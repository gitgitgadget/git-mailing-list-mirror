Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B60C54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 16:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0371E206DD
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 16:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="HHi4uCfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDZQSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:18:02 -0400
Received: from avasout03.plus.net ([84.93.230.244]:48607 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgDZQSB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 12:18:01 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id SjyfjIuqPNXR9SjygjBuL4; Sun, 26 Apr 2020 17:17:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1587917878; bh=k1acWshBfAvUbXia676Ln1T0EwKHoNwgIHIU1Sg9oYU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HHi4uCfb3EIeC2s0XQNGU2g9rtZlTcoxHOkEL7bqrATVvuRmwaX1AMlVmKUOssmfA
         asjq7phJ8/oDu7iTLQciN9FsiXBJzn1JGiY3zSK4zkzVKyJRlaXpctCE1SE0dwDVcs
         oUW9i/aZBjX1nafnPP7NvfqNLixkUBRZnNHZN2rQH5oaJkvQXOUC7n5OuwUrciqNP6
         FlvI7A16VDTSc19QeYWvo7lr15ySCGykZ7Ay3QK1iVXa+VRmVC390J1gKp6jBLR1oB
         hOeGIHTXpPipD9rwMUtzpBfRpR8vdsrnjGUemj7LbggIrf1gugJ3X+V4ZL/7Nw8KD8
         PoeikEQzdX+Mw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Et9JURUA c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5KEJ3k9QAAAA:8 a=0zWQGpc3VLsO9O32o5AA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=olg2BfGzmf2haRflzj8J:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 2/4] compat/regex: include alloca.h before undef it
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <cover.1587740959.git.congdanhqx@gmail.com>
 <290ba923b5ee5bcaa4801454b6692deb532bd681.1587740959.git.congdanhqx@gmail.com>
 <820d44c5-5852-fa83-a814-8e58dd120565@ramsayjones.plus.com>
 <20200424170916.GA29153@danh.dev>
 <0bee8daa-99d0-4939-e225-8783bc0457f8@ramsayjones.plus.com>
 <20200424223440.GC721@danh.dev>
 <ffcaaf4f-a43f-2d20-b70d-dfb8b1d7c687@ramsayjones.plus.com>
 <20200426005451.f7pyoiijgbk4hpsj@danh.dev>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <e9163e0d-2572-e7e0-6aa3-09ce04750b22@ramsayjones.plus.com>
Date:   Sun, 26 Apr 2020 17:17:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426005451.f7pyoiijgbk4hpsj@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEvon5uM90b+CCq5S0x57nrVi6LoDayWOK0cnOn2fquFbbAFAdbg7IvUYu2ZWYmobt/3itadk8MP0cvSgDRnWEal0JbrA0af9a4SKGf7CWfnuw4ZnViv
 vI0oWCWb2VYy6NtTIIt/3v6a2Iw5M+bFH58+MANh63bFN/24ebE8aj9rDxfEkbj3RA6lQ1lOyQVt+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26/04/2020 01:54, Danh Doan wrote:
> On 2020-04-25 21:28:05+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
[snip]
>> OK, I had a quick look at the <alloca.h> header file on a glibc
>> system (linux) and new-lib system (cygwin) and they both do
>> (more or less) the same thing: first #undef alloca, and then
>> if being compiled by gcc, define alloca(size) to be __builtin_alloca(size).
> 
> musl people don't do that.
> They just go ahead define it, if any other header file requires
> alloca, they will include alloca.h
> 
>> So, even if <alloca.h> is #included after regex.c:66, it wouldn't
>> be a problem. Since I don't have access to a musl based system,
>> I don't know what that system header is doing.
> 
> musl's alloca.h is available here:
> 
> https://git.musl-libc.org/cgit/musl/tree/include/alloca.h

Hmm, OK, so that partly explains the problem. I wonder if the
musl guys would accept a bug report?

>> However, I said *even if* above, because I don't see why it is trying
>> to #include <alloca.h> in the first place! ;-)
> 
> I looked into my system again. The inclusion chain is:
> 
> compat/regex/regex.c:77
> `-> compat/regex/regex_internal.h:26
>     `-> /usr/include/stdlib.h:138 [*1*]
> 
> [*1*]: https://git.musl-libc.org/cgit/musl/tree/include/stdlib.h#n137
> 
> I don't know why _GNU_SOURCE and/or _BSD_SOURCE is defined.

... and this explains the main cause. Hmm, as you say, why are
one (or both) of those pp variables set. :(

[snip] 
>> BTW, why are you compiling with NO_REGEX set anyway?
> 
> Because I use musl-libc, and musl-libc doesn't have StartEnd

Ah, OK. ;-)

Well, even if the musl project accepted a PR and provided a fix, that
will not help you in the short term! :D

Hmm, whatever patch you decide to send (even the original one) I think
you need to add an explanation of the problem to the commit message,
including why the patch provides a solution. (You don't have to type
a novel - see commit bd8f005583 :-P ).

I haven't thought about this too much, but some options:

  - iff the musl library sets some kind of identifying pp variable
    (_MUSL_LIBC_ or somesuch - I haven't looked), then you could
    make the '#include <alloca.h>' conditional on that variable.
    This has the benefit of making it obvious to people reading the
    code that this is specific to musl-libc.

  - you could simply remove that '#ifdef GAWK' block completely (Lines
    64->67). We set GAWK and NO_MBSUPPORT  unconditionally in the Makefile
    so that it compiles (see commit a997bf423d), but these particular
    lines simply reflect the gawk projects dislike of alloca (along with
    the desire to catch any attempts to add new calls which are not protected
    by HAVE_ALLOCA). Given that we are very unlikely to add new calls ...

  - change the conditional on this block to (totally untested, just typing
    into my email client) '#if defined(GAWK) && defined(HAVE_ALLOCA)'.
    This should work, but it does disable the 'catch any attempts to add
    new _unintentional_ calls' aspect of that block; so you may as well
    remove it ...

Just some 'off the top of my head ideas', ... ;-)

ATB,
Ramsay Jones


