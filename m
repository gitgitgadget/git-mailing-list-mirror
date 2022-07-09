Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B30C43334
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 16:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiGIQ4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 12:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGIQ4a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 12:56:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF9B18E02
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 09:56:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a5so2011192wrx.12
        for <git@vger.kernel.org>; Sat, 09 Jul 2022 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=xHUcjfe9pOQtsvZ0NqvE5UdJPWJD00dCV5ehh/oIPXk=;
        b=oGe0M40NTCg9mu8IentPNHz1VEXN6ZY6+xSP4HUzemKrGPv4CUDhgvb2zYmoTx62rf
         gB1eR5WcuvjgAdbV3huXeHPMck1jUl30N84ewgIVCDJvcIn8VzNa+K3QMOmexU/K+arc
         Eeb8AcPELIxB+YOl6EfXKL8XMcwttfuaFCOR/cdfS13+KoFC+GBQtAftLszrSYKGpwab
         ekckGPxyX1O+70W9JYh62wd1AtDEz58Ol2shkvka6SrsjXSOfNie04SuWDllIB6RJl0m
         FWcUumMYIP7fNoSVOuG/8fAkaQLBNqReWoAaRwsd6Osfo44E+vlhv323nuE7hshwgmV2
         tzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=xHUcjfe9pOQtsvZ0NqvE5UdJPWJD00dCV5ehh/oIPXk=;
        b=H9Dywde4AtF9G6OgOEhvko1APTUneSWOBNZRDuDd6IW2Nlr6DHmnCvwtPSUGPpJ5td
         ixPEd6eSv2EAWDpR7kRSC+6q330p8Mg9Je0IaBXkGRutkazcw5/B1XCzdm4LrSuBGp9k
         1pFXQWkYDT7zMezKJN93O52yP+O3Z8JGe4kDc5HRGzrIOYx5UpVDimwAThYPjyBi5sTh
         byGqbLHgOoKF3eyNetIyA2LyIW9+6mA6mBAYnuXyZv9PkIuVjd7b9t19Bk4l72nO4Qy8
         FkHqPOGsVZXZEJwATI3pdeou/bMbvtcC7Txe8M4Nh3rD9E+lT1qOjuIIouu0+ebYXYn+
         6Z3g==
X-Gm-Message-State: AJIora+BskyOP9nFFc0D6dJ1SDlUDIxgdAy+wjp0hyjcErjsSAiEUz1n
        4DKLw+PIm2y2UoyTvAU9DxAp4Zh68A8=
X-Google-Smtp-Source: AGRyM1uK4a+5adumqORLMcW2KqGDO6v0QCfoqqJt7+8Kop3PSAjnfCy3NTWqPTik8TqsdtysWtkaFg==
X-Received: by 2002:a5d:4f0b:0:b0:21d:705c:caf with SMTP id c11-20020a5d4f0b000000b0021d705c0cafmr9044762wru.55.1657385787740;
        Sat, 09 Jul 2022 09:56:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13-20020a056000054d00b0021d7d251c76sm1768893wrf.46.2022.07.09.09.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 09:56:27 -0700 (PDT)
Message-Id: <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Jul 2022 16:56:21 +0000
Subject: [PATCH 4/4] doc add: renormalize is not idempotent for CRCRLF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

Bug report
 https://lore.kernel.org/git/AM0PR02MB56357CC96B702244F3271014E8DC9@AM0PR02MB5635.eurprd02.prod.outlook.com/
noted that a file containing /r/r/n needed renormalising twice.

This is by design. Lone CR characters, not paired with an LF, are left
unchanged. Note the lack of idempotentness of the "clean" filter in the
documentation.

Renormalize was introduced at 9472935d81e (add: introduce "--renormalize",
Torsten Bögershausen, 2017-11-16)

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/git-add.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 11eb70f16c7..c4a5ad11a6b 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -188,7 +188,8 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	forcibly add them again to the index.  This is useful after
 	changing `core.autocrlf` configuration or the `text` attribute
 	in order to correct files added with wrong CRLF/LF line endings.
-	This option implies `-u`.
+	This option implies `-u`. Lone CR characters are untouched, so
+	cleaning not idempotent. A CRCRLF sequence cleans to CRLF.
 
 --chmod=(+|-)x::
 	Override the executable bit of the added files.  The executable
-- 
gitgitgadget
