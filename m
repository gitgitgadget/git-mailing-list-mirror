Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FE9C4167B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 21:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiL0VI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 16:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiL0VIO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 16:08:14 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33908DF4E
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 13:02:01 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so34259845ejb.13
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 13:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zMuyDhTRGg59o+D5Q2tAWE37Cwth3EkkJsROZqTOuC4=;
        b=gWXDkzDkMSt92Zk1cl8zt+v+7p0HUoNY2UjwCloWcpUSEsM/L+QOqRulkOJQBvB/Ou
         MmOndYH+EoITnQQxE3nEl0BI3+ihcRByaS3iK+6lpIxCseUEcD+oK8SgRsFcBxN5K+qV
         m+dUqNkttWIlvEDwRf6/mxN16r9v3Xf/MxyD8cl/4EawW9XE+c14taxJRGM6t/Z/8FAZ
         ow6pe9Ma6yKAZGooJEKI92OjDJ6AkNwFdWYdXNzCFyqwDbV4zEK9nMGCDNFFQCp32Sjs
         0q45GXBVVuDAKO7Y9xxpnaTnl+RZPRj5QREpG5AskNKoJdsztrcXDxdX6LcALUoqbksV
         GIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMuyDhTRGg59o+D5Q2tAWE37Cwth3EkkJsROZqTOuC4=;
        b=5aWnxcj03PIou57adqkEr/XOhH8Ej6mosy8++OWLhoR2/hJZZaMcL5Q2J4z5IpYLen
         CPv6/ypsvpHRXGWn6my7rxKzendu9o6Ozoyq3/EbUIOY39Oemewy17OB/WgvrlSDt/AB
         e/e5PAVSSOL0jdRo9gRzMblMuISPptRiGpBqTWXrKNalnnEkYkew3hf9bOIfs5j02mrF
         4aL6MVVpJjW5AckoCHGfIli0wGtte/b5zU4y/r3F9deVQ7EXwvkltz/JfJsV+nHkv+xt
         q1pYq/usdBQoDMUz7p3p0LNG2Ma5OypleMzhBx0s8RBNbBFpwpr7Q51/3fEXbElvqUJE
         +jcg==
X-Gm-Message-State: AFqh2kq/Z7jIW0px2Lmkw13eD3d37lF163PB5hkCC//c/qBDZalL7PLN
        THnXrrSxL0cpkR9zeO8kgJsg7+JtDc9AiA==
X-Google-Smtp-Source: AMrXdXsEerAgRjl+R/wyKTqAq+DJ7ZMKAlzkkeEhs5bnW4DeYqMl7mtlqQF4mcD2oSdzr0JxAyntJg==
X-Received: by 2002:a17:907:a0d6:b0:7d3:c516:6ef4 with SMTP id hw22-20020a170907a0d600b007d3c5166ef4mr27822930ejc.20.1672174919466;
        Tue, 27 Dec 2022 13:01:59 -0800 (PST)
Received: from titov.fritz.box ([45.88.97.246])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906319000b0084c2065b388sm4443060ejy.128.2022.12.27.13.01.58
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 13:01:58 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] gitattributes.txt: fix typo in "comma separated"
Date:   Tue, 27 Dec 2022 22:01:56 +0100
Message-Id: <20221227210156.1532168-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 4b36d51beb..c19e64ea0e 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1155,7 +1155,7 @@ Unspecified::
 
 String::
 
-	Specify a comma separate list of common whitespace problems to
+	Specify a comma separated list of common whitespace problems to
 	notice in the same format as the `core.whitespace` configuration
 	variable.
 
-- 
2.38.1

