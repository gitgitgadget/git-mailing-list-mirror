X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 22:12:35 +0100
Message-ID: <200611152212.35978.Josef.Weidendorfer@gmx.de>
References: <87k61yt1x2.wl%cworth@cworth.org> <200611152131.14883.Josef.Weidendorfer@gmx.de> <20061115203517.GN7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 21:12:54 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>,
	Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <20061115203517.GN7201@pasky.or.cz>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31498>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkS3n-000121-RP for gcvg-git@gmane.org; Wed, 15 Nov
 2006 22:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161689AbWKOVMk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 16:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161690AbWKOVMk
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 16:12:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:32986 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1161689AbWKOVMj (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 16:12:39 -0500
Received: (qmail invoked by alias); 15 Nov 2006 21:12:37 -0000
Received: from p5496A980.dip0.t-ipconnect.de (EHLO noname) [84.150.169.128]
 by mail.gmx.net (mp010) with SMTP; 15 Nov 2006 22:12:37 +0100
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On Wednesday 15 November 2006 21:35, Petr Baudis wrote:
> On Wed, Nov 15, 2006 at 09:31:13PM CET, Josef Weidendorfer wrote:
> > Often, I find myself doing "git branch" just to make sure that I am on
> > "master", so that a following pull does not do a bogus merge.
> > 
> > Can we please disable this behavior, e.g. by allowing a fake first
> > Pull line like "Pull: (not-for-merge)" to prohibit any merge?
> 
> Wait, if you don't want pull to merge, why do you pull and not fetch?

I am not really opposed to pull doing a merge. It only should work in
a useful way: ie. only do the merge of updated origin branch when
current branch is master (given "Pull: master:origin").

I want "git pull" being harmless if I find myself accidently on a
branch != master. I always can do "git checkout master; git pull . origin"
afterwards.

For this to work, I currently need to specify a "branch.<name>.merge"
config for _every_ branch I have, as otherwise I get this bogus pull
merge behavior. This is not needed if there was a way to configure no
merge at all as default pull behavior.

I just noted that allowing such a config option would be kind of a
working compromise for all the people which want
pull to be the opposite of push.

