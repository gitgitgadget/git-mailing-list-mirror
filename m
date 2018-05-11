Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421A61F406
	for <e@80x24.org>; Fri, 11 May 2018 12:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbeEKMub (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 08:50:31 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40685 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752563AbeEKMua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 08:50:30 -0400
Received: by mail-qt0-f196.google.com with SMTP id h2-v6so6859427qtp.7
        for <git@vger.kernel.org>; Fri, 11 May 2018 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yNhKMMbYrnjT4rqtGfb0RcJLZ5hEZfil9ft67G+E9YI=;
        b=iQlgYhaJUTSm94WJBHVOu7WZjhYHWWxU4kBv77gmC64RE7kRjHMTkezlnGSE2T49TM
         Eqf4Gx/gxwPMFWJhOBwcf9NpskDLr5hqc4PcDqJ1rTOzqNkMWApgEuX7GYFC32Euelyw
         EJTGOOvrKV8HAT8dM08yQgzbJi5Ivj2oMtsonEuQ7Nk28Jybo3CqGJUW2++ygeQR7/Ut
         ZNmYVTg3rZqIist9EmAcBmNJAFdT5FCH5hFJVwOHd2hyS6qMvVP+18//luQIfjB+sCFj
         qbCmfkfCiFN6Lwozm0xob535D6FN5iZj/6OI1Hvxm/N7a9kuXlP5ZWF4qU3biMungkoM
         C0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yNhKMMbYrnjT4rqtGfb0RcJLZ5hEZfil9ft67G+E9YI=;
        b=RC2Ohtqv25YvfKVrJuBktfhwDle9Qe7PhWeLTgeT0lgNma2HIHPQZfyEqHxRuJdKfr
         fXUHfYWgvnETHyPSirmZbxSpk2J5sTJLkERJe3wQ/PhlckguO4AqyoUHqyyaOxxsPCOc
         iDtgVZAhypb8iRuKNO3Yv/J16sU1aKh15FtwbYXe2XlpAFfSsYlHB+HEvB54RZnCT2RV
         S4ZTdWKXN+6rWL1flcS7cUoro/KLYiUSoJKXbY+xgssd+x3oVMhq2RJnHVA/6C9prXhn
         ZmQgrXAYwAlTFA9IdfZbOH3tIuo+K76O5cLlqCYdJ9YvV/ETtzp6DefS5+PB5yKOJuwm
         gN9w==
X-Gm-Message-State: ALKqPweFgIyQ/Y5UjMRK6ksckY95HlNxsEMCW0HBET/Pq7Xle9QDGtCy
        Nn3jCpukdwtyGExpBxFq3oU=
X-Google-Smtp-Source: AB8JxZqZ9jC/gi+kkquHX/XQJ7NjC56j7AWUDlz5vmMtKXHtBcKb2O/unBg/+vYvEyPL7HMGW+0d0A==
X-Received: by 2002:ac8:8b2:: with SMTP id v47-v6mr5090967qth.350.1526043029516;
        Fri, 11 May 2018 05:50:29 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id y84-v6sm2351228qkb.23.2018.05.11.05.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 05:50:28 -0700 (PDT)
Subject: Re: [PATCH v2] add status config and command line options for rename
 detection
To:     Elijah Newren <newren@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Alejandro Pauly <alpauly@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
References: <20180509144213.18032-1-benpeart@microsoft.com>
 <20180510141621.9668-1-benpeart@microsoft.com>
 <CABPp-BGE6RXv3ka8wGXruFjk3W=kDEDJ6zpH3t5=_CGSTONCHQ@mail.gmail.com>
 <bc81823e-7b7d-c516-dfc2-cd47bedb5a5a@gmail.com>
 <CABPp-BGL2Fcnj0QNu+D3wfOU5q8MuizUGJyzrEc7FXy9Q9aA_A@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <276c981b-3b6b-4034-7aaa-dbfcba4ae3f1@gmail.com>
Date:   Fri, 11 May 2018 08:50:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGL2Fcnj0QNu+D3wfOU5q8MuizUGJyzrEc7FXy9Q9aA_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/10/2018 6:31 PM, Elijah Newren wrote:
> Hi Ben,
> 
> On Thu, May 10, 2018 at 12:09 PM, Ben Peart <peartben@gmail.com> wrote:
>> On 5/10/2018 12:19 PM, Elijah Newren wrote:
>>> On Thu, May 10, 2018 at 7:16 AM, Ben Peart <Ben.Peart@microsoft.com>
>>> wrote:
> 
>> Given the example perf impact is arbitrary (the actual example that
>> triggered this patch took status from 2+ hours to seconds) and can't be
>> replicated using the current performance tools in git, I'm just going drop
>> the specific numbers.  I believe the patch is worth while just to give users
>> the flexibility to control these behaviors.
> 
> Your parenthetical statement of timing going from hours to seconds I
> think would be great; I don't think we need precise numbers.
> 
>>>> +       if ((intptr_t)rename_score_arg != -1) {
>>>> +               s.detect_rename = DIFF_DETECT_RENAME;
>>>
>>>
>>> I'd still prefer this was a
>>>           if (s.detect_rename < DIFF_DETECT_RENAME)
>>>                   s.detect_rename = DIFF_DETECT_RENAME;
>>>
>>> If a user specifies they are willing to pay for copy detection, but
>>> then just passes --find-renames=40% because they want to find more
>>> renames, it seems odd to disable copy detection to me.
>>>
>>
>> I agree and will change it. It is unfortunate this will behave differently
>> than it does with merge.  Fixing the merge behavior to match is outside the
>> scope of this patch.
> 
> I agree that changing merge is outside the scope of this patch, but
> I'm curious what change you have in mind for it to "make it match".
> In particular, merge-recursive.c already has (or will shortly have)
> +       if (opts.detect_rename > DIFF_DETECT_RENAME)
> +               opts.detect_rename = DIFF_DETECT_RENAME;
> from your commit 85b460305ce7 ("merge: add merge.renames config
> setting", 2018-05-02), 

This is a good point that I missed.  With that recent change to merge, 
it no longer matters that the settings parsing code caps detect_rename 
at DIFF_DETECT_RENAME because it will cap it later anyway so there is no 
need to change the merge option behavior.

> The one place copy detection does make sense inside a merge is for the
> diffstat shown at the end (from builtin/merge.c), but it currently
> isn't controlled by any configuration setting at all.  When it is
> hooked up, it'd probably store the value separately from
> merge-recursive's internal o->{diff,merge}_detect_rename anyway,
> because builtin/merge.c's diffstat should be controlled by the
> relevant confiig settings and flags (merge.renames, diff.renames,
> -Xfind-renames, etc.) regardless of which merge strategy (recursive,
> resolve, octopus, ours, ort) is employed.  And when that is hooked up,
> I agree with you that it should look like what you've done with
> status.renames here.  In fact, if you'd like to take a crack at it, I
> think you'd do a great job.  :-)  If not, it's on my list of things to
> do.
> 

Thanks but I'll leave that to you. :)  I have a large backlog of patches 
I would like to see pushed through the mailing list into master.  We've 
been sitting on this one for over a year.  If the current rate is any 
indication, it will take man years to get caught up.

>>> Testcases look good.  It'd be nice to also add a few testcases where
>>> copy detection is turned on -- in particular, I'd like to see one with
>>> --find-renames=$DIFFERENT_THAN_DEFAULT being passed when
>>> merge.renames=copies.
>>>
>>
>> OK.  I also added tests to verify the settings correctly impact commit.
> 
> Nice!
> 
