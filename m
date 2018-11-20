Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878851F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 09:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeKTUMr (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 15:12:47 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:39117 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTUMr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 15:12:47 -0500
Received: by mail-pg1-f180.google.com with SMTP id w6so664769pgl.6
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 01:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=RX9/+MKKetTbaiaL9BFwGAProBm0FGTH+4xTauEf128=;
        b=us+ZzgsDWwujjXA/XpPz5EOvIPzIqx93uq/1Yv6zTdVvtmEy47akW2pz6lpyJGy2qj
         N1Ed0ZVDZR3B31t6kwv4xzF2lYjmzhpCyZMzlDDBsjfhMeuw0cdrFzzUa3NDVApDV6gg
         nZIo+tsH/Uu2g9gABulZl/iOTfCQfpfS4ATtP7ZhLAgTlDMG3yWmR1bajDiQeSCtLnoh
         blLp/FxJvAzf6K2hLkBTEULoJ7z5nW7J0fF92hfWU4iPFZscDf+hBsDtHtFaLV1oS5QY
         hoqfcbH7EPUu2pCbvOz5QWKrPLE0OkGrUEuRWjKSvicjnYuXBeiFZixihcyNwaInQIr7
         kB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RX9/+MKKetTbaiaL9BFwGAProBm0FGTH+4xTauEf128=;
        b=mwoBA8dDVgUoBniX2bCuuna5oMDX76JWi9RqSOnUIP1KX4EiLMiLAdY7IaXxbe0AyW
         VG2Mir03zV7vBkmlZufpHMV8KQAiPnETqsQTztkgcw5vKGsE0SPm0Li5yHcLDzybo0rK
         YRw/gF+qS0g00Pmuxit9un/sDyOz9Q/qYHTTSnykW7iXZMj5+LgMHuBHEPF8U9qa13Dk
         nGUlHP5y5VFUlWs/7AB/OLUBLPrwohVRJ00qs3Le0fo/ETRTX+9/NhFRKmIRTX8cR48q
         lNcgNpR7fQI7fPTP9nit9bm6emSEygo+uMuD+97qn2TSWZiHGdoyYyAsBqxp+kcpKRL8
         sebg==
X-Gm-Message-State: AGRZ1gJxt1YkjqhQX5m7dzhEbTkYqFVPUf79/+szwBR0qGbEgh+mpZDz
        xkRT10bR8qrEG91CdJh+86LBnR+E
X-Google-Smtp-Source: AJdET5eOUWmPtWTelpt8I76ASYcxKt/fwPB2ydVdYIggt13NozVKK8otSb2TibuW5WEJ4H4nyFXAxg==
X-Received: by 2002:a62:d148:: with SMTP id t8mr1508037pfl.52.1542707073143;
        Tue, 20 Nov 2018 01:44:33 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id l6-v6sm41336645pff.147.2018.11.20.01.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 01:44:32 -0800 (PST)
Date:   Tue, 20 Nov 2018 01:44:32 -0800 (PST)
X-Google-Original-Date: Tue, 20 Nov 2018 09:44:29 GMT
Message-Id: <pull.85.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] rebase: warn about the correct tree's OID
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

A quick fix for a recent topic. Not overly critical, but I would deem this
v2.20.0-rc1 material.

Johannes Schindelin (1):
  rebase: warn about the correct tree's OID

 builtin/rebase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: bb75be6cb916297f271c846f2f9caa3daaaec718
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-85%2Fdscho%2Freset_head-typo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-85/dscho/reset_head-typo-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/85
-- 
gitgitgadget
