Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C496202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 22:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbdJ3Wfo (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 18:35:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52867 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753389AbdJ3Wfn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 18:35:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id t139so19443595wmt.1
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F+R640jQDxlL07vCyjCFYMk7nIiUMKEmPJih17Ra+Qc=;
        b=Xjb8p/pu2iLvIm/goxmESQW62mWIYgFCiRJPk07NGsTa62iu+JDgcxatqkla3yJ7l6
         msv/nkpgfYNVZ4Xm41bL2qckUzecNncpu8LnrbmQKUSGnhXAfx8d+A8EWiIxNg4Uiux/
         ZQ11HQlEIU9E/0GtDJNAD/7eG8POEzK+Ox1gU+UnE5G8X/QXnJHvWNHWhj8GASougUdv
         dTJUlyvsSAv7DENbC0Ukrr5JQx3iGAbaBn1VOqEXMLkRR7JIAn36YrCu0M04uxGafItO
         aNGkIlWXZ6XcAgxLl9uzGErulrxkuyOzz0Q0zJLKvGV67wMOJxNixCJ8OKxYnCmOMURl
         jgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F+R640jQDxlL07vCyjCFYMk7nIiUMKEmPJih17Ra+Qc=;
        b=hGKpxsd7xEbK9QyhvJ+nBz0VYVaRqnWdPu1rYJ9OUQJ4A4GsKDzGOgGHHAqH7IB29P
         /VJxwdFuKUkLZs59fCMRdlAOaW/ISaWoUgKZdErIgFilRmnQ1yQ+hX4JQLtPlkM/+IbK
         qkUK3U3FfOEqqQcOXfnoHzlc/yKP5MH7S8swuz+VpVe3ZAdIJWlhNGNLT80NH1zZNU/p
         XgJFxmMUYKETQQjP2FE1S1gfXLwx8GAIWc4I6flPL3uxDsqtnZxtgUuzSWdYYFFZ0yjs
         roQCOwD3/EA/hzu1278KfPRgPzbNuy0b+F1ghuOeHi9XHJCs1fcU+ekY6jyZ1SAhT1hX
         cLJQ==
X-Gm-Message-State: AMCzsaWF2joKXjmVuskkqfX2rDCBMD2lu0cJcBxyDyU794L19tlvI3SF
        AcEeUPgUIjd+U2OGdaj+pTeEqA==
X-Google-Smtp-Source: ABhQp+Sh67GpJKx4FfjStUkTOfMgju9t6uaLl6zpZIqsamIuJUA4m6vnh2BsWeR0fK2Sd1vn0B5O/w==
X-Received: by 10.28.137.193 with SMTP id l184mr184104wmd.24.1509402941442;
        Mon, 30 Oct 2017 15:35:41 -0700 (PDT)
Received: from localhost.localdomain (AMarseille-654-1-544-80.w92-158.abo.wanadoo.fr. [92.158.136.80])
        by smtp.gmail.com with ESMTPSA id k69sm353676wmg.45.2017.10.30.15.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 15:35:40 -0700 (PDT)
From:   Payre Nathan <second.payre@gmail.com>
X-Google-Original-From: Payre Nathan <nathan.payre@etu.univ-lyon1.fr>
To:     git@vger.kernel.org
Cc:     matthieu.moy@univ-lyon1.fr, timothee.albertin@etu.univ-lyon1.fr,
        daniel.bensoussan--bohm@etu.univ-lyon1.fr,
        Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH 1/2] quote-email populates the fields
Date:   Mon, 30 Oct 2017 23:34:43 +0100
Message-Id: <20171030223444.5052-2-nathan.payre@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.14.1.731.g083517f57
In-Reply-To: <20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr>
References: <20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tom Russello <tom.russello@grenoble-inp.org>

---
 Documentation/git-send-email.txt |   3 +
 git-send-email.perl              |  70 ++++++++++++++++++++++-
 t/t9001-send-email.sh            | 117 +++++++++++++++++++++++++--------------
 3 files changed, 147 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index bac9014ac..710b5ff32 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -106,6 +106,9 @@ illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
 Only necessary if --compose is also set.  If --compose
 is not set, this will be prompted for.
 
+--quote-email=<email_file>::
+	Fill appropriately header fields for the reply to the given email.
+
 --subject=<string>::
 	Specify the initial subject of the email thread.
 	Only necessary if --compose is also set.  If --compose
diff --git a/git-send-email.perl b/git-send-email.perl
index 2208dcc21..665c47d15 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -57,6 +57,7 @@ git send-email --dump-aliases
     --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
+    --quote-email           <file> * Populate header fields appropriately.
     --[no-]xmailer                 * Add "X-Mailer:" header (default).
     --[no-]annotate                * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
@@ -166,7 +167,7 @@ my $re_encoded_word = qr/=\?($re_token)\?($re_token)\?($re_encoded_text)\?=/;
 
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
-	$initial_reply_to,$initial_subject,@files,
+	$initial_reply_to,$initial_references,$quote_email,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$use_xmailer,$compose,$time);
 
 my $envelope_sender;
@@ -316,6 +317,7 @@ $rc = GetOptions(
 		    "sender|from=s" => \$sender,
                     "in-reply-to=s" => \$initial_reply_to,
 		    "subject=s" => \$initial_subject,
+		    "quote-email=s" => \$quote_email,
 		    "to=s" => \@initial_to,
 		    "to-cmd=s" => \$to_cmd,
 		    "no-to" => \$no_to,
@@ -652,6 +654,70 @@ if (@files) {
 	usage();
 }
 
+if ($quote_email) {
+	my $error = validate_patch($quote_email);
+	die "fatal: $quote_email: $error\nwarning: no patches were sent\n"
+		if $error;
+
+	my @header = ();
+
+	open my $fh, "<", $quote_email or die "can't open file $quote_email";
+
+	# Get the email header
+	while (<$fh>) {
+		# Turn crlf line endings into lf-only
+		s/\r//g;
+		last if /^\s*$/;
+		if (/^\s+\S/ and @header) {
+			chomp($header[$#header]);
+			s/^\s+/ /;
+			$header[$#header] .= $_;
+		} else {
+			push(@header, $_);
+		}
+	}
+
+	# Parse the header
+	foreach (@header) {
+		my $initial_sender = $sender || $repoauthor || $repocommitter || '';
+
+		chomp;
+
+		if (/^Subject:\s+(.*)$/i) {
+			my $prefix_re = "";
+			my $subject_re = $1;
+			if ($1 =~ /^[^Re:]/) {
+				$prefix_re = "Re: ";
+			}
+			$initial_subject = $prefix_re . $subject_re;
+		} elsif (/^From:\s+(.*)$/i) {
+			push @initial_to, $1;
+		} elsif (/^To:\s+(.*)$/i) {
+			foreach my $addr (parse_address_line($1)) {
+				if (!($addr eq $initial_sender)) {
+					push @initial_cc, $addr;
+				}
+			}
+		} elsif (/^Cc:\s+(.*)$/i) {
+			foreach my $addr (parse_address_line($1)) {
+				my $qaddr = unquote_rfc2047($addr);
+				my $saddr = sanitize_address($qaddr);
+				if ($saddr eq $initial_sender) {
+					next if ($suppress_cc{'self'});
+				} else {
+					next if ($suppress_cc{'cc'});
+				}
+				push @initial_cc, $addr;
+			}
+		} elsif (/^Message-Id: (.*)/i) {
+			$initial_reply_to = $1;
+		} elsif (/^References:\s+(.*)/i) {
+			$initial_references = $1;
+		}
+	}
+	$initial_references = $initial_references . $initial_reply_to;
+}
+
 sub get_patch_subject {
 	my $fn = shift;
 	open (my $fh, '<', $fn);
@@ -1488,7 +1554,7 @@ EOF
 }
 
 $reply_to = $initial_reply_to;
-$references = $initial_reply_to || '';
+$references = $initial_references || $initial_reply_to || '';
 $subject = $initial_subject;
 $message_num = 0;
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index f30980895..ce12a1164 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1917,52 +1917,87 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	test_cmp expected-list actual-list
 '
 
-test_expect_success $PREREQ 'invoke hook' '
-	mkdir -p .git/hooks &&
-
-	write_script .git/hooks/sendemail-validate <<-\EOF &&
-	# test that we have the correct environment variable, pwd, and
-	# argument
-	case "$GIT_DIR" in
-	*.git)
-		true
-		;;
-	*)
-		false
-		;;
-	esac &&
-	test -f 0001-add-master.patch &&
-	grep "add master" "$1"
-	EOF
-
-	mkdir subdir &&
-	(
-		# Test that it works even if we are not at the root of the
-		# working tree
-		cd subdir &&
-		git send-email \
-			--from="Example <nobody@example.com>" \
-			--to=nobody@example.com \
-			--smtp-server="$(pwd)/../fake.sendmail" \
-			../0001-add-master.patch &&
+test_expect_success $PREREQ 'setup expect' '
+	cat >email <<-\EOF
+	Subject: subject goes here
+	From: author@example.com
+	To: to1@example.com
+	Cc: cc1@example.com, cc2@example.com,
+     cc3@example.com
+	Date: Sat, 12 Jun 2010 15:53:58 +0200
+	Message-Id: <author_123456@example.com>
+	References: <firstauthor_654321@example.com>
+        <secondauthor_01546567@example.com>
+        <thirdauthor_1395838@example.com>
 
-		# Verify error message when a patch is rejected by the hook
-		sed -e "s/add master/x/" ../0001-add-master.patch >../another.patch &&
-		git send-email \
-			--from="Example <nobody@example.com>" \
-			--to=nobody@example.com \
-			--smtp-server="$(pwd)/../fake.sendmail" \
-			../another.patch 2>err
-		test_i18ngrep "rejected by sendemail-validate hook" err
-	)
+	Have you seen my previous email?
+	> Previous content
+	EOF
 '
 
-test_expect_success $PREREQ 'test that send-email works outside a repo' '
-	nongit git send-email \
+test_expect_success $PREREQ 'Fields with --quote-email are correct' '
+	clean_fake_sendmail &&
+	git send-email \
+		--quote-email=email \
 		--from="Example <nobody@example.com>" \
-		--to=nobody@example.com \
 		--smtp-server="$(pwd)/fake.sendmail" \
-		"$(pwd)/0001-add-master.patch"
+		-1 \
+		2>errors &&
+	grep "From: Example <nobody@example.com>" msgtxt1 &&
+	grep "In-Reply-To: <author_123456@example.com>" msgtxt1 &&
+	to_adr=$(awk "/^To: /{flag=1}/^Cc: /{flag=0} flag {print}" msgtxt1) &&
+	cc_adr=$(awk "/^Cc: /{flag=1}/^Subject: /{flag=0} flag {print}" msgtxt1) &&
+	ref_adr=$(awk "/^References: /{flag=1}/^MIME-Version: /{flag=0} flag {print}" \
+		msgtxt1) &&
+	echo "$to_adr" | grep author@example.com &&
+	echo "$cc_adr" | grep to1@example.com &&
+	echo "$cc_adr" | grep cc1@example.com &&
+	echo "$cc_adr" | grep cc2@example.com &&
+	echo "$cc_adr" | grep cc3@example.com &&
+	echo "$ref_adr" | grep "<firstauthor_654321@example.com>" &&
+	echo "$ref_adr" | grep "<secondauthor_01546567@example.com>" &&
+	echo "$ref_adr" | grep "<thirdauthor_1395838@example.com>" &&
+	echo "$ref_adr" | grep "<author_123456@example.com>" &&
+	echo "$ref_adr" | grep -v "References: <author_123456@example.com>"
+'
+
+test_expect_success $PREREQ 'Fields with --quote-email and --compose are correct' '
+	clean_fake_sendmail &&
+	git send-email \
+		--quote-email=email \
+		--compose \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		-1 \
+		2>errors &&
+	grep "From: Example <nobody@example.com>" msgtxt1 &&
+	grep "In-Reply-To: <author_123456@example.com>" msgtxt1 &&
+	grep "Subject: Re: subject goes here" msgtxt1 &&
+	to_adr=$(awk "/^To: /{flag=1}/^Cc: /{flag=0} flag {print}" msgtxt1) &&
+	cc_adr=$(awk "/^Cc: /{flag=1}/^Subject: /{flag=0} flag {print}" msgtxt1) &&
+	ref_adr=$(awk "/^References: /{flag=1}/^MIME-Version: /{flag=0} flag {print}" \
+		msgtxt1) &&
+	echo "$to_adr" | grep author@example.com &&
+	echo "$cc_adr" | grep to1@example.com &&
+	echo "$cc_adr" | grep cc1@example.com &&
+	echo "$cc_adr" | grep cc2@example.com &&
+	echo "$cc_adr" | grep cc3@example.com &&
+	echo "$ref_adr" | grep "<firstauthor_654321@example.com>" &&
+	echo "$ref_adr" | grep "<secondauthor_01546567@example.com>" &&
+	echo "$ref_adr" | grep "<thirdauthor_1395838@example.com>" &&
+	echo "$ref_adr" | grep "<author_123456@example.com>" &&
+	echo "$ref_adr" | grep -v "References: <author_123456@example.com>"
+'
+
+test_expect_success $PREREQ 'Re: written only once with --quote-email and --compose ' '
+	git send-email \
+		--quote-email=msgtxt1 \
+		--compose \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		-1 \
+		2>errors &&
+	grep "Subject: Re: subject goes here" msgtxt3
 '
 
 test_done
-- 
2.14.2

