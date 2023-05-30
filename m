Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337D6C7EE31
	for <git@archiver.kernel.org>; Tue, 30 May 2023 18:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjE3SZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 14:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjE3SZe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 14:25:34 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C107A1BC
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:25:06 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1q441m-000AGO-4d
        for git@vger.kernel.org; Tue, 30 May 2023 20:25:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Carlos <kaploceh@gmail.com>
Subject: not robust inconsistent git 2.40.1 with HEAD -> master, origin/main,
 origin/HEAD, origin/master, main
Date:   Tue, 30 May 2023 13:58:21 -0400
Message-ID: <7o2ggnyobdgjpki2ooljbmd5gqjxsbg56wuhkzyl3qfqvimrds@tnrmri2cxc5n>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running git 2.40.1 with HEAD -> master, origin/main, origin/HEAD, origin/master, main with initial commit on main does not show all the objects from master


! [main] Initial commit
 * [master] Initial commit
  ! [origin/master] Initial commit
---
+*+ [main] Initial commit

the chunk of objects are on master and not main, and yet it shows
nothing once checking out to master. 

the git-clone operation is not consistent either. It's a disaster.

One would think that by now with the more developed work put on to git, it'd
be safe to assume the more sense there's on newer versions. But no. This
 is the opposite actually. 

Now. If by any chance the git-branch operation were to return:

  main
* master

after git-clone, then objects are indeed in place. That is. On master

but not if git-branch returns 

  main
* master
  origin/master




-- 
Our documentation manager was showing her 2 year old son around the office.
He was introduced to me, at which time he pointed out that we were both
holding bags of popcorn.  We were both holding bottles of juice.  But only
*he* had a lollipop.
	He asked his mother, "Why doesn't HE have a lollipop?"
	Her reply: "He can have a lollipop any time he wants to.  That's
what it means to be a programmer."

