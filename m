Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF8BC433FE
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353098AbiETSmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353037AbiETSlM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611B820BCF
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j25so12607095wrc.9
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=q4hxNFkqTVCCuMwbXAWIlyBGIglHeh8calg7Yq0Cafo=;
        b=DCIQVMVCWqGgGfd0fU93ApGSE+aZr3NbFLKzEXtWvtRE6NRlevvAAo5tTiCPUx+yed
         5DEoJAPRC1tdBPwwlXXae4fgT32aV29AJz9nQJZJCfFkQLw0GF6ttuVeMrPYm31Y4fbq
         C77AoYay99bbtoeArdCoMxg7HtUdvFtSFG8Svc0PH8CdtBEQXloY8ceA2CHt5/l6pqjP
         ohMwjdDUOITr9TfWa3J0E/ivp8y4GcJOztVB3FFa6vJvoDz6RPhDbtMP40c0H6NachNH
         utpw6INGv7E/m8wtJ03e7uZixzXiFjTnFoLcB2kbOhYW+lNcWtxAhIfRZiLLWAiPQXBS
         thFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=q4hxNFkqTVCCuMwbXAWIlyBGIglHeh8calg7Yq0Cafo=;
        b=4uSQVzF+x0tdJQNDFjg51Lzqs7UXPyMnOr+UsaqrrNvEd/sHzQix1U+8WKLDMup9sB
         zEjYp7/ZE/8wL38F3ToGM0fQfyzGMzWkc5Bte/Vm41t4hZ3GyXkS+g7KMepGlUoNdHQJ
         Qdubf3ckGpMkIKVtQMqfrkm7M0LGEJQJCKOICSn38mc0TdxF8F3Q8f6DaPTT18QI8rO8
         TFrtasQo9cBv0TBhkeNDnxeWD63kgXWxr4Y0PFhiBSEcnHlIllA0MCt5noULzKo6BRdC
         g9CASymlCiod7yXUJ6QqwazST8QUGU4j3j4EXEXfDRIWt1Bu/4Svjz+onwZMQG5bkL63
         pbOA==
X-Gm-Message-State: AOAM533KB1NB86lw83syq1bgMWjWU+apvmx9oaKBcyg1GZ0ITFyEUbmP
        IIco41I8zjju7c899JG50aiudPSyQ6w=
X-Google-Smtp-Source: ABdhPJxReRRGl+j0cwrGlzy/DTj5ZZjw2pK13CCrVIFY29Jcc8a1IKOxpvKTYjSNXRLJwauCoT6xpw==
X-Received: by 2002:a05:6000:1548:b0:20f:c4e3:637a with SMTP id 8-20020a056000154800b0020fc4e3637amr437247wry.513.1653072067081;
        Fri, 20 May 2022 11:41:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bcc14000000b00394351e35edsm2561289wmh.26.2022.05.20.11.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:41:06 -0700 (PDT)
Message-Id: <2bc114925ade24d5e2e4c7cbd4fb90dcff09e85e.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:38 +0000
Subject: [PATCH 20/24] bundle-uri client: add boolean transfer.bundleURI
 setting
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

The yet-to-be introduced client support for bundle-uri will always
fall back on a full clone, but we'd still like to be able to ignore a
server's bundle-uri advertisement entirely.

The new transfer.bundleURI config option defaults to 'false', but a user
can set it to 'true' to enable checking for bundle URIs from the origin
Git server using protocol v2.

To enable this setting by default in the correct tests, add a
GIT_TEST_BUNDLE_URI environment variable.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/transfer.txt     |  6 ++++++
 t/lib-t5730-protocol-v2-bundle-uri.sh |  3 +++
 transport.c                           | 10 +++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index b49429eb4db..337a7886546 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -77,3 +77,9 @@ transfer.unpackLimit::
 transfer.advertiseSID::
 	Boolean. When true, client and server processes will advertise their
 	unique session IDs to their remote counterpart. Defaults to false.
+
+transfer.bundleURI::
+	When set to `false` ignores any server advertisement of
+	`bundle-uri` and proceed with a "normal" clone/fetch even if
+	using bundles to bootstap is possible. Defaults to `true`,
+	i.e. bundle-uri is tried whenever a server offers it.
diff --git a/t/lib-t5730-protocol-v2-bundle-uri.sh b/t/lib-t5730-protocol-v2-bundle-uri.sh
index 23f2de0d9d7..49d4d848cac 100644
--- a/t/lib-t5730-protocol-v2-bundle-uri.sh
+++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
@@ -1,5 +1,8 @@
 # Included from t573*-protocol-v2-bundle-uri-*.sh
 
+GIT_TEST_BUNDLE_URI=1
+export GIT_TEST_BUNDLE_URI
+
 T5730_PARENT=
 T5730_URI=
 T5730_BUNDLE_URI=
diff --git a/transport.c b/transport.c
index c9d2e1804eb..f0114778ff4 100644
--- a/transport.c
+++ b/transport.c
@@ -1529,6 +1529,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 
 int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
 {
+	int value = 0;
 	const struct transport_vtable *vtable = transport->vtable;
 
 	/* Check config only once. */
@@ -1536,10 +1537,13 @@ int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
 		return 0;
 
 	/*
-	 * This is intentionally below the transport.injectBundleURI,
-	 * we want to be able to inject into protocol v0, or into the
-	 * dialog of a server who doesn't support this.
+	 * Don't use bundle-uri at all, if configured not to.
+	 * This logic defaults "transfer.bundleURI" to false.
 	 */
+	if (!git_env_bool("GIT_TEST_BUNDLE_URI", 0) &&
+	    (git_config_get_bool("transfer.bundleuri", &value) || !value))
+		return 0;
+
 	if (!vtable->get_bundle_uri) {
 		if (quiet)
 			return -1;
-- 
gitgitgadget

