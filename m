Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC795ECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 19:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiIMT0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 15:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIMT0D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 15:26:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8BE7287F
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n8so2610009wmr.5
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=+f6YTqMKgo/XauQ5HVwJ9Cjt9MJOXkiqZPvZQkkmKdM=;
        b=mspgyTb+hcDL9njD9Uk0Hvon3R7vpTiJi6+fRcUtZBDtZko3AibySE8OM8vmFaheJw
         4tW+b6XVPh0+sF4/8JQohc3QmnPkYdd7wn0fJKihwa7Y00O3DhVAvjiBMtNXnmz75Unx
         4o+6ssBJzjjDazmxxsQFN8qU0gQ5upmSnMPNcb11hJwwOPJeuyNsdyjtFiykFL6cRtPg
         xdXMsJ4IE3O01fc2Netzf5C4pu55gMKdHSU+uEJru/En5mKI+oS6fd1GeFDnmeJwleXY
         BumGZGzeCFbMEiRftIIofIpt8y1+i2WH4KZ5fVl2Pt6ra0fD3Ap3ib+rWrtH7SYyo1Ja
         6wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+f6YTqMKgo/XauQ5HVwJ9Cjt9MJOXkiqZPvZQkkmKdM=;
        b=d6Pfcdkjrn6El3iZdN4lfW8M+WHFuQX6TmQsPhudyAkJw2en1pmgxwfTB6o3cRxzDS
         2tomJpj08Fw9V8XaHQ5OFlGWHfClQ9n8RNPLwiAHs31nHe61nDHvrZGfYTEfRdAnZju2
         /3x1W8BUl2woWebfmgjx2HuSdq5pLDJGU6mVOk6ZAJewCW3t9l6r0a7KbCZHVY+W0kIO
         U2pch6igN2R9Hwgne7d+A45d6RjUYqce+8M2WIJptjBenq76742Iah3v0HBBMR5CiY7c
         IuSv0D2fwUZBFhR3SUMbwFV/L48fRdD2OP6mdKjNcOKUlYRD3RyIWwwDSJ7vkdXmM9vY
         TdpA==
X-Gm-Message-State: ACgBeo2SKl4+yZxSyX+enPXVK9HxS/NwDgSZLEw291a/V3iYrtfjoOh0
        0YwFZiEP4wXFsvG+Epud8Ugt7q83POA=
X-Google-Smtp-Source: AA6agR7JuMNaHyN26xZtCiYNzs+RGqfc/a5fzRjjA+c2lrSdS7oi96N2Ka2g5O6HfEqf3f3C1oyVFw==
X-Received: by 2002:a05:600c:4f10:b0:3a5:f8c8:a5b5 with SMTP id l16-20020a05600c4f1000b003a5f8c8a5b5mr632365wmq.34.1663097160811;
        Tue, 13 Sep 2022 12:26:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y25-20020a05600c365900b003b483000583sm8977817wmq.48.2022.09.13.12.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:26:00 -0700 (PDT)
Message-Id: <2ece562a5952b5752de5040b17ec36076164c72f.1663097156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 19:25:51 +0000
Subject: [PATCH 3/8] osxkeychain: clarify that we ignore unknown lines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Like in all the other credential helpers, the osxkeychain helper
ignores unknown credential lines.

Add a comment (a la the other helpers) to make it clear and explicit
that this is the desired behaviour.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index bf77748d602..e29cc28779d 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -159,6 +159,11 @@ static void read_credential(void)
 			username = xstrdup(v);
 		else if (!strcmp(buf, "password"))
 			password = xstrdup(v);
+		/*
+		 * Ignore other lines; we don't know what they mean, but
+		 * this future-proofs us when later versions of git do
+		 * learn new lines, and the helpers are updated to match.
+		 */
 	}
 }
 
-- 
gitgitgadget

