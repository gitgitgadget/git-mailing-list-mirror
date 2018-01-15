Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE581F404
	for <e@80x24.org>; Mon, 15 Jan 2018 11:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755095AbeAOLAD (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 06:00:03 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42177 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755001AbeAOLAC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 06:00:02 -0500
Received: by mail-pl0-f67.google.com with SMTP id bd8so3468263plb.9
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 03:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mw+lhk6NcFk61BwrxyfWPgWoYXJiPBWSqRYUdIzhGjs=;
        b=Z6+jBj2vfHYw0y8VBQxxeKeEHQrGcGLjzX1v9vQeqHUnwww1cGEuJcJPtFv/1XbvBP
         g4LlCJvQBc2kSai8tDctdWD0bsP9nznBW3VBLt921ukrsFyZjTGbd+T0jfBZ0cVoaXvy
         e2SqclhkIlwGOLkeaMnc2I44qQukB0LReTDSuLvz7CdpcHGZQFn0LH0wOYecD/bWRhge
         IN94KHMaSfEbBCYyQRR2kEETHxpgbeTfDJ1Y9cuQosu/QbrJHgKUhluHsEZnU5gtDKzX
         3p8iYLrl+FMuJi5d/TYHsUKThA84UPE0fP92hnOd7R5H2rwZ5D6fqoAyo0x9zWayEonZ
         JvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mw+lhk6NcFk61BwrxyfWPgWoYXJiPBWSqRYUdIzhGjs=;
        b=AZcNm7EyTRNgq/T501ktui7x7PNMtcaI7LgsE3GA6ocwUn1piujTuNZawIHs2JphhG
         gozajYsr58+GJI1j12pZgWolq4XUatRNbtcXPGWsA8jYo/vb3sbQNV1qFgnFhVtA5CFn
         l9nGKJikbJod9agvY8of7KzM5zYl0MDw21mpa6hV17he5CrCQhfxvwiIswWKDrkLNawA
         zNXoQqxGm5I3b2fyPo14s2RqapcMubtFY9o6+HbFrq/L2Am4yG6XRMkHiElnk81Mlxv4
         rGAINIkUxnTRmBDIRpWwKS+g5ysFk5fj0bbMXZYW6M7MvAayiBUYguotyezV7CFcIiNq
         NQuA==
X-Gm-Message-State: AKwxytdOCshh+YIQZgIj1CgyMkG8UeuHujv+++t63wnuHYvPGOjy0wfe
        3Y8DOQNzDCKfZ67I44sWXhtg2w==
X-Google-Smtp-Source: ACJfBotxl57tGiZNT7uiGLfEuviqkZvu3LAhfl61Z4X4Rht7OKpycY+heM/NV0x6DKHlZPTIYjOZ9A==
X-Received: by 10.84.217.154 with SMTP id p26mr19146732pli.27.1516014001263;
        Mon, 15 Jan 2018 03:00:01 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id k13sm21906674pfj.38.2018.01.15.02.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jan 2018 03:00:00 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 15 Jan 2018 17:59:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 0/7] Trace env variables in run_command()
Date:   Mon, 15 Jan 2018 17:59:42 +0700
Message-Id: <20180115105949.18328-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180113064949.6043-1-pclouds@gmail.com>
References: <20180113064949.6043-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5 

 - makes test-run-command safer
 - deletes a dead line
 - fixes an embarassing memory leak

Interdiff

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 0ab71f14fb..153342e44d 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -57,9 +57,14 @@ int cmd_main(int argc, const char **argv)
 	if (argc < 3)
 		return 1;
 	while (!strcmp(argv[1], "env")) {
+		if (!argv[2])
+			die("env specifier without a value");
 		argv_array_push(&proc.env_array, argv[2]);
 		argv += 2;
+		argc -= 2;
 	}
+	if (argc < 3)
+		return 1;
 	proc.argv = (const char **)argv + 2;
 
 	if (!strcmp(argv[1], "start-command-ENOENT")) {
diff --git a/trace.c b/trace.c
index 4bfd3fce10..ad75d683bf 100644
--- a/trace.c
+++ b/trace.c
@@ -286,8 +286,8 @@ static void add_env(struct strbuf *dst, const char *const *deltaenv)
 	for (e = deltaenv; e && *e; e++) {
 		struct strbuf key = STRBUF_INIT;
 		char *equals = strchr(*e, '=');
+
 		if (equals) {
-			strbuf_reset(&key);
 			strbuf_add(&key, *e, equals - *e);
 			string_list_insert(&envs, key.buf)->util = equals + 1;
 		} else {
@@ -360,6 +360,7 @@ void trace_run_command(const struct child_process *cp)
 
 	sq_quote_argv_pretty(&buf, cp->argv);
 	print_trace_line(&trace_default_key, &buf);
+	strbuf_release(&buf);
 }
 
 static const char *quote_crnl(const char *path)

Jeff King (2):
  sq_quote_argv: drop maxlen parameter
  trace: avoid unnecessary quoting

Nguyễn Thái Ngọc Duy (5):
  trace.c: move strbuf_release() out of print_trace_line()
  trace.c: introduce trace_run_command()
  trace.c: print program 'git' when child_process.git_cmd is set
  trace.c: print env vars in trace_run_command()
  trace.c: print new cwd in trace_run_command()

 builtin/am.c                |  2 +-
 builtin/rev-parse.c         |  4 +-
 quote.c                     | 30 ++++++++++++--
 quote.h                     | 10 ++++-
 run-command.c               |  3 +-
 t/helper/test-run-command.c |  9 +++++
 t/t0061-run-command.sh      | 22 ++++++++++
 trace.c                     | 97 +++++++++++++++++++++++++++++++++++++++++++--
 trace.h                     |  3 ++
 9 files changed, 169 insertions(+), 11 deletions(-)

-- 
2.15.1.600.g899a5f85c6

