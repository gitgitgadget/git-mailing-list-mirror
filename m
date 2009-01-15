From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] checkout: implement "-" shortcut name for last branch
Date: Thu, 15 Jan 2009 01:45:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901150141570.3586@pacific.mpi-cbg.de>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 15 01:46:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNGMt-00085b-FC
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758961AbZAOAoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 19:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758889AbZAOAoc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:44:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:40162 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756687AbZAOAob (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 19:44:31 -0500
Received: (qmail invoked by alias); 15 Jan 2009 00:44:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 15 Jan 2009 01:44:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4Vp0XcJn4HhdqZBUGpDTeX1u949vpfv+nfVd3PT
	+Lmk8iXt16rMvH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1231977976-8739-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105745>

Hi,

On Thu, 15 Jan 2009, Thomas Rast wrote:

> Let git-checkout save the old branch as a symref in LAST_HEAD, and
> make 'git checkout -' switch back to LAST_HEAD, like 'cd -' does in
> the shell.

Actually, what you want is in the reflog, no?  So... parsing 
.git/logs/HEAD for the latest occurrence of "checkout: moving from " and 
then using everything up until the next space should give you the branch 
name, right?

It could be a SHA-1, though, if the last branch switch was from a detached 
HEAD, though.

Ciao,
Dscho
