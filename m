Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E311F424
	for <e@80x24.org>; Thu, 12 Apr 2018 07:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeDLHtp (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 03:49:45 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34491 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbeDLHto (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 03:49:44 -0400
Received: by mail-oi0-f67.google.com with SMTP id u141-v6so4295574oif.1
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 00:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Ohq8v6bjW65QPLLduYtz51DLdta2Lr4qnLCei8eN+Q=;
        b=mF5M3IurYIF+u1lRKz3oXHzfA3E3Cy0qngP7NaNpJi6A4VKXfreMQC1IVZlPkJ0HUh
         lzr83KJG4+yxBMCf33utPUQKz9Tr11BoREhY6YH23aGoRyeExQ1lEVXupUaq+F/42A++
         4hPrF6icdbkSjA8vR0GoF3vFm2VaHStuvcqtFIWLZLu5ey6gY+nspwevNWDK4/U849jd
         WDTL3Je+UrZ+juJGT4ZB8FjlfsV3q2hPXh+asIm4xfcfzv9aX3udzaXAX/n15YWVX/WO
         OpE+qtNDfQH0YXZtQbzzjZS66RYdVtrTaWwBBKrR5pBjpdCGYYn/k64zn43B04lyXUbS
         krJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Ohq8v6bjW65QPLLduYtz51DLdta2Lr4qnLCei8eN+Q=;
        b=sDAsgLcorg4Ov8RUBmr+KKQRbMArS6UFwgRREFqIcA7xFw54hqkk880YuoHot27OL1
         HITDkT6I9idknks2nCbzxwrndhSYbZCl3s1Wi9OERHUvbtVHxG147eVwrqOa6cKq/SEm
         woE045DX5rK6wACauY1L1cU4JtOh4ytfM9I2udxpiUNCDaq4tbfzfO2lnD4EawyiPfhC
         x52AIgB+unRw5mi4x4pvEq/DuD687WVtRxbyMekYSXQKlhskSzlrS/8RdkJ48Tbf9ciJ
         DB7+npXnT7Ly/KqwsIhklMrMW5R8qA9FP5aCZgLKS0voPKlBCH4G3voj/tDgLOSYuO2g
         iWkg==
X-Gm-Message-State: ALQs6tDwUBKIYzYVYKqhNPKo2WFG4VlKh8WLKLp7vyGzBquwktSZTySb
        6ctLorMREecWK363nMdFI8A+6D8i4sOC3rjSKyQ=
X-Google-Smtp-Source: AIpwx4+8wu5JplLERwlX/UacMSE2AZ/tLamf2k0suUxlvcB8yd9o/Sw2dUz5Lfx29P9OS+/UTbfVHVbFta/TIDX61Qo=
X-Received: by 2002:aca:ec4e:: with SMTP id k75-v6mr5236762oih.81.1523519384268;
 Thu, 12 Apr 2018 00:49:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.68.194 with HTTP; Thu, 12 Apr 2018 00:49:03 -0700 (PDT)
In-Reply-To: <CAGZ79kbt=J5SHsHJTfOZYhgSdn9_gOjVBC3qp_oL0sC-b3ZRmw@mail.gmail.com>
References: <20180411225534.48658-1-haraldnordgren@gmail.com> <CAGZ79kbt=J5SHsHJTfOZYhgSdn9_gOjVBC3qp_oL0sC-b3ZRmw@mail.gmail.com>
From:   Harald Nordgren <haraldnordgren@gmail.com>
Date:   Thu, 12 Apr 2018 09:49:03 +0200
Message-ID: <CAHwyqnVg83xSQHRnDVz+aMxPPMj-3bWF4P8YUxEjurxnpDhFEQ@mail.gmail.com>
Subject: Re: [PATCH] Create '--merges-only' option for 'git bisect'
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think it looks similar. But if I'm reading that thread correctly
then there was never a patch created, right?

On Thu, Apr 12, 2018 at 1:33 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Apr 11, 2018 at 3:55 PM, Harald Nordgren
> <haraldnordgren@gmail.com> wrote:
>> When ran with '--merges-only', git bisect will only look at merge commit=
s -- commits with 2 or more parents or the initial commit.
>
> There has been quite some talk on the mailing list, e.g.
> https://public-inbox.org/git/20160427204551.GB4613@virgo.localdomain/
> which suggests a --first-parent mode instead. For certain histories
> these are the same,
> but merges-only is more restrictive for back-and-forth-cross merges.
>
>
>
>>
>> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>> ---
>>
>> Notes:
>>     Proof of concept of a feature that I have wanted in Git for a while.=
 In my daily work my company uses GitHub, which creates lots of merge commi=
ts. In general, tests are only ran on the tip of a branch before merging, s=
o the different commits within a merge commit are allowed not to be buildab=
le. Therefore 'git bisect' often doesn't work since it will give lots of fa=
lse positives for anything that is not a merge commit. If we could have a f=
eature to only bisect merge commits then it would be easier to pinpoint whi=
ch merge causes any particular issue. After that, a bisect could be done wi=
thin the merge to pinpoint futher. As a follow-up to this patch -- we could=
 potentially create a feature that automatically continues into regular bis=
ect within the bad merge commit after completed '--merges-only' bisection.
>
> The github workflow you mention sounds as if --first-parent would do, too=
?
