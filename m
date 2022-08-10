Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29074C25B07
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 23:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiHJXet (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiHJXem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 19:34:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792B08C031
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso1857846wma.2
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=327gbsyYeccEL0tlq4IQ1Y7CXUns6oBUTnyfqIVz7cI=;
        b=i6K21r6tAJXe+l0MG289DJinaeAstu3K4fhie2/6eq5BKVqwUBNnXCZw2wGybS3tn/
         d3M+Dy7SmOIAZ4X+FCjXkmjy4TXHglgG1W//DMnrSSFtHVxACgVSLokh4D1uvEkbbCsn
         KpnqHXkiE0UvXO73FzAAUEKV6sTEN+w5Eu/P3WZeejfhl8ZFcIBH4BzupZUMvDRbNPc2
         CeSGaP+KqtbHaCVzwQhv6IOS8H+YxxyEQGSS/pMY+G0gn+xB6r7yph4SQJzrRokwsU6T
         JdDOpKFDwL9vOVmF7vmeweS0rBFtbwBiVCbCnpaXOldamhyKO95Na1ojCiaUHIrYAxg9
         DjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=327gbsyYeccEL0tlq4IQ1Y7CXUns6oBUTnyfqIVz7cI=;
        b=8EDghuLaw4JJN5Cyq38yn8A8oTcX/xngyKC4cMxmk3PDcLduW9AC+qHOJMXMGCNh7o
         0uu50oM5SbFtp/T06OBjdcE4U+HpOl0xczQE2IHNmKtCFyt3rYW41vpcgCD7j5kPcKC9
         B8ajfQY45R7yy7LdnrLthvWTBuBsrgHBY1TaVTfkicAj/o+3sSDMIFJMKySblKKfbuED
         uLcBF/D0XXsYu6MHh1NvPFLj06loziSmKcLS97ZfIcaLXfMX1wucKrJqj+kz9/sSLjuX
         ytRQsEy7KJAKYHH9TH+jzoePDzSNxOB4EVnTqiM1mtzTddUQreRTMcMlaaD0CWE5JPJC
         fzEA==
X-Gm-Message-State: ACgBeo3S763dgWeon/UDy3kASHcXY1vz5llqUV+jpdl3M8D5SaN3Hw/i
        PH7q4+MOXnECDRZMVD/Fq2oYQzjI30g=
X-Google-Smtp-Source: AA6agR4jrG2Rsxb8bdytfbnJVpz9lhRLQkDq5odcW/dcibQZuGvFdSeJ+SutWRxv4BbT6ZGImm628Q==
X-Received: by 2002:a05:600c:3782:b0:3a5:23f5:6bc9 with SMTP id o2-20020a05600c378200b003a523f56bc9mr3821997wmr.174.1660174477756;
        Wed, 10 Aug 2022 16:34:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay29-20020a05600c1e1d00b003a3170a7af9sm4123413wmb.4.2022.08.10.16.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:34:37 -0700 (PDT)
Message-Id: <22ee8ea5a1e04a42ad359be4eb5ebc96bd5e5fa2.1660174473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
        <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 23:34:25 +0000
Subject: [PATCH v3 03/11] scalar-diagnose: add directory to archiver more
 gently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

If a directory added to the 'scalar diagnose' archiver does not exist, warn
and return 0 from 'add_directory_to_archiver()' rather than failing with a
fatal error. This handles a failure edge case where the '.git/logs' has not
yet been created when running 'scalar diagnose', but extends to any
situation where a directory may be missing in the '.git' dir.

Now, when a directory is missing a warning is captured in the diagnostic
logs. This provides a user with more complete information than if 'scalar
diagnose' simply failed with an error.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 04046452284..b9092f0b612 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -266,14 +266,20 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
 					  const char *path, int recurse)
 {
 	int at_root = !*path;
-	DIR *dir = opendir(at_root ? "." : path);
+	DIR *dir;
 	struct dirent *e;
 	struct strbuf buf = STRBUF_INIT;
 	size_t len;
 	int res = 0;
 
-	if (!dir)
+	dir = opendir(at_root ? "." : path);
+	if (!dir) {
+		if (errno == ENOENT) {
+			warning(_("could not archive missing directory '%s'"), path);
+			return 0;
+		}
 		return error_errno(_("could not open directory '%s'"), path);
+	}
 
 	if (!at_root)
 		strbuf_addf(&buf, "%s/", path);
-- 
gitgitgadget

