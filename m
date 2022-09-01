Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8CEECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 07:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiIAHJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 03:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiIAHIt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 03:08:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B143123C17
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 00:08:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e20so21021541wri.13
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 00:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=zi4P1PtPHj1SN0ELcuWHF7H8SYIYKfxJYsQpBf6l3SM=;
        b=X5u2ncJsU3l6EbXPPeWIWShWndECA86DVgnQSCtxKhtkr4UZHKOd0jp9OrLTcAXa29
         NIZHNIaA2TSEmgDX6ER2473QPJd+cjv649GoUgLP2GR3tz3VCJ3EZoOc7JmzccAHH/JT
         U/VxUHcnpk0CZwvEcnEadLEqbJIYC9khXGCHeOw+oQJTcW3OV4Zy2u0ozxov1dpI3NMw
         iD03WPlrUQb9e2LAAVVq43D9d7FAC0fThSiFB/thIL3y2FlvhOes13zSayy3Mma3CZR2
         etzVDv1L6gH1hvFscNvSKcxBaItdfLRL2gnhHFY7d9XJa9lPfyBIQGgK4VLf4s7jGcov
         cxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=zi4P1PtPHj1SN0ELcuWHF7H8SYIYKfxJYsQpBf6l3SM=;
        b=Yi3ug+15f3t6fMHK3qJXcnXhog7AaEERxZKbjrgMSIuBF2cRZG2+WSFr5/TkXWNkjz
         x1Eqr+EZHpAoiVeYHHOB14oWGkTDxem7d8EHBkeZYNdH4pHTkTAgq9fDg2tJS+WEz5fG
         0pW+VO1zX+zg2sxQCkl5QuJ2ODz04cRVriCGW+rgp8ZcqQ3M/UbRXhXBjgB4S0iUfvI2
         p+V61KSvYvsBpPcKKjxRzFk8G1OgNyJbn7r3UokrTCb+ejhY+3nIonsuk1ZC8ZzNN640
         i9W2a7xnzKIq5ybcfnLXJLSkRfeBsLbjOrybShw2AsgZfbuRpTt3/IKIQb3B1OJLmHOc
         cuwg==
X-Gm-Message-State: ACgBeo232PG22YbCsFtjtHuS8OTgYdCtzUm0ieyYxj+J8X7z8yWKS6Wk
        6iJYTHATP0xuZ9aJxm5d4K2wclHj7+E=
X-Google-Smtp-Source: AA6agR4HRr+VofCeJVCYgbbkQfKKjIFF1FZmZjLFeCF4euDZmhaKxbEEuGKha3+Qf97nTQTCC58JYg==
X-Received: by 2002:a05:6000:2a1:b0:226:d5b1:b001 with SMTP id l1-20020a05600002a100b00226d5b1b001mr11622176wry.29.1662016090274;
        Thu, 01 Sep 2022 00:08:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l23-20020adfa397000000b002254b912727sm13837012wrb.26.2022.09.01.00.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 00:08:09 -0700 (PDT)
Message-Id: <pull.1342.v2.git.1662016087.gitgitgadget@gmail.com>
In-Reply-To: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 07:08:04 +0000
Subject: [PATCH v2 0/3] Output fixes for --remerge-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain found and reported a couple issues with the output of
--remerge-diff[1]. After digging in, I think one of them actually counts as
two separate issues, so here's a series with three patches to fix these
issues. Each includes testcases to keep us from regressing.

Changes since v1:

 * Added a new diff_filepair_is_phoney() function to make the code more
   self-documenting, as suggested by Junio.
 * Note: Patch 2, as called out in its commit message, disables
   TEST_PASSES_SANITIZE_LEAK for t4069. This is not because I introduce any
   memory leaks, but because I add new testcases invoking additional parts
   of the code (pickaxe stuff) which already had pre-existing leaks. This is
   not a change since v1, but this somehow accidentally got munged out of
   Junio's application of my v1.

Note: The issue fixed by the third commit for --remerge-diff is also an
issue exhibited by 'git log --cc $FILTER_RULES $COMMIT' (or by -c instead of
--cc). However, as far as I can tell the causes are different and come from
separate codepaths; this series focuses on --remerge-diff and hence makes no
attempt to fix independent (even if similar) --cc or -c issues.

[1]
https://lore.kernel.org/git/43cf2a1d-058a-fd79-befe-7d9bc62581ed@gmail.com/

Elijah Newren (3):
  diff: have submodule_format logic avoid additional diff headers
  diff: fix filtering of additional headers under --remerge-diff
  diff: fix filtering of merge commits under --remerge-diff

 diff.c                  | 17 ++++++++++++++---
 t/t4069-remerge-diff.sh | 30 +++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 4 deletions(-)


base-commit: 6c8e4ee870332d11e4bba84901654b355a9ff016
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1342%2Fnewren%2Fremerge-diff-output-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1342/newren/remerge-diff-output-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1342

Range-diff vs v1:

 1:  e4414cf630d ! 1:  aea0bbc1c6a diff: have submodule_format logic avoid additional diff headers
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## diff.c ##
     +@@ diff.c: static void add_formatted_headers(struct strbuf *msg,
     + 				     line_prefix, meta, reset);
     + }
     + 
     ++static int diff_filepair_is_phoney(struct diff_filespec *one,
     ++				   struct diff_filespec *two)
     ++{
     ++	return !DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two);
     ++}
     ++
     + static void builtin_diff(const char *name_a,
     + 			 const char *name_b,
     + 			 struct diff_filespec *one,
      @@ diff.c: static void builtin_diff(const char *name_a,
       
       	if (o->submodule_format == DIFF_SUBMODULE_LOG &&
       	    (!one->mode || S_ISGITLINK(one->mode)) &&
      -	    (!two->mode || S_ISGITLINK(two->mode))) {
      +	    (!two->mode || S_ISGITLINK(two->mode)) &&
     -+	    (one->mode || two->mode)) {
     ++	    (!diff_filepair_is_phoney(one, two))) {
       		show_submodule_diff_summary(o, one->path ? one->path : two->path,
       				&one->oid, &two->oid,
       				two->dirty_submodule);
     @@ diff.c: static void builtin_diff(const char *name_a,
       		   (!one->mode || S_ISGITLINK(one->mode)) &&
      -		   (!two->mode || S_ISGITLINK(two->mode))) {
      +		   (!two->mode || S_ISGITLINK(two->mode)) &&
     -+		   (one->mode || two->mode)) {
     ++		   (!diff_filepair_is_phoney(one, two))) {
       		show_submodule_inline_diff(o, one->path ? one->path : two->path,
       				&one->oid, &two->oid,
       				two->dirty_submodule);
     +@@ diff.c: static void builtin_diff(const char *name_a,
     + 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
     + 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
     + 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
     +-	if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two)) {
     ++	if (diff_filepair_is_phoney(one, two)) {
     + 		/*
     + 		 * We should only reach this point for pairs from
     + 		 * create_filepairs_for_header_only_notifications().  For
      
       ## t/t4069-remerge-diff.sh ##
      @@ t/t4069-remerge-diff.sh: test_expect_success 'remerge-diff w/ diff-filter=U: all conflict headers, no dif
 2:  feac9749460 = 2:  3bd622d5b45 diff: fix filtering of additional headers under --remerge-diff
 3:  46ea0d7dd65 = 3:  7903f8380dc diff: fix filtering of merge commits under --remerge-diff

-- 
gitgitgadget
