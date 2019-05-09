Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BFB21F488
	for <e@80x24.org>; Thu,  9 May 2019 11:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfEILsv (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 07:48:51 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:41237 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfEILst (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 07:48:49 -0400
Received: by mail-wr1-f50.google.com with SMTP id d12so2604218wrm.8
        for <git@vger.kernel.org>; Thu, 09 May 2019 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DdMXTOCkykwQkCGdb90RxClsSFKuR/yMmVxjjkqZFN8=;
        b=WMVYtO+Ead9gf9wL6ZoYXfEMt9oygktg4j5jhrOr09zGIWFZHIbGr3lTIrdHFWMLwD
         rWro6ajl3W9AmIvi5jDqPOwcqTq9euBQIktBvTfVFp6dX37nsNtOk5xn1KdnCCGvUcGX
         rZBcEZk//F+n8Bb3pFyb+p5LXHSsJjhYk7t5n8hoCJ4+H992ZPkFuZthJN3BkYKZU5tr
         vDp6HpnZOelNw/9UF+LiHEn7iAwzZVY9xYjVHAY+nobGzI5DjLqR6IVwY0fn7I4Q1Gc4
         y6ZWAIvifMHEGcsaBbBIZkGIa0aIJh6lU/WZDfawvuPw6m6hvjaJsEweyLk4FcOyLgM2
         wOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DdMXTOCkykwQkCGdb90RxClsSFKuR/yMmVxjjkqZFN8=;
        b=UYlnH1CCnFLqMKj06fZyIQZu3VgwvJICNzYtawOMt3UrfOLebXcWWQfOlKgpGTpEN0
         WAv9POFMXwueow5XNA+5fuYEC/dqc6vvuyXQNdUXt/o6+5I9hfVLTPxr+mz66H1eEsiz
         vV8lpLReZ8yi2L0ziyNfwYkoKLcBCzK0U7XaQC42FbLukgawvZL622I6aeHD4L3AA3Il
         skfuKdIVst1IXUqmnptGXCb5VFLnYUJXZq5lhUGTX1behcE+wHFTgvTUECOh6pc25SKV
         8KqdOD6zPYGKZE/2dtn0zQI1grQYse+xWnMal8Tn6G3UGigHlka/VoDGArxUxDHEV50x
         YQEw==
X-Gm-Message-State: APjAAAXfg3oZKRELUfmtbOUU0VkwPj+b08OvVSgga8r74CVYORHpGwnq
        TS+Qv5A3ygzeYg1SsCeSgp3OkRdP
X-Google-Smtp-Source: APXvYqzxyRByQTS9259Ajqq6a1b4wjfBaDZBZbEvIUxOM4im6pjEh8yWIhBP6hgb8W1BjIa+mI4w/A==
X-Received: by 2002:adf:b456:: with SMTP id v22mr958415wrd.55.1557402526231;
        Thu, 09 May 2019 04:48:46 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f1sm1610807wrc.93.2019.05.09.04.48.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 04:48:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/3] send-email: do defaults -> config -> getopt in that order
Date:   Thu,  9 May 2019 13:48:30 +0200
Message-Id: <20190509114830.29647-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <20190508105607.178244-1-gitster@pobox.com>
References: <20190508105607.178244-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the git-send-email command-line argument parsing and config
reading code to parse those two in the right order. I.e. first we set
our hardcoded defaults, then we read our config, and finally we read
the command-line, with later sets overriding earlier sets.

This fixes a bug introduced in e67a228cd8 ("send-email: automatically
determine transfer-encoding", 2018-07-08). That change broke the broke
the reading of sendmail.transferencoding because it wasn't careful to
update our fragile code dealing with doing this in the previous
"defaults -> getopt -> config" order..

But as we can see from the history for this file doing it this way was
never what we actually wanted, it just something we grew organically
as of 5483c71d7a ("git-send-email: make options easier to configure.",
2007-06-27) and have been dealing with the fallout since, e.g. in
463b0ea22b ("send-email: Fix %config_path_settings handling",
2011-10-14).

As can be seen in this change the only place where we actually want to
do something clever is with the to/cc/bcc variables, where setting
them on the command-line (or using --no-{to,cc,bcc}) should clear out
values we grab from the config.

All the rest are things where the command-line should simply override
the config values, and by reading the config first the config code
doesn't need all this "let's not set it was on the command-line"
special-casing, as [1] shows we'd otherwise need to care about the
difference between whether something was a default or present in
config to fix the bug in e67a228cd8.

1. https://public-inbox.org/git/20190508105607.178244-2-gitster@pobox.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl   | 92 +++++++++++++++++++++++--------------------
 t/t9001-send-email.sh | 13 +++++-
 2 files changed, 62 insertions(+), 43 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 48ed18a85c..fab255249f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -177,11 +177,15 @@ sub format_2822_time {
 my $re_encoded_word = qr/=\?($re_token)\?($re_token)\?($re_encoded_text)\?=/;
 
 # Variables we fill in automatically, or via prompting:
-my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@initial_bcc,$no_bcc,@xh,
+my (@to,@cc,,@xh,$envelope_sender,
 	$initial_in_reply_to,$reply_to,$initial_subject,@files,
-	$author,$sender,$smtp_authpass,$annotate,$use_xmailer,$compose,$time);
-
-my $envelope_sender;
+	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
+# Things we either get from config, *or* are overridden on the
+# command-line.
+my ($no_cc, $no_to, $no_bcc);
+my (@config_to, @getopt_to);
+my (@config_cc, @getopt_cc);
+my (@config_bcc, @getopt_bcc);
 
 # Example reply to:
 #$initial_in_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
@@ -228,33 +232,37 @@ sub do_edit {
 }
 
 # Variables with corresponding config settings
-my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
+my ($suppress_from, $signed_off_by_cc);
 my ($cover_cc, $cover_to);
 my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
 my ($batch_size, $relogin_delay);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
-my ($validate, $confirm);
+my ($confirm);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
 my ($compose_encoding);
-my $target_xfer_encoding = 'auto';
-
+# Variables with corresponding config settings & hardcoded defaults
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
+my $thread = 1;
+my $chain_reply_to = 0;
+my $use_xmailer = 1;
+my $validate = 1;
+my $target_xfer_encoding = 'auto';
 
 my %config_bool_settings = (
-    "thread" => [\$thread, 1],
-    "chainreplyto" => [\$chain_reply_to, 0],
-    "suppressfrom" => [\$suppress_from, undef],
-    "signedoffbycc" => [\$signed_off_by_cc, undef],
-    "cccover" => [\$cover_cc, undef],
-    "tocover" => [\$cover_to, undef],
-    "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
-    "validate" => [\$validate, 1],
-    "multiedit" => [\$multiedit, undef],
-    "annotate" => [\$annotate, undef],
-    "xmailer" => [\$use_xmailer, 1]
+    "thread" => \$thread,
+    "chainreplyto" => \$chain_reply_to,
+    "suppressfrom" => \$suppress_from,
+    "signedoffbycc" => \$signed_off_by_cc,
+    "cccover" => \$cover_cc,
+    "tocover" => \$cover_to,
+    "signedoffcc" => \$signed_off_by_cc,
+    "validate" => \$validate,
+    "multiedit" => \$multiedit,
+    "annotate" => \$annotate,
+    "xmailer" => \$use_xmailer,
 );
 
 my %config_settings = (
@@ -267,12 +275,12 @@ sub do_edit {
     "smtpauth" => \$smtp_auth,
     "smtpbatchsize" => \$batch_size,
     "smtprelogindelay" => \$relogin_delay,
-    "to" => \@initial_to,
+    "to" => \@config_to,
     "tocmd" => \$to_cmd,
-    "cc" => \@initial_cc,
+    "cc" => \@config_cc,
     "cccmd" => \$cc_cmd,
     "aliasfiletype" => \$aliasfiletype,
-    "bcc" => \@initial_bcc,
+    "bcc" => \@config_bcc,
     "suppresscc" => \@suppress_cc,
     "envelopesender" => \$envelope_sender,
     "confirm"   => \$confirm,
@@ -320,8 +328,9 @@ sub read_config {
 	my ($prefix) = @_;
 
 	foreach my $setting (keys %config_bool_settings) {
-		my $target = $config_bool_settings{$setting}->[0];
-		$$target = Git::config_bool(@repo, "$prefix.$setting") unless (defined $$target);
+		my $target = $config_bool_settings{$setting};
+		my $v = Git::config_bool(@repo, "$prefix.$setting");
+		$$target = $v if defined $v;
 	}
 
 	foreach my $setting (keys %config_path_settings) {
@@ -333,15 +342,13 @@ sub read_config {
 			}
 		}
 		else {
-			$$target = Git::config_path(@repo, "$prefix.$setting") unless (defined $$target);
+			my $v = Git::config_path(@repo, "$prefix.$setting");
+			$$target = $v if defined $v;
 		}
 	}
 
 	foreach my $setting (keys %config_settings) {
 		my $target = $config_settings{$setting};
-		next if $setting eq "to" and defined $no_to;
-		next if $setting eq "cc" and defined $no_cc;
-		next if $setting eq "bcc" and defined $no_bcc;
 		if (ref($target) eq "ARRAY") {
 			unless (@$target) {
 				my @values = Git::config(@repo, "$prefix.$setting");
@@ -349,7 +356,8 @@ sub read_config {
 			}
 		}
 		else {
-			$$target = Git::config(@repo, "$prefix.$setting") unless (defined $$target);
+			my $v = Git::config(@repo, "$prefix.$setting");
+			$$target = $v if defined $v;
 		}
 	}
 
@@ -363,6 +371,11 @@ sub read_config {
 	}
 }
 
+$identity = Git::config(@repo, "sendemail.identity");
+read_config("sendemail.$identity") if defined $identity;
+read_config("sendemail");
+read_config("sendemail");
+
 # Begin by accumulating all the variables (defined above), that we will end up
 # needing, first, from the command line:
 
@@ -378,12 +391,12 @@ sub read_config {
                     "in-reply-to=s" => \$initial_in_reply_to,
 		    "reply-to=s" => \$reply_to,
 		    "subject=s" => \$initial_subject,
-		    "to=s" => \@initial_to,
+		    "to=s" => \@getopt_to,
 		    "to-cmd=s" => \$to_cmd,
 		    "no-to" => \$no_to,
-		    "cc=s" => \@initial_cc,
+		    "cc=s" => \@getopt_cc,
 		    "no-cc" => \$no_cc,
-		    "bcc=s" => \@initial_bcc,
+		    "bcc=s" => \@getopt_bcc,
 		    "no-bcc" => \$no_bcc,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "no-chain-reply-to" => sub {$chain_reply_to = 0},
@@ -434,6 +447,11 @@ sub read_config {
 		    "git-completion-helper" => \$git_completion_helper,
 	 );
 
+# Munge any "either config or getopt, not both" variables
+my @initial_to = @getopt_to ? @getopt_to : ($no_to ? () : @config_to);
+my @initial_cc = @getopt_cc ? @getopt_cc : ($no_cc ? () : @config_cc);
+my @initial_bcc = @getopt_bcc ? @getopt_bcc : ($no_bcc ? () : @config_bcc);
+
 usage() if $help;
 completion_helper() if $git_completion_helper;
 unless ($rc) {
@@ -447,16 +465,6 @@ sub read_config {
 	"(via command-line or configuration option)\n")
 	if defined $relogin_delay and not defined $batch_size;
 
-# read configuration from [sendemail "$identity"], fall back on [sendemail]
-$identity = Git::config(@repo, "sendemail.identity") unless (defined $identity);
-read_config("sendemail.$identity") if (defined $identity);
-read_config("sendemail");
-
-# fall back on builtin bool defaults
-foreach my $setting (values %config_bool_settings) {
-	${$setting->[0]} = $setting->[1] unless (defined (${$setting->[0]}));
-}
-
 # 'default' encryption is none -- this only prevents a warning
 $smtp_encryption = '' unless (defined $smtp_encryption);
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1e3ac3c384..1b18201ce2 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1461,7 +1461,18 @@ test_expect_success $PREREQ '--transfer-encoding overrides sendemail.transferEnc
 	test -z "$(ls msgtxt*)"
 '
 
-test_expect_success $PREREQ 'sendemail.transferencoding=8bit' '
+test_expect_success $PREREQ 'sendemail.transferencoding=8bit via config' '
+	clean_fake_sendmail &&
+	git -c sendemail.transferencoding=8bit send-email \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		email-using-8bit \
+		2>errors >out &&
+	sed '1,/^$/d' msgtxt1 >actual &&
+	sed '1,/^$/d' email-using-8bit >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success $PREREQ 'sendemail.transferencoding=8bit via cli' '
 	clean_fake_sendmail &&
 	git send-email \
 		--transfer-encoding=8bit \
-- 
2.21.0.1020.gf2820cf01a

