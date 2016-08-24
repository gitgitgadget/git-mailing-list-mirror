Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213CB1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 22:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932591AbcHXWw4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 18:52:56 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:37515 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932337AbcHXWwz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 18:52:55 -0400
Received: by mail-it0-f54.google.com with SMTP id f6so61187986ith.0
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 15:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ukbvegAAWb2SYKq6xeQOZ+jQbGavdjlLWTcGbFIJEHA=;
        b=h0bsEhcA5c+LpXSMuTbzdGVSL96qZMMA92N3jnu7x/P7sNTHV6Y2QuKS0Vz2yj3PDl
         BsqCx7S8aYITupGnpwXs0P1p3OTkcLsjUswn5d2zQkY/GDkrig9jEM+tfYkyhKKlhV4T
         yyCczQj2TC2zRRDnLLugqDsLRwyizdaiUpdZjatKtpq4Pl1423GWOwk2SqgvGS7QTSg1
         U6TO8tSz8wglSu/hQgLXwGMNte9dBGuLJhB8PdXDg4ldlpqwnjQGbe1SXYopPVQaDyYB
         vBBYj3PQOlckIPtiS3rkWtv0/TTz0xA1K17DUnJ7r/9oQdpLLEzgRSBWZpUvMfP36ben
         5NHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ukbvegAAWb2SYKq6xeQOZ+jQbGavdjlLWTcGbFIJEHA=;
        b=XjHi5OypuRXsX0j0LXr++DsHnmT0IG6/uML7uDwIPD7wrIyIyZZY++fpwD7p10eeBg
         kk6NfNh3WjEnDUMyDIyhlqWhJFDWp1u8Qtdqmhc2Fr14m2x6TFC0J61hADa58B+0PaBO
         5L+Ja21MGUfkO0mTRIbPQb9QEIxvlkVYbcUDL35quakG+MYsG3mHZg5dAf/h1yCAlXsV
         QuOEbC8Yxl3uV2fzJrVdYMe/JhvXGe7RAuVXlm1DOBQ2Eopx5zSA+X8j5NOTWBGGbBrb
         yYCfxDyoGSUmLeoz69SwvqKl3bMsSphKcImkqYUOj2fFLTA5ptS73GLTg1m0WM//1zHC
         sgvA==
X-Gm-Message-State: AEkoouuW/6oBuo74HQGhxyLFHxcZB/Isx3XJUgussHATuj1JXVuflR+KruX8aOTMeCCJA2BmBS01ebGwxAtaUVCJ
X-Received: by 10.36.217.9 with SMTP id p9mr1613581itg.46.1472079174162; Wed,
 24 Aug 2016 15:52:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 24 Aug 2016 15:52:53 -0700 (PDT)
In-Reply-To: <CA+P7+xpmyx+QsdOpS7JC1i9Z6cdsy_=MK7J_rGYiukPsqAJBVQ@mail.gmail.com>
References: <20160815215327.15682-1-sbeller@google.com> <20160815215327.15682-9-sbeller@google.com>
 <CA+P7+xpDqkTFLUJBhSwWiVnXw-iy1fmGBWzVBLmybOcPOmevBw@mail.gmail.com>
 <CAGZ79ka6nwYjBRcUKAxCqAodq=Hw6f86J0Mq6GWyKgMO_PNi4A@mail.gmail.com> <CA+P7+xpmyx+QsdOpS7JC1i9Z6cdsy_=MK7J_rGYiukPsqAJBVQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 24 Aug 2016 15:52:53 -0700
Message-ID: <CAGZ79kah4sY0NJkaqDiUqcwsCHn0SECkMjN8SoXQ8vGi6zRkuw@mail.gmail.com>
Subject: Re: [PATCHv5 8/8] clone: recursive and reference option triggers
 submodule alternates
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 11:29 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Aug 23, 2016 at 4:03 PM, Stefan Beller <sbeller@google.com> wrote:
>>>> +
>>>> +       if (option_recursive) {
>>>> +               if (option_required_reference.nr &&
>>>> +                   option_optional_reference.nr)
>>>> +                       die(_("clone --recursive is not compatible with "
>>>> +                             "both --reference and --reference-if-able"));
>>>
>>> So if you have multiple references that don't all match we basically
>>> just refuse to allow recursive?
>>>
>>> Would it be better to simply assume that we want to die on missing
>>> references instead of failing the clone here?
>>
>> The new config options are per repo (or even set globally), and not
>> per alternate. And as we communicate the [if-able] part via the config
>> options to the submodules it is not feasible to transport both
>> kinds of (reference-or-die and reference-but-ignore-misses).
>>
>> That is why I introduced this check in the first place. If we'd go back
>> to the drawing board and come up with a solution that is on a
>> "per alternate" basis we could allow such things.
>>
>>> That is, treat it so
>>> that multiple reference and reference-if-able will die, and only info
>>> if we got only reference-if-able?
>>>
>>> Probably what's here is fine, and mixing reference and
>>> reference-if-able doesn't make much sense.
>>
>> I think the reference-if-able doesn't make sense for one project alone
>> as you can easily script around that, but is only useful if you have
>> submodules in a partially checked out superproject that you want
>> to reference to.
>>
>> Thanks,
>> Stefan
>
> I'm not sure there is a better design.  How are alternates stored? In
> a config section?

Alternates are stored in .git/objects/info/alternates
with each alternate in a new line. On that file (from
(man gitrepository-layout):

objects/info/alternates

This file records paths to alternate object stores that this object store
borrows objects from, one pathname per line. Note that not only native
Git tools use it locally, but the HTTP fetcher also tries to use it remotely;
this will usually work if you have relative paths (relative to the object
database, not to the repository!) in your alternates file, but it will not work
if you use absolute paths unless the absolute path in filesystem and web
URL is the same. See also objects/info/http-alternates.

So changing that file is out of question.
Ideally we would have a flag for each path here, though.

> Or is there some way we can store the is-able per
> alternate and look it up when adding them to submodule?

I guess we could invent a file as alternate-flags that is matches
line by line to the alternates file.

I don't think we'd want to go that way for now as it would really only
help in an edge case?

If we later find out we need the flag on a per-alternate basis we can
still come up with a solution and just not set these config variables,
so I think we'll be fine for now with this approach.

Thanks,
Stefan
