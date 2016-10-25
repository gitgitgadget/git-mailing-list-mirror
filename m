Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EC882035F
	for <e@80x24.org>; Tue, 25 Oct 2016 15:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbcJYPF0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 11:05:26 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:40001 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbcJYPFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 11:05:25 -0400
Received: by mail-vk0-f43.google.com with SMTP id c126so12056288vkd.7
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CNKOW8moemDQwgsVJ1RMaPk6AbVbXqlVqN23dpxp/L8=;
        b=K9euS/mZnGwcAKCDjKkEgIgtdj3XmkPC9PBW6pHiCzKqi65cvi5A5QlE08NyqfI0JQ
         GTS6+rV1ZbH+u/paFZx3AwKhEQCt678XwPJkbC43sEwMfZwaAyP6KNBjR7vWWtHbYfj9
         5HpHHf1sY/NnHowvrXbc13qZijvADmbl+zQgTUx6Ei0LrMeuJGUKCIT2cZwwx7R9Aas6
         AjOqcCfLdshUihF5CJb4Yk/v9Sq0VnRJFFuDi/92rVdxDrTd7iCYWT4ffIz0QpkvgwwA
         0m10W9stbX4MyYMdlamQtXC60N1fUTJmb/74MYCm6Wa9mYQ89MQalmUTL6Vd1x7NCIxr
         PDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CNKOW8moemDQwgsVJ1RMaPk6AbVbXqlVqN23dpxp/L8=;
        b=bI5XZuHT7y56G7HhP8Nmr3LpsLJzauU/8RIvnfOfefPeiHe6LG3Dgfze8wIwGCrb+k
         ODajN/Bu3lMZsTMu3sVRexSKCxjMAWjfU06jnBvEyWNe5nuxIUjuaFp9fwyLcuBrmyIc
         t+oDg+tDlErE17h2YoqPztMJxoJW27jL7x2BwlDNeYYv3vsDbcc6c1Kd9WCcRJ/aPQXB
         QDc/ciCHiveq2mqgT9lckjgcKANcHKV10Ti7Kb+Gk5Cy698rrx26Ew4Kd0PpdzeDK28c
         pCu21R3WAk8PDzz30rChNtShPSNuVybcdiYrtclVnZ+adAFqN4/LCT7gzA67RAz1VTr+
         PI2Q==
X-Gm-Message-State: ABUngvcUAryOWF6EiNY7KjC7yjVjkVwn5zSRXi1CCq9ZLKsf6kr6f8nomdZ1ooW8YhuXYSmVBmorbh+8Xaolng==
X-Received: by 10.31.222.66 with SMTP id v63mr15790123vkg.46.1477407924340;
 Tue, 25 Oct 2016 08:05:24 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.68.97 with HTTP; Tue, 25 Oct 2016 08:05:23 -0700 (PDT)
In-Reply-To: <CAHd499DKz+tpP3zRrXX3_serhoC_GCZst2y75JtC0Eiy1zfEew@mail.gmail.com>
References: <CAHd499AN2VHL66c6JWxHqS-1bQ6y4PrGjZJiR_ad6HJsCGpeDQ@mail.gmail.com>
 <CAGZ79kaFtzQDZrSJhJZ59xvBzn+6+UVDO65Ac+T6aFxMQaM_xQ@mail.gmail.com>
 <CAHd499CN3+cHVwjOEirwXVu3DsJwPrmJwEgSJL2CHD5CvoYxxg@mail.gmail.com>
 <CAGZ79kYKdHHcfRxCOJwNuqnOGMjBBeMy3Av5U7_ssuOp-to61w@mail.gmail.com>
 <CAHd499D_fehBHsNdH9PLQj+H_WAJqbbMhDwv_nCT3fZcX60ENA@mail.gmail.com>
 <CAGZ79kZWaShG9iG565bD3aVYFcb53+opbpnJH-v3G6hrQL2tzA@mail.gmail.com> <CAHd499DKz+tpP3zRrXX3_serhoC_GCZst2y75JtC0Eiy1zfEew@mail.gmail.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 25 Oct 2016 10:05:23 -0500
X-Google-Sender-Auth: FcvwNcndyxTQ8jF4sVDt4FMapZM
Message-ID: <CAHd499B605aWFKJa1DmuEcB9WR5pubeURk8ToTrnJP7saTG2Kg@mail.gmail.com>
Subject: Re: Integrating submodules with no side effects
To:     Stefan Beller <sbeller@google.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 2:51 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> On Wed, Oct 19, 2016 at 2:45 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Wed, Oct 19, 2016 at 12:19 PM, Robert Dailey
>> <rcdailey.lists@gmail.com> wrote:
>>> On Wed, Oct 19, 2016 at 11:23 AM, Stefan Beller <sbeller@google.com> wrote:
>>>> You could try this patch series:
>>>> https://github.com/jlehmann/git-submod-enhancements/tree/git-checkout-recurse-submodules
>>>> (rebased to a newer version; no functional changes:)
>>>> https://github.com/stefanbeller/git/tree/submodule-co
>>>> (I'll rebase that later to origin/master)
>>>>
>>>>>
>>>>> Do you have any info on how I can prevent that error? Ideally I want
>>>>> the integration to go smoothly and transparently, not just for the
>>>>> person doing the actual transition (me) but for everyone else that
>>>>> gets those changes from upstream. They should not even notice that it
>>>>> happened (i.e. no failed commands, awkward behavior, or manual steps).
>>>>
>>>> It depends on how long you want to postpone the transition, but I plan to
>>>> upstream the series referenced above in the near future,
>>>> which would enable your situation to Just Work (tm). ;)
>>>
>>> At first glance, what you've linked to essentially looks like
>>> automated `git submodule update` for every `git checkout`. Am I
>>> misunderstanding?
>>
>> Essentially yes, except with stricter rules than the actual submodule update
>> IIRC.
>>
>>>
>>> If I'm correct, this is not the same as what I'm talking about. The
>>> problem appears to be more internal: When a submodule is removed, the
>>> physical files that were there are not removed by Git.
>>
>> That is also done by that series: submodules ought to be treated as files:
>> If you checkout a new version where a file is deleted, the checkout command
>> will actually remove the file for you (and e.g. solve any
>> directory/file conflicts
>> that may happen in the transition.)
>>
>>> It leaves them
>>> there in the working copy as untracked files.
>>
>> That is the current behavior as checkout tries hard to ignore submodules.
>>
>>> The next step Git takes
>>> (again, just from outside observation) is to add those very same files
>>> to the working copy, since they were added to a commit. However, at
>>> this point Git fails because it's trying to create (write) files to
>>> the working copy when an exact file of that name already exists there.
>>> Git will not overwrite untracked files, so at this point it fails.
>>>
>>> What needs to happen, somehow, is Git sees that the files were
>>> actually part of a submodule (which was removed) and remove the
>>> physical files as well, assuming that they were not modified in the
>>> submodule itself. This will ensure that the next step (creating the
>>> files) will succeed since the files no longer block it.
>>
>> Yep.
>
> It's great we're finally on the same page ;-)
>
> However, I don't see how this problem can be solved with your script,
> or solved in general outside of that. Does this mean that Git needs to
> change to treat submodules as it does normal files, per your previous
> assertion, which means submodules should *not* be left behind in the
> working copy as untracked files?

I'll assume (due to the lack of responses) that the only viable
solution here is to integrate the submodule using a different
directory name than the one used by the submodule itself. It's
unfortunate but I'll do it if I have no other option.
