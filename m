Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 662211F404
	for <e@80x24.org>; Mon, 11 Dec 2017 21:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdLKVKF (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 16:10:05 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36337 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdLKVKE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 16:10:04 -0500
Received: by mail-wr0-f195.google.com with SMTP id v105so19018391wrc.3
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 13:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=UTWzGLLgZjKr2GT2Khd6gAhY6Hl9iXNY6rsT6dxf0tI=;
        b=rc2Gwn78yGL2+/yuyDtQwpQyDcAUZrhn3sArcRJj6RYWexVmt87X5xD6ot7JXcRBEy
         emJfKt7C/CEFSAU8eTfi9GNovdW30SEOJySlfdIFWz9MzxD9R1LCXTll93NNg5erXz+N
         vUq+bnA0/pVWfOf777rCAsvaB4RLUH6s3DvSbXRq4qeDpoYPo3pWNEFmk0rfPwAmFkKD
         BgO8r/XE2MV5NGoVAEDOJLpqN0Xa6Ks+tC14WF9jSoasj51rrvplI6zLgjsEAh0huSjC
         rPmYqy17NKgCBBNmnDmUTARpGNKa3DtNI4Neps1f8NKN4IKZxROL6fiKBnIrLiWqYV2O
         D6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=UTWzGLLgZjKr2GT2Khd6gAhY6Hl9iXNY6rsT6dxf0tI=;
        b=VLlBtvwj1OqbCfARznj+77759BRy3+z1zliR2kc5coRQv0Q17OgYKjs0G2Mj+0u67S
         JFsQqTo+XL1v8n65AAWpLjCzx1x5l0uQcNhxJjm4c3J3TgAHG67YgFeicWxk+x83Jx85
         G7QDPtBvFERxBrzP45dX9Ik0JRZo8IwCcAv5SQQ5IxTzUmrk4tUPcxoR6xP4S0FfabQS
         QZ844vVhjvJYO/jJKd0QwnIDrFXOtZcspJ1uhx2Oc5Zc+Of9uI2qkh7l2ISbEA+wQowJ
         t4nwwdbCMpOK8Jz6Zoc0j3XC5cs52IuQZCEX+9C0t853PQt5tIxHiH+u6lTqDKdXET83
         uzgQ==
X-Gm-Message-State: AKGB3mKQyMtqbxrX3atyyFsYbSzLIMw2CPMgyDLr9Jfu32mWhrQSRk/5
        yPtzHjsYY6y0LG54kS24aFA=
X-Google-Smtp-Source: ACJfBotOrD8qhhHtlwGnzSJhh/9NugCtRuUe8NNEJn1R2bMu/Y31nOwdmDa0GX5MJ78vvdZP+gOEZA==
X-Received: by 10.223.170.214 with SMTP id i22mr1606766wrc.110.1513026603027;
        Mon, 11 Dec 2017 13:10:03 -0800 (PST)
Received: from localhost.localdomain (x590d9245.dyn.telefonica.de. [89.13.146.69])
        by smtp.gmail.com with ESMTPSA id 59sm16580757wrs.41.2017.12.11.13.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 13:10:02 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
Date:   Mon, 11 Dec 2017 22:09:48 +0100
Message-Id: <20171211210948.6867-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.421.gc469ca1de
In-Reply-To: <20171210212202.28231-4-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Make sure that split index doesn't get broken, by running it on travis
> CI.
> 
> Run the test suite with split index enabled in linux 64 bit mode, and
> leave split index turned off in 32-bit mode.

This doesn't accurately describe what the patch does.
Travis CI runs three 64 bit Linux build jobs for us: one compiled with
Clang, one with GCC, and one with GETTEXT_POISON enabled.  This patch
enables split index only in the latter build job, but not in the Clang
and GCC build jobs.

>  The laternative would be
> to add an extra target in the matrix, enabling split index mode, but
> that would only use additional cycles on travis and would not bring that
> much benefit, as we are still running the test suite in the "vanilla"
> version in the 32-bit mode.
> 
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 281f101f31..c83c766dee 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -39,7 +39,7 @@ env:
>  
>  matrix:
>    include:
> -    - env: GETTEXT_POISON=YesPlease
> +    - env: GETTEXT_POISON=YesPlease GIT_TEST_SPLIT_INDEX=YesPlease
>        os: linux
>        compiler:
>        addons:
> -- 
> 2.15.1.504.g5279b80103
