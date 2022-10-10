Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D569BC433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 17:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJJRjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJJRjs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 13:39:48 -0400
X-Greylist: delayed 558 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Oct 2022 10:39:38 PDT
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC53EE5E
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 10:39:36 -0700 (PDT)
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
        by wilbur.contactoffice.com (Postfix) with ESMTP id 15436D34;
        Mon, 10 Oct 2022 19:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665423017;
        s=20220911-jt8y; d=wired4ever.net; i=sndanailov@wired4ever.net;
        h=From:Cc:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        l=1189; bh=i67Y4gcBd6pYcbW1u7Nj0blcQkLEFelXv4FnDdpvIfY=;
        b=fwWKzj7xwsbG1zTv8ltOghzpUxWYSWp7JzDpkMNK2PoOg6tPvGAnZ+9Ud5u0vkpP
        UE+c8G41kNpFjwjZdLqIoNYPdI4gSHyKthauXxAg0So3MDodUqbQ49OfpiN20CoYAx/
        9TEF23cJ51EqWriw557DtLuq4IDmFhTPQPkcAOqcnymsYZJsq6k4IdEQxSlVvk4xOvZ
        Zie6pLP84Tip5eg+tMmBaybIsXw4QgSbow/NEzwj/U41NXDD6fmL06vPxf0XNT7m9oO
        BJjqlGhbhWhR4QEGd19x+GonwU9+ml1IaXky1mxOUY/1u/K5jCvgcptCaP7d7eV6Ym4
        OJ3JFc/2ew==
Received: by smtp.mailfence.com with ESMTPSA ; Mon, 10 Oct 2022 19:30:13 +0200 (CEST)
From:   sndanailov@wired4ever.net
To:     git@vger.kernel.org
Cc:     Sotir Danailov <sndanailov@wired4ever.net>
Subject: [PATCH] docs: git-send-email: difference between ssl and tls smtp-encryption
Date:   Mon, 10 Oct 2022 19:28:59 +0200
Message-Id: <20221010172859.13832-1-sndanailov@wired4ever.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ContactOffice-Account: com:378009619
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sotir Danailov <sndanailov@wired4ever.net>

New explanation for the difference between these values.
It's hard to understand what they do based only on the names.

Signed-off-by: Sotir Danailov <sndanailov@wired4ever.net>
---
 Documentation/git-send-email.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3290043053..4db32f05f0 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -178,8 +178,11 @@ Sending
 	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
 
 --smtp-encryption=<encryption>::
-	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
-	value reverts to plain SMTP.  Default is the value of
+	Specify the encryption to use, either 'ssl' or 'tls'. Any other
+	value reverts to plain SMTP. The difference between the two for Git is
+	that 'ssl' uses implicit encryption and defaults to port 465, 'tls'
+	uses explicit encryption and defaults to port 25. Other ports might be
+	used by the SMTP server. Default is the value of
 	`sendemail.smtpEncryption`.
 
 --smtp-domain=<FQDN>::
-- 
2.37.3

