Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A821C1FAFD
	for <e@80x24.org>; Sat,  4 Feb 2017 03:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbdBDDQB (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 22:16:01 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34715 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbdBDDQA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 22:16:00 -0500
Received: by mail-lf0-f65.google.com with SMTP id q89so2869144lfi.1
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 19:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EpRg74smVUnEWE/ZNDD0U+/9Nax+zfT90X9C9UPFegY=;
        b=aVs+2HbNDuW6LwuP1P0x1Lz3arfzE+G/XCPkCojb8xJr5aCPN3m77YZW67E+rRvtn+
         630qPlVQ+l3N28fiWGmI564uzRLRFb/XXJq/m6Fk4SL6fwbfOqEqzP5LY+LHT1cIxtXr
         eZyBZ/+EQTcwto/jNBS2M0/OKCqCdWRHbC/gwMQz+xJi8G5QXIAqMF3Mgwo7qdblYSYI
         wtkM9KxHccOD05uJ17rsRtNdgxbg59jfRR4c7CW6uo2gaAVGQOV3GoYCHMSRxuQXV4ok
         wN8OjpGpkJtl1j42GiwHuLblnn8MbkIZY0526X0mqVZB9aF3b8AqtzyF1Ch7vNGHQf/h
         9f+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EpRg74smVUnEWE/ZNDD0U+/9Nax+zfT90X9C9UPFegY=;
        b=clLxEgF366JxkbA9TuJqNTGMJWYeAqUGtkIEGR46XwCzaXobuTJRnSjotBNEpq2191
         YCfv5mo5b1pwqcejgJ3TFUuMe/JUgn6+1Hukd8NzXpNsDgFU038UBhPpsuHrGCwnG2QM
         SlVogBgsUtvROqbPtULcUdFobYDd5hpwRgSusyysyOmH1RUzR3X28pfwLLKbTpES8lwt
         45KiUauqBaGPjVl+NW7YT3siYkOxQohNa2fnSv/aDlZfHr+gLDGqF0j1HvZkMxnSi4sF
         2qb3Zbp6C7zpeLCzVM9vvAlDD6QeISnBWqELR0Io0avahTBVRNNB0lSs5eqWciGTnfp4
         VjYQ==
X-Gm-Message-State: AIkVDXIAoC6GfdBgpEeQuxijwgMfDfxzL4PmO59t+ch5vD1MqkGmwe6lYQbvEdzeFNSvkiE7jp9iZ4+Q4gbj6A==
X-Received: by 10.25.75.79 with SMTP id y76mr97048lfa.143.1486178158858; Fri,
 03 Feb 2017 19:15:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Fri, 3 Feb 2017 19:15:38 -0800 (PST)
In-Reply-To: <CA+P7+xqhjVQMXtO4gtQ_2VAVd3qrpVLncH6YpFHreVV2mHORxg@mail.gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com> <CA+P7+xqhjVQMXtO4gtQ_2VAVd3qrpVLncH6YpFHreVV2mHORxg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 3 Feb 2017 19:15:38 -0800
Message-ID: <CA+P7+xpeyebN3pmSX09Avh1EvYVjALpBCQ9r2==q3SWTu3GMSw@mail.gmail.com>
Subject: Re: [PATCH 00/12] completion: speed up refs completion
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2017 at 8:15 PM, Jacob Keller <jacob.keller@gmail.com> wrote=
:
> On Thu, Feb 2, 2017 at 6:53 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>> This series speeds up refs completion for large number of refs, partly
>> by giving up disambiguating ambiguous refs (patch 6) and partly by
>> eliminating most of the shell processing between 'git for-each-ref'
>> and 'ls-remote' and Bash's completion facility.  The rest is a bit of
>> preparatory reorganization, cleanup and bugfixes.
>>
>> The last patch touches the ZSH wrapper, too.  By a lucky educated
>> guess I managed to get it work on the first try, but I don't really
>> know what I've actually done, so...  ZSH users, please have a closer
>> look.
>>
>> At the end of this series refs completion from a local repository is
>> as fast as it can possibly get, at least as far as the completion
>> script is concerned, because it basically does nothing anymore :)  All
>> it does is run 'git for-each-ref' with assorted options to do all the
>> work, and feed its output directly, without any processing into Bash's
>> COMPREPLY array.  There is still room for improvements in the code
>> paths using 'git ls-remote', but for that we would need enhancements
>> to 'ls-remote'.
>>
>> It goes on top of the __gitdir() improvements series I just posted at:
>>
>>   http://public-inbox.org/git/20170203024829.8071-1-szeder.dev@gmail.com=
/T/
>>
>> This series is also available at:
>>
>>   https://github.com/szeder/git completion-refs-speedup
>>
>
> Nice! This is something i've been bothered by in the past since
> completion would take a rather long time!
>
> Regards,
> Jake

I haven't had a chance to further investigate, but I tried this series
out (from your github) and it appears that this series (or the
previous series for __gitdir work) breaks "git log" ref completion.
I'll have further details when I am able to investigate a it more.

Thanks,
Jake
