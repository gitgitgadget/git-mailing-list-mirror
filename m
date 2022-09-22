Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4690EC6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 16:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiIVQ7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 12:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIVQ7m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 12:59:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8882A13D01
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 09:59:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s14so14540357wro.0
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=nux1mDXV6UAP3b2Yui30zaM88WL6NE924cP9WN28Wz4=;
        b=lVVjki8jI494G5RzOO1kXr0xqeRovmSQo8lT+Iqiy5wtssR/e0LduJ8kRi7TOiowdD
         +M4MPzkcdGZgxQRIE9jBfNgqJig3lI4WIgblnpTm9qa2zRqTkFuiucB2veN6IOgszOLE
         X+5PvcuEVukZQ/L0QpW0rcSrMi47XtOpVrXI6kFOfYxSsFh+MaOgC9VMUS8w/Zy+Lp8H
         xc8byqrqH6zUyIRjqJWGu2oDAogHAtS/mxL+eS8pBArKy1IdnEtbK0txRssLPLSfqqN2
         aSVfY0TTnTZTqipje11jRVIX9dVzFupig3DYgfcG8EsYm8DojlNXY+PgKaAXpf5w/p8i
         VQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nux1mDXV6UAP3b2Yui30zaM88WL6NE924cP9WN28Wz4=;
        b=xkT3gNDt5aZ+5Mmziu1NFTa2mm90+nzfps4QRI+hLlO+jTTm7j4SL9gKNr6ginqGSY
         uzCE4UlrQQPjVBZmuHygVRtqIbiV6zGewbJhXe2+5rK7CR7R92p75na0ZjY4U1KcA+hg
         jFmNBbtIomyq4NcWTh6Ru/LsdxSFLwokLGrLn9vUTQJftBKmyYKFJI2jFAy999/p9w9X
         /c2XvGGn+elzKaeb3PfbP1+frz3GCt2mmkupwoL1J/0kpAyWUZpczytI6bE2pRfE4pUF
         IVi43rsoplcrsFT5/wqSkfBTZ/S3BFMf+2jhra0a6+KcGck4wIDy4CZeJzVAhJOeFeYG
         CtUw==
X-Gm-Message-State: ACrzQf0xlfTcbiwh4T+XDjojsyPoEEh0J04m3k3y/kHC1YKoRwD+h6hI
        q310vQuKsfaZNvYdi58vmSdX9lso8RU=
X-Google-Smtp-Source: AMsMyM5v/IiDEQEfUNheul65Vz94dU7fYE1wNyJw4nPtowvCawEUiI97rT/FqaViVnDoobVhB1cZXg==
X-Received: by 2002:a5d:47c7:0:b0:229:6514:9ef7 with SMTP id o7-20020a5d47c7000000b0022965149ef7mr2627482wrc.663.1663865978584;
        Thu, 22 Sep 2022 09:59:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bw25-20020a0560001f9900b0022ac1be009esm5871221wrb.16.2022.09.22.09.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 09:59:37 -0700 (PDT)
Message-Id: <6426f9c3954866b3fd9259d1a58d2c41dc42e17f.1663865974.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1363.git.1663865974.gitgitgadget@gmail.com>
References: <pull.1363.git.1663865974.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Sep 2022 16:59:32 +0000
Subject: [PATCH 1/3] wincred: ignore unknown lines (do not die)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, mjcheetham@outlook.com,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

It is the expectation that credential helpers be liberal in what they
accept and conservative in what they return, to allow for future growth
and evolution of the protocol/interaction.

All of the other helpers (store, cache, osxkeychain, libsecret,
gnome-keyring) except `netrc` currently ignore any credential lines
that are not recognised, whereas the Windows helper (wincred) instead
dies.

Fix the discrepancy and ignore unknown lines in the wincred helper.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 contrib/credential/wincred/git-credential-wincred.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 5091048f9c6..ead6e267c78 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -278,8 +278,11 @@ static void read_credential(void)
 			wusername = utf8_to_utf16_dup(v);
 		} else if (!strcmp(buf, "password"))
 			password = utf8_to_utf16_dup(v);
-		else
-			die("unrecognized input");
+		/*
+		 * Ignore other lines; we don't know what they mean, but
+		 * this future-proofs us when later versions of git do
+		 * learn new lines, and the helpers are updated to match.
+		 */
 	}
 }
 
-- 
gitgitgadget

