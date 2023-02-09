Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44634C05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 09:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjBIJL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 04:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBIJL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 04:11:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D36901F
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 01:11:49 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso3363291wmp.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 01:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMyOflcTy8Au55J81iHSedrF5MKB4fkfHAUW0A7V1Sk=;
        b=kCZ+8RvnGH0hUcrpc7glXtND17qzcJccdzvSTadJa6Y5/brvDGd0G6CmNNY/PtZTyj
         l0tpR1lSwgJrun35iWr00yPGfQNfAQBrloxeTJFzTp1P/evqSpMs3NwUSAMjqsiymS1S
         1LTUY4kd2wu5CN8cTFF4qneOnkIvStUll86OCOXg9w+sbgWkH8n1ohM1zFtRww95JUxg
         RvAce/ZlLTJ68wLkNUrz9iK4ZFO5Cnmk1sBlyxDSu7P9DYUj5sVBK2ICbgCj39cVE7f7
         mSfPXoWs2GI16muBZWTQRKFi7T1NEvyjL/ni6vKEx+ZS2tGKBzB0G+GOzgiWAmSsLPfW
         +kBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMyOflcTy8Au55J81iHSedrF5MKB4fkfHAUW0A7V1Sk=;
        b=WtFJ1Md+DEAy7NXzzEOdBoFe5vD7W0g2w14/YD04JiodJy6Wjn0sU0EFoMi2kk0DME
         6k8UOmIpDPrh0Tb+1TSTHe912Gt62Fc1bijsZsBSNAY8xh6BIKOZZrOcT2Q2t0FzGH6z
         52zpfE+GIfKAmTNLyYGQoSsKlP3tGBM6RD2Kle1Btdd/OTaa+otRtx4qQvandO8HacDS
         o+FButUjZ2RHxi2Y24FKIfnHdCGPXBBd2g9qpTtQdYFYwERovLvXbqsCuvR7bsf1Ql2n
         yXRrlJjJ8aoF6ccusK885fdKLFI1mABRMk2hSGnWXeLTMu9NTGLhq0IkhlDIZOC18oL/
         2pWg==
X-Gm-Message-State: AO0yUKW1R9QZrhO0AQDLfmncSsRRU3uRlLqjyeKCZ8AY3FtF0CknTKpt
        kGLPVyBeHJQ2ESy521J0e6j8/oQmDcs=
X-Google-Smtp-Source: AK7set8aIs1ie4+B4UIIHZo5a+Os5d78ZrXl8yWZOKzr6aH2wFqYr0OfSWBWZgMEC8E870PqYh5SWw==
X-Received: by 2002:a05:600c:4da2:b0:3df:e1d1:e14c with SMTP id v34-20020a05600c4da200b003dfe1d1e14cmr12611926wmp.20.1675933907902;
        Thu, 09 Feb 2023 01:11:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv12-20020a05600c548c00b003dc521f336esm1354024wmb.14.2023.02.09.01.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 01:11:47 -0800 (PST)
Message-Id: <pull.1468.v3.git.1675933906906.gitgitgadget@gmail.com>
In-Reply-To: <pull.1468.v2.git.1675751527365.gitgitgadget@gmail.com>
References: <pull.1468.v2.git.1675751527365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Feb 2023 09:11:46 +0000
Subject: [PATCH v3] name-rev: fix names by dropping taggerdate workaround
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 7550424804 ("name-rev: include taggerdate in considering the best
name", 2016-04-22) introduced the idea of using taggerdate in the
criteria for selecting the best name.  At the time, a certain commit in
linux.git -- namely, aed06b9cfcab -- was being named by name-rev as
    v4.6-rc1~9^2~792
which, while correct, was very suboptimal.  Some investigation found
that tweaking the MERGE_TRAVERSAL_WEIGHT to lower it could give
alternate answers such as
    v3.13-rc7~9^2~14^2~42
or
    v3.13~5^2~4^2~2^2~1^2~42
A manual solution involving looking at tagger dates came up with
    v3.13-rc1~65^2^2~42
which is much nicer.  That workaround was then implemented in name-rev.

Unfortunately, the taggerdate heuristic is causing bugs.  I was pointed
to a case in a private repository where name-rev reports a name of the
form
    v2022.10.02~86
when users expected to see one of the form
    v2022.10.01~2
(I've modified the names and numbers a bit from the real testcase.)  As
you can probably guess, v2022.10.01 was created after v2022.10.02 (by a
few hours), even though it pointed to an older commit.  While the
condition is unusual even in the repository in question, it is not the
only problematic set of tags in that repository.  The taggerdate logic
is causing problems.

Further, it turns out that this taggerdate heuristic isn't even helping
anymore.  Due to the fix to naming logic in 3656f84278 ("name-rev:
prefer shorter names over following merges", 2021-12-04), we get
improved names without the taggerdate heuristic.  For the original
commit of interest in linux.git, a modern git without the taggerdate
heuristic still provides the same optimal answer of interest, namely:
    v3.13-rc1~65^2^2~42

So, the taggerdate is no longer providing benefit, and it is causing
problems.  Simply get rid of it.

However, note that "taggerdate" as a variable is used to store things
besides a taggerdate these days.  Ever since commit ef1e74065c
("name-rev: favor describing with tags and use committer date to
tiebreak", 2017-03-29), this has been used to store committer dates and
there it is used as a fallback tiebreaker (as opposed to a primary
criteria overriding effective distance calculations).  We do not want to
remove that fallback tiebreaker, so not all instances of "taggerdate"
are removed in this change.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    name-rev: fix names by dropping taggerdate workaround
    
    Changes since v2: Fixed nearby comments based on code changes
    
    Changes since v1: Slight tweaks to the commit message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1468%2Fnewren%2Ffix-name-rev-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1468/newren/fix-name-rev-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1468

Range-diff vs v2:

 1:  206726fc954 ! 1:  ff57b1583b1 name-rev: fix names by dropping taggerdate workaround
     @@ Commit message
      
       ## builtin/name-rev.c ##
      @@ builtin/name-rev.c: static int is_better_name(struct rev_name *name,
     - 	 * based on the older tag, even if it is farther away.
     - 	 */
     + 	int name_distance = effective_distance(name->distance, name->generation);
     + 	int new_distance = effective_distance(distance, generation);
     + 
     +-	/*
     +-	 * When comparing names based on tags, prefer names
     +-	 * based on the older tag, even if it is farther away.
     +-	 */
     ++	/* If both are tags, we prefer the nearer one. */
       	if (from_tag && name->from_tag)
      -		return (name->taggerdate > taggerdate ||
      -			(name->taggerdate == taggerdate &&
      -			 name_distance > new_distance));
      +		return name_distance > new_distance;
       
     - 	/*
     - 	 * We know that at least one of them is a non-tag at this point.
     +-	/*
     +-	 * We know that at least one of them is a non-tag at this point.
     +-	 * favor a tag over a non-tag.
     +-	 */
     ++	/* Favor a tag over a non-tag. */
     + 	if (name->from_tag != from_tag)
     + 		return from_tag;
     + 
      
       ## t/t6120-describe.sh ##
      @@ t/t6120-describe.sh: test_expect_success 'setup: describe commits with disjoint bases 2' '


 builtin/name-rev.c  | 14 +++-----------
 t/t6120-describe.sh |  6 ++++++
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 15535e914a6..0ebf06fad5a 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -108,19 +108,11 @@ static int is_better_name(struct rev_name *name,
 	int name_distance = effective_distance(name->distance, name->generation);
 	int new_distance = effective_distance(distance, generation);
 
-	/*
-	 * When comparing names based on tags, prefer names
-	 * based on the older tag, even if it is farther away.
-	 */
+	/* If both are tags, we prefer the nearer one. */
 	if (from_tag && name->from_tag)
-		return (name->taggerdate > taggerdate ||
-			(name->taggerdate == taggerdate &&
-			 name_distance > new_distance));
+		return name_distance > new_distance;
 
-	/*
-	 * We know that at least one of them is a non-tag at this point.
-	 * favor a tag over a non-tag.
-	 */
+	/* Favor a tag over a non-tag. */
 	if (name->from_tag != from_tag)
 		return from_tag;
 
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 9a35e783a75..c9afcef2018 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -657,4 +657,10 @@ test_expect_success 'setup: describe commits with disjoint bases 2' '
 
 check_describe -C disjoint2 "B-3-gHASH" HEAD
 
+test_expect_success 'setup misleading taggerdates' '
+	GIT_COMMITTER_DATE="2006-12-12 12:31" git tag -a -m "another tag" newer-tag-older-commit unique-file~1
+'
+
+check_describe newer-tag-older-commit~1 --contains unique-file~2
+
 test_done

base-commit: 221222b278e713054e65cbbbcb2b1ac85483ea89
-- 
gitgitgadget
