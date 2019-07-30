Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7BB1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 16:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbfG3Q03 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 12:26:29 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:45721 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfG3Q03 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 12:26:29 -0400
Received: by mail-wr1-f41.google.com with SMTP id f9so66439120wre.12
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1K8hPLQ2DakBsaDPC9g3C+YDsVFN6Y7MG8VVURucy1Q=;
        b=aBIJql7rP6HY4DQ+X22dDsHJN7wwzp4gLezu0he02U0dkOL/vbBkTmtSGiddFRkTyh
         rYA2aJaRKjoLNFtVwn0we1UcgxP9/J6iDj16P2bo0m8JFhirHHnTQXbaXASbQkIfjIN5
         vbD2P5QRzNm2Eiv90l8y2AVr4TOZz4M95ru5wJmFIwQStCSDIaFvm+tA1LttAOded9Ag
         ITQpy1LHxJNGp/fxA0pnt5lrKA5ub0t8oKzyvP76AWtaWDXK7VLcCkiMxGnl89ZgXDFd
         3hDVQFRwkulcP5rbsxTOtzx3k16IQZFxkEFR5Ta+sGyMUN0szJ5YkmizMRN3C7/8jJ/2
         iBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1K8hPLQ2DakBsaDPC9g3C+YDsVFN6Y7MG8VVURucy1Q=;
        b=LJUh/TtKz5MgFePVo1tTJ6PdSb2rQCjzfPvww9DAPdZMb3Cls1RT/GtQw3uni/QVnJ
         2Vc8nQQ+AZeftDxgxoleYw3DpYV/RBPshm42EV+daJowXMY9EOcq2PzcClKc8oQaeq7P
         szuanuQWuZ0s9DanXyQG0catNZ94nzg3lQmwohh8AOpgYjIcP8XPPFv0KZoMOaiWZKtd
         CCSDkPioxaNo7+/wtbxF+duaFEk8vUh4CuHh3IICtOjKGsmoRI0CvpjOgSJCrdYTS5I+
         1aJwemAbIfjlttbRGEKG/1D1T7aMY0G5dGfC8beJEpGPXBbJS0SXEOyE2PxRUtOmQx0F
         KkNg==
X-Gm-Message-State: APjAAAWbd566EYF8qli8Ia4kimbb5TuwjQyKWiJ4vEK/omeyTGjhyOGi
        3yotBiN48UlQlfoh1K5bhFopK0b7V9zDu4jG2+ecAGF9Ip2RLXjsh+Xly1WZWHnx4ni/tfueUpD
        QVoniim4/sz6vmTI9yjenOAwQITLsOAdooVtTG1B8khnkWLBeOTasWP3/KYJBNPyCotBCfj4Qhw
        WTXK8ZAuxRBNqUh0g=
X-Google-Smtp-Source: APXvYqzNnFOwpxKqo4LQm7dgFp0n+OfXn4hsWRh55uvVE88cVG7O2ydRJTyaCwtxIpC4NxDnQ0wGCA==
X-Received: by 2002:a5d:4090:: with SMTP id o16mr1538248wrp.292.1564503986116;
        Tue, 30 Jul 2019 09:26:26 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c78sm90132123wmd.16.2019.07.30.09.26.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 09:26:25 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@openvz.org>
Subject: [PATCHv2] send-email: Ask if a patch should be sent twice
Date:   Tue, 30 Jul 2019 17:26:24 +0100
Message-Id: <20190730162624.9226-1-dima@arista.com>
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
index 997f90b42b3e..77df51519d6e 100755
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
+	! grep "Patches specified several times: " stdout
+'
+
 test_expect_success $PREREQ 'setup fake editor' '
 	write_script fake-editor <<-\EOF
 	echo fake edit >>"$1"
-- 
2.22.0

