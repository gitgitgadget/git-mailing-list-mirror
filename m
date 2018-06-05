Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27E181F403
	for <e@80x24.org>; Tue,  5 Jun 2018 15:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeFEPpQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 11:45:16 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:39236 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbeFEPpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 11:45:16 -0400
Received: by mail-wm0-f53.google.com with SMTP id p11-v6so6020690wmc.4
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E4SCIuycH00SvSBn99r/mLJPPAcY9vOmtw0UA9+GH4U=;
        b=qKPbmbNLfDXmi9kL+pZA4XIkVm6F991vBHPDMpdC+AB+r2RJozorcJyPvHcWSlFeXx
         FQjmndVVLpTcXgE9a3N/NfVAQzszHdk4jLMf+w2IVcqGLGcmNcbdD6ymHrka4DAe1udD
         gfSftIeBWyR5dZM3r/BZ7bl9dpPQGbsVRPi1Us88j9etGY7aH7TWaNklBGuM3KQiOGxp
         Tkw4kH4W8qB4/ors8chHULr39SdR1SdF7pFWqQjQn6Z53WbwVMDGF59KMqdgjWWY8dtG
         HKswG6jEFwDJRTrBkicggOHxzulbLlvY7rvfHetnxBMbYsFhu5ftzykVtnKbma36b++l
         jwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4SCIuycH00SvSBn99r/mLJPPAcY9vOmtw0UA9+GH4U=;
        b=VnmmM0U2ihG9M9YdFjGvSU056X3OyOiALxZtUfPzEQhI4bTq4m1fp7Fuh757bUAbTV
         aBwcv4AYiM873B0Lpr3ELdXpE9t5sPyg6c/K2LM4NzwfkkW+U7M55BVoms0mxjYnxqW7
         VJhLyrvT2owrPaTEV/71WmRvjSSfmMQrpJIKvBld3/FVHcKUWX4KmZ47v6QcgZiNQLgL
         XvWQhljTqbr3QjoGIFMys7G4Pi1msZsuiUJniZSZZGUbK1luZE6eWoqSlUfOvv+8XgZG
         uIfZm5KrgV69GfDaFZQ2pvH2mog5opu0BXzOcQj9L70U5MOAlk019K+WC1eILRjkQDNo
         N3MA==
X-Gm-Message-State: ALKqPwe3KTgzn9vsaKdpMmCfDy3sEex5QeQi2caEDrdd12G1g4kcKmlY
        1pyYDNP3c+TJFX/KJqSPONFWsA==
X-Google-Smtp-Source: ADUXVKImJWM993eXT/4ZOgRopn5OG3JeDFivw+W6y8xSns+SC1UHaEPjTDq2KxwMLkf+UdQ7vIBUCw==
X-Received: by 2002:a1c:3fc2:: with SMTP id m185-v6mr10788467wma.37.1528213514990;
        Tue, 05 Jun 2018 08:45:14 -0700 (PDT)
Received: from localhost.localdomain (x590daf56.dyn.telefonica.de. [89.13.175.86])
        by smtp.gmail.com with ESMTPSA id r11-v6sm9195638wrn.34.2018.06.05.08.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jun 2018 08:45:14 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 1/8] checkout tests: index should be clean after dwim checkout
Date:   Tue,  5 Jun 2018 17:45:01 +0200
Message-Id: <20180605154501.13502-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <20180605144049.26488-2-avarab@gmail.com>
References: <20180605144049.26488-1-avarab@gmail.com> <20180602115042.18167-1-avarab@gmail.com> <20180605144049.26488-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
> index 3e5ac81bd2..ed32828105 100755
> --- a/t/t2024-checkout-dwim.sh
> +++ b/t/t2024-checkout-dwim.sh
> @@ -23,6 +23,12 @@ test_branch_upstream () {
>  	test_cmp expect.upstream actual.upstream
>  }
>  
> +status_uno_is_clean() {
> +	>status.expect &&
> +	git status -uno --porcelain >status.actual &&
> +	test_cmp status.expect status.actual

This function could be written a tad simpler as:

  git status -uno --porcelain >status.actual &&
  test_must_be_empty status.actual

