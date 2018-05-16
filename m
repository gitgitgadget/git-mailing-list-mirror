Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49AF1F42D
	for <e@80x24.org>; Wed, 16 May 2018 08:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeEPIOG (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 04:14:06 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38129 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbeEPIOD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 04:14:03 -0400
Received: by mail-wm0-f52.google.com with SMTP id m129-v6so5765183wmb.3
        for <git@vger.kernel.org>; Wed, 16 May 2018 01:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=QxKbsEoJRTPQIRNOFQKGcpnA4LZbHtHaMOqL/Rbz6VU=;
        b=Muo2Xq5+BHVQMVYqbojrliK0NZvEawkHM06EvrKt/13GWTpZDx6GR4UvM4t0LX/TAI
         Y+ymfu4gz5sx+sv2PKvqyS5Ht9fV+ksKlWnhy50XgzpRqeV0JoqU+x1grBD0LWCULDTu
         Rw4XhZWOksng2voVOIf1wlBQGQIHNiA5QONvgznNveKyiPTyEOprZNA4h6zhwZNy0WSD
         SH/LJPpolC1mqgRFgk9UjGKqzskRXQhCuSxlqSIUegiuZB9DMgpLMYbKL6eI9D27fWXJ
         2yhIUHIGxU8l6fPKpkTDWC6EXeNRF2+pbKI1nWh7dVdGRKXzIGbjLXW4xcPi93588H8u
         Ziow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=QxKbsEoJRTPQIRNOFQKGcpnA4LZbHtHaMOqL/Rbz6VU=;
        b=NO6yTKRFxT6S2f2PGeTZEGB29Lh/HpoMGgSLVzpbeVZlXTcCP1UOVH347l+dAPrmIx
         G7pVYcHK2nlkqA10poDnOae8k2hCoV7ODicY1/VsUL+luCZOBMJX4luQfGuxnddw7yfL
         U0BELHsCKX7u/OGAEHsBEV4CBRD6ZBmejx3PTNPJ3SuMwDVUdZxf1R2PmPAi7kwPCGT7
         ugSQgOb3z++ooD8CMsoZPJUaXflUmFCfpue228DAPO/rOEt+b4v6sXjQVXDAx2A0NocM
         v04j/ndc7kyvioL1H4gcO7LN7yr66fXxPsp0+0k5CL4lnRqg5V3lAUnP3hw4dY+0rL1Y
         uohA==
X-Gm-Message-State: ALKqPwe+WcnHZpDrpNm0Co/Jm6QosINSvurU2Gk2GUL/LQIlak4g1tCD
        KnVvCIO3p1b917H4AQ0/wP8uVAXF
X-Google-Smtp-Source: AB8JxZpXdLyq7iNiVkxCOf7prV4L0mGyjoMJuZ25Tb1FMKfxgx4pHMHuOk+boewN3cyEd7LbuhhXlA==
X-Received: by 2002:a1c:6d5a:: with SMTP id i87-v6mr839417wmc.12.1526458442021;
        Wed, 16 May 2018 01:14:02 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4199.dip0.t-ipconnect.de. [93.219.65.153])
        by smtp.gmail.com with ESMTPSA id u37-v6sm1867144wrb.53.2018.05.16.01.14.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 May 2018 01:14:01 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: worktrees vs. alternates
Date:   Wed, 16 May 2018 10:13:59 +0200
Message-Id: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To:     git <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am looking into different options to cache Git repositories on build
machines. The two most promising ways seem to be git-worktree [1] and
git-alternates [2].

I wonder if you see an advantage of one over the other?=20

My impression is that git-worktree supersedes git-alternates. Would
that be a fair statement? If yes, would it makes sense to deprecate
alternates for simplification?

Thanks,
Lars


[1] https://git-scm.com/docs/git-worktree
[2] =
https://git-scm.com/docs/gitrepository-layout#gitrepository-layout-objects=
infoalternates=
