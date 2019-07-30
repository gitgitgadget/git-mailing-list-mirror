Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415181F462
	for <e@80x24.org>; Tue, 30 Jul 2019 21:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387741AbfG3VY6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 17:24:58 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:55415 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387649AbfG3VY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 17:24:58 -0400
Received: by mail-wm1-f42.google.com with SMTP id a15so58560588wmj.5
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ml0hTW0Axl4iZfBiaNuPsJyYCdGYLnX7unFGiBMkdwk=;
        b=TOLhg6YSaH/vqKQ2o/Pq7sA6IKZq08jMs9+ZmmeMNCggDulB4R7+vYlsUpFa41Zp3g
         ap7+W85TTdHumGfS0My89HNam81L3bvJO8aW6p5QttEXFuhOXq9lfjH4rVmvZoonA60k
         Y3uC7jRtSgfz9Do0jzeoCBDPi0boEsMPUqgIGjiGu7GL0RVwmOUuXRz9p3m1ze0mxuZz
         XdbOEywn+AgtDSaxiBUYrhv2b71K4YLaNcDtfXXZNh7SoAwTXrU7rxsVxOAZ1OGHM4su
         4th4DL1kXIpKOZ1bxs23fv9XYEGxUc1xRpNmH+cb8I0qXLGc2LPzoQ8QRFdI7bW/NT0Z
         WXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ml0hTW0Axl4iZfBiaNuPsJyYCdGYLnX7unFGiBMkdwk=;
        b=dhDfbpKxVJqNsc25CRCxXrVZj0q5jCmuSabob0pqhEMh1YiV8Bpu9gmEY0kGMDbI20
         gjx+rNj8t8bkRUJbCTz61865HwEvbSg9I8dIk9g4NoRn8y3ibNpiF7FSNepFbHvCy1LK
         YBXvTqVIaDzDKBocSm+GLjbJwsH/Rv2J/mrVoklfm+weYVJz+c03Qe+SISclS0B++B2I
         OzkPArXhi4YjmALtHNeVv5vLmzP2FsJbKWpBx7v7IAog7CU85fLvxw6NQN1uxPO/PmKc
         qmsJ9do2u9KVw0ICzaOX0YTetmkn5etmW0gY/JkDAj0/ga397RZw1hi4zzHBbj85rcFb
         Z+SQ==
X-Gm-Message-State: APjAAAU78HcLrSxGs5WCXv10UiExaxKIG4qYQNfrwPgV5hrlxHJnRN+1
        DhrlJSh4zXduCcYh8j6RiemGl+DTNpGFvgln8Qk3VJcvlcwRI5rImsKE10JLR+APgxA7BScSsUo
        CJ0ZYI+o716Xs5Es58Mr1J6jNc/e7PvcoeF+dKLMIJIlNASyrFJYwxSMQfOQ2xdXKisva1N1jE6
        I+SRgx6Zsw3ZgkaNo=
X-Google-Smtp-Source: APXvYqytjcvS1ojcuEcwhNKkTYoQtuNIzhF86oAP0vo47OA6AcD9DdDnLLeeSDlY5i+TnIkO0H2qhw==
X-Received: by 2002:a7b:c104:: with SMTP id w4mr110937668wmi.42.1564521894761;
        Tue, 30 Jul 2019 14:24:54 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p63sm17547120wmp.45.2019.07.30.14.24.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 14:24:54 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@openvz.org>
Subject: [PATCHv4] send-email: Ask if a patch should be sent twice
Date:   Tue, 30 Jul 2019 22:24:53 +0100
Message-Id: <20190730212453.28301-1-dima@arista.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was almost certain that git won't let me send the same patch twice,
but today I've managed to double-send a directory by a mistake:
	git send-email --to linux-kernel@vger.kernel.org /tmp/timens/
	    --cc 'Dmitry Safonov <0x7f454c46@gmail.com>' /tmp/timens/`

[I haven't noticed that I put the directory twice ^^]

Prevent this shipwreck from happening again by asking if a patch
is sent multiple times on purpose.

link: https://lkml.kernel.org/r/4d53ebc7-d5b2-346e-c383-606401d19d3a@gmail.com
Cc: Andrei Vagin <avagin@openvz.org>
Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
v4: Don't fail the test with GIT_TEST_GETTEXT_POISON=true
v3: Use `test_i18ngrep` instead of plain `grep`
v2: Moved the check under --validate,
    fixed tests,
    added a new test,
    updated documentation for --validate

 Documentation/git-send-email.txt |  2 ++
 git-send-email.perl              | 14 ++++++++++++++
 t/t9001-send-email.sh            | 15 +++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index d93e5d0f58f0..0441bb1b5d3b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -421,6 +421,8 @@ have been specified, in which case default to 'compose'.
 			('auto', 'base64', or 'quoted-printable') is used;
 			this is due to SMTP limits as described by
 			http://www.ietf.org/rfc/rfc5322.txt.
+		*	Ask confirmation before sending patches multiple times
+			if the supplied patches set overlaps.
 --
 +
 Default is the value of `sendemail.validate`; if this is not set,
diff --git a/git-send-email.perl b/git-send-email.perl
index 5f92c89c1c1b..c1638d06f81d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -688,6 +688,9 @@ sub is_format_patch_arg {
 @files = handle_backup_files(@files);
 
 if ($validate) {
+	my %seen;
+	my @dupes = grep { $seen{$_}++ } @files;
+
 	foreach my $f (@files) {
 		unless (-p $f) {
 			my $error = validate_patch($f, $target_xfer_encoding);
@@ -695,6 +698,17 @@ sub is_format_patch_arg {
 						  $f, $error);
 		}
 	}
+	if (@dupes) {
+		printf(__("Patches specified several times: \n"));
+		printf(__("%s \n" x @dupes), @dupes);
+		$_ = ask(__("Do you want to send those patches several times? Y/n "),
+			default => "y",
+			valid_re => qr/^(?:yes|y|no|n)/i);
+		if (/^n/i) {
+			cleanup_compose_files();
+			exit(0);
+		}
+	}
 }
 
 if (@files) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 997f90b42b3e..8954f8e38d90 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -555,6 +555,7 @@ test_expect_success $PREREQ 'In-Reply-To without --chain-reply-to' '
 		--no-chain-reply-to \
 		--in-reply-to="$(cat expect)" \
 		--smtp-server="$(pwd)/fake.sendmail" \
+		--no-validate \
 		$patches $patches $patches \
 		2>errors &&
 	# The first message is a reply to --in-reply-to
@@ -577,6 +578,7 @@ test_expect_success $PREREQ 'In-Reply-To with --chain-reply-to' '
 		--chain-reply-to \
 		--in-reply-to="$(cat expect)" \
 		--smtp-server="$(pwd)/fake.sendmail" \
+		--no-validate \
 		$patches $patches $patches \
 		2>errors &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt1 >actual &&
@@ -589,6 +591,19 @@ test_expect_success $PREREQ 'In-Reply-To with --chain-reply-to' '
 	test_cmp expect actual
 '
 
+test_expect_success $PREREQ 'ask confirmation for double-send' '
+	clean_fake_sendmail &&
+	echo y | \
+		GIT_SEND_EMAIL_NOTTY=1 \
+		git send-email --from=author@example.com \
+			--to=nobody@example.com \
+			--smtp-server="$(pwd)/fake.sendmail" \
+			--validate \
+			$patches $patches $patches \
+			>stdout &&
+	test_i18ngrep ! "Patches specified several times: " stdout
+'
+
 test_expect_success $PREREQ 'setup fake editor' '
 	write_script fake-editor <<-\EOF
 	echo fake edit >>"$1"
-- 
2.22.0

