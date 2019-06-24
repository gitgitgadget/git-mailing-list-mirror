Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EA261F461
	for <e@80x24.org>; Mon, 24 Jun 2019 15:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbfFXPlh (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 11:41:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36066 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFXPlh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 11:41:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so13871747wmm.1
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JmNyTYV4FZeJlng2NBS0O59vquDDdAmj1TXUhWoIz+o=;
        b=nEAuSpGEeEq9hoELhFAI+NoWfLbiMNKnp1T4rwZ212rirryMrQCRO16vRX2aaqeAek
         P7762BurpCyHijI0n/OFDZk5kPFKnpglcUaWYO+i6RSAav0GPz+g1UZjVTb0NJaGXqAg
         22iCm1esDAPXOK6k1/I9vmyEJ88mlV7GxoBCRrQ3pfzsS1hpJvDL/3E0qpqEbrSG3E6S
         1W7HzGLFaMX+zWGyezNicLX08MiJ+w9EmW4KErnzBpAz1YOHtd/ZjhSsYoKTg2UNI+7z
         iODdU0NiJKf8KDZUO1dWZvDnGt++SmcH0ropnzgisJNz9TIsDJr9qrbu2GOpabTt0ci2
         blJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JmNyTYV4FZeJlng2NBS0O59vquDDdAmj1TXUhWoIz+o=;
        b=kSTixi1GqzT5JuNVg6XxQlERnrUvCUKKmGMlFaUbyB1rrdagMUhDMf5+mtQn13Wb+h
         aqABuUKU8GgmJ4Csgt0g24v8ZFc/FZnAEaOtr0TjkS9mGyEWOd7SKOcIMxdpa2NbXS/S
         K/sfdB/KuQRMh3OYaxxs0qzJ1RyAFbWOD6XvI3a5oP/vz50NpEcYiBvCL70zqQfBtl0D
         Pl3PnG/yNg+ntchyzOhf+j17AeaJVWhZfwCuq5eozk8gLuFBUR+ZcO2+zImTE14asavE
         Zyu/qHYxVTgRm/yXZIJmApvYPOZ764DTSsO2b4q4xW+8d9fMN2IbVRE0eISaL35eax9N
         6GLA==
X-Gm-Message-State: APjAAAUQkPtaqTP3VkXDC9/WBdYzlnU3mUTIh7S+qE48OVHKburrCfJy
        ePW9EFH6LTMy9tZToVZ1hWo=
X-Google-Smtp-Source: APXvYqx885RbmqWlrQkNQVhRKH31JS52Wan7RkVDlBZqfdRjksLfCvw/zF3whwdWIaafMi0WCoUn5A==
X-Received: by 2002:a7b:c774:: with SMTP id x20mr16311822wmk.30.1561390894738;
        Mon, 24 Jun 2019 08:41:34 -0700 (PDT)
Received: from linux-16.fritz.box (2a0a-a542-2a07-0-a793-8424-e1d1-435c.ipv6dyn.netcologne.de. [2a0a:a542:2a07:0:a793:8424:e1d1:435c])
        by smtp.gmail.com with ESMTPSA id z5sm9647460wma.36.2019.06.24.08.41.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 08:41:34 -0700 (PDT)
From:   Morian Sonnet <moriansonnet@gmail.com>
X-Google-Original-From: Morian Sonnet <MorianSonnet@googlemail.com>
Received: from linux-16.fritz.box (localhost [127.0.0.1])
        by linux-16.fritz.box (8.15.2/8.15.2) with ESMTPS id x5OFfXdQ010232
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 17:41:33 +0200
Received: (from momo@localhost)
        by linux-16.fritz.box (8.15.2/8.15.2/Submit) id x5OFfXhF010231;
        Mon, 24 Jun 2019 17:41:33 +0200
To:     johannes.schindelin@gmx.de
Cc:     MorianSonnet@googlemail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, gitster@pobox.com, moriansonnet@gmail.com,
        sunshine@sunshineco.us, Morian Sonnet <moriansonnet@googlemail.com>
Subject: [PATCH] submodule foreach: fix recursion of options
Date:   Mon, 24 Jun 2019 17:40:51 +0200
Message-Id: <20190624154050.9943-2-MorianSonnet@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <nycvar.QRO.7.76.6.1906241241080.44@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1906241241080.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calling

    git submodule foreach --recursive <subcommand> --<option>

leads to an error stating that the option --<option> is unknown to
submodule--helper. That is of course only, when <option> is not a valid
option for git submodule foreach.

The reason for this is, that above call is internally translated into a
call to submodule--helper:

    git submodule--helper foreach --recursive \
        -- <subcommand> --<option>

This call starts by executing the subcommand with its option inside the
first first level submodule and continues by calling the next iteration
of the submodule foreach call

    git --super-prefix <submodulepath> submodule--helper \
      foreach --recursive <subcommand> --<option>

inside the first level submodule. Note that the double dash in front of
the subcommand is missing.

This problem starts to arise only recently, as the
PARSE_OPT_KEEP_UNKNOWN flag for the argument parsing of git submodule
foreach was removed in commit a282f5a906. Hence, the unknown option is
complained about now, as the argument parsing is not properly ended by
the double dash.

This commit fixes the problem by adding the double dash in front of the
subcommand during the recursion.

Signed-off-by: Morian Sonnet <moriansonnet@googlemail.com>
---
 builtin/submodule--helper.c  | 1 +
 t/t7407-submodule-foreach.sh | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0bf4aa088e..afaf0819c9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -540,6 +540,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		if (info->quiet)
 			argv_array_push(&cpr.args, "--quiet");
 
+		argv_array_push(&cpr.args, "--");
 		argv_array_pushv(&cpr.args, info->argv);
 
 		if (run_command(&cpr))
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 706ae762e0..ade6672820 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -421,4 +421,11 @@ test_expect_success 'option-like arguments passed to foreach commands are not lo
 	test_cmp expected actual
 '
 
+test_expect_success 'option-like arguments passed to foreach recurse correctly' '
+  git -C super submodule foreach --recursive "echo be --an-option" > expected &&
+  git -C super submodule foreach --recursive echo be --an-option > actual &&
+  grep -e "--an-option" expected &&
+  test_cmp expected actual
+'
+
 test_done
-- 
2.20.1

