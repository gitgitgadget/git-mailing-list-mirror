Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285101F404
	for <e@80x24.org>; Mon, 15 Jan 2018 11:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755087AbeAOLAV (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 06:00:21 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44588 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755072AbeAOLAT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 06:00:19 -0500
Received: by mail-pl0-f68.google.com with SMTP id f8so1448252plk.11
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 03:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCr7dHRjerGiDDk4osYQqwPwBSqz7r1iw0UEOwHdaGE=;
        b=dKMUy9uNz/380UX4639Tw42ZunArZv6ukeCrFK6PIMYGbdsrfmHngODj0Fn8JSwgk5
         Hz3FupiUjj1IOVhaHIT7FeWk6H8dVaSZu4mAXguiah4EuBhixXtXENI8tqfRBii8NBHJ
         BtRkl2nmqU2YV6CeRXFUrBCRdftuVLFNRvLq/MSwNv9hu8r/f0d5m91ITsoT+0w4ciOj
         GLZqhakO31QUnUDifb3GNZMZwwAg5RiQ3h0s6yVBtVccuTTNztkQ6omiu9U/Q+8ACoo0
         xqCT7t7Z7fp1lqLOCtsyYlUo2vSI0gjvWGjPChL8SdAS8UB1EX5FiG1n8XQZ5IDKM/YU
         gA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCr7dHRjerGiDDk4osYQqwPwBSqz7r1iw0UEOwHdaGE=;
        b=Zdj2XcQVdnElXwQxkDCIozYqiZXmgCeXb70TftRCE3b2rvvuQqtVw9etU8E9T5+PIG
         DTBAMuZ0rceZQ55W/DEhWuVfTtYLcPuy1X3YVCMQ4uxeCv9JILpRQhmcUuHPpYcwicZH
         zK0EUzGQmvz8QgUGQ5Z51ixq7pEVEv758wQREFyBmV51Wf4g+Y2gHQ6PGpF59IXG3uyb
         H8V7Whu8e0UDh1d6v5Kp8O7ZXyBN0Xx7Qd1ry4wjtZ/EQYpi2RcoJc1HBJMUilw8BYZw
         CdtNtjNGTnYDtDLdH3uvC4znBVai+eo4kIl7jPqkPZMvHgBOR8h2rLuZgrQBF2z4NOeU
         7/mw==
X-Gm-Message-State: AKGB3mL1EkEjWZihwbxUBOTtf9pk/jQ16oUzgUB+Bitwwl8hHneP+lcg
        5PiOqHs6b2Cofa8LhnWURD06xg==
X-Google-Smtp-Source: ACJfBovxkALDgfXJC9Oac7BoWoncPffUcn1aJJtcdnFzyPteIBn61MZqW0fCnAZOSceHKFa0hz3Zlw==
X-Received: by 10.124.18.1 with SMTP id t1mr27574102ply.342.1516014019080;
        Mon, 15 Jan 2018 03:00:19 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id l10sm15240592pgp.86.2018.01.15.03.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jan 2018 03:00:18 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 15 Jan 2018 18:00:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 3/7] trace.c: move strbuf_release() out of print_trace_line()
Date:   Mon, 15 Jan 2018 17:59:45 +0700
Message-Id: <20180115105949.18328-4-pclouds@gmail.com>
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

The function is about printing a trace line, not releasing the buffer it
receives too. Move strbuf_release() back outside. This makes it easier
to see how strbuf is managed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/trace.c b/trace.c
index 9784915be1..7f3b08e148 100644
--- a/trace.c
+++ b/trace.c
@@ -131,7 +131,6 @@ static void print_trace_line(struct trace_key *key, struct strbuf *buf)
 {
 	strbuf_complete_line(buf);
 	trace_write(key, buf->buf, buf->len);
-	strbuf_release(buf);
 }
 
 static void trace_vprintf_fl(const char *file, int line, struct trace_key *key,
@@ -144,6 +143,7 @@ static void trace_vprintf_fl(const char *file, int line, struct trace_key *key,
 
 	strbuf_vaddf(&buf, format, ap);
 	print_trace_line(key, &buf);
+	strbuf_release(&buf);
 }
 
 static void trace_argv_vprintf_fl(const char *file, int line,
@@ -159,6 +159,7 @@ static void trace_argv_vprintf_fl(const char *file, int line,
 
 	sq_quote_argv_pretty(&buf, argv);
 	print_trace_line(&trace_default_key, &buf);
+	strbuf_release(&buf);
 }
 
 void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
@@ -171,6 +172,7 @@ void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 
 	strbuf_addbuf(&buf, data);
 	print_trace_line(key, &buf);
+	strbuf_release(&buf);
 }
 
 static void trace_performance_vprintf_fl(const char *file, int line,
@@ -190,6 +192,7 @@ static void trace_performance_vprintf_fl(const char *file, int line,
 	}
 
 	print_trace_line(&trace_perf_key, &buf);
+	strbuf_release(&buf);
 }
 
 #ifndef HAVE_VARIADIC_MACROS
-- 
2.15.1.600.g899a5f85c6

