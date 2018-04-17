Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64CA1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeDQRnq (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:43:46 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35999 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbeDQRno (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:43:44 -0400
Received: by mail-wr0-f175.google.com with SMTP id q13so34389278wre.3
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1whwSZP5jVZebA5b7jAObsfwAzs72wnedJP7jPuJhhQ=;
        b=DZ0qRS7pn/PDxjMGlJpEWp4S+TosDO580jaMkw2L2sAyE9Fza0gLxMljMhi/YUppTO
         O6pcODSP6dpJOwSN7FZcQcz8O+wzE6SfLXHvcRDsdT9foh3x2rQ3BNvXoQUOvwzke4wL
         KdXCDWv+UGcUav6eHajkpGLoyOCIJvuxgnswdtSUf12/fHRpRNcHdTOFgI/Zx1PEti8/
         sTHhH+MR1YMP1frsypncEwruHIr2YvUTqK0iTVZU86+bZGpUI2jK3VMwz2r7z4b9+Awr
         Dbr3VzNVGfeGM0/LGO4iiFUWBC+5rUI9r6NScpcxSXHy3qiA8quKPWxBCGYmQMk7soea
         60Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1whwSZP5jVZebA5b7jAObsfwAzs72wnedJP7jPuJhhQ=;
        b=RTCixK6K/J6zqgqwf7DXSXgUZ1AJmVs85g82qOfKGpXxZH6kuw/1lp2naW/vzLGfAc
         yQAzTIzoxNJJ8aI+8KaqG8yYkVkFk5kejMw5oqdOZzda7eDWp6wKn20Z2zJk/oqnlvPA
         mZ6Q0GHErhloacIHkp+2iG7HG34mS8tltHQ+sHNrxcaWmfW12xto7A97e5upwZ1xVvey
         2lDaDcz2Bernof9uSC6mnGD6KIVjxblbuWI/c7puTqjyNVcme6Ya74AxEleOXCjMr1HZ
         xQwMguih6HjjWctoyz9ut/yMovDB78tQnpbui1Q95ewrneOH60TGy/EdEnEOBLvwuQGi
         gMnw==
X-Gm-Message-State: ALQs6tBLediLB0Aj9Zniz7Q68YJ3nlnnZdNHj2+2OHK8kyggKauOjBlC
        TK2v6TXQZ3aT0uqTOj5SckcdO2QDCv9V+HA8F8I=
X-Google-Smtp-Source: AIpwx48+jHbtl47c0FVJDG9+zArfc5zqekKpI25XCIK6QHVdNY50cyb46oTrYNWNsFquHkno+s1sltBjDBWe6cuTNU0=
X-Received: by 10.80.192.145 with SMTP id k17mr4330903edf.303.1523987023449;
 Tue, 17 Apr 2018 10:43:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Tue, 17 Apr 2018 10:43:22 -0700 (PDT)
In-Reply-To: <C42212C2-6777-41B8-A571-1457ACD405A3@gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
 <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
 <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
 <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
 <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
 <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com>
 <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com> <CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com>
 <F1738316-71EF-4053-82E5-F009F491CCE8@gmail.com> <CA+P7+xrmAHjaF=wze1iu0=cZBY3WcHXqpuDep3Nrev+zmt_Gog@mail.gmail.com>
 <CA+P7+xoVcPV_mFS3WpUvCUR7N4SzJ5WBZqpGT3VVWdkPjh6Qww@mail.gmail.com> <C42212C2-6777-41B8-A571-1457ACD405A3@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 17 Apr 2018 10:43:22 -0700
Message-ID: <CA+P7+xrdeoXXE5W-_bES2f85DPnzyuH3HqVyeeU1jurfdD3saQ@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Peter Backes <rtc@helen.plasma.xg8.de>,
        winserver.support@winserver.com, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 10:27 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 16 Apr 2018, at 19:45, Jacob Keller <jacob.keller@gmail.com> wrote:
>>
>> On Mon, Apr 16, 2018 at 10:43 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>> On Mon, Apr 16, 2018 at 9:07 AM, Lars Schneider
>>> <larsxschneider@gmail.com> wrote:
>>>> What if Git kept a LRU list that contains file path, content hash, and
>>>> mtime of any file that is removed or modified during a checkout. If a
>>>> file is checked out later with the exact same path and content hash,
>>>> then Git could set the mtime to the previous value. This way the
>>>> compiler would not think that the content has been changed since the
>>>> last rebuild.
>>>
>>> That would only work until they actuall *did* a build on the second
>>> branch, and upon changing back, how would this detect that it needs to
>>> update mtime again? I don't think this solution really works.
>>> Ultimately, the problem is that the build tool relies on the mtime to
>>> determine what to rebuild. I think this would cause worse problems
>>> because we *wouldn't* rebuild in the case. How is git supposed to know
>>> that we rebuilt when switching branches or not?
>>>
>>> Thanks,
>>> Jake
>>
>> I think a better solution for your problem would be to extend the
>> build system you're using to avoid rebuilding when the contents
>> haven't changed since last build (possibly by using hashes?). At the
>> very least, I would not want this to be default, as it could possibly
>> result in *no* build when there should be one, which is far more
>> confusing to debug.
>
> I am 100% with you that this is a build system issue. But changing
> the build system for many teams in a large organization is really
> hard. That's why I wondered if Git could help with a shortcut.
> Looks like there is no shortcut (see my other reply in this thread).
>
> Thanks
> Lars

Right. I think that solutions involving hooks or scripts which "fix"
the mtimes are the best bet for this problem then, given that building
it into git would cause problems for other users. (And personally I
would always ere on the side of causing rebuilds unless we're 100%
sure)

Thanks,
Jake
