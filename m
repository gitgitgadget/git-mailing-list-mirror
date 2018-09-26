Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993A91F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeI0A5e (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:57:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33815 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeI0A5e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:57:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id q19-v6so2829821edr.1
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 11:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AQmPAo+b7IRvuGuDT15+oF5gKT0jEdrHiJH8FthvgWI=;
        b=Eq6PCpO1YaZlnDdvm27Jai37DMdeyB5L0I/PAEGqj54pG+bk29D3eLM1wvkC/59el2
         FqGJVCOmwg6ftW7QP9Y+eqaN9zPpRomDY7OqQrbNAD42Nbvd7DyYvMyyiO+BijJJpqKk
         /aNVTJ86gC5aGfj+m3E7fsQly+qDQtyDOLMXIwqY4PCkexK1tHFXEkzGlcvrtEuv4+Wz
         8K4D/AJ5pzWk5CdtH+6LuAgNemvOBy6fcrfdqD2sS18Ia64mM4dIAAs0AmZsd532tH0n
         0kb+a/YtviWgz7qEl5q/RjnOHpfznLr0rLYfWQxtlFASynEHAB7nBLKfcQIihDnctkS3
         lu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=AQmPAo+b7IRvuGuDT15+oF5gKT0jEdrHiJH8FthvgWI=;
        b=GgsvK6AmH5vxGDKl9NMfmcYr0G7SyLMwRZShChhm8Fy1tmIPGyhQ36RNdwstqr2CZH
         lpcGBqV6n/eployZqIM0e507Pr5a0s4zcaR5qiJ0PvDgh7ESscSSHtoAH33GUcMJfGY+
         NxNNk7d5adRHJhXITRwl5QGwzJKZiSCQSlfJFIqoQx7366uthLmCO+0hVA3ddHOa+d+1
         aTFwnabm+2up8g2owfcXMW9B7ROfYsEvULOLKe24oyPfc9bl6ywtvVDnPVBFPnelOD4s
         F3bA/zLWAaGqOq7PXiaiabc6wpRRFQT6QlnG2MQxZxdOHPjxYtUQvDekPs26KhUsvt20
         gXVA==
X-Gm-Message-State: ABuFfohN9V2TILdFxf7s3kfTfHAigLuK6/tvqxC+S2msEz6Pts1WVSgm
        BB9FAA2n/JmAsszfL5LxuJ0=
X-Google-Smtp-Source: ACcGV63/t8aeKcasEdtEoLqu9xd6uVFwxmm4YwSt8ybFnrP8g8A28git+34sTV6Jc8v7R1HE1n1AAw==
X-Received: by 2002:a50:d1c7:: with SMTP id i7-v6mr11631752edg.169.1537987395449;
        Wed, 26 Sep 2018 11:43:15 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id b9-v6sm79384edk.62.2018.09.26.11.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 11:43:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
References: <20180921223558.65055-1-sbeller@google.com>
        <20180921223558.65055-2-sbeller@google.com>
        <87h8ihk7sl.fsf@evledraar.gmail.com>
        <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
        <20180926041517.GA2140@sigill.intra.peff.net>
        <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
        <87d0t0jghm.fsf@evledraar.gmail.com>
        <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 26 Sep 2018 20:43:14 +0200
Message-ID: <87a7o4je0t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 26 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Sep 26 2018, Junio C Hamano wrote:
>>
>>> Jeff King <peff@peff.net> writes:
>>>>
>>>> Yes, please. I think it prevents exactly this sort of confusion. :)
>>>
>>> CodingGuidelines or SubmittingPatches update, perhaps?
>>>
>>>  Documentation/CodingGuidelines | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>>> index 48aa4edfbd..b54684e807 100644
>>> --- a/Documentation/CodingGuidelines
>>> +++ b/Documentation/CodingGuidelines
>>> @@ -358,7 +358,11 @@ For C programs:
>>>     string_list for sorted string lists, a hash map (mapping struct
>>>     objects) named "struct decorate", amongst other things.
>>>
>>> - - When you come up with an API, document it.
>>> + - When you come up with an API, document it.  It used to be
>>> +   encouraged to do so in Documentation/technical/, and the birds-eye
>>> +   level overview may still be more suitable there, but detailed
>>> +   function-by-function level of documentation is done by comments in
>>> +   corresponding .h files these days.
>>>
>>>   - The first #include in C files, except in platform specific compat/
>>>     implementations, must be either "git-compat-util.h", "cache.h" or
>>
>> Thanks. I had not looked at this closely and was under the false
>> impression that it was going in the other direction. Good to have it
>> clarified.
>
> Heh, I knew people were in favor of one over the other but until
> Peff chimed in to this thread, I didn't recall which one was
> preferred, partly because I personally do not see a huge advantage
> in using in-code comments as docs for programmers, and do not like
> having to read them as in-code comments.
>
> If somebody wants to wordsmith the text and send in a patch with
> good log message, please do so, as I myself am not sure if what I
> wrote is the consensus position.  It could be that they want to have
> even birds-eye overview in the header files.

While we're on that subject, I'd much prefer if these technical docs and
other asciidoc-ish stuff we would be manpages build as part of our
normal "make doc" target. So e.g. this one would be readable via
something like "man 3 gitapi-oid-array".

They could still be maintained along with the code given a sufficiently
smart doc build system, e.g. perl does that:
https://github.com/Perl/perl5/blob/v5.26.0/av.c#L294-L387

Although doing that in some readable and sane way would mean getting rid
of your beloved multi-line /* ... */ comment formatting, at least for
that case. It would be a pain to have everyone configure their editor to
word-wrap lines with leading "*" without screwing up the asciidoc
format.
