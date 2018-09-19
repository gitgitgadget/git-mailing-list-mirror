Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A756E1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 02:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbeISIJD (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 04:09:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39788 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeISIJC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 04:09:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id c12-v6so4176240otl.6
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 19:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JpjTGrRzzwyNfU+IBC0GGjSmK1e86a0fGGrn3vUf/zs=;
        b=WYZyvKaMop/0l+QigVEw8EIpQW2bz9NGYWbwesxeFw8VRUNv5QRh08HYHIZxg20ha+
         PG7HxmmYPMhrwILlFMn4M7K+c4iUuCSZXDTKTWqiaIyfYUkbDlmCAOLxx3UejDqynkxk
         RQK6ZVbYMISp92ZK0zowh5QJJtLZoy7IAktGxkMFefZc0RMBbedLcvGHVCTvqEpPxdth
         rSE+zsGc2cdePJbc7E5YZDQ7UFzOU3nivunoEtMqWe+Hg8HmELLDabMgWU14PXKwBBtn
         aMobTZcwbV+X5Nlg6nN6ZHAr0GTobAmXLpUiMFI1X51ofrwQSM55cxGtveyEZoAk4peH
         pRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpjTGrRzzwyNfU+IBC0GGjSmK1e86a0fGGrn3vUf/zs=;
        b=MPyo3P+rnKIbL2eCY06G3151ENnUqjUwOjqDz0W7jDfuLx76Zk0TnRiqQDoIfYfTQf
         ZvXbT2bKrJDGJzOUjf4L4AdZFxpkISz0yQCu7ztGErY7aXKhcZW565AFdiAYsRaT4pzr
         FLMTZjVcOF+vRQAL3eKo1GGbZgJaU/PrnySqobZE/CJQPwsVlCbPAjt+e+fCFdnQEzVy
         A+FOb1uVzw95/7f0s9Dc85u4Vzw9NLWmIuuqgXUkerxfd9eYsv2+NZYClz6HfNZ1UMOB
         RHlLPHrLC60tsK+EDq1smxYPYLuTrT3EQ91OMRP5OhNNY+6bBQrYeV1Iu0W0YK1/qHZ2
         KTCA==
X-Gm-Message-State: APzg51DwMa1BkUn+POhNmjm98V8h1xzROamW8WwCtNtRfHvAyathPZhS
        QdIBWVI/fDqYInL4AOLGws+UGA7s3sxNYGKBpsW2
X-Google-Smtp-Source: ANB0Vdb6t4g4Tvhiy3lmXucOEt0Zwf/NBA9zzh1qJg/Q+Kcrf0qe8Urfxe4M4yDKN2FX3DYtU1Gm2gMM6Y/i6wqDQM0=
X-Received: by 2002:a9d:522d:: with SMTP id e45-v6mr16525064oth.250.1537324408064;
 Tue, 18 Sep 2018 19:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537223021.git.matvore@google.com>
 <12cc68aabf76e08f6214b21df786e61301c8f55e.1537223021.git.matvore@google.com> <CAPig+cQchHoWffobw3iGrsmRRPx2LKNu+EvR=t4c5RcV9Cmi9g@mail.gmail.com>
In-Reply-To: <CAPig+cQchHoWffobw3iGrsmRRPx2LKNu+EvR=t4c5RcV9Cmi9g@mail.gmail.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Tue, 18 Sep 2018 19:33:15 -0700
Message-ID: <CAMfpvh+0_x4UbPHK9jJoeN6rgZOS7F6iq7u_LRMP0YssMOZynw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] tests: split up pipes
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 6:30 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Sep 17, 2018 at 6:25 PM Matthew DeVore <matvore@google.com> wrote:
> > tests: split up pipes
>
> This title explains the mechanical changes the patch is making but not
> the intent. Perhaps reword it to say something like:
>
>     tests: avoid swallowing Git exit code upstream of a pipe
>
> > Some pipes in tests lose the exit code of git processes, which can mask
> > unexpected behavior. Split these pipes up so that git commands are at
> > the end of pipes rather than the beginning or middle.
>
> Can you say something about how you chose which tests to fix in this
> patch? Is this fixing all such cases or only a subset? It looks like
> it's only fixing "ls-files" and "verify-pack" invocations. If that's
> the case, the commit message should explain that.
>
> Also, missing sign-off.
Fixed - here is the new commit message (I changed the wording of your
header to fit within 50 chars):

    tests: don't swallow Git errors upstream of pipes

    Some pipes in tests lose the exit code of git processes, which can mask
    unexpected behavior like crashes. Split these pipes up so that git
    commands are only at the end of pipes rather than the beginning or
    middle.

    The violations fixed in this patch were found in the process of fixing
    pipe placement in a prior patch.

    Signed-off-by: Matthew DeVore <matvore@google.com>

>
> > ---
> > diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> > @@ -51,8 +51,10 @@ pull_to_client () {
> > -                       git symbolic-ref HEAD refs/heads/$(echo $heads |
> > -                       sed -e "s/^\(.\).*$/\1/") &&
> > +                       git symbolic-ref HEAD refs/heads/$(
> > +                               echo $heads |
> > +                               sed -e "s/^\(.\).*$/\1/"
> > +                       ) &&
>
> Why is this change included in the patch? There is no Git invocation
> upstream of a pipe here. While the cleanup itself may be desirable, it
> doesn't belong in this patch.
This actually should have been part of the "tests: standardize pipe
placement" patch, but I did "git commit --fixup=SHA" with the wrong
SHA. Fixed.
