Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDA4E1F45F
	for <e@80x24.org>; Tue,  7 May 2019 21:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfEGVvb (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 17:51:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43159 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfEGVvb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 17:51:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id w33so17794251edb.10
        for <git@vger.kernel.org>; Tue, 07 May 2019 14:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=rwuQuVEBdnkyqJFFFBE35Q13dkcIcijb0BP+b1SvMqw=;
        b=A7bmFg+DW6PH1osIQo5SKM34BxWMmpZxUn3u6OOzsT5rGGO8vDtH59Ivi4bCaoqgvt
         vZSJKdmbylnpbppfQiL9qhKHKEInbWY5EiDr/1vScn42EWFZ0zDA/jl08zD6JrlmwfDU
         BAkalZEFB5jINStSWUzNJikMIwGkA9qp0Nv/SwsJWx8tyN3k1dQctK0smzVz16d5gQGW
         trkbUODSEoOuNWY+tUNgNi1RYWZuBYONd2U5S50fW6dL5HxUZD/s1QkEyWZ+wbnEx90k
         9/tuyywYFzmAktTZ3p5ZnT5WsyzcnzEebGugNQmR5D4Avkm7aoHa5y43CIVBrT/b+IJe
         mNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rwuQuVEBdnkyqJFFFBE35Q13dkcIcijb0BP+b1SvMqw=;
        b=MG9W/R6Mul4u1e9rEueSQfLpPXqPn/5uMc+2vtPB2RZI4our7MoJ2bjgX3ayE1FsnZ
         jk7QQJucltscG7KSJXgg8qvnFWO5h5LCVRPSbhtoNEWtAe08kH2yMNCm0xGPQn/qohyd
         AkZrKGdorYCUyjV7K+LoZI/rCMKO+aYDptfZ74XjZ++X4L49nHaol73MY0UOOodVCbVe
         yQ7Fg/KleOUcm2bimReXEuBO9nC2ancdAE4XTjbw9tRuUfUq/SiIvzyimvHGcxAmxZiI
         TKCXdnJjBBreOIDSyGAqIHSoQEfryGOBJBr4nt6bmMAcL/uEH/zvD72eTTF8BqnnIGoL
         kS3w==
X-Gm-Message-State: APjAAAV2OOMK701F6uaquXxeHOf5/3KorDmCO9/D/y2NtZlZMtFbVug4
        s9PfgjJjWCVnylMOBTwmAa3vBXcX
X-Google-Smtp-Source: APXvYqxfo+S2htM97d3djY1sLMLSW8aCvV/uVq3mF6ruespvWmd7Lo3hf4W29UGA5Dw8wRIp//FYiA==
X-Received: by 2002:a50:9203:: with SMTP id i3mr17861414eda.172.1557265889956;
        Tue, 07 May 2019 14:51:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1sm2412202ejf.40.2019.05.07.14.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 14:51:29 -0700 (PDT)
Date:   Tue, 07 May 2019 14:51:29 -0700 (PDT)
X-Google-Original-Date: Tue, 07 May 2019 21:51:27 GMT
Message-Id: <pull.185.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Proactively fix a test issue with v3.x of the MSYS2 runtime
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I saw this in one of my builds that followed the bleeding edge of Git for
Windows' SDK: git.exe has a different idea of the test script's PID than the
test script itself. Yet another of the quirks Git for Windows has to deal
with...

Johannes Schindelin (1):
  t6500(mingw): use the Windows PID of the shell

 t/t6500-gc.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-185%2Fdscho%2Ft6500-and-msys2-runtime-v3.x-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-185/dscho/t6500-and-msys2-runtime-v3.x-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/185
-- 
gitgitgadget
