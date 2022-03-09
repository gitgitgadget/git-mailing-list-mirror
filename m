Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD22C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 16:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiCIQDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiCIQCy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 11:02:54 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9260917F6B5
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 08:01:52 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r6so3345282wrr.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 08:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qvpX/0xqAMbcZk3Asv2E/I9bjNoKDUuKRq3KG+b3yEw=;
        b=TrUGb/rucz6KEpUE44KzlxheQldvDzDCvOYL8f2fQ+OaIyCh2YUK0Pqi26A9EBL5qJ
         XqfXD6Ewq5EcNNLO8YlKAUNU1eKPco+Ug4RfRGSrXoEIlFWkhgwZh0QoTd1S0Tm4SHuN
         Q3xS9KYxMZDGEPUk8tttX83pwBOLdVgZL+bM0+Y9eCaMA99Xn9s4ov8Rw2193/vJP9lW
         ttmwjFyhwIkysGZxrkRLMq7aoasARuA2cybtoznZ2XHQ/dF81Vr9yjkf6Dro6wkTSWsU
         xKkJx/J+3Rwfx+gaz+HEzWMngZnoa0EjY1CX1k+ShMFaiy+RjCuzKdSxdWKZXudsxQhH
         CvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qvpX/0xqAMbcZk3Asv2E/I9bjNoKDUuKRq3KG+b3yEw=;
        b=SFIs9UodIb9fM57ozsF2LfaHDxjG4z5vJ1mayLv4seaoPTBkeQBC5KP45pr4BrOihf
         m4TkMwfnisKPjmEFzYAnLCll7Eme9cuiQ6dQ7IqEfgUl6noGFQxcnVVx8WqnkJd9a4IX
         lLUo3Ydcgci7xVVqttd+afeAJmwhViCBEBzKA0xZzWxWewAPGaZU+cXdHmc/ja6X3ZJk
         jUx93pW8aPcF+/k8ZNwUUlM+o9pZcc4wFgs1omM2uYTElMwgk8Q9Klo0RIJW5kXjDf9L
         6FDeeDbEpW/kTGnCb+JG0cDkyp6dx6zsO07PBEtMLE6IXQDGFoimz96EWHTshzCHyspQ
         fN9A==
X-Gm-Message-State: AOAM531kjruPhiYGBlV1DPBuCMW2zkS+5znrP2p6l3x7ZtHb7Alfb9fk
        81MYYxywqVF3S3H66Hz7LNYDM1U29QA=
X-Google-Smtp-Source: ABdhPJyRM+NqCg2nI3hNl8oDk47hVMH4VRv74HVtooi3/YI5Hsgg+8O369ot9w8A8suSVMr38vIBcQ==
X-Received: by 2002:adf:fa8c:0:b0:1f0:47ef:a04 with SMTP id h12-20020adffa8c000000b001f047ef0a04mr238254wrr.398.1646841710520;
        Wed, 09 Mar 2022 08:01:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0037fa5c422c8sm5949334wmb.48.2022.03.09.08.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:01:50 -0800 (PST)
Message-Id: <ed22a77782bee97ef50fe1ff1a12fa2fa1470805.1646841703.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 16:01:34 +0000
Subject: [PATCH v4 04/13] pack-objects: use rev.filter when possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

In builtin/pack-objects.c, we use a 'filter_options' global to populate
the --filter=<X> argument. The previous change created a pointer to a
filter option in 'struct rev_info', so we can use that pointer here as a
start to simplifying some usage of object filters.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/pack-objects.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba2006f2212..e5b7d015d7d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3651,7 +3651,7 @@ static int pack_options_allow_reuse(void)
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
-	if (!(bitmap_git = prepare_bitmap_walk(revs, &filter_options, 0)))
+	if (!(bitmap_git = prepare_bitmap_walk(revs, &revs->filter, 0)))
 		return -1;
 
 	if (pack_options_allow_reuse() &&
@@ -3727,6 +3727,7 @@ static void get_object_list(int ac, const char **av)
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, &s_r_opt);
+	list_objects_filter_copy(&revs.filter, &filter_options);
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
@@ -3777,7 +3778,7 @@ static void get_object_list(int ac, const char **av)
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
-	traverse_commit_list_filtered(&filter_options, &revs,
+	traverse_commit_list_filtered(&revs.filter, &revs,
 				      show_commit, fn_show_object, NULL,
 				      NULL);
 
-- 
gitgitgadget

