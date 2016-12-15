Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC4DC209E6
	for <e@80x24.org>; Thu, 15 Dec 2016 11:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757416AbcLOL3U (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 06:29:20 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36705 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755591AbcLOL3E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 06:29:04 -0500
Received: by mail-pg0-f67.google.com with SMTP id x23so5958687pgx.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 03:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y5MjTmifyrctpIQMG4VbLr0RhugpduuLiXj4cKWs2ig=;
        b=p0RKJSq3CoboCz63i1LejAnU7bVL4JHhw4pZke4KiXmQNG5B0RmW7svnTjT1dEJ2hD
         f+h1gecXkxd1eDQW+6f6tGwSJUu6OMDP6MZwyZVYvyGpzE2Sg8y1UAF2YkRc4gj+J8eu
         1NKUi/6hsnJzYUHvQoVe8j2FRMYrj2lTBC/oUhYZI3lXQ737KhS73rcz8+MAWZ4vhEY0
         9OgLyDjUNrpBKHIpGJ/DksCvMCALVbm8hapVNgl7LheUX91YeRgQUAD8HJgs8C9Cba8E
         vPLBeb7ljpSBHdRkXCccfkq45KwlYE5IbQK71oQILSx5yjhW90JsrOrZ7Jhfe76rPb0W
         3Wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y5MjTmifyrctpIQMG4VbLr0RhugpduuLiXj4cKWs2ig=;
        b=Z7c99ns3tApkI85vfW10mYcRa8lpg8cSVNuK/VAWmhqaPkLIvK95MbxQVhFxvbs1rk
         hRVIH9MaPL2c8RDXlXcqECjLTHzc7ypyKREYsBGrOxvMJ3uEoXm/dCQxsY79apiHFTGE
         uKUaHEtPSIAl0OLYSnfXY8acab7I684oC4PsWYx5DEy6I7tUW0vd9YFDXOSR2zlWw+Me
         J8V1YQEK88NSVaRCfDUWTeZ5L2oHTtvbWFDW7HnO//y3ReXeqgLK5V6nzUy7iWNwG0X5
         vLbGow2dCVqx3rBtSOE/2BER55UWV0zUpd8o3C3czKxs5p1CS4j6hWEhtWwlhEMeUu5L
         IEUA==
X-Gm-Message-State: AKaTC02SnQIvC0G4/VcYvWlTk+XAMJffEHQvoAs4DeyEWLC16eGhKZ0bI4HbfJV7wq3l0w==
X-Received: by 10.84.151.9 with SMTP id i9mr1615429pli.67.1481801343583;
        Thu, 15 Dec 2016 03:29:03 -0800 (PST)
Received: from kpdpro.suho.local ([118.211.97.195])
        by smtp.gmail.com with ESMTPSA id 189sm3930190pgh.5.2016.12.15.03.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2016 03:29:02 -0800 (PST)
From:   Pierre Dumuid <pmdumuid@gmail.com>
To:     paulus@ozlabs.org, git@vger.kernel.org
Cc:     Pierre Dumuid <pmdumuid@gmail.com>
Subject: [PATCH 4/6] Add DirDiffTool as additional option
Date:   Thu, 15 Dec 2016 21:58:45 +1030
Message-Id: <20161215112847.14719-4-pmdumuid@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161215112847.14719-1-pmdumuid@gmail.com>
References: <20161215112847.14719-1-pmdumuid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Pierre Dumuid <pmdumuid@gmail.com>
---
 gitk | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/gitk b/gitk
index a894f1d..5f27716 100755
--- a/gitk
+++ b/gitk
@@ -2661,6 +2661,9 @@ proc makewindow {} {
 	{mc "Diff this -> marked commit" command {diffvsmark 0}}
 	{mc "Diff marked commit -> this" command {diffvsmark 1}}
 	{mc "Revert this commit" command revert}
+
+	{mc "DirDiffTool this -> selected" command {externalDiffToolVsSel 0}}
+	{mc "DirDiffTool selected -> this" command {externalDiffToolVsSel 1}}
     }
     $rowctxmenu configure -tearoff 0
 
@@ -9254,6 +9257,20 @@ proc diffvssel {dirn} {
     doseldiff $oldid $newid
 }
 
+proc externalDiffToolVsSel {diffDirection} {
+    global rowmenuid selectedline
+
+    if {$selectedline eq {}} return
+    if {$diffDirection} {
+	set oldid [commitonrow $selectedline]
+	set newid $rowmenuid
+    } else {
+	set oldid $rowmenuid
+	set newid [commitonrow $selectedline]
+    }
+    [exec git difftool -d $oldid $newid]
+}
+
 proc diffvsmark {dirn} {
     global rowmenuid markedid
 
-- 
2.10.2

