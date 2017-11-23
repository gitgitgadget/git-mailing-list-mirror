Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B325C20954
	for <e@80x24.org>; Thu, 23 Nov 2017 06:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbdKWGWP (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 01:22:15 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36484 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbdKWGWO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 01:22:14 -0500
Received: by mail-vk0-f47.google.com with SMTP id p144so11222273vkp.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 22:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9lhxqdlKQymjedJLG9tg0CMYlVjwdPn+4mx/+4RSP+E=;
        b=HELPpq3UE1Zbv1mcCRbm7zQBRdFNQvMocGuZuv3uumcqA5yojD6Ra7aWgDg0GA4FqO
         Wvj4fjaFg0OmjVu9IWtnvXsD83ilYyWtwgK1Svd8QAxQjcRExD/PTtO0ZNEPWG+U1oQ2
         dNOM4qKdfT/fhTYqNsh7GLlHJrwHJEvIMHm7qZL1Ty4Cg7D5yRc3KXF+MhLbM1MIUI1/
         /stDEsjgeLK5xCLe+BxWgjNdp9HtmjbhS9LrqevtXA4dNs26ImUkbTF907uTMMK+9Jl3
         VLe6uxYHCuQ9FDLxrW8vuVMcxtMzP6HMoS054Wq8kKFcTH3nkf+5xG1b6o5dloRHSyDj
         PTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9lhxqdlKQymjedJLG9tg0CMYlVjwdPn+4mx/+4RSP+E=;
        b=UaspVDFt5neP6blTqBg6e898rnNKJsUhvsuNvu3fukhTvU8Sb0nvYwURgOlRxkzv/s
         amRdo0VSLkUlkqxMrHqjoXSNQ0LiLHPqWz0+AShEM13ovsfTFP83+NdJ3JU2PKkrzNYk
         5Fv4xAGQdlS+p3Xr/Auyk3NJr8wZlZ/58D+N9bpBQAerRJNFY08r5BGCwkPo/xp1NzTq
         0O5R5f4/Bbm2uoEY9yRnPSjZ/F0SJTLM1YTzmrdG9YpxXWGwu058S2r2Zh3MTHPlDyZf
         hbfjBnVjuwZdFxJ13bYdZ0vbgk3jM8BBEGUdbUtLReiVInnLFBbqmoWnc5v4e5UFtc6w
         aiQw==
X-Gm-Message-State: AJaThX46AQheUi1S9FkLiSjqS/fZN8trjjLYkFSy0UjqMo94GwNb3Rmk
        XB0qdJYaN96riijDmSrAc/GPWiOSQ5gOeYKyx9s=
X-Google-Smtp-Source: AGs4zMbGPqscYtqR+u3UZeb7568ZnUl07rY8fzBnY+JlEPukRmLaW3FV2kzzHYLAPyKpKHRuKkyHGqbM8K5Bv7ApObI=
X-Received: by 10.31.172.137 with SMTP id v131mr19372266vke.75.1511418133463;
 Wed, 22 Nov 2017 22:22:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Wed, 22 Nov 2017 22:22:12 -0800 (PST)
In-Reply-To: <CAGZ79kbustk48yP7jC6UmjidQUuWfhQWcqX_CUz=WnM0X3H8aw@mail.gmail.com>
References: <20171121080059.32304-1-newren@gmail.com> <CAGZ79kbVzDEv=rj7X6EhWZyAFd+fq+nwG8c+raqu9tXv_z9f4A@mail.gmail.com>
 <CABPp-BFm7ZcYbie-n-ASmb6MDyJXW3G8YdtHRAzpVNgOvwK5MA@mail.gmail.com> <CAGZ79kbustk48yP7jC6UmjidQUuWfhQWcqX_CUz=WnM0X3H8aw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 22 Nov 2017 22:22:12 -0800
Message-ID: <CABPp-BE3W1dRNZtYxAimT4v-J4jzjKAV03YH3gF5V9f3A91P7g@mail.gmail.com>
Subject: Re: [PATCH v3 00/33] Add directory rename detection to git
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 11:24 AM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Nov 21, 2017 at 5:12 PM, Elijah Newren <newren@gmail.com> wrote:
>> On Tue, Nov 21, 2017 at 4:42 PM, Stefan Beller <sbeller@google.com> wrote:
>>> On Tue, Nov 21, 2017 at 12:00 AM, Elijah Newren <newren@gmail.com> wrote:

>>>> This patchset introduces directory rename detection to merge-recursive; I'm

> In my first round of review I only looked over the tests to see if I'd
> find the behavior intuitive, I spared the implementation, as Junio seemed
> to have reviewed a couple patches of the v1 implementation.
>
> Now I also looked over the implementation and quite like it, though
> I'd be happy if others would also have a look.
>
> All but one comment were minor style nits, which are no big deal;
> the other remark that I was musing about was whether we want to use
> strbufs in the new code instead of e.g. sprintfs to extend strings.
> And I'd think we would want to use them unless there are compelling
> reasons not to.

Thanks for the reviews!  I've fixed up the style issues already and
will take a look into switching over to strbuf.
