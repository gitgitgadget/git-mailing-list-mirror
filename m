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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3381F4BE
	for <e@80x24.org>; Tue,  1 Oct 2019 10:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfJAKIZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 06:08:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50274 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbfJAKIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 06:08:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so2668801wmg.0
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p6gZguNgvwZB8vI/G5pxy9Kbcc1PQdGs9zF49YkIV6k=;
        b=gRz05KgfEt6k4FXzklB3asVPgXLAYUwcihz0S5ZgzDnvjjSldOoPlLgvRuC/q6oEL9
         QopPnMYtKMEJImwj/+g2v7DfNhPwf5jKzAhhScYxwyFxHENvFsKvaVK5AjG1x8H3ZNTN
         SoSYDkHhbzKNd3z8jF6iogdm6Uk5r1hlQler/2A1AHrSAV8CQ8z/ke2HqJ5mkPwmLH+y
         b28dbpLRRfEzrl7l78TO82qvq7B81rIj2GHDHjjvacuYC2YsJsD4YxvONvkO3xUCi3XP
         cigM0JrYkvVgqkNjJZLnQl8/frE+Tb8eXEf7Vwh3hDBoiBogX/SaB8V2FoqdPK3OMTSd
         EMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p6gZguNgvwZB8vI/G5pxy9Kbcc1PQdGs9zF49YkIV6k=;
        b=ZUho4tWwDCE1aFJbc86YG/J+F4Ru2NRBpPDVuzzD16HDrqmHqF8U0evNP/75jBRMEE
         asqKG700iZE7lem3CljWj7ZpceCWsr6sdBqOhUbGB/oWskGyalY7nl8uebyyrT5X7gxd
         i5J7ZThxEHUrtxrsFuRi1AiEqJRDgnfc6vEnVGeUqdcGwoH5EEwB1UmitBcqSfWBn9uH
         z1bGPWVaDIUoT2UDB7VNNJBnsIzEN2lxGaggUJg+zb9FN48dHkixXo0ShaWZ5cI7IjKd
         NhwVdE3R7GtK6L5AeNAQ625w7yR01X0FQ4HdM3cWvSdJi3Kf6B0bxOgIYhhIHQKKJw8J
         Byzw==
X-Gm-Message-State: APjAAAWO5yrD8pJ5PEI2N8eCBNI93saTgcSfoWkdNykq7ZX8JX8glHD1
        AHzvSoFv+bjKzCI2Q+8=
X-Google-Smtp-Source: APXvYqzPLzYGKFnm1D3KX0hIYSmG1N4MbYoJmNwINe9v+hpipUyttnRjEedemZiTm7Hbh4OMHKdWSQ==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr3121183wmo.114.1569924503017;
        Tue, 01 Oct 2019 03:08:23 -0700 (PDT)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id s12sm34435286wra.82.2019.10.01.03.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 03:08:22 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>, paulus@ozlabs.org
Subject: [PATCH] gitk: Add horizontal scrollbar to the files list
Date:   Tue,  1 Oct 2019 12:08:21 +0200
Message-Id: <5c5803ac99b6aaf7ca39393422ca9aa17f0280ec.1569910203.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.23.0.11.g242cf7f110
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrapping filenames is an unexpected experience in UX design. Disable
wrapping and add a horizontal scrollbar to the files list to remove this.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 gitk | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index abe4805..bf2a061 100755
--- a/gitk
+++ b/gitk
@@ -2477,13 +2477,16 @@ proc makewindow {} {
 	-background $bgcolor -foreground $fgcolor \
 	-font mainfont \
 	-tabs [list $indent [expr {2 * $indent}]] \
-	-yscrollcommand ".bright.sb set" \
+	-xscrollcommand ".bright.sbx set" \
+	-yscrollcommand ".bright.sby set" \
 	-cursor [. cget -cursor] \
-	-spacing1 1 -spacing3 1
+	-spacing1 1 -spacing3 1 -wrap none
     lappend bglist $cflist
     lappend fglist $cflist
-    ${NS}::scrollbar .bright.sb -command "$cflist yview"
-    pack .bright.sb -side right -fill y
+    ${NS}::scrollbar .bright.sbx -orient horizontal -command "$cflist xview"
+    ${NS}::scrollbar .bright.sby -orient vertical   -command "$cflist yview"
+    pack .bright.sbx -side bottom -fill x
+    pack .bright.sby -side right -fill y
     pack $cflist -side left -fill both -expand 1
     $cflist tag configure highlight \
 	-background [$cflist cget -selectbackground]
-- 
2.23.0.11.g242cf7f110

