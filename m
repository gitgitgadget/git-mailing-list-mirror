Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0279C1F404
	for <e@80x24.org>; Sun,  4 Feb 2018 02:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbeBDCEm (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Feb 2018 21:04:42 -0500
Received: from mail-ua0-f180.google.com ([209.85.217.180]:46261 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeBDCEl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Feb 2018 21:04:41 -0500
Received: by mail-ua0-f180.google.com with SMTP id j23so16592396uak.13
        for <git@vger.kernel.org>; Sat, 03 Feb 2018 18:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0hSrSiwwKNrKb9s26W0QSTqVOCpP02x+0GDd3eWK5ng=;
        b=tOo7qWIX7r3XTHaRKcRpS3bi7VengL6gGsDcDeuDEDDW0tUTXv2b3kERBB5C1msrA9
         x0Xa5Cekd3bkxtnaWlmmKJ8ciC53OOC29+hbaff77MFpxwhZghbnMiOm7HoOglQaEZ/B
         nGkeMOq8MkBmQf1nRV/aF7BmiY3UJqoATWN6Iz+MnlUuNWwD/GgV/kbRVtjQqXQU5rc8
         2LWck+LozZ22Bjbbm4DHsp3hcqxaF1SE6V3G5AfzXkqDCyT7O6vTNrG6E2kLowDpRLg9
         rye9uHQ1oMyJ4lItkCQzx8iL+LMzEseiJF5ObRhtW5hOGeGCOhgQRYQwsel/jpu2bvgu
         UevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0hSrSiwwKNrKb9s26W0QSTqVOCpP02x+0GDd3eWK5ng=;
        b=Lae2AvxYLPvgkjcgogEk+pw6uvjEDvYKA+NVZnIoC/da9mrpQotShhRo650Yu5kaFQ
         RYDliw103YI7o6NxWRUkvr3tMavyeSiy9y0lpxqN24msxQU3p8mMAlw7rRXrKDuxDBHt
         gXQAGgLIm3LJrFgVBSVhoGMElvTvttTcfRINIUSdhFjYwjSpqyrfVHTT/90DKnBsgzNP
         3klfwjcb2gyvlOJPKWicBqflQfuN4RW64sr/MJJwnOB4MHNyd7VsQXRm/C09gaEhBZc0
         MprQEMoE+Q8fi8Ri+UBMp4KWou4vAGbOIzIleoOfKdAYlqSv7ToxgNMiORjTPIqxUTQh
         WaNA==
X-Gm-Message-State: AKwxytcNzUfxXRKmL5sjC0jEekmEF802Is1tiTmRbGOEAYR5dxIfcVoJ
        Hhdi+9gZevvB2kJ0RgvFf8y7eqxKjBBKYtLLE1g=
X-Google-Smtp-Source: AH8x224e2ntCzr8m4yEkfzmO4TJ0lT56DNUyGClNu7mGdPfMbburkxUgInoQZYoBI96piJ0QLLWy/b3Vqo1CI0SsrJ8=
X-Received: by 10.176.67.4 with SMTP id k4mr20577726uak.55.1517709880100; Sat,
 03 Feb 2018 18:04:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.33 with HTTP; Sat, 3 Feb 2018 18:04:39 -0800 (PST)
In-Reply-To: <CABPp-BGh7QTTfu3kgH4KO5DrrXiQjtrNhx_uaQsB6fHXT+9hLQ@mail.gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-20-newren@gmail.com>
 <CAGZ79kb2+tpr0K0x2VVfFR-u3W2htvbxokxfKBpG60mNjXGPEw@mail.gmail.com> <CABPp-BGh7QTTfu3kgH4KO5DrrXiQjtrNhx_uaQsB6fHXT+9hLQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 3 Feb 2018 18:04:39 -0800
Message-ID: <CABPp-BGwAu7_+BJR+43G2SysmBMnZYEBtHnwjMZBRn5XDPubWg@mail.gmail.com>
Subject: Re: [PATCH v7 19/31] merge-recursive: add get_directory_renames()
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 3, 2018 at 2:32 PM, Elijah Newren <newren@gmail.com> wrote:
> On Fri, Feb 2, 2018 at 5:02 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:

>>> +       while (*--end_of_new == *--end_of_old &&
>>> +              end_of_old != old_path &&
>>> +              end_of_new != new_path)
>>> +               ; /* Do nothing; all in the while loop */
>>
>> We have to compare manually as we'd want to find
>> the first non-equal and there doesn't seem to be a good
>> library function for that.
>>
>> Assuming many repos are UTF8 (including in their paths),
>> how does this work with display characters longer than one char?
>> It should be fine as we cut at the slash?
>
> Oh, UTF-8.  Ugh.
> Can UTF-8 characters, other than '/', have a byte whose value matches
> (unsigned char)('/')?  If so, then I'll need to figure out how to do
> utf-8 character parsing.  Anyone have pointers?

Well, after digging around for a while, I found this claim on the
Wikipedia page for UTF-8:

  Since ASCII bytes do not occur when encoding non-ASCII code points
into UTF-8, UTF-8 is safe to use within most programming and document
languages that interpret certain ASCII characters in a special way,
such as "/" in filenames, "\" in escape sequences, and "%" in printf.

So, unless I'm reading something wrong here, I think that means this
code is just fine as it is.
