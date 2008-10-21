From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-remote: list branches in vertical lists
Date: Tue, 21 Oct 2008 18:49:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810211847410.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <48FDEA82.5050903@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 18:44:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsKLR-0006hE-AA
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 18:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbYJUQmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 12:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbYJUQmw
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 12:42:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:41794 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752149AbYJUQmw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 12:42:52 -0400
Received: (qmail invoked by alias); 21 Oct 2008 16:42:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 21 Oct 2008 18:42:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QtMIRvGJQgM0WtAc9M8p1A5aXRN3K4qKs/BlQDD
	n6AJ7dMzabWiDD
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <48FDEA82.5050903@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98794>

Hi,

On Tue, 21 Oct 2008, Johannes Sixt wrote:

> Previously, branches were listed on a single line in each section. But 
> if there are many branches, then horizontal, line-wrapped lists are very 
> inconvenient to scan for a human. This makes the lists vertical, i.e one 
> branch per line is printed.
> 
> This does mean that users' scripts must be updated because the output 
> format changed, but the result is friendlier to the eye *and* easier to 
> parse.

My initial reaction to that was: add an option, and keep the old behavior 
then.

But on second thought: No script has any business scanning the output of 
git-remote.  That command is a pure convenience wrapper, and scripts 
trying to list remote branches should use git show-ref instead.

So I'd say: replace the last comment with

	Since "git remote" is porcelain, we can easily make this 
	backwards-incompatible change.

Ciao,
Dscho
