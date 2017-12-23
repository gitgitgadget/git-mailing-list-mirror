Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8874B1F404
	for <e@80x24.org>; Sat, 23 Dec 2017 13:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbdLWNmB (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 08:42:01 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:37895 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbdLWNl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 08:41:59 -0500
Received: by mail-wr0-f176.google.com with SMTP id o2so30050667wro.5
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 05:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CqBE3fkL4GTKIIOGVYOrss6HUtaBAaIvkHsPRe763Tg=;
        b=NhUf/WnThZhXEGs5i/uqovQ73m2whIW0ROQyAdGEvyUcWy7mynqIEJv1W3hXJWgLbR
         s+DHYC0OG20In5n0nkja3fqAG8WTdJqibnIiAOj51MrKNUzfNwfFbtIIhY9vFWjoU70D
         uHGnokjfRSuwfJOFX7TvludjYK3MV0bDPkCSznAMtHAvwH1zSegnJxO5KxsfB/WOObSX
         TLv8uVUoxcmS+kwR+97/wCmkqYUMUbqOkxDbnTVrjcuK1CFmxr3WHKcZzjcaaPVRkSoj
         KbNhB3Y4Wm8x2AqpdE7tG9eT56jgL5C5fUGhj27p4xzqxCUCWirJ8d5RZDOrcZHXmHFl
         aArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CqBE3fkL4GTKIIOGVYOrss6HUtaBAaIvkHsPRe763Tg=;
        b=KcziBM0cg3BVT27pV1cXFfMzknCt1QDhAHsZbkZ2/oLsMm5F8uFTOhMm6UD3UZOhkK
         l3wUzZ8ZgZCQY0hEqfGyo0nxcxAdyq8+Cr2Q1IVVUZelNQ76hPgVJGET38ZAjt7JXHgH
         o8feIRtIY2+8EoOuhgo7QUZgFpPv56mORI/th/x5GlBbfrJr/kqg3BkhUW39UMx/Fh04
         alFYIS0q073Avsl0lGQMPovvShy9uJm+1x92TffwoAZ6Fb683dG6UR27J2cXud4507co
         Wo7QzxV16XCTSgK+Ds06xQef6tIuYtUxnOnxb6yFfv7xQyYxH1W99K83/ysDXYIXaM03
         i/zQ==
X-Gm-Message-State: AKGB3mIaKFQWxkcaDnCG1Usb54t2xZh8KrQUsw9Ch5yq2t4b0h0fJYX3
        C9RNMEWgmqjbHQNDtS3YJ24kvbWGWUobJ1PP8uU=
X-Google-Smtp-Source: ACJfBovkmOxtukLqo/A7Kh5Z9cI31wc/uDS8PzBq6ZQiIx6I25S+v7is8poPSl11NGFKRO4FKDB9u2ZAcZ2QhoIJIiA=
X-Received: by 10.223.176.52 with SMTP id f49mr18794074wra.105.1514036518445;
 Sat, 23 Dec 2017 05:41:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.151.203 with HTTP; Sat, 23 Dec 2017 05:41:37 -0800 (PST)
In-Reply-To: <FF34D4C2058D44E990BF149F3AB1E010@PhilipOakley>
References: <201711231458.vANEwUMK048049@elephants.elehost.com>
 <003c01d3646c$df78fc50$9e6af4f0$@nexbridge.com> <CAPkN8xJBWRs-2DxViBACLKzAbD1_EBA2MvmWVZmWgL+Sg72znw@mail.gmail.com>
 <CACBZZX4SM45hgA=PW0MEP9Ea0OG_8OTb5U7JCOX7xnd=hT5n3A@mail.gmail.com>
 <CAPkN8xKDQrf+LMpj9GHw9n_crJ1UUwq7Zek+Z1dgQ0n2Jz5U6g@mail.gmail.com> <FF34D4C2058D44E990BF149F3AB1E010@PhilipOakley>
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Sat, 23 Dec 2017 16:41:37 +0300
Message-ID: <CAPkN8xL1tUszvMuwwrc1ym6B6R5TzE4G9jKQ08oY2O_VPc8K_w@mail.gmail.com>
Subject: Re: Re: Unify annotated and non-annotated tags
To:     Philip Oakley <philipoakley@iee.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 3, 2017 at 1:25 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "anatoly techtonik" <techtonik@gmail.com>
>
> comment at end - Philip
>
>
> On Fri, Nov 24, 2017 at 1:24 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Fri, Nov 24, 2017 at 10:52 AM, anatoly techtonik <techtonik@gmail.com=
>
>> wrote:
>>>
>>> On Thu, Nov 23, 2017 at 6:08 PM, Randall S. Becker
>>> <rsbecker@nexbridge.com> wrote:
>>>>
>>>> On 2017-11-23 02:31 (GMT-05:00) anatoly techtonik wrote
>>>>>
>>>>> Subject: Re: Unify annotated and non-annotated tags
>>>>> On Sat, Nov 11, 2017 at 5:06 AM, Junio C Hamano <gitster@pobox.com>
>>>>> wrote:
>>>>>>
>>>>>> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
>>>>>>
>>>>>>> If you would like to mimic output of "git show-ref", repeating
>>>>>>> commits for each tag pointing to it and showing full tag name as
>>>>>>> well, you could do something like this, for example:
>>>>>>>
>>>>>>>       for tag in $(git for-each-ref --format=3D"%(refname)" refs/ta=
gs)
>>>>>>>       do
>>>>>>>               printf '%s %s\n' "$(git rev-parse $tag^0)" "$tag"
>>>>>>>       done
>>>>>>>
>>>>>>>
>>>>>>> Hope that helps a bit.
>>>>>>
>>>>>>
>>>>>> If you use for-each-ref's --format option, you could do something
>>>>>> like (pardon a long line):
>>>>>>
>>>>>> git for-each-ref
>>>>>> --format=3D'%(if)%(*objectname)%(then)%(*objectname)%(else)%(objectn=
ame)%(end)
>>>>>> %(refname)' refs/tags
>>>>>>
>>>>>> without any loop, I would think.
>>>>>
>>>>> Thanks. That helps.
>>>>> So my proposal is to get rid of non-annotated tags, so to get all
>>>>> tags with commits that they point to, one would use:
>>>>> git for-each-ref --format=3D'%(*objectname) %(refname)' refs/tags>
>>>>> For so-called non-annotated tags just leave the message empty.
>>>>> I don't see why anyone would need non-annotated tags though.
>>>>
>>>>
>>>> I have seen non-annotated tags used in automations (not necessarily we=
ll
>>>> written ones) that create tags as a record of automation activity. I a=
m not
>>>> sure we should be writing off the concept of unannotated tags entirely=
. This
>>>> may cause breakage based on existing expectations of how tags work at
>>>> present. My take is that tags should include whodunnit, even if it's j=
ust
>>>> the version of the automation being used, but I don't always get to ha=
ve my
>>>> wishes fulfilled. In essence, whatever behaviour a non-annotated tag h=
as now
>>>> may need to be emulated in future even if reconciliation happens. An o=
ption
>>>> to preserve empty tag compatibility with pre-2.16 behaviour, perhaps? =
Sadly,
>>>> I cannot supply examples of this usage based on a human memory page-fa=
ult
>>>> and NDAs.
>>>
>>>
>>> Are there any windows for backward compatibility breaks, or git is
>>> doomed to preserve it forever?
>>> Automation without support won't survive for long, and people who rely
>>> on that, like Chromium team, usually hard set the version used.
>>
>>
>> Git is not doomed to preserve anything forever. We've gradually broken
>> backwards compatibility for a few core things like these.
>>
>> However, just as a bystander reading this thread I haven't seen any
>> compelling reason for why these should be removed. You initially had
>> questions about how to extract info about them, which you got answers
>> to.
>>
>> So what reasons remain for why they need to be removed?
>
>
> To reduce complexity and prior knowledge when dealing with Git tags.
>
> For example, http://readthedocs.io/ site contains a lot of broken
> "Edit on GitHub" links, for example -
> http://git-memo.readthedocs.io/en/stable/
>
> And it appeared that the reason for that is discrepancy between git
> annotated and non-annotated tags. The pull request that fixes the issue
> after it was researched and understood is simple
> https://github.com/rtfd/readthedocs.org/pull/3302
>
> However, while looking through linked issues and PRs, one can try to
> imagine how many days it took for people to come up with the solution,
> which came from this thread.
> --
> anatoly t.
>
>>>>>>>>
>
> So if I understand correctly, the hope is that `git show-ref --tags` coul=
d
> get an alternate option `--all-tags` [proper option name required...] suc=
h
> that the user would not have to develop the rather over the complicated
> expression that used a newish capability of a different command.
>
> Would that be right?

That's correct.

> Or at least update the man page docs to clarify the annotated vs
> non-annotated tags issue (many SO questions!).

Are there stats how many users read man pages and what is their
reading session length? I mean docs may not help much,

> And indicate if the --dereference and/or --hash options would do the tric=
k!
> - maybe the "^{}" appended would be part of the problem (and need that ne=
w
> option "--objectreference" ).

--dereference would work if it didn't require extra processing.
It is hard to think about other option name that would give
desired result.

--=20
anatoly t.
