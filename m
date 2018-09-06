Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 595DF1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 06:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbeIFK40 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 06:56:26 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:39058 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeIFK40 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 06:56:26 -0400
Received: by mail-pg1-f182.google.com with SMTP id i190-v6so4668184pgc.6
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 23:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=brS4yMJtVbn6TezPw3KdEpTy+ovgTZKcTB0gxuG7C3c=;
        b=a1T6fRKtPJEw1INmrhNrgCz+tuPiRCCeaie8YglIupuSzQFsTo5yrcx0qv6OXVrcID
         pFnfWma74gLpU7fZowna/VEjQbzmyQdgl25X+S+lK+x5cJk/9RGQTcAGeJnD3pa6ZIzl
         G1HE2YPvn9UXginYk/OxecSEx//+b+pdo8QoY9deDiOLqtU4LHWNHmawi9e8uaXGOQBa
         lL1+lqmH9n7o5HvgZDY1/SFhMLUvOJwgaDHe5TwISMvsrazoZMVCCSnV1I0nYcydTh9W
         D9OS8G2D7ucx6BIciRflJl/WtrMibVpDRKRfu/+1+QEuaHrW7grlH6h+JrY5bJj3/zfD
         ZffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=brS4yMJtVbn6TezPw3KdEpTy+ovgTZKcTB0gxuG7C3c=;
        b=KX8dDKmRqg9S9BYEItWLKKEjeKx/a49oWwSQnEqLaqF+tr5LWf/A1kp5GJ8hyF0GxT
         4D17zif/PM44Aumh1pY1ZRuR+AJcayA+k+8a+vm/AKlwVw5gPuIFKxCkhvgYrDeer+el
         ThcfB4SGqT3i1tzRRH/SOuehq34dArkOAzC1u/LkmCoNr+Ff7Ewq16fCmBlLFUUbInZN
         o4osDyS3NaD1QHAEBOtjzUQNJAVEmAw4HnBH5CEYL52hOfpHgTBdFQJaltR9ikmIvzur
         E8eq2F5WEaI7Crrdgo/Yakq2ubQh8IN0zbgpe40GcJAvucrC6/cphEJ9GwsN43zbbqRF
         pGiA==
X-Gm-Message-State: APzg51Ai8EnikT6ZIcjfYzLfpiOBl/KCRexXUDNPiFjVuzOgXC4hceiW
        3OYEigmsvXgNACMlx5YuZYWN/cJ/dXWLzuzQOio=
X-Google-Smtp-Source: ANB0VdbEcarzd/Pj2oosonVerGCnkOYgEKhzeNNyZlgNfPtInusoayj111ZF2BZtSJtikwPejmTdPmFPTJ3D1059s6o=
X-Received: by 2002:a62:71c4:: with SMTP id m187-v6mr1317285pfc.232.1536214954261;
 Wed, 05 Sep 2018 23:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180905231952.28145-1-sbeller@google.com> <20180905231952.28145-2-sbeller@google.com>
In-Reply-To: <20180905231952.28145-2-sbeller@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 6 Sep 2018 08:22:20 +0200
Message-ID: <CAN0heSq1fNb6Wc1P0B3JQL3PA_yi329vbkG5pjWsCpYf8SDn5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule.c: warn about missing submodule commit in
 recursive actions
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +       if (repo_submodule_init(&subrepo, the_repository, path) < 0)
> +               warning(_("Could not get submodule repository for submodule 's'"), path);

Missing "%" in format specifier, so `path` will never be used. Also,
s/C/c/ at the start of the warning.

Thanks for marking with _().

Martin
