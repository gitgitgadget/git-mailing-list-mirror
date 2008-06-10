From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Respecting core.autocrlf when showing objects
Date: Tue, 10 Jun 2008 16:34:15 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806101632570.1783@racer>
References: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org> <cover.1213084587.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 17:36:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K65th-0005kw-B9
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 17:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYFJPfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 11:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbYFJPfe
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 11:35:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:55413 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752251AbYFJPfd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 11:35:33 -0400
Received: (qmail invoked by alias); 10 Jun 2008 15:35:31 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 10 Jun 2008 17:35:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GPyltPvZGx3pY1R7owiYdMw6D+1WeAeyAyn7h30
	CfyGgRJ2MVrn6n
X-X-Sender: gene099@racer
In-Reply-To: <cover.1213084587.git.marius@trolltech.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84520>

Hi,

On Tue, 10 Jun 2008, Marius Storm-Olsen wrote:

> When you use 'git show <rev>:<file>' or 'git show :<stage>:<file>', the 
> objects are shows as they are in the object store, ignoring the 
> core.autocrlf configuration.

I think this is the correct behaviour: inside the object repository, the 
files are supposed to be LF clean.

Likewise, things in the unmerged stages are in the index, which again is 
not the working directory, so they should be LF clean.

_Only_ when writing a file to the working directory, it should get 
clobbered.

Ciao,
Dscho
