Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71E111F404
	for <e@80x24.org>; Mon, 11 Dec 2017 15:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbdLKPZc (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 10:25:32 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:37792 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbdLKPZb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 10:25:31 -0500
Received: by mail-it0-f47.google.com with SMTP id d137so16608998itc.2
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 07:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9LtObEjTfHX0E+jb30BAnUe30BO6nwRJt2XBLpUcesk=;
        b=HeJtf86W8LZhP45rqgh1Ei0ET2Ut+cZqEDK7icgvsHd14HQBEwVyrIi6brjBbrooYC
         n9qURTMKsmIfO2SBP86oFaqO1gA8elQ/gfQghwoXCsQfLXIHOgCqUbmJql/T7feQqGDy
         vbxtYqwViqdvvjUGMP9vKg3eg2NsBdjoW+/20L32mjmWrAtcyEchI3gxRVGS9EL30ET/
         TlkB+QtkvimTnz1eXAeRVnt1L8ousXXB9o0hzA5b47f6aTgiWobA6JEmJ9GJhEGc7fn3
         C2soqku/6V0RGWk9HavOHpeA1j5ut7wdZ9mnpWd5RVKQP0rVcYo34FvGszs/x9xTJQDN
         y9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9LtObEjTfHX0E+jb30BAnUe30BO6nwRJt2XBLpUcesk=;
        b=lUiEhfN8lpanvvkH2sZb1lkDNvhfhNXtcNlP7DFBZ7Du4jogfsaM7bQLKU8giIt8KZ
         LSfTEE5EVR3XrIiAmtnLdTk/f4kF/F+sSomPZtkaLpAM6SLqk51dBqQLM7KwdGGnYmuI
         LCvm9lL1RoKLj4h3gbH67iDYK23KWMtPFsvm8TZ9Ea24d5B8dV1ns0Sb/7rJo4oOsH9r
         Bet5ZAwTayrCwqydaLXuKq8ms+hZ1OVvwr+/HEcj3yonQZXrSujNrxUmNCoJ92/bzh2R
         uTMWWjUWbVrBEIre4zJygFbilMd6jTKXrCS0ijfADT0+284ncJBgpD2+tC3oviWXPFKu
         DLnQ==
X-Gm-Message-State: AKGB3mJjfQFJIlbpgXp7iOhu//6tVoTlKvnFYaoQWQKsJP3xMwMFEPit
        rT/9PmMJ4Men2oKC3MDolT5fJPXUk33sJMukTdaCXA==
X-Google-Smtp-Source: ACJfBovBB7VHOIVf3bF6hlZe0LMaKR5YeAo5UZ1HEHrjR1n8CB5QrfWHKVDI90d2PRrZD1/vogxj2KuYod41nl+EYKM=
X-Received: by 10.36.129.212 with SMTP id q203mr1580493itd.152.1513005930516;
 Mon, 11 Dec 2017 07:25:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.131.68 with HTTP; Mon, 11 Dec 2017 07:25:30 -0800 (PST)
In-Reply-To: <ca421d38-2d9a-8681-7947-3799c59984a7@gmail.com>
References: <20171211134409.13339-1-g3orge.app@gmail.com> <ca421d38-2d9a-8681-7947-3799c59984a7@gmail.com>
From:   George Papanikolaou <g3orge.app@gmail.com>
Date:   Mon, 11 Dec 2017 17:25:30 +0200
Message-ID: <CAByyCQDBtCdxB9fLUeH6A8o-g444TO_yD+O7ap8RO2Bg0b6aAA@mail.gmail.com>
Subject: Re: [PATCH] builtin/tag.c: return appropriate value when --points-at
 finds an empty list
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I agree with what you're saying, just I thought this might be ultra-minor f=
or
API-breakage. To me, 0 doesn't necessarily mean "I didn't segfault".
I lot of tools use ret-values to give information back. And that way it's m=
uch
easier to just `||` the command to something else instead of `[[ -z ]]` in =
the
script.

But I see what you're saying...
--
/=CE=93=CE=A0


On Mon, Dec 11, 2017 at 4:05 PM, Derrick Stolee <stolee@gmail.com> wrote:
> On 12/11/2017 8:44 AM, George Papanikolaou wrote:
>>
>> `git tag --points-at` can simply return if the given rev does not have
>> any tags pointing to it. It's not a failure but it shouldn't return
>> with 0 value.
>
>
> I disagree. I think the 0 return means "I completed successfully" and the
> empty output means "I didn't find any tags pointing to this object."
>
> Changing the return value here could break a lot of scripts out in the wi=
ld,
> and I consider this to be an "API" compatibility that needs to stay as-is=
.
>
> What are you using "--points-at" where you need a nonzero exit code inste=
ad
> of a different indicator?
>
> Thanks,
> -Stolee
>
