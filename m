Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86DD2023D
	for <e@80x24.org>; Wed, 28 Jun 2017 22:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbdF1WRa (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 18:17:30 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36442 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdF1WR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 18:17:28 -0400
Received: by mail-wm0-f52.google.com with SMTP id 62so66090944wmw.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 15:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5kGFcGsHkhZZZTjWQ6Np4Y9pfPmGMOxHZ/V4E5yBehI=;
        b=WQkDiOZc6vGUN7qln1ScKqx5RSi5vXdX/UA0/rVRQmccEqe29bT6sSLwiEg0QpOoA9
         XyftJDDzI6mGfloTvyQPoHLKjEM15iVlsgivmSm+zn6nPiQC8096SkiLolcKzyuC1rZP
         +43FxbY6/ObbVe+i5bjIpKnFfPz49pALS+f5YeOBDRLiJajwKYVAdvX7Dk/EqaM1h0OZ
         j+iDMBgNOCadT6xQx/npwtxmr4fo7hyjwOUrXjhHstgu9XEQgZmdCvJ268BUSsr/eUfe
         NHJ1LiRX5Plcosf7520hSUMrr4cyv5w7lUCvbdBKrdL5L5dp4xZdfSM/ARs64m1Wzumx
         Quhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=5kGFcGsHkhZZZTjWQ6Np4Y9pfPmGMOxHZ/V4E5yBehI=;
        b=XUsQ6aBlk3RXRrPzu9ZEv9uNPSNMH3XUO+bSNztQ3ag0KCExe9da66nhISlaul7dGp
         7r7XWbti3dzHr2NQLXl225gbJmPfI63argrcJ7C0EPohlIYDHyOQ7oXGG0XDp/p0J2cm
         36Lm/RzHVCWiKbHbLqdegYawAEdlT6gi4S6JTD6d0uECqUodytMUAw7dYFaK8ldA1kbJ
         0KCbRv+C+A8lDjYli2UWERu0uYGQQwaXbbu7tuIij7ic59rA+woJfOWQ13Iidru8Ho4T
         bwtkMDbynPKWMnM8svpGD9l7O04jNUQihZ/r1vltI5bxzOte+UdOnZ6OSds58dsdQYI3
         7tRw==
X-Gm-Message-State: AKS2vOwkPdi6gRD2U0+5r+9ZCrv1bXfP2IQ+p6IxbBzSkadRtWtYxZ8/
        IOfWHONj4PiLSqsBW8E=
X-Received: by 10.80.182.180 with SMTP id d49mr9235106ede.56.1498688246902;
        Wed, 28 Jun 2017 15:17:26 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id 4sm1805283eds.48.2017.06.28.15.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2017 15:17:25 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dQLH3-00048W-Bt; Thu, 29 Jun 2017 00:17:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH v4 4/6] coccinelle: add a rule to make "expression" code use FREE_AND_NULL()
References: <20170615231549.20085-1-avarab@gmail.com> <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com> <20170615231549.20085-5-avarab@gmail.com> <xmqq7f0byayu.fsf@gitster.mtv.corp.google.com> <2122b01f-7627-cd1b-c7df-751c076f90ff@web.de> <87injfkd0j.fsf@gmail.com> <xmqqlgobvklj.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqlgobvklj.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 29 Jun 2017 00:17:25 +0200
Message-ID: <87fuejkb9m.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 28 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> Late reply, sorry. What version of coccinelle are you running? I have
>> 1.0.4 (from Debian) and can't get this to produce the same results as
>> what I have.
>>
>> On top of next, I did:
>>
>>         Revert "*.[ch] refactoring: make use of the FREE_AND_NULL() macro"
>>         Revert "coccinelle: make use of the "expression" FREE_AND_NULL() rule"
>>         Revert "coccinelle: make use of the "type" FREE_AND_NULL() rule"
>>
>> And then generated the patch as usual with `make coccicheck`, and
>> applied it. This has your change.
>>
>> I then re-applied the manual "*.[ch] refactoring" changes
>>
>> This results in this diff with next:
>> ...
>>
>> These are all cases where we now miss things that should use
>> FREE_AND_NULL(), e.g.:
>>
>>     diff --git a/builtin/am.c b/builtin/am.c
>>     index c973bd96dc..2f89338ed7 100644
>>     --- a/builtin/am.c
>>     +++ b/builtin/am.c
>>     @@ -484,7 +484,8 @@ static int run_applypatch_msg_hook(struct am_state *state)
>>             ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
>>
>>             if (!ret) {
>>     -               FREE_AND_NULL(state->msg);
>>     +               free(state->msg);
>>     +               state->msg = NULL;
>>                     if (read_commit_msg(state) < 0)
>>                             die(_("'%s' was deleted by the applypatch-msg hook"),
>>                                     am_path(state, "final-commit"));
>>
>> So it looks to me like removing the "type T" rule breaks a lot of
>> things, but that the change you made to the expression rule is good, and
>> we should do that for the "type" rule as well. Your commit says the
>> "expression rule already covers it", but this doesn't seem to be the
>> case at all.
>
> OK, if an older version of the tool that is otherwise still usable
> needs two rules, let's keep the "type T" one by reverting the change
> out of 'next' and then have a patch that only rearranges the lines,
> something like the attached.
>
> -- >8 --
> From: René Scharfe <l.s.r@web.de>
> Date: Sun, 25 Jun 2017 10:01:04 +0200
> Subject: [PATCH] coccinelle: polish FREE_AND_NULL rules
>
> There are two rules for using FREE_AND_NULL in free.cocci, one for
> pointer types and one for expressions.  Both cause coccinelle to remove
> empty lines and even newline characters between replacements for some
> reason; consecutive "free(x);/x=NULL;" sequences end up as multiple
> FREE_AND_NULL calls on the same time.
>
> Rearrange the lines to place the addition of FREE_AND_NULL between
> the removals, which causes coccinelle to leave surrounding
> whitespace untouched.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/coccinelle/free.cocci | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
> index f2d97e755b..179c185d85 100644
> --- a/contrib/coccinelle/free.cocci
> +++ b/contrib/coccinelle/free.cocci
> @@ -15,12 +15,12 @@ type T;
>  T *ptr;
>  @@
>  - free(ptr);
> -- ptr = NULL;
>  + FREE_AND_NULL(ptr);
> +- ptr = NULL;
>
>  @@
>  expression E;
>  @@
>  - free(E);
> -- E = NULL;
>  + FREE_AND_NULL(E);
> +- E = NULL;

Looks good.
