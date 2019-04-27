Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49B91F453
	for <e@80x24.org>; Sat, 27 Apr 2019 19:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfD0TZ3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 15:25:29 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36649 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0TZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 15:25:29 -0400
Received: by mail-it1-f194.google.com with SMTP id v143so161615itc.1
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 12:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A6wwXhxvUGk0qlqexR5mDaNagQnYK7A1s42cCu0LJc0=;
        b=Cg/+pt33YKtu8qXB9XcgF4MtNMYPUGW1rUQ73g4+ddrj6opKHuU8fG12EkgBvto3sv
         VKk4lZWNeJetc7WsB++A7RjXPGeohnDH5bxpBpm/5IiMgK0QU8aroHhtNgE1U39jR6FE
         IHTfjxVbJmcNfxwlbwNomO1JBopWS7+9OnnMoMlHmjGW+wvgYDNhlT3QZ4Qp0yBmZB6+
         Yzcii1qB3bIjuVnq46TZ6+EoDCFEAu3ViajTeKG2A3d6adYqQeINVXzvPSqT64MjM7Sx
         P3cidelKMQhR/95qHdS5Ouk0I+B+KdK/STBwEaHEJU+4ThjG0J0x6hp5Ef1o7qsWr/8y
         gPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A6wwXhxvUGk0qlqexR5mDaNagQnYK7A1s42cCu0LJc0=;
        b=if17O3j8UN99E5xsnP1Z52Vdf/N9ylNx0K3nCqnMgTCYxlYVKuJE2rNd1ll233Nwry
         bFfx77T6VFK4Bxlof1DA9HeeVhotFM/BVh7RYw2UQaJVbQUUMgLmMIDFt1uFlXtpxBWE
         xC5vkvfT3Pi0uQ5r5gMv/+41X49IOOpNDmkDUF9XS+xvZD1JDoZJZqngyotF9TfaGsrO
         TmSzYnaxV38KIKLiizr1OoQZgBn9KEDBveabdSv1sEhctQ/IbGh1JVLX0jsVP3n4OeZi
         2MF0lemsdpt861OJ1smsbGyjO7ZktAJk+3LkoEmZ5gwSKTBm5mu/BYBxL/oOlz7WOxmY
         BL7g==
X-Gm-Message-State: APjAAAWx+VjfcHBUEexTFLgCoTONlYwCzcmVDMXzz25Xqa5A+LsMEdPM
        0yEm7xWusKyFjK0H1kj1iQxTwY+Cdi0=
X-Google-Smtp-Source: APXvYqwEejbiLUiV0e8hBlnDXmcA+eBRWHyeSXQoXHpLLOsDnUBk788JeeND9oFZaAuyJDi0m7Y8XQ==
X-Received: by 2002:a24:df84:: with SMTP id r126mr13800298itg.113.1556393128155;
        Sat, 27 Apr 2019 12:25:28 -0700 (PDT)
Received: from archbookpro.localdomain (mobile-107-77-160-115.mobile.att.net. [107.77.160.115])
        by smtp.gmail.com with ESMTPSA id w12sm8160478ioc.4.2019.04.27.12.25.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Apr 2019 12:25:27 -0700 (PDT)
Date:   Sat, 27 Apr 2019 15:25:25 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/2] format-patch: teach format.notes config option
Message-ID: <1338045be4a185cddc3ebf8adbe4b744551acf15.1556388260.git.liu.denton@gmail.com>
References: <cover.1556388260.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556388260.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-format-patch, notes can be appended with the `--notes` option.
However, this must be specified by the user on an
invocation-by-invocation basis. If a user is not careful, it's possible
that they may forget to include it and generate a patch series without
notes.

Teach git-format-patch the `format.notes` config option where if its
value is true, notes will automatically be appended. This option is
overridable with the `--no-notes` option in case a user wishes not to
append notes.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/format.txt    |  4 ++++
 Documentation/git-format-patch.txt |  3 +++
 builtin/log.c                      |  6 ++++++
 t/t4014-format-patch.sh            | 28 ++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index dc77941c48..55327b6511 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -85,3 +85,7 @@ format.outputDirectory::
 format.useAutoBase::
 	A boolean value which lets you enable the `--base=auto` option of
 	format-patch by default.
+
+format.notes::
+	A boolean value which lets you enable the `--notes` option of
+	format-patch by default.
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 2c3971390e..9ce5b8aaee 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -275,6 +275,9 @@ these explanations after `format-patch` has run but before sending,
 keeping them as Git notes allows them to be maintained between versions
 of the patch series (but see the discussion of the `notes.rewrite`
 configuration options in linkgit:git-notes[1] to use this workflow).
++
+The default is `--no-notes`, unless the `format.notes` configuration is
+set.
 
 --[no-]signature=<signature>::
 	Add a signature to each message produced. Per RFC 3676 the signature
diff --git a/builtin/log.c b/builtin/log.c
index e43ee12fb1..3c6fd9b117 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -769,6 +769,7 @@ static const char *signature = git_version_string;
 static const char *signature_file;
 static int config_cover_letter;
 static const char *config_output_directory;
+static int show_notes;
 
 enum {
 	COVER_UNSET,
@@ -864,6 +865,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 			from = NULL;
 		return 0;
 	}
+	if (!strcmp(var, "format.notes")) {
+		show_notes = git_config_bool(var, value);
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1626,6 +1631,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.max_parents = 1;
 	rev.diffopt.flags.recursive = 1;
 	rev.subject_prefix = fmt_patch_subject_prefix;
+	rev.show_notes = show_notes;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def = "HEAD";
 	s_r_opt.revarg_opt = REVARG_COMMITTISH;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b6e2fdbc44..fe9522121a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -738,6 +738,34 @@ test_expect_success 'format-patch --notes --signoff' '
 	sed "1,/^---$/d" out | grep "test message"
 '
 
+test_expect_success 'format-patch notes output control' '
+	git notes add -m "notes config message" HEAD &&
+	test_when_finished git notes remove HEAD &&
+
+	git format-patch -1 --stdout >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --notes >out &&
+	grep "notes config message" out &&
+	git format-patch -1 --stdout --no-notes >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --notes --no-notes >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --no-notes --notes >out &&
+	grep "notes config message" out &&
+
+	test_config format.notes true &&
+	git format-patch -1 --stdout >out &&
+	grep "notes config message" out &&
+	git format-patch -1 --stdout --notes >out &&
+	grep "notes config message" out &&
+	git format-patch -1 --stdout --no-notes >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --notes --no-notes >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --no-notes --notes >out &&
+	grep "notes config message" out
+'
+
 echo "fatal: --name-only does not make sense" > expect.name-only
 echo "fatal: --name-status does not make sense" > expect.name-status
 echo "fatal: --check does not make sense" > expect.check
-- 
2.21.0.1033.g0e8cc1100c

