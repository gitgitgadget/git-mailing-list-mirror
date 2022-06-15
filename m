Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21D4C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 23:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355176AbiFOXgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352214AbiFOXgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 19:36:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6261FA4E
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:36:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a15so17279755wrh.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nnd6xL32hUge5nGiU/0P2C+0HjczE0+v6Q2+Ox5siBs=;
        b=LKF9v/cFlsd68TYQYwpLvHl0l+Qz+4Gk4ZMX31GXnTDgPcRUYLGwzZ2QmrdT29QPtl
         DR8m3sylwY8IGnTjl8b5tfdkolT1kC/sbc9yntfsUYdEpSyv2SlQjyiDY1cJLDQRVFpz
         Nd3hXg/Vtn6ZmvMKguhC96/EMi45N+tYximtzEc/jv8bW4dqilzK3gTl0khwlsCwlOxH
         8Dcg8+LjXkbaXZp9dTx6ohjYq0/pcuv2fkBM/VVNae71OYtFZJT9IH2peLvAjul86qgf
         1LSrc5lQxe0/H50UXLziGt8KrPspj+YcRmV4nwqzFKZ/etKRL9In+SLn9qdCFWaSsUjO
         mFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nnd6xL32hUge5nGiU/0P2C+0HjczE0+v6Q2+Ox5siBs=;
        b=PGZ+jRltHMHto6S6V95UO0rW+FeK1PzRq3OxhB98bneEYBev+XaVdo7ZVFtvoZHXjV
         Lh0xCozl5m8oQr0LD3JmDx+aYM5bL9T9Jj17IWePJiQ6Y5Z/bTIMwWsxvci7XMI2whze
         cOxamGvabiS0u13c1wbC78COVrxcCxFQq803eQmgV8ZKT/R1f2UKQTM4tUCFuNFy4FpG
         7HQiqiwHH53CokTssTLim1o+gWKOoXkQTwW1eHwSaTlFA3J6KciOAgD5Ysf4tNEuU9uT
         V/FIpMfUvoH2LjvdIZRwiWbmKPKxA2RGu/6KDlKO6ZIIroKzNuROgDPbrXp1PtSE0OPJ
         M8dA==
X-Gm-Message-State: AJIora9ABnV5AZQm7qUrJmdw2xLRrLinz4kDarC1Mb0jjM3JNgnFSDDQ
        qBHp9Xts2pnhtGze9cXS636KsfM1yJhI6w==
X-Google-Smtp-Source: AGRyM1tXibuzsTVL/k+0GuegWxA0ZpyzZ2/Z3oFdvgrd4b6FaRJg/4d2KO0WezNb3uXq3LojnznpNA==
X-Received: by 2002:a5d:4fc9:0:b0:213:aac9:33b3 with SMTP id h9-20020a5d4fc9000000b00213aac933b3mr1968887wrw.443.1655336159379;
        Wed, 15 Jun 2022 16:35:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d6412000000b002117f872f81sm194091wru.113.2022.06.15.16.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:35:58 -0700 (PDT)
Message-Id: <ad3f23a9f0c2c92ac95406fcadc51eec1a9861ff.1655336146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 23:35:41 +0000
Subject: [PATCH 07/11] submodule--helper: avoid memory leak when fetching
 submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In c51f8f94e5b3 (submodule--helper: run update procedures from C,
2021-08-24), we added code that first obtains the default remote, and
then adds that to a `strvec`.

However, we never released the default remote's memory.

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/submodule--helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d7b8004b933..9a8248ffe6a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2208,6 +2208,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 		char *hex = oid_to_hex(oid);
 		char *remote = get_default_remote();
 		strvec_pushl(&cp.args, remote, hex, NULL);
+		free(remote);
 	}
 
 	return run_command(&cp);
-- 
gitgitgadget

