Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDC5ECAAA1
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 03:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiIBDxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 23:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiIBDxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 23:53:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BB123BC8
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 20:53:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u18so703908wrq.10
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 20:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=XtacciwFJOv4DbTyWmlidVssEVu/hCV3UP0dDaxo41Q=;
        b=aZSEvrNXsYZexMz/fhta91krFWLncM9Z/rMNVAO8O/KV+FWFgeGVEXIRKAn7q6r1ub
         IcfVT8fOdoV+fvPSb+FToAiGSXSD4hiI8Lkn0EU0+cnYkIbcknaKvL4SHy5sgKdC1j5K
         PfdZPZOAS9ZAcfMTbibEZlXyD6pRAWJIpM/J2hi6XRxEUI1zr+z5gGTfNTRPY/PsBBHQ
         iYQY7cAZmfQStnrC+6TdpgM1a0NaSZ1XEUUipJaJ4XNxN31R1ZBDIMXQMSXUPq6SUM9C
         tmP1Xavb2N6UsWydm6O10aV7dJ0xGenKV9AOG53fQFp7EEn0dYb675VGNz3Mloa5IylN
         iemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XtacciwFJOv4DbTyWmlidVssEVu/hCV3UP0dDaxo41Q=;
        b=D5ofFiSDsYxeMwx/sb+CuP0cG5iAsm9K73BkCMEqIjUdmSZo/4pS3q0X58Z0QFE2Q/
         URFbRMyqPzBkHyzFHC+rubCiBnggid2cT/FA1g1L/MYMVDLFr3Vyx+pNZW74ZtvEbDxx
         Bvik8pPBgjWzdKmUY5uftZvflB2770z4d9KuX8rVJ1t0LzI/Kz2LSNFtm4zxg+PAAoKS
         1Go3snq61Z7G7Oqqj0o6kgstJLaRM6hmwmbKQoM2pu7Ka+BGeKwOQdKy7Z58F1fGQF2A
         AjUYZGsAp/yU5f5zKzJhMZV55Kj/80lm2TpkhierM/NqnsIN/fYXLhgLo0ibJFaJOcqx
         V4Og==
X-Gm-Message-State: ACgBeo0sC3eC9IwAdCb/zH3osdAf9qCfvBPra6Z2LZcais3imoNmnoxw
        kNM70svsOc+zooP/BWPAm/2wOQSFiQE=
X-Google-Smtp-Source: AA6agR60ZHh9tjoB9fg1q5/4Zw5hRqjFke7Vly91MdBeRYdea9dyk7hBrIG8dUKs4aNDzefXNvF/Pg==
X-Received: by 2002:a05:6000:1d8c:b0:226:eea4:49ef with SMTP id bk12-20020a0560001d8c00b00226eea449efmr5469562wrb.663.1662090811641;
        Thu, 01 Sep 2022 20:53:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c4e8e00b003a5dbdea6a8sm9256280wmq.27.2022.09.01.20.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:53:31 -0700 (PDT)
Message-Id: <pull.1342.v3.git.1662090810.gitgitgadget@gmail.com>
In-Reply-To: <pull.1342.v2.git.1662016087.gitgitgadget@gmail.com>
References: <pull.1342.v2.git.1662016087.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 03:53:27 +0000
Subject: [PATCH v3 0/3] Output fixes for --remerge-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain found and reported a couple issues with the output of
--remerge-diff[1]. After digging in, I think one of them actually counts as
two separate issues, so here's a series with three patches to fix these
issues. Each includes testcases to keep us from regressing.

Changes since v2:

 * Added a comment describing the rationale for the new
   diff_filepair_is_phoney() function.

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

 diff.c                  | 32 ++++++++++++++++++++++++++------
 t/t4069-remerge-diff.sh | 30 +++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 7 deletions(-)


base-commit: 6c8e4ee870332d11e4bba84901654b355a9ff016
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1342%2Fnewren%2Fremerge-diff-output-fixes-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1342/newren/remerge-diff-output-fixes-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1342

Range-diff vs v2:

 1:  aea0bbc1c6a ! 1:  ed28acaed97 diff: have submodule_format logic avoid additional diff headers
     @@ Commit message
      
          The submodule_format handling is another codepath with the same issue;
          it would operate on these additional headers and attempt to display them
     -    as submodule changes.  Prevent that by explicitly checking for both
     -    modes being 0.
     +    as submodule changes.  Prevent that by explicitly checking for "phoney"
     +    filepairs (i.e. filepairs with both modes being 0).
      
          Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
     @@ diff.c: static void add_formatted_headers(struct strbuf *msg,
      +static int diff_filepair_is_phoney(struct diff_filespec *one,
      +				   struct diff_filespec *two)
      +{
     ++	/*
     ++	 * This function specifically looks for pairs injected by
     ++	 * create_filepairs_for_header_only_notifications().  Such
     ++	 * pairs are "phoney" in that they do not represent any
     ++	 * content or even mode difference, but were inserted because
     ++	 * diff_queued_diff previously had no pair associated with
     ++	 * that path but we needed some pair to avoid losing the
     ++	 * "remerge CONFLICT" header associated with the path.
     ++	 */
      +	return !DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two);
      +}
      +
     @@ diff.c: static void builtin_diff(const char *name_a,
      -	if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two)) {
      +	if (diff_filepair_is_phoney(one, two)) {
       		/*
     - 		 * We should only reach this point for pairs from
     +-		 * We should only reach this point for pairs from
     ++		 * We should only reach this point for pairs generated from
       		 * create_filepairs_for_header_only_notifications().  For
     +-		 * these, we should avoid the "/dev/null" special casing
     +-		 * above, meaning we avoid showing such pairs as either
     ++		 * these, we want to avoid the "/dev/null" special casing
     ++		 * above, because we do not want such pairs shown as either
     + 		 * "new file" or "deleted file" below.
     + 		 */
     + 		lbl[0] = a_one;
      
       ## t/t4069-remerge-diff.sh ##
      @@ t/t4069-remerge-diff.sh: test_expect_success 'remerge-diff w/ diff-filter=U: all conflict headers, no dif
 2:  3bd622d5b45 = 2:  f91bea2bbc3 diff: fix filtering of additional headers under --remerge-diff
 3:  7903f8380dc = 3:  084a037756d diff: fix filtering of merge commits under --remerge-diff

-- 
gitgitgadget
