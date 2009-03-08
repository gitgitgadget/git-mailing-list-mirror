From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when cherry-picking
 an empty commit
Date: Sun, 8 Mar 2009 02:19:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903080218070.10279@pacific.mpi-cbg.de>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com> <alpine.DEB.1.00.0903071212350.10279@pacific.mpi-cbg.de> <EEE56CB5-BBC7-45F4-801B-062349E07730@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 02:24:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg7l6-0001mL-4f
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 02:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbZCHBR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 20:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbZCHBR6
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 20:17:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:49370 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752875AbZCHBR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 20:17:58 -0500
Received: (qmail invoked by alias); 08 Mar 2009 01:17:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 08 Mar 2009 02:17:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/jiFBCfV/VtOjFoX4calpnHx+bKJfxKZBTbmDCc
	rQot9Yxy1Co62N
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <EEE56CB5-BBC7-45F4-801B-062349E07730@pobox.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112604>

Hi,

On Sat, 7 Mar 2009, Chris Johnsen wrote:

> On 2009 Mar 7, Johannes Schindelin wrote:
> >I wonder, though, if the real root of the problem is that there is
> >copied code.
> 
> Agreed.
> 
> >IOW I think it would be better to introduce a global
> >function that writes the index to a tree.
> 
> I am not quite sure I follow your meaning here.

Well, my thinking was that instead of imitating what merge-recursive does, 
you could refactor that very code into a function that gets called from 
both merge-recursive and revert.

Ciao,
Dscho
