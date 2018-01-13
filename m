Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06DEB1FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 06:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965452AbeAMGud (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 01:50:33 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34694 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965440AbeAMGud (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 01:50:33 -0500
Received: by mail-pg0-f67.google.com with SMTP id r19so121027pgn.1
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 22:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mS+5xi+RpKgupicHBIODUuXFfCr8rMzona4pTPtstOw=;
        b=L9mmPTQ5VlSwej4ldxqZwmIXgWdnHS1xJAaAyUmHyr7KcpCySch0qBc5K5jDHK4OP5
         TsdhMvutD8WPvBPLJZJbqbTxxcfyk9vcOv4MDtbNnVnyNPrzDvrHtj4YTm6asGspqae6
         MjR6FlESQHvUu//02Wcl9GJeGt9N0CFcWW5wJykxxutVvm9g9fmnMh+E3k913iN/EFE9
         s8/12uWeqsl9gTdRIOQ9yHmz0CC5B/9uwT6WHySJBMZCTxxg54BDrnrMPNkUKTrsCRLS
         AQDa/JXJHsVg6AT70bR03Jq32b8DI1GV3Fn5gaKJG8c+LNb5U+WaVI/c4j26cM+aNv9Y
         l48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mS+5xi+RpKgupicHBIODUuXFfCr8rMzona4pTPtstOw=;
        b=SGDy+SzjdEoEtJCJlNXOdQvOtjkb7AGp1H9r8KisCcozl5MisriraMJ5akcuYMFOtP
         NytRfc0ohKD5fevE6VZ8NzeGGpw0bsrhEO7hHte4q3GWafUYzfF8peaNXbUT7qaFfT9I
         XSQndJeX49dgqLcfj/RBtmn/EBnJ/87sACo9krJfDpgb0DYqotSovJzi1Le8a/Gwf0KG
         sIo7JXCOP1EH3EONHwu0SQtSWjR1FZPwscFpxnLbdLzulvQRYYM6rXmoWl5RZA6oE8to
         vIiAQfPirkUIZVfI9EpeI7jNT7XJZo66ajNHN3Q045JwwyEThCKgPQ8G7y6bR6HQr8xO
         xRUw==
X-Gm-Message-State: AKwxyteCQTWiDe9o88jmsfH2fvyutAYwQwEHsR+CGAk+oNtp0k+zNN2d
        iop9wde08mtBs/g0FPCETopC8w==
X-Google-Smtp-Source: ACJfBos7AtlHz+7frECKz+GvdGIwzuNINmb3IYmKWI9ilJwED1U+8SG2aCOIUBlpv1LYwkoKd1ogAA==
X-Received: by 10.99.113.75 with SMTP id b11mr13089007pgn.271.1515826232365;
        Fri, 12 Jan 2018 22:50:32 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id b25sm52570096pfd.182.2018.01.12.22.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 22:50:31 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 13 Jan 2018 13:50:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 5/7] trace.c: print program 'git' when child_process.git_cmd is set
Date:   Sat, 13 Jan 2018 13:49:47 +0700
Message-Id: <20180113064949.6043-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180113064949.6043-1-pclouds@gmail.com>
References: <20180112095607.18293-1-pclouds@gmail.com>
 <20180113064949.6043-1-pclouds@gmail.com>
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
index 25c333709b..7f43da211a 100644
--- a/trace.c
+++ b/trace.c
@@ -286,6 +286,9 @@ void trace_run_command(const struct child_process *cp)
 
 	strbuf_addf(&buf, "trace: run_command:");
 
+	if (cp->git_cmd)
+		strbuf_addstr(&buf, " git");
+
 	sq_quote_argv_pretty(&buf, cp->argv);
 	print_trace_line(&trace_default_key, &buf);
 }
-- 
2.15.1.600.g899a5f85c6

