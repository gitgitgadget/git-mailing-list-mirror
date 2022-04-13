Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417E8C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 17:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbiDMRdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237361AbiDMRdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 13:33:16 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F024A33E8A
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 10:30:54 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id x4so2673553iop.7
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQgnh+wvYaqELT5rUkWKnJqK3oyY8HtlaBSwedACfpg=;
        b=HkR24jkJA6Tr1KxfDbCT7ZT4bgSf+xZA7vc/0PvRYcnCS9Auq9q2D7dvrb9qYqXbIB
         QeRsqYVr4Irvfo4nPACVm9gzvNqc51b7hutStCD0ls+Yv4SQY4RpzPYCzaRDSCHpC4Qp
         g46QeVFcOafkqXHnsF/viVnCdfMn8n3h1+D8WaQAstB8FXhsHL0YOg7M5h/rh73oQu2D
         DgKNWqoZ0/BqY4eD0P01NrhH85liCFgHtxWsioQEpL87eJSgxnEMOfH6UVK6/rzJpdDR
         xdJFmlu7LMXPg2tx3X5JaOcD0t8y5Ft599V1ysplXSrjTtgN8J0CHB0Bt7OSuvmaBsb2
         7qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQgnh+wvYaqELT5rUkWKnJqK3oyY8HtlaBSwedACfpg=;
        b=KHn05WUqrg4g2jgRSp9layWqQREXT5xsHYMPaFeZDuipvJFX/U6DH95oQGfQLtAm4E
         siMQHRTTXAZnB/EUXaKFm1201Kd2gzlZ+QIOR+Y0lRjSiLXCW/1vbemUsJDMiC1qOkBQ
         bQHAAGbsP5ASstimXgYr1yYcUv8daNTkt80L0LhyR9cTGV+esTdLVfFkGxhRksz0lc8r
         PQNNCRQk8oiUcA14TJ1uP8TVj1PA6oAXpfvDnvnd8Pb+urCe3TxKt1x2f2ArAF3JA/Qw
         yk0T2ScVdNKLlEEgxvyjbnFeT0caWP/HIAdDASKC6EstvyiO283RZ+++4ZZR/3kuVYp4
         pZtw==
X-Gm-Message-State: AOAM530JoegpPnM7tmKKD3MY3GWkN1A+lVgkfEKYyUlKMEgHeKwvWC6h
        MGtGUH086ebUpoNq751HD6apedCAPpvXBixc+RI/00e8TzKRL8/+
X-Google-Smtp-Source: ABdhPJzBuKaxtXXuz3WXgh+QxsjTf+J7/X+EKpN+Kg6e4LLtmuNYIUduJmNF5nUO1lfRp3IwcuMtZiiCIsYNRyRN2EQ=
X-Received: by 2002:a05:6638:22a2:b0:324:2e2d:d39a with SMTP id
 z2-20020a05663822a200b003242e2dd39amr15638287jas.271.1649871054405; Wed, 13
 Apr 2022 10:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <033701d84f5b$ad167ce0$074376a0$@nexbridge.com>
In-Reply-To: <033701d84f5b$ad167ce0$074376a0$@nexbridge.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 13 Apr 2022 19:30:42 +0200
Message-ID: <CAOc6etY0fyBnT9kMSm+s1LqfCsSV4RRppokuE5igme-M-cvW6g@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     rsbecker@nexbridge.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 7:26 PM <rsbecker@nexbridge.com> wrote:
>
> >2.35.1
>
> I'm sorry if I'm missing something here but how is this different from
> cherry-pick A..B?
> --Randall
>

Good question, but cherry-pick has troubles with merges:

(same example, after amending):
$ git cherry-pick v2.35.0..v2.36.0-rc1
error: commit bb4921cf45e11d063e7bbe55f594adf8f0077d5d is a merge but
no -m option was given.
fatal: cherry-pick failed
