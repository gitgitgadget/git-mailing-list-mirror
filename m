Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 330DD1FCA5
	for <e@80x24.org>; Sun,  1 Jan 2017 17:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932244AbdAARlL (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 12:41:11 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:35679 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbdAARlL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 12:41:11 -0500
Received: by mail-it0-f66.google.com with SMTP id b123so46317107itb.2
        for <git@vger.kernel.org>; Sun, 01 Jan 2017 09:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MvJ8WJMHfU7xxyR/gSjKhGSJ8wvPF6dP+bOP8eg8WOs=;
        b=bGDmLZYtJ5fx/tFyn4+nV2Wj3faqcfcJsUiKBjQUHrBC88DwOF3bigQ46jyUHYy6uy
         loRAYUzhlTz4Dd/IFFbgsK+Nw0jEO9vQ2XS7qRjdhmRp0Aki1vEH52PDKaGaAgMyzBhu
         Ha/lYoVpA6KK+abdKntaTjnIiYWFN0Xzhn8lBN5vxL3+kIwGAhbsZdOT6fPCp+Z1ZMJz
         /+nKWqODUFSwi1HeK/y3/K0aCE8DcfnLvPabcfTo6qOs5a/aqogwqH+3ydR1vJpi8h2q
         9Z8QXiKGx7MaqhBrGh9zo4/04cw3RgDGwY3sJhueTQhvzlna/Gx6yUBPHB7OyboRil2u
         9UQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MvJ8WJMHfU7xxyR/gSjKhGSJ8wvPF6dP+bOP8eg8WOs=;
        b=DCtd/uwE/eAxpmyQ89EAL6/gMWRTeyD1pOLf2gbdQdCoOGa+fbFOJWl6v/QPeljzJ3
         6A+QXHguBUWxhkNady8XXcsZou/66ZwHyuDsEu8ZFRgFxtVCTgkrZOcXBrnch3qZoNoN
         iNnWtqv8w0R2wt7ODy4T0h8cEOsKROziJW1r85Zf/ye24Q0DbqsGdP5CZ1AZMWvey/1H
         JDVwW4qWhgxrgm00rjnyQCOLOhlVzwas0xQUPfmvOt9bEwPAYbit1BLA5AnfHWkw0Uuj
         6y+eMDPSZrIuPfRmm9mOyp5Pa+X9EIpJBpBlgK31CEh5AHHELtMcUY6PZT14WISYE9Ed
         HhZg==
X-Gm-Message-State: AIkVDXIDlh7Fz2xd1XHCvVjlF1e9cVgEMQais4RSvv3DCnrKCp7EQRLXpV6AyXiiHj/yIG7Cubb3Ej1bom/yiw==
X-Received: by 10.36.73.134 with SMTP id e6mr14906738itd.60.1483292470287;
 Sun, 01 Jan 2017 09:41:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Sun, 1 Jan 2017 09:41:09 -0800 (PST)
In-Reply-To: <cdf41dcc-bdc5-a3a7-8d39-8b85e01cda85@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1af0-5d688c2e-868d-4d8c-a8fd-9a675f7f01da-000000@eu-west-1.amazonses.com>
 <06402c8a-14a4-3d70-8d98-659cfe9f1aa2@gmx.net> <CAFZEwPPtF5P5nGp+=btHtwNm1unTJ7qo1khJHCqLvNn1=RYAUQ@mail.gmail.com>
 <cdf41dcc-bdc5-a3a7-8d39-8b85e01cda85@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sun, 1 Jan 2017 23:11:09 +0530
Message-ID: <CAFZEwPN1yFjSxGjHP6BmF8huaVuiipGfWxdFy4fc1hapxd+qCA@mail.gmail.com>
Subject: Re: [PATCH v15 15/27] bisect--helper: `bisect_next` and
 `bisect_auto_next` shell function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Sun, Jan 1, 2017 at 9:57 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
>>>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>>> @@ -643,6 +794,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>>>                        N_("print out the bisect terms"), BISECT_TERMS),
>>>>               OPT_CMDMODE(0, "bisect-start", &cmdmode,
>>>>                        N_("start the bisect session"), BISECT_START),
>>>> +             OPT_CMDMODE(0, "bisect-next", &cmdmode,
>>>> +                      N_("find the next bisection commit"), BISECT_NEXT),
>>>> +             OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
>>>> +                      N_("verify the next bisection state then find the next bisection state"), BISECT_AUTO_NEXT),
>>>
>>> The next bisection *state* is found?
>>
>> checkout is more appropriate. I don't remember why I used "find".
>
> "checkout the next bisection commit" maybe?

Seems better. Thanks!

Regards,
Pranit Bauva
