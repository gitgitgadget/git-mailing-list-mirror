Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ACB81F404
	for <e@80x24.org>; Fri, 12 Jan 2018 09:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754522AbeALJ5M (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 04:57:12 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44758 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754350AbeALJ5L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 04:57:11 -0500
Received: by mail-pg0-f68.google.com with SMTP id m20so4235225pgc.11
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 01:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0bmknLtjCN8uBY/qHLqSjY0zIUT3fSiv2wq2/SZZUsE=;
        b=rldkKMo0uGeUwpXZhM6C6oSdjZIs/l6DTV+1QplrGPZKp5M/QgwP/jjZzVaYq/Y2Zz
         qaR2H7o6sbq9+5qMZ5TGVKLjFTO/H5BaxASNRwWy9Fh3AXVZjYKMIXdw8+FTLkr7SUin
         NeeN1+inOhWiK9ZU1YjI8RPuib6L0qn5IT98Jm62CLwfkVzR/19G/dnZoJZsekom4/72
         yR1Sa4guMglTrr8UYCKNb5op2N2omYOwGJ9Ez+S/F0zWdvJmK7tpnI60YG7eIqCNxL5T
         2uNae7mYKeJqo0MSGL3aj2+i+QlwSfCq+uq0/7gSAiSwL7jg+i0+un5aDdYZ9t666afZ
         RYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bmknLtjCN8uBY/qHLqSjY0zIUT3fSiv2wq2/SZZUsE=;
        b=tPYMODQeq2yRUfhHX+WovGF37TxheB1hySOR01b124JzrgSQowEaBZIzt4WCUFMfdJ
         hmTxuELqhT6jPu4fai05OhpqeTmUeZotrsTsYhf9b350uUJVsFb57KvIf6C2DK9jzKKu
         OiNtU4UwwcJWaFRQkP0u9YK9/lNoSiGXhp61PM4seRtpE79F7TG/PB5VV7kA5d8k0f/e
         DKTULX7WTA5oeoprVSN094/fQYgZETB4VnJCinB0YoSHvYZxwg/oAtNmntTvdvB38hZK
         lEoZZcOZW2qFNuDP04VkR4oSckrzzxnFFBtjv0xlYz33B05by4F7nSg5vIO6qulpreMA
         nfPA==
X-Gm-Message-State: AKwxytdDphpzRNjQXpBKb3vZ7bDvaa0VV/U/VC24kaS4GrZABRM+e4QK
        qbF0ZEq0gSj9FrlMVQ5sAE4hqA==
X-Google-Smtp-Source: ACJfBouoXeUHAtJfbUxC5AHwX3FXnvxHyUp1Jvh4v2zLaYH6Mr46/4Ea1uXfTbGM+t3Zg4Lcpr3mlw==
X-Received: by 10.159.229.3 with SMTP id s3mr5652625plq.161.1515751030310;
        Fri, 12 Jan 2018 01:57:10 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id e62sm10149689pfa.173.2018.01.12.01.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jan 2018 01:57:09 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 12 Jan 2018 16:57:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 3/4] trace.c: print env vars in trace_run_command()
Date:   Fri, 12 Jan 2018 16:56:06 +0700
Message-Id: <20180112095607.18293-4-pclouds@gmail.com>
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

Occasionally submodule code could execute new commands with GIT_DIR set
to some submodule. GIT_TRACE prints just the command line which makes it
hard to tell that it's not really executed on this repository.

Print modified env variables (compared to parent environment) in this
case. Actually only modified or new variables (*) are printed. Variable
deletion is suppressed because they are often used to clean up
repo-specific variables that git passes around between processes. When
submodule code executes commands on another repo, it clears all these
variables, _many_ of these, that make the output really noisy.

(*) sort of. More on this in the next patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 trace.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/trace.c b/trace.c
index ed1f728021..e499074d39 100644
--- a/trace.c
+++ b/trace.c
@@ -273,6 +273,24 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
 #endif /* HAVE_VARIADIC_MACROS */
 
 
+static void concatenate_env(struct strbuf *dst, const char *const *envs)
+{
+	int i;
+
+	for (i = 0; envs[i]; i++) {
+		const char *env = envs[i];
+		const char *p = strchr(env, '=');
+
+		if (!p) /* ignore var deletion for now */
+			continue;
+		p++;
+
+		strbuf_addch(dst, ' ');
+		strbuf_add(dst, env, p - env);
+		sq_quote_buf(dst, p);
+	}
+}
+
 void trace_run_command(const struct child_process *cp)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -281,8 +299,17 @@ void trace_run_command(const struct child_process *cp)
 				&trace_default_key, &buf))
 		return;
 
+	strbuf_grow(&buf, 255);
+
 	strbuf_addf(&buf, "trace: run_command:");
 
+	/*
+	 * The caller is responsible for initializing cp->env from
+	 * cp->env_array if needed. We only check one place.
+	 */
+	if (cp->env)
+		concatenate_env(&buf, cp->env);
+
 	if (cp->git_cmd)
 		strbuf_addstr(&buf, " git");
 
-- 
2.15.1.600.g899a5f85c6

