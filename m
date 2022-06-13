Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA93CCCA47B
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 17:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbiFMRTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 13:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241747AbiFMRSg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 13:18:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7F610ED
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 05:29:49 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x17so6937734wrg.6
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 05:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IiRZec0PjHc39lMAlne3dFiB2/W53beW8du8uoopyiE=;
        b=jOOFl3BPSCFusp7DfBfHAioGy+a7EQD5/VkUzOn1mEK5642d91kRoeWv82b5gbiqUd
         /j/DybTY20tew9MwYUPNrj6MmFsYJJ7Gsc5AdMXqk8ExNge0dLjBs0Qax5I1B3IwZeyh
         M55nazlHBAq44t/FnRQtNkpPBZe5TkM1FWyc56B2g5qGcv1myDVukqeXxq50jetLRjf0
         2bVvOsP1yQRyywX+0+OrzGGtGHArU3rikmKFWPocEjG/H+ru5GqsAPb+g0t01fjVkEui
         BDtMQNTAYKPr1z/KFVewB6XidBp9C98a3tetOks6Qsj7xSX3N4PX2C5IZEw+2f4mZjEd
         MMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IiRZec0PjHc39lMAlne3dFiB2/W53beW8du8uoopyiE=;
        b=NZkbME9xmHi+4iaJZLZGGVSc4z5gfZu7y2Pmdykc8emoWqmcYy3kORqdUy2aM9VSPv
         fTax1WNnFw5rO4+ZYtWh9oG4VmK5mLjhSUJ1HkER+ymV5R6Qe6c5J/WvM0+kNPg1iGNF
         BIVxCW+JnkecK4G2tSnrPJdqf2jfphujCk451kr6qL+1Zg6tWjKDGwnqHc7fae18urds
         XRhnmbcnc3fLGmSfdqRNq5ZTfY3Sv1/WDv7+lfAt7Yzp6VH3E+wkfkbR1Nfiw+OwCoSF
         J1rXcCIIuvlOTTbbFLa5F4nMvGpxMCnUgME0+teg6jviH18bh3ibhGamksmRZX95vMXO
         kLqg==
X-Gm-Message-State: AOAM532F1Rokzz3JgwxecpW+KQc+41JgH4RItYAGXVAxEd7gLwe6/7vQ
        fa3IuhAZFKlt7OcCIgBz7M25jcUopUu3EQ==
X-Google-Smtp-Source: ABdhPJyYKsz4t9YtuXCwMkgYxXPGSoWUUIYHssLvMMkhfZIpv8DgQzR2ENYomgoKVfsz+/J40O2bog==
X-Received: by 2002:a05:6000:18a8:b0:212:ae71:a3f6 with SMTP id b8-20020a05600018a800b00212ae71a3f6mr55431715wri.635.1655123388022;
        Mon, 13 Jun 2022 05:29:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c4e0e00b0039747cf8354sm9239432wmq.39.2022.06.13.05.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 05:29:47 -0700 (PDT)
Message-Id: <af67c33916f5ff29f158f400d6365e6c09e80eea.1655123383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1259.git.1655123383.gitgitgadget@gmail.com>
References: <pull.1259.git.1655123383.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Jun 2022 12:29:43 +0000
Subject: [PATCH 3/3] diff-index.txt: update raw output format in examples
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The two examples in the doc for 'git diff-index' were not updated when
the raw output format was changed in 81e50eabf0 ([PATCH] The diff-raw
format updates., 2005-05-21) (first example) and in b6d8f309d9 ([PATCH]
diff-raw format update take #2., 2005-05-23) and 7cb6ac1e4b (diff:
diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value,
2017-12-03) (second example).

Update the output, inventing some characters to complete the source
hash in the second example. Also correct the destination mode in the
second example, which was wrongly '100664' since the addition of the
example in c64b9b8860 (Reference documentation for the core git
commands., 2005-05-05).

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-diff-index.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 679cae27d9b..c30d8f0da8a 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -69,8 +69,8 @@ done an `update-index` to make that effective in the index file.
 matches my working directory. But doing a 'git diff-index' does:
 
   torvalds@ppc970:~/git> git diff-index --cached HEAD
-  -100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        commit.c
-  +100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        git-commit.c
+  :100644 000000 4161aecc6700a2eb579e842af0b7f22b98443f74 0000000000000000000000000000000000000000 D	commit.c
+  :000000 100644 0000000000000000000000000000000000000000 4161aecc6700a2eb579e842af0b7f22b98443f74 A	git-commit.c
 
 You can see easily that the above is a rename.
 
@@ -103,7 +103,7 @@ have not actually done a 'git update-index' on it yet - there is no
 "object" associated with the new state, and you get:
 
   torvalds@ppc970:~/v2.6/linux> git diff-index --abbrev HEAD
-  :100644 100664 7476bb... 000000...      kernel/sched.c
+  :100644 100644 7476bb5ba 000000000 M	kernel/sched.c
 
 i.e., it shows that the tree has changed, and that `kernel/sched.c` is
 not up to date and may contain new stuff. The all-zero sha1 means that to
-- 
gitgitgadget
