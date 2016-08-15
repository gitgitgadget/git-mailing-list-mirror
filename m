Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79001F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 21:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbcHOVSB (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:18:01 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:36184 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115AbcHOVSB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 17:18:01 -0400
Received: by mail-it0-f41.google.com with SMTP id e63so17146150ith.1
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 14:18:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MaGHYVIvpxxD8fWxW+JyxjQT9zwcGulQ6jMvXOwnWiw=;
        b=BbEqGxkcMm2ziOmclXqB96azKbdrHPWOqjCqGuuqLA6WCs3/ZMDqVNqPu+yI129OfQ
         lVjleOxRwMlAa8aeGrUfmOjNbdEu+E8lGZ5ibTFSG3bYf0T+aTzTsAojSd1d7uVAjCsq
         A9tI0aL2bpe3BAJ+poCmW6dXMTxl7fMIePShVkyDseVO/HXTmvZFqwz5hiKz0dySjIhv
         zrpuv1cxhjggBt1IGWtdWXBMuklVJFWr7WWtrkDTCP9SDPpv8Mw+1P0/abakEeYPFwCz
         oAT/sF7HQz+L/ty2aZmTiliV/Krlq4TR+XZypBNGdiRXdQgYj36t3ie0dUi0KEr4CA3S
         MDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MaGHYVIvpxxD8fWxW+JyxjQT9zwcGulQ6jMvXOwnWiw=;
        b=DWaphqsisTvm/ebDd4oBRVd39chTXC51vwki2uhWHpikc1Guw/evK3TvJ5+kUCJk7w
         9jdafkN7o9Mt+RmyJqTiCpsW32Laza3B4K5XRHGENrTEV9sxXe57kTZ4jOdxHE7TSOWV
         wQ/jTGTxsRmknTXjhhoSKsivp08iwU2UUyWHYcoBeZQ38h4x6GkyJPVB78U+KCNxtPUW
         mEqqWibZN8BAS3JmFCsVDkt0EQfenc2hQsGFMaoQZ8sbv5TDIHzDCv6H7e+j/vGLqDWf
         v719ZvZiSU7xXOElSsg52m1F8sVwivEQvZ80muSLgaz+IqFb5wsjQISfewwJD3QGyqS7
         1STA==
X-Gm-Message-State: AEkoouuPu77ZRwqmhttdtq92/eQrIhEXxCLz6+gmF2sJqcSlDezJFNM7hkDQsteIWN8x6z0ay0Q5oVE/4JM4D7Em
X-Received: by 10.36.29.15 with SMTP id 15mr15888594itj.97.1471295880212; Mon,
 15 Aug 2016 14:18:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 15 Aug 2016 14:17:59 -0700 (PDT)
In-Reply-To: <xmqqd1l9g2lv.fsf@gitster.mtv.corp.google.com>
References: <20160815184021.12396-1-sbeller@google.com> <20160815184021.12396-2-sbeller@google.com>
 <20160815184730.eevqogqrxp2zp43q@sigill.intra.peff.net> <xmqqh9alg2uh.fsf@gitster.mtv.corp.google.com>
 <xmqqd1l9g2lv.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 15 Aug 2016 14:17:59 -0700
Message-ID: <CAGZ79kayr9p9qGrH563_-D-WpWvcgzmsQMrPxkxTptbLzp+4oA@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkout: do not mention detach advice for explicit
 --detach option
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 2:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> I don't think doing it this way is _wrong_. It just feels sort of
>>> pointlessly over-engineered. It's also a little weird that all of the:
>>>
>>>   if (advice_foo)
>>>
>>> will trigger because "advice_foo" is set to -1. I think it does the
>>> right thing, but it feels like a bug (the value is now a tri-state, and
>>> we silently collapse two states into one).
>>
>> Guilty as charged.  I do agree that this is over-engineered.
>
> Let's discard 1/2 and amend 2/2 with this incremental.

That is fine with me.

Thanks,
Stefan

>
>
>
>  builtin/checkout.c         | 3 +--
>  t/t2020-checkout-detach.sh | 5 -----
>  2 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2a32b5f..337c35a 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -656,8 +656,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>                            REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
>                 if (!opts->quiet) {
>                         if (old->path &&
> -                           (advice_detached_head == 1 ||
> -                            (advice_detached_head == -1 && !opts->force_detach)))
> +                           advice_detached_head == 1 && !opts->force_detach)
>                                 detach_advice(new->name);
>                         describe_detached_head(_("HEAD is now at"), new->commit);
>                 }
> diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
> index fe311a1..fbb4ee9 100755
> --- a/t/t2020-checkout-detach.sh
> +++ b/t/t2020-checkout-detach.sh
> @@ -180,11 +180,6 @@ test_expect_success 'no advice given for explicit detached head state' '
>         git checkout child && git checkout --detach HEAD^0 >actual 2>&1 &&
>         test_cmp expect.no-advice actual &&
>
> -       # explicitly ask advice
> -       test_config advice.detachedHead true &&
> -       git checkout child && git checkout --detach HEAD^0 >actual 2>&1 &&
> -       test_cmp expect.advice actual &&
> -
>         # explicitly decline advice
>         test_config advice.detachedHead false &&
>         git checkout child && git checkout --detach HEAD^0 >actual 2>&1 &&
