Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 237D91FDEA
	for <e@80x24.org>; Mon,  8 May 2017 06:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbdEHGkN (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 02:40:13 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:35923 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdEHGkM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 02:40:12 -0400
Received: by mail-qt0-f180.google.com with SMTP id m91so42351995qte.3
        for <git@vger.kernel.org>; Sun, 07 May 2017 23:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HeuYgH60BobzXoEj3vBfnnxJoyV4+EDxoEXjrUtKKb8=;
        b=F53E1ea3iAdSHTJgcddQdCtcSfBO20dY5AYGymg/q15camjcaJ57qliSYZQ9bGQ5lw
         ra+sKnR3wU5iSqhWpS29eGyIElK4D5gdRK9VjPpT84n04bD670Gfw5O/wkbc2B4WHRvd
         YynfD2sJSlu/b2Dc9WIsNe0s4Y5DGvl36jfANV+yujPFKgPBJJBUbBJazWef9bAHcRY4
         M352Pp9wU/RIfqXwaewk+lK/kQfyHNgVoE6PMBpYEM5KN1fuoZMAiSrfJf6hgOilcwi3
         NJmClKzKzHMgt02lGBITpt11E7wWqHgaHxq4LYn2tk/Os9Qa0DCko+YRbHREpOVQxxdy
         4jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HeuYgH60BobzXoEj3vBfnnxJoyV4+EDxoEXjrUtKKb8=;
        b=AbUv1N2iex7lixCK7KSwrbwnrHmmwRxuZpP5ORTMzODsvdwcVWEOmGm6R1OU9asKvv
         n77vGXlsGavd6h7iVCZGuak8LT5E7QBZXNVroWIxqNyKOjswijq0R+i8Txi+8bo+WXMv
         wSSt/XR6LY6FtJW5ltGQ6Wz0byGcLi/jJkAubPQ8fzFLqflO12aPwAsxl1Pl07GLs85o
         q4tr76C/3TEZFGXw+g5M2SXb2uCq7uQBeCDQLA+Xh4/MqXfQPy+qFhP5JrY9TP2w7SkJ
         Ir9DsEc5C3LwcqthpDtzb+r5wqfqS51DniYgRDHPJSnckOm2nDz6Ux3tsQwjZ48uOVgK
         O3kg==
X-Gm-Message-State: AODbwcAQ2UrsQxR5MVJrmT5Df7k0zWXTsW8UoPRtZTK82xxDk0t0sQZk
        md+HK21j11JfEnBHxLzNBNKlJdWPpw==
X-Received: by 10.237.36.42 with SMTP id r39mr9695136qtc.159.1494225612040;
 Sun, 07 May 2017 23:40:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Sun, 7 May 2017 23:40:11 -0700 (PDT)
In-Reply-To: <xmqqk25sazik.fsf@gitster.mtv.corp.google.com>
References: <20170505145713.8837-1-chriscool@tuxfamily.org>
 <xmqqo9v4azv7.fsf@gitster.mtv.corp.google.com> <xmqqk25sazik.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 8 May 2017 08:40:11 +0200
Message-ID: <CAP8UFD0r06gX1QE+hsSAN6uGvNfQJgUv1PmbzoQyAg7_FpHiGQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] split index extra bits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2017 at 3:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> This patch series contains 2 patches that have already been sent to
>>> the list but have felt through the cracks. It would be nice if they
>>> could be considered for v2.13.0.
>>
>> There is no way for anything new to go to 2.13 without getting
>> reviewed and discussed at this point---it simply is way too late.

Ok, sorry about resending too late.

> I found that this is <20170419093314.4454-1-pclouds@gmail.com> in
> mid April (please do not make readers dig the list archive when you
> can).
>
> I didn't see anybody (not even you, to whom the patch was apparently
> addressed) commenting back then on the patch and that was why I
> didn't touch it.  I've skimmed the change in 1/2 now, and although I
> didn't see anything glaringly wrong, it would be good to have a test
> if this fixes a reproducible crash.

It fixes a memory leak not a crash. And this should not be a big
problem as shared index files should not be changed often in the same
Git process.
