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
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DE01F461
	for <e@80x24.org>; Mon, 24 Jun 2019 20:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfFXU2b (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 16:28:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40323 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfFXU2b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 16:28:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so15280602wre.7
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 13:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EACuPxtGqDR9Z7rFB7iCyR27snCplR3x5iaEudMPCPg=;
        b=sn8oYGWT1Mg/zuZ4UqKB843rJPdbXugsXLG0EuecaReyNUml7PdWxhscDYm4QSHI+h
         tAzMnCodvtWSTqBO9pZCj3sxMG6qZK/4MDzfwq9wq6tSqFVHydv6gyRCpKMkfP5tj4YD
         5+HgCEsqoDGpGTuxHMonu1gnG8pwGDLYp89K82mZ2zesU+5pJmI6KXobXF+cZWjJDGsV
         lGxLSAC1eioFC8S47l+kyabu11XjLIO9uyS4/x25agTxJv5JfeytWjXFNjqOJYzbXLGc
         stpGPltChQKpd+4Wwpnp/3ZleMM1ZF84HYxGOo1FK7+LtIPT/I/+udvVNkvzRTFvdFMF
         emmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EACuPxtGqDR9Z7rFB7iCyR27snCplR3x5iaEudMPCPg=;
        b=WuYLXy3fNKF0Ej4IMGxXaaJou/7MVWY+2DtOpvdG32V5aWXgtnL2AAXYZEjDCIqo0g
         5fAK+lXiEoqJZFMkviWB8T0bFGTf+JoHvTn1qeiufpr0zTatupqJVtLQhgaur2SiKhLk
         PE/USHeCXhmUJpriHlBmUh6nBDLwJVcbBlHAZI0nMBDBanAlqQrbCbMQeFkHO3JHp5vG
         vz0HwI/pF5FAurHik+wKMKsGOTto+ZrO7srw+5kfKh25jpm3WzAZpMU4S4kIdJ5O+tXx
         2Vu2Y7ySXIg0NpQsFJm5jyTx1a3bcCYZdFgEuU1mplpRjNgtQNFItDzvRjsP9MBqV/lF
         PV8g==
X-Gm-Message-State: APjAAAVIcWqHqVB1BvYUVl+qGB1Zo/+a/6k+Tlxxh6/T8oc9qf0M6avZ
        o2MWdkrCUNFk7QK8xBD9xxk=
X-Google-Smtp-Source: APXvYqyrxVxxBbZoEdGkFDgICBY61VuohlVNvLxMHIUwCsl3adjqFde+XZNWT/RLrcjzcntbodQ27w==
X-Received: by 2002:a5d:638e:: with SMTP id p14mr78657608wru.238.1561408108749;
        Mon, 24 Jun 2019 13:28:28 -0700 (PDT)
Received: from linux-16.fritz.box (2a0a-a542-2a07-0-a793-8424-e1d1-435c.ipv6dyn.netcologne.de. [2a0a:a542:2a07:0:a793:8424:e1d1:435c])
        by smtp.gmail.com with ESMTPSA id r5sm25782324wrg.10.2019.06.24.13.28.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 13:28:28 -0700 (PDT)
From:   Morian Sonnet <moriansonnet@gmail.com>
X-Google-Original-From: Morian Sonnet <MorianSonnet@googlemail.com>
Received: from linux-16.fritz.box (localhost [127.0.0.1])
        by linux-16.fritz.box (8.15.2/8.15.2) with ESMTPS id x5OKSRRY014205
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 22:28:27 +0200
Received: (from momo@localhost)
        by linux-16.fritz.box (8.15.2/8.15.2/Submit) id x5OKSRTj014204;
        Mon, 24 Jun 2019 22:28:27 +0200
To:     gitster@pobox.com
Cc:     MorianSonnet@googlemail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, johannes.schindelin@gmx.de,
        moriansonnet@gmail.com, sunshine@sunshineco.us,
        Morian Sonnet <moriansonnet@googlemail.com>
Subject: [PATCH] submodule foreach: fix recursion of options
Date:   Mon, 24 Jun 2019 22:26:55 +0200
Message-Id: <20190624202653.13810-2-MorianSonnet@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqqsgryhmqt.fsf@gitster-ct.c.googlers.com>
References: <xmqqsgryhmqt.fsf@gitster-ct.c.googlers.com>
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
first level submodule and continues by calling the next iteration of
the submodule foreach call

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
index 706ae762e0..6b2aa917e1 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -421,4 +421,11 @@ test_expect_success 'option-like arguments passed to foreach commands are not lo
 	test_cmp expected actual
 '
 
+test_expect_success 'option-like arguments passed to foreach recurse correctly' '
+	git -C clone2 submodule foreach --recursive "echo be --an-option" >expect &&
+	git -C clone2 submodule foreach --recursive echo be --an-option >actual &&
+	grep -e "--an-option" expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.20.1

