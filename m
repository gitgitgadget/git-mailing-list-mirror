Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C749B1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeBILFe (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:05:34 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41736 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbeBILFd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:05:33 -0500
Received: by mail-pl0-f66.google.com with SMTP id k8so1314257pli.8
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Qc7zkivmH9mdXeRrNpgjoDr3owS6wo9CDdOco3t4Qc=;
        b=sedWkhjwvpTTTjKlc0pz84kGCwISbCdOYT82EtE4ueQHlmCST+5+VvPl+hubNKw6v8
         52+cOyuYfQTuKJ60MG37Ud05WouDR1ToerIQp2Vu0YlHXpzO/Fs2mnOTciVTcJb9yjub
         QaqYQU2g46rQzaczI6HuqYt26jPNjA64QH36gxV8uhZzh1nGtykQcOwDycK2tIrlNAPH
         XDWQPCAveKzrtPI/MbRmtXNhxKZ24WWI2edQceJsjvs92e2zSxxYMFzqdk+IY328K23O
         5C8/xnCkP75nnmYmNfSd+IZPjKrnWnghYjUbi7Nhq3dvZp/iWXeAGdmyjnNMgmHB6hBL
         wc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Qc7zkivmH9mdXeRrNpgjoDr3owS6wo9CDdOco3t4Qc=;
        b=dg6dV41DafPyGbrl39hqekEmwmG2/BYzALzmI2n35Mm0fZF94n2Hy5twUWXic1/Xre
         yKbsD/cxTPshM+vQpcB2W/nrBQP0abbNbvYWoHMHRw3jyW1REwE3M2KWTNThZijm6f2n
         r1wWC2SFpRd7/COLpzcis1gMMsjdDG1tQZubuuBD4iA9oFsXbKJTBsL+g9VltIde3iHh
         t6uYmrQfMA/37eDH2SKhZbvfGbLTfpnAo2qnCdQUlcAW9z1BcAzyiCQweb0VozCL2FXV
         vGEJ083zVYAS3z2Axtpgeqeg5OZvjUuMt6KuN1KHRtQtFXE7RmVrDDiUGKshEdQU5jhO
         +BAA==
X-Gm-Message-State: APf1xPDXMDd2BIsKlVpijp3qYiqZ2pm9WcBRxSjwdDmUEg85LbXlC3Y8
        RBihIk2H7RCv9r2SMnm2yanWPA==
X-Google-Smtp-Source: AH8x227FSo+Wg7uDlcYtFcvxbkIShxc7JDPqtTP2dP8d9usVElqv9C5DswkjvHGg2t041qKylFwLdQ==
X-Received: by 2002:a17:902:bd4b:: with SMTP id b11-v6mr2264761plx.313.1518174333233;
        Fri, 09 Feb 2018 03:05:33 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id p73sm5384020pfa.109.2018.02.09.03.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:05:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:05:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 33/42] remote: force completing --mirror= instead of --mirror
Date:   Fri,  9 Feb 2018 18:02:12 +0700
Message-Id: <20180209110221.27224-34-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git remote --mirror" is a special case. Technically it is possible to
specify --mirror without any argument. But we will get a "dangerous,
deprecated!" warning in that case.

This new parse-opt flag allows --git-completion-helper to always
complete --mirror=, ignoring the dangerous use case.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/remote.c | 2 +-
 parse-options.c  | 2 ++
 parse-options.h  | 6 +++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d95bf904c3..fce9e5c0f6 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -168,7 +168,7 @@ static int add(int argc, const char **argv)
 		OPT_STRING('m', "master", &master, N_("branch"), N_("master branch")),
 		{ OPTION_CALLBACK, 0, "mirror", &mirror, N_("push|fetch"),
 			N_("set up remote as a mirror to push to or fetch from"),
-			PARSE_OPT_OPTARG, parse_mirror_opt },
+			PARSE_OPT_OPTARG | PARSE_OPT_COMP_ARG, parse_mirror_opt },
 		OPT_END()
 	};
 
diff --git a/parse-options.c b/parse-options.c
index 29f4defdd6..979577ba2c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -459,6 +459,8 @@ static int show_gitcomp(struct parse_opt_ctx_t *ctx,
 		default:
 			break;
 		}
+		if (opts->flags & PARSE_OPT_COMP_ARG)
+			suffix = "=";
 		printf(" --%s%s", opts->long_name, suffix);
 	}
 	fputc('\n', stdout);
diff --git a/parse-options.h b/parse-options.h
index 009cd863e5..0ba08691e6 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -39,7 +39,8 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
 	PARSE_OPT_SHELL_EVAL = 256,
-	PARSE_OPT_NOCOMPLETE = 512
+	PARSE_OPT_NOCOMPLETE = 512,
+	PARSE_OPT_COMP_ARG = 1024
 };
 
 struct option;
@@ -92,6 +93,9 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *				Useful for options with multiple parameters.
  *   PARSE_OPT_NOCOMPLETE: by default all visible options are completable
  *			   by git-completion.bash. This option suppresses that.
+ *   PARSE_OPT_COMP_ARG: this option forces to git-completion.bash to
+ *			 complete an option as --name= not --name even if
+ *			 the option takes optional argument.
  *
  * `callback`::
  *   pointer to the callback to use for OPTION_CALLBACK or
-- 
2.16.1.207.gedba492059

