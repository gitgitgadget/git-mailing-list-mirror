Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE2AC433FE
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 21:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343756AbiCTV4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 17:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343754AbiCTV4W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 17:56:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D0C11151
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:54:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t11so18469302wrm.5
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=QQcDvCDYwvzH0EntRq1TIK5AC8tttVytzx41QHC/LF0=;
        b=NRm0BYiRaARvrNcHX0io+JDShXEVElzA8Ii9xsNUPA3FR2HhdBVGceJUbJj4mUHwqP
         BxEj4hBif8ApRpI9S92sjx0kt5yxS28Zyt1BQQ3o8uW1iW/vHsf544XJNA0JBupFI7X8
         EVWE2W/87WVRUzkJPLPEtyS87PdYjRq1zo1OYPPFJR+/bWf/L2V9vkIwcAkokdZOHmF2
         w3bS6b7pLRFL4ggP7dzIlPzrxnXMDGYTS4zM51ZOPfkVrp1AR9quGmmlfLu0NJuh6qk4
         IeEMfZL1MFGqhJoOD+w04ZUSEJMpxNpk6Iybl26M9kHcuIgtM2yAhgKHrwPUTZE6QX0y
         fTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=QQcDvCDYwvzH0EntRq1TIK5AC8tttVytzx41QHC/LF0=;
        b=ZErI31wtriDXMlXew2WwVmfE1cdFLt4W314CS2nSSJ6Xk9RXzGARocilh6FM+vGeiP
         0nlCeNBSlJWifZG/VVv2YPxe9Y99byOMC3GMUu476Sf2ypUEmwcgYqQCUlkn0eZsmAeb
         ufcD1vM1wgQSNfOKrYcLbbCq14jwyFyyIz76iMzc/+h8IAofgGb1wBqlAV8eTW9GOBqj
         p+ZJw+1/FOPC2cS2BITliH7s4+12nMNRIDzntGJPBF+RnMhTmGFwPm/kCPQAwQyUyX7L
         WcDGDMRfqCdJFKKdJmdV36C6B5UaAJgVr0g8yrcUF50qmvN3/TtBQiLXSOIPO5ioAX7g
         yoLA==
X-Gm-Message-State: AOAM530Yd9iG/Px0+eCOWBWnQbUf4FuBluCKclkyk2ek0RIx+Z9ZIVlo
        kv3rhSsBKJ08/yiNCgk9U+REVomCjpM=
X-Google-Smtp-Source: ABdhPJzTavs3TtdGTC8SBEGdyN7AjUkU051UEVV5mV09BHTXdDhypTXxZ7d7z2i4vkv7OU0ztvYRxQ==
X-Received: by 2002:adf:f946:0:b0:1f0:62c3:ea2e with SMTP id q6-20020adff946000000b001f062c3ea2emr15489979wrr.348.1647813297417;
        Sun, 20 Mar 2022 14:54:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v124-20020a1cac82000000b0037c3d08e0e7sm15256951wme.29.2022.03.20.14.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 14:54:56 -0700 (PDT)
Message-Id: <bf23e1ebe6543d8831e1bdb6a465fa292cae3955.1647813292.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 21:54:48 +0000
Subject: [PATCH 4/7] i18n: factorize "Server does not support foo" messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 09b1cf6173a..fcbc5cc5944 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1106,16 +1106,16 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		print_verbose(args, _("Server supports %s"), "deepen-since");
 		deepen_since_ok = 1;
 	} else if (args->deepen_since)
-		die(_("Server does not support --shallow-since"));
+		die(_("Server does not support %s"), "--shallow-since");
 	if (server_supports("deepen-not")) {
 		print_verbose(args, _("Server supports %s"), "deepen-not");
 		deepen_not_ok = 1;
 	} else if (args->deepen_not)
-		die(_("Server does not support --shallow-exclude"));
+		die(_("Server does not support %s"), "--shallow-exclude");
 	if (server_supports("deepen-relative"))
 		print_verbose(args, _("Server supports %s"), "deepen-relative");
 	else if (args->deepen_relative)
-		die(_("Server does not support --deepen"));
+		die(_("Server does not support %s"), "--deepen");
 	if (!server_supports_hash(the_hash_algo->name, NULL))
 		die(_("Server does not support this repository's object format"));
 
-- 
gitgitgadget

