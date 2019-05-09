Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF7091F45F
	for <e@80x24.org>; Thu,  9 May 2019 11:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfEILsr (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 07:48:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34972 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfEILsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 07:48:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id w12so2650962wrp.2
        for <git@vger.kernel.org>; Thu, 09 May 2019 04:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ywpIZC1NTyz+Q5zHKkTkBe5Tkpt6ollY3JK1DxfInyo=;
        b=utHaAYIqw5BnhndbfPTTkNnfKkrN/4A3UVztyovlvJianiZWGhJSCWSaENgcELh03P
         iFGG+0zGQodsPMHs/u9lTWmKjO6aaLSU5Zkw0B9Fdse4udTuse/Qlu7/u55VwI0ISpzN
         DgmvNIBt/CJda2Wj4J+4FXbeP2esIDjicp6BYKbIGWkD7hyv2AKztH9APvlzU68OxZAy
         JbqFJAOb+LdnEA7hV6j9ZOre3ID3xX4f776rSFoeLVwKYrj7nRVb72Er711BbyHp9BHW
         Q/vnvbh+U/isFi0guKwZ8m54+lgtR/HEMDPOz9j1cwhYZthHsSKpAiLdgxb/uIzxoEVb
         w7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ywpIZC1NTyz+Q5zHKkTkBe5Tkpt6ollY3JK1DxfInyo=;
        b=SjSEo+FCgV6dq+Br+cSUZlg0Pl/o80Ek7b6hFCBqVv9oPpw8ubGi2Eg5OeUBvyAMqb
         LUrcvIEAozb4h2hzflGXJ5ktqiV9azhJfUN1odykKRhb9vOARX1e3Xe7AXNR8ibxQY4k
         BE9XvRiBKrwu9vLhYf3qmf9tbGTuOYVNXHFeMlxDuR9qOmnXylF77KZM9stahchyT9R1
         eBRckG2xvYbUxwHpCUWFweY3d4Sre0zzc+wbLzZePki4HOKRsqSq6WVfX/d6Ik/VRnD1
         wiScUxUCIHNAnY/ufP6SmetP274Na/mZu+eYQ6DZPo3kjUK2uutaNR+/pC5W62Ib5E7I
         XVPw==
X-Gm-Message-State: APjAAAWXybMrwgmmbPKI6Sepd1CKoGLrbj96ZKmuynuPenD28uvZsL/Y
        QlnQ1xd9ecKUz7cYm563yGdhhfDF
X-Google-Smtp-Source: APXvYqxLNRqKCKOenMvGTZqoUisLzi6R2qrKeyqpNtCNW92PsXtxQEAOG9KaDJNj48X4py5jUvrCvg==
X-Received: by 2002:adf:906c:: with SMTP id h99mr2772701wrh.198.1557402524698;
        Thu, 09 May 2019 04:48:44 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f1sm1610807wrc.93.2019.05.09.04.48.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 04:48:43 -0700 (PDT)
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
Subject: [PATCH v3 2/3] send-email: rename the @bcclist variable for consistency
Date:   Thu,  9 May 2019 13:48:29 +0200
Message-Id: <20190509114830.29647-3-avarab@gmail.com>
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

The "to" and "cc" variables are named @initial_{to,cc}, let's rename
this one to match them.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0d87ed2b5d..48ed18a85c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -177,7 +177,7 @@ sub format_2822_time {
 my $re_encoded_word = qr/=\?($re_token)\?($re_token)\?($re_encoded_text)\?=/;
 
 # Variables we fill in automatically, or via prompting:
-my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
+my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@initial_bcc,$no_bcc,@xh,
 	$initial_in_reply_to,$reply_to,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$use_xmailer,$compose,$time);
 
@@ -272,7 +272,7 @@ sub do_edit {
     "cc" => \@initial_cc,
     "cccmd" => \$cc_cmd,
     "aliasfiletype" => \$aliasfiletype,
-    "bcc" => \@bcclist,
+    "bcc" => \@initial_bcc,
     "suppresscc" => \@suppress_cc,
     "envelopesender" => \$envelope_sender,
     "confirm"   => \$confirm,
@@ -383,7 +383,7 @@ sub read_config {
 		    "no-to" => \$no_to,
 		    "cc=s" => \@initial_cc,
 		    "no-cc" => \$no_cc,
-		    "bcc=s" => \@bcclist,
+		    "bcc=s" => \@initial_bcc,
 		    "no-bcc" => \$no_bcc,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "no-chain-reply-to" => sub {$chain_reply_to = 0},
@@ -940,7 +940,7 @@ sub expand_one_alias {
 
 @initial_to = process_address_list(@initial_to);
 @initial_cc = process_address_list(@initial_cc);
-@bcclist = process_address_list(@bcclist);
+@initial_bcc = process_address_list(@initial_bcc);
 
 if ($thread && !defined $initial_in_reply_to && $prompting) {
 	$initial_in_reply_to = ask(
@@ -1363,7 +1363,7 @@ sub send_message {
 		    }
 	       @cc);
 	my $to = join (",\n\t", @recipients);
-	@recipients = unique_email_list(@recipients,@cc,@bcclist);
+	@recipients = unique_email_list(@recipients,@cc,@initial_bcc);
 	@recipients = (map { extract_valid_address_or_die($_) } @recipients);
 	my $date = format_2822_time($time++);
 	my $gitversion = '@@GIT_VERSION@@';
-- 
2.21.0.1020.gf2820cf01a

