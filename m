Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB91BC433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 20:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347426AbiEPU25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 16:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbiEPU1p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 16:27:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4C218B24
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r188-20020a1c44c5000000b003946c466c17so216697wma.4
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=CMM7XzceafSd/2uhqTgyB2yXqhYZx5oO0BrLu1l4zW0=;
        b=cHXwsEZDKG5L3upgTzN5RUe5InkyfexdmL/Gh0rakuURoQaSqzouiBvwCI5bTFYOoS
         z+RC/iXWcV8tG1bKbxkoiZhJkHusUBpOdiYRUNes/jAHfLgzLt7heykGJUS/zrDpEN+n
         +imYG0gWBfj4n79Dhh6QgukTcbkZsMgZDZVWnUxMh65Er5YTwDbjd8V5sdamnTREd9jn
         5NOePKwDpfIZuIiMP5iBzXJ5zS3Tf/MvWc+J89bxrfoLB9fnEtOutStLxx2pViUyBUBs
         +xkeWgHCfFW4FfRhSaFNtc0NY6BHBwbpXbcamN54R22NUVuQYe5DUT3tGmo5NpWlkYTV
         TuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=CMM7XzceafSd/2uhqTgyB2yXqhYZx5oO0BrLu1l4zW0=;
        b=A9kDON8oa4otEf8Dc28vMBuJd6NHvTkD50o3iVmrKhCvSvghhDYFJpZHVA5BhD2K8L
         C8hm58cTK6xY9i8T3WU/bjavuIKkEITM4syqUQxklq1AwmlVpkoY8sPSgc27jLx6Gv4U
         RmXVgloxpAPM/DACZf6HOXZ8zgI5DyrZSwnytNomAIQYuesKqW3GAzQThF8qjHQm7rxo
         k7zyVZsuEY640zOKIMK8Rm21ceUEfAb1t3dN/EzV5wsVLwPaPaIszn9hwScUfG8h7Byj
         9EmkVTdLnvCMvlwkFJc02HBSPl0O4x2U+KBOZwCCLqBfleUKfA/bK1wEXpNT8eoc0i7M
         qItQ==
X-Gm-Message-State: AOAM531mugkHmrhzwGz64i2zA09sDgZKOHouUz6gTGCbjZ29qfUDJ0en
        8EhNJG+tsqIXoOgD7zeJONNhzM/l2k8=
X-Google-Smtp-Source: ABdhPJxW0KQNxZMu77mszTiObuiUeX1NCwTFeKy2yh55qab1HNKu7fIeyztBjWIvA80ejSDsMW+WZg==
X-Received: by 2002:a05:600c:4885:b0:393:fac6:f409 with SMTP id j5-20020a05600c488500b00393fac6f409mr28603578wmp.150.1652731872773;
        Mon, 16 May 2022 13:11:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6-20020adf8bc6000000b0020c5253d8besm10607948wra.10.2022.05.16.13.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:11:12 -0700 (PDT)
Message-Id: <dd7eb99cfaa4bdf787e0af414a0232e7f74730fb.1652731865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
References: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 20:11:01 +0000
Subject: [PATCH 4/8] fetch-pack: move --keep=* option filling to a function
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

Move the populating of the --keep=* option argument to "index-pack" to
a static function, a subsequent commit will make use of it in another
function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 fetch-pack.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index d0aa3a5c229..b1d90d1914f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -847,6 +847,16 @@ static void parse_gitmodules_oids(int fd, struct oidset *gitmodules_oids)
 	} while (1);
 }
 
+static void add_index_pack_keep_option(struct strvec *args)
+{
+	char hostname[HOST_NAME_MAX + 1];
+
+	if (xgethostname(hostname, sizeof(hostname)))
+		xsnprintf(hostname, sizeof(hostname), "localhost");
+	strvec_pushf(args, "--keep=fetch-pack %"PRIuMAX " on %s",
+		     (uintmax_t)getpid(), hostname);
+}
+
 /*
  * If packfile URIs were provided, pass a non-NULL pointer to index_pack_args.
  * The strings to pass as the --index-pack-arg arguments to http-fetch will be
@@ -916,14 +926,8 @@ static int get_pack(struct fetch_pack_args *args,
 			strvec_push(&cmd.args, "-v");
 		if (args->use_thin_pack)
 			strvec_push(&cmd.args, "--fix-thin");
-		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit)) {
-			char hostname[HOST_NAME_MAX + 1];
-			if (xgethostname(hostname, sizeof(hostname)))
-				xsnprintf(hostname, sizeof(hostname), "localhost");
-			strvec_pushf(&cmd.args,
-				     "--keep=fetch-pack %"PRIuMAX " on %s",
-				     (uintmax_t)getpid(), hostname);
-		}
+		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit))
+			add_index_pack_keep_option(&cmd.args);
 		if (!index_pack_args && args->check_self_contained_and_connected)
 			strvec_push(&cmd.args, "--check-self-contained-and-connected");
 		else
-- 
gitgitgadget

