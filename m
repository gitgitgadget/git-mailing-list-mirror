Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C26B61F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 14:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbdKMOPR (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 09:15:17 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55265 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbdKMOPP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 09:15:15 -0500
Received: by mail-wm0-f68.google.com with SMTP id r68so15548962wmr.3
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 06:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=34xpckVhGalEqM1q4uSLBNCD3V9GqfF1s6kU8NgscCo=;
        b=D+ow+G0jiiD+TgDoDaL3LhDiXW/cleH9AtdUH/835xvz3u1bFIRuYq9on5OOmb+jwn
         kcVZdatuXvYD3v+S6+cOdJN4auPvKYAxFS1glmlXRUhOvdEBjTnVsXfeuYIEOxyuFiFQ
         m5kCeD1zyNe3Q9fvkQByqeXeTkiPidMrf8whA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=34xpckVhGalEqM1q4uSLBNCD3V9GqfF1s6kU8NgscCo=;
        b=KOSmKLkKdMB5UmlapYvcO8i28LFLQ2gvpb0Prxdyf+/cgsEbHRKpDBsBqp1PS5kL2y
         tzUJnCAz/DzFLfGnYTAFSUp3frtvuSeF+0Aids5WQLmS7un5Y1xohJLYcngQRicuzS8f
         7zkAw5plUvHLBjn7Xrt5FH3+xnDqXaKdKDVogbQ+QZjpsX7sEhEhzn4TYoBaSTQJKg6R
         IPA5+kVccQxFiegYHHQm0gkO8H3U3uiKFDjja00cmWCWG4Jgw/mwpq7T5ISuB64j3Gt/
         5yq4akZ0JQ5aYCoPB6hzgYJ2FCxWslxkLaR862LhHPkOLft6hnpIZ27ajKYLZtiUfGRf
         xFIA==
X-Gm-Message-State: AJaThX7P9xWKAimbpQ2iEYtDcB+Aif7Op1Q9a4jGzM+6n9ZSYG6EHae4
        Jzj7kXt0Xqmgnq9YkQAkRCZW5w==
X-Google-Smtp-Source: AGs4zMZ1l0UjGMiXLGvvaSm5Xji8pq+mpqX3Z+0OTdWwfpYlEPwQxeePGXPyjUGt3T8+QMD7pfu36w==
X-Received: by 10.28.142.85 with SMTP id q82mr6212287wmd.155.1510582513986;
        Mon, 13 Nov 2017 06:15:13 -0800 (PST)
Received: from wildmoose.dk ([2a01:488:66:1000:57e6:57d1:0:1])
        by smtp.gmail.com with ESMTPSA id k30sm18855993wrf.52.2017.11.13.06.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2017 06:15:13 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 2/2] completion: add git config sendemail.tocmd
Date:   Mon, 13 Nov 2017 15:14:43 +0100
Message-Id: <20171113141443.19141-2-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171113141443.19141-1-rv@rasmusvillemoes.dk>
References: <20171113141443.19141-1-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fdd984d34..10607cdf2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2642,6 +2642,7 @@ _git_config ()
 		sendemail.suppressfrom
 		sendemail.thread
 		sendemail.to
+		sendemail.tocmd
 		sendemail.validate
 		sendemail.smtpbatchsize
 		sendemail.smtprelogindelay
-- 
2.11.0

