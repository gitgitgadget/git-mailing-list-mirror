Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18F3C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 20:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347101AbiEPU3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 16:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348837AbiEPU1z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 16:27:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E6F1928A
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p189so9344817wmp.3
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=U/r/9EV8L9YP7PY4ue/BiQabkdglT5aaqWXkZsxe3Uo=;
        b=q0LfEFXNHlTRxWEQXN+Un3Yik5mr9+fPuUzP2DqxwWsOT1EO9vVq4sEVkE2/9OTJsj
         1ERld5Ev+WYyemr0LzER/0w7uQS3pwdFrHQNvVQrPfR14lRYKvtP3A8DnxFqMSYd7GdN
         lcYuLI6psugXXfPPqH+bQJBBUi+N/a2R6pXmhMhou9zGrRI75cRS/8DUv2jwCDE3n6Fh
         g0Wt0f9KWOdkhznEXtiRHzTCg6Y3ud+K3oLNaubP1qWrf6BO4GTW/UsvhApykV2iWG1M
         Xa8ohnQysIask8ESnjgZkQFHnF6dgFvPt2fF5eDPx9V3QGcBCNRSOKTMQCo6+XgbU3II
         4aZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=U/r/9EV8L9YP7PY4ue/BiQabkdglT5aaqWXkZsxe3Uo=;
        b=e/dprYB312BFl14g5g6ZUrGdkeaP1JirkiJvhwfWMrC+NaMZ4CdTYCGdAUuXRhJjCy
         5xp82bcXIBBJ8Wshve5ecanPfqO+JT/2W+W/qgcwNJsOZgoxGiELLfLUdOVM6ri+LTeJ
         T4z0RA1SFzBoSlHCbeS0h3ZXmysa7l8TZHPglxTIiSMR+cbtDO6teLNdA3wt0K8t050p
         e2lV/jiIvY7SSnE15dHEpaFG3ipyB0nFcfazuS7ZSqGZjTbm3N7Sbs1kPDggESuxlpHi
         SxJiOCC0pPZGqOGq0SpYuP7iUXtTv6itMN6g1Afeq/b5eC3OdQMTAENaxjizkh4Urv8s
         sx2Q==
X-Gm-Message-State: AOAM533IydGx6HRS5gd4M53wfrkSpcupowXk1Tuzp1dLbUXqesLOI8Q+
        rkJi1xiOeRYBs10qnNAct2JJPoXJWOQ=
X-Google-Smtp-Source: ABdhPJyDkcAdspidqRaZqbe66YjHG2f3//vpRRSEhGQHeejwQObJlDb6tl/gsnzEGYUizQ5o3MW6Ww==
X-Received: by 2002:a05:600c:4f15:b0:394:8ea0:bb45 with SMTP id l21-20020a05600c4f1500b003948ea0bb45mr18355125wmq.206.1652731878351;
        Mon, 16 May 2022 13:11:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x3-20020a1c7c03000000b0039482d95ab7sm187206wmc.24.2022.05.16.13.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:11:17 -0700 (PDT)
Message-Id: <c35f35dc08a8b315a7f4ee783dfa407f774b0b38.1652731865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
References: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 20:11:05 +0000
Subject: [PATCH 8/8] bundle.h: make "fd" version of read_bundle_header()
 public
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, albertqcui@gmail.com, robbat2@gentoo.org,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Change the parse_bundle_header() function to be non-static, and rename
it to parse_bundle_header_fd(). The parse_bundle_header() function is
already public, and it's a thin wrapper around this function. This
will be used by code that wants to pass a fd to the bundle API.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle.c | 8 ++++----
 bundle.h | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/bundle.c b/bundle.c
index d50cfb5aa7e..5fa41a52f11 100644
--- a/bundle.c
+++ b/bundle.c
@@ -66,8 +66,8 @@ static int parse_bundle_signature(struct bundle_header *header, const char *line
 	return -1;
 }
 
-static int parse_bundle_header(int fd, struct bundle_header *header,
-			       const char *report_path)
+int read_bundle_header_fd(int fd, struct bundle_header *header,
+			  const char *report_path)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int status = 0;
@@ -143,7 +143,7 @@ int read_bundle_header(const char *path, struct bundle_header *header)
 
 	if (fd < 0)
 		return error(_("could not open '%s'"), path);
-	return parse_bundle_header(fd, header, path);
+	return read_bundle_header_fd(fd, header, path);
 }
 
 int is_bundle(const char *path, int quiet)
@@ -153,7 +153,7 @@ int is_bundle(const char *path, int quiet)
 
 	if (fd < 0)
 		return 0;
-	fd = parse_bundle_header(fd, &header, quiet ? NULL : path);
+	fd = read_bundle_header_fd(fd, &header, quiet ? NULL : path);
 	if (fd >= 0)
 		close(fd);
 	bundle_header_release(&header);
diff --git a/bundle.h b/bundle.h
index 7fef2108f43..0c052f54964 100644
--- a/bundle.h
+++ b/bundle.h
@@ -24,6 +24,8 @@ void bundle_header_release(struct bundle_header *header);
 
 int is_bundle(const char *path, int quiet);
 int read_bundle_header(const char *path, struct bundle_header *header);
+int read_bundle_header_fd(int fd, struct bundle_header *header,
+			  const char *report_path);
 int create_bundle(struct repository *r, const char *path,
 		  int argc, const char **argv, struct strvec *pack_options,
 		  int version);
-- 
gitgitgadget
