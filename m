Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB83202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 14:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbdKWORP (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 09:17:15 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35085 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbdKWORN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 09:17:13 -0500
Received: by mail-wr0-f178.google.com with SMTP id w95so17772179wrc.2
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 06:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=52ea5O4yNqk7O7dete3zhF9oqi/dfuRoVJAVr6v5CGM=;
        b=t8D8H1nhTHTa8FJKOj3wknCubM4qR5Q63BDj7COlnH3gxN79geakDafX1te15MaZ2B
         lx6kB4sVD6+GPLZ+WIpR9aW6lYI/sSfCOtaQr7Ztr2apcCTmDNgri16JDV5h09o/S5Rc
         LGmCFrJBptSCD28qW1CUoz+MJYxtwdVE4E824zQJo+V+iKyb9/pYRgYGL0WyXc/nShFU
         SpwWWv0TdsUMN0XmYnl8JsmrlN2+5awAi70kSLZKTOt48/bFYnD0yGVrE/QOTzQB70lV
         0bSe/Cyfz/Ihq/cr7jPFFQfWvE/3bIK7Hk87HprIMPPBxf4wfDsyIaD5+FVYPzen5dFN
         kvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=52ea5O4yNqk7O7dete3zhF9oqi/dfuRoVJAVr6v5CGM=;
        b=EMoAhBA1MMu8jZAL+igszZPZHeyqhoTMEaJ8tHxZnDrQ6xB9eIU5N1sbi+R75T2wvV
         GbCkQO+nvC9/ezJEqiSBShczOpUrMXPpl44MajhLTd4KVolnG0iMZwoRoTqeM6Wd3Aw2
         bmhZFo8c/NegPaFjegp3id1iVfpjiwBC8em4GXXy1oC+JFuAQ4wsk6BBvwCImm8I1Z+/
         5qQK3TDXqfQyHAlOD67phjg/+LEU0JJX6GDMqmUKAhqb854EQS0KRuW1vLSfFSsAyWKG
         p3eOusvZ6Bk3o5BKKpb8ez0o5biYMVwoFR2hZLksAkCZodppJa5MuX5iMgW8w4PDEDXa
         fBdw==
X-Gm-Message-State: AJaThX6yepCQAVihPgJq8Bhqml2KrOZ0LIQjhZRhjbp7Fh/PpMR4Oaya
        QqZa9LzOcYPZbRILloCQJHuSTKUA
X-Google-Smtp-Source: AGs4zMYRXxH3MfFHX8gI/lZ8BTeueIgAnpjEzk67ETjGje5I2aImraiLlXwyzLXZS3kC17O6/MVmRw==
X-Received: by 10.223.134.75 with SMTP id 11mr22160591wrw.37.1511446632044;
        Thu, 23 Nov 2017 06:17:12 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id n143sm14755536wmd.31.2017.11.23.06.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Nov 2017 06:17:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Simon Ruderich <simon@ruderich.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] grep: fix segfault under -P + PCRE2 <=10.30 + (*NO_JIT)
Date:   Thu, 23 Nov 2017 14:16:58 +0000
Message-Id: <20171123141658.13010-2-avarab@gmail.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6
In-Reply-To: <20171123141658.13010-1-avarab@gmail.com>
References: <20171123141658.13010-1-avarab@gmail.com>
In-Reply-To: <20171122133630.18931-2-avarab@gmail.com>
References: <20171122133630.18931-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in the compilation of PCRE2 patterns under JIT (the most
common runtime configuration). Any pattern with a (*NO_JIT) verb would
segfault in any currently released PCRE2 version:

    $ git grep -P '(*NO_JIT)hi.*there'
    Segmentation fault

That this segfaulted was a bug in PCRE2 itself, after reporting it[1]
on pcre-dev it's been fixed in a yet-to-be-released version of
PCRE (presumably released first as 10.31). Now it'll die with:

    $ git grep -P '(*NO_JIT)hi.*there'
    fatal: pcre2_jit_match failed with error code -45: bad JIT option

But the cause of the bug is in our own code dating back to my
94da9193a6 ("grep: add support for PCRE v2", 2017-06-01).

As explained at more length in the comment being added here, it isn't
sufficient to just check pcre2_config() to see whether the JIT should
be used, pcre2_pattern_info() also has to be asked.

This is something I discovered myself when fiddling around with PCRE2
verbs in patterns passed to git. I don't expect that any user of git
has encountered this given the obscurity of passing PCRE2 verbs
through to the library, along with the relative obscurity of (*NO_JIT)
itself.

1. "How am I supposed to use PCRE2 JIT in the face of (*NO_JIT) ?"
   (<CACBZZX5mMqDuWuFmi7sRBp3wH6CFyd-ghACukd=v0NN=rBMnJg@mail.gmail.com> &
    https://lists.exim.org/lurker/thread/20171123.101502.7f0d38ca.en.html)
   on the pcre-dev mailing list

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Incorporates feedback from Eric & Simon. Thanks both. I also amended
the commit message / comment to note that this was also a bug in PCRE2
upstream, which has been fixed after I reported it.

 grep.c          | 26 ++++++++++++++++++++++++++
 t/t7810-grep.sh |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/grep.c b/grep.c
index d0b9b6cdfa..e8ae0b5d8f 100644
--- a/grep.c
+++ b/grep.c
@@ -477,6 +477,8 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	int options = PCRE2_MULTILINE;
 	const uint8_t *character_tables = NULL;
 	int jitret;
+	int patinforet;
+	size_t jitsizearg;
 
 	assert(opt->pcre2);
 
@@ -511,6 +513,30 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
 		if (jitret)
 			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
+
+		/*
+		 * The pcre2_config(PCRE2_CONFIG_JIT, ...) call just
+		 * tells us whether the library itself supports JIT,
+		 * but to see whether we're going to be actually using
+		 * JIT we need to extract PCRE2_INFO_JITSIZE from the
+		 * pattern *after* we do pcre2_jit_compile() above.
+		 *
+		 * This is because if the pattern contains the
+		 * (*NO_JIT) verb (see pcre2syntax(3))
+		 * pcre2_jit_compile() will exit early with 0. If we
+		 * then proceed to call pcre2_jit_match() further down
+		 * the line instead of pcre2_match() we'll either
+		 * segfault (pre PCRE 10.31) or run into a fatal error
+		 * (post PCRE2 10.31)
+		 */
+		patinforet = pcre2_pattern_info(p->pcre2_pattern, PCRE2_INFO_JITSIZE, &jitsizearg);
+		if (patinforet)
+			BUG("pcre2_pattern_info() failed: %d", patinforet);
+		if (jitsizearg == 0) {
+			p->pcre2_jit_on = 0;
+			return;
+		}
+
 		p->pcre2_jit_stack = pcre2_jit_stack_create(1, 1024 * 1024, NULL);
 		if (!p->pcre2_jit_stack)
 			die("Couldn't allocate PCRE2 JIT stack");
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 2a6679c2f5..c8ff50cc30 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1110,6 +1110,12 @@ test_expect_success PCRE 'grep -P pattern' '
 	test_cmp expected actual
 '
 
+test_expect_success LIBPCRE2 "grep -P with (*NO_JIT) doesn't error out" '
+	git grep -P "(*NO_JIT)\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp expected actual
+
+'
+
 test_expect_success !PCRE 'grep -P pattern errors without PCRE' '
 	test_must_fail git grep -P "foo.*bar"
 '
-- 
2.15.0.403.gc27cc4dac6

