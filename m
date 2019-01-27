Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC8F11F453
	for <e@80x24.org>; Sun, 27 Jan 2019 19:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfA0TI4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 14:08:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33455 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfA0TI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 14:08:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so12403753ljd.0
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 11:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZ2Z1iDkFrA+61891aSaroSloISi/pQWJKtBXLGdtt8=;
        b=RXX8WxEi+w481YwrOvIoVJSRhbayetTY2oeO1FbdYBkb6DQ1q2ZpcnsBS52OYaPUZB
         PJkpOwxmMmvXgb5UoHzLhkej/tWxX0vW25I5Ec7A8kYYayjX9CTqKT01Z15kiD8K6uAS
         mFQzLuVhNhl4KoQsgOffuAiqB6R2vtr0sCPp+SFsF8eWKhgJl4XI3pZaHOUmGBSWXvmq
         7FlcAzmLXV2HcI7LJS4g5trvd9QyDvGFOJkwm9qKIztYA1M7HdqKlKkhzkXXNH6xsDNA
         oI0pI8G9qllylX2hzAC0k6v4sP8pch73lDGsRXh8I8TvgpiLukExqDO42KsmmorTDLwR
         wemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZ2Z1iDkFrA+61891aSaroSloISi/pQWJKtBXLGdtt8=;
        b=OSgRTfSC9AEwXABdq1b3C+87lYlWEDrJy/DTjsTRkw2j2n47cmC5nGQEK/SBT/HLJG
         Mc28nv/IZn3Udf1TEbYzz7vPooiSUN1f/LsoXIHBLIoCqX5HL3Lzp1Bb729aTrtA2A3M
         11Tdr/+VKXn3MHMMIuPlz6WPQsWMRReb9gsF+053k3D4iFfE4Q30zxxiL/GMCxKLlFA1
         tZP8SIqui/IFCoIlEhW4SJLQmoGAcNj5g2YIvfLC9XJLokxl0ea4tVmUnCz972TShcgY
         L65uXZ+o8yr3gfLLMIHuKRpZ19LRkXT1fsvgFspKdtv/J1xmaFHEb4S6AOT+VXqOUdAQ
         kWxg==
X-Gm-Message-State: AJcUukdjEoO5wUB8mAvHMvLVfRi+RA6gKCQ6mI0utnbYvDtswCvaTh10
        GjrIMh5rv+FJnZo8aIdHu38+ddWnZvbRcrySXGxwZw==
X-Google-Smtp-Source: ALg8bN5RSiymW+NUV/X15vUm2krUdEAotPf4afWxMthbs2Aiiiwp5vvXc0hcjpaLk2SyN0XTD4K7eGslCSVlv5mqEuU=
X-Received: by 2002:a2e:9c87:: with SMTP id x7-v6mr14076918lji.196.1548616133969;
 Sun, 27 Jan 2019 11:08:53 -0800 (PST)
MIME-Version: 1.0
References: <20190121223216.66659-1-sxenos@google.com> <20190121223216.66659-2-sxenos@google.com>
 <CAGZ79kYiE+VhQw4GMs_VM6kK5yXAQ8An0o4fCVSZ3gr2+rHwiA@mail.gmail.com>
In-Reply-To: <CAGZ79kYiE+VhQw4GMs_VM6kK5yXAQ8An0o4fCVSZ3gr2+rHwiA@mail.gmail.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Sun, 27 Jan 2019 11:08:42 -0800
Message-ID: <CAPL8Ziuce2D4iLzkAguzjVvLq8iZXxE_UwxtU7TVKB0D7bG-dA@mail.gmail.com>
Subject: Re: [PATCH 2/8] evolve: Implement oid_array_contains_nondestructive
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Stefan Xenos <sxenos@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 11:51 AM Stefan Beller <sbeller@google.com> wrote:
>
> On Mon, Jan 21, 2019 at 2:32 PM <sxenos@google.com> wrote:
> >
>
> > evolve: Implement oid_array_contains_nondestructive
>
> I'd think I would word this
>
>     sha1-array: implement oid_array_contains_nondestructive

Good point. Done.

> as for this patch it is not relevant what we we'll be using it for
> later, but rather that it touches the oidset class?
>
> > From: Stefan Xenos <sxenos@gmail.com>
> >
> > Implement a "contains_nondestructive" function for oid_array that won't
> > sort the array if it is unsorted. This can be used to test containment in
> > the rare situations where the array order matters.
> >
> > The function has intentionally been given a name that is more cumbersome
> > than the "lookup" function, which is what most callers will will want
> > in most situations.
>
> What about naming it oid_array_linear_lookup instead?
> That would still have the common "lookup" in the name and
> the "linear" should be enough to scare away the casual
> user. The non-destructive sounds scary.

It probably shouldn't contain the word "lookup" since the lookup
method returns an index and this new method returns true/false. I
changed it to oid_array_readonly_contains.

> Missing sign off

Thanks!
