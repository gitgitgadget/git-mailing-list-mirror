Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0EFC1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 01:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbeG0Cv1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 22:51:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46798 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731737AbeG0Cv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 22:51:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id l16-v6so2458048lfc.13
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 18:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KOZ+bWOIT05g2u9xWhb1J6LhHy3sdqxj9607n58sNAQ=;
        b=NnuO2Rf2bEBuH6IjilgO/wKAqsoN9mtZTRAeXxaSCZ82GEFS++NSGn8vjhFSFCEHKU
         V6xMOBciruWoqBnQ6/0owvLje2Og8RywDikmwpzn6l1tOCrE9bkmUOc7oomMrm6CA7W5
         9RncxSpA/NId/Ti0PAhp+NZlCYeQ/lVRYzxLkPMf0t1oUiSeJbYVbs9l6xbQw2L9Rc29
         r7Zbixdoe1TVITTAVsWVQoYcOLPOx6IVHTU9uW3fXBYnP32oBovQrTLcKwAQzgt0r/ut
         Ty//SuV4wFsw8GtJWRhYBSvbvEBfvBZC6O4/gWS/CzgVzuTaPEnLxjTALNyHkNHtUlOU
         hdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KOZ+bWOIT05g2u9xWhb1J6LhHy3sdqxj9607n58sNAQ=;
        b=kI/o0NThBcMd9jQZH4EqEjK5t0L0sE9ZUCd7MAhrht/uSjuJe2i1QPkAw3LwLVULHq
         gFdWQkRUOYu/Xb0ykc/Qof76IWjslcZ2nE1o6aH4CqOYDD5clLcqJMpv0VLb8z3mo/Yq
         EySumhpGw1nWag4xH7EGxdHqWfl0gn5Sr4Y5eE4770trb203/WZkS0LsG4dYdyQFRjPW
         XRhI59GyzD7OTqGgGmIEiBytyzGNAmFiCmIXcT7D5dTQobmQ7/Vu6cy5v2GHaOC2N3jQ
         7UBemr1as8Hj8OU5hGH7YGhx94wOaeEMgzFEzP61ggUqxdpDZpPU7Z3FzJ4TnkLYmjWv
         o5tQ==
X-Gm-Message-State: AOUpUlHszbpqk1nw7QN8hjQSJmXgjtPHTrjH5Ql/SnW2wv+QQdp7aN9V
        DIrTryuJt67SbJ0J9SshtCvZuzYHI/T0XhJvfnEt+SRz
X-Google-Smtp-Source: AAOMgpfOPq3qdNPhv/dQqDtqvyJS135aWj6C5oUbaJQaem+yyGK/7GJ4HkDSJmrlEbtMQmLVpu/LnYg4Ir9ZrR/PTzc=
X-Received: by 2002:a19:c1c4:: with SMTP id r187-v6mr194252lff.90.1532655119113;
 Thu, 26 Jul 2018 18:31:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:88d7:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 18:31:58
 -0700 (PDT)
In-Reply-To: <CAE5ih7-DatojdaOYZSEKfgG+FeR9+CWiEcf0veHfz89W7Vhx=Q@mail.gmail.com>
References: <CAE5ih79ndEbnEeV_muQyZwG+01_8Kg0J74rZtOoK1_V40E0z7g@mail.gmail.com>
 <20180725134345.8631-1-chenbin.sh@gmail.com> <CAPig+cR2gYEwOTVBMRde35rn9oVsixeerbm5iJV+FmnOiBWxqQ@mail.gmail.com>
 <CAAE-R+_BWJAB3zsZUZ+=Zn6SiSkzrWG0EYwBF_OcX_V+2idCww@mail.gmail.com>
 <CAPig+cQ80DrYJjYgJEvfcpeNEscgNBvj7ydwxMMVRf6kBfpaqQ@mail.gmail.com> <CAE5ih7-DatojdaOYZSEKfgG+FeR9+CWiEcf0veHfz89W7Vhx=Q@mail.gmail.com>
From:   chen bin <chenbin.sh@gmail.com>
Date:   Fri, 27 Jul 2018 11:31:58 +1000
Message-ID: <CAAE-R+_04wHwtKYEYn-iQz5r1hNp0_GCg0ba7LhjSsayQWSuAQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] add hook pre-p4-submit
To:     Luke Diamand <luke@diamand.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Luke,
Running the hook after applying changes to P4 shadow repo might not be
a good idea.

When the hook is running *before* the changes are applied, I'm 100% sure it's
*only* my code's problem if the hook fails.

One reason we need this hook is sometimes developer is over confident
when applying
some quick one line fix.

The quick fix could be required by business guy before demo to senior
managers or customers.
So we might not want our fix being blocked by upstream commits.

Not everyone is our team is perforce/git expert. Someone only use
`git-p4 submit` and never use
 `git-p4 rebase`. If unit test fails and he could not submit code, he
would come to me for help. But I
want to reduce my workload.


Regards,
Chen


On Fri, Jul 27, 2018 at 7:09 AM, Luke Diamand <luke@diamand.org> wrote:
> On 26 July 2018 at 10:21, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Jul 25, 2018 at 10:08 PM chen bin <chenbin.sh@gmail.com> wrote:
>>> The hook does not receive any information or input from git. The
>>> original requirement
>>> comes from my colleague. He want to run unit test automatically before
>>> submitting code
>>> to remote repository. Or else CI server will send the blame mail to the manager.
>>
>> Okay, that seems in line with a hook such as pre-commit. Please do
>> update the documentation to mention that the hook takes no arguments
>> and nothing on standard input, and perhaps describe in the
>> documentation an example use-case (as you did here).
>>
>> I'm not a p4 or git-p4 user, but, out of curiosity, would there be any
>> information which could be supplied to the hook as arguments or
>> standard input (or both) which would help the hook author implement
>> the hook more easily? Perhaps such information would be fodder for a
>> future enhancement (not necessarily needed for this patch).
>
>
> I tried to think of a use-case for a hook requiring any more
> information, but I can't think of any. You're already chdir()'d to the
> P4 shadow repo which is what you really need.
>
> Anything where you just need the commit hash (e.g. checking the commit
> message) can already be done with one of the existing git hooks; I
> don't think git-p4 needs to duplicate that.
>
> And we can't write a commit hook that can know about the Perforce
> changelist, because we don't know what it is yet.
>
> However, looking at the code, it runs the hook at the point just
> *before* the changes are applied to the P4 shadow repo. Would it make
> more sense to run the hook *after* they have been applied (but before
> being P4 submitted) ?
>
> That way you can run your tests on the checked-out P4 shadow directory
> with your changes - as it stands, you can only run them on your git
> repo at this point, which might not be in sync with Perforce (and
> could be quite a long way out in fact).
>
> Luke
>
>
>>
>>> The hook actually stops the submit process from start instead of abort
>>> submit in midway.
>>> So nothing is touched when hook exits with status 1.
>>
>> This might be a good thing to add to the documentation, as well.
>>
>>> I'm not sure whether `git-p4` should print some "hook rejection" message.
>>> Current implementation is same as other hooks (`pre-commit`, for example).
>>> Only hook itself is responsible to print error messages.
>>>
>>> Personally I don't have opinion whether we should print out hook
>>> related message inside
>>> `git-p4.py`. I just try to following existing convention of git.
>>>
>>> What you guys think?
>>
>> Following existing practice makes sense. It can always be revisited
>> later if needed.
>>
>> Thanks.



-- 
help me, help you.
