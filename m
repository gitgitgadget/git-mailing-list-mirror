Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E7720C31
	for <e@80x24.org>; Thu,  7 Dec 2017 09:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbdLGJAA (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 04:00:00 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39868 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdLGI77 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 03:59:59 -0500
Received: by mail-wr0-f195.google.com with SMTP id a41so6621502wra.6
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 00:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5I7vmHK9uPX8QYPTUWUa9Y9ZXtQpIIZPN2zCQdSDT0=;
        b=dZssZlWkjr2VWfeuaDze+smK1qQVsfv+1gQNrD5MOlHD7vKUBXSYZgXBmlUW4sWlPi
         ePsYhR2nTLZS8OepQLo7HBUeK0zLx/CRChf60Vk/19Smf5220Fxl2vA4mQ1Bk9r8ciGo
         +s35xatRfNdHW/5YBc9PVw2w7TF7qbB7fCSHoKly2F5cLt/ioyhAVhY350Ns8B1FrrbT
         +Z6l169Rt2T8vzdVU5xYZ0O/7GlkHNTvvwOb2XjtD8koH5y07TUUVj2WePE8SOpTGD08
         Pb5c6dqqtxFnPhQYptNp3Cnl3KxUhEc5xsRoOMymVh3QnFiSfw5iPKVZSTiDJnwC023i
         9OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T5I7vmHK9uPX8QYPTUWUa9Y9ZXtQpIIZPN2zCQdSDT0=;
        b=hWuzHsjW2Y4ZVTaK2PnatlyjYUSHkJxdqe8C5+2df1WYqm4wcR5l4Mjl8qTE/IrzjV
         4RHEJyZXZzujMOPBkWBSRj6br+EWhOAFrjBfLokn+vh1AtMbCqfk8lhmK6J8fIXtVP9W
         eBYUOmK/3+BQ2IoLvKsqu+38B8CxoV7yOaEblkVYxMvafiRn91M8y9PksIXS11B9O8cK
         jmrftG7BvJtbSPNVX2NJjsGQbVxBy79f7Q9XgLdSNKDhE8b+atcZnZmEZvVOTod44Ozx
         l3S22ZTPHvnp4/drXw7URkg0CPffVQThTKqnEk3peXQEKBEK000cp3QT/51AbWRqCYDL
         vMqw==
X-Gm-Message-State: AJaThX4myP4Dn2vOAbBYtdxIYahEX0Vz5iNgyoY4OFSGHZRd1tkqT0ZW
        BPahOuUIayeyjOEWyh7ky0W2QQ==
X-Google-Smtp-Source: AGs4zMZeikfHalnGuX2Q4SHvMQefxNHdEeU/sYDTvWirdC3cMFBUVhcd+DRll1Wh/4VQnRVOLaGKvQ==
X-Received: by 10.223.134.5 with SMTP id 5mr19376371wrv.186.1512637198823;
        Thu, 07 Dec 2017 00:59:58 -0800 (PST)
Received: from localhost.localdomain (x4db28667.dyn.telefonica.de. [77.178.134.103])
        by smtp.gmail.com with ESMTPSA id g68sm4993737wmc.22.2017.12.07.00.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 00:59:58 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] setup.c: fix comment about order of .git directory discovery
Date:   Thu,  7 Dec 2017 09:59:49 +0100
Message-Id: <20171207085949.19519-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.338.g53352fef7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since gitfiles were introduced in b44ebb19e (Add platform-independent
.git "symlink", 2008-02-20) the order of checks during .git directory
discovery is: gitfile, gitdir, bare repo.  However, that commit did
only partially update the in-code comment describing this order,
missing the last line which still puts gitdir before gitfile.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 03f51e056..b168d25db 100644
--- a/setup.c
+++ b/setup.c
@@ -921,7 +921,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 	 * - ../.git
 	 * - ../.git/
 	 * - ../ (bare)
-	 * - ../../.git/
+	 * - ../../.git
 	 *   etc.
 	 */
 	one_filesystem = !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0);
-- 
2.15.1.338.g53352fef7

