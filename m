Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900BFC001B5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 16:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbiIBQFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbiIBQEi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 12:04:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE6165810
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 08:58:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n17so2873556wrm.4
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=b+hSNf9d9LK+B92bNET4jUFRgGR0JVUliICx97zkhh4=;
        b=GBSMcbNFU7qlrXkntsvLTu+5QV/zV2243ze8Frq/PC6tI4N12Yf6oXBuAUC9v6HN8W
         AEtl2nby8QSjpsK+cghGQZD4t7ftSBdiYfcHgabgi6uHBUGfekWobkWn1RQOEh/Rkltv
         MJQ3DQOh+Wz1tCGlPI6JGcHgY3knUZtUA3gCLN2kNz/pHgdhbLJ52HbOx841IxdEiLZ7
         iwQN79jHbwgyHP4X1Otf81BWwnNIRUuIowjQeO69EVVikf9KI7Hfji9g7bKi7/LnFQ6A
         sDmAB40M6SCx38DFP4NVQtY2xJn079c8OoRvtG0RpwyuNjLsIhiG9Cncku6olITOwC5k
         S74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b+hSNf9d9LK+B92bNET4jUFRgGR0JVUliICx97zkhh4=;
        b=oNEjfJKOrkpQQIHV1eG6FWY31vl0453WFLMySRUppKvyoDQ1C7mSPn52KsEIvkRbNB
         skk1RGj2FWNUqFuVYU8ochp7QVn6aPK+5OcdTt8rjF1qzrNYisB3RtpA4GcUkX6fP+tr
         EaPg7VaaM3tKDZHywwbeyKbe/5pWT1apAEMTEh7jS6/50xq3WFdf5ex0L8aAeSvmMKxL
         HR5sbmbPXxrHcVkFYLr9s/AjYzYIl9RqYzbfYnpUOqcoHoKtJDSfPvlOY2LdFw2Ulx+l
         DwvwX9v5KgQH08HcxB2Sgw6OVebm6Ictog/vgem/NUnksYCoaySBrss/yGMnK6hdKUSe
         fp6w==
X-Gm-Message-State: ACgBeo1U3tOYIIkJ6QkcaKQvFLUcHRksRJjtYMDzKSziwga0RNbOPzfW
        C2cV46ydA6V55oaoaEJuzVrGiNFOowM=
X-Google-Smtp-Source: AA6agR5JpaYvxw+SkVoHdNCY+eV5+JwhSK3zXbbntitigMPkIJbltrfgjs32JlcxUxj6D8IcNXwB6A==
X-Received: by 2002:adf:e80e:0:b0:226:d808:667d with SMTP id o14-20020adfe80e000000b00226d808667dmr15140380wrm.282.1662134216831;
        Fri, 02 Sep 2022 08:56:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bk16-20020a0560001d9000b002258235bda3sm1784774wrb.61.2022.09.02.08.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:56:56 -0700 (PDT)
Message-Id: <55aba052c342c7c5e1f8d3b7908f3662a1dcd0dc.1662134210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
        <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 15:56:45 +0000
Subject: [PATCH v2 4/9] scalar: implement the `help` subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is merely handing off to `git help scalar`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 scalar.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scalar.c b/scalar.c
index 642d16124eb..c5c1ce68919 100644
--- a/scalar.c
+++ b/scalar.c
@@ -819,6 +819,25 @@ static int cmd_delete(int argc, const char **argv)
 	return res;
 }
 
+static int cmd_help(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		"scalar help",
+		NULL
+	};
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	if (argc != 0)
+		usage_with_options(usage, options);
+
+	return run_git("help", "scalar", NULL);
+}
+
 static int cmd_version(int argc, const char **argv)
 {
 	int verbose = 0, build_options = 0;
@@ -858,6 +877,7 @@ static struct {
 	{ "run", cmd_run },
 	{ "reconfigure", cmd_reconfigure },
 	{ "delete", cmd_delete },
+	{ "help", cmd_help },
 	{ "version", cmd_version },
 	{ "diagnose", cmd_diagnose },
 	{ NULL, NULL},
-- 
gitgitgadget

