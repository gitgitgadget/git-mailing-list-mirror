Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 647BB1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 04:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750992AbeD0ERx (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 00:17:53 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46375 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeD0ERx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 00:17:53 -0400
Received: by mail-vk0-f66.google.com with SMTP id i190-v6so309731vkd.13
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 21:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B1cLWaHyNod5vignat0+jJuU9NwwZOwKX1VlcufWXn8=;
        b=Oy2LkrfntNLDRzb8zVFCVjfNg8NxVim/2y4oeRoMXm+KWuRnEZQBNo17MTQ5atkoiX
         wj2kLdS0z8c5hluqNiTRJBYDtzqAizlrCg445Y5SHw4WOm3LlRjv9IZF06tb0l3jnAb4
         /+neRJ0l1I3mtOw0XgC9BtYBNC4JaFB53pSKEJBb73m7kbK7RabOUhZpADiWdTkihCPU
         526weJSkhVGVTGtaNl/3MGLXS+PmwN0NaixvG1Auabv/qFz5Y2PwEfqv9kJC3EuzEIfc
         xEC8ZHsBTSpJaxDP9iuBd29zMXUOWE04T9CUeH6ltBjMtXOCToDQ++z6QaO3UPuOVs+c
         umXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B1cLWaHyNod5vignat0+jJuU9NwwZOwKX1VlcufWXn8=;
        b=WfpD1hEDcwdVWrXtwpS2+MLMrAHmlHooB1Ol6m8m9ybTZOMTVcq7YBmbkgWHbBP0bq
         cbtjV3jOxhG6cLVIEddu+5tTfRGcf/srPZ2Az97lPdVFSZ5SEFmVRLq1EFhf5v4AWU0n
         +w1qRpl28f9pwwIcsapl+TDHqlwi4nty6AFaxaPGXWXRzrCvzbDAs8OEMEMPwa82YVhB
         bgdHzZHPNWZNpOyh5GQDJfAP1bTRRgU9Zbu8/9pZqW9NpIGnBSNgO/sNzWOsfyjWMY1s
         droy27Nwd7GJMDU4pEUqEOkUuOKBdYE7rjCdehPoTMxiGGsd+eZaS0FL1QeSxCnD6WWp
         uVSA==
X-Gm-Message-State: ALQs6tA22DXsRm8dyNr9Mn89OKIAAY4GhEUCR8Qavkgw+bplgTGhB99r
        av8VekbcSUeyb7gq2r8hqfJp6C3cASFYfzdNMuQ=
X-Google-Smtp-Source: AB8JxZqKU4teuFFOhVlXDWOfOHjGfgMCHPa/+lA1A1rMYkgEdc7BjO9H7AkJU+wtz0O1PVYv6EmWtizA9Wut1ALpaKo=
X-Received: by 2002:a1f:aa58:: with SMTP id t85-v6mr429881vke.118.1524802672064;
 Thu, 26 Apr 2018 21:17:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 26 Apr 2018 21:17:51 -0700 (PDT)
In-Reply-To: <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180426205202.23056-1-benpeart@microsoft.com> <20180426205202.23056-3-benpeart@microsoft.com>
 <CABPp-BE29rwZCDqFHH-nzrDub6MMdtoiorj0jv3K6B6cmfcaLA@mail.gmail.com> <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Apr 2018 21:17:51 -0700
Message-ID: <CABPp-BFDVQiUtytQ0TJu6inzsd93RD96XkazLT5BZJqeM2jX8Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] merge: Add merge.renames config setting
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 5:54 PM, Ben Peart <peartben@gmail.com> wrote:
> On 4/26/2018 6:52 PM, Elijah Newren wrote:
>> On Thu, Apr 26, 2018 at 1:52 PM, Ben Peart <Ben.Peart@microsoft.com>
>> wrote:
>>
>>> diff --git a/merge-recursive.h b/merge-recursive.h
>>> index 80d69d1401..0c5f7eff98 100644
>>> --- a/merge-recursive.h
>>> +++ b/merge-recursive.h
>>> @@ -17,7 +17,8 @@ struct merge_options {
>>>          unsigned renormalize : 1;
>>>          long xdl_opts;
>>>          int verbosity;
>>> -       int detect_rename;
>>> +       int diff_detect_rename;
>>> +       int merge_detect_rename;
>>>          int diff_rename_limit;
>>>          int merge_rename_limit;
>>>          int rename_score;
>>> @@ -28,6 +29,11 @@ struct merge_options {
>>>          struct hashmap current_file_dir_set;
>>>          struct string_list df_conflict_file_set;
>>>   };
>>> +inline int merge_detect_rename(struct merge_options *o)
>>> +{
>>> +       return o->merge_detect_rename >= 0 ? o->merge_detect_rename :
>>> +               o->diff_detect_rename >= 0 ? o->diff_detect_rename : 1;
>>> +}
>>
>>
>> Why did you split o->detect_rename into two fields?  You then
>> recombine them in merge_detect_rename(), and after initial setup only
>> ever access them through that function.  Having two fields worries me
>> that people will accidentally introduce bugs by using one of them
>> instead of the merge_detect_rename() function.  Is there a reason you
>> decided against having the initial setup just set a single value and
>> then use it directly?
>>
> The setup of this value is split into 3 places that may or may not all get
> called.  The initial values, the values that come from the config settings
> and then any values passed on the command line.
>
> Because the merge value can now inherit from the diff value, you only know
> the final value after you have received all possible inputs.  That makes it
> necessary to be a calculated value.
>
> If you look at diff_rename_limit/merge_rename_limit, detect_rename follow
> the same pattern for the same reasons.  It turns out detect_rename was a
> little more complex because it is used in 3 different locations (vs just
> one) which is why I wrapped the inheritance logic into the helper function
> merge_detect_rename().

Ah, you're following the precedent set by
diff_rename_limit/merge_rename_limit; that makes sense.  Thanks for
the explanation.  I believe another possibility here is that for both
the {merge,diff}_rename_limit pair of variables and the
{diff,merge}_renames pair of variables, since the code parses all
inputs before ever using the result, we could calculate the result
once and store it rather than storing the constituent pieces of the
calculation.  That would also prevent people from trying to use one of
the pieces of the calculation instead of treating it as a coherent
whole.  However, while I would have preferred that the rename_limit
pair of variables also went away in favor of just one field which is
updated as it parses each input option, what you have is fine for this
series.
