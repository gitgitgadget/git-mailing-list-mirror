Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643C41F404
	for <e@80x24.org>; Fri, 12 Jan 2018 09:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932723AbeALJ5G (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 04:57:06 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44755 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754403AbeALJ5F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 04:57:05 -0500
Received: by mail-pf0-f193.google.com with SMTP id m26so4050462pfj.11
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 01:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NFMS1gURptECiTln2HHlypFMMuLjPftUJ5Yn5SqK4OY=;
        b=T2wdqGAykbkDRn22maatDKk4YNhjspAVDxdw3g0cMKvxRDVgtZVnFFQxnklYb2sLqc
         lzMgMfSyM37W638590i1jfyKa+On2aHSl5o8LVfPZWnyFZmEyaxW0G6XrhRznkkoeXSW
         c7S3/k5Csq47wRIXqWU+sUnbA8tmuF6INX5WcqQbWtTDlzVbxurOv4OaCiimmfXEPFs2
         nXdxalzjjfsiDuV7fzX/qv/Gm7g8fwL6ii00Ta6QLQQRQyMG8niv6z2kZayIFGNL/LEG
         38wOZ1HYoXU/VsEkP8hB1ZswCkLC788q5MlGR8h6jTAzOtfrujakw50vdqeXwJJKjhXs
         DXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NFMS1gURptECiTln2HHlypFMMuLjPftUJ5Yn5SqK4OY=;
        b=jAJUqbekFr/KkGHfKwXzKIo5LRf17f4Fe31yblaQC1a7/i5whmp31ODL1Rk376lNnb
         dLq2cJ6kFEYLW7grpMWzW9EyvkDFRrfBchZIIcNW8+eCp7hVUEfjUshGw9SOld+sQczG
         zNOE6DaCeWa6JeqxicdJ+TMDMseui6cz9BEtUExbuaTWoetSmecB4AuwvLLOEMvdPs/5
         7a78x0TySDmTO52eiWys1FFOsUcX+v1SdrwYHYeOWTRXXN8yggFulPRgRjUYko4F7ISZ
         T7aarGIR7cJFBwBFBHVcdRPu9NnN1aFLPF5jhcQrwtc7sB9LToxW2+cSpOr6vLYbz5If
         ninQ==
X-Gm-Message-State: AKGB3mJpIPXAeICxoDbJzBwrTR6Vd2TJF+snfjcbSb0DQ6RahtyKOjZ9
        ItRBb7XfFitRXDObsdRgOxz2jg==
X-Google-Smtp-Source: ACJfBovxrbHP9QHXDsI2Jv7gAknSCq2X5lsc+MrH2iHaHTHsN1Dp4lm2k/l7cwdFQYEViRKKjGEh2Q==
X-Received: by 10.159.252.197 with SMTP id o5mr14914206pls.67.1515751024519;
        Fri, 12 Jan 2018 01:57:04 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id g2sm23481269pfh.62.2018.01.12.01.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 01:57:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 12 Jan 2018 16:56:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 2/4] trace.c: print program 'git' when child_process.git_cmd is set
Date:   Fri, 12 Jan 2018 16:56:05 +0700
Message-Id: <20180112095607.18293-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180112095607.18293-1-pclouds@gmail.com>
References: <20180111094712.2551-1-pclouds@gmail.com>
 <20180112095607.18293-1-pclouds@gmail.com>
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
index f08c673b51..ed1f728021 100644
--- a/trace.c
+++ b/trace.c
@@ -283,6 +283,9 @@ void trace_run_command(const struct child_process *cp)
 
 	strbuf_addf(&buf, "trace: run_command:");
 
+	if (cp->git_cmd)
+		strbuf_addstr(&buf, " git");
+
 	sq_quote_argv(&buf, cp->argv, 0);
 	print_trace_line(&trace_default_key, &buf);
 }
-- 
2.15.1.600.g899a5f85c6

