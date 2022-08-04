Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB19C19F29
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 01:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbiHDBqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 21:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbiHDBp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 21:45:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850DD5D0E1
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 18:45:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b6so9580497wmq.5
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 18:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=327gbsyYeccEL0tlq4IQ1Y7CXUns6oBUTnyfqIVz7cI=;
        b=LtgMc0ALSrwvDt1Gs6Xb82T+sdU6OGRi9MogN+ynkg9KpFYUkdTIKeuCUFeCNQfsB8
         lAt24idI860C3pw4IBVA0KKo0oLZJC2lrOxJeJF3NvK9sQIOkVXi0fdxqZg61mRcfpmd
         0IyMNGXdGXJhBXVks+bctlpR+ILB1KgwSHw+A5Ze06fuXopCcrOW3mMlXk9h0ouxHrZx
         SRVkluLDxcmiKf6Ue4ra4swPu51v3Z7iTSeiNvZ4MuOJAtAUjiDLmRsGeiu/tgSzKkJR
         FCYv8MGomrSBlIEh3wLzKO0xiznQEgOmfKpVJVpid0Q1O+Q3Om3EtZ73t8/gF1CSd8bC
         hAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=327gbsyYeccEL0tlq4IQ1Y7CXUns6oBUTnyfqIVz7cI=;
        b=KtjhlDTQWcxoo5pv3Tcrk69tGHt0Vjm5EjhVmo0WSrkO+yw5NdgYyKBkvpn2B+taJ9
         qSHd3Be6UOe5xcwuEfncaF320bQbAGY/9MLL042SPY3S0c4a2TnOsXXH0th+atFLsuO9
         HHMfUY9FPdlR+JmnFM7qjKIt6CIfySv3Hey5WNl5U/dOLa1L81WOHV1dWxWtJpNHRlC3
         ZKqDcl0sQ21ttGA7jdwZNfuMuK94jj2FhiO++IjtqbXruZQWTR0q7eOi7eH7dL6V16lZ
         vjlAzQBRknMutQ3ZD+9n93fdtYfT05P729dJgQKzLPZXXGYhPGxnYO7wm13LNnOwVX/Z
         VmMw==
X-Gm-Message-State: ACgBeo2y19BYk9FZSjqN68kRkYd4T/BH8iSgs3jhykBIF4aNSNgi7OrW
        dRGdubqt1WsfGdVEBHBIZhxnCnaHlRQ=
X-Google-Smtp-Source: AA6agR62FEhj2spJb85z3xnnr7lYcY0JILTZtfIro5iAT2YIyBZw4gNwOHMm0sBM95VnaXhp6ZvTAQ==
X-Received: by 2002:a1c:4c0f:0:b0:3a3:1401:7660 with SMTP id z15-20020a1c4c0f000000b003a314017660mr4508876wmf.8.1659577553252;
        Wed, 03 Aug 2022 18:45:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b003a2d6c623f3sm4379086wms.19.2022.08.03.18.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 18:45:52 -0700 (PDT)
Message-Id: <23349bfaf8fc5f5001f1ed1fa19e9b3909466ae3.1659577543.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 01:45:36 +0000
Subject: [PATCH v2 03/10] scalar-diagnose: add directory to archiver more
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

