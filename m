Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 702F51F454
	for <e@80x24.org>; Mon, 22 Oct 2018 20:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeJWEnj (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 00:43:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35737 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeJWEnj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 00:43:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id e2-v6so2784174edn.2
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sbMCBemiClCpEe4BT6RReSAvKd3cL9gs3PF4yHi5rU0=;
        b=n1RuHKOo9dwLergc1znmkvHAEL0MSMtHcedffwj6nsI4afMxZtB02fn8rcQH1MTLaa
         12gr8MAX0TuRoLqHWv8Q36geoqygoGbz0P9in6T1i55oznvts7GCO0O3izJjM01ElVrD
         8VhrqAoaV+56Hld5gl3nvlxBgPRGJZiQw7wB2pQL+VeyIHL0PAvSAsoNbbS6mima+Fsk
         d2lWBcCueCV1k5DhS1MxJlmsFZVCD23l4ZoLOnTQOdC8FtW3adCZb5Vgrk6TkXFWGX9W
         sDtLN3ppSU26ZYaML1eonQunoaBQwPu4OFKDQTVqyVjN8AHZGbTe7zeUBA3ARh6ydGrj
         n6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sbMCBemiClCpEe4BT6RReSAvKd3cL9gs3PF4yHi5rU0=;
        b=oQLHKHf/9LbmIPA4/2a4c1IDCPLm9WEBnwgbWKagoNrNZCQu/EqVlAFRBz/KXSU8Rh
         bdRfS2Sau61W4PATk9K8FObgx3SUmxUDsUvSYyUI0WZttzz9TQCM3A3JZrRPCbRX4Z/T
         SQ8IXSC9icqpTv+sPa+aL+WTnZFdBKu72Pgv1OzqocnyoEGi39yeoQHgrwrtpR1+6DaF
         eJFI54y4x6jwIUOB/eqWxjP86X4K0/F5ib3vs6GfFXAdEYUUMOFjEvz4YQZ19cXMvl1Y
         /Vsurb4xi898ihihcX4u7KvVOf/g+XvIrSJfzDAqgqtJYFfXKybxydHeBvheIO+ttxPz
         0RkQ==
X-Gm-Message-State: ABuFfoiNOp8TwayHf7eAKVhv0NeYYkpMXFhUbLlJs1Qa/mAa8dZ11avU
        1Wttz8wivv0eKgHmFp6Bvped3QEc
X-Google-Smtp-Source: ACcGV623ccG9Q0Xiao/feTrlholoZB29EnSIKLIR+ieVlpPoZ9mmIqHuXQ9gmssiLwqDJj4mUdP/rA==
X-Received: by 2002:a50:9583:: with SMTP id w3-v6mr14724007eda.33.1540239817169;
        Mon, 22 Oct 2018 13:23:37 -0700 (PDT)
Received: from localhost.localdomain (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id h21-v6sm16882228eda.23.2018.10.22.13.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 13:23:36 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 7/8] gettext: introduce GIT_GETTEXT_POISON=scrambled
Date:   Mon, 22 Oct 2018 22:22:40 +0200
Message-Id: <20181022202241.18629-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.681.g6bd79da3f5
In-Reply-To: <20181022202241.18629-1-szeder.dev@gmail.com>
References: <20181022153633.31757-1-pclouds@gmail.com>
 <20181022202241.18629-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes tests run with GETTEXT POISON fail because of a reason other
than a translated string that should not have been translated.  In
such a case an error message from a git command in the test's verbose
output is usually, well, less than helpful:

  error: # GETTEXT POISON #

or

  fatal: # GETTEXT POISON #: No such file or directory

It's especially annoying on those rare occasions when a heisenbug
decides it's a good time to suddenly reveal its presence during a
GETTEXT POISON test run, and all we get is an error message like these
(yes, I did actually see both of the above error messages only once).

Make builtin commands' GETTEXT POISON-ed error messages more useful
for debugging failures by introducing a new mode of poisoning: if
$GIT_GETTEXT_POISON is set to 'scrambled', then include the original
untranslated message after that "# GETTEXT_POISON #" string in a
scrambled form, interspersing a '.' after each character.  This way
the messages will remain gibberish enough for machine consumption as
they were before, but at the same time they will be relatively easily
legible for humans.  Take extra care to preserve printf() format
conversion specifiers unaltered when inserting those dots.

Leave 'git-sh-i18n.sh' unchanged, because translatable messages in
scripts often include shell variables, and they could (though
currently they don't) include printf format specifiers, parameter
expansions, command substitutions and whatnot, too.  Dealing with
those in a shell script would be too much hassle without its worth.

There is an additional benefit: as this change considerably increases
the size of translated messages, it could detect cases when we try to
format a translated string into a too small buffer.  E.g. this change
applied on old versions causes test failures because of the bug that
was fixed in 2cfa83574c (bisect_next_all: convert xsnprintf to
xstrfmt, 2017-02-16).

[TODO: Fallout?
       A 'printf(_("foo: %s"), var);' call includes the contents of
       'var' unscrambled in the output.  Could that hide the
       translation of a string that should not have been translated?
       I'm afraid yes: to check the output of that printf() a sloppy
       test could do:

         git plumbing-cmd >out && grep "var's content" out

       which would fail in a regular GETTEXT_POISON test run, but
       would succeed in a scrambled test run.  Does this matter in
       practice, do we care at all?

       Does gettext_scramble() need a FORMAT_PRESERVING annotation?
       Seems to work fine without it so far...]

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 gettext.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 gettext.h | 11 +++++++++--
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/gettext.c b/gettext.c
index c50d1e0377..8ba7fd0bea 100644
--- a/gettext.c
+++ b/gettext.c
@@ -52,13 +52,61 @@ enum poison_mode use_gettext_poison(void)
 	static enum poison_mode poison_mode = poison_mode_uninitialized;
 	if (poison_mode == poison_mode_uninitialized) {
 		const char *v = getenv("GIT_GETTEXT_POISON");
-		if (v && *v)
-			poison_mode = poison_mode_default;
-		else
+		if (v && *v) {
+			if (!strcmp(v, "scrambled"))
+				poison_mode = poison_mode_scrambled;
+			else
+				poison_mode = poison_mode_default;
+		} else
 			poison_mode = poison_mode_none;
 	}
 	return poison_mode;
 }
+
+static int conversion_specifier_len(const char *s)
+{
+	const char printf_conversion_specifiers[] = "diouxXeEfFgGaAcsCSpnm%";
+	const char *format_end;
+
+	if (*s != '%')
+		return 0;
+
+	format_end = strpbrk(s + 1, printf_conversion_specifiers);
+	if (format_end)
+		return format_end - s;
+	else
+		return 0;
+}
+
+const char *gettext_scramble(const char *msg)
+{
+	struct strbuf sb;
+
+	strbuf_init(&sb,
+		    /* "# GETTEXT_POISON #" + ' ' + "m.e.s.s.a.g.e." + '\0' */
+		    strlen(GETTEXT_POISON_MAGIC) + 1 + 2 * strlen(msg) + 1);
+
+	strbuf_addch(&sb, ' ');
+	while (*msg) {
+		if (*msg == '\n') {
+			strbuf_addch(&sb, *(msg++));
+			continue;
+		} else if (*msg == '%') {
+			int spec_len = conversion_specifier_len(msg);
+			if (spec_len) {
+				strbuf_add(&sb, msg, spec_len);
+				msg += spec_len;
+				continue;
+			}
+		}
+
+		strbuf_addch(&sb, *(msg++));
+		strbuf_addch(&sb, '.');
+	}
+
+	/* This will be leaked... */
+	return strbuf_detach(&sb, NULL);
+}
 #endif
 
 #ifndef NO_GETTEXT
diff --git a/gettext.h b/gettext.h
index fcb6bfaa2c..d21346d9fa 100644
--- a/gettext.h
+++ b/gettext.h
@@ -45,10 +45,12 @@ static inline int gettext_width(const char *s)
 enum poison_mode {
 	poison_mode_uninitialized = -1,
 	poison_mode_none = 0,
-	poison_mode_default
+	poison_mode_default,
+	poison_mode_scrambled
 };
 
 extern enum poison_mode use_gettext_poison(void);
+extern const char *gettext_scramble(const char *msg);
 
 #define GETTEXT_POISON_MAGIC "# GETTEXT POISON #"
 #endif
@@ -60,6 +62,8 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 #ifdef GETTEXT_POISON
 	if (use_gettext_poison() == poison_mode_default)
 		return GETTEXT_POISON_MAGIC;
+	else if (use_gettext_poison() == poison_mode_scrambled)
+		return gettext_scramble(gettext(msgid));
 #endif
 	return gettext(msgid);
 }
@@ -67,11 +71,14 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
 const char *Q_(const char *msgid, const char *plu, unsigned long n)
 {
+	const char *msg = ngettext(msgid, plu, n);
 #ifdef GETTEXT_POISON
 	if (use_gettext_poison() == poison_mode_default)
 		return GETTEXT_POISON_MAGIC;
+	else if (use_gettext_poison() == poison_mode_scrambled)
+		return gettext_scramble(msg);
 #endif
-	return ngettext(msgid, plu, n);
+	return msg;
 }
 
 /* Mark msgid for translation but do not translate it. */
-- 
2.19.1.681.g6bd79da3f5

