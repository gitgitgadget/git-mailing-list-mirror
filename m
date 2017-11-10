Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E161201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 03:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755780AbdKJDhe (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 22:37:34 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:40770 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755757AbdKJDhd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 22:37:33 -0500
Received: by mail-wm0-f45.google.com with SMTP id b9so51064wmh.5
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 19:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wQh4TC6PBD5oUGKHsOwdVHwZuVHD3lDgXwuEd26URhM=;
        b=KqjJWizyKOjdNdkH/INcUFDcSdCYl4GUpHyMPs1NDFKe05sAMF+zjOg4SQKa/1qT5e
         EsZ5Z8nuCvMKB9YRWb3f1T+4XIKEnJ49ENw3M5Se6urVvhIK942FBrDvaqcqjMjBtlc1
         rAArPjWhCysTV/ELXJjyXaXzVD1BpZR3rK11oB7xnS4Q5G/Z7PVhJ3jMNb/w7gY8GHMQ
         dfLyD9LJzatcFauvS9DlCvKGJ4AzExpOdwcGYeEKpAsF0mhJ36UuoOUq/zaEyDGOn3Gi
         9gzGzaw6QS4HsUf9u0baBo8DSt1Bt1WlUxGu0x6ytKG9pdZro2Cp8NMxgL2H5xINJOKo
         V1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wQh4TC6PBD5oUGKHsOwdVHwZuVHD3lDgXwuEd26URhM=;
        b=HOS0MHkdEzAQijP4rnHyyYf1HwZRz5t2NqozQFzkg66upbB/xjBn8dtbsL4LBRiMq2
         Mf8vjeKQLlbg3NKAU3Wc0XM+ju0XxRBY+WgG23RxYMplx8U9Zd3pBJN1GY74wzIIOX97
         KmZeNPiHACkdo+Qcml2lFfWnjmFm6rYBtfBb5m9N0yUu+v0l28OmJTT/ku7zb3a2o+Kx
         WH0lU/xiCLSkjjqhmLAbrtnWzZrh32aWl0vNCLEVoQ13QnYjDakMpQIEA5kZv5c612On
         SN/Ohm8l9WxaBihFiqhqtVPPu99maVN9bgdQgXHxwJdyyLPYlewkfS6z6LlTwJHiHbkt
         x9PQ==
X-Gm-Message-State: AJaThX6NwVnEUKIfE+2ctcvEV1LswYApffq36C53dHInpbWHRkt/9wrz
        gomjZSCqzViiBcgCrK6i83kLP5pSMwHGdAEoU3t8TQ==
X-Google-Smtp-Source: ABhQp+RMZi+oH4qzzTowma6o+lpqHEyRCt04xBJ9N/2E+Uhotv1Z8RQFir5t2/hUBCccz1eIID3t9SIrPGxmddQ/QUo=
X-Received: by 10.80.137.91 with SMTP id f27mr571684edf.18.1510285051843; Thu,
 09 Nov 2017 19:37:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.136.103 with HTTP; Thu, 9 Nov 2017 19:37:11 -0800 (PST)
In-Reply-To: <CAGZ79kZAvMKQUjbqWZkhy39sE5e9k1DmkiA42ywiw2NgY1+Xig@mail.gmail.com>
References: <20171108143646.2e1870a82360072557094e01@google.com>
 <20171109001007.11894-1-sbeller@google.com> <CA+P7+xpTCHHNG1tAhysOFV5jFHpXdzRk5zfYNHUUVdYiGY55cA@mail.gmail.com>
 <CAGZ79kZAvMKQUjbqWZkhy39sE5e9k1DmkiA42ywiw2NgY1+Xig@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 9 Nov 2017 19:37:11 -0800
Message-ID: <CA+P7+xoA5KNW7PEiW0wZp-aohsKbnH8AGAvkk3Y3Ghv=Jhp+hw@mail.gmail.com>
Subject: Re: [RFD] Long term plan with submodule refs?
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 9, 2017 at 12:16 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Nov 8, 2017 at 10:54 PM, Jacob Keller <jacob.keller@gmail.com> wr=
ote:
>> On Wed, Nov 8, 2017 at 4:10 PM, Stefan Beller <sbeller@google.com> wrote=
:
>>>> The relationship is indeed currently useful, but if the long term plan
>>>> is to strongly discourage detached submodule HEAD, then I would think
>>>> that these patches are in the wrong direction. (If the long term plan =
is
>>>> to end up supporting both detached and linked submodule HEAD, then the=
se
>>>> patches are fine, of course.) So I think that the plan referenced in
>>>> Junio's email (that you linked above) still needs to be discussed.
>>>
>>
>>> New type of symbolic refs
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>>> A symbolic ref can currently only point at a ref or another symbolic re=
f.
>>> This proposal showcases different scenarios on how this could change in=
 the
>>> future.
>>>
>>> HEAD pointing at the superprojects index
>>> ----------------------------------------
>>> Introduce a new symbolic ref that points at the superprojects
>>> index of the gitlink. The format is
>>>
>>>   "repo:" <superprojects gitdir> '\0' <gitlink-path> '\0'
>>>
>>> Just like existing symrefs, the content of the ref will be read and fol=
lowed.
>>> On reading "repo:", the sha1 will be obtained equivalent to:
>>>
>>>     git -C <superproject> ls-files -s <gitlink-path> | awk '{ print $2}=
'
>>>
>>> Ref write operations driven by the submodule, affecting symrefs
>>>   e.g. git checkout <other branch> (in the submodule)
>>>
>>> In this scenario only the HEAD is optionally attached to the superproje=
ct,
>>> so we can rewrite the HEAD to be anything else, such as a branch just f=
ine.
>>> Once the HEAD is not pointing at the superproject any more, we'll leave=
 the
>>> submodule alone in operations driven by the superproject.
>>> To get back on the superproject branch, we=E2=80=99d need to invent new=
 UX, such as
>>>    git checkout --attach-superproject
>>> as that is similar to --detach
>>>
>>
>> Some of the idea trimmed for brevity, but I like this aspect the most.
>> Currently, I work on several projects which have multiple
>> repositories, which are essentially submodules.
>>
>> However, historically, we kept them separate. 99% of the time, you can
>> use all 3 projects on "master" and everything works. But if you go
>> back in time, there's no correlation to "what did the parent project
>> want this "COMMON" folder to be at?
>
> So an environment where "git submodule update --remote" is not that
> harmful, but rather brings the joy of being up to date in each project?
>
>> I started promoting using submodules for this, since it seemed quite nat=
ural.
>>
>> The core problem, is that several developers never quite understood or
>> grasped how submodules worked. There's problems like "but what if I
>> wanna work on master?" or people assume submodules need to be checked
>> out at master instead of in a detached HEAD state.
>
> So the documentation sucks?
>
> It is intentional that from the superprojects perspective the gitlink
> must be one
> exact value, and rely on the submodule to get to and keep that state.
>
> (I think we once discussed if setting the gitlink value to 00...00 or oth=
erwise
> signal that we actually want "the most recent tip of the X branch" would =
be
> a good idea, but I do not think it as it misses the point of versioning)
>
>> So we often get people who don't run git submodule update and thus are
>> confused about why their submodules are often out of date. (This can
>> be solved by recursive options to commands to more often recurse into
>> submodules and checkout and update them).
>>
>> We also often get people who accidentally commit the old version of
>> the repository, or commit an update to the parent project pointing the
>> submodule at some commit which isn't yet in the upstream of the common
>> repository.
>
> Would an upstream prereceive hook (maybe even builtin and accessible via
> 'receive.denyUnreachableSubmodules') help? (It would require submodules
> to be defined with relative URLs in the .gitmodules file and then the rec=
eive
> command can check for the gitlink value present in this other repository)
>
>> The proposal here seems to match the intuition about how submodules
>> should work, with the ability to "attach" or "detach" the submodule
>> when working on the submodule directly.
>
> Well I think the big picture discussion is how easy this attaching or
> detaching is. Whether only the HEAD is attached or detached, or if we
> invent a new refstore that is a complete new submodule thing, which
> cannot be detached from the superproject at all.
>
>> Ideally, I'd like for more ways to say "ignore what my submodule is
>> checked out at, since I will have something else checked out, and
>> don't intend to commit just yet."
>
> This is in the superproject, when doing a git add . ?
>

Yes.

>> Basically, a workflow where it's easier to have each submodule checked
>> out at master, and we can still keep track of historical relationship
>> of what commit was the submodule at some time ago, but without causing
>> some of these headaches.
>
> So essentially a repo or otherwise parallel workflow just with the versio=
ning
> happening magically behind your back?

Ideally, my developers would like to just have each submodule checked
out at master.

Ideally, I'd like to be able to checkout an old version of the parent
project and have it recorded what version of the shared submodule was
at at the time.

Ideally, my developers don't want to have to worry about knowing that
they shouldn't "git add -a" or "git commit -a" when they have a
submodule checked out at a different location from the parent projects
gitlink.

Thanks,
Jake

>
>> I've often tried to use the "--skip-worktree" bit to have people set
>> their repository to ignore the submodule. Unfortunately, this is
>> pretty complex, and most of the time, developers never remember to do
>> this again on a fresh clone.
>
> That sounds interesting.
>
> Thanks,
> Stefan
