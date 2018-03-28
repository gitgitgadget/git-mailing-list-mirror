Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E12D1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbeC1RDM (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:03:12 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35931 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeC1RDL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:03:11 -0400
Received: by mail-yw0-f182.google.com with SMTP id y64so1035462ywa.3
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L+cdNPxNVc2dCJ11N9/w3JU5PZGV2cOB7k8gk434iD8=;
        b=WViqwmc5pEXnjvALxMsJFcWyyrqHEztPb5fuM97q4ZdqIatX8LT+Js3REs2qmDE3h2
         8gRVxJ9GCxQIwuvtIU7Q8f5qG3mHBeW5f/t7Nsfc17uU81d8091kG8zBnGzKDmzJU85X
         Ed59nuidj2lCVfl7gKeUSgUQeWilrVrzL7xanB9VC03kYmmsr3tobDYzLwvAdLN3Icz0
         lxmQvMQsul/gM/LbAwpS2iRGlfSyLERztDYq2Tpf2wOUdBBQh0dLIIHzxK3BDSi35V0C
         aVM8Bf/XwBYItIWWkBnNYswD4mK/5fWstA3TnhEGl8YtAPkcROTTI46nbMjboKQ63rg5
         gh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L+cdNPxNVc2dCJ11N9/w3JU5PZGV2cOB7k8gk434iD8=;
        b=fYrBlYBL6NYqeVw7JC7lrlZxN4O0k5OTQXb6/dPYSPW8TcewA3hBUryEp/45w9okb6
         gbswGpWuK1xCh1rj95pUeU6ZGhdXdrl74BewQpje/kF1VA+i0hlsscshyAhByDzm0fQh
         NOYzkdsWO9UxxvxcTpG17vRwONTkLKJIcg1Uswvt7CmCVm7/teC11GIVNGY+t4oW68LO
         sqb8KLy48PL0vTL9TgnXZ9cyOwLW4jltutQ7xp6Vu/WRZYR7LJpfQQFcJ5o6gJV6K2vf
         CJy1evFVfcLIO5OO6XKdFd2BK9JE/vp7o7lhBU9YniFTli870LdxyEV1sZz22bva9YO9
         bm9g==
X-Gm-Message-State: AElRT7GvbGE83E73T7Ip5tj5Rmd3pF+a2UxBeQSiBs0MoB+yR6Lp/Pwl
        3RS18DRX/0YMAhT3HdmnTYDdlKce/iL0aQI9VrXjiQ==
X-Google-Smtp-Source: AIpwx48HCm6HmN2p+aF5GxZqAJcxxmjZzeHpjiREIe6qs8Er80gE5IHMpx8FWW2S7P2TPW72C+aS8mSjIfUuNamIz58=
X-Received: by 10.129.136.7 with SMTP id y7mr2764418ywf.238.1522256589855;
 Wed, 28 Mar 2018 10:03:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 28 Mar 2018 10:03:09
 -0700 (PDT)
In-Reply-To: <xmqqlgec87ns.fsf@gitster-ct.c.googlers.com>
References: <20180325095046.GA687@feusi.co> <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de>
 <CAGZ79kYagdvpOcZykF4JPQc9vpVb8_xyFiQkE9yznBQTD1PWJw@mail.gmail.com> <xmqqlgec87ns.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Mar 2018 10:03:09 -0700
Message-ID: <CAGZ79kYveU=TK-zvxNimSYcQqhOf4OFgynuNDu08bvbDtwfEEA@mail.gmail.com>
Subject: Re: Null pointer dereference in git-submodule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, jeremy@feusi.co,
        git <git@vger.kernel.org>, Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 9:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> Subject: [PATCH v2] submodule: check for NULL return of
>> get_submodule_ref_store()
>>
>> Maybe more imperative, telling what we actually want
>> to achieve instead of what we do?
>>
>>    submodule: report deleted submodules as not initialized
>>
>>> If we can't find a ref store for a submodule then assume it the latter
>>> is not initialized (or was removed).  Print a status line accordingly
>>> instead of causing a segmentation fault by passing NULL as the first
>>> parameter of refs_head_ref().
>>
>> Thanks for the message here. Looks good!
>> ...
>> Which would be added in t/t7400-submodule-basic.sh
>>
>> Thanks for coming up with a sensible patch!
>
> I take the above to mean that you as a contributor active in this
> area like the general idea in the patch but not volunteering to take
> this topic over

Rereading the discussion, I overlooked the author of the second patch
to be Rene (for some reason I thought someone else would have
written that patch. Sorry about that!)

> and instead trust Ren=C3=A9 to tie the loose ends with a
> reroll, taking hints from your suggestions?

As Rene likes. I can reroll that patch with a test, too.
I'd pick it up after rerolling the series from yesterday
(moving nested submodules).

> I just wanted to make sure that we won't be confused whose turn it
> is next (e.g. me waiting for update to t7400 from you or Ren=C3=A9 doing
> the same).

Thanks,
Stefan
