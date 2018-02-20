Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA0971F404
	for <e@80x24.org>; Tue, 20 Feb 2018 06:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbeBTGKa (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 01:10:30 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38450 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbeBTGKa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 01:10:30 -0500
Received: by mail-wm0-f46.google.com with SMTP id z9so13635772wmb.3
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 22:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8tlfSNCuexJ5khcw7Y29rnPdVnEve3tOpeBZEC7UInA=;
        b=CZSo+TXxoX05sgj3nAJeoLH2GW2Ow8JgzQfzNhQbRTokVR1xBA7a9JY3K9qyb9AJtU
         re2XUkQncdfwWIQImOJnp5PFqaF5AdzHdd0Ib5S8cfHhwp/kfJoYYTfiqpQrcikom2ht
         OLMpMKxUHcBWlndOvastQGQ067VCm1QYBXHSE8qO69T2Jdc+WfCOn+6j+G58ABmZgCEv
         jfu5Sf2Nje6jXNXCf1mdljHvFWa/bh0qG3uChp6RFzPLc16Enfs+EtHxW1IfrB1UBFua
         6pmMxYP5F3Pi9uZk+n0CTftx1R+65/DYwcZxTDHvA5XDs5/rq1v59DDzfWrFEWJaA49d
         nOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8tlfSNCuexJ5khcw7Y29rnPdVnEve3tOpeBZEC7UInA=;
        b=U59eoYHkCSvfclA8K5HWUikdokqhkAFaVvKR2WsEn0sZgJ93Mr5TfZaNcj9x1QrEbq
         zF3gwlcwQRqnkwnQ5j51v/wEbQXkF4r34llOxnhDs7w4b4lFsAVv6beD5CW2lKQwoOp/
         fIRMwtySBWbSvF6y/RujQXP53wlBZVTfIwhnjvoV8A85Xzmg+95w+s1sf2ETRP2hB3Up
         cwBLBGtkt0iKk6XP8i1OiNgM9RPkVpGltRv1/5Fy/MfPQQJBxbpiI+SLXH2T8Cjn+BOr
         VmGfiIPqIbYSfiFlNqTZuZCE2hLzrINzzst7jEHLCVIBSoAq3m4esh5pQZi+7kYMEm01
         gf8Q==
X-Gm-Message-State: APf1xPAwRR3g0ByHPIodz2WAScGN05GtZboxjILdkSefw+aHiJ6QrX8S
        xFCmIeA+3zplrZdOSgZDQf4kTxSjOpeAADPJYCQ=
X-Google-Smtp-Source: AH8x227ESuRMas0ur2m0leicowGHe30MEoZ8ncBVGJu9HBdhSzX9IkIfT0n51ibVsrijqdx3dsHWZ0eQYmTqmlhzJS4=
X-Received: by 10.80.139.5 with SMTP id l5mr21129173edl.265.1519107028640;
 Mon, 19 Feb 2018 22:10:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.139.133 with HTTP; Mon, 19 Feb 2018 22:10:08 -0800 (PST)
In-Reply-To: <cdef8e46-92ee-2062-385a-999b5b49ae9a@gaspard.io>
References: <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com> <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io> <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io> <20180210122131.GB21843@sigill.intra.peff.net>
 <5abf8565-1aa1-c101-83a7-90781682bc7a@gaspard.io> <20180214013520.GA25188@sigill.intra.peff.net>
 <96dd7fb3-849b-8de6-7c3a-cd6bde9da432@gaspard.io> <20180219212347.GA9748@sigill.intra.peff.net>
 <cdef8e46-92ee-2062-385a-999b5b49ae9a@gaspard.io>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 19 Feb 2018 22:10:08 -0800
Message-ID: <CA+P7+xrb0PCsJtQbrT+E9hNhZ8yZ5qeR7vVGVYFtqEOeoK77kw@mail.gmail.com>
Subject: Re: Fetch-hooks
To:     Leo Gaspard <leo@gaspard.io>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>,
        Git mailing list <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 2:50 PM, Leo Gaspard <leo@gaspard.io> wrote:
> On 02/19/2018 10:23 PM, Jeff King wrote:
>> [...]
>> If you do go this route, please model it after "pre-receive" rather than
>> "update". We had "update" originally but found it was too limiting for
>> hooks to see only one ref at a time. So we introduced pre-receive. The
>> "update" hook remains for historical reasons, but I don't think we'd
>> want to reproduce the mistake. :)
>
> Hmm, what bothered me with =E2=80=9Cpre-receive=E2=80=9D was that it was =
an
> all-or-nothing decision, without the ability to allow some references
> through and not others.
>
> Is there a way for =E2=80=9Cpre-receive=E2=80=9D to individually filter h=
ooks? I was
> under the impression that the only way to do that was to use the
> =E2=80=9Cupdate=E2=80=9D hook, which was the reason I wanted to model it =
after =E2=80=9Cupdate=E2=80=9D
> rather than =E2=80=9Cpre-receive=E2=80=9D (my use case being a check inde=
pendent for
> each pushed ref)

At least in the "push" case I think there is value in saying "if one
ref fails, please fail the entire push, always". This makes sense,
because if a user happens to violate some rule in one thing, they very
likely may not wish any of the push to succeed, and it also creates
problems with whether a push is atomic or not.

For fetch, I could see either method being useful.

Thanks,
Jake
