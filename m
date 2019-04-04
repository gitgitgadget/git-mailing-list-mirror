Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6B820248
	for <e@80x24.org>; Thu,  4 Apr 2019 09:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfDDJm3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 05:42:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39471 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbfDDJm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 05:42:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id l7so1477042ljg.6
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 02:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7mcHUrm7mH3yk4uEuOCryMC0CXREQxgOF1scABkz7MY=;
        b=CMc3T6UGp6i1/LXtl7xVuGN9POfG+R+UTlzue9Xt/82rlGK8Ab4telJAdDK5mEBMi2
         iy7LH+TTlpwHeNsnKOtB4JRS957D9UWX9vu/ntgeuMdo8ysW5nE4FGYzktsQm+tHp/8Y
         noUp7X0LGkyFZ2/DAl7+HirfcUBwe3W1pro6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7mcHUrm7mH3yk4uEuOCryMC0CXREQxgOF1scABkz7MY=;
        b=sWg4adOObK0rajsYPmK9+Wg0z7nSe9pVr8+Of1ZYaV/UVA6/9akvoGwgGrUZCjNCCR
         +/gKjrWwgxmnFj/EcRad8H5RF3Eq+kcrabSJSESa8lZvIyDZaCjzcO4XXbj5q0ocBvaf
         eExuSRj3S4pv24RkvCy2uhki0frItDmCZgVpa6MfJsX2ZeruLbaut2PLuiiv9m2DmUEw
         LgnG0BlfXhWZmk+EIIGAN4Tqyt/Qcq0/82zSljTnulTNTCmti6vt2ybzG5f8X2L+O/87
         qCXG+9FXiGH8PlAjJPXW/aSM3MltsKUi61vnXAjNw4rM7dm90kCpZkkNtNfocH5Sxtdn
         GXSg==
X-Gm-Message-State: APjAAAUOXoWjYhf5r+Ld1FdDFqjuYISFbBcX1PDhjMW96hEgpIPU+PGf
        n0TG87tyqawcdQezAR4hsqPD0XIZ/8/ESp8/
X-Google-Smtp-Source: APXvYqxTZYQUNsMsHo8O4JGIQaQV16P5CjF2W9FgODB/R43J4kEqbv2YlyB2MPI7FaDqWbGPFP0xdg==
X-Received: by 2002:a2e:1311:: with SMTP id 17mr2826634ljt.75.1554370945218;
        Thu, 04 Apr 2019 02:42:25 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s16sm2613455lji.61.2019.04.04.02.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 02:42:24 -0700 (PDT)
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
To:     Baruch Siach <baruch@tkos.co.il>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Joe Perches <joe@perches.com>, git@vger.kernel.org
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
 <bc20070b-437a-9875-efd0-b4cad1413233@rasmusvillemoes.dk>
 <604795fe60991f22273cbb652eeeedc17985bc65.camel@perches.com>
 <xmqqh8c03dcz.fsf@gitster-ct.c.googlers.com> <874l7ekynt.fsf@tarshish>
 <xmqqk1gaf7oe.fsf@gitster-ct.c.googlers.com> <87zhp6jf2o.fsf@tarshish>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Message-ID: <dd8160f8-0e5e-1024-53c1-1a9f23423af5@rasmusvillemoes.dk>
Date:   Thu, 4 Apr 2019 11:42:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87zhp6jf2o.fsf@tarshish>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/04/2019 11.27, Baruch Siach wrote:
> Hi Junio,
> 
> On Thu, Apr 04 2019, Junio C. Hamano wrote:
>> Baruch Siach <baruch@tkos.co.il> writes:
>>
>>>> Independently, I think it makes sense to do something like
>>>>
>>>> 	/^([a-z][a-z-]*-by|Cc): (.*)/i
>>>>
>>>> to tighten the match to exclude a non-trailer; that would have been
>>>> sufficient for the original case that triggered this thread.
>>>
>>> Is there anything I need to do more to get this fix applied for the next
>>> git release?
>>
>> Get "this" fix applied?  I think we should tighten the regexp to
>> exclude a non-trailer, which would have been sufficient for the
>> original case without anything else in "this" fix.  So in short, I
>> do not think "this" fix won't be applied without further tweaking
>> ;-)
> 
> This is exactly what "this" patch (referenced in the title of "this"
> thread) is doing:
> 
>   https://public-inbox.org/git/eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il/
> 
> Am I missing something?

My ack for Baruch's original patch, which AFAICT is identical with
Junio's suggestion, still stands. FWIW, I'm against Joe's suggestion of
stopping at a line matching /^---/, since it's not unlikely somebody
does something like

---- dmesg output ----
bla bla
----

in the commit message.

Since all lines (except for some of the diff header lines) in the patch
part begin with space, - or +, insisting on a the line starting with a
letter should be sufficient for excluding any random Foo-by lines that
may appear in the patch part.

Rasmus
