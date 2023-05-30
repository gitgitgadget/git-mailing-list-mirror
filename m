Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9810C77B7A
	for <git@archiver.kernel.org>; Tue, 30 May 2023 18:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjE3SaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 14:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjE3SaG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 14:30:06 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2340E5
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:30:03 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1q446b-0006x0-M9
        for git@vger.kernel.org; Tue, 30 May 2023 20:30:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Carlos <kaploceh@gmail.com>
Subject: not robust inconsistent git 2.40.1 with HEAD -> master, origin/main,
 origin/HEAD, origin/master, main
Date:   Tue, 30 May 2023 14:14:44 -0400
Message-ID: <lxh4jpacuv5ivqp35w5vpbcjlw67r7ix3yog6cc3cu5ij7yqho@mrtr24xxdstx>
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
This login session: $13.99

