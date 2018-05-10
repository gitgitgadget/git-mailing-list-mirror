Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0124D1F406
	for <e@80x24.org>; Thu, 10 May 2018 18:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeEJSxw (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 14:53:52 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:50566 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeEJSxv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 14:53:51 -0400
Received: by mail-wm0-f52.google.com with SMTP id t11-v6so5485161wmt.0
        for <git@vger.kernel.org>; Thu, 10 May 2018 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DekzdMYyWpH0x64ksyRgVbB6iYlxDMcRsvV+6jTRGT8=;
        b=O96FjnJ5/bIYKpwCf0C4GhvqdbVn1iiHCMhmu/Aj2gKsBjBdKORKodn6fy+PlV1hR3
         ljLo7rnrPDS1RGaBSuvqRKXoKbGaohEaqdOGaL/uu6zJrmqikfdX66NPz+tXs8WpZIC7
         QH2f/6/sky57EmTNwU+vMr6zaHEU18wjlaVZc57c2FNp/7SDReMIblJgfemYjwIagk7V
         mtvbaRQshHIMOZvr9k3igzY2JETMqvmX7k7YShyFnyoacmKNtqbvtFBpFXU6WKh6ptzc
         xsmes0yNeWdWIViUcu8dyfG8jKiSG7/AEden8bGYI31TgPT9HWFfqOuswG9aswRNAFSz
         Q+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DekzdMYyWpH0x64ksyRgVbB6iYlxDMcRsvV+6jTRGT8=;
        b=Rt6eowE5LEU7Vw68wBCHlndLDJWnlNgg4kLEtprQCrco21PjH/y7EVL+UUWX0UdIXq
         nR3XgKaYL4i+nWixBi+y/8Ftzc3Xc5JNFSkg/3Q8oe8FQCYKvTcZom5kF6a15HqJ5jfb
         0vekWDs89bi01IB6VTeiReurUQB0FEcwaLaMUIxETgliIcn9+wtendfk0v0n6rX5b1Aq
         4b5w5lJb1qQDi3Jdgf8+kDpGTJQIiL73vOwC0VEY5RLtWHV7dS74tCBaMM+mYwrAqBHg
         rhW77OnK8yqte7vw46Ht1YOZHFh8OBFgXegWJooDWM4PyZA7FcXwLSGuYKvJKQzWNVhU
         NtiA==
X-Gm-Message-State: ALKqPwdB8pf4wd+F/gZQkzoQU1xByI2/ydsZ7WqcI/Oex66CR4TSUY0i
        z+Lgb102i9Jy4/2ScKUypQiWq9qR/twvKfiCkrE=
X-Google-Smtp-Source: AB8JxZpQpocf0LYLNmn7OQyADq19V+A06llUEyB6NiuNF6udXsqqMpisnL/REsvY9HOiGdK9R3UJMuYUVtWHy4gFnQ0=
X-Received: by 2002:a1c:9383:: with SMTP id v125-v6mr103393wmd.58.1525978430304;
 Thu, 10 May 2018 11:53:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.152.138 with HTTP; Thu, 10 May 2018 11:53:29 -0700 (PDT)
In-Reply-To: <bc722982-042a-53cc-e3b3-7c2428952062@xiplink.com>
References: <CAFU8umjyrJc1m65hu6QMQUiNmsJtbV65tovcWjvmzFpsCr668A@mail.gmail.com>
 <CAGZ79kb05U91_Ku7DKuwQVCrtouYwGWTCPdJFQ=bgWo91inRGA@mail.gmail.com>
 <98279912-0f52-969d-44a6-22242039387f@xiplink.com> <CAFU8umhPCTTUc=EZYGDhFe=GeW7_GdyrqZU0DVg7xYaE+Ajg2A@mail.gmail.com>
 <bc722982-042a-53cc-e3b3-7c2428952062@xiplink.com>
From:   Ilya Kantor <iliakan@gmail.com>
Date:   Thu, 10 May 2018 21:53:29 +0300
Message-ID: <CAFU8umhU+jOdB=PbrnBx24sizSAp-JeTt8KfvxoM_no0kbDu-A@mail.gmail.com>
Subject: Re: Is rebase --force-rebase any different from rebase --no-ff?
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

If that's indeed true (as far as I could see that, still can be
mistaken), then as a git user, not developer, I'd stick to --no-ff,
because it's the more intuitive naming.

Just 5=C2=A2.
---
Best Regards,
Ilya Kantor


On Thu, May 10, 2018 at 9:34 PM, Marc Branchaud <marcnarc@xiplink.com> wrot=
e:
> On 2018-05-09 03:46 PM, Ilya Kantor wrote:
>>
>> I tried to compare --force-rebase VS --no-ff for the following repositor=
y:
>> http://jmp.sh/E7TRjcL
>>
>> There's no difference in the resulf of:
>> git rebase --force-rebase 54a4
>> git rebase --no-ff 54a4
>>
>> (rebases all 3 commits of feature)
>>
>> Also, there's no difference in interactive mode:
>> git rebase --force-rebase -i 54a4
>> git rebase --no-ff -i 54a4
>>
>> (picks all 3 commits of feature)
>>
>> Is there a case where --no-ff differs from --force-rebase?
>
>
> So now that "rebase -i" respects --force-rebase, the question is what to =
do
> about it:
>
> 1. Teach "rebase -i" to stop respecting --force-rebase (restoring the
> original intent when --no-ff was introduced)?
>
> 2. Deprecate --no-ff?
>
> 3. Deprecate --force-rebase?
>
> As a heavy rebase user, I find --no-ff more intuitive than --force-rebase=
.
> I'd be in favour of option 3, and keeping just --no-ff (with -f as a
> synonym).
>
>                 M.
>
>
>> ---
>> Best Regards,
>> Ilya Kantor
>>
>>
>> On Wed, May 9, 2018 at 10:27 PM, Marc Branchaud <marcnarc@xiplink.com>
>> wrote:
>>>
>>> On 2018-05-09 02:21 PM, Stefan Beller wrote:
>>>>
>>>>
>>>> +cc Marc and Johannes who know more about rebase.
>>>>
>>>> On Wed, May 9, 2018 at 9:01 AM, Ilya Kantor <iliakan@gmail.com> wrote:
>>>>>
>>>>>
>>>>> Right now in "git help rebase" for --no-ff:
>>>>> "Without --interactive, this is a synonym for --force-rebase."
>>>>>
>>>>> But *with* --interactive, is there any difference?
>>>>
>>>>
>>>>
>>>> I found
>>>>
>>>>
>>>> https://code.googlesource.com/git/+/b499549401cb2b1f6c30d09681380fd519=
938eb0
>>>> from 2010-03-24
>>>
>>>
>>>
>>> In the original discussion around this option [1], at one point I
>>> proposed
>>> teaching rebase--interactive to respect --force-rebase instead of addin=
g
>>> a
>>> new option [2].  Ultimately --no-ff was chosen as the better user
>>> interface
>>> design [3], because an interactive rebase can't be "forced" to run.
>>>
>>> At the time, I think rebase--interactive only recognized --no-ff.  That
>>> might have been muddled a bit in the migration to rebase--helper.c.
>>>
>>> Looking at it now, I don't have a strong opinion about keeping both
>>> options
>>> or deprecating one of them.
>>>
>>>                  M.
>>>
>>> [1] https://public-inbox.org/git/4B9FD9C1.9060200@xiplink.com/t/
>>> [2]
>>>
>>> https://public-inbox.org/git/1269361187-31291-1-git-send-email-marcnarc=
@xiplink.com/
>>> [3] https://public-inbox.org/git/7vzl1yd5j4.fsf@alter.siamese.dyndns.or=
g/
>>>
>>>
>>>>       Teach rebase the --no-ff option.
>>>>
>>>>       For git-rebase.sh, --no-ff is a synonym for --force-rebase.
>>>>
>>>>       For git-rebase--interactive.sh, --no-ff cherry-picks all the
>>>> commits
>>>> in
>>>>       the rebased branch, instead of fast-forwarding over any unchange=
d
>>>> commits.
>>>>
>>>>       --no-ff offers an alternative way to deal with reverted merges.
>>>> Instead of
>>>>       "reverting the revert" you can use "rebase --no-ff" to recreate
>>>> the
>>>> branch
>>>>       with entirely new commits (they're new because at the very least
>>>> the
>>>>       committer time is different).  This obviates the need to revert
>>>> the
>>>>       reversion, as you can re-merge the new topic branch directly.
>>>> Added
>>>> an
>>>>       addendum to revert-a-faulty-merge.txt describing the situation a=
nd
>>>> how to
>>>>       use --no-ff to handle it.
>>>>
>>>> which sounds as if there is?
>>>>
>>>> Stefan
>>>>
>>>
>
