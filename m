Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563142;
	b=h4rr4KZiVrEXqZfvXxOqPcY/RNHuWxOxgr/rmGzcAaB9aEa9/oerDTC30iUFdybuy//u
	 vfYINLocfVFCCXKLMZieVNgvOAynpL21VDv6GMMAf6ou+vQv9vc9UyzBdcTpspNUc1yeZ
	 kclKb6XJUOGy4JWRUZQ6G+tfDspcCtXui2dVuD3VzrrmbuVTpiGjd8lcuJqocTPURvrP3
	 896KpHtw0B4mJu1DiEGgkj+GqnuPag9ssx70OdqMiOt3BpC14t8W5Nh0iEKZyokgPhyXM
	 fIJkM1KAuNkh3Rh6aRXlQPIA8m5i7tFWbEtlbo1O244R+pKcFfje0LJctzAjBMu23GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NnTde1OYlbt5Rck9PAQS5KiWaQlvV0FJK0Qswqq3EIw=;
	b=3VwYKYLQjZzi/UayujU/5CGcCstK3MT/8bEF+ldwQMfJNurzsWTQXGG4tnpJE8xj1g8w
	 cfLf4F25HJ6eSgD1gS4dM5gh7M7tZRJVuYh/aEnlIEenCEnfznorLPLzDzE3ZQM49FU+7
	 PRtOQkUQyQvTgkaBmv3neMW2oJJCBj2+K56VjmQiO96KRHuTLbfXhVLBPgEz3ZuMPi9nm
	 kzdPM3VrDwqvEnZ/yKJpxTub3FaMcmx0n1B1+SsKtHzhcc8n2ruLPvyPFmpoiXUOGeP0b
	 uDEJjthxBc0VyVjqLpQprsrln86Fr0BUca1NYYqkPvDaY1VQJ5KjpCHQkYFqwyuPm6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=cervined.in;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="m5+/tTiN";
	arc=none smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27302606A332
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 23:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27302606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m5+/tTiN
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so3199829e87.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795563140; x=1796167940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NnTde1OYlbt5Rck9PAQS5KiWaQlvV0FJK0Qswqq3EIw=;
        b=m5+/tTiNVZpJoiNXHyK5U/PevR82M0liiqXg9T/FxZ6DYRzX9aYTRiGyojvfCDDZ8I
         ZBZH5wWDMH1EC/O/Ed+z0TW1m8Pf9W0yUkTYql1owDr47jryb3Hw/MSwfEUmA+MXuJfy
         2RFA53fndJyYO7MMyr2DGx1H4pnU+LJ5Th39B89GhTsW97jHx+I10tt20Gur57ory4rQ
         k73EQUNZI/OJKldyIQinA4rS6Nv4LlRl1iQ2WnEkQOY0MHlQpy5jBRVq5JVcI6llJToe
         PlIjGdsAl95ZYYa9wBjWbf8yRi5Yay7EQfYBohqpzyHSMT9uywSHdPWwCMkQO330g028
         Ewzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795563140; x=1796167940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnTde1OYlbt5Rck9PAQS5KiWaQlvV0FJK0Qswqq3EIw=;
        b=yRTSF/we2n/x7+zpzDHo7i3iIWhzHcpx48fkIpBVTFaO0B+IzxMckFIugvfNnnTP0U
         1JXgOIKFeMhtQJM06a8H95wjZil4wRnQCZvkcvE0tAVG3DKruAgHcHYO8KXGK/i3XvtZ
         zIOFJU54DwEu/UNfcRv7EwRHjwHOV7PMQPmi3tNO295Jy3eOXTqIUw6DdWAFWFa2cS8H
         xdQEGOf6Lp8TUvXN87CBNQMDZ2SNNzciOnA0Cld7KLKfQd8A9rliiHRnyNQSCGIduGbR
         hJQGB60ftlwdRN0wLnMjEbt4mG5xz2mLqvIssX/zFy/+2rdJWMHD3feyjB0B8F++N047
         783g==
X-Gm-Message-State: APuU4Z9JNqS3o9LrPA86QhkRRcJX+RhfG9x8+CMATVNsA02Ze9RAsoO2
	OvrOXXs5MxZYoglZMjnO22L5EXP3wXjdryU2t5It2H68auM91xhnMQ+5mxg5FA==
X-Gm-Gg: AZFdTZdNJ+/F37f8AQlahAaUA0PMJmaiXr0Uip9fHdIIuerYbWorOStSYymjEBQbNxh
	SP5m7iWHf088B88KxS9RgrgA2XMJOxPokb1iOVJOpp89dTLEfO05XngZaAQespgLWWG6LE0WV20
	/2nqQRrVJ+JgkwvWNKW2CnnFgnzs3KfB9QOo/5wDuH6e012lN77THRCQNkSdVExMjWoEgHX8I1C
	gWoWhT5gUOUFkHTjyvndbKz2VNeEj2V2KY+PLul5jAjDADpZDf6oYO8Sn0KTrdtR+qVdZVSyYBO
	EduHtatFL2YLMslaAK5f4Ayg2YBCXxiI/bInmRWfEx+Rg2ICOvHZ6vOoV2aL2G92zjxKu1sZp0b
	sWoQQUmtj1sjqBPrhzqLXvsugB+a0LfsFoYbfNpl2ju4NDmRb9tgrPgeQrroEXD2HJR2mvSM/xM
	dSV39Cxr1qllg7FO2XurKe1JEY7E1dfZroP4a8YsJgiAh72WNRC2+4kknhi37fo5jycppVQ2clz
	QsVpkmW/aYyhxaz3T5t4Suml2thXJ6avPHmmpPk2Ti4VFoRF+qIWT9N778Q2pVjG/2fMgXBQt6K
	+P94WUzsQpAWNQfLZmq5Juv6rnvY2yBnov/vy/8SS5jdREtIzx/BOh0vL1a17GlR8CHRBBAiIb6
	/V1r+yuhNjVDZTkv6j6CuilU1O2theibpQAjRaAIj2A1kDA==
X-Received: by 2002:a05:6512:6604:b0:5c1:598b:62e8 with SMTP id 2adb3069b0e04-5c1bc81ccccmr3787582e87.56.1795563139980;
        Tue, 24 Nov 2026 15:32:19 -0800 (PST)
Received: from localhost ([2001:2043:be0a:d700:bd32:e7e3:cfbd:5b51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bcf33c75sm4232459e87.12.2026.11.24.15.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 15:32:19 -0800 (PST)
Sender: Erik <erik88@gmail.com>
From: Erik Cervin-Edin <erik@cervined.in>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	Erik Cervin-Edin <erik@cervined.in>
Subject: [PATCH v4 1/3] commit: write the --fixup subject the way --squash does
Date: Wed, 25 Nov 2026 00:32:09 +0100
Message-ID: <ebae1fbe0586bc3c396c26aaf044149a0b9a16bb.1795562078.git.erik@cervined.in>
X-Mailer: git-send-email 2.56.1.978.gcc9bcf3eaa
In-Reply-To: <cover.1795562078.git.erik@cervined.in>
References: <cover.1790082176.git.erik@cervined.in> <cover.1795562078.git.erik@cervined.in>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In prepare_to_commit(), the source of the message is chosen by an
if/else-if chain, one arm per option.  Originally [1], when using
--fixup you couldn't specify a message source, but then [2] taught
commit how to combine --fixup with -m.  Since then, the -m arm is
skipped for fixup commits and instead the fixup arm writes the
"fixup!" or "amend!" subject, appending any -m messages to a "fixup!".

Unlike --fixup, --squash has supported all message source options since
it was introduced [3].  It writes its "squash!" subject first and then
lets the chain write the rest of the message.

Two commits that follow teach commit --fixup how to take messages like
--squash.  In preparation for that, refactor prepare_to_commit() to
write the --fixup subject in a block before the chain, as --squash does.
Since the two options are mutually exclusive, put each subject block in
its own branch of an if/else-if.

The fixup arm is left with the one message source that takes no
command-line option: an amend, which supplies the message by opening
an editor prefilled with the fixup target's message.

The -m arm now runs before the fixup arm, so the error for -m with an
amend would never be reached there.  Raise it in the subject block.

While moving the subject code, rename its "commit" variable to "c" to
match the --squash block.

1. d71b8ba7c9 (commit: --fixup option for use with rebase --autosquash,
   2010-11-02)

2. 30884c9afc (commit: add support for --fixup <commit> -m"<extra
   message>", 2017-12-22)

3. 89ac1223c0 (commit: --squash option for use with rebase --autosquash,
   2010-11-02)

Signed-off-by: Erik Cervin-Edin <erik@cervined.in>
---
 builtin/commit.c | 51 +++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 36e47e18ed..698823d4fa 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -781,7 +781,21 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 					  "pre-commit", NULL))
 		return 0;
 
-	if (squash_message) {
+	if (fixup_message) {
+		struct pretty_print_context ctx = {0};
+		struct commit *c;
+		char *fmt;
+		c = lookup_commit_reference_by_name(fixup_commit);
+		if (!c)
+			die(_("could not lookup commit '%s'"), fixup_commit);
+		ctx.output_encoding = get_commit_output_encoding();
+		fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
+		repo_format_commit_message(the_repository, c, fmt, &sb,
+					   &ctx);
+		free(fmt);
+		if (have_option_m && !strcmp(fixup_prefix, "amend"))
+			die(_("options '%s' and '%s:%s' cannot be used together"), "-m", "--fixup", fixup_message);
+	} else if (squash_message) {
 		/*
 		 * Insert the proper subject line before other commit
 		 * message options add their content.
@@ -801,7 +815,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		}
 	}
 
-	if (have_option_m && !fixup_message) {
+	if (have_option_m) {
 		strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (logfile && !strcmp(logfile, "-")) {
@@ -823,35 +837,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		hook_arg1 = "commit";
 		hook_arg2 = use_message;
 	} else if (fixup_message) {
-		struct pretty_print_context ctx = {0};
-		struct commit *commit;
-		char *fmt;
-		commit = lookup_commit_reference_by_name(fixup_commit);
-		if (!commit)
-			die(_("could not lookup commit '%s'"), fixup_commit);
-		ctx.output_encoding = get_commit_output_encoding();
-		fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
-		repo_format_commit_message(the_repository, commit, fmt, &sb,
-					   &ctx);
-		free(fmt);
 		hook_arg1 = "message";
-
-		/*
-		 * Only `-m` commit message option is checked here, as
-		 * it supports `--fixup` to append the commit message.
-		 *
-		 * The other commit message options `-c`/`-C`/`-F` are
-		 * incompatible with all the forms of `--fixup` and
-		 * have already errored out while parsing the `git commit`
-		 * options.
-		 */
-		if (have_option_m && !strcmp(fixup_prefix, "fixup"))
-			strbuf_addbuf(&sb, &message);
-
 		if (!strcmp(fixup_prefix, "amend")) {
-			if (have_option_m)
-				die(_("options '%s' and '%s:%s' cannot be used together"), "-m", "--fixup", fixup_message);
-			prepare_amend_commit(commit, &sb, &ctx);
+			struct pretty_print_context ctx = {0};
+			struct commit *c = lookup_commit_reference_by_name(fixup_commit);
+			if (!c)
+				die(_("could not lookup commit '%s'"), fixup_commit);
+			ctx.output_encoding = get_commit_output_encoding();
+			prepare_amend_commit(c, &sb, &ctx);
 		}
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
 		size_t merge_msg_start;
-- 
2.56.1.978.gcc9bcf3eaa

