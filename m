Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3C081F403
	for <e@80x24.org>; Sun,  3 Jun 2018 10:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751013AbeFCKfW (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 06:35:22 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:40002 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeFCKfV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 06:35:21 -0400
Received: by mail-wr0-f179.google.com with SMTP id l41-v6so40259940wre.7
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 03:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZofIii0B/4Oi8Xgvs7RtIWeyxHxs/gi0/EEY0vJ9kY=;
        b=OJ0F+UKOKDe5S2U3L9mLEI1P46BhWUQrK7FPucPwnXoqqS3J0ZdxVsDHYLyzc1p3XU
         1sQpilWHp24OguufwQEB3uV+BDXRFW7tVoFqEcEStDuR12MlMaL/FlpeBnns+/Z4uF0i
         mYvaZOLZ2VcsuOIboxsf5gkR1YT21PSnCA99uRplV9T2dOTxnAgBkdfGg+DEzWJR3CCZ
         HcQgnTJ1nmdctxDbF1LMqs7+a3t6IRK1hBCZqC+QqKnGwjYuktPWtVDoKbKdWeP1KHbC
         GZ8KgbcSlSaJUKi2M0Xf7p1ZGcepAz0zmsXaz8EQqbkGyUfMJhpd8q/CL1aKwzwyPAks
         Cgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZofIii0B/4Oi8Xgvs7RtIWeyxHxs/gi0/EEY0vJ9kY=;
        b=NTkXM66tKDPHqmAOni98RWC538QAgwLx9JGrsfvWZMEOgOCkOtOIFjCKKgcROYpuDb
         soGQ8RXfRbkOq4LdQRnfL5dk5JgqRnvqSFli650O7JU/8jTBbmnQMkmj5+D0jaaFohk0
         2QqH09SDGeaQoSxS2/ohn258tTdK9qf5zoyGcg8LNgLGNCBfqDO/uOOl/UTW7g2Vwusj
         Wb/864GPJGuRP64KslTG/e/4FlsiEfLU7HJ8JfabkMhslnWYDEM87RkEIblznejfgkpw
         p9aWVWZrwfeTD0vKdUDLlQx3PZHZ8y9YGSc2NHD1XiJJI+lT5g1F8WrZculaDl1SSJc8
         7iag==
X-Gm-Message-State: ALKqPwfcrbM5wAZOfEm8uPOsjexAj28U6PTuNdz0n1iwqOAdgy6oflBD
        +yxk/LEkSgbFXJ1oeNKV03A=
X-Google-Smtp-Source: ADUXVKLKdwPRwqKXDNadooOPCO5BOLnMPJXqZyWZMsD3CKgqngaeyYFL5dTsgW8a/aE+vTmPejM96A==
X-Received: by 2002:adf:9441:: with SMTP id 59-v6mr8994488wrq.274.1528022119906;
        Sun, 03 Jun 2018 03:35:19 -0700 (PDT)
Received: from localhost.localdomain (x590e56c9.dyn.telefonica.de. [89.14.86.201])
        by smtp.gmail.com with ESMTPSA id n7-v6sm4973535wrr.39.2018.06.03.03.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Jun 2018 03:35:19 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: how exactly can git config section names contain periods?
Date:   Sun,  3 Jun 2018 12:35:10 +0200
Message-Id: <20180603103510.21020-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <alpine.LFD.2.21.1806030547070.5332@localhost.localdomain>
References: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain> <20180601210731.GA20974@sigill.intra.peff.net> <alpine.LFD.2.21.1806030547070.5332@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Fri, 1 Jun 2018, Jeff King wrote:
> 
> > On Fri, Jun 01, 2018 at 04:14:12PM -0400, Robert P. J. Day wrote:
> > >   ok, so how on earth would i use "git config" at the command line
> > > to set a config variable with some arbitrary level of subsections?
> > > let's try this:
> >
> > You don't. There are only three levels: section, (optional)
> > subsection, and key. If there is a subsection, it consists of
> > _everything_ between the two outer periods.

<snip>

>   if (for some weird reason) i wanted to define a multi-level
> subsection,

You can't, there are no multi-level subsections, see above.


