Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715D61F97E
	for <e@80x24.org>; Tue, 30 Jul 2019 20:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfG3Udc (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 16:33:32 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43597 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfG3Udc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 16:33:32 -0400
Received: by mail-wr1-f51.google.com with SMTP id p13so67146370wru.10
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XQjj2VJtYLb4WveFAE4qIsPl7dN1eVVWd83zRNmkm2Y=;
        b=jH/EBSj7i5iBVVfUBF6pAQqHVVE/D9sdxQcndKvNw7TIcNK89rfGa+ljPIPi2Vcvcj
         xrm8HERC/OlVHfrhy3W/xlARjD3BKwyRjQotF3L/tp+/EzU8EKh8uRJpj/7mAdMu5/52
         UOZ6+RXmGaSDZuR7qUOvHzH2NV02UlBbexGotreGQ6ghP8kcKNZJlCEDw9rK/JjmjL3B
         9l472b7WNaLqdhNR7yVrtX4m30nYJxANvDAm5TyBZd8eMSkqFjSNd1q713XFxav4AFsp
         cT5RqHGNJdTt1PMGywGzc4PCxCj8QukuBAoaH3yJxw6fWMEcfmVj6KwYNnxZU8nbiTCj
         Am0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XQjj2VJtYLb4WveFAE4qIsPl7dN1eVVWd83zRNmkm2Y=;
        b=sQ4xw98iXNYqZZkZO0dznVXeSI1c/pIT5gue2z7VgvhqpqcaZm0R3McDwEdfSxhXth
         pv8D3t+ZciEI3oVHx730/3pYk8dtfzTC0tgUlOvR/h6HqoA575Ms1gN/E2NOem5ky92q
         d8q0I1BFfZWSc/R/BKhegYt0LWZhv/3ozlIkg94VRxIfWfn7MOZOb2tVv/iXPyKKOAuh
         dlJ+NK4g6W7fX2JoLT+VJskYar2e8+66x7bUQiWnujTL0ns47jPhyzJ52wtYHGUX8xdQ
         vZPb2PWPUj0tsxvhzX2G2YANt7Ab9zVaJzXdn5Z11WlfJmNcc5MEKzbPTsuywLnSHJ+C
         jhcQ==
X-Gm-Message-State: APjAAAVtRAiSjHKo71Uc/PEinVATVTYk1rKkeYWrjiMA5bSR5p7+mefW
        OffpwfCn1SveSpn2jIAeApjrZ79ef3KGeqNNzciBPdZKaIbGOK7iXXRLHJX6jY23wseCOqMY78X
        F8RcmAkhmkkaxSM/fxYUfGYHQZOECAtdo1ZJHKQL9j+eoJisWrI8WWrN9YQL3aBZ4u42AkRp2tq
        tfw2Hre6bAn6yOU+Q=
X-Google-Smtp-Source: APXvYqxXJJhafdWIIhceasD6HPEdpwlIYgLHSNSe454/P7KxGKSLqc49zZQt9d0FF+2IuhsWUIO4kQ==
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr43435067wro.284.1564518808894;
        Tue, 30 Jul 2019 13:33:28 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id e19sm90769197wra.71.2019.07.30.13.33.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 13:33:28 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@openvz.org>
Subject: [PATCHv3] send-email: Ask if a patch should be sent twice
Date:   Tue, 30 Jul 2019 21:33:27 +0100
Message-Id: <20190730203327.30958-1-dima@arista.com>
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
index 997f90b42b3e..496005af1763 100755
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
+	! test_i18ngrep "Patches specified several times: " stdout
+'
+
 test_expect_success $PREREQ 'setup fake editor' '
 	write_script fake-editor <<-\EOF
 	echo fake edit >>"$1"
-- 
2.22.0

