Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 441C11F404
	for <e@80x24.org>; Sat, 24 Feb 2018 13:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeBXNqG (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 08:46:06 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:40061 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBXNqF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 08:46:05 -0500
Received: by mail-ot0-f170.google.com with SMTP id s4so9699529oth.7
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 05:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZkhWCSmxr/RG+EeQPIt7NEJ45CYsNPYPhY+L7hqV/ok=;
        b=MF8XhzC6SEB8vUt/wJcrGXmH33lSxeMtmDytb6Zy54FAwcXNnjBWRgZrGUkq+cIlHP
         B3KOw10wJHo/iYKxVxOMzEYEgUaQ40hGzTifQW2/B6o619ouYa6gj/NoC7oZBgwL38qN
         3WJ1Kp+AlMwRp0hwOaT/xNtkgLd29xyfDfgbSCxTsBrnR2iIBtQ0mohsQVFPrwl1dITp
         nGdU6tXXmMRk3j1+ruRMOJZ8scbAj80wWgJylYUOrx99iSbRzqXuuMNM2ofQHPvhOvnv
         EaYg9oplxcuCkrAhVPQr7YKmQkqA5rf0oXSqoUXo0QIf4fi/O6OIrJKsKgbHdBc3rSuh
         Lrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZkhWCSmxr/RG+EeQPIt7NEJ45CYsNPYPhY+L7hqV/ok=;
        b=EJED3/VaMZ8NtL+BRePrLJTi0dVqFglbjTetNiutdDpDSccJCXNgDC+UCJ0mjh/sFE
         Q/oYVkwBEuoh21gyHCSSBNRkMVrGZoxUyQJKhjDB9Mf1zDqq+rV4nT4k32OWSYFc4lFR
         4tiHm8g/wjrQYmZRjhkwYlUspNvVx7PPJ1/ee8H831o6GI0+Su6XKYH3YkQipy4sxWa4
         lTvqQaVTuPqwlzDg5hKFFdKun0uqi5cAKwIf5BFjqDz8gjgEwjQkNytD73hrdeWpArfh
         QdBTpyHPc+jw7iJTbDO6tAzTsfJUZivJN7lhbZ5DiMoHWcIOsTW1IjqEkUJe0qMVBL7P
         g15Q==
X-Gm-Message-State: APf1xPDgt/Zep3VYh923AyiZe6KFWeoeBThHwrQGvKZnRcCH8lXdqxNB
        GQRdkPotbdEUwwHnyEevqksgf/XQyJGpXQ26SI4=
X-Google-Smtp-Source: AG47ELsK0X0t40FCel9kkcIX5qG77qEr/IoxFQYUqR4NurS699Jh+uqoEtmvkwBeedun5CHfeiDPE+wRT92GcTUBty0=
X-Received: by 10.157.11.4 with SMTP id a4mr3628531ota.65.1519479964531; Sat,
 24 Feb 2018 05:46:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Sat, 24 Feb 2018 05:45:34 -0800 (PST)
In-Reply-To: <CAPig+cQq32eyArKME4_H0njjn2mbPkNVKo=ULbh-16d55tVYOQ@mail.gmail.com>
References: <20180223095640.25876-1-pclouds@gmail.com> <20180224033429.9656-1-pclouds@gmail.com>
 <20180224033429.9656-5-pclouds@gmail.com> <CAPig+cQq32eyArKME4_H0njjn2mbPkNVKo=ULbh-16d55tVYOQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 24 Feb 2018 20:45:34 +0700
Message-ID: <CACsJy8BjZsSM+g4=hUV+v_Z+Lj2+f8m+9i-OLAR8rz+2Zij0WQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] diff.c: initialize hash algo when running in
 --no-index mode
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 24, 2018 at 3:15 PM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> On Fri, Feb 23, 2018 at 10:34 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy
> <pclouds@gmail.com> wrote:
>> before, compared to the alternative that we simply do not hash).
>>
>> d=C3=B2ng =C4=91=C6=B0=E1=BB=A3c
>
> Accidental paste?

Oops. I blame Emacs.
--=20
Duy
