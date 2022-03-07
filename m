Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4552AC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbiCGVvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbiCGVvl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:51:41 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867857561B
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:50:46 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso288301wmr.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 13:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h62JVzb/uF3I+8SLeb9g0QKm9zTbW6d6LFRo3OfnaqQ=;
        b=hDXTEW+MYObChx3LtvgwouOJ4uSzkZpbxyr7w68OgOY3PkURJ7Sx4ZbxFpjfvxYxzD
         0y1O0LGJe/IGH9hBGBET0qRHA4VSXQ28e7jdUHTy5euitQvFsHLe26M2ric3WmavItWk
         Yuv+k0ccz6tzq2YwqdfsWzm5ZItjKAlx/JZs9fOZ18UcxPLjwdaQGDD8/WTOVCoRhZEK
         OFNlFu765OzlNJ8DMZ+1e/bdz9dku/eBOHhhDJRxSlV0MPdEBM1Lk4NzkicosTQ75LzZ
         Gw+6UkmZ8Lb/RBrLjEBlGICKX1kIpY/mkE6iJUTkwfvAV322X+GOPumnQsXb7ELOlKBZ
         cyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h62JVzb/uF3I+8SLeb9g0QKm9zTbW6d6LFRo3OfnaqQ=;
        b=v1cI9tQw5MIar9FWyH6s3Y+dVmLjJagbVsw7owpKBzA4CCY4ytbR8gh+LJ02R2f6FA
         9YTfEoXm2Z4btAkTir9am31fQpNDJvIZ8auV39xU5gL/3O5EPMENdRKr2T6TNOo8XFAm
         ydluohkeUo7Kat583ubccCgBa20TWpl3YOj7sRCVoI4AW72ry15B5kJ1rgzMbweQhiKL
         6yNvC2AaYE9UERcOJ6IyYTlOFlQ8+mtkKwU7/KbgScg/W3/KBP+dUwKFkE8601rCYT+R
         FFgsapm7udZyDbN0EpGDwyrN7O8wNpqfexmKEUFGS9D3rRRGJ8a31IM1q3DiDaDq2mpa
         aooQ==
X-Gm-Message-State: AOAM532+Ay8DbXUHZzs3mQpp4ILmdbVaclcNYfEz9jtu/RZogybhiPcn
        tbS8HTwalpP6mLT9kNBeWnhUOEZfScM=
X-Google-Smtp-Source: ABdhPJyeK7DOsrzbBkyU6u+2HnykcZZUfwMu+T1X6czS7mysJzLqSlJz4ZKmox+97FJmplHTJomhjQ==
X-Received: by 2002:a05:600c:4f4f:b0:37b:d847:ef15 with SMTP id m15-20020a05600c4f4f00b0037bd847ef15mr829211wmq.130.1646689844964;
        Mon, 07 Mar 2022 13:50:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4010000000b001f07772457csm9059676wrp.101.2022.03.07.13.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:50:44 -0800 (PST)
Message-Id: <d5edb193229731edbac9f861ad569885ec2b4405.1646689840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Mar 2022 21:50:31 +0000
Subject: [PATCH v2 03/12] pack-objects: use rev.filter when possible
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
index ba2006f2212..256d9b1798f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3651,7 +3651,7 @@ static int pack_options_allow_reuse(void)
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
-	if (!(bitmap_git = prepare_bitmap_walk(revs, &filter_options, 0)))
+	if (!(bitmap_git = prepare_bitmap_walk(revs, revs->filter, 0)))
 		return -1;
 
 	if (pack_options_allow_reuse() &&
@@ -3727,6 +3727,7 @@ static void get_object_list(int ac, const char **av)
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, &revs, &s_r_opt);
+	revs.filter = &filter_options;
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
@@ -3777,7 +3778,7 @@ static void get_object_list(int ac, const char **av)
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
-	traverse_commit_list_filtered(&filter_options, &revs,
+	traverse_commit_list_filtered(revs.filter, &revs,
 				      show_commit, fn_show_object, NULL,
 				      NULL);
 
-- 
gitgitgadget

