Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFAD11F597
	for <e@80x24.org>; Tue, 31 Jul 2018 15:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbeGaQri (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 12:47:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37346 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeGaQri (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 12:47:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id v9-v6so14035190ljk.4
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GZeY0J+qP2j6MFjx9OjJ0srXFVm6y2exx+jrvxTtZCI=;
        b=JX6f1eEBBoHJpbBmCZgVmZP0UquJ8DwEbzMXkLLJkPASqVq6HL0aPcA/hCxjWHecdb
         jNbtJ7G7ALRoEJvWLsxkndWTlrjeHSzAwhJO/M5CYKl+ttw2IK9f2+smSLfKuz5/UCNq
         JGeHC22ZX+RtxUPPdv/eB/zyYCdiFBfchs+lcCRoabCyCKMQaCAyEExtjdAB6QAZDmeX
         1sxoBMcV6iMZ3imgQtH4XW1nR8evqVy1Vmt4cHGAoKotVgAsq/GOxO+HiQ6Ktext/dqi
         /ymC4k82ebwQ7z1SnHlaBJAbEu9CXsKt537Ymoas5+Z7nCCbvkRAXJi4qbBT07r2WC36
         fTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GZeY0J+qP2j6MFjx9OjJ0srXFVm6y2exx+jrvxTtZCI=;
        b=mWReHIKxD+B8gzy4FSMpO7+0u9gDy3TIvXCCGlJwWXgyUT+MFLX2HGzd1FaC6hvuiv
         0bJbfB9xdWmHRa4NEjetdMykuIvNvCnDARP52/gegACv2s7pZ8DGyxmATUJUoHy7lIEH
         pnTp/HkyfScGwMVy5gQY4/TZBJT/eSFOwI/tqt6mzllSzaeBY2wraWj6+JFHfLz4zVZV
         KIAtI72dkbeM210EMUYRxIOuX2QuZ+aAV17K0pcbPcikHyzR0/QEiSqAWh96Ko49tloJ
         UzbhhqUkvQUtdPUS+Xynjr2n4vw2vlKOIvCiMeQMXWYZ0sR0U33vfH8O/kCS0KAws0D+
         o1YA==
X-Gm-Message-State: AOUpUlHSSoLUxqMQPCfEn6ImpH5m5rs5X0B6IeAWgqioJlj+11Zqv+Op
        P3SZVJVezkXdTyxXVH9uUSE=
X-Google-Smtp-Source: AAOMgpegtnVcfbi0KduRyYweiGCLyT7cYdkzhSjt1EXfsm8RNG7bT6wu/rqqfwSrznVoneNwdGgJPw==
X-Received: by 2002:a2e:558c:: with SMTP id g12-v6mr16114902lje.4.1533049611336;
        Tue, 31 Jul 2018 08:06:51 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x11-v6sm1995208lfi.8.2018.07.31.08.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 08:06:50 -0700 (PDT)
Date:   Tue, 31 Jul 2018 17:06:48 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/1] Highlight keywords in remote sideband output.
Message-ID: <20180731150648.GA852@duynguyen.home>
References: <20180730123334.65186-1-hanwen@google.com>
 <20180730123334.65186-2-hanwen@google.com>
 <87tvofua7k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvofua7k.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 09:37:51AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jul 30 2018, Han-Wen Nienhuys wrote:
> 
> 
> > +	if (sideband_use_color < 0) {
> > +		const char *key = "color.remote";
> > +		char *value = NULL;
> > +		if (!git_config_get_string(key, &value))
> > +			sideband_use_color = git_config_colorbool(key, value);
> > [...]
> > +	struct kwtable {
> > +		const char *keyword;
> > +		const char *color;
> > +	} keywords[] = {
> > +		{"hint", GIT_COLOR_YELLOW},
> > +		{"warning", GIT_COLOR_BOLD_YELLOW},
> > +		{"success", GIT_COLOR_BOLD_GREEN},
> > +		{"error", GIT_COLOR_BOLD_RED},
> 
> 
> FWIW I agree with other reviewers that it would be nice if these could
> be customized, but I also think it can wait for some follow-up patch.
> 
> Users who don't like these colors don't have to use them, and then
> they're no worse off than now, whereas some users will appreciate these
> and be better off than now.
> 
> So great if you want to improve this, but just chiming in on that point
> because I think we should be respectful of the time of contributors, and
> not make perfect the enemy of the good.

Fair enough. I'll scratch my own itch. Can we squash this in then?

-- 8< --
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 43b2de7b5f..0783323bec 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1229,6 +1229,15 @@ color.push::
 color.push.error::
 	Use customized color for push errors.
 
+color.remote::
+	A boolean to enable/disable colored remote output. If unset,
+	then the value of `color.ui` is used (`auto` by default).
+
+color.remote.<slot>::
+	Use customized color for each remote keywords. `<slot>` may be
+	`hint`, `warning`, `success` or `error` which match the
+	corresponding keyword.
+
 color.showBranch::
 	A boolean to enable/disable color in the output of
 	linkgit:git-show-branch[1]. May be set to `always`,
diff --git a/help.c b/help.c
index 3ebf0568db..b6cafcfc0a 100644
--- a/help.c
+++ b/help.c
@@ -425,6 +425,7 @@ void list_config_help(int for_human)
 		{ "color.diff", "<slot>", list_config_color_diff_slots },
 		{ "color.grep", "<slot>", list_config_color_grep_slots },
 		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
+		{ "color.remote", "<slot>", list_config_color_sideband_slots },
 		{ "color.status", "<slot>", list_config_color_status_slots },
 		{ "fsck", "<msg-id>", list_config_fsck_msg_ids },
 		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
diff --git a/help.h b/help.h
index f8b15323a6..9eab6a3f89 100644
--- a/help.h
+++ b/help.h
@@ -83,6 +83,7 @@ void list_config_color_diff_slots(struct string_list *list, const char *prefix);
 void list_config_color_grep_slots(struct string_list *list, const char *prefix);
 void list_config_color_interactive_slots(struct string_list *list, const char *prefix);
 void list_config_color_status_slots(struct string_list *list, const char *prefix);
+void list_config_color_sideband_slots(struct string_list *list, const char *prefix);
 void list_config_fsck_msg_ids(struct string_list *list, const char *prefix);
 
 #endif /* HELP_H */
diff --git a/sideband.c b/sideband.c
index 74b2fcaf64..61c4376a64 100644
--- a/sideband.c
+++ b/sideband.c
@@ -3,7 +3,59 @@
 #include "config.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "help.h"
+
+struct kwtable {
+	/*
+	 * Note, we current use keyword as config key so it can't
+	 * contain funny chars like spaces. When we do that, we need a
+	 * separate field for slot name in load_sideband_colors().
+	 */
+	const char *keyword;
+	char color[COLOR_MAXLEN];
+};
+
+static struct kwtable keywords[] = {
+	{ "hint",	GIT_COLOR_YELLOW },
+	{ "warning",	GIT_COLOR_BOLD_YELLOW },
+	{ "success",	GIT_COLOR_BOLD_GREEN },
+	{ "error",	GIT_COLOR_BOLD_RED },
+};
+
+static int sideband_use_color = -1;
+
+static void load_sideband_colors(void)
+{
+	const char *key = "color.remote";
+	struct strbuf sb = STRBUF_INIT;
+	char *value;
+	int i;
+
+	if (sideband_use_color >= 0)
+		return;
+
+	if (!git_config_get_string(key, &value))
+		sideband_use_color = git_config_colorbool(key, value);
+
+	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s.%s", key, keywords[i].keyword);
+		if (git_config_get_string(sb.buf, &value))
+			continue;
+
+		if (color_parse(value, keywords[i].color))
+			die(_("expecting a color: %s"), value);
+	}
+	strbuf_release(&sb);
+}
+
+void list_config_color_sideband_slots(struct string_list *list, const char *prefix)
+{
+	int i;
 
+	for (i = 0; i < ARRAY_SIZE(keywords); i++)
+		list_config_item(list, prefix, keywords[i].keyword);
+}
 
 /*
  * Optionally highlight some keywords in remote output if they appear at the
@@ -11,24 +63,9 @@
  */
 static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
 {
-	static int sideband_use_color = -1;
 	int i;
-	struct kwtable {
-		const char *keyword;
-		const char *color;
-	} keywords[] = {
-		{"hint", GIT_COLOR_YELLOW},
-		{"warning", GIT_COLOR_BOLD_YELLOW},
-		{"success", GIT_COLOR_BOLD_GREEN},
-		{"error", GIT_COLOR_BOLD_RED},
-	};
-
-	if (sideband_use_color < 0) {
-		const char *key = "color.remote";
-		char *value = NULL;
-		if (!git_config_get_string(key, &value))
-			sideband_use_color = git_config_colorbool(key, value);
-	}
+
+	load_sideband_colors();
 
 	if (!want_color_stderr(sideband_use_color)) {
 		strbuf_add(dest, src, n);
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 606386f4fe..69b7cc571d 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -6,7 +6,7 @@ test_description='remote messages are colorized on the client'
 
 test_expect_success 'setup' '
 	mkdir .git/hooks &&
-	cat << EOF > .git/hooks/update &&
+	cat << EOF >.git/hooks/update &&
 #!/bin/sh
 echo error: error
 echo hint: hint
@@ -20,15 +20,26 @@ EOF
 	git commit -m 1 &&
 	git clone . child &&
 	cd child &&
-	echo 2 > file &&
+	echo 2 >file &&
 	git commit -a -m 2
 '
 
-test_expect_success 'push' 'git -c color.remote=always push origin HEAD:refs/heads/newbranch 2>output &&
-  test_decode_color < output > decoded &&
-  test_i18ngrep "<BOLD;RED>error<RESET>:" decoded &&
-  test_i18ngrep "<YELLOW>hint<RESET>:" decoded &&
-  test_i18ngrep "<BOLD;GREEN>success<RESET>:" decoded &&
-  test_i18ngrep "<BOLD;YELLOW>warning<RESET>:" decoded'
+test_expect_success 'push' '
+	git -c color.remote=always push origin HEAD:refs/heads/newbranch 2>output &&
+	test_decode_color <output >decoded &&
+	test_i18ngrep "<BOLD;RED>error<RESET>:" decoded &&
+	test_i18ngrep "<YELLOW>hint<RESET>:" decoded &&
+	test_i18ngrep "<BOLD;GREEN>success<RESET>:" decoded &&
+	test_i18ngrep "<BOLD;YELLOW>warning<RESET>:" decoded
+'
+
+test_expect_success 'push with customized color' '
+	git -c color.remote=always -c color.remote.error=white push origin HEAD:refs/heads/newbranch2 2>output &&
+	test_decode_color <output >decoded &&
+	test_i18ngrep "<WHITE>error<RESET>:" decoded &&
+	test_i18ngrep "<YELLOW>hint<RESET>:" decoded &&
+	test_i18ngrep "<BOLD;GREEN>success<RESET>:" decoded &&
+	test_i18ngrep "<BOLD;YELLOW>warning<RESET>:" decoded
+'
 
 test_done
-- 8< --
