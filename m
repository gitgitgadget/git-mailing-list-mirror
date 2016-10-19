Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9271220986
	for <e@80x24.org>; Wed, 19 Oct 2016 19:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760422AbcJSTvz (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 15:51:55 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33898 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754262AbcJSTvy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 15:51:54 -0400
Received: by mail-vk0-f54.google.com with SMTP id b186so41994974vkb.1
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CTSc2axOhmcL8yuax1sIv48d7yB3iVzphRJj9X2y8L0=;
        b=TLgx0W5a4kj65fDK8xd7Sw2fHH/c3Weur1SWm+N4aD63qaZGfULFEg35T/5oeCa4ug
         ncohR8+jIPjRixhc0w0KT6cD8OmkLOVaffg5sNeXKcdoUTfGbhRlxfkRrbpGZjqTHI/0
         lc+cEd17CZIySU/Uf4rwgPnp56a6fwjtd9p6i7cakPF3MshpaEdhjRzapccMZEGy+ON8
         GUzLRg5lkvOn1YsYfJKF4aVzom+dG2ZpNbepTrfxOnCSg5ORSVuQCo/ihYuc0A5pz2Z0
         /8tRvdZ8jgejKjFn6H0kbZFQMxeHcMm10W5LULJeOKhyMRU/9bgLZ1fw2FSjOv+Fa6RN
         vF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CTSc2axOhmcL8yuax1sIv48d7yB3iVzphRJj9X2y8L0=;
        b=KcKKiX/3PQHzdToStkB2tzE35IUpJCIk62xENdBP5REXZUjJnqJewM7ILs/4UARamM
         PEH8tfZT4WvK0EWUuBH3Faa7xdy4scv0ZgFfdYbWCZvggTkCuVUt1ZsL4WQx9EHBEI2P
         zB/rDufOl9iILfOH+9vGscbBx7bQIK81waPVHRcZwdE728z6lzF2fP+bRZ2r7ISNrGjl
         p3t1iqekfpkNareADXkA95QEmBmxnPUekKs6ZAZYnqsYbm/pH5hNuyQqjm2L40Bdz5P6
         G1F3wtXamvHJUDRhgjIOzNGVx/lc3c6yKK1OY5IBngiQ0sRM4zUi9MPr4OZmEwKQQHnS
         POAA==
X-Gm-Message-State: AA6/9RkYOYkQw1zYIu/1TrfiZpwX9Cr8iF1yIAJbFCqaphbItQOwkqLH6fkuz9sDne2L5k2i7h6dCjPkLBhlIg==
X-Received: by 10.31.222.66 with SMTP id v63mr7040062vkg.46.1476906713125;
 Wed, 19 Oct 2016 12:51:53 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.68.97 with HTTP; Wed, 19 Oct 2016 12:51:52 -0700 (PDT)
In-Reply-To: <CAGZ79kZWaShG9iG565bD3aVYFcb53+opbpnJH-v3G6hrQL2tzA@mail.gmail.com>
References: <CAHd499AN2VHL66c6JWxHqS-1bQ6y4PrGjZJiR_ad6HJsCGpeDQ@mail.gmail.com>
 <CAGZ79kaFtzQDZrSJhJZ59xvBzn+6+UVDO65Ac+T6aFxMQaM_xQ@mail.gmail.com>
 <CAHd499CN3+cHVwjOEirwXVu3DsJwPrmJwEgSJL2CHD5CvoYxxg@mail.gmail.com>
 <CAGZ79kYKdHHcfRxCOJwNuqnOGMjBBeMy3Av5U7_ssuOp-to61w@mail.gmail.com>
 <CAHd499D_fehBHsNdH9PLQj+H_WAJqbbMhDwv_nCT3fZcX60ENA@mail.gmail.com> <CAGZ79kZWaShG9iG565bD3aVYFcb53+opbpnJH-v3G6hrQL2tzA@mail.gmail.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 19 Oct 2016 14:51:52 -0500
X-Google-Sender-Auth: MQONoubyIfASPszxcWlcXabteYA
Message-ID: <CAHd499DKz+tpP3zRrXX3_serhoC_GCZst2y75JtC0Eiy1zfEew@mail.gmail.com>
Subject: Re: Integrating submodules with no side effects
To:     Stefan Beller <sbeller@google.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 2:45 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Oct 19, 2016 at 12:19 PM, Robert Dailey
> <rcdailey.lists@gmail.com> wrote:
>> On Wed, Oct 19, 2016 at 11:23 AM, Stefan Beller <sbeller@google.com> wrote:
>>> You could try this patch series:
>>> https://github.com/jlehmann/git-submod-enhancements/tree/git-checkout-recurse-submodules
>>> (rebased to a newer version; no functional changes:)
>>> https://github.com/stefanbeller/git/tree/submodule-co
>>> (I'll rebase that later to origin/master)
>>>
>>>>
>>>> Do you have any info on how I can prevent that error? Ideally I want
>>>> the integration to go smoothly and transparently, not just for the
>>>> person doing the actual transition (me) but for everyone else that
>>>> gets those changes from upstream. They should not even notice that it
>>>> happened (i.e. no failed commands, awkward behavior, or manual steps).
>>>
>>> It depends on how long you want to postpone the transition, but I plan to
>>> upstream the series referenced above in the near future,
>>> which would enable your situation to Just Work (tm). ;)
>>
>> At first glance, what you've linked to essentially looks like
>> automated `git submodule update` for every `git checkout`. Am I
>> misunderstanding?
>
> Essentially yes, except with stricter rules than the actual submodule update
> IIRC.
>
>>
>> If I'm correct, this is not the same as what I'm talking about. The
>> problem appears to be more internal: When a submodule is removed, the
>> physical files that were there are not removed by Git.
>
> That is also done by that series: submodules ought to be treated as files:
> If you checkout a new version where a file is deleted, the checkout command
> will actually remove the file for you (and e.g. solve any
> directory/file conflicts
> that may happen in the transition.)
>
>> It leaves them
>> there in the working copy as untracked files.
>
> That is the current behavior as checkout tries hard to ignore submodules.
>
>> The next step Git takes
>> (again, just from outside observation) is to add those very same files
>> to the working copy, since they were added to a commit. However, at
>> this point Git fails because it's trying to create (write) files to
>> the working copy when an exact file of that name already exists there.
>> Git will not overwrite untracked files, so at this point it fails.
>>
>> What needs to happen, somehow, is Git sees that the files were
>> actually part of a submodule (which was removed) and remove the
>> physical files as well, assuming that they were not modified in the
>> submodule itself. This will ensure that the next step (creating the
>> files) will succeed since the files no longer block it.
>
> Yep.

It's great we're finally on the same page ;-)

However, I don't see how this problem can be solved with your script,
or solved in general outside of that. Does this mean that Git needs to
change to treat submodules as it does normal files, per your previous
assertion, which means submodules should *not* be left behind in the
working copy as untracked files?
