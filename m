Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB04ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiHaQDW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiHaQCu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:02:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB2BC993B
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v16so16153553wrm.8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=34CmBf8CuIsfMqN+5OEJmvDj0KavnYpIi3zcg1sxGUQ=;
        b=PNp7N6NC7uMyOB3lwQVghKdaA9V+7zdTbJ+NbWqbk/0Kt8A31Q+KC4IXW6lATZKPfp
         mt6iK/3NR/n+55CQJVaysJjNJiD4ifyVYGh5hOv90/wZ0q7ic0GgJzOPSz9znYBXnCnZ
         BQsO/D8JtQiJzjni+3QCiAQeciz4P7AMVGf/jhg/xVh0wsfhT0qerq15vI+g4WMBSRgX
         pm0fMzLKI0h2+m7xgkCjFueQUB8AUZc0ONt8goWkkWsOtEwN2JNjGtqU8FZCXqQd6Eln
         LYgfTau9KK9r5UkL6Jg7OT8v1CGDup/9+LqgMMIOZfi5CiwRSbxQZS9rM80cKkX4ErST
         179w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=34CmBf8CuIsfMqN+5OEJmvDj0KavnYpIi3zcg1sxGUQ=;
        b=4FaqrCNEtr7B1XJBUafWLNK336CK7bRJeBIoZ9JjSxzyFFvrQMQOqE1g8obROLuc33
         8Up/F+m6oTjjyJdDHvSfFMAXJd4ql5EXhxo5uT1odxdfB68+4trTUQ3+83jTQDOjngxV
         qR3EdTRIuqHJip+eB75+Srs80LXdkKQGdym1Q+PC10NKIpoqs5ufA2mfwjtOSwIbljjK
         S9XAG7M9HNGS83Il6EEfm8POJEdpVc++0fTdZlddHodCLIHDzsAFJ+6JeeQ+vX1WxDvF
         YQ0DhlNJ64V86oCrU/jLYF7pw4WbSLrCLJBKNE3Hie9PTFGB4uIn1C04MA0+6rX14DYi
         ZApw==
X-Gm-Message-State: ACgBeo0ucizjnaHJhnZbzd9qAn0I4ajH62J+GkF/1wR8WVCC7Flm+dlD
        PaPLmMkvmYEnz7jm4IJSECXjvCcaWns=
X-Google-Smtp-Source: AA6agR5YnlnLxgsmMP5fDd6xaM1R8jCE+nJpsaZh6NR6El8OosAvUg0s1hchJHPFB1V2dm2T2KPaHQ==
X-Received: by 2002:a05:6000:1885:b0:226:dcaa:f00e with SMTP id a5-20020a056000188500b00226dcaaf00emr7627567wri.154.1661961762484;
        Wed, 31 Aug 2022 09:02:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8-20020a1c5448000000b003a63a3b55c3sm2939579wmi.14.2022.08.31.09.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:02:41 -0700 (PDT)
Message-Id: <969160650aa08f0cb6ef03cbdd3324f640a20a4e.1661961746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 16:02:20 +0000
Subject: [PATCH 3/8] git help: special-case `scalar`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With this commit, `git help scalar` will open the appropriate manual
or HTML page (instead of looking for `gitscalar`).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/help.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/help.c b/builtin/help.c
index 09ac4289f13..6f2796f211e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -440,6 +440,8 @@ static const char *cmd_to_page(const char *git_cmd)
 		return git_cmd;
 	else if (is_git_command(git_cmd))
 		return xstrfmt("git-%s", git_cmd);
+	else if (!strcmp("scalar", git_cmd))
+		return xstrdup(git_cmd);
 	else
 		return xstrfmt("git%s", git_cmd);
 }
-- 
gitgitgadget

