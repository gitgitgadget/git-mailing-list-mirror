Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCE0C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 15:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbiCDPFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240040AbiCDPF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 10:05:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875E715B984
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 07:04:40 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so5254899wmp.5
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 07:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GQLIrddXetsyrX2ll69SBqBgf8QkoPOqnA7Y0Pv1zaE=;
        b=mTHRQsQwzAYK+gor9yV471uO+dvF6e4HYI42JdqJnVaZdzs0UVyC86ZSDUtUrDu2lQ
         pl8S2OQVUkoGSYGIKG7ojMHcb+yWr8fVES5IuuxF3hMIWvPid8x1odbabC9CVlBedYWQ
         QNjOKddVidvc+2rfBBsB5sqog5OCK8UHApCMRtIPDsDlKH/BNKwx/KmflwafPb2tu8bJ
         2OcXGr72pye6gBHcy5koGWcWwCR0VX2xvd7QQl+oh5Xd9G/tV8VrVq7CpU3pW4Dl8Iun
         yX9tN8YNgRZ/uvsqECJLpi25KKdKS7ODDUnmp8+FsbqbHoj9+gee0aJf+GdEiha62vR3
         1orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GQLIrddXetsyrX2ll69SBqBgf8QkoPOqnA7Y0Pv1zaE=;
        b=FW20Fj21lBm+Dbim6JS8AdUe1ocPxuT1M7+hkNq1zVX9b6zZCv4dzcC9rp5G9WODJo
         3e1aM9Z2vQDYTFka46yHsDeAm6/L+BhTlNIs7C6R4CqG4B4jaNz/UGkmxeHCVEz5u9oJ
         1/VbxrpOUIzyEiR5bkYIlP+SfEucTxDhNjmAhlRmJ3ycMOgtw9ITKWFO36KKRtvU91Z3
         swWSm4NukQC7U86I5E7NrxNC5tsxXINUAH+ZaZdD6sWp9Rncv8+ksVo9+FH3ECLaptof
         hNvUSkOKU6Wab6kz40HAOjnp01x8FI4eRqNcjYz0xro13kr4N5XGKRJYBTtE+qSx6ipF
         CMYw==
X-Gm-Message-State: AOAM532o/ubaSu0VmniYJtyyT6DH77WjkJZ/sqa4Fql4zbeZBxxL5MUI
        qcfH2ESt1qtHUdjZo7Vok0oolmeoJ9Q=
X-Google-Smtp-Source: ABdhPJyKUAn5B2rXRlPDrZy6vx3gMM5EPtrn5L3M0BKrlFtyg3ncn8Hrb0KG4fYIodFZ8+LSVRKMmQ==
X-Received: by 2002:a05:600c:1d08:b0:381:6eda:67d1 with SMTP id l8-20020a05600c1d0800b003816eda67d1mr8390734wms.88.1646406278857;
        Fri, 04 Mar 2022 07:04:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10-20020adf808a000000b001edd413a952sm4758282wrl.95.2022.03.04.07.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 07:04:38 -0800 (PST)
Message-Id: <879d30c4473ee31ad26b324cabf02eb37b3bd62a.1646406275.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
References: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
        <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 15:04:30 +0000
Subject: [PATCH v3 3/7] builtin/fetch-pack: add --refetch option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Add a refetch option to fetch-pack to force a full fetch. Use when
applying a new partial clone filter to refetch all matching objects.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 Documentation/git-fetch-pack.txt | 4 ++++
 builtin/fetch-pack.c             | 4 ++++
 remote-curl.c                    | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index c9758847937..46747d5f429 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -101,6 +101,10 @@ be in a separate packet, and the list must end with a flush packet.
 	current shallow boundary instead of from the tip of each
 	remote branch history.
 
+--refetch::
+	Skips negotiating commits with the server in order to fetch all matching
+	objects. Use to reapply a new partial clone blob/tree filter.
+
 --no-progress::
 	Do not show the progress.
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c2d96f4c89a..1f8aec97d47 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -153,6 +153,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.from_promisor = 1;
 			continue;
 		}
+		if (!strcmp("--refetch", arg)) {
+			args.refetch = 1;
+			continue;
+		}
 		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
 			parse_list_objects_filter(&args.filter_options, arg);
 			continue;
diff --git a/remote-curl.c b/remote-curl.c
index 0dabef2dd7c..fc75600d4c6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -43,6 +43,7 @@ struct options {
 		/* see documentation of corresponding flag in fetch-pack.h */
 		from_promisor : 1,
 
+		refetch : 1,
 		atomic : 1,
 		object_format : 1,
 		force_if_includes : 1;
@@ -198,6 +199,9 @@ static int set_option(const char *name, const char *value)
 	} else if (!strcmp(name, "from-promisor")) {
 		options.from_promisor = 1;
 		return 0;
+	} else if (!strcmp(name, "refetch")) {
+		options.refetch = 1;
+		return 0;
 	} else if (!strcmp(name, "filter")) {
 		options.filter = xstrdup(value);
 		return 0;
@@ -1182,6 +1186,8 @@ static int fetch_git(struct discovery *heads,
 		strvec_push(&args, "--deepen-relative");
 	if (options.from_promisor)
 		strvec_push(&args, "--from-promisor");
+	if (options.refetch)
+		strvec_push(&args, "--refetch");
 	if (options.filter)
 		strvec_pushf(&args, "--filter=%s", options.filter);
 	strvec_push(&args, url.buf);
-- 
gitgitgadget

