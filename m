Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC0931F404
	for <e@80x24.org>; Mon, 15 Jan 2018 11:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755152AbeAOLAb (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 06:00:31 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43549 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755129AbeAOLAa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 06:00:30 -0500
Received: by mail-pg0-f66.google.com with SMTP id n17so239152pgf.10
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 03:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9981EHi6d7jYjUpbE7sh26OG0jZhgsmU/uKwlsQHG4c=;
        b=Vd3aReBf6bMAEPCLDH0HnJEAlTwjfQcRiGxHh5O3KDge1QG1xDjs6JNulxAcSf1IWd
         RqC00Ubc5amiN+ygdpEYcY+rskLYIWksaYu9zCGvs7R3q6YbWdscEDZsPiTVWQzXf5TT
         tnatYiwITxqhYNa3TNq2YMjSkSZrFEaKrSd8rUB2CxSs0xVJS2CUljoNYDrgCCBhzcFM
         pDLNZL+bnMDNIJBNu27nsy7pXW3BKjfnU4uEBC6DbpmR8RZm6TNqqX5E395QmNHLxTkR
         7NBWVOChZ+mraHpGFhe8AtYoMiUhmkCWOGJQeV6x5m30O4u9uBVex9qf7dVcPQhqMLSR
         AWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9981EHi6d7jYjUpbE7sh26OG0jZhgsmU/uKwlsQHG4c=;
        b=o5UUbcXU05U2vDBgC6Lw0Z3fb2cT7smZgoX+Z2A/2EyJnqIrruKzBWcxQ7qZtPfOfR
         FTdUMP1E8dLtDJN1bAAqIJWBg359V6ArEEvQSQA6uMoquzO+emVYfH+m/APA27Wn7yF0
         g5TVmk+Za9g+5E30CjIpSvu9xmfvgd1Cm4xUtQTacLiNrO00pcpjxGidCOJE39e0F4hF
         kTKSbCSmmYElh7NzNiw9l5wm2LYltRqCxk8r7bXSf/JeEbFKoGS3W5aH1F5WWVcN7cGY
         k21xMAyPy0etqAGeJcTAITLOV6+PMOXJz4DnyXQIWsjVyIxDSZDkyWDJeBTBuuViqTQW
         SsxQ==
X-Gm-Message-State: AKGB3mJZtFMZJcCdPJZSjK1im2rwEeZJKy9g/bTy+/N/YpX/RSM7EVgR
        Q/+Jxx0zHlQWWS/iVBC2U7gluQ==
X-Google-Smtp-Source: ACJfBotM85Coc7OAEmqcgda4F7H6ZQjQ3tP/EJKZW4ReRiaNr3o5jexYULZ252qpgw8SMnMgwwsbWQ==
X-Received: by 10.99.152.26 with SMTP id q26mr26111905pgd.74.1516014030202;
        Mon, 15 Jan 2018 03:00:30 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id s14sm55624876pfa.158.2018.01.15.03.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jan 2018 03:00:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 15 Jan 2018 18:00:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 5/7] trace.c: print program 'git' when child_process.git_cmd is set
Date:   Mon, 15 Jan 2018 17:59:47 +0700
Message-Id: <20180115105949.18328-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180115105949.18328-1-pclouds@gmail.com>
References: <20180113064949.6043-1-pclouds@gmail.com>
 <20180115105949.18328-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We normally print full command line, including the program and its
argument. When git_cmd is set, we have a special code path to run the
right "git" program and child_process.argv[0] will not contain the
program name anymore. As a result, we print just the command
arguments.

I thought it was a regression when the code was refactored and git_cmd
added, but apparently it's not. git_cmd mode was introduced before
tracing was added in 8852f5d704 (run_command(): respect GIT_TRACE -
2008-07-07) so it's more like an oversight in 8852f5d704.

Fix it, print the program name "git" in git_cmd mode. It's nice to have
now. But it will be more important later when we start to print env
variables too, in shell syntax. The lack of a program name would look
confusing then.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/trace.c b/trace.c
index da3db301e7..98bee2c259 100644
--- a/trace.c
+++ b/trace.c
@@ -286,6 +286,9 @@ void trace_run_command(const struct child_process *cp)
 
 	strbuf_addf(&buf, "trace: run_command:");
 
+	if (cp->git_cmd)
+		strbuf_addstr(&buf, " git");
+
 	sq_quote_argv_pretty(&buf, cp->argv);
 	print_trace_line(&trace_default_key, &buf);
 	strbuf_release(&buf);
-- 
2.15.1.600.g899a5f85c6

