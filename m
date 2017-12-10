Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C67F1F407
	for <e@80x24.org>; Sun, 10 Dec 2017 23:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbdLJXhS (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 18:37:18 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46882 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdLJXhR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 18:37:17 -0500
Received: by mail-qt0-f195.google.com with SMTP id r39so34109320qtr.13
        for <git@vger.kernel.org>; Sun, 10 Dec 2017 15:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7jM4DQweiNiTvAcWTj5Ln3EL+n2GODEqcOLmd8ePYiU=;
        b=nzbDc2JRjFmI2yH89SNTd832vQhjV8ueHwrbm4Fays46T/2UW6Lmz71wmjkO6ASLtl
         GxF9qe18i1mYmA+T/GG8TOsK0ktkitYKaIGa5Bz9AMQl7gyTa4gItYAGpDNUdn/jYvaO
         hrmDfK0rdHndXpo7Mz7eXsLiIGSF/hQ89nT9ciBM23YGHMZdTwiI3weDan9w+yJO7xkr
         s0uDkrNFOzyU6SRu7MZ304XuaJhfDIQfXYXgXI637pelFkqb3O505G6YgaowcTKFRUYC
         Ik8N+Qxqr/62rZc+hqOrk/Iltx+IzKvvm5seSzaWze2cMAoYOv7PvRe7cW7bajR81myR
         /uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=7jM4DQweiNiTvAcWTj5Ln3EL+n2GODEqcOLmd8ePYiU=;
        b=SQ2dlQBlY6FBciniVq60y42Git1oDQvylM1clg0Czkyj5Qnh7fKoCAmrYUdKSK4is8
         EFsw2bzyqV2UEVEuThUnzlp37gXICdJehmAwb3+iEum5/ITQ8DECNklu4U1n2kcYqhdC
         Gb20QpFWgTf9ljJhBkCMUPj/aXNovPVwv1fwMPtBCPS2Rd61tIFOM8tFTlrsR/AJXa7T
         cAFIE1oZsbEylfJLMbhGC90EUdwI3tE+FPzLmlzjVSODpQub2zfNexsJrldkPFin+9w4
         eclKTrD1eyaaOQCjPyNKu6i0Pu03c1iROZQVo68Pml3n1JLYNvJYRvAIALEjMcEznrRK
         6FVg==
X-Gm-Message-State: AKGB3mIKNBpKBnIFGRgOtKkYxwa24YWM70xNoMmDV2azgWJvxB26f+sW
        P/JCQbHVOShqE768oAAHBv3CgkAV4J5Z0EKtdHw=
X-Google-Smtp-Source: AGs4zMZIzUHtpLjlhZVZyW0to6bzm4ErsLYQ602aZSlgZ94bcI/foBDH6rf671Sa+DJGRImMmT3smXNlDf+bqEZQxIc=
X-Received: by 10.237.37.47 with SMTP id v44mr26222339qtc.55.1512949036627;
 Sun, 10 Dec 2017 15:37:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Sun, 10 Dec 2017 15:37:16 -0800 (PST)
In-Reply-To: <20171210212202.28231-4-t.gummerer@gmail.com>
References: <20171210212202.28231-1-t.gummerer@gmail.com> <20171210212202.28231-4-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Dec 2017 18:37:16 -0500
X-Google-Sender-Auth: TZVHW9oelI3d5TXWKQ5Dx-o5IDs
Message-ID: <CAPig+cRG2BcD3DRuPcyxOsoMV6HuZOXXoyc+CQZm6gBLpsSCaQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 10, 2017 at 4:22 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Make sure that split index doesn't get broken, by running it on travis
> CI.
>
> Run the test suite with split index enabled in linux 64 bit mode, and
> leave split index turned off in 32-bit mode.  The laternative would be

s/laternative/alternative/

> to add an extra target in the matrix, enabling split index mode, but
> that would only use additional cycles on travis and would not bring that
> much benefit, as we are still running the test suite in the "vanilla"
> version in the 32-bit mode.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
