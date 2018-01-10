Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57FE21FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 10:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754034AbeAJKHW (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 05:07:22 -0500
Received: from s019.cyon.net ([149.126.4.28]:59076 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752451AbeAJKHU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 05:07:20 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jan 2018 05:07:19 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Gh7EXv3d/457Mfd//GtD8lLC7hm6in2Fz45mJyVrrvI=; b=d4nGSw4BVl5+4DpNFnXwGJ7P2S
        3Ko6g23b4ChAM2LR6uMrKAaAi+MQQ5ZJYgEH0sNMM4nl6QFEyNEPvJqKJ2KzEZ9xkEhnAYf43cEpN
        hc//wuM2TFdVizdnUVZ0b7vD0IR6d0/OgcjWs520Ns67bjPi7cjDeMdnYckiwuhpx8rArB1KHfoyD
        9DJeo6Qu8JjNqqTs4XDO2FjhhkJ3Ko3MZae02mvNguwloUF/fvp/dWo/Gj0vpk0mwAgcJ9+K6SdEV
        B5KhJQQv2kn+6tZ6q3FLz0w/V4RBW+pOrxOccklprTUIKcNtAEn7u4t4HlQRdBI5j6Rcs8OfVjVAV
        eC/rfpMQ==;
Received: from [10.20.10.233] (port=64192 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.89)
        (envelope-from <bb@drbeat.li>)
        id 1eZD9o-0006sf-Mi; Wed, 10 Jan 2018 10:58:55 +0100
Received: by drbeat.li (Postfix, from userid 1000)
        id 412DB20197; Wed, 10 Jan 2018 10:58:52 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH] t3900: add some more quotes
Date:   Wed, 10 Jan 2018 10:58:32 +0100
Message-Id: <20180110095832.22077-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.15.0.rc1.299.gda03b47c3
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 89a70b80 ("t0302 & t3900: add forgotten quotes", 2018-01-03), quotes
were added to protect against spaces in $HOME. In the test_when_finished
hander, two files are deleted which must be quoted individually.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 t/t3900-i18n-commit.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 9e4e694d9..dc00db87b 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -40,7 +40,7 @@ test_expect_success 'UTF-16 refused because of NULs' '
 '
 
 test_expect_success 'UTF-8 invalid characters refused' '
-	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
+	test_when_finished "rm -f \"$HOME/stderr\" \"$HOME/invalid\"" &&
 	echo "UTF-8 characters" >F &&
 	printf "Commit message\n\nInvalid surrogate:\355\240\200\n" \
 		>"$HOME/invalid" &&
@@ -49,7 +49,7 @@ test_expect_success 'UTF-8 invalid characters refused' '
 '
 
 test_expect_success 'UTF-8 overlong sequences rejected' '
-	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
+	test_when_finished "rm -f \"$HOME/stderr\" \"$HOME/invalid\"" &&
 	rm -f "$HOME/stderr" "$HOME/invalid" &&
 	echo "UTF-8 overlong" >F &&
 	printf "\340\202\251ommit message\n\nThis is not a space:\300\240\n" \
@@ -59,7 +59,7 @@ test_expect_success 'UTF-8 overlong sequences rejected' '
 '
 
 test_expect_success 'UTF-8 non-characters refused' '
-	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
+	test_when_finished "rm -f \"$HOME/stderr\" \"$HOME/invalid\"" &&
 	echo "UTF-8 non-character 1" >F &&
 	printf "Commit message\n\nNon-character:\364\217\277\276\n" \
 		>"$HOME/invalid" &&
@@ -68,7 +68,7 @@ test_expect_success 'UTF-8 non-characters refused' '
 '
 
 test_expect_success 'UTF-8 non-characters refused' '
-	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
+	test_when_finished "rm -f \"$HOME/stderr\" \"$HOME/invalid\"" &&
 	echo "UTF-8 non-character 2." >F &&
 	printf "Commit message\n\nNon-character:\357\267\220\n" \
 		>"$HOME/invalid" &&
-- 
2.15.0.rc1.299.gda03b47c3

