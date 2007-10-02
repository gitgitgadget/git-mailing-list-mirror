From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problems setting up bare repository (git 1.5.3.3)
Date: Tue, 2 Oct 2007 18:45:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710021841300.28395@racer.site>
References: <m3fy0u7bk3.fsf@barry_fishman.acm.org> <7vejgeqxd1.fsf@gitster.siamese.dyndns.org>
 <87bqbisae6.wl%cworth@cworth.org> <Pine.LNX.4.64.0710021045430.28395@racer.site>
 <87641psey8.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Barry Fishman <barry_fishman@acm.org>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 19:47:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iclq3-0000Hy-Dr
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 19:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbXJBRq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 13:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753737AbXJBRq5
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 13:46:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:46264 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753655AbXJBRq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 13:46:56 -0400
Received: (qmail invoked by alias); 02 Oct 2007 17:46:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 02 Oct 2007 19:46:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZTIsueooZsP8It2DNosa/M2SdsKyOyWrhRfReSX
	e6AlfUcDvrGTxq
X-X-Sender: gene099@racer.site
In-Reply-To: <87641psey8.wl%cworth@cworth.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59703>

Hi,

On Tue, 2 Oct 2007, Carl Worth wrote:

> On Tue, 2 Oct 2007 10:46:56 +0100 (BST), Johannes Schindelin wrote:
> > On Mon, 1 Oct 2007, Carl Worth wrote:
> > > And why is that?
> >
> > Well, if the OP had used "git push <bla> master" instead of "... 
> > master:master", it would have worked.  I am unaware of any tutorial 
> > that suggests the latter, only of tutorials that suggest the former.
> 
> OK. I was wrong. Somehow I got stuck thinking that "git push <bla> 
> master" wouldn't create a new remote master branch if it didn't 
> previously exist. (It's bizarre that I forgot since I've used that for a 
> long time).
> 
> Sorry about the noise.

Nothing to be sorry about.  It got me thinking.  People propose that "git 
push <nick> master:blub" should create the branch "refs/heads/blub" on the 
remote side.

My initial reaction was "then you have to be precise, because we do not 
know if you want to push it as a branch, or as a lightweight tag".

But then I stepped back a little: What is most likely meant when you say 
"master:blub" and there is no tag/branch of name "blub" on the remote 
side?  Exactly, you want a branch to be created.

_Except_ if you had a typo, such as "git push ko master:po" where you want 
to be warned that that ref is not present on the remote side.

So I am less opposed to making "master:blub" automatically create a branch 
"blub" if it does not exist yet.  But opposed nevertheless.

Ciao,
Dscho
