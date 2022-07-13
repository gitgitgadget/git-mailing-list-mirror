Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55729C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 18:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiGMSes (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 14:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGMSer (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 14:34:47 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C25201A5
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 11:34:46 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10c0e6dd55eso15076568fac.7
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ryhZdUrvrZxUA7vCEd+sq5IQVO9pXfe3cGt0InKmeRs=;
        b=fSmNfLrirnIybWyvbmkCOi2lQXrEY72QSe7IiDgTGAySg6lljUjKZigyZ1kkMJP45G
         T1wXoQsOwfEpq/vYvMLXWk8wceM9nVgU8XUo0qofjagQ1i7sTnNXo7Y17XKNQFC9Iq5f
         NzX/cXQSd5iw/lJwvvlXMtw4NfQ06YlALoR+PUnhKl27ZUxkZO4rOo6gmdHSZ48H0cq2
         9oCVLPiwyfi5jgfh0hGYhpoK2mXcCDewqocSxOvtJY0yOurb2KSwVML5u0ks4xgTW8G+
         5etFUddVKh2rr0ow0dCHopUo6xEbozgbEnkHGfSA3Mfk4zqIA7ddXsEaeT0gUDjlnROF
         eTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ryhZdUrvrZxUA7vCEd+sq5IQVO9pXfe3cGt0InKmeRs=;
        b=3704WhceV+t4HiX+KisjdnLR8aqIh++sWsVX2nr27H78AMH6FkdfZaE6v2EkOn/6sU
         61UPNtG0SjKOuxwZ+5kLAUFYsPUE2NVEsV/uk9zvf8Q4KWso0ejvfoDoL3fv+GUZmckR
         VT46PQiK2KI0pwg4Za2vwc36UEnA6EKwIsR7kO6PmuEOO2PFprvu8fdAl+ztrDeWOjr+
         GePdRwZ2extExC8dKuS8E1mv2g4V44z8x1dLLDSsdwCyadp1HZ1WrAo0bNiudjdrOF/U
         gfK0XbrwZM5SmHgi6jwEAE8yG5mn2XVPRZgrgZO8/rydOwtiIGQuFBZv2ntR9dfJM26D
         Kw3g==
X-Gm-Message-State: AJIora/1PlymTrYPfLsb4b4fDL/FibcE+S2ZtsLLrd9hlkim1gWza5Ov
        ipQ+ktJYn685bK78Zyv99+eq
X-Google-Smtp-Source: AGRyM1s40KTrgrVzDrChKBkKkbEH3aBvPRijHfREGVtbr3RmJBNU7VgLkFU0hXKzc9jCWNzeTlnFcA==
X-Received: by 2002:a05:6870:e997:b0:10c:66f1:8bbb with SMTP id r23-20020a056870e99700b0010c66f18bbbmr5338545oao.243.1657737286219;
        Wed, 13 Jul 2022 11:34:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3507:5998:f07a:ba19? ([2600:1700:e72:80a0:3507:5998:f07a:ba19])
        by smtp.gmail.com with ESMTPSA id j23-20020a544817000000b0033a0ef748a8sm3028682oij.54.2022.07.13.11.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 11:34:46 -0700 (PDT)
Message-ID: <6b117636-d3e3-5ae9-5419-439689efb763@github.com>
Date:   Wed, 13 Jul 2022 14:34:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] Documentation: use allowlist and denylist
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
 <ec81aac05c40318755f5311a20e8f9cc55d289fc.1657718450.git.gitgitgadget@gmail.com>
 <Ys7i/GWSNRHqSZNQ@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Ys7i/GWSNRHqSZNQ@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/2022 11:21 AM, Jeff King wrote:
> On Wed, Jul 13, 2022 at 01:20:48PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> Using "allowlist" and "denylist" is a more precise definition of the
>> functionality they provide. The previous color-based words assume
>> cultural interpretation to provide the meaning.
>>
>> Focus on replacements in the Documentation/ directory since these are
>> not functional uses.
> 
> Thanks, the direction looks reasonable to me. I knew at least about the
> one for protocol.*, which I think I introduced, and had been meaning to
> grep for others.
> 
> I think you need some grammatical fixups, though. E.g.:
> 
>> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
>> index fdc28c041c7..ff74a90aead 100644
>> --- a/Documentation/git-daemon.txt
>> +++ b/Documentation/git-daemon.txt
>> @@ -33,7 +33,7 @@ It verifies that the directory has the magic file "git-daemon-export-ok", and
>>  it will refuse to export any Git directory that hasn't explicitly been marked
>>  for export this way (unless the `--export-all` parameter is specified). If you
>>  pass some directory paths as 'git daemon' arguments, you can further restrict
>> -the offers to a whitelist comprising of those.
>> +the offers to a allowlist comprising of those.
> 
> You'd want s/a/an/ here.

Thank you for the careful attention to detail. I should have
been more careful when switching from a consonant to a vowel.
>>  'git daemon' as inetd server::
>>  	To set up 'git daemon' as an inetd service that handles any
>> -	repository under the whitelisted set of directories, /pub/foo
>> +	repository under the allowlisted set of directories, /pub/foo
>>  	and /pub/bar, place an entry like the following into
>>  	/etc/inetd all on one line:
> 
> This one is more gut feeling.  Somehow "allowlisted" as an adjective
> seems more awkward than "whitelisted". Probably because I've just seen
> "whitelisted" so many more times. Or maybe it just crosses my personal
> line of too many syllables. ;)
> 
> I don't know if there's an easy way around it. I don't have a suggestion
> that's better than "allowlist" for the general term, and we want to use
> the terms consistently. You could probably write it as:
> 
>   ...any repository under the set of directories in the allowlist...
> 
> but I'm sure somebody probably likes that less. :) So I register it only
> as a suggestion, not a request for a change.

I think that is the natural way to reword here, but I'll take some
time to think of alternatives before sending v2.

Thanks,
-Stolee
