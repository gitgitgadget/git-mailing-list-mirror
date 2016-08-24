Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2D81F6C1
	for <e@80x24.org>; Thu, 25 Aug 2016 04:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755587AbcHYEzD (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 00:55:03 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:36662 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755671AbcHYEyn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 00:54:43 -0400
Received: by mail-yb0-f173.google.com with SMTP id e31so12913636ybi.3
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 21:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UbNbnyTXWi0zYGrJ0/f8ZDUJywVCUEvQr1pscGVkHd4=;
        b=YQjkrXf0wLw9WVi7RbL83D5DMXw/YWADGjceLdRb85vu8538wNC0ILNCfBzKeIwJSL
         MbsQeCTOawbF81jo2/lCTAfxeG/7oejBu0K7TwDqdm+8qzrEwg6ryg5TK2xV1Zn5jT52
         NNhi+WtdIO80Qlnhoyu/k1RwTrMx+Q68l8EZBHfMJDgy0yZG8n67HCkthTCnexKV+BbF
         yHjWJStVtiahyHSORIYlTomoXDs9ee19SEhzDXhCJ1o1QcE7YGsbIU7rwsHFnOXBc7p7
         eNWbE/TBq0bjvTz3WBv8AOtqLKYqoB02hmlpFtMHftCo6UQlVuQUX7ZOAYPgXXuZgVMc
         Q5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UbNbnyTXWi0zYGrJ0/f8ZDUJywVCUEvQr1pscGVkHd4=;
        b=XDmeqInEY16djVUiMT94d4/5Wo8+M7AkwmVx4m2LUgkJY1LcXHaDuIfRrMkFaHVqPd
         o4SPINLdwU7x66OFB5v2ozHwI5SRHd6iMuI2brqycqn6mgEyc3A6TzOJV9quVgef4MIl
         txisSzLrjmh3Id2ARUZP0wFSbxvu2TL2GofhTJOk+mZH682SNDd50C40PA8CzguEU44h
         DzELy6bQTsLi0AV2mM1ptnL5bM7WIRBuGJOJWGnrg5aMvYyPZCNgNWSJKq2k96jMPJTH
         fQsRNUAYwTTHrQ/0b5d2vdQHeJ/lPsMgGBjj3RnsiT260bUQbBaN0SFhFhPoB/JPHwRh
         jfrg==
X-Gm-Message-State: AEkoousFlIWrl1unJx63I8F+jI7rB8lAxHJiy790Ake3VjgMz7KfCCgXSdbk835g0rnKx3iOhyAyfweUCQe2qw==
X-Received: by 10.37.197.211 with SMTP id v202mr4521265ybe.15.1472081869587;
 Wed, 24 Aug 2016 16:37:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Wed, 24 Aug 2016 16:37:29 -0700 (PDT)
In-Reply-To: <CAGZ79kah4sY0NJkaqDiUqcwsCHn0SECkMjN8SoXQ8vGi6zRkuw@mail.gmail.com>
References: <20160815215327.15682-1-sbeller@google.com> <20160815215327.15682-9-sbeller@google.com>
 <CA+P7+xpDqkTFLUJBhSwWiVnXw-iy1fmGBWzVBLmybOcPOmevBw@mail.gmail.com>
 <CAGZ79ka6nwYjBRcUKAxCqAodq=Hw6f86J0Mq6GWyKgMO_PNi4A@mail.gmail.com>
 <CA+P7+xpmyx+QsdOpS7JC1i9Z6cdsy_=MK7J_rGYiukPsqAJBVQ@mail.gmail.com> <CAGZ79kah4sY0NJkaqDiUqcwsCHn0SECkMjN8SoXQ8vGi6zRkuw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 24 Aug 2016 16:37:29 -0700
Message-ID: <CA+P7+xrokr0ZGidQFuvpN+-J_WDjkaUropcnPGVjZHafc12AnQ@mail.gmail.com>
Subject: Re: [PATCHv5 8/8] clone: recursive and reference option triggers
 submodule alternates
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 3:52 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Aug 23, 2016 at 11:29 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Tue, Aug 23, 2016 at 4:03 PM, Stefan Beller <sbeller@google.com> wrote:
>>>>> +
>>>>> +       if (option_recursive) {
>>>>> +               if (option_required_reference.nr &&
>>>>> +                   option_optional_reference.nr)
>>>>> +                       die(_("clone --recursive is not compatible with "
>>>>> +                             "both --reference and --reference-if-able"));
>>>>
>>>> So if you have multiple references that don't all match we basically
>>>> just refuse to allow recursive?
>>>>
>>>> Would it be better to simply assume that we want to die on missing
>>>> references instead of failing the clone here?
>>>
>>> The new config options are per repo (or even set globally), and not
>>> per alternate. And as we communicate the [if-able] part via the config
>>> options to the submodules it is not feasible to transport both
>>> kinds of (reference-or-die and reference-but-ignore-misses).
>>>
>>> That is why I introduced this check in the first place. If we'd go back
>>> to the drawing board and come up with a solution that is on a
>>> "per alternate" basis we could allow such things.
>>>
>>>> That is, treat it so
>>>> that multiple reference and reference-if-able will die, and only info
>>>> if we got only reference-if-able?
>>>>
>>>> Probably what's here is fine, and mixing reference and
>>>> reference-if-able doesn't make much sense.
>>>
>>> I think the reference-if-able doesn't make sense for one project alone
>>> as you can easily script around that, but is only useful if you have
>>> submodules in a partially checked out superproject that you want
>>> to reference to.
>>>
>>> Thanks,
>>> Stefan
>>
>> I'm not sure there is a better design.  How are alternates stored? In
>> a config section?
>
> Alternates are stored in .git/objects/info/alternates
> with each alternate in a new line. On that file (from
> (man gitrepository-layout):
>
> objects/info/alternates
>
> This file records paths to alternate object stores that this object store
> borrows objects from, one pathname per line. Note that not only native
> Git tools use it locally, but the HTTP fetcher also tries to use it remotely;
> this will usually work if you have relative paths (relative to the object
> database, not to the repository!) in your alternates file, but it will not work
> if you use absolute paths unless the absolute path in filesystem and web
> URL is the same. See also objects/info/http-alternates.
>
> So changing that file is out of question.
> Ideally we would have a flag for each path here, though.
>
>> Or is there some way we can store the is-able per
>> alternate and look it up when adding them to submodule?
>
> I guess we could invent a file as alternate-flags that is matches
> line by line to the alternates file.
>
> I don't think we'd want to go that way for now as it would really only
> help in an edge case?
>
> If we later find out we need the flag on a per-alternate basis we can
> still come up with a solution and just not set these config variables,
> so I think we'll be fine for now with this approach.
>

Yes that seems reasonable.

Thanks,
Jake
