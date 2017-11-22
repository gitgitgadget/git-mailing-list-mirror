Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2899D2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 03:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbdKVDOw (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 22:14:52 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33559 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751431AbdKVDOv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 22:14:51 -0500
Received: by mail-qk0-f194.google.com with SMTP id 78so14976840qkz.0
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 19:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IKM57ftgBj3I9uCoagwJ0HzrwqeWSSezg0nImxVR25E=;
        b=sJIN1b+yOTOsJPzmc2wuPOabEkDprTvED71Kmw79ylRlUbNBx/8O3AbNYJb+OQQE51
         Lp9XQ8HVZzVsp0cbRwbTPXHNyv8qQaYBjMFfY4dXcyni3awQLMcMm1G5oQFhDc8HXpcb
         v4o5kNkKllTzfXfYHqPUMwOdMQVrB5IZ0QccDI2GOVyD0eukSsJtu6xnUuS6dU8oLous
         2L4DniQmzED8B/itdz+JF/3D6h4/BlIyyyun71yelKnH/6B5zZ/OFKIde2JkJpW5Lu5u
         y3zsJfTnynof0VIQ2YNj+OSo8I3OjHN/istWumMWtkDmyL2b8LUQkrCqbqoTFCHOoEpa
         O4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IKM57ftgBj3I9uCoagwJ0HzrwqeWSSezg0nImxVR25E=;
        b=Em47zkr3cWssDw8SgNBJfVC4dN+7k38ynUjleadpbaCQ2uS+BuDFMViXm/J3a+KcSq
         uD2SQ2547z6VyTrAgIshaqwb6KIgxkgzVesRzOPjTdkWkg/+lSY8F6rmhSa6XiAZ/d/F
         VMScL9rB8UnvpvSAI9/M9su3euIT3Tb2qkwUOzbNKzmSwckYKxy+Hf8VGW5aa0XLEwA9
         0N8gPfROa+DwVc5iYq2BHPlS0rsmCvGq7WXOtqWD3rvovweaq3NkGplI8W0r259neQe9
         Ejr8SCSxzWlQcLUSb7gX1dpPW90O5BjRc7s4wc+xtCykmadjZJ2yw/ZD0s7BiMy9+FpA
         Ax7A==
X-Gm-Message-State: AJaThX61ZW7/ZokOpr90Ftw/gteLMcXKiQu5g9f7Et1A72eb8hoIUYpv
        0WHJUn0eBCAPrTVt4wtVWcV2SuWfuQTFchy8CUA=
X-Google-Smtp-Source: AGs4zMYvfCmV7ztATlMG9u4tYSgX5bNubMT4G17uDL+zmaY4UBmEwsb/HuULQFq55kG4iyua5lLvgW+3Ezje8wAyF8M=
X-Received: by 10.55.90.4 with SMTP id o4mr17408379qkb.296.1511320490332; Tue,
 21 Nov 2017 19:14:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Tue, 21 Nov 2017 19:14:49 -0800 (PST)
In-Reply-To: <xmqqa7zfxdru.fsf@gitster.mtv.corp.google.com>
References: <20171121150954.3227-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQrC1MiPrwwPqtdX2tzj1ntFHxO28uqnMBcmVpPPrc_Rg@mail.gmail.com> <xmqqa7zfxdru.fsf@gitster.mtv.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Nov 2017 22:14:49 -0500
X-Google-Sender-Auth: bj0F0JOq2uu5O-xgE9aPsNs2xbE
Message-ID: <CAPig+cTux4dfBsX3DD=5TbM-p4-t66WX3+sufi39-W5Dw+ZvOw@mail.gmail.com>
Subject: Re: [RFC PATCH] builtin/worktree: enhance worktree removal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 9:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> Let me see if I understand. Sometimes you know that you've deleted the
>> worktree directory, in which case 'git worktree prune' is the obvious
>> choice. However, there may be cases when you've forgotten that you
>> deleted the worktree directory (or it got deleted some other way), yet
>> it still shows up in "git worktree list" output with no indication
>> that it has been deleted (though, ideally, it should tell you so[1]).
>> In this case, you see a worktree that you know you no longer want, so
>> you invoke "git worktree remove" but that errors out because the
>> actual directory is already gone. This patch make the operation
>> succeed, despite the missing directory. Is that correct?
>
> Hmph, so the user could be using "git worktree prune" after seeing
> the error?  Was there a reason behind "git worktree remove" to be
> extra careful to make sure both existed before going forward, or was
> this a simple oversight?

The erroring out in this case looks like simple oversight. Most
likely, this particular case did not occur to Duy. The code does
intentionally check the directory to see if it is dirty so that it can
warn the user (in which case the user can re-run with --force or take
other corrective action), but erroring out if the directory is merely
an indirect (and unintended) result of trying to check for dirtiness.

So, Kaatic's patch is intended to address that oversight (though I
haven't examined the implementation closely; I was just trying to
understand the reason for the patch).
