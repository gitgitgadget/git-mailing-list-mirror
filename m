X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: selective git-update-index per diff(1) chunks
Date: Fri, 1 Dec 2006 20:42:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612012039530.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <b6fcc0a0612010323x7554e47m5e6bdafe85fc8224@mail.gmail.com>
 <slrnen04os.a5.Peter.B.Baumann@xp.machine.xx> <7v3b7zalsq.fsf@assigned-by-dhcp.cox.net>
 <ekpm6i$s35$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 19:43:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <ekpm6i$s35$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32960>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqEHf-0006IQ-UF for gcvg-git@gmane.org; Fri, 01 Dec
 2006 20:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031763AbWLATmx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 14:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031756AbWLATmx
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 14:42:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:7899 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1031763AbWLATmw (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 14:42:52 -0500
Received: (qmail invoked by alias); 01 Dec 2006 19:42:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp034) with SMTP; 01 Dec 2006 20:42:51 +0100
To: Anand Kumria <wildfire@progsoc.org>
Sender: git-owner@vger.kernel.org

Hi,

On Fri, 1 Dec 2006, Anand Kumria wrote:

> On Fri, 01 Dec 2006 03:38:13 -0800, Junio C Hamano wrote:
> 
> > Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
> > writes:
> > 
> >> I don't think it belongs in the plumbing, the git-update-index but I
> >> think something like this would be very usefull.
> >>
> >> AFAIR darcs has this functionality. It selectively ask for each hunk if
> >> it should be commited. This would be awfull to have in git.
> > 
> > I concur, on both counts.  My own now-defunct Porcelain had the
> > darcs style interactive hunk selection because it felt so
> > useful (and sometimes it was).
> 
> Is there a good receipe on how to do this? Everytime I do it, I try a
> different method; since I'm testing out my understanding of things.
> 
> It'd nice to have some of these "advanced receipes" that people often do
> noted down somewhere.

Can't say anything about advanced recipes, but I use a poor-man's 
workflow:

$ git diff > a1.patch
$ vi a1.patch
  <edit out what I want to _keep_>
$ git apply -R < a1.patch
  <test & commit>
$ git apply < a1.patch

Of course, you could write a little wrapper around it, even one which asks 
you which hunks you want to edit out. Should not be that hard...

Note that this is independent of the SCM you are using.

Ciao,
Dscho
