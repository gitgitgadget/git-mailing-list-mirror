Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 667F81FD09
	for <e@80x24.org>; Wed, 31 May 2017 14:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751105AbdEaORr (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 10:17:47 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:37419 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbdEaORq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 10:17:46 -0400
Received: by mail-it0-f52.google.com with SMTP id g126so12255263ith.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 07:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=txJmKq0+P2e1DTIT06HZ6NEbuiVOj/lBhBHSXdlCvu4=;
        b=HCPKvPAF3CsvUr3jv55Ke3iw879Ideb9kZ1A60CblvIRx94LZ4s6q55xFlY4iq0WVK
         8bX6A6WqO5gaaqgARn+m3GF3ZfrcvtlktmXx1SgxwuDUwdtPxc6xRvfhxlKhXoNR4jgC
         URugawLQsSUmU4fOwm4kTavUVldwrx13qIicSNc0PchFp/uaYwM8i7y1oeotyypKoxkO
         UP7tSPd85K3BJHKtaBsBP9tCDfjK926D9gBjnez1vyfE4bWoJCUcgPTEVITY2c+t35VE
         QSD54CAlkYIa5QVLR5hHRiDG8KFB8+jmgGDHHebWa6nZVRI6ylNGCMF8Udrok6eOTwwt
         05nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=txJmKq0+P2e1DTIT06HZ6NEbuiVOj/lBhBHSXdlCvu4=;
        b=KgPyQw6mgMuUjCuAp+GuQOq6Pt+tuMgpXM1V/S0Cz3gfKCKQxEgvkxwrs/nxWMIVVd
         ViU/fgRjTDGYCWKzNcMT8V6g6ORNzoxCAWIOhqTqhcUg+EhacbBqBKS9cHk8oiAt+TFp
         Egdun+2xs0W9Yjh/LRgEapiAVJ+6KVMuYTxRiAqPYNKriFsywTS4HblPiext3IjjtbLo
         DIwzxuAerTsN4bQXUbP0QyI5a5t2OxMhskHXlAo7Nt677YybJyCSrNgs8kGZ3y1ThYZ8
         bYFIjdRO5o2Bv0D/cyFIngzNTKqoiDSgo9wvhCPOJFBK8Mkb1Ou7mM19fh5hW3DNiJui
         GfVw==
X-Gm-Message-State: AODbwcBKoWEkdksNowtd9FSSEZa5qDYWFkkW4W0nMH9Sfm7JNfURtLUv
        1o08o0TlyW5qS6W0igzFhjpRpq6apWX8
X-Received: by 10.36.91.212 with SMTP id g203mr7158592itb.94.1496240265711;
 Wed, 31 May 2017 07:17:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 31 May 2017 07:17:25 -0700 (PDT)
In-Reply-To: <CAM0VKjmz7MpVt3oPBuwHiXNoLkZmdmrZ66ggk+aY5-4oVkE35A@mail.gmail.com>
References: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170530071244.32257-1-szeder.dev@gmail.com> <20170530071244.32257-2-szeder.dev@gmail.com>
 <CACBZZX740rcQKnfkRXgn0+fmeUDaWL-Kz5WzKeyUvBhXWPwPhg@mail.gmail.com> <CAM0VKjmz7MpVt3oPBuwHiXNoLkZmdmrZ66ggk+aY5-4oVkE35A@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 31 May 2017 16:17:25 +0200
Message-ID: <CACBZZX6rczNtCLkxELZ0ETRhuKjf9Hma7AY420BXh0QwfopvgA@mail.gmail.com>
Subject: Re: [PATCHv4 2/2] Documentation/clone: document ignored configuration variables
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 10:50 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
> On Tue, May 30, 2017 at 11:01 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Tue, May 30, 2017 at 9:12 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com=
> wrote:
>
>>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
>>> index ec41d3d69..4f1e7d4ba 100644
>>> --- a/Documentation/git-clone.txt
>>> +++ b/Documentation/git-clone.txt
>>> @@ -186,6 +186,10 @@ objects from the source repository into a pack in =
the cloned repository.
>>>         values are given for the same key, each value will be written t=
o
>>>         the config file. This makes it safe, for example, to add
>>>         additional fetch refspecs to the origin remote.
>>> +       Note that due to limitations of the current implementation some
>>> +       configuration variables don't take effect during the initial
>>> +       fetch and checkout.  Configuration variables known to not take
>>> +       effect are: `remote.<name>.mirror` and `remote.<name>.tagOpt`.
>>
>> We should add to that: "Instead supply the --mirror and --no-tags
>> options, respectively".
>
> I don't think we can do that in this patch right now.  This topic
> branches off from c3808ca69 (preparing for 2.10.3, 2016-12-05), I
> assume because, as a bugfix, it will be included in maintenance
> releases for older releases, and those won't have the '--no-tags'
> option.  Perhaps as a follow-up, only on master.

Sorry, my misunderstanding. I didn't think we'd be updating docs like
this in maint releases, thought this was for to-be-2.14.
