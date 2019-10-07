Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4F11F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 17:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfJGRMC (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 13:12:02 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:43186 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfJGRMC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 13:12:02 -0400
Received: by mail-lf1-f54.google.com with SMTP id u3so9801700lfl.10
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORG2fp3WB2+azP8Ee3pglajKGEamKQzSXs4w9a8mED8=;
        b=mBZ1AzxYY67CbwRS5jYgl0avB2AgjbOM+Oe/YvaKz6YCsC1UMlSfx3X5n6AlH64Ios
         t4iDZWK7Ozg2ND2W6SxtFuMK9Tg+B+9qRCRAmNysn31v01ClXZQk8QLOO/UwHW4F7DQY
         rmc1P1vt2S75sqxmXWTN6C+ZbRM83JTiDRTrg3s78jRAvGSYM7MUVbUAC4RTtBzD9j6G
         Tx1WQ06Zu1DzAw3FH9IGROgY1Xefqs8JJhiN2Rbzs1sED6TTbRHTs4Rgk28tjZB2vxSy
         QGI/wtrV6Uuv+TL68UmfSDzVJSyWyuncW9utHyC2UhxF3oZqmHaRVRvfexG7znRsZSBw
         ICuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORG2fp3WB2+azP8Ee3pglajKGEamKQzSXs4w9a8mED8=;
        b=I4rxDYNf6K+pnYyGUWDo5/f4jZLx06vFcbFAK/oEWTnxZca5TR+TgbSDNh8M8zNsA4
         cHmdUbqhHfokeMokXy5SfYCRTNXKMSv2Ig4iZrPlgbHR3Ej4OsJeKryevpfOkvl0epD2
         9xexEamFE/EEq/1HNWMKXKhmBrX8XoG3TBSNKZ4eoOQewSmEj5VNWenpEUvY66X9Usix
         HYC+r5cn3FNdVfw+PxUXNcbH6Hkaz6SSnSAZiOITWvCGXrSAaS3AqhvRZHCdGik46Jnd
         P+/+9zScIhIudim1Whzi2syNreddeqViYWx8b+ZYIYNgQWtuWV8+/SkYWtbBNcgZ+rn/
         AmRg==
X-Gm-Message-State: APjAAAWBXCnwKpntL3Ju+k+1dzGr/KN+mMjVsrgPcYjQVkIkKZL4ze+n
        VR9F9xawP3AkQmBVDee1UfqVQRJpgCQ=
X-Google-Smtp-Source: APXvYqwpF5HcKjGuK8bVNPFx/gqFL6i1mx68CO5CAWXAU5cfp14ydsFsWPFCEiYfijR1kjeTsBCMcA==
X-Received: by 2002:a19:c709:: with SMTP id x9mr17755196lff.20.1570468319755;
        Mon, 07 Oct 2019 10:11:59 -0700 (PDT)
Received: from localhost.localdomain (static243-191-189.mimer.net. [83.243.191.189])
        by smtp.gmail.com with ESMTPSA id n17sm3209477ljc.44.2019.10.07.10.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 10:11:58 -0700 (PDT)
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
To:     git@vger.kernel.org
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: [PATCH 1/2] git-gui: implement proc select_path_in_widget
Date:   Mon,  7 Oct 2019 19:11:44 +0200
Message-Id: <20191007171145.1259-1-birger.sp@gmail.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com>
References: <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
---
 git-gui.sh | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index fd476b6..b7f4d1e 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2669,25 +2669,31 @@ proc show_less_context {} {
 }
 
 proc focus_widget {widget} {
-	global file_lists last_clicked selected_paths
-	global file_lists_last_clicked
+	global file_lists
 
 	if {[llength $file_lists($widget)] > 0} {
-		set path $file_lists_last_clicked($widget)
-		set index [lsearch -sorted -exact $file_lists($widget) $path]
-		if {$index < 0} {
-			set index 0
-			set path [lindex $file_lists($widget) $index]
-		}
-
+		select_path_in_widget $widget
 		focus $widget
-		set last_clicked [list $widget [expr $index + 1]]
-		array unset selected_paths
-		set selected_paths($path) 1
-		show_diff $path $widget
 	}
 }
 
+proc select_path_in_widget {widget} {
+	global file_lists last_clicked selected_paths
+	global file_lists_last_clicked
+
+	set path $file_lists_last_clicked($widget)
+	set index [lsearch -sorted -exact $file_lists($widget) $path]
+	if {$index < 0} {
+		set index 0
+		set path [lindex $file_lists($widget) $index]
+	}
+
+	set last_clicked [list $widget [expr $index + 1]]
+	array unset selected_paths
+	set selected_paths($path) 1
+	show_diff $path $widget
+}
+
 proc toggle_commit_type {} {
 	global commit_type_is_amend
 	set commit_type_is_amend [expr !$commit_type_is_amend]
-- 
2.23.0.windows.1

