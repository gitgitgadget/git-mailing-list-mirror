Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E9AC4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 01:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiLPBrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 20:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiLPBrW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 20:47:22 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7602BB01
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 17:47:20 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d82so799993pfd.11
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 17:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vTJH8jxW+qdbO+0po4BigY2q3TK8TME8iG7XZO+Phis=;
        b=G0K8ktN97n/OldKcXcJg5aOOIkPngEMrx090AZidy9IudSnzdA/IZtgyHc/W2kjhgT
         PKRvLSU+NH9jEcrvwAzTBrw3CWacwT5KClF2NJUkg8jMMnxwh6xO6CvgG4zeK5bDRAql
         4peXdBbFNqKlUNlFyvjbkhmt0Q05xDNeOLh+Gands+IYs4hqaXdlprKD8TQdmhVbOOFK
         OVUjUNdZr5T9IwKWy/DwUkFfYw51xZtKiS0A5irPztD5u9F0jDd2qTaSyYRXYLVbwWL9
         bRxKcWrmPZ32piL0swwpJBVjx8azaB4gDUHYDk3ODI3yYkO16SFK2ePbIla1JVTorQ5d
         U8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTJH8jxW+qdbO+0po4BigY2q3TK8TME8iG7XZO+Phis=;
        b=QeHlokFfWwM+EgSyAHwM7g04NtSERGXuvgRsMgyTQPTUvHJwAd9AHeyjlAwWRliEsp
         fBYyc6R/5S+BetayHENrOUiQ4pnqycHEavl0o4kmjdpdErYYT+ptaMFQQ/Fj7zwu8d9b
         rS9/psKi3wqtymud0IBh/E5ts4szo0VYCPx0quew2b/bg8n22Zsu9vQvUQx/TCYp7k1L
         uDclYrYonjGpARRZ1TTPgk0hC2Dy8QkXK/T4k7Wj8T6LCvxWgYxxaTVlI2qKnNivk9u0
         c3vHYQiNTz1gmVwznUQQXVWNN9lX7oUDjfKwvd835FlWRxw/ygZ6Kqz1ETArPPi2NjKP
         7YCw==
X-Gm-Message-State: ANoB5pkKOSyz3fu6MG8N1g10SVjS2Irr0dUgIrObs9Kp33lQZz/SVak8
        E9/J++IXzTZ3snd9BmF9JF+c0V2xujwWiQ==
X-Google-Smtp-Source: AA0mqf4miGWGBsTd4uI1pFDvkP53ISmVgVui8fT8omIEtoNwTbO0+kwoijlxS54hMRUVR+X4VpMVeA==
X-Received: by 2002:a62:1a94:0:b0:56b:dae1:e946 with SMTP id a142-20020a621a94000000b0056bdae1e946mr28886574pfa.28.1671155239956;
        Thu, 15 Dec 2022 17:47:19 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w7-20020a626207000000b00562677968aesm251550pfb.72.2022.12.15.17.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 17:47:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] e-mail workflow: Message-ID is spelled with ID in both
 capital letters
Date:   Fri, 16 Dec 2022 10:47:19 +0900
Message-ID: <xmqqsfhgnmqg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We used to write "Message-Id:" and "Message-ID:" pretty much
interchangeably, and the header name is defined to be case
insensitive by the RFCs, but the canonical form "Message-ID:" is
used throughout the RFC documents, so let's imitate it ourselves.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/MyFirstContribution.txt | 14 +++----
 Documentation/git-format-patch.txt    |  4 +-
 Documentation/git-send-email.txt      |  2 +-
 git-send-email.perl                   |  4 +-
 log-tree.c                            |  2 +-
 mailinfo.c                            |  4 +-
 t/t4014-format-patch.sh               | 56 +++++++++++++--------------
 t/t4150-am.sh                         |  8 ++--
 t/t4258/mbox                          |  2 +-
 t/t5100/msg0002                       |  2 +-
 t/t5100/msg0003                       |  2 +-
 t/t5100/msg0012--message-id           |  2 +-
 t/t5100/quoted-cr.mbox                |  4 +-
 t/t5100/sample.mbox                   |  6 +--
 t/t9001-send-email.sh                 | 38 +++++++++---------
 15 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index ccfd0cb5f3..2f8b7d597f 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1171,21 +1171,21 @@ between your last version and now, if it's something significant. You do not
 need the exact same body in your second cover letter; focus on explaining to
 reviewers the changes you've made that may not be as visible.
 
-You will also need to go and find the Message-Id of your previous cover letter.
+You will also need to go and find the Message-ID of your previous cover letter.
 You can either note it when you send the first series, from the output of `git
 send-email`, or you can look it up on the
 https://lore.kernel.org/git[mailing list]. Find your cover letter in the
-archives, click on it, then click "permalink" or "raw" to reveal the Message-Id
+archives, click on it, then click "permalink" or "raw" to reveal the Message-ID
 header. It should match:
 
 ----
-Message-Id: <foo.12345.author@example.com>
+Message-ID: <foo.12345.author@example.com>
 ----
 
-Your Message-Id is `<foo.12345.author@example.com>`. This example will be used
-below as well; make sure to replace it with the correct Message-Id for your
-**previous cover letter** - that is, if you're sending v2, use the Message-Id
-from v1; if you're sending v3, use the Message-Id from v2.
+Your Message-ID is `<foo.12345.author@example.com>`. This example will be used
+below as well; make sure to replace it with the correct Message-ID for your
+**previous cover letter** - that is, if you're sending v2, use the Message-ID
+from v1; if you're sending v3, use the Message-ID from v2.
 
 While you're looking at the email, you should also note who is CC'd, as it's
 common practice in the mailing list to keep all CCs on a thread. You can add
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index dfcc7da4c2..508f3ae2c0 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -99,7 +99,7 @@ To omit patch numbers from the subject, use `-N`.
 
 If given `--thread`, `git-format-patch` will generate `In-Reply-To` and
 `References` headers to make the second and subsequent patch mails appear
-as replies to the first mail; this also generates a `Message-Id` header to
+as replies to the first mail; this also generates a `Message-ID` header to
 reference.
 
 OPTIONS
@@ -163,7 +163,7 @@ include::diff-options.txt[]
 --no-thread::
 	Controls addition of `In-Reply-To` and `References` headers to
 	make the second and subsequent mails appear as replies to the
-	first.  Also controls generation of the `Message-Id` header to
+	first.  Also controls generation of the `Message-ID` header to
 	reference.
 +
 The optional <style> argument can be either `shallow` or `deep`.
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 765b2df853..b0f438ec99 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -93,7 +93,7 @@ See the CONFIGURATION section for `sendemail.multiEdit`.
 
 --in-reply-to=<identifier>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
-	reply to the given Message-Id, which avoids breaking threads to
+	reply to the given Message-ID, which avoids breaking threads to
 	provide a new patch series.
 	The second and subsequent emails will be sent as replies according to
 	the `--[no-]chain-reply-to` setting.
diff --git a/git-send-email.perl b/git-send-email.perl
index 5861e99a6e..092b8938c8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1530,7 +1530,7 @@ sub send_message {
 To: $to${ccline}
 Subject: $subject
 Date: $date
-Message-Id: $message_id
+Message-ID: $message_id
 ";
 	if ($use_xmailer) {
 		$header .= "X-Mailer: git-send-email $gitversion\n";
@@ -1825,7 +1825,7 @@ sub process_file {
 				$has_mime_version = 1;
 				push @xh, $_;
 			}
-			elsif (/^Message-Id: (.*)/i) {
+			elsif (/^Message-ID: (.*)/i) {
 				$message_id = $1;
 			}
 			elsif (/^Content-Transfer-Encoding: (.*)/i) {
diff --git a/log-tree.c b/log-tree.c
index 1dd5fcbf7b..bbaf26c6b6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -440,7 +440,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 	fprintf(opt->diffopt.file, "From %s Mon Sep 17 00:00:00 2001\n", name);
 	graph_show_oneline(opt->graph);
 	if (opt->message_id) {
-		fprintf(opt->diffopt.file, "Message-Id: <%s>\n", opt->message_id);
+		fprintf(opt->diffopt.file, "Message-ID: <%s>\n", opt->message_id);
 		graph_show_oneline(opt->graph);
 	}
 	if (opt->ref_message_ids && opt->ref_message_ids->nr > 0) {
diff --git a/mailinfo.c b/mailinfo.c
index 833d28612f..580c2316a9 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -597,7 +597,7 @@ static int check_header(struct mailinfo *mi,
 		ret = 1;
 		goto check_header_out;
 	}
-	if (parse_header(line, "Message-Id", mi, &sb)) {
+	if (parse_header(line, "Message-ID", mi, &sb)) {
 		if (mi->add_message_id)
 			mi->message_id = strbuf_detach(&sb, NULL);
 		ret = 1;
@@ -829,7 +829,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	if (patchbreak(line)) {
 		if (mi->message_id)
 			strbuf_addf(&mi->log_message,
-				    "Message-Id: %s\n", mi->message_id);
+				    "Message-ID: %s\n", mi->message_id);
 		return 1;
 	}
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index de1da4673d..533d21fcaf 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -445,13 +445,13 @@ test_expect_success 'no threading' '
 
 cat >expect.thread <<EOF
 ---
-Message-Id: <0>
+Message-ID: <0>
 ---
-Message-Id: <1>
+Message-ID: <1>
 In-Reply-To: <0>
 References: <0>
 ---
-Message-Id: <2>
+Message-ID: <2>
 In-Reply-To: <0>
 References: <0>
 EOF
@@ -462,15 +462,15 @@ test_expect_success 'thread' '
 
 cat >expect.in-reply-to <<EOF
 ---
-Message-Id: <0>
+Message-ID: <0>
 In-Reply-To: <1>
 References: <1>
 ---
-Message-Id: <2>
+Message-ID: <2>
 In-Reply-To: <1>
 References: <1>
 ---
-Message-Id: <3>
+Message-ID: <3>
 In-Reply-To: <1>
 References: <1>
 EOF
@@ -482,17 +482,17 @@ test_expect_success 'thread in-reply-to' '
 
 cat >expect.cover-letter <<EOF
 ---
-Message-Id: <0>
+Message-ID: <0>
 ---
-Message-Id: <1>
+Message-ID: <1>
 In-Reply-To: <0>
 References: <0>
 ---
-Message-Id: <2>
+Message-ID: <2>
 In-Reply-To: <0>
 References: <0>
 ---
-Message-Id: <3>
+Message-ID: <3>
 In-Reply-To: <0>
 References: <0>
 EOF
@@ -503,21 +503,21 @@ test_expect_success 'thread cover-letter' '
 
 cat >expect.cl-irt <<EOF
 ---
-Message-Id: <0>
+Message-ID: <0>
 In-Reply-To: <1>
 References: <1>
 ---
-Message-Id: <2>
+Message-ID: <2>
 In-Reply-To: <0>
 References: <1>
 	<0>
 ---
-Message-Id: <3>
+Message-ID: <3>
 In-Reply-To: <0>
 References: <1>
 	<0>
 ---
-Message-Id: <4>
+Message-ID: <4>
 In-Reply-To: <0>
 References: <1>
 	<0>
@@ -535,13 +535,13 @@ test_expect_success 'thread explicit shallow' '
 
 cat >expect.deep <<EOF
 ---
-Message-Id: <0>
+Message-ID: <0>
 ---
-Message-Id: <1>
+Message-ID: <1>
 In-Reply-To: <0>
 References: <0>
 ---
-Message-Id: <2>
+Message-ID: <2>
 In-Reply-To: <1>
 References: <0>
 	<1>
@@ -553,16 +553,16 @@ test_expect_success 'thread deep' '
 
 cat >expect.deep-irt <<EOF
 ---
-Message-Id: <0>
+Message-ID: <0>
 In-Reply-To: <1>
 References: <1>
 ---
-Message-Id: <2>
+Message-ID: <2>
 In-Reply-To: <0>
 References: <1>
 	<0>
 ---
-Message-Id: <3>
+Message-ID: <3>
 In-Reply-To: <2>
 References: <1>
 	<0>
@@ -576,18 +576,18 @@ test_expect_success 'thread deep in-reply-to' '
 
 cat >expect.deep-cl <<EOF
 ---
-Message-Id: <0>
+Message-ID: <0>
 ---
-Message-Id: <1>
+Message-ID: <1>
 In-Reply-To: <0>
 References: <0>
 ---
-Message-Id: <2>
+Message-ID: <2>
 In-Reply-To: <1>
 References: <0>
 	<1>
 ---
-Message-Id: <3>
+Message-ID: <3>
 In-Reply-To: <2>
 References: <0>
 	<1>
@@ -600,22 +600,22 @@ test_expect_success 'thread deep cover-letter' '
 
 cat >expect.deep-cl-irt <<EOF
 ---
-Message-Id: <0>
+Message-ID: <0>
 In-Reply-To: <1>
 References: <1>
 ---
-Message-Id: <2>
+Message-ID: <2>
 In-Reply-To: <0>
 References: <1>
 	<0>
 ---
-Message-Id: <3>
+Message-ID: <3>
 In-Reply-To: <2>
 References: <1>
 	<0>
 	<2>
 ---
-Message-Id: <4>
+Message-ID: <4>
 In-Reply-To: <3>
 References: <1>
 	<0>
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index cdad4b6880..95b48103b8 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -103,7 +103,7 @@ test_expect_success setup '
 
 	git format-patch --stdout first >patch1 &&
 	{
-		echo "Message-Id: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>" &&
+		echo "Message-ID: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>" &&
 		echo "X-Fake-Field: Line One" &&
 		echo "X-Fake-Field: Line Two" &&
 		echo "X-Fake-Field: Line Three" &&
@@ -910,7 +910,7 @@ test_expect_success 'am --message-id really adds the message id' '
 	git am --message-id patch1.eml &&
 	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD | tail -n1 >actual &&
-	grep Message-Id patch1.eml >expected &&
+	grep Message-ID patch1.eml >expected &&
 	test_cmp expected actual
 '
 
@@ -922,7 +922,7 @@ test_expect_success 'am.messageid really adds the message id' '
 	git am patch1.eml &&
 	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD | tail -n1 >actual &&
-	grep Message-Id patch1.eml >expected &&
+	grep Message-ID patch1.eml >expected &&
 	test_cmp expected actual
 '
 
@@ -933,7 +933,7 @@ test_expect_success 'am --message-id -s signs off after the message id' '
 	git am -s --message-id patch1.eml &&
 	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD | tail -n2 | head -n1 >actual &&
-	grep Message-Id patch1.eml >expected &&
+	grep Message-ID patch1.eml >expected &&
 	test_cmp expected actual
 '
 
diff --git a/t/t4258/mbox b/t/t4258/mbox
index c62819f3d2..1ae528ba78 100644
--- a/t/t4258/mbox
+++ b/t/t4258/mbox
@@ -2,7 +2,7 @@ From: A U Thor <mail@example.com>
 To: list@example.org
 Subject: [PATCH v2] sample
 Date: Mon,  3 Aug 2020 22:40:55 +0700
-Message-Id: <msg-id@example.com>
+Message-ID: <msg-id@example.com>
 Content-Type: text/plain; charset="utf-8"
 Content-Transfer-Encoding: base64
 
diff --git a/t/t5100/msg0002 b/t/t5100/msg0002
index e2546ec733..1089382425 100644
--- a/t/t5100/msg0002
+++ b/t/t5100/msg0002
@@ -3,7 +3,7 @@ message:
 
 From: Nit Picker <nit.picker@example.net>
 Subject: foo is too old
-Message-Id: <nitpicker.12121212@example.net>
+Message-ID: <nitpicker.12121212@example.net>
 
 Hopefully this would fix the problem stated there.
 
diff --git a/t/t5100/msg0003 b/t/t5100/msg0003
index 1ac68101b1..3402b534a6 100644
--- a/t/t5100/msg0003
+++ b/t/t5100/msg0003
@@ -3,7 +3,7 @@ message:
 
 From: Nit Picker <nit.picker@example.net>
 Subject: foo is too old
-Message-Id: <nitpicker.12121212@example.net>
+Message-ID: <nitpicker.12121212@example.net>
 
 Hopefully this would fix the problem stated there.
 
diff --git a/t/t5100/msg0012--message-id b/t/t5100/msg0012--message-id
index 376e26e9ae..44482958ce 100644
--- a/t/t5100/msg0012--message-id
+++ b/t/t5100/msg0012--message-id
@@ -5,4 +5,4 @@ docutils заменён на python-docutils
 python-docutils. В то время как сам rest2web не нужен.
 
 Signed-off-by: Dmitriy Blinov <bda@mnsspb.ru>
-Message-Id: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>
+Message-ID: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>
diff --git a/t/t5100/quoted-cr.mbox b/t/t5100/quoted-cr.mbox
index 909021bb7a..a529d4de08 100644
--- a/t/t5100/quoted-cr.mbox
+++ b/t/t5100/quoted-cr.mbox
@@ -3,7 +3,7 @@ From: A U Thor <mail@example.com>
 To: list@example.org
 Subject: [PATCH v2] sample
 Date: Mon,  3 Aug 2020 22:40:55 +0700
-Message-Id: <msg-id@example.com>
+Message-ID: <msg-id@example.com>
 Content-Type: text/plain; charset="utf-8"
 Content-Transfer-Encoding: base64
 
@@ -27,7 +27,7 @@ From: A U Thor <mail@example.com>
 To: list@example.org
 Subject: [PATCH v2] sample
 Date: Mon,  3 Aug 2020 22:40:55 +0700
-Message-Id: <msg-id2@example.com>
+Message-ID: <msg-id2@example.com>
 Content-Type: text/plain; charset="utf-8"
 Content-Transfer-Encoding: base64
 
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 6d4d0e4474..4a54ee5171 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -35,7 +35,7 @@ message:
 
 From: Nit Picker <nit.picker@example.net>
 Subject: foo is too old
-Message-Id: <nitpicker.12121212@example.net>
+Message-ID: <nitpicker.12121212@example.net>
 
 Hopefully this would fix the problem stated there.
 
@@ -78,7 +78,7 @@ message:
 
 From: Nit Picker <nit.picker@example.net>
 Subject: foo is too old
-Message-Id: <nitpicker.12121212@example.net>
+Message-ID: <nitpicker.12121212@example.net>
 
 Hopefully this would fix the problem stated there.
 
@@ -508,7 +508,7 @@ From bda@mnsspb.ru Wed Nov 12 17:54:41 2008
 From: Dmitriy Blinov <bda@mnsspb.ru>
 To: navy-patches@dinar.mns.mnsspb.ru
 Date: Wed, 12 Nov 2008 17:54:41 +0300
-Message-Id: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>
+Message-ID: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>
 X-Mailer: git-send-email 1.5.6.5
 MIME-Version: 1.0
 Content-Type: text/plain;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1130ef21b3..5c2c282d08 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -12,7 +12,7 @@ PREREQ="PERL"
 
 replace_variable_fields () {
 	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
-		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
+		-e "s/^\(Message-ID:\).*/\1 MESSAGE-ID-STRING/" \
 		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/"
 }
 
@@ -225,7 +225,7 @@ Cc: cc@example.com,
 	two@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 In-Reply-To: <unique-message-id@example.com>
 References: <unique-message-id@example.com>
@@ -617,7 +617,7 @@ test_expect_success $PREREQ 'In-Reply-To without --chain-reply-to' '
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt1 >actual &&
 	test_cmp expect actual &&
 	# Second and subsequent messages are replies to the first one
-	sed -n -e "s/^Message-Id: *\(.*\)/\1/p" msgtxt1 >expect &&
+	sed -n -e "s/^Message-ID: *\(.*\)/\1/p" msgtxt1 >expect &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt2 >actual &&
 	test_cmp expect actual &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt3 >actual &&
@@ -637,10 +637,10 @@ test_expect_success $PREREQ 'In-Reply-To with --chain-reply-to' '
 		2>errors &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt1 >actual &&
 	test_cmp expect actual &&
-	sed -n -e "s/^Message-Id: *\(.*\)/\1/p" msgtxt1 >expect &&
+	sed -n -e "s/^Message-ID: *\(.*\)/\1/p" msgtxt1 >expect &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt2 >actual &&
 	test_cmp expect actual &&
-	sed -n -e "s/^Message-Id: *\(.*\)/\1/p" msgtxt2 >expect &&
+	sed -n -e "s/^Message-ID: *\(.*\)/\1/p" msgtxt2 >expect &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt3 >actual &&
 	test_cmp expect actual
 '
@@ -713,7 +713,7 @@ Cc: cc@example.com,
 	two@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -759,7 +759,7 @@ Cc: A <author@example.com>,
 	two@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -796,7 +796,7 @@ Cc: A <author@example.com>,
 	C O Mitter <committer@example.com>
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -824,7 +824,7 @@ From: Example <from@example.com>
 To: to@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -860,7 +860,7 @@ Cc: A <author@example.com>,
 	cc-cmd@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -893,7 +893,7 @@ Cc: A <author@example.com>,
 	two@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -926,7 +926,7 @@ Cc: A <author@example.com>,
 	two@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -963,7 +963,7 @@ Cc: A <author@example.com>,
 	C O Mitter <committer@example.com>
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -993,7 +993,7 @@ Cc: A <author@example.com>,
 	C O Mitter <committer@example.com>
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -1478,7 +1478,7 @@ test_expect_success $PREREQ 'To headers from files reset each patch' '
 test_expect_success $PREREQ 'setup expect' '
 cat >email-using-8bit <<\EOF
 From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
-Message-Id: <bogus-message-id@example.com>
+Message-ID: <bogus-message-id@example.com>
 From: author@example.com
 Date: Sat, 12 Jun 2010 15:53:58 +0200
 Subject: subject goes here
@@ -1564,7 +1564,7 @@ test_expect_success $PREREQ '--8bit-encoding overrides sendemail.8bitEncoding' '
 test_expect_success $PREREQ 'setup expect' '
 	cat >email-using-8bit <<-\EOF
 	From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
-	Message-Id: <bogus-message-id@example.com>
+	Message-ID: <bogus-message-id@example.com>
 	From: author@example.com
 	Date: Sat, 12 Jun 2010 15:53:58 +0200
 	Subject: Dieser Betreff enthält auch einen Umlaut!
@@ -1593,7 +1593,7 @@ test_expect_success $PREREQ '--8bit-encoding also treats subject' '
 test_expect_success $PREREQ 'setup expect' '
 	cat >email-using-8bit <<-\EOF
 	From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
-	Message-Id: <bogus-message-id@example.com>
+	Message-ID: <bogus-message-id@example.com>
 	From: A U Thor <author@example.com>
 	Date: Sat, 12 Jun 2010 15:53:58 +0200
 	Content-Type: text/plain; charset=UTF-8
@@ -1674,7 +1674,7 @@ test_expect_success $PREREQ '8-bit and sendemail.transferencoding=base64' '
 test_expect_success $PREREQ 'setup expect' '
 	cat >email-using-qp <<-\EOF
 	From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
-	Message-Id: <bogus-message-id@example.com>
+	Message-ID: <bogus-message-id@example.com>
 	From: A U Thor <author@example.com>
 	Date: Sat, 12 Jun 2010 15:53:58 +0200
 	MIME-Version: 1.0
@@ -1700,7 +1700,7 @@ test_expect_success $PREREQ 'convert from quoted-printable to base64' '
 test_expect_success $PREREQ 'setup expect' "
 tr -d '\\015' | tr '%' '\\015' >email-using-crlf <<EOF
 From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
-Message-Id: <bogus-message-id@example.com>
+Message-ID: <bogus-message-id@example.com>
 From: A U Thor <author@example.com>
 Date: Sat, 12 Jun 2010 15:53:58 +0200
 Content-Type: text/plain; charset=UTF-8
-- 
2.39.0-56-g57e2c6ebbe

