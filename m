Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A8151F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 18:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394234AbfJPSaj (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 14:30:39 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:54421 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390895AbfJPSai (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 14:30:38 -0400
Received: by mail-wm1-f54.google.com with SMTP id p7so3977091wmp.4
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 11:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=9t91HsawxKjeR979gnFNO1BtEVq0GnkrOXo5fdMUo84=;
        b=JNSJl/K81dvtb8OtmE/X1HAHIImKh/aRWskTihQCLxwfPpglHne7fBu11MI8on11bW
         B77ZZWxxWQXtGu/9hrhTmMOoelhnr/zsNUN7h6rcOtSh57jU45Z3fkbnAAuVomrN+LWV
         aYW6gukTPTtw1v0sjzgYy2WifO4NSCGKMG50+XaHjU4HeIrxf2Nt3bezEJtL/0ONB+sV
         MkEpjdfYQnzoaf4pB+St1ddI24inb9tHDUWcr30gONXvl+pQYMZykvsMzjJAIU3Jz2ZN
         VPCpFEbEYbNFZklzfM/if1v7XUI+PfJkgS4rstURh/tZ28jlC6qyOJgK78pfZIrsTiqv
         gxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9t91HsawxKjeR979gnFNO1BtEVq0GnkrOXo5fdMUo84=;
        b=MsgQzJ0Y2PaKSH4/I9lb8/FLPk22uIbXO1j9/63XUFlYDAUKAkcvQUTXoWQuM9NOCY
         KLajr1Z9+5ng6fPP4Jnwp+uqjbr2Pkho3E3zClQtnGdEuybkKKwrTpO/j7pTD9KGBLTw
         N/bfu9iIc66eBdpNi0WU3Xjf4FM2cx5HqLlkvcoGXSaXEqCVtrmnSWEYaedG7XPP0Kfg
         tD8OuGGPaQ74rRJFcmVvmMVciQ1DqCJ42FQwSyJzsiMKYBCna6KTONX304DEM4Oqe38u
         7F86tlzhIwy5/lEYnfwd731lnYNA4zz/iAz1FQoM9LJYJ0bMxL+OpOdEKcoCfPvprZkN
         0/vg==
X-Gm-Message-State: APjAAAVPgBHoy32Q0e3p2rpKG7hPBw3o+0KNuTdMcD3db/s65CnFS2Gu
        ra0G69mNv1NP5P4u5lcpdafl3aXi
X-Google-Smtp-Source: APXvYqwi5LqnpkXA2R7Oan4kW2GaUC+mMsqaELjIc6PMNecHHpx7rPs6hiCyglNa9SCjoE/eYQ1SYg==
X-Received: by 2002:a1c:4e15:: with SMTP id g21mr4316750wmh.148.1571250636881;
        Wed, 16 Oct 2019 11:30:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm35357532wrv.63.2019.10.16.11.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 11:30:36 -0700 (PDT)
Message-Id: <pull.382.git.1571250635.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 18:30:34 +0000
Subject: [PATCH 0/1] builtin/blame.c: bit field constants into bit shift format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

we are looking at bitfield constants, and elsewhere in the Git source code,
such cases are handled via bit shift operators rather than octal numbers,
which also makes it easier to spot holes in the range (if, say, 1<<5 was
missing, it is easier to spot it between 1<<4 and 1<<6 than it is to spot a
missing 040 between a 020 and a 0100). Also, bit shifts lead to low-level
optimizations because they require fewer calculations for the CPU. 

Special Thanks to @dscho for helping me out throughout the process.

Hariom Verma (1):
  builtin/blame.c: constants into bit shift format

 builtin/blame.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)


base-commit: 08da6496b61341ec45eac36afcc8f94242763468
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-382%2Fharry-hov%2Fenum-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-382/harry-hov/enum-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/382
-- 
gitgitgadget
