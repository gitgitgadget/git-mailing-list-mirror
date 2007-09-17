From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 16:05:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709171603090.28586@racer.site>
References: <11900314321506-git-send-email-hjemli@gmail.com>  <46EE7584.8010202@op5.se>
  <8c5c35580709170616i49a8836hb60423c5eebf601d@mail.gmail.com> 
 <Pine.LNX.4.64.0709171422340.28586@racer.site> 
 <8c5c35580709170638mc0c8279pa86d71bd79fd3084@mail.gmail.com> 
 <Pine.LNX.4.64.0709171454031.28586@racer.site>
 <8c5c35580709170712v2f5df7b1w8fa0377b69f24988@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 17:06:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXIBM-0005U8-Ie
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 17:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbXIQPGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 11:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbXIQPGc
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 11:06:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:34040 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753460AbXIQPGb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 11:06:31 -0400
Received: (qmail invoked by alias); 17 Sep 2007 15:06:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 17 Sep 2007 17:06:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19sOHNCzUBsONxALIBa5gaKzjxizvsQn4SqR7MP2P
	4tVPsEZn6i5fyT
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580709170712v2f5df7b1w8fa0377b69f24988@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58450>

Hi,

On Mon, 17 Sep 2007, Lars Hjemli wrote:

> On 9/17/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > But then, I do not use svn branches here, and that might be the problem?
> 
> Probably. The case I'm trying to solve is:
>   -git-svn branch A is merged into git-svn branch B
>   -A is a fast-forward of B
> 
> This might look unrealistic, but it happened to me today when I wanted
> to merge a feature-branch into a relase-branch. The release-branch had
> previously been merged into the feature-branch (to get a few
> bugfixes), but the release-branch had not changed since this merge. So
> when merging the feature-branch into the release-branch it just
> fast-forwarded, leaving me with an 'un-dcomittable' release-branch. I
> obviously could have done the merge in subversion (haha!), but doing
> it in git preserves the correct history.
> 
> Btw: I have redone the merge with --no-ff, and dcommit then worked
> like a charm ;-)

Yep, I can see that now.

But maybe there is a better method to detect the latest svn id, by not 
only looking up the svn ids, but making sure that they come from the 
current branch?

(I'm happily unaware of git-svn's internals, so that might not be 
feasible... But I think that it might be worth fixing that for the git-svn 
idiot like me, since I would never guess that I have to specify --no-ff 
when working on branches that come from git-svn...)

Ciao,
Dscho
