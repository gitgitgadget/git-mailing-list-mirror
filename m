Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA3FD1F406
	for <e@80x24.org>; Tue, 16 Jan 2018 10:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeAPKhZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 05:37:25 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35007 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbeAPKhW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 05:37:22 -0500
Received: by mail-pl0-f68.google.com with SMTP id b96so5811641pli.2
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 02:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+XtWfPOaELHnnDOTxWiZeUP1RemUPEcAN2MnkYI0So=;
        b=OmSMTuLa1JomIuClhdLPMfHxzLZdd66Vc5TdjaClSF0SHi8PgW0XbJRuPCqHIGl7rK
         OBf/8RA4zQw6dFqO21hHh5qobzziVIObTA6AxQNMXRwIGurwgX6o9xrowbqlepY1NMc7
         RryR2pw7M2Imv+xT6pRxpTa4W5O0gRHPjUdtDkGWK5b8ECoy8Uowz4sBcMzST3kKPSTO
         H1ezImqGjsQuRfseikH+D1Dg+ndUfMpFQtKxjpLwXdFSsgechcKrcRsQQbzZifBjKbmb
         Ex/QJp1EKeE1jKtarzYE+tGUZmdDF4k3BPBD+E38HdgFykXpuxJhQ8vafoffuh4w22q4
         NjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+XtWfPOaELHnnDOTxWiZeUP1RemUPEcAN2MnkYI0So=;
        b=m4+wDB6dxYAA1LTRLskn10XfbHIMqIUbM6dQshSutyU8lxZuNQFLB2Cokyetosmy2E
         ZHZAYSIW7sEY2IZseTMqKjP8OiiqJ9N6YPxlSRWji+iy/wbtynRNSe+UgSDR48I82GLN
         h6QawCpCSFDmvs4Oiod9E+kdP4b8p+If2GwiYaTAUPnkb+0/VzpXGU4D7g99XuB/QStT
         w0rFIj82o5adJhAT9VFM0fMpAQtK+rZT+zIJhGiSs27OX8dvnoRyvgwEM6lHLqjZIqBV
         DNNgeRicUMsqgEczgNV7RKA7K1fcitfghtyi0uS3rBMGui/6R8E/G/VkRpSE+9SyUaDm
         zuZQ==
X-Gm-Message-State: AKwxytemftOPBIG2L27SgXixb1ro5UNu8wzvHDyTivdy1HXrKfRa+dXx
        cDKtNz4zhYFckrhTOvlYxVb0KQ==
X-Google-Smtp-Source: ACJfBosL1NqbGEs8VI6vm5KUAYH7/lX4kr8uCECK3YKNDfzeAMizE5o944yZL4yuYL+FTIGKxVxvSw==
X-Received: by 10.159.205.129 with SMTP id v1mr6176539plo.430.1516099042106;
        Tue, 16 Jan 2018 02:37:22 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id s67sm3344034pfe.133.2018.01.16.02.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2018 02:37:21 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Jan 2018 17:37:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] git-completion: use --git-completion-helper
Date:   Tue, 16 Jan 2018 17:37:00 +0700
Message-Id: <20180116103700.4505-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180116103700.4505-1-pclouds@gmail.com>
References: <20180116103700.4505-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The builtin command is updated to hide some options. The new options
that are complete-able are:

--after-context=
--all-match
--before-context=
--color
--context
--exclude-standard
--recurse-submodules
--textconv

--max-depth and --threads are already completable, but now it will
complete with the "=" suffix because these always take an argument.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c                         | 13 ++++++++-----
 contrib/completion/git-completion.bash | 16 +---------------
 parse-options.h                        |  8 +++++---
 3 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3ca4ac80d8..8fe5560ee8 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -832,8 +832,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('L', "files-without-match",
 			&opt.unmatch_name_only,
 			N_("show only the names of files without match")),
-		OPT_BOOL('z', "null", &opt.null_following_name,
-			N_("print NUL after filenames")),
+		OPT_BOOL_F('z', "null", &opt.null_following_name,
+			   N_("print NUL after filenames"),
+			   PARSE_OPT_NO_GITCOMP),
 		OPT_BOOL('c', "count", &opt.count,
 			N_("show the number of matches instead of matching lines")),
 		OPT__COLOR(&opt.color, N_("highlight matches")),
@@ -884,9 +885,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
 			N_("pager"), N_("show matching files in the pager"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
-		OPT_BOOL(0, "ext-grep", &external_grep_allowed__ignored,
-			 N_("allow calling of grep(1) (ignored by this build)")),
+			PARSE_OPT_OPTARG | PARSE_OPT_NO_GITCOMP,
+			NULL, (intptr_t)default_pager },
+		OPT_BOOL_F(0, "ext-grep", &external_grep_allowed__ignored,
+			   N_("allow calling of grep(1) (ignored by this build)"),
+			   PARSE_OPT_NO_GITCOMP),
 		OPT_END()
 	};
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c5..f0d9126fd6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1585,21 +1585,7 @@ _git_grep ()
 
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--cached
-			--text --ignore-case --word-regexp --invert-match
-			--full-name --line-number
-			--extended-regexp --basic-regexp --fixed-strings
-			--perl-regexp
-			--threads
-			--files-with-matches --name-only
-			--files-without-match
-			--max-depth
-			--count
-			--and --or --not --all-match
-			--break --heading --show-function --function-context
-			--untracked --no-index
-			"
+		__gitcomp "$(git grep --git-completion-helper)"
 		return
 		;;
 	esac
diff --git a/parse-options.h b/parse-options.h
index 8a3389b05b..2bd833a4c5 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -124,9 +124,11 @@ struct option {
 				      (h), PARSE_OPT_NOARG, NULL, (b) }
 #define OPT_COUNTUP(s, l, v, h)     { OPTION_COUNTUP, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG }
-#define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, NULL, (i) }
-#define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
+#define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l), (v), NULL, \
+					  (h), PARSE_OPT_NOARG | (f), NULL, (i) }
+#define OPT_SET_INT(s, l, v, h, i)  OPT_SET_INT_F(s, l, v, h, i, 0)
+#define OPT_BOOL_F(s, l, v, h, f)   OPT_SET_INT_F(s, l, v, h, 1, f)
+#define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
 #define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
-- 
2.15.1.600.g899a5f85c6

