X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 23:26:22 +0100
Message-ID: <200612012326.22779.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <200612012306.41410.Josef.Weidendorfer@gmx.de> <20061201221230.GM18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 22:26:50 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, sf <sf@b-i-t.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <20061201221230.GM18810@admingilde.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32974>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqGpw-0003QG-J3 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 23:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162114AbWLAW00 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 17:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162119AbWLAW0Z
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 17:26:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:36282 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1162114AbWLAW0Z (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 17:26:25 -0500
Received: (qmail invoked by alias); 01 Dec 2006 22:26:23 -0000
Received: from p5496B457.dip0.t-ipconnect.de (EHLO noname) [84.150.180.87] by
 mail.gmx.net (mp023) with SMTP; 01 Dec 2006 23:26:23 +0100
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

On Friday 01 December 2006 23:12, Martin Waitz wrote:
> hoi :)
> 
> On Fri, Dec 01, 2006 at 11:06:40PM +0100, Josef Weidendorfer wrote:
> > > Well, I would actually argue that you may often want to have a
> > > supermodule and then at least have the _option_ to decide to not
> > > fetch all the submodules.
> > 
> > If you want to allow this, you have to be able to cut off fetching the
> > objects of the supermodule at borders to given submodules, the ones you
> > do not want to track. With "border" I mean the submodule commit in some
> > tree of the supermodule.
> 
> I don't think this is something special to submodules.  There has been
> interest in checking out only a part of the tree even before talking
> about submodules and I really think this feature should be independent
> to submodules.

It's not about checking out part of the tree, it's about fetching only
part of the objects: If you have a slow modem and want to clone a
supermodule, you are not interested in fetching all the objects from
some submodules.

So it is more like a shallow clone. But even here, submodules are special
as you have defined borders between supermodule and submodules. This gives
you the freedom the introduce a submodule namespace, and allows you to
point to a submodule: "I do not want you!".

With shallow clone, there you do not have this option, so there, you need
to use something like grafting.

BTW: In your submodule implementation, is the user allowed to change the
relative path of the root of some submodule, e.g. with "git-mv" ?

Josef
