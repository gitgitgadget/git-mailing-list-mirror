From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] checkout: implement "-" shortcut name for last
 branch
Date: Thu, 15 Jan 2009 14:15:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <1231978322-21228-1-git-send-email-trast@student.ethz.ch> <496EE559.3060901@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 14:15:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNS4e-0002WC-G9
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842AbZAONO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754099AbZAONO2
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:14:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:54569 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754064AbZAONO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:14:27 -0500
Received: (qmail invoked by alias); 15 Jan 2009 13:14:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 15 Jan 2009 14:14:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188h61OBM88c2L7+MLX4cF72/Snwko/gU4ryQe7Or
	o64JVqwlMP2knI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <496EE559.3060901@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105794>

Hi,

On Thu, 15 Jan 2009, Johannes Sixt wrote:

> Thomas Rast schrieb:
> > Let git-checkout save the old branch as a symref in LAST_HEAD, and
> > make 'git checkout -' switch back to LAST_HEAD, like 'cd -' does in
> > the shell.
> 
> /me likes this feature.
> 
> git rebase (-i or not) calls checkout behind the scenes if the
> two-argument form is used:
> 
>    git rebase [-i] master topic
> 
> and 'topic' is not the current branch. You may want to add a test that
> ensures that rebase sets LAST_HEAD in this case.
> 
> You must make sure that commits referenced by LAST_HEAD are not
> garbage-collected. (I don't know if this happens anyway for symrefs in .git.)

Note: if you used reflogs for that feature, the garbage collection could 
not have killed the commit.  However, it is quite possible that the 
branch was deleted.

Ciao,
Dscho
