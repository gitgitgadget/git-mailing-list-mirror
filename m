Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51FF1F404
	for <e@80x24.org>; Fri, 12 Jan 2018 10:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754784AbeALKsJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 05:48:09 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36119 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754576AbeALKsI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 05:48:08 -0500
Received: by mail-wr0-f196.google.com with SMTP id d9so4931488wre.3
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 02:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=egyOtN2lRbTsVZTjrX5SI2gRpI/EXLIH4YQ9HouNe9I=;
        b=SNCDaGhCY9TF8dobC1WWzrA7iNwd/4EVs9VA8g+gaF9v9FSaGOPI/vFD/jMDxliuGW
         68QrpscbtJ4XiFo/VLy/p3IXdHq/AYarC/kQ6lpv3KR6Qcfnl3O53NWuDzAKI4V9O7W4
         +ClpH5SXkuxw8yLzIXgnIi0m3jShuIS+Y4ExyCuJBLqs2d86dPt87IrlP/GoWZCH4e+K
         YvMgsnGPnFrLpq6NGtAEWLdtBmMgE7BZi5A4//nH76P8gUEl/o2xYoebFu0Gv9Vfu8Zu
         dVK1Hd27T+kS089PHMb6hdmKgqnjX0A9nwhGZMb7kzBoV/iHBZ+qewplh55SB5HYRHIv
         P+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=egyOtN2lRbTsVZTjrX5SI2gRpI/EXLIH4YQ9HouNe9I=;
        b=QPx02adCeSni5FXPms8ya+JzRymG8yBVDBFxIFbX0GpmszAalelXd+fw8V9P7A/RO3
         mVzSh5TiTJ39T2kmuQIokzA2xeue25YI0iinkD/UGloMwn3j79wRm0hvqi+eOVZgYmZJ
         5B2DpVENzMY3T3iPtF/7QXWXV6xKYt227ykAwP+rWOr6mirhSwkACknH0ousOeBLj3qs
         HXhtlPGC8oSbeHy5DUbhmwfk3WfeGGgOw9DKcLssrjHF0UWqvyxQgZVnl9JGq89TARP3
         vF6mlaBobaP8dCIwf7qq9gSRDifCR5NOlpB4lfpN1QMzgV/iijnlg8S/FgDvz5Xo3vW3
         Hajw==
X-Gm-Message-State: AKGB3mLrQvjvTRNKkD30s2EY4deCsyk6DPa2ldaaiCGdNDed+J0Y+V7q
        qcEOmJpt3DppfMcE+PO+MFZXEBOR
X-Google-Smtp-Source: ACJfBouE3AXIs2mZ1ds408DYNS8LkhLMWZsP452l2dTYGCYkcQEWl6PGIkpPHMTgBZEG1qQoItvv9Q==
X-Received: by 10.223.158.208 with SMTP id b16mr22151196wrf.66.1515754086750;
        Fri, 12 Jan 2018 02:48:06 -0800 (PST)
Received: from greyhound ([195.145.21.250])
        by smtp.gmail.com with ESMTPSA id h4sm19501522wrh.40.2018.01.12.02.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jan 2018 02:48:05 -0800 (PST)
From:   Christian Ludwig <chrissicool@googlemail.com>
X-Google-Original-From: Christian Ludwig <chrissicool@gmail.com>
Received: from cc by greyhound with local (Exim 4.89)
        (envelope-from <cc@localhost>)
        id 1eZwsW-0007Mj-SN; Fri, 12 Jan 2018 11:48:04 +0100
To:     git@vger.kernel.org
Cc:     Christian Ludwig <chrissicool@gmail.com>
Subject: [PATCH] send-email: Support separate Reply-To address
Date:   Fri, 12 Jan 2018 11:47:51 +0100
Message-Id: <20180112104751.28263-1-chrissicool@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some projects contributions from groups are only accepted from a
common group email address. But every individual may want to recieve
replies to her own personal address. That's what we have 'Reply-To'
headers for in SMTP.

Introduce an optional '--reply-to' command line option. Unfortunately
the $reply_to variable name was already taken for the 'In-Reply-To'
header field. To reduce code churn, use $reply_address as variable
name instead.

Signed-off-by: Christian Ludwig <chrissicool@gmail.com>
---
 Documentation/git-send-email.txt |  5 +++++
 git-send-email.perl              | 18 +++++++++++++++++-
 t/t9001-send-email.sh            |  2 ++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 8060ea35c..c3bc622b1 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -84,6 +84,11 @@ See the CONFIGURATION section for `sendemail.multiEdit`.
 	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
 	set, as returned by "git var -l".
 
+--reply-to=<address>::
+	Specify the address that replies from reciepients should
+	to go. Use this if replies to messages should go to another
+	address than what is specified with the --from parameter.
+
 --in-reply-to=<identifier>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
 	reply to the given Message-Id, which avoids breaking threads to
diff --git a/git-send-email.perl b/git-send-email.perl
index edcc6d346..fc21081d3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -56,6 +56,7 @@ git send-email --dump-aliases
     --[no-]cc               <str>  * Email Cc:
     --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
+    --reply-to              <str>  * Email "Reply-To:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
     --[no-]xmailer                 * Add "X-Mailer:" header (default).
     --[no-]annotate                * Review each patch that will be sent in an editor.
@@ -166,7 +167,7 @@ my $re_encoded_word = qr/=\?($re_token)\?($re_token)\?($re_encoded_text)\?=/;
 
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
-	$initial_reply_to,$initial_subject,@files,
+	$initial_reply_to,$reply_address,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$use_xmailer,$compose,$time);
 
 my $envelope_sender;
@@ -315,6 +316,7 @@ die __("--dump-aliases incompatible with other options\n")
 $rc = GetOptions(
 		    "sender|from=s" => \$sender,
                     "in-reply-to=s" => \$initial_reply_to,
+		    "reply-to=s" => \$reply_address,
 		    "subject=s" => \$initial_subject,
 		    "to=s" => \@initial_to,
 		    "to-cmd=s" => \$to_cmd,
@@ -677,6 +679,7 @@ if ($compose) {
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_reply_to = $initial_reply_to || '';
+	my $tpl_reply_address = $reply_address || '';
 
 	print $c <<EOT1, Git::prefix_lines("GIT: ", __ <<EOT2), <<EOT3;
 From $tpl_sender # This line is ignored.
@@ -688,6 +691,7 @@ for the patch you are writing.
 Clear the body content if you don't wish to send a summary.
 EOT2
 From: $tpl_sender
+Reply-To: $tpl_reply_address
 Subject: $tpl_subject
 In-Reply-To: $tpl_reply_to
 
@@ -738,6 +742,9 @@ EOT3
 		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
 			$initial_reply_to = $1;
 			next;
+		} elsif (/^Reply-To:\s*(.+)\s*$/i) {
+			$reply_address = $1;
+			next;
 		} elsif (/^From:\s*(.+)\s*$/i) {
 			$sender = $1;
 			next;
@@ -884,6 +891,12 @@ if (defined $initial_reply_to) {
 	$initial_reply_to = "<$initial_reply_to>" if $initial_reply_to ne '';
 }
 
+if (defined $reply_address) {
+	$reply_address =~ s/^\s+|\s+$//g;
+	($reply_address) = expand_aliases($reply_address);
+	$reply_address = sanitize_address($reply_address);
+}
+
 if (!defined $smtp_server) {
 	my @sendmail_paths = qw( /usr/sbin/sendmail /usr/lib/sendmail );
 	push @sendmail_paths, map {"$_/sendmail"} split /:/, $ENV{PATH};
@@ -1315,6 +1328,9 @@ Message-Id: $message_id
 		$header .= "In-Reply-To: $reply_to\n";
 		$header .= "References: $references\n";
 	}
+	if ($reply_address) {
+		$header .= "Reply-To: $reply_address\n";
+	}
 	if (@xh) {
 		$header .= join("\n", @xh) . "\n";
 	}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 81869d891..c62318a78 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -205,6 +205,7 @@ Message-Id: MESSAGE-ID-STRING
 X-Mailer: X-MAILER-STRING
 In-Reply-To: <unique-message-id@example.com>
 References: <unique-message-id@example.com>
+Reply-To: Reply <reply@example.com>
 
 Result: OK
 EOF
@@ -297,6 +298,7 @@ test_expect_success $PREREQ 'Show all headers' '
 		--dry-run \
 		--suppress-cc=sob \
 		--from="Example <from@example.com>" \
+		--reply-to="Reply <reply@example.com>" \
 		--to=to@example.com \
 		--cc=cc@example.com \
 		--bcc=bcc@example.com \
-- 
2.15.1

