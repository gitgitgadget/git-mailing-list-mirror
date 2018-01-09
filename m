Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0291F406
	for <e@80x24.org>; Tue,  9 Jan 2018 20:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbeAIUQo (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 15:16:44 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36024 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbeAIUQn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 15:16:43 -0500
Received: by mail-qt0-f179.google.com with SMTP id a16so19377395qtj.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 12:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zk4MBQaBQOgZfXh0QUve1fgx2iUnkc6VUMsUh+001Ts=;
        b=qY/sDsbxxVL6BfTaclP1iaLqBM0XMdEcyhmxfD01d++3f60OC/D1F+wZbM0OPBjwuw
         62nGSsPRcnL52h91VcS3xn9TneNdGvn4nz6TS+Bs1JTKNpMNFxttE1H30WteA3J55YJq
         RC45W3Vy3ollJu4YemrnL43EaoWghWrgAC4/KAik5UD1DcFeZGIOLPsYmCo/WeX4p4T6
         P3W+85er5Xu2g8eyw1cAEVlBZlQjxrkB5xWRWiP0NTVm8Qj+B2kXoY1WslBo4lpoFWy7
         juApv/1XRFynRytod47z1UMethfyA4mpXugcMi6D81RrvZxcH0SyKWck/sKUDHe1PJvy
         RpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zk4MBQaBQOgZfXh0QUve1fgx2iUnkc6VUMsUh+001Ts=;
        b=dZ49+HJnY7wC+tk6tS/hUVU873lt+3absrwg2noRCKKGKqw6UsqsswTJquGT6qVS4G
         g2A7ciAN4cjhIXJOUqaLp1+WWVoAlkiUfQJuj7Jf7YcjAVAvYxF6T1GkWW4nETwb8iDI
         hh80tUSriM4XrM0wZOOScnM1QpTb4Ikg3NpTmLGTq4hDOJ471NOXZo73yzxSBdZa9/T5
         f8M+C4uRI13Nz3r5mEUIt9GNqMYAtlfuJ+uxAaEiY3AXsGA34WURRmsyVp5/9pvK6f1b
         RO92GNW6XOj/GN51g+SxKluECX30uEDjdGZdsPgsksxNy2hPSJWEIsfpVx9WqGFgICzC
         Q0UA==
X-Gm-Message-State: AKwxytf4PcY1u1s9Ad8VqO5nkgWaK4F56fcXq/ALZvCA0CSZwtOuhkQL
        GqkxQxKqzTXQ3+H0QziuC8/X5sZN3pjX62q1SBT95A==
X-Google-Smtp-Source: ACJfBosmvYjrVEsWhq8zJMm+VDe8dola4cCvuVs1up5Pc8MuoSXhlSmZ28gNFnTra3WwP8Of3c/7aKpafeyW3PYNNGA=
X-Received: by 10.200.26.37 with SMTP id v34mr23166336qtj.207.1515529002582;
 Tue, 09 Jan 2018 12:16:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 9 Jan 2018 12:16:41 -0800 (PST)
In-Reply-To: <xmqqtvvu4wr2.fsf@gitster.mtv.corp.google.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
 <87k1wtb8a4.fsf@evledraar.gmail.com> <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
 <20180108102029.GA21232@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1801081438470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180109065018.GA32257@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1801091357560.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAGZ79kYdgD2h7QjjJe0aA4eMATCGkH62XYvziUNvAPsBJDXOCA@mail.gmail.com> <xmqqtvvu4wr2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 9 Jan 2018 12:16:41 -0800
Message-ID: <CAGZ79kajChFqJRxLAaFnUeikW28kJQXLj7JG6G3=Td4u-zxTwg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 9, 2018 at 12:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> And in that light, I'd like to propose a new naming scheme:
>>
>> (a) assume that we "tag" HEAD at the start of the rebase
>> (b) any abbreviation must be given as committish anchored to said ref:
>>
>> pick REBASE_HEAD~1 commit subject
>> pick REBASE_HEAD~2 distak the gostim
>> pick REBASE_HEAD~3 Document foo
>> pick REBASE_HEAD~4 Testing the star-gazer
>>
>> And as we have the full descriptiveness of the committishs there,
>> each commit can be described in a unique way using the graph relationship.
>> I am just throwing the name REBASE_HEAD out there to trigger some associations
>> ("similar to FETCH_HEAD"), but I dislike the name.
>>
>> (c) this would not solve the problem of mergy history, yet. For that we'd need
>>     to introduce more keywords, that allow us to move around in the DAG,
>>     such that we can reset to a specific revision or name revisions on the fly.
>>     So maybe all we need is "reset", "name" (== short lived tag),
>>     "merge" (rewrite parents of HEAD) to be expressive enough, but still keep
>>     the line oriented interface?
>
> It is correct to say that (c) is an issue that is not solved by (b),
> but with the current scheme, the commits are internally referenced
> by full object names, and just before it is presented to the end
> users, these names are abbreviated down to unique prefix.  The
> machinery expands these abbreviated names back to the full names
> before going forward, so it is not an issue that we are creating new
> commits during the rebase.
>
> Does it make it easier to read if we used ~$n notation based on a
> fixed point, instead of shortened unique object names?  What
> improvement is (b) trying to achieve?
>

Johannes wrote:
> I think a better alternative would be to introduce a new abbreviation mode
> that is *intended* to stop caring about unique abbreviations.
>
> In web interfaces, for example, it makes tons of sense to show, say, 8
> digits in link texts and have the full name in the actual link URL.

And that is what (b) would solve, as it is shorter than the full hash and
yet exact.

(c) was mostly speculation on top of (b) if we can take it any further.
