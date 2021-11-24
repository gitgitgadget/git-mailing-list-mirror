Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EBAC433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 01:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhKXBk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 20:40:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56724 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhKXBk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 20:40:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73551FFED5;
        Tue, 23 Nov 2021 20:37:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gPS7B65AmWqs
        FpzTYgE45rgBpx9lbpMrdgQ/IUoEl44=; b=MNemlHC5ze2N/bzWtqgskb/Oc0Zk
        4QFtZZ7qZSuiwyij32muHjcopJ2OtVSDxvqI9iH7fN9cPJzZzNeQfaLXGXGEVKjX
        YIs9bB5VzqJ/95YV36zcjnq92NZ1FlzXDOOb2Hj5TQcDLFBJl5yDABe6fVLteBkW
        dVw3UzrUgK5cCVE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AE3FFFED4;
        Tue, 23 Nov 2021 20:37:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF733FFED3;
        Tue, 23 Nov 2021 20:37:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, workflows@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags
 'Reported:' and 'Reviewed:'
References: <cover.1637566224.git.linux@leemhuis.info>
        <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
        <20211123185237.M476855@dcvr>
Date:   Tue, 23 Nov 2021 17:37:16 -0800
In-Reply-To: <20211123185237.M476855@dcvr> (Eric Wong's message of "Tue, 23
        Nov 2021 18:52:37 +0000")
Message-ID: <xmqq4k825o6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0F1D462C-4CC7-11EC-B0BF-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> git send-email's capitalization does annoy me and I've looked
> into changing it; but there's a bunch of tests and probably
> dependent code that also need to be updated...

It does annoy me, too, and I do not mind if it gets "fixed", but I
do not know if the cost for vetting a bulk update like that is worth
it.  There is another one outside send-email in log-tree.c that is
responsible for output from format-patch.

Here is the extent of damage in my trial change that seems to pass
the tests locally.

 Documentation/MyFirstContribution.txt | 14 ++++-----
 Documentation/git-format-patch.txt    |  4 +--
 Documentation/git-send-email.txt      |  2 +-
 git-send-email.perl                   |  4 +--
 log-tree.c                            |  2 +-
 mailinfo.c                            |  4 +--
 t/t4014-format-patch.sh               | 56 +++++++++++++++++------------=
------
 t/t4150-am.sh                         |  8 ++---
 t/t4258/mbox                          |  2 +-
 t/t5100/msg0002                       |  2 +-
 t/t5100/msg0003                       |  2 +-
 t/t5100/msg0012--message-id           |  2 +-
 t/t5100/quoted-cr.mbox                |  4 +--
 t/t5100/sample.mbox                   |  6 ++--
 t/t9001-send-email.sh                 | 38 ++++++++++++------------
 15 files changed, 75 insertions(+), 75 deletions(-)

diff --git i/Documentation/MyFirstContribution.txt w/Documentation/MyFirs=
tContribution.txt
index b20bc8e914..91cb204d52 100644
--- i/Documentation/MyFirstContribution.txt
+++ w/Documentation/MyFirstContribution.txt
@@ -1071,21 +1071,21 @@ between your last version and now, if it's someth=
ing significant. You do not
 need the exact same body in your second cover letter; focus on explainin=
g to
 reviewers the changes you've made that may not be as visible.
=20
-You will also need to go and find the Message-Id of your previous cover =
letter.
+You will also need to go and find the Message-ID of your previous cover =
letter.
 You can either note it when you send the first series, from the output o=
f `git
 send-email`, or you can look it up on the
 https://lore.kernel.org/git[mailing list]. Find your cover letter in the
-archives, click on it, then click "permalink" or "raw" to reveal the Mes=
sage-Id
+archives, click on it, then click "permalink" or "raw" to reveal the Mes=
sage-ID
 header. It should match:
=20
 ----
-Message-Id: <foo.12345.author@example.com>
+Message-ID: <foo.12345.author@example.com>
 ----
=20
-Your Message-Id is `<foo.12345.author@example.com>`. This example will b=
e used
-below as well; make sure to replace it with the correct Message-Id for y=
our
-**previous cover letter** - that is, if you're sending v2, use the Messa=
ge-Id
-from v1; if you're sending v3, use the Message-Id from v2.
+Your Message-ID is `<foo.12345.author@example.com>`. This example will b=
e used
+below as well; make sure to replace it with the correct Message-ID for y=
our
+**previous cover letter** - that is, if you're sending v2, use the Messa=
ge-ID
+from v1; if you're sending v3, use the Message-ID from v2.
=20
 While you're looking at the email, you should also note who is CC'd, as =
it's
 common practice in the mailing list to keep all CCs on a thread. You can=
 add
diff --git i/Documentation/git-format-patch.txt w/Documentation/git-forma=
t-patch.txt
index 113eabc107..daf911f249 100644
--- i/Documentation/git-format-patch.txt
+++ w/Documentation/git-format-patch.txt
@@ -99,7 +99,7 @@ To omit patch numbers from the subject, use `-N`.
=20
 If given `--thread`, `git-format-patch` will generate `In-Reply-To` and
 `References` headers to make the second and subsequent patch mails appea=
r
-as replies to the first mail; this also generates a `Message-Id` header =
to
+as replies to the first mail; this also generates a `Message-ID` header =
to
 reference.
=20
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
diff --git i/Documentation/git-send-email.txt w/Documentation/git-send-em=
ail.txt
index 3db4eab4ba..086f132229 100644
--- i/Documentation/git-send-email.txt
+++ w/Documentation/git-send-email.txt
@@ -91,7 +91,7 @@ See the CONFIGURATION section for `sendemail.multiEdit`=
.
=20
 --in-reply-to=3D<identifier>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
-	reply to the given Message-Id, which avoids breaking threads to
+	reply to the given Message-ID, which avoids breaking threads to
 	provide a new patch series.
 	The second and subsequent emails will be sent as replies according to
 	the `--[no-]chain-reply-to` setting.
diff --git i/git-send-email.perl w/git-send-email.perl
index 5262d88ee3..a61134c7d3 100755
--- i/git-send-email.perl
+++ w/git-send-email.perl
@@ -1494,7 +1494,7 @@ sub send_message {
 To: $to${ccline}
 Subject: $subject
 Date: $date
-Message-Id: $message_id
+Message-ID: $message_id
 ";
 	if ($use_xmailer) {
 		$header .=3D "X-Mailer: git-send-email $gitversion\n";
@@ -1789,7 +1789,7 @@ sub process_file {
 				$has_mime_version =3D 1;
 				push @xh, $_;
 			}
-			elsif (/^Message-Id: (.*)/i) {
+			elsif (/^Message-ID: (.*)/i) {
 				$message_id =3D $1;
 			}
 			elsif (/^Content-Transfer-Encoding: (.*)/i) {
diff --git i/log-tree.c w/log-tree.c
index 644893fd8c..818cea5f12 100644
--- i/log-tree.c
+++ w/log-tree.c
@@ -428,7 +428,7 @@ void log_write_email_headers(struct rev_info *opt, st=
ruct commit *commit,
 	fprintf(opt->diffopt.file, "From %s Mon Sep 17 00:00:00 2001\n", name);
 	graph_show_oneline(opt->graph);
 	if (opt->message_id) {
-		fprintf(opt->diffopt.file, "Message-Id: <%s>\n", opt->message_id);
+		fprintf(opt->diffopt.file, "Message-ID: <%s>\n", opt->message_id);
 		graph_show_oneline(opt->graph);
 	}
 	if (opt->ref_message_ids && opt->ref_message_ids->nr > 0) {
diff --git i/mailinfo.c w/mailinfo.c
index 02f6f95357..855349cc0e 100644
--- i/mailinfo.c
+++ w/mailinfo.c
@@ -597,7 +597,7 @@ static int check_header(struct mailinfo *mi,
 		ret =3D 1;
 		goto check_header_out;
 	}
-	if (parse_header(line, "Message-Id", mi, &sb)) {
+	if (parse_header(line, "Message-ID", mi, &sb)) {
 		if (mi->add_message_id)
 			mi->message_id =3D strbuf_detach(&sb, NULL);
 		ret =3D 1;
@@ -829,7 +829,7 @@ static int handle_commit_msg(struct mailinfo *mi, str=
uct strbuf *line)
 	if (patchbreak(line)) {
 		if (mi->message_id)
 			strbuf_addf(&mi->log_message,
-				    "Message-Id: %s\n", mi->message_id);
+				    "Message-ID: %s\n", mi->message_id);
 		return 1;
 	}
=20
diff --git i/t/t4014-format-patch.sh w/t/t4014-format-patch.sh
index 712d4b5ddf..973899d165 100755
--- i/t/t4014-format-patch.sh
+++ w/t/t4014-format-patch.sh
@@ -445,13 +445,13 @@ test_expect_success 'no threading' '
=20
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
=20
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
=20
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
=20
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
=20
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
=20
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
=20
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
=20
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
diff --git i/t/t4150-am.sh w/t/t4150-am.sh
index 2aaaa0d7de..f41418c6e9 100755
--- i/t/t4150-am.sh
+++ w/t/t4150-am.sh
@@ -103,7 +103,7 @@ test_expect_success setup '
=20
 	git format-patch --stdout first >patch1 &&
 	{
-		echo "Message-Id: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>" &=
&
+		echo "Message-ID: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>" &=
&
 		echo "X-Fake-Field: Line One" &&
 		echo "X-Fake-Field: Line Two" &&
 		echo "X-Fake-Field: Line Three" &&
@@ -916,7 +916,7 @@ test_expect_success 'am --message-id really adds the =
message id' '
 	git am --message-id patch1.eml &&
 	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD | tail -n1 >actual &&
-	grep Message-Id patch1.eml >expected &&
+	grep Message-ID patch1.eml >expected &&
 	test_cmp expected actual
 '
=20
@@ -928,7 +928,7 @@ test_expect_success 'am.messageid really adds the mes=
sage id' '
 	git am patch1.eml &&
 	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD | tail -n1 >actual &&
-	grep Message-Id patch1.eml >expected &&
+	grep Message-ID patch1.eml >expected &&
 	test_cmp expected actual
 '
=20
@@ -939,7 +939,7 @@ test_expect_success 'am --message-id -s signs off aft=
er the message id' '
 	git am -s --message-id patch1.eml &&
 	test_path_is_missing .git/rebase-apply &&
 	git cat-file commit HEAD | tail -n2 | head -n1 >actual &&
-	grep Message-Id patch1.eml >expected &&
+	grep Message-ID patch1.eml >expected &&
 	test_cmp expected actual
 '
=20
diff --git i/t/t4258/mbox w/t/t4258/mbox
index c62819f3d2..1ae528ba78 100644
--- i/t/t4258/mbox
+++ w/t/t4258/mbox
@@ -2,7 +2,7 @@ From: A U Thor <mail@example.com>
 To: list@example.org
 Subject: [PATCH v2] sample
 Date: Mon,  3 Aug 2020 22:40:55 +0700
-Message-Id: <msg-id@example.com>
+Message-ID: <msg-id@example.com>
 Content-Type: text/plain; charset=3D"utf-8"
 Content-Transfer-Encoding: base64
=20
diff --git i/t/t5100/msg0002 w/t/t5100/msg0002
index e2546ec733..1089382425 100644
--- i/t/t5100/msg0002
+++ w/t/t5100/msg0002
@@ -3,7 +3,7 @@ message:
=20
 From: Nit Picker <nit.picker@example.net>
 Subject: foo is too old
-Message-Id: <nitpicker.12121212@example.net>
+Message-ID: <nitpicker.12121212@example.net>
=20
 Hopefully this would fix the problem stated there.
=20
diff --git i/t/t5100/msg0003 w/t/t5100/msg0003
index 1ac68101b1..3402b534a6 100644
--- i/t/t5100/msg0003
+++ w/t/t5100/msg0003
@@ -3,7 +3,7 @@ message:
=20
 From: Nit Picker <nit.picker@example.net>
 Subject: foo is too old
-Message-Id: <nitpicker.12121212@example.net>
+Message-ID: <nitpicker.12121212@example.net>
=20
 Hopefully this would fix the problem stated there.
=20
diff --git i/t/t5100/msg0012--message-id w/t/t5100/msg0012--message-id
index 376e26e9ae..44482958ce 100644
--- i/t/t5100/msg0012--message-id
+++ w/t/t5100/msg0012--message-id
@@ -5,4 +5,4 @@ docutils =D0=B7=D0=B0=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D0=BD=
=D0=B0 python-docutils
 python-docutils. =D0=92 =D1=82=D0=BE =D0=B2=D1=80=D0=B5=D0=BC=D1=8F =D0=BA=
=D0=B0=D0=BA =D1=81=D0=B0=D0=BC rest2web =D0=BD=D0=B5 =D0=BD=D1=83=D0=B6=D0=
=B5=D0=BD.
=20
 Signed-off-by: Dmitriy Blinov <bda@mnsspb.ru>
-Message-Id: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>
+Message-ID: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>
diff --git i/t/t5100/quoted-cr.mbox w/t/t5100/quoted-cr.mbox
index 909021bb7a..a529d4de08 100644
--- i/t/t5100/quoted-cr.mbox
+++ w/t/t5100/quoted-cr.mbox
@@ -3,7 +3,7 @@ From: A U Thor <mail@example.com>
 To: list@example.org
 Subject: [PATCH v2] sample
 Date: Mon,  3 Aug 2020 22:40:55 +0700
-Message-Id: <msg-id@example.com>
+Message-ID: <msg-id@example.com>
 Content-Type: text/plain; charset=3D"utf-8"
 Content-Transfer-Encoding: base64
=20
@@ -27,7 +27,7 @@ From: A U Thor <mail@example.com>
 To: list@example.org
 Subject: [PATCH v2] sample
 Date: Mon,  3 Aug 2020 22:40:55 +0700
-Message-Id: <msg-id2@example.com>
+Message-ID: <msg-id2@example.com>
 Content-Type: text/plain; charset=3D"utf-8"
 Content-Transfer-Encoding: base64
=20
diff --git i/t/t5100/sample.mbox w/t/t5100/sample.mbox
index 6d4d0e4474..4a54ee5171 100644
--- i/t/t5100/sample.mbox
+++ w/t/t5100/sample.mbox
@@ -35,7 +35,7 @@ message:
=20
 From: Nit Picker <nit.picker@example.net>
 Subject: foo is too old
-Message-Id: <nitpicker.12121212@example.net>
+Message-ID: <nitpicker.12121212@example.net>
=20
 Hopefully this would fix the problem stated there.
=20
@@ -78,7 +78,7 @@ message:
=20
 From: Nit Picker <nit.picker@example.net>
 Subject: foo is too old
-Message-Id: <nitpicker.12121212@example.net>
+Message-ID: <nitpicker.12121212@example.net>
=20
 Hopefully this would fix the problem stated there.
=20
@@ -508,7 +508,7 @@ From bda@mnsspb.ru Wed Nov 12 17:54:41 2008
 From: Dmitriy Blinov <bda@mnsspb.ru>
 To: navy-patches@dinar.mns.mnsspb.ru
 Date: Wed, 12 Nov 2008 17:54:41 +0300
-Message-Id: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>
+Message-ID: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>
 X-Mailer: git-send-email 1.5.6.5
 MIME-Version: 1.0
 Content-Type: text/plain;
diff --git i/t/t9001-send-email.sh w/t/t9001-send-email.sh
index aa0c20499b..ce09cf1fe3 100755
--- i/t/t9001-send-email.sh
+++ w/t/t9001-send-email.sh
@@ -11,7 +11,7 @@ PREREQ=3D"PERL"
=20
 replace_variable_fields () {
 	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
-		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
+		-e "s/^\(Message-ID:\).*/\1 MESSAGE-ID-STRING/" \
 		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/"
 }
=20
@@ -224,7 +224,7 @@ Cc: cc@example.com,
 	two@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 In-Reply-To: <unique-message-id@example.com>
 References: <unique-message-id@example.com>
@@ -616,7 +616,7 @@ test_expect_success $PREREQ 'In-Reply-To without --ch=
ain-reply-to' '
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt1 >actual &&
 	test_cmp expect actual &&
 	# Second and subsequent messages are replies to the first one
-	sed -n -e "s/^Message-Id: *\(.*\)/\1/p" msgtxt1 >expect &&
+	sed -n -e "s/^Message-ID: *\(.*\)/\1/p" msgtxt1 >expect &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt2 >actual &&
 	test_cmp expect actual &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt3 >actual &&
@@ -636,10 +636,10 @@ test_expect_success $PREREQ 'In-Reply-To with --cha=
in-reply-to' '
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
@@ -712,7 +712,7 @@ Cc: cc@example.com,
 	two@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -758,7 +758,7 @@ Cc: A <author@example.com>,
 	two@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -795,7 +795,7 @@ Cc: A <author@example.com>,
 	C O Mitter <committer@example.com>
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -823,7 +823,7 @@ From: Example <from@example.com>
 To: to@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -859,7 +859,7 @@ Cc: A <author@example.com>,
 	cc-cmd@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -892,7 +892,7 @@ Cc: A <author@example.com>,
 	two@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -925,7 +925,7 @@ Cc: A <author@example.com>,
 	two@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -962,7 +962,7 @@ Cc: A <author@example.com>,
 	C O Mitter <committer@example.com>
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -992,7 +992,7 @@ Cc: A <author@example.com>,
 	C O Mitter <committer@example.com>
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
-Message-Id: MESSAGE-ID-STRING
+Message-ID: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 MIME-Version: 1.0
 Content-Transfer-Encoding: 8bit
@@ -1477,7 +1477,7 @@ test_expect_success $PREREQ 'To headers from files =
reset each patch' '
 test_expect_success $PREREQ 'setup expect' '
 cat >email-using-8bit <<\EOF
 From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
-Message-Id: <bogus-message-id@example.com>
+Message-ID: <bogus-message-id@example.com>
 From: author@example.com
 Date: Sat, 12 Jun 2010 15:53:58 +0200
 Subject: subject goes here
@@ -1563,7 +1563,7 @@ test_expect_success $PREREQ '--8bit-encoding overri=
des sendemail.8bitEncoding' '
 test_expect_success $PREREQ 'setup expect' '
 	cat >email-using-8bit <<-\EOF
 	From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
-	Message-Id: <bogus-message-id@example.com>
+	Message-ID: <bogus-message-id@example.com>
 	From: author@example.com
 	Date: Sat, 12 Jun 2010 15:53:58 +0200
 	Subject: Dieser Betreff enth=C3=A4lt auch einen Umlaut!
@@ -1592,7 +1592,7 @@ test_expect_success $PREREQ '--8bit-encoding also t=
reats subject' '
 test_expect_success $PREREQ 'setup expect' '
 	cat >email-using-8bit <<-\EOF
 	From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
-	Message-Id: <bogus-message-id@example.com>
+	Message-ID: <bogus-message-id@example.com>
 	From: A U Thor <author@example.com>
 	Date: Sat, 12 Jun 2010 15:53:58 +0200
 	Content-Type: text/plain; charset=3DUTF-8
@@ -1673,7 +1673,7 @@ test_expect_success $PREREQ '8-bit and sendemail.tr=
ansferencoding=3Dbase64' '
 test_expect_success $PREREQ 'setup expect' '
 	cat >email-using-qp <<-\EOF
 	From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
-	Message-Id: <bogus-message-id@example.com>
+	Message-ID: <bogus-message-id@example.com>
 	From: A U Thor <author@example.com>
 	Date: Sat, 12 Jun 2010 15:53:58 +0200
 	MIME-Version: 1.0
@@ -1699,7 +1699,7 @@ test_expect_success $PREREQ 'convert from quoted-pr=
intable to base64' '
 test_expect_success $PREREQ 'setup expect' "
 tr -d '\\015' | tr '%' '\\015' >email-using-crlf <<EOF
 From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
-Message-Id: <bogus-message-id@example.com>
+Message-ID: <bogus-message-id@example.com>
 From: A U Thor <author@example.com>
 Date: Sat, 12 Jun 2010 15:53:58 +0200
 Content-Type: text/plain; charset=3DUTF-8
