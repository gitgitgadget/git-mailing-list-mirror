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
	by dcvr.yhbt.net (Postfix) with ESMTP id 81C8F1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 15:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfFXPtn (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 11:49:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41946 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfFXPtn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 11:49:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so14454570wrm.8
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXtesWMQ5paeBTJBzDg9MELq6WuxZ+W7XIFF1TR0nsc=;
        b=SXcvVfriZaTrokG/RUBWABLonq2OOR2jneFY5NLKU731KJ8EWSIVN+Jg6l9Y+5oe8z
         IAZqAZ2VI4b0w0g2aBp94rFkaEv+OhpuJKeL7HQZAGYH7twRszJ+MRQeUPz2stLFF96Z
         e6EnzU2wqIZcK7T6c1v32+5AbahlHXhiKqNERjFqrhANE7C520tIOJAfBJ+TYbHLn0/A
         5oWqD9Ne2lsp+SslEswvD1VnvBrEN7MPM4lKiPBCUQG46GQheUDnCwtR2xwLom8wF333
         jwevZOKnsgBSsi2op75ix0Bbj9T61cMsLMGn4zWmzv9gAmLFKCN4rtwuu5VpVLnJfawS
         0xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXtesWMQ5paeBTJBzDg9MELq6WuxZ+W7XIFF1TR0nsc=;
        b=E7t4u+DdQU9OSfT3NHmwxPzLXkAv2MvwGxQC3C01wzqBccmO/tFhXkJHiaM9NXjvKG
         8BrnGiP5Zqq4qDTu6bgkpjkVDNifdu8hm4GOPaMSAXJBkpYt0SUiCTEWkdlODpdImUqQ
         giDFc+mfE7U43KGUU2376JK6d2/MBziQIkHDCtcITpQvIlQRBA+XsIASZV84zhyTMCpl
         4WWQiS9f/P+iGAVhDBeu028sjRdmcCuuHlNMIo2j8G8kg6FA228Y+hKtYJLIzbUD+LAm
         a5We/3EVhwEvo26+abauE9nG/pCG9Oybb3yeETLHLRDt9dfId0vvMoQ7XAV7RTDKvnvC
         JHzw==
X-Gm-Message-State: APjAAAXG00H8jPIUTXvO456H0dErseFCld5dhTpTyMg/TnsnIIt6Ler2
        vUz+08AHkAQWqcVvSBudpZA=
X-Google-Smtp-Source: APXvYqzO2RnRHXe3wDARipEia8lvPzl3+8d/3S+SQdaZpgO4j/l/bPMH9mzUv9ruCdiksh45IPQ7pA==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr33144079wrp.133.1561391381061;
        Mon, 24 Jun 2019 08:49:41 -0700 (PDT)
Received: from linux-16.fritz.box (2a0a-a542-2a07-0-a793-8424-e1d1-435c.ipv6dyn.netcologne.de. [2a0a:a542:2a07:0:a793:8424:e1d1:435c])
        by smtp.gmail.com with ESMTPSA id z5sm10226986wrh.16.2019.06.24.08.49.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 08:49:40 -0700 (PDT)
From:   Morian Sonnet <moriansonnet@gmail.com>
X-Google-Original-From: Morian Sonnet <MorianSonnet@googlemail.com>
Received: from linux-16.fritz.box (localhost [127.0.0.1])
        by linux-16.fritz.box (8.15.2/8.15.2) with ESMTPS id x5OFnd9o020317
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 17:49:39 +0200
Received: (from momo@localhost)
        by linux-16.fritz.box (8.15.2/8.15.2/Submit) id x5OFndni020316;
        Mon, 24 Jun 2019 17:49:39 +0200
To:     moriansonnet@gmail.com
Cc:     MorianSonnet@googlemail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de, sunshine@sunshineco.us,
        Morian Sonnet <moriansonnet@googlemail.com>
Subject: [PATCH] submodule foreach: fix recursion of options
Date:   Mon, 24 Jun 2019 17:47:52 +0200
Message-Id: <20190624154750.19842-2-MorianSonnet@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624154050.9943-2-MorianSonnet@googlemail.com>
References: <20190624154050.9943-2-MorianSonnet@googlemail.com>
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
index 706ae762e0..43da184d40 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -421,4 +421,11 @@ test_expect_success 'option-like arguments passed to foreach commands are not lo
 	test_cmp expected actual
 '
 
+test_expect_success 'option-like arguments passed to foreach recurse correctly' '
+  git -C clone2 submodule foreach --recursive "echo be --an-option" > expected &&
+  git -C clone2 submodule foreach --recursive echo be --an-option > actual &&
+  grep -e "--an-option" expected &&
+  test_cmp expected actual
+'
+
 test_done
-- 
2.20.1

