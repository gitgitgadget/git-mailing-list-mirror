Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5311D1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 15:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeCCPjO (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:39:14 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:42647 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbeCCPjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:39:09 -0500
Received: by mail-wr0-f174.google.com with SMTP id k9so12939086wre.9
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1+C3cOgcpDFgnT4zHDL3yNbgh+0207NBARsjEpCJHX0=;
        b=KNVdQwX/ZXqHWHTPUkYBQpZpBuJ0dLE5GTElntaUrsDY/P953cmek23ja5jrQbxu5m
         jclNTTY0xjmDSYuZtxpPHV71ptqZjbxQ62l3JkzYLxfRGsKJgumTpel+k50VsskTpezc
         /Y5CrnIz4OfETiUF4v5yfzHKC4/QFFOk/sZDOEMfbjm/4PDKxVU35PuwCZyVBm+HImTo
         II+yrxOySvnQJPkdzFj6hmwyLiRHQ1Em9PsOiLrDuyaSGNT9iqaOXdV+drhLvUBFET2d
         9OOSLAYqzcRMQvacF9mrlXhxNlEDVYRsydL5v2NfAyTe91aW5arpPsUvOcrERlIfWLEI
         /nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1+C3cOgcpDFgnT4zHDL3yNbgh+0207NBARsjEpCJHX0=;
        b=e4HfULWo29wb2aqnt1VTEBSW8M2ApXMFiLyDmPiNrZ/w6+kI80dCuDg8q9rDgcB6Np
         Gs+xDU/sDLXAKCv63IIreub4haPgGAuDioiSdgaZrj+CViudUNGzXLnnjuijY0YnCCkG
         bllv8RYoNPyOBhEev/5kGXaW8DAqnyjV39raCexn2M9kIwGAH41S2ZJowL3F0a/HFGbd
         S43C6g8dCA5esZ1OINUIXpdErkilDZs9M5wmz1Fbs6MoKAVAl3xR2yQItzXdw6Nc5Yh0
         dgIGixnRU3sIYN0h9obLsKrtEUjlMFBxIiRtWpempeBpgwR36SRwHGMOPB9aS0hsd6em
         XSWQ==
X-Gm-Message-State: APf1xPASUBgLcokI5TfR2vL/UAltBVSfefyB0MGDj+aZXxnGW9J3njn/
        xoD2c6OpVb/I7bBaKiPuONPGWn/m
X-Google-Smtp-Source: AG47ELvFM4pGkRUiXJLVJ/xP+HJSGskhJan7+UdvNzk+wXgkczJD3+s0xoJCK/khEKFVojb3FJOL5Q==
X-Received: by 10.223.171.247 with SMTP id s110mr7998225wrc.106.1520091547901;
        Sat, 03 Mar 2018 07:39:07 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y1sm6899379wrh.80.2018.03.03.07.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 07:39:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/13] git-send-email: unconditionally use Net::{SMTP,Domain}
Date:   Sat,  3 Mar 2018 15:38:10 +0000
Message-Id: <20180303153817.20270-7-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180303153817.20270-1-avarab@gmail.com>
References: <20180303153817.20270-1-avarab@gmail.com>
In-Reply-To: <20180225194637.18630-1-avarab@gmail.com>
References: <20180225194637.18630-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Net::SMTP and Net::Domain were both first released with perl
v5.7.3[1], since my d48b284183 ("perl: bump the required Perl version
to 5.8 from 5.6.[21]", 2010-09-24) we've depended on 5.8, so there's
no reason to conditionally require them anymore.

This conditional loading was initially added in
87840620fd ("send-email: only 'require' instead of 'use' Net::SMTP",
2006-06-01) for Net::SMTP and 134550fe21 ("git-send-email.perl - try
to give real name of the calling host to HELO/EHLO", 2010-03-14) for
Net::Domain, both of which predate the hard dependency on 5.8.

Since they're guaranteed to be installed now let's "use" them
instead. The cost of loading them both is trivial given what
git-send-email does (~15ms on my system), and it's better to not defer
any potential loading errors until runtime.

This patch is better viewed with -w, which shows that the only change
in the last two hunks is removing the "if eval" wrapper block.

1. $ parallel 'corelist {}' ::: Net::{SMTP,Domain}
   Data for 2015-02-14
   Net::SMTP was first released with perl v5.7.3

   Data for 2015-02-14
   Net::Domain was first released with perl v5.7.3

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index bbf4deaa0d..d5a4826a1c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -31,6 +31,8 @@ use Cwd qw(abs_path cwd);
 use Git;
 use Git::I18N;
 use Git::Mail::Address;
+use Net::Domain ();
+use Net::SMTP ();
 
 Getopt::Long::Configure qw/ pass_through /;
 
@@ -1143,10 +1145,8 @@ sub valid_fqdn {
 sub maildomain_net {
 	my $maildomain;
 
-	if (eval { require Net::Domain; 1 }) {
-		my $domain = Net::Domain::domainname();
-		$maildomain = $domain if valid_fqdn($domain);
-	}
+	my $domain = Net::Domain::domainname();
+	$maildomain = $domain if valid_fqdn($domain);
 
 	return $maildomain;
 }
@@ -1154,17 +1154,15 @@ sub maildomain_net {
 sub maildomain_mta {
 	my $maildomain;
 
-	if (eval { require Net::SMTP; 1 }) {
-		for my $host (qw(mailhost localhost)) {
-			my $smtp = Net::SMTP->new($host);
-			if (defined $smtp) {
-				my $domain = $smtp->domain;
-				$smtp->quit;
+	for my $host (qw(mailhost localhost)) {
+		my $smtp = Net::SMTP->new($host);
+		if (defined $smtp) {
+			my $domain = $smtp->domain;
+			$smtp->quit;
 
-				$maildomain = $domain if valid_fqdn($domain);
+			$maildomain = $domain if valid_fqdn($domain);
 
-				last if $maildomain;
-			}
+			last if $maildomain;
 		}
 	}
 
-- 
2.15.1.424.g9478a66081

