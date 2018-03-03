Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 390771F404
	for <e@80x24.org>; Sat,  3 Mar 2018 23:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932304AbeCCX66 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 18:58:58 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42363 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbeCCX6u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 18:58:50 -0500
Received: by mail-wr0-f196.google.com with SMTP id k9so13624151wre.9
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 15:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q5QaWhtR7ppwpMXDEI14XsCIltUsQxN5iV/tHNC91vc=;
        b=hscQ3lDXEdm5nQvMAgGq6vFzi9DPcD7quDO/yruwJfKT7uWHC7zcVvAhKZag2kIYHI
         5BIYymaNdQ8cji+MrjIKp8CdUg+q1QvCeBga83DNHGV3mSr0YgYGFTqdBELOGVlVCiW0
         JjUDo0xRd3aCEPXO57WcmfSjfftN+a/jlBw6mHo4GbnWNTtFbNRrL1u3pRcSV3zCI0/p
         QFs70giUwMPg/Q2voOSNgo+LkpHVLb/ZCwkefL+6O1BopS41GeKocDTrnhHY2MzeXz7a
         iTR9l7CRuvKGCHZTlbL6vrVXQ5gFX90ABkI70Qct5Va9kK6O8mM/zTw8GCWEqKepg27t
         OWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q5QaWhtR7ppwpMXDEI14XsCIltUsQxN5iV/tHNC91vc=;
        b=YhybOVEz2HUYpoKw+Pq3MwmR5nh4Xr/dVIHp+0L/Ra2fksc7rZyqYgwTy5ZK+zuFdx
         JOr0jbbs8usqvB7w7VlPDulAKB6JxFR4RNPiKzMCgMrZdJoEckEg6OkBqQkUlEqXB+1c
         7Lau+oJavNzwLY07+0nzLSZNd+NQ8Sf5L5sOGCn5XoCWhvBFciWVyhtw6Yf6ZhzhHg9+
         +1UT1p1FBgkWK9WSNJWu/qfR+JKPOo/bS6xN5MevbY9Sl9NtyrP7bSWfADrxJiUR+ypS
         qIZ4bpFjBypc/d19nSVcfv4gRciPfnJF5ZI5pWcJN3y/285NJAwNYfOLI21fY405+9+7
         VQZg==
X-Gm-Message-State: APf1xPCRuAwhuIF1nZOGrbGy5/tdNapT+1pM26sADEcy0HKruBvWKe6n
        /sSNDYF4N+2GiN7PU0Ia0nzCg9Tg
X-Google-Smtp-Source: AG47ELuq4782at+mSWezy7d0HOLj1ofZxnBiAHX1/kJhEDk/ijlop6llxe+938YHBrCRJtpjMStMfA==
X-Received: by 10.223.179.211 with SMTP id x19mr8538413wrd.175.1520121529289;
        Sat, 03 Mar 2018 15:58:49 -0800 (PST)
Received: from greyhound.Speedport_W_724V_Typ_A_05011603_05_028 (p200300CA5BEF8278E01D0E043582A547.dip0.t-ipconnect.de. [2003:ca:5bef:8278:e01d:e04:3582:a547])
        by smtp.gmail.com with ESMTPSA id m190sm5677403wmb.6.2018.03.03.15.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Mar 2018 15:58:46 -0800 (PST)
Received: from cc by greyhound.Speedport_W_724V_Typ_A_05011603_05_028 with local (Exim 4.89)
        (envelope-from <cc@localhost>)
        id 1esH37-00023F-OO; Sun, 04 Mar 2018 00:58:45 +0100
From:   Christian Ludwig <chrissicool@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Ludwig <chrissicool@gmail.com>
Subject: [PATCH v3 2/2] send-email: Support separate Reply-To address
Date:   Sun,  4 Mar 2018 00:58:14 +0100
Message-Id: <20180303235814.7241-3-chrissicool@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180303235814.7241-1-chrissicool@gmail.com>
References: <20180303235814.7241-1-chrissicool@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some projects contributions from groups are only accepted from a
common group email address. But every individual may want to receive
replies to her own personal address. That's what we have 'Reply-To'
headers for in SMTP. So introduce an optional '--reply-to' command
line option.

This patch re-uses the $reply_to variable. This could break
out-of-tree patches!

Signed-off-by: Christian Ludwig <chrissicool@gmail.com>
---
 Documentation/git-send-email.txt       |  5 +++++
 contrib/completion/git-completion.bash |  2 +-
 git-send-email.perl                    | 18 +++++++++++++++++-
 t/t9001-send-email.sh                  |  2 ++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 8060ea35c..71ef97ba9 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -84,6 +84,11 @@ See the CONFIGURATION section for `sendemail.multiEdit`.
 	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
 	set, as returned by "git var -l".
 
+--reply-to=<address>::
+	Specify the address where replies from recipients should go to.
+	Use this if replies to messages should go to another address than what
+	is specified with the --from parameter.
+
 --in-reply-to=<identifier>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
 	reply to the given Message-Id, which avoids breaking threads to
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c7d5c7af2..4805b92ba 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2081,7 +2081,7 @@ _git_send_email ()
 			--compose --confirm= --dry-run --envelope-sender
 			--from --identity
 			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc
-			--no-suppress-from --no-thread --quiet
+			--no-suppress-from --no-thread --quiet --reply-to
 			--signed-off-by-cc --smtp-pass --smtp-server
 			--smtp-server-port --smtp-encryption= --smtp-user
 			--subject --suppress-cc= --suppress-from --thread --to
diff --git a/git-send-email.perl b/git-send-email.perl
index 9eb12b5ba..707ec9eb7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -57,6 +57,7 @@ git send-email --dump-aliases
     --[no-]cc               <str>  * Email Cc:
     --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
+    --reply-to              <str>  * Email "Reply-To:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
     --[no-]xmailer                 * Add "X-Mailer:" header (default).
     --[no-]annotate                * Review each patch that will be sent in an editor.
@@ -167,7 +168,7 @@ my $re_encoded_word = qr/=\?($re_token)\?($re_token)\?($re_encoded_text)\?=/;
 
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
-	$initial_in_reply_to,$initial_subject,@files,
+	$initial_in_reply_to,$reply_to,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$use_xmailer,$compose,$time);
 
 my $envelope_sender;
@@ -316,6 +317,7 @@ die __("--dump-aliases incompatible with other options\n")
 $rc = GetOptions(
 		    "sender|from=s" => \$sender,
                     "in-reply-to=s" => \$initial_in_reply_to,
+		    "reply-to=s" => \$reply_to,
 		    "subject=s" => \$initial_subject,
 		    "to=s" => \@initial_to,
 		    "to-cmd=s" => \$to_cmd,
@@ -678,6 +680,7 @@ if ($compose) {
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_in_reply_to = $initial_in_reply_to || '';
+	my $tpl_reply_to = $reply_to || '';
 
 	print $c <<EOT1, Git::prefix_lines("GIT: ", __ <<EOT2), <<EOT3;
 From $tpl_sender # This line is ignored.
@@ -689,6 +692,7 @@ for the patch you are writing.
 Clear the body content if you don't wish to send a summary.
 EOT2
 From: $tpl_sender
+Reply-To: $tpl_reply_to
 Subject: $tpl_subject
 In-Reply-To: $tpl_in_reply_to
 
@@ -731,6 +735,9 @@ EOT3
 	if ($parsed_email{'In-Reply-To'}) {
 		$initial_in_reply_to = delete($parsed_email{'In-Reply-To'});
 	}
+	if ($parsed_email{'Reply-To'}) {
+		$reply_to = delete($parsed_email{'Reply-To'});
+	}
 	if ($parsed_email{'Subject'}) {
 		$initial_subject = delete($parsed_email{'Subject'});
 		print $c2 "Subject: " .
@@ -924,6 +931,12 @@ if (defined $initial_in_reply_to) {
 	$initial_in_reply_to = "<$initial_in_reply_to>" if $initial_in_reply_to ne '';
 }
 
+if (defined $reply_to) {
+	$reply_to =~ s/^\s+|\s+$//g;
+	($reply_to) = expand_aliases($reply_to);
+	$reply_to = sanitize_address($reply_to);
+}
+
 if (!defined $smtp_server) {
 	my @sendmail_paths = qw( /usr/sbin/sendmail /usr/lib/sendmail );
 	push @sendmail_paths, map {"$_/sendmail"} split /:/, $ENV{PATH};
@@ -1355,6 +1368,9 @@ Message-Id: $message_id
 		$header .= "In-Reply-To: $in_reply_to\n";
 		$header .= "References: $references\n";
 	}
+	if ($reply_to) {
+		$header .= "Reply-To: $reply_to\n";
+	}
 	if (@xh) {
 		$header .= join("\n", @xh) . "\n";
 	}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 19601fb54..e80eacbb1 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -224,6 +224,7 @@ Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 In-Reply-To: <unique-message-id@example.com>
 References: <unique-message-id@example.com>
+Reply-To: Reply <reply@example.com>
 
 Result: OK
 EOF
@@ -316,6 +317,7 @@ test_expect_success $PREREQ 'Show all headers' '
 		--dry-run \
 		--suppress-cc=sob \
 		--from="Example <from@example.com>" \
+		--reply-to="Reply <reply@example.com>" \
 		--to=to@example.com \
 		--cc=cc@example.com \
 		--bcc=bcc@example.com \
-- 
2.16.2

