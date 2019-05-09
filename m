Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3EB1F45F
	for <e@80x24.org>; Thu,  9 May 2019 11:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfEILsq (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 07:48:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34704 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfEILsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 07:48:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id f7so2646862wrq.1
        for <git@vger.kernel.org>; Thu, 09 May 2019 04:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cY8jRppbVZA5tSfIS9tca3+X5Lu+5uON7gB0LzZoLF4=;
        b=tFqi554ujJEtJjFtaxrmMnEfkG0XdzZG4rM8sSMO9E09U5SF3WmR2f6LL3bZpEeS7y
         gdlTwKO0hoxTGeU/FpLmxBOiJsKmBSA1puTAvLZIu8xjA25QbCoM1j98101YZAQrZyK2
         P2JaezTJaDNsh8+oGkk+k5ubyqJ4UhZqTtDjFe88vFKNDXjTGykIv8Mfavox5uafE+2q
         ren1cY44kzx/lRvoQASJ+ee+BdRdZ1IABsQnHPkfdSilkz1udtt4G6odbnXSE0qaWyCD
         +yzsY1QNgI6WR7vdAdPq8Jn5d2Qdpo6z80n64wdMMY3TlQrISsUTaxpH7cpvXgyKogUs
         /vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cY8jRppbVZA5tSfIS9tca3+X5Lu+5uON7gB0LzZoLF4=;
        b=LUA/bvCCIyB34FZfTuYiKS1YSwLKF1oekZrm80YTnRnJ+WxF5fUfItaG+UNLBCG4sY
         DdvHVswt3rtATzV6Qt3WsT6T5DvyISyAX4d0CJIOGxXLJ7NnNfdvfgSyPCuldKKDv9/7
         EESHzks23eGnADsfxhnXfgjB7KAQ6lr9HMoSjEOcBBXMUuCaG5/pmEmjt//Vv6pwJVNZ
         t5zvwTOYgLbKHEu9MgpL6dmhncTEMr6g7B6XoEz+JtTg43p9tmIrmPBTYO2hT0j2cYYc
         s+qAeoXqHZZ7qLCtFGCJK63Pdst+G89Le/9IP9/+k4DdHsP5KEeSBNnd390jORUu2sNd
         JTew==
X-Gm-Message-State: APjAAAXdOKTlME37lk+CiMhhgagUVH6m2afttIlp2aC8I5GwkyCu+c0c
        jeTw00ZFRt5Np77hhHp5GCkYJTDy
X-Google-Smtp-Source: APXvYqzJjIndqy+EVdW7eq9YGTU/QkCH9mXc3vdFdMnnoxAZqqq28jnzIyPNe/eJL93lJ+2MsYfrPQ==
X-Received: by 2002:adf:e6cc:: with SMTP id y12mr494787wrm.261.1557402523147;
        Thu, 09 May 2019 04:48:43 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f1sm1610807wrc.93.2019.05.09.04.48.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 04:48:42 -0700 (PDT)
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
Subject: [PATCH v3 1/3] send-email: move the read_config() function above getopts
Date:   Thu,  9 May 2019 13:48:28 +0200
Message-Id: <20190509114830.29647-2-avarab@gmail.com>
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

This is in preparation for a later change where we'll read the config
first before parsing command-line options. As the move detection will
show no lines (except one line of comment) is changed here, just moved
around.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 97 ++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 49 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 24859a7bc3..0d87ed2b5d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -315,6 +315,54 @@ sub signal_handler {
 $SIG{TERM} = \&signal_handler;
 $SIG{INT}  = \&signal_handler;
 
+# Read our sendemail.* config
+sub read_config {
+	my ($prefix) = @_;
+
+	foreach my $setting (keys %config_bool_settings) {
+		my $target = $config_bool_settings{$setting}->[0];
+		$$target = Git::config_bool(@repo, "$prefix.$setting") unless (defined $$target);
+	}
+
+	foreach my $setting (keys %config_path_settings) {
+		my $target = $config_path_settings{$setting};
+		if (ref($target) eq "ARRAY") {
+			unless (@$target) {
+				my @values = Git::config_path(@repo, "$prefix.$setting");
+				@$target = @values if (@values && defined $values[0]);
+			}
+		}
+		else {
+			$$target = Git::config_path(@repo, "$prefix.$setting") unless (defined $$target);
+		}
+	}
+
+	foreach my $setting (keys %config_settings) {
+		my $target = $config_settings{$setting};
+		next if $setting eq "to" and defined $no_to;
+		next if $setting eq "cc" and defined $no_cc;
+		next if $setting eq "bcc" and defined $no_bcc;
+		if (ref($target) eq "ARRAY") {
+			unless (@$target) {
+				my @values = Git::config(@repo, "$prefix.$setting");
+				@$target = @values if (@values && defined $values[0]);
+			}
+		}
+		else {
+			$$target = Git::config(@repo, "$prefix.$setting") unless (defined $$target);
+		}
+	}
+
+	if (!defined $smtp_encryption) {
+		my $enc = Git::config(@repo, "$prefix.smtpencryption");
+		if (defined $enc) {
+			$smtp_encryption = $enc;
+		} elsif (Git::config_bool(@repo, "$prefix.smtpssl")) {
+			$smtp_encryption = 'ssl';
+		}
+	}
+}
+
 # Begin by accumulating all the variables (defined above), that we will end up
 # needing, first, from the command line:
 
@@ -399,55 +447,6 @@ sub signal_handler {
 	"(via command-line or configuration option)\n")
 	if defined $relogin_delay and not defined $batch_size;
 
-# Now, let's fill any that aren't set in with defaults:
-
-sub read_config {
-	my ($prefix) = @_;
-
-	foreach my $setting (keys %config_bool_settings) {
-		my $target = $config_bool_settings{$setting}->[0];
-		$$target = Git::config_bool(@repo, "$prefix.$setting") unless (defined $$target);
-	}
-
-	foreach my $setting (keys %config_path_settings) {
-		my $target = $config_path_settings{$setting};
-		if (ref($target) eq "ARRAY") {
-			unless (@$target) {
-				my @values = Git::config_path(@repo, "$prefix.$setting");
-				@$target = @values if (@values && defined $values[0]);
-			}
-		}
-		else {
-			$$target = Git::config_path(@repo, "$prefix.$setting") unless (defined $$target);
-		}
-	}
-
-	foreach my $setting (keys %config_settings) {
-		my $target = $config_settings{$setting};
-		next if $setting eq "to" and defined $no_to;
-		next if $setting eq "cc" and defined $no_cc;
-		next if $setting eq "bcc" and defined $no_bcc;
-		if (ref($target) eq "ARRAY") {
-			unless (@$target) {
-				my @values = Git::config(@repo, "$prefix.$setting");
-				@$target = @values if (@values && defined $values[0]);
-			}
-		}
-		else {
-			$$target = Git::config(@repo, "$prefix.$setting") unless (defined $$target);
-		}
-	}
-
-	if (!defined $smtp_encryption) {
-		my $enc = Git::config(@repo, "$prefix.smtpencryption");
-		if (defined $enc) {
-			$smtp_encryption = $enc;
-		} elsif (Git::config_bool(@repo, "$prefix.smtpssl")) {
-			$smtp_encryption = 'ssl';
-		}
-	}
-}
-
 # read configuration from [sendemail "$identity"], fall back on [sendemail]
 $identity = Git::config(@repo, "sendemail.identity") unless (defined $identity);
 read_config("sendemail.$identity") if (defined $identity);
-- 
2.21.0.1020.gf2820cf01a

