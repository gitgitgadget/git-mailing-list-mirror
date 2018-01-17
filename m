Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A0B31F406
	for <e@80x24.org>; Wed, 17 Jan 2018 18:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753463AbeAQSIO (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 13:08:14 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46481 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752654AbeAQSIL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 13:08:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id 143so16900761wma.5
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 10:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CjT7sZ3yHOEtJXtxHrMaQgujuuEvC+IwPr1DUO6wGZw=;
        b=WwAdMxNBb5aqLFZ3KucTRG/CTbY74Tj6tG0xS8ukFjS/toqEtAnuH9C+szXTaZQNQs
         24wRoVJA/ksffFhDWBdTOrQh3oFvRKuwnELg2S+kDzkQFCzf2O7QScW6Q/VZyTFmy20g
         S+bxUaEbNsH+7/+zQ82uqgXh3UPZMg76GrDvLAv6ck/zh1hoxOwuk+71wvDs+f9xN61s
         oK17LP/behVVZDyUHO5dCERc2Y/6MfWsB3/n9GltlOIWpkGQVLpVMwILKFpHn0w+BZeH
         WKaH/YqNcSO9vzI1r4iCn+uAVnmNnZyGP8QWWl2nyMDAZEdl8ou4PI/c5eb35RJr/JlF
         azzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CjT7sZ3yHOEtJXtxHrMaQgujuuEvC+IwPr1DUO6wGZw=;
        b=d2wp5oQpBj+Adr4ka2WwneyWYdjnC4C/Dw7n0rZVFzL5sWwmUJFGWwyBL/oVZhUy+E
         Eyc48l4XQcw6aRoiTupIKX9yWAlrSYAZ+3qrdbkU4ppbolLvC16Mps2ItN93mEhLRNhF
         a3Ls+1zOmh1dyUuTjvnIJqD6xLeXHdpdrz0azjEmvC4RPuSUf+32+ECOTzgyXqD527dL
         EQUxGT60r4dExdcGYPKoH48pn6TGFdPdrErKgMdFoka6ON2RAYwErQixao69qltBp+yp
         TPcuKkUD+STToDTolVdFxoOeu7dajmY08qUuZ0QmsCHcNqK+dtsbBc0I+6geTATmDJ28
         O6pw==
X-Gm-Message-State: AKwxytd1XNNd7fawJOeczFIWZ7mbCyoL2mcFrQQAO7TepRpRegPitvKT
        sdeCm+8SFajUfNeR29L18cWXcLua
X-Google-Smtp-Source: ACJfBovpGeKBAWvwScWiMQRWE88iO1pmnAvJgZHoQjfAqp4VTVM7Ncc2EwMta/NrbNFb9Bm3k24DQA==
X-Received: by 10.28.93.69 with SMTP id r66mr3027502wmb.24.1516212489924;
        Wed, 17 Jan 2018 10:08:09 -0800 (PST)
Received: from greyhound ([195.145.21.250])
        by smtp.gmail.com with ESMTPSA id b48sm10862482wrd.69.2018.01.17.10.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jan 2018 10:08:08 -0800 (PST)
From:   Christian Ludwig <chrissicool@googlemail.com>
X-Google-Original-From: Christian Ludwig <chrissicool@gmail.com>
Received: from cc by greyhound with local (Exim 4.89)
        (envelope-from <cc@localhost>)
        id 1ebs84-00085Y-Jj; Wed, 17 Jan 2018 19:08:04 +0100
To:     git@vger.kernel.org
Cc:     Christian Ludwig <chrissicool@gmail.com>
Subject: [PATCH v2 1/2] send-email: Rename variable for clarity
Date:   Wed, 17 Jan 2018 19:08:00 +0100
Message-Id: <20180117180801.31049-1-chrissicool@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The SMTP protocol has both, the 'Reply-To' and the 'In-Reply-To' header
fields. We only use the latter. To avoid confusion, rename the variable
for it.

Signed-off-by: Christian Ludwig <chrissicool@gmail.com>
---
 git-send-email.perl | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index edcc6d346..0c07f48d5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -166,13 +166,13 @@ my $re_encoded_word = qr/=\?($re_token)\?($re_token)\?($re_encoded_text)\?=/;
 
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
-	$initial_reply_to,$initial_subject,@files,
+	$initial_in_reply_to,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$use_xmailer,$compose,$time);
 
 my $envelope_sender;
 
 # Example reply to:
-#$initial_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
+#$initial_in_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
 
 my $repo = eval { Git->repository() };
 my @repo = $repo ? ($repo) : ();
@@ -314,7 +314,7 @@ die __("--dump-aliases incompatible with other options\n")
     if !$help and $dump_aliases and @ARGV;
 $rc = GetOptions(
 		    "sender|from=s" => \$sender,
-                    "in-reply-to=s" => \$initial_reply_to,
+                    "in-reply-to=s" => \$initial_in_reply_to,
 		    "subject=s" => \$initial_subject,
 		    "to=s" => \@initial_to,
 		    "to-cmd=s" => \$to_cmd,
@@ -676,7 +676,7 @@ if ($compose) {
 
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
 	my $tpl_subject = $initial_subject || '';
-	my $tpl_reply_to = $initial_reply_to || '';
+	my $tpl_in_reply_to = $initial_in_reply_to || '';
 
 	print $c <<EOT1, Git::prefix_lines("GIT: ", __ <<EOT2), <<EOT3;
 From $tpl_sender # This line is ignored.
@@ -689,7 +689,7 @@ Clear the body content if you don't wish to send a summary.
 EOT2
 From: $tpl_sender
 Subject: $tpl_subject
-In-Reply-To: $tpl_reply_to
+In-Reply-To: $tpl_in_reply_to
 
 EOT3
 	for my $f (@files) {
@@ -736,7 +736,7 @@ EOT3
 				quote_subject($subject, $compose_encoding) .
 				"\n";
 		} elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
-			$initial_reply_to = $1;
+			$initial_in_reply_to = $1;
 			next;
 		} elsif (/^From:\s*(.+)\s*$/i) {
 			$sender = $1;
@@ -872,16 +872,16 @@ sub expand_one_alias {
 @initial_cc = process_address_list(@initial_cc);
 @bcclist = process_address_list(@bcclist);
 
-if ($thread && !defined $initial_reply_to && $prompting) {
-	$initial_reply_to = ask(
+if ($thread && !defined $initial_in_reply_to && $prompting) {
+	$initial_in_reply_to = ask(
 		__("Message-ID to be used as In-Reply-To for the first email (if any)? "),
 		default => "",
 		valid_re => qr/\@.*\./, confirm_only => 1);
 }
-if (defined $initial_reply_to) {
-	$initial_reply_to =~ s/^\s*<?//;
-	$initial_reply_to =~ s/>?\s*$//;
-	$initial_reply_to = "<$initial_reply_to>" if $initial_reply_to ne '';
+if (defined $initial_in_reply_to) {
+	$initial_in_reply_to =~ s/^\s*<?//;
+	$initial_in_reply_to =~ s/>?\s*$//;
+	$initial_in_reply_to = "<$initial_in_reply_to>" if $initial_in_reply_to ne '';
 }
 
 if (!defined $smtp_server) {
@@ -901,7 +901,7 @@ if ($compose && $compose > 0) {
 }
 
 # Variables we set as part of the loop over files
-our ($message_id, %mail, $subject, $reply_to, $references, $message,
+our ($message_id, %mail, $subject, $in_reply_to, $references, $message,
 	$needs_confirm, $message_num, $ask_default);
 
 sub extract_valid_address {
@@ -1310,9 +1310,9 @@ Message-Id: $message_id
 	if ($use_xmailer) {
 		$header .= "X-Mailer: git-send-email $gitversion\n";
 	}
-	if ($reply_to) {
+	if ($in_reply_to) {
 
-		$header .= "In-Reply-To: $reply_to\n";
+		$header .= "In-Reply-To: $in_reply_to\n";
 		$header .= "References: $references\n";
 	}
 	if (@xh) {
@@ -1489,8 +1489,8 @@ EOF
 	return 1;
 }
 
-$reply_to = $initial_reply_to;
-$references = $initial_reply_to || '';
+$in_reply_to = $initial_in_reply_to;
+$references = $initial_in_reply_to || '';
 $subject = $initial_subject;
 $message_num = 0;
 
@@ -1700,9 +1700,9 @@ foreach my $t (@files) {
 
 	# set up for the next message
 	if ($thread && $message_was_sent &&
-		($chain_reply_to || !defined $reply_to || length($reply_to) == 0 ||
+		($chain_reply_to || !defined $in_reply_to || length($in_reply_to) == 0 ||
 		$message_num == 1)) {
-		$reply_to = $message_id;
+		$in_reply_to = $message_id;
 		if (length $references > 0) {
 			$references .= "\n $message_id";
 		} else {
-- 
2.15.1

