From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when cherry-picking
 an empty commit
Date: Sat, 7 Mar 2009 12:15:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903071212350.10279@pacific.mpi-cbg.de>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 12:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfuVh-0004Pg-Ei
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 12:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859AbZCGLO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 06:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753561AbZCGLO3
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 06:14:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:47056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753220AbZCGLO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 06:14:28 -0500
Received: (qmail invoked by alias); 07 Mar 2009 11:14:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 07 Mar 2009 12:14:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZkcR55DJZvTnaaxswVYDOwrIdmolXWCo3B5puyi
	O5dpdNuimNNjOa
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112525>

Hi,

On Sat, 7 Mar 2009, Chris Johnsen wrote:

> When a cherry-pick of an empty commit is done, release the lock
> held on the index.
> 
> The fix is the same as was applied to similar code in 4271666046.
> 
> Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>
> ---
> [...]

Thanks for the detailed explanation, and the patch!

I wonder, though, if the real root of the problem is that there is 
copied code.  IOW I think it would be better to introduce a global 
function that writes the index to a tree.  A quick "git grep 
commit_locked_index" reveals quite a few code sites...

Thanks,
Dscho
