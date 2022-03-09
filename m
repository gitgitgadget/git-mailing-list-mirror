Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FB7C4332F
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 16:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiCIQDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiCIQCy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 11:02:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4759B17F6A4
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 08:01:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so1748732wms.4
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 08:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nhoz//lgtAOsg7zwaxkPxCWbsvzxKtOa6k0srOiAd7k=;
        b=LhTaBZdbwVrU2gIYkbkDjY5U3yaHC7VhXZy4mJHnspL33FmqPUHuW53yNo9oFYu6b7
         5melvROP31/E28vhs4nt6mafFCJyDTyKazG44bxH8xdGxhkQIKN2xZMoQQ+DmWsbJIpi
         6pWwHrXBj3sne6bFHMASKvwrrIzrwwWpGnmngvCf8QF1HjyrghgqKx+wf+p6jz9h2CQC
         QwoFRvIPd5Vvp6vNRAYCAvzaVxxqQzTCISQbEGKGxjDuwDgLGTEQA/9olyh/lhTs/3nh
         emfLD2pLXb8h0BSU6VthrE3kN7v693O9lEBD7DIUkNXSxtUvdOpvmjxzSnKLXDHIDLZd
         uaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nhoz//lgtAOsg7zwaxkPxCWbsvzxKtOa6k0srOiAd7k=;
        b=uZkgFMpTGJfY8hWT8vTeJ68im1ocJZj2FdEGz7xMPUOXeb9dk0unGRrJSo57oh36Vr
         AqjTnoAzcQMRsK6SfaIhtzkjue41C+tkVHegOHRXloqSohVaxoATuwcSMhLqGb59kxbb
         U31JTcMgG/w+93iYX3wXJtCdsYhGtIhyPWDTAtDigM8cUV+OcP5mWzF7beeI7leZ+eI/
         7Xn8mpfpFB4MKjStGDgIxyTvSMcH7lDcG/gIm5GxrjZIZ4gw4gZJb03CTdPmv1UsTzQy
         MdTSlxAtNFmEiqYzavRsd3OmG8ATuD0SBNO0r+jSiOJ+0R0VisTlh/HuPmyKPIjiHO5B
         3Fyg==
X-Gm-Message-State: AOAM530qm6N1V1rQ6yeFiB8DxUkhd9PhhqIKVDpLqvGLpdC65OfhL7r1
        unDPR3kcNEYa/dYlPt2VPMD6mg0WwIc=
X-Google-Smtp-Source: ABdhPJxZRi1Oa/DmwspucF4pTCSxylN3mo+jhalPzu4ZkpeV9DhPWbWBJwvym1XuS3JKgrZOxKte6g==
X-Received: by 2002:a7b:c04e:0:b0:380:ead9:254a with SMTP id u14-20020a7bc04e000000b00380ead9254amr8086702wmc.58.1646841708055;
        Wed, 09 Mar 2022 08:01:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r187-20020a1c44c4000000b0038377fb18f8sm3121207wma.5.2022.03.09.08.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:01:47 -0800 (PST)
Message-Id: <a4c5a727ef1fd7e36d6d870fd05cc694b0436c0d.1646841703.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 16:01:32 +0000
Subject: [PATCH v4 02/13] list-objects-filter-options: create copy helper
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

As we add more embedded members with type 'struct
list_objects_filter_options', it will be important to easily perform a
deep copy across multiple such structs. Create
list_objects_filter_copy() to satisfy this need.

This method is recursive to match the recursive nature of the struct.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 list-objects-filter-options.c | 19 +++++++++++++++++++
 list-objects-filter-options.h |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index fd8d59f653a..449d53af69f 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -415,3 +415,22 @@ void partial_clone_get_default_filter_spec(
 					 &errbuf);
 	strbuf_release(&errbuf);
 }
+
+void list_objects_filter_copy(
+	struct list_objects_filter_options *dest,
+	const struct list_objects_filter_options *src)
+{
+	int i;
+	struct string_list_item *item;
+
+	/* Copy everything. We will overwrite the pointers shortly. */
+	memcpy(dest, src, sizeof(struct list_objects_filter_options));
+
+	string_list_init_dup(&dest->filter_spec);
+	for_each_string_list_item(item, &src->filter_spec)
+		string_list_append(&dest->filter_spec, item->string);
+
+	ALLOC_ARRAY(dest->sub, dest->sub_alloc);
+	for (i = 0; i < src->sub_nr; i++)
+		list_objects_filter_copy(&dest->sub[i], &src->sub[i]);
+}
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index da5b6737e27..425c38cae9d 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -132,4 +132,8 @@ void partial_clone_get_default_filter_spec(
 	struct list_objects_filter_options *filter_options,
 	const char *remote);
 
+void list_objects_filter_copy(
+	struct list_objects_filter_options *dest,
+	const struct list_objects_filter_options *src);
+
 #endif /* LIST_OBJECTS_FILTER_OPTIONS_H */
-- 
gitgitgadget

