Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759EF1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 00:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeB1AmI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 19:42:08 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:36274 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbeB1AmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 19:42:07 -0500
Received: by mail-ua0-f169.google.com with SMTP id i15so478657uak.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 16:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8/H7yH9H/Dj95MzLXZU/RklETIZtPVwmsJBhwJ8Sc1g=;
        b=GIW3y5aRXRF+6ozbtOH4zz1FB6ZasoYxwsHmt7jxJSyRXYvu4hZ2aGHCtzV1KGjOW/
         7+PzY6yUDqx5i07d3ZAYe4wUQstB7MZGCMSYPoQRmzc6ycwcnZT/eYGKNnO7lao/DT2j
         4ktE7E4bbmiZREZ4R1zIHow5kYlBhzKVfiiv891eQm5XpBe5AzjiZGfgbW9L+pyykK4b
         NS64s97etxJGFZ9TOTGcIYuCtfa3Ou2/6TIUmEFKKzEwJmSswC1bMQXQ7FkdPzega3G0
         wABMT8h1c5muNEAU3tjwXKL7tPPh2d0XygBoFZ9en6s/GMlVLL3dI+IO2uNYAuy89f9r
         ++PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8/H7yH9H/Dj95MzLXZU/RklETIZtPVwmsJBhwJ8Sc1g=;
        b=FWDYv8X2c0cVwPvFPwTaNMPyqRQ3zmyjxNk1lJ/hwLUB0J02EVfzHvPBZ6H0kHS7z6
         xBGpfnM04GdbEdm0vh3IQnlGVxCUZFTgYZLxQf8iLauwIY8b6RK+PFGXzr0+Rww4kMck
         lCY3dxL51QViYp1oL7g0u6gQ5qWURaYfg3EBrufNxgh6QVGrQwa86b5j92B2bqTtVmaI
         nBHaJaFnF/OmhNGepC11RLC06cmsoFlC4TuepawCfU1u41e5wMv6Jbd20daXCN5a5KH1
         y3fA8wjvwc14onfncsMcrtgmVAXnu/lVzQfTViTPD4fAk/GS9bZdqzYMKtGiRyZaRqTl
         cqsQ==
X-Gm-Message-State: APf1xPDeNFdccVot/ut1OojgQs/sxHE3oQ9IyEqZPghGEm5o/q0cKHVv
        y81jXC1oAebUgDcF0eKuOPfNZZuJFt83ljVXLCw=
X-Google-Smtp-Source: AG47ELsBYVZJvgbHFJAZZchCOetiEHDgTp7xtaLhrU40A/r2th+8Xt2naL6M3Mu1RJ2NHaA1iKIK/qgppSKO096wwlg=
X-Received: by 10.159.59.229 with SMTP id y37mr10890630uah.48.1519778526837;
 Tue, 27 Feb 2018 16:42:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Tue, 27 Feb 2018 16:42:06 -0800 (PST)
In-Reply-To: <192d4ee4-dbdd-3e47-b45c-8d1f7b69b9af@ramsayjones.plus.com>
References: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com>
 <xmqq3726t11d.fsf@gitster-ct.c.googlers.com> <69c7dc21-fb52-5982-f7d8-04518d06db6c@ramsayjones.plus.com>
 <xmqqvaf1qqcx.fsf@gitster-ct.c.googlers.com> <20180213100437.15685-1-szeder.dev@gmail.com>
 <xmqqr2porf4z.fsf@gitster-ct.c.googlers.com> <20180213172603.GA10062@sigill.intra.peff.net>
 <xmqqeflorc9m.fsf@gitster-ct.c.googlers.com> <xmqq371mqjce.fsf@gitster-ct.c.googlers.com>
 <xmqq4lm2ozq3.fsf@gitster-ct.c.googlers.com> <192d4ee4-dbdd-3e47-b45c-8d1f7b69b9af@ramsayjones.plus.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 28 Feb 2018 01:42:06 +0100
Message-ID: <CAM0VKj=hbT_m21ssF+nedVDrfNiYHu8wd9mUD55mAdNgmnZSgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 12:47 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 27/02/18 22:05, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> OK, somehow I had the version from Ramsay on a topic branch that was
>>> not merged to 'pu'.  Here is the replacement for 2/2 I'd be queuing.
>>>
>>> We'd need SZEDER to sign it off (optionally correcting mistakes in
>>> the log message) if we are going with this solution.
>>>
>>> Thanks.
>>
>> I guess I missed Ramsay's v2 which already did this
>>
>> <550fb3f4-8d25-c5c4-0ecd-3a4e61ea13f4@ramsayjones.plus.com>
>
> Yes, and as I said in the cover letter, I wasn't too sure that
> I had passed that patch along correctly. ;-)
>
>> so I'll use that version.  We still want sign-off from Szeder,
>> though.
>
> I would be happy with either version, or maybe Szeder would like
> to tweak the commit message. In any event, it would be good to
> get sign-off from Szeder.

Certainly, here you go:

Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>

However, I'm not sure about the authorship and taking credit for the
patch.  We ended up taking my patch, sure, but I think Ramsay did all
the real hard work, i.e. writing the commit message and, most
importantly, realizing that something is wrong with that '...| sort' at
the end of the line.
