Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189F9C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 21:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347122AbiHRVlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347083AbiHRVlC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 17:41:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7A3BD745
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:41:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k17so1459144wmr.2
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=hpH7rRcpB5r5+82dVfRT2fIzHmCKUiujRgzjMBEYDl4=;
        b=Dt0PxXgWnD9fZ7r+c/21MxnSte6wewHrpmY9YtgjJlBlFca+eXttmzkFN+hxXP1DeN
         CoXyRcX/1up6aQh3SZ0ofUWDbOhLpicbI3tGh7gJXc89RiQNB3FnrkJ0HAQqW7sSkIls
         72MGc/ENVvopJ4QnFUEYOXqnbdnWRHT2N0pZtym3duDpXrOF6HrEhMMo8IZZcLsfJfEw
         xGyEKbWeIdHJDOvPCxBCSB4Ta3TsoTtgQZVPAuJ50zg+Bn0COP1JcudVocn3Vk81cAqe
         fDbhiKL7ZSJRRBEgdBt0dXb8/zS1PL9y99LnOO6G7rRWY8jS87eQPNfIQGDcBC6k5WlV
         qpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=hpH7rRcpB5r5+82dVfRT2fIzHmCKUiujRgzjMBEYDl4=;
        b=nMRh7cVP/qO+bCkzUTaCO+x6C5/73puFAVU0ME2OoDlfMEC6x259DgfRrDgViHyHdc
         eAWDn+lslY+x2Ltc1zFo0g3McQWkr7+wdFGOCEJZBD0O4MyycBJT98foYtRz/5QDjd0Y
         JE+u6XjLC59LhZKiomLYvA8ygmVlCy2W+lmvpmc4H/QBlIQjfZ68kcqRRqRirLxnzNxb
         UPRhHL1gR83phagFe24it8R/eg1OkNtoRkv1z85ccKc/FB8tOrIaO78afppkiObhI8th
         qYZ2UAmyhJColbA6K6L38IN9RMe4yOkofnQAv8O9rYesBgGmhyXuLngny+E7AonJXFOu
         XBVQ==
X-Gm-Message-State: ACgBeo0SAdJm7bSA6/glJ9lvhdERecQ2yKqcFRhJ0chVX5TdTk+mgD7p
        hPVNsQ5j3fH2cF7/SRDYH/LS9NZxAhc=
X-Google-Smtp-Source: AA6agR7qJWfv6cQdstLayM27+aKl/0IMpKBQPZaHi2Xa3tj+tLd9kZxz/whBAY8X3LKI61vM+zCK+A==
X-Received: by 2002:a7b:c5c3:0:b0:3a6:14f3:8ea7 with SMTP id n3-20020a7bc5c3000000b003a614f38ea7mr2899524wmk.76.1660858859943;
        Thu, 18 Aug 2022 14:40:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d44cd000000b00222ed7ea203sm2302217wrr.100.2022.08.18.14.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:40:59 -0700 (PDT)
Message-Id: <f8471e94e830b199a7045a0b2f508cac8a4b559d.1660858853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
References: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
        <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 21:40:50 +0000
Subject: [PATCH v3 5/8] scalar: move config setting logic into its own
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Create function 'set_scalar_config()' to contain the logic used in setting
Scalar-defined Git config settings, including how to handle reconfiguring &
overwriting existing values. This function allows future patches to set
config values in parts of 'scalar.c' other than 'set_recommended_config()'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 44 ++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 6de4d5b3721..836a4c48fab 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -85,13 +85,33 @@ static int run_git(const char *arg, ...)
 	return res;
 }
 
+struct scalar_config {
+	const char *key;
+	const char *value;
+	int overwrite_on_reconfigure;
+};
+
+static int set_scalar_config(const struct scalar_config *config, int reconfigure)
+{
+	char *value = NULL;
+	int res;
+
+	if ((reconfigure && config->overwrite_on_reconfigure) ||
+	    git_config_get_string(config->key, &value)) {
+		trace2_data_string("scalar", the_repository, config->key, "created");
+		res = git_config_set_gently(config->key, config->value);
+	} else {
+		trace2_data_string("scalar", the_repository, config->key, "exists");
+		res = 0;
+	}
+
+	free(value);
+	return res;
+}
+
 static int set_recommended_config(int reconfigure)
 {
-	struct {
-		const char *key;
-		const char *value;
-		int overwrite_on_reconfigure;
-	} config[] = {
+	struct scalar_config config[] = {
 		/* Required */
 		{ "am.keepCR", "true", 1 },
 		{ "core.FSCache", "true", 1 },
@@ -145,17 +165,9 @@ static int set_recommended_config(int reconfigure)
 	char *value;
 
 	for (i = 0; config[i].key; i++) {
-		if ((reconfigure && config[i].overwrite_on_reconfigure) ||
-		    git_config_get_string(config[i].key, &value)) {
-			trace2_data_string("scalar", the_repository, config[i].key, "created");
-			if (git_config_set_gently(config[i].key,
-						  config[i].value) < 0)
-				return error(_("could not configure %s=%s"),
-					     config[i].key, config[i].value);
-		} else {
-			trace2_data_string("scalar", the_repository, config[i].key, "exists");
-			free(value);
-		}
+		if (set_scalar_config(config + i, reconfigure))
+			return error(_("could not configure %s=%s"),
+				     config[i].key, config[i].value);
 	}
 
 	/*
-- 
gitgitgadget

