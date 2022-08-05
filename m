Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4950CC00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 18:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbiHESAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 14:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbiHER7V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 13:59:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A48279EEF
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 10:59:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h34-20020a05600c49a200b003a5165eae0fso1586132wmp.4
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=QawMDnDz7mSZjuQbXSqEXdLQCY4h/yBU8Xk/FincMPQ=;
        b=I0f9geOHc37/zd7jGxON79ZRgRoS96T86SZ/ZlGo93jEzXoLShC5GKnT//wzTVPqz2
         ImoIyAd8S6dNYX4DRzZzxUo9IMGUaebi2t+9JNy93AatBuSGfihmEi9ELgcjC/3iXRlf
         E5qF8uRqWeipEYBoNMKlkx4XMJshgBBc992NUXj+1kPKFb4KMF5hcqp7LfSDc7Ohwfao
         Q0O4vqASEG4z3L+6ZC07W0BgXwU/Pd3ScSWnDpBh14wcJXshg7YzLrGbaSAppdVgvWOn
         MSMb0nqn2I22SZ8qSQrSjFXyxr0MsgUjk9ZUZ4TDJARzyYzLbH6DCVnMuzn+3wrK3IZe
         yYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=QawMDnDz7mSZjuQbXSqEXdLQCY4h/yBU8Xk/FincMPQ=;
        b=CBpNKWF+E4cppibD5s1614zFYq05vUbc8nljpXGvhrCSJVCXQEV7lYR35i6KFZ9+ho
         PFfzbT9xtTQpwBkEEn7P1NCREiUR2ebItWbWNecENF8HaIwiGPInyy6hM0WEzfLwCBqj
         FMFcSL4JnkiwD5yHs3s2Jnq+YCqg/4KQ7SmxlfBYe4tg34uxD30BQEnzkn/l2i6jKyvS
         21zrG+SBQJJOY5dvap5WWNKi1Z+ePsAdewlSAb3EeyqpkntI59mFZ4SsH3VS8Jn7yzg0
         ir8uTbNU2Yck4zZe7uyr8ECh0FY4FlCnoalCRH/EEMTbfz+rN+5qbEwKmR64Am9ZnDk7
         cpxQ==
X-Gm-Message-State: ACgBeo1UknqdvtpLcz76qI8ykkjFEh7+8Ns8Zexkb2zP9oW6J8RrGv8x
        /KOFIUYnfcUSz1/QK3t1lA0OTQ9k5zk=
X-Google-Smtp-Source: AA6agR4kE53X5qY2w5/PNrifuNtquznCyZlJjaSNJFdVweYNUsUAhHoKOpt9Gb/cENRHaMpW8Pt32w==
X-Received: by 2002:a05:600c:1c0f:b0:3a5:2113:ebda with SMTP id j15-20020a05600c1c0f00b003a52113ebdamr2239797wms.203.1659722347091;
        Fri, 05 Aug 2022 10:59:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba5-20020a0560001c0500b0021efc75914esm4847377wrb.79.2022.08.05.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:59:05 -0700 (PDT)
Message-Id: <bd2ffac88acd4ac4c408e362b86dada330656cc4.1659722324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Aug 2022 17:58:43 +0000
Subject: [PATCH v3 11/11] fetch: use ref_namespaces during prefetch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The "refs/prefetch/" namespace is used by 'git fetch --prefetch' as a
replacement of the destination of the refpsec for a remote. Git also
removes refspecs that include tags.

Instead of using string literals for the 'refs/tags/ and
'refs/prefetch/' namespaces, use the entries in the ref_namespaces
array.

This kind of change could be done in many places around the codebase,
but we are isolating only to this change because of the way the
refs/prefetch/ namespace somewhat motivated the creation of the
ref_namespaces array.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/fetch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fc5cecb4835..368a0f5329c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -490,7 +490,9 @@ static void filter_prefetch_refspec(struct refspec *rs)
 			continue;
 		if (!rs->items[i].dst ||
 		    (rs->items[i].src &&
-		     !strncmp(rs->items[i].src, "refs/tags/", 10))) {
+		     !strncmp(rs->items[i].src,
+			      ref_namespace[NAMESPACE_TAGS].ref,
+			      strlen(ref_namespace[NAMESPACE_TAGS].ref)))) {
 			int j;
 
 			free(rs->items[i].src);
@@ -506,7 +508,7 @@ static void filter_prefetch_refspec(struct refspec *rs)
 		}
 
 		old_dst = rs->items[i].dst;
-		strbuf_addstr(&new_dst, "refs/prefetch/");
+		strbuf_addstr(&new_dst, ref_namespace[NAMESPACE_PREFETCH].ref);
 
 		/*
 		 * If old_dst starts with "refs/", then place
-- 
gitgitgadget
