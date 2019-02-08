Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533781F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfBHJFO (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:05:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38044 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfBHJFO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:05:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so1310636pgc.5
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GcUiZOdhoSE8sK7+QoWdt7EP1WS43Vx11R6TAE78phU=;
        b=A9S6Fg01G65U84rOb5VSVyJ/hFkj0AAZI2RSQgF7np2Emh32KHaXx37fTzElSpMHr2
         GasOhCIb8t82J0SRlM/vVAQgLTiwiUQDnR+i75sGKmcuh07MiX61ZpT6dvMLX4P5A1Cv
         zTqWh176NLm7QTU/zlOmQDKpDfyIliHuQSbN+9SUUEQ2wPYNbK+yxTPHesNRQKfXYpW4
         k+sPJomweolezJyxjKbS+V9qJirXnS8omPSsr6cX70buxHyWmq375XJrEnG17o9HBPWW
         lsuyiGjEq8osx042s6AvG0Nzb2OwNdZOOFDpIL7/28x/TO2YdHMXUvidMrABbz4znDRk
         283w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GcUiZOdhoSE8sK7+QoWdt7EP1WS43Vx11R6TAE78phU=;
        b=pwbktzp8o/fl87Oo1bU6TObcq73uuOHtRQrKWqer82kmwd3qEM8vjJXNduuFlYyEop
         POM+HzzP4XlaIyMKOeAjFDz0bWYKD+P7snz/qd00ip/JRB9i9DS0OfCyaINb+rJP58fB
         nRaazJxllHHWaS8UDuGPSsb78I0c0XOu7T1H316SHQtcBypDe2mIORUde/AWRh1ugV17
         6FLbwph0phAYXHr7/AVc11Hf2ZjtXtGmZhJ+zNLa0M7BgRmBvm8/agjuJIIfv4jBqnqs
         ZqVNlhuDSY8vtNfhoJtripu1Mtqat2BWDTx9YY5t/CecfnPzOApbpVYXDVea4zaKagAr
         RfFQ==
X-Gm-Message-State: AHQUAubQYLhSMpEDg7dMujvPqMQCSScuYn5seh1MmnClTfTl+12IrdNE
        A3hLiZ13NP1dT2jylD8eoXSRm3M5
X-Google-Smtp-Source: AHgI3IYm/IugN7kkK+fAUqZMR8aIDtLwXfUQcMZrscFxnkoyDyoccs+kmpqN1L7ruXS1m6So3mcQpA==
X-Received: by 2002:a63:4808:: with SMTP id v8mr4554340pga.236.1549616713282;
        Fri, 08 Feb 2019 01:05:13 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id j9sm1922600pfi.86.2019.02.08.01.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:05:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:05:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/19] switch: better names for -b and -B
Date:   Fri,  8 Feb 2019 16:03:51 +0700
Message-Id: <20190208090401.14793-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shortcut of these options do not make much sense when used with
switch. And their descriptions are also tied to checkout
out. Move -b/-B to cmd_checkout() and new -c/-C with the same
functionality in cmd_switch_branch()

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2ac53b4302..f6de232922 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1353,14 +1353,10 @@ static struct option *add_common_options(struct checkout_opts *opts,
 	return newopts;
 }
 
-static struct option *add_switch_branch_options(struct checkout_opts *opts,
-						struct option *prevopts)
+static struct option *add_common_switch_branch_options(
+	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_STRING('b', NULL, &opts->new_branch, N_("branch"),
-			   N_("create and checkout a new branch")),
-		OPT_STRING('B', NULL, &opts->new_branch_force, N_("branch"),
-			   N_("create/reset and checkout a branch")),
 		OPT_BOOL('l', NULL, &opts->new_branch_log, N_("create reflog for new branch")),
 		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
@@ -1556,15 +1552,22 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
-	struct option *options = NULL;
+	struct option *options;
+	struct option checkout_options[] = {
+		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
+			   N_("create and checkout a new branch")),
+		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
+			   N_("create/reset and checkout a branch")),
+		OPT_END()
+	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
 
-	options = parse_options_dup(options);
+	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
-	options = add_switch_branch_options(&opts, options);
+	options = add_common_switch_branch_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
@@ -1577,14 +1580,21 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
 	struct option *options = NULL;
+	struct option switch_options[] = {
+		OPT_STRING('c', "create", &opts.new_branch, N_("branch"),
+			   N_("create and switch to a new branch")),
+		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
+			   N_("create/reset and switch to a branch")),
+		OPT_END()
+	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
 
-	options = parse_options_dup(options);
+	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-	options = add_switch_branch_options(&opts, options);
+	options = add_common_switch_branch_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
 			    options, switch_branch_usage);
-- 
2.20.1.682.gd5861c6d90

