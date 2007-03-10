From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in
 bundle
Date: Sat, 10 Mar 2007 16:39:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703101637300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net>
 <45F17EF0.5060008@gmail.com> <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 16:39:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ3fJ-0000Yw-HE
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 16:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767844AbXCJPjT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 10:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767847AbXCJPjT
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 10:39:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:40345 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1767844AbXCJPjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 10:39:18 -0500
Received: (qmail invoked by alias); 10 Mar 2007 15:39:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 10 Mar 2007 16:39:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cL0wfU3bci9aM3EjIaEkWnksNupjqLHieTaDDXy
	X5dwfpzWqZWU9w
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41866>

Hi,

On Fri, 9 Mar 2007, Junio C Hamano wrote:

> Mark Levedahl <mlevedahl@gmail.com> writes:
> 
> > git>git bundle create t.bdl master --not master
> > Generating pack...
> > Done counting 0 objects.
> > Writing 0 objects.
> > Total 0 (delta 0), reused 0 (delta 0)
> > git>git ls-remote t.bdl
> > git>
> >
> > e.g, an empty bundle is created without any error or warning. This is
> > the one case I believe an error should result: there is no use to
> > sending (or even creating) an empty bundle.
> 
> I agree that erroring on an empty output is a sensible _option_
> just like pack-objects has --no-empty option.
> 
> The above is actually an interesting example in a different
> sense.  When somebody did the following, what should be output?
> 
> 	$ edit; git commit -a ;# on master
>         $ git checkout -b side
>         $ edit; git commit -a ;# on side
>         $ git bundle create foo.bdl master side ^master

IMHO saying "master ^master" should blow into the user's face. If she says 
"I want it" _and_ "I don't want it", she should sorta expect it not to 
work.

Ciao,
Dscho
