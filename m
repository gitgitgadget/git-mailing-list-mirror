Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263C21F404
	for <e@80x24.org>; Sat,  3 Mar 2018 23:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932258AbeCCX6w (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 18:58:52 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33724 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeCCX6u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 18:58:50 -0500
Received: by mail-wr0-f196.google.com with SMTP id v18so13006139wrv.0
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 15:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CokmmyrMbKlBI60oPMoC1g27/ompc5aMaIrhpc2KN80=;
        b=Y4C+WHshGlhynBvPPFx7zPoBvsDAawsIFswKI+p1xwGbS2Sn5XVeoCQidBHEqRt5Ev
         wE0fBrI9SmwX364qWUV3RZA5MFOqVooDRPWcfnwdruRJuY4TolT7iU2KG0GG3ETcHbGA
         YlpboXCL9HHABvxBAUdR1qkXzux4IF9zbck2Tl1qnfNU63SmOEVP9d3+Yn0Kt9VU+8oM
         C63/PS0Z0awRRpudYFdjIQUbbP0e239EwRfme/5h8gPxxSaVTu8EfgMJ4uUDdSHx6DQP
         9BubGj2X73bf2HCbno2qUhMPhQBof+YXU0gycIJCnjSLJTIucoJVrS7ehKAyC/EpjE1f
         oLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CokmmyrMbKlBI60oPMoC1g27/ompc5aMaIrhpc2KN80=;
        b=MPTesUbsxf7gCcywSzhlSc3H7PN1seBVHAOPcM7yY7rMVqDbAicYk3dcbvq3/5QnZp
         0tteY1/Z762BDeQj1gHo+bpiUoDelZcO04F46MYEe27EzbCmyzsZJCvCPUz0JaWQgkmG
         aVRzcRi37kgV0s+7gifUnCoEQAHahM7csCtfbh057ohZWrSZHo7xkFnkB6RK6wXGZKUZ
         pbmrdro0SsTK6t/eDJRH38ghFV4erV32nI/F2njcq5SOwIadPaYbitUomH/u+kj5/7Ky
         dJj9SO/0u9GZv9TDaChRC43lZoMbN1Iq2EI/2PmGVQ3Ao/3RZfTGihNt4z1b3KVOHZXT
         1EiA==
X-Gm-Message-State: APf1xPD4997nJ4zv1jNOXOWMT9e5yvNFAlzbcbyYetzRNUJg+DsuRj20
        qDu4CTjiIwHAXhBoHF5RGcCVayLA
X-Google-Smtp-Source: AG47ELtwC84tgIbyP3YgwyVv7Rb3yS6u87Okcp4QRZa824emOWKsse25WiUaOssDqauMfoZfq2Y10g==
X-Received: by 10.223.185.82 with SMTP id b18mr8341954wrg.180.1520121528324;
        Sat, 03 Mar 2018 15:58:48 -0800 (PST)
Received: from greyhound.Speedport_W_724V_Typ_A_05011603_05_028 (p200300CA5BEF8278E01D0E043582A547.dip0.t-ipconnect.de. [2003:ca:5bef:8278:e01d:e04:3582:a547])
        by smtp.gmail.com with ESMTPSA id o94sm14657793wrc.7.2018.03.03.15.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Mar 2018 15:58:46 -0800 (PST)
Received: from cc by greyhound.Speedport_W_724V_Typ_A_05011603_05_028 with local (Exim 4.89)
        (envelope-from <cc@localhost>)
        id 1esH37-00023B-NC; Sun, 04 Mar 2018 00:58:45 +0100
From:   Christian Ludwig <chrissicool@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Ludwig <chrissicool@gmail.com>
Subject: [PATCH v3 1/2] send-email: Rename variable for clarity
Date:   Sun,  4 Mar 2018 00:58:13 +0100
Message-Id: <20180303235814.7241-2-chrissicool@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180303235814.7241-1-chrissicool@gmail.com>
References: <20180303235814.7241-1-chrissicool@gmail.com>
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
index d0dcc6d7f..9eb12b5ba 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -167,13 +167,13 @@ my $re_encoded_word = qr/=\?($re_token)\?($re_token)\?($re_encoded_text)\?=/;
 
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
@@ -315,7 +315,7 @@ die __("--dump-aliases incompatible with other options\n")
     if !$help and $dump_aliases and @ARGV;
 $rc = GetOptions(
 		    "sender|from=s" => \$sender,
-                    "in-reply-to=s" => \$initial_reply_to,
+                    "in-reply-to=s" => \$initial_in_reply_to,
 		    "subject=s" => \$initial_subject,
 		    "to=s" => \@initial_to,
 		    "to-cmd=s" => \$to_cmd,
@@ -677,7 +677,7 @@ if ($compose) {
 
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
 	my $tpl_subject = $initial_subject || '';
-	my $tpl_reply_to = $initial_reply_to || '';
+	my $tpl_in_reply_to = $initial_in_reply_to || '';
 
 	print $c <<EOT1, Git::prefix_lines("GIT: ", __ <<EOT2), <<EOT3;
 From $tpl_sender # This line is ignored.
@@ -690,7 +690,7 @@ Clear the body content if you don't wish to send a summary.
 EOT2
 From: $tpl_sender
 Subject: $tpl_subject
-In-Reply-To: $tpl_reply_to
+In-Reply-To: $tpl_in_reply_to
 
 EOT3
 	for my $f (@files) {
@@ -729,7 +729,7 @@ EOT3
 		$sender = delete($parsed_email{'From'});
 	}
 	if ($parsed_email{'In-Reply-To'}) {
-		$initial_reply_to = delete($parsed_email{'In-Reply-To'});
+		$initial_in_reply_to = delete($parsed_email{'In-Reply-To'});
 	}
 	if ($parsed_email{'Subject'}) {
 		$initial_subject = delete($parsed_email{'Subject'});
@@ -912,16 +912,16 @@ sub expand_one_alias {
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
@@ -941,7 +941,7 @@ if ($compose && $compose > 0) {
 }
 
 # Variables we set as part of the loop over files
-our ($message_id, %mail, $subject, $reply_to, $references, $message,
+our ($message_id, %mail, $subject, $in_reply_to, $references, $message,
 	$needs_confirm, $message_num, $ask_default);
 
 sub extract_valid_address {
@@ -1350,9 +1350,9 @@ Message-Id: $message_id
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
@@ -1529,8 +1529,8 @@ EOF
 	return 1;
 }
 
-$reply_to = $initial_reply_to;
-$references = $initial_reply_to || '';
+$in_reply_to = $initial_in_reply_to;
+$references = $initial_in_reply_to || '';
 $subject = $initial_subject;
 $message_num = 0;
 
@@ -1740,9 +1740,9 @@ foreach my $t (@files) {
 
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
2.16.2

