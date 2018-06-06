Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BED91F403
	for <e@80x24.org>; Wed,  6 Jun 2018 05:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932089AbeFFFC1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 01:02:27 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33041 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbeFFFCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 01:02:25 -0400
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so7062178lfy.0
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 22:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L332VTrnguNRWJBGhfGFO92Iw8pRUTSzYMMIxIRTGM0=;
        b=l6Afp+IX2g4tzRsn8y9PQHELUpQ5qITMb7XhZUv0jVKhEZZm3XMwk0V62yHMjlMEd5
         cJ9Vec0vLUgBzRqpHX+GSdB48IGmDpCejMx+goKu7NGZQmDfU7rJvO0rM7XU4nhtPheE
         zwBe40SdIchznOU2P5SNiJOYK8VKwA9AUpKQmlZUaENPFiBshNM8c9mlr2xYYVOBHEPn
         APBOYRGLuqw8acytT6VNhK0V4oPk4lOyNAWTx1QUAdjXlB57j1gxl8OMsXGPvpnQ4mYX
         PoQF2DnftzIvZrxA/G+bw1S8JjMX0QFMafSDV2mUvdVc7dbLfJwxWNIcYnjDPComlnNv
         iS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L332VTrnguNRWJBGhfGFO92Iw8pRUTSzYMMIxIRTGM0=;
        b=UiJsTUB2RaQ0fMcu97XRjSlBpNJhqoshXrMx7m1MnXMrzLsNuhSNZM+gJldY24JIBf
         lBYH+MAb7RDiYRPU0/wDnKQF2gf4Vc2hKESIEz8M9QHTcAIF5U/YagJDmfBO+QdZLsM/
         WLoy5PatSID7hGVoPwtO3DXDEv1dUetj9WPZSxWiMfjcUzbOuVN6b44JsexUQ8QoQy39
         Okpunbb6o4a3BXkW4nlr3PN3KA2uiO67IP3yHpfzgdGatTIhNPH0823igYpHB0Wk1xTp
         HM7WULzcmjkjH6P5CyKFkNKI6UiVp+1DqNWKntXGzmYlAWKWQsYAUMZuZPi6RIcaZpCZ
         AzJw==
X-Gm-Message-State: APt69E2cUIEhlzpVWIuFcUaqrHpKB3ViXwfaVyTXcQIcgl4/z6vM/kXt
        IpuvAskfCA29mP7ooj0pbJY=
X-Google-Smtp-Source: ADUXVKIBMev5+/dg1YCjjsm4wBv909uAl6io25NIE3bEOxWrlXMOMvIPjEY80y5/ONbqUjaYi0pJ9g==
X-Received: by 2002:a19:1714:: with SMTP id n20-v6mr790655lfi.54.1528261344467;
        Tue, 05 Jun 2018 22:02:24 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4125798lji.4.2018.06.05.22.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 22:02:23 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 1/5] unpack-trees: remove 'extern' on function declaration
Date:   Wed,  6 Jun 2018 07:02:03 +0200
Message-Id: <20180606050207.13556-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606050207.13556-1-pclouds@gmail.com>
References: <20180605154334.22613-1-pclouds@gmail.com>
 <20180606050207.13556-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..534358fcc5 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -82,8 +82,8 @@ struct unpack_trees_options {
 	struct exclude_list *el; /* for internal use */
 };
 
-extern int unpack_trees(unsigned n, struct tree_desc *t,
-		struct unpack_trees_options *options);
+int unpack_trees(unsigned n, struct tree_desc *t,
+		 struct unpack_trees_options *options);
 
 int verify_uptodate(const struct cache_entry *ce,
 		    struct unpack_trees_options *o);
-- 
2.18.0.rc0.333.g22e6ee6cdf

