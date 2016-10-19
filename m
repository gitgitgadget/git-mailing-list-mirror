Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1982098B
	for <e@80x24.org>; Wed, 19 Oct 2016 16:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941087AbcJSQXa (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 12:23:30 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36298 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941075AbcJSQX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 12:23:28 -0400
Received: by mail-qk0-f182.google.com with SMTP id o68so44602513qkf.3
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 09:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LSxW+iluaQRecGEFp9dY8nf2SY+iRceU4RJfdddfPdQ=;
        b=Uo9pCc4Sev5yzhSczLprV4xEBsuT19I4Y3i6txChhHmRVHvCAjI15+JxOQ1cESUfXB
         0e6cVbAtutwtDNZuBTlV2/et5U0Rz62ozh/zm8xwRU26UMzOxPFQHtFdHvt5G7Rxmei5
         8DDO0cdRv91wjLpE4CDDcu/Pv5kGTMx+ZQuBzXal7utYIIMKc9UACbwC7DRX7UtsPuZ7
         TGfT4bDwmATcYqkMqqKdSilO5I6LYcMhaXh/s3e+7Nzc1Osh56WBlpPU5jfwc4h2l24o
         3mpD+Ltv/3mxRcKnNAtu3/AfT3WzgI8fsS+vBfx/0D/tYoFal7jeJGEoGE5CTJVIQsV6
         TCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LSxW+iluaQRecGEFp9dY8nf2SY+iRceU4RJfdddfPdQ=;
        b=mpJKBtuQzlQfthjNleCtWTiP5l4Gx6qmBwyIJ4lHd9Sc7OeoXy70sCqfaoK3ty1G1t
         MST2llHGGcSx1S7/oPcAYh876fRDeMAFxu3d2Nr3UOYhLGthW44X2PaBTwj46i0cCYjR
         8kg67HZARlA9/Mw5ICupZ9+pCtsXBYOydkdwdDy7nyUGIx9/28dU9fM1lzhRijFxNEce
         pg7WMk/gY5On+BdQsvXiOwzG0fEdhFMAdoWiMy3Lf+cw/YSQlC4MC7ZPtrirIhAw65A/
         AZmwa577kVz3h1nB7L/JpAPgDkNfurU649QAOKVSju04Y53GTKWTQySnxx+COhtFUXDs
         dgqg==
X-Gm-Message-State: ABUngvd5wms+JKkUq2u3plAiVCWY5yWwfBulOGNApXcCT92O7hP2s35KcWR3mkuXy9o3ZNjWLaD5oZvJ9cYL00b1
X-Received: by 10.55.56.11 with SMTP id f11mr6686412qka.255.1476894206926;
 Wed, 19 Oct 2016 09:23:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 19 Oct 2016 09:23:26 -0700 (PDT)
In-Reply-To: <CAHd499CN3+cHVwjOEirwXVu3DsJwPrmJwEgSJL2CHD5CvoYxxg@mail.gmail.com>
References: <CAHd499AN2VHL66c6JWxHqS-1bQ6y4PrGjZJiR_ad6HJsCGpeDQ@mail.gmail.com>
 <CAGZ79kaFtzQDZrSJhJZ59xvBzn+6+UVDO65Ac+T6aFxMQaM_xQ@mail.gmail.com> <CAHd499CN3+cHVwjOEirwXVu3DsJwPrmJwEgSJL2CHD5CvoYxxg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Oct 2016 09:23:26 -0700
Message-ID: <CAGZ79kYKdHHcfRxCOJwNuqnOGMjBBeMy3Av5U7_ssuOp-to61w@mail.gmail.com>
Subject: Re: Integrating submodules with no side effects
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 6:27 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> On Tue, Oct 18, 2016 at 4:17 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, Oct 18, 2016 at 12:35 PM, Robert Dailey
>> <rcdailey.lists@gmail.com> wrote:
>>> Hello git experts,
>>>
>>> I have in the past attempted to integrate submodules into my primary
>>> repository using the same directory name. However, this has always
>>> caused headache when going to and from branches that take you between
>>> when this integration occurred and when it didn't. It's a bit hard to
>>> explain. Basically, if I have a submodule "foo", and I delete that
>>> submodule and physically add its files under the same directory "foo",
>>> when I do a pull to get this change from another clone, it fails
>>> saying:
>>>
>>> error: The following untracked working tree files would be overwritten
>>> by checkout:
>>>         foo/somefile.txt
>>> Please move or remove them before you switch branches.
>>> Aborting
>>> could not detach HEAD
>>>
>>>
>>> Obviously, git can't delete the submodule because the files have also
>>> been added directly. I don't think it is built to handle this
>>> scenario. Here is the series of commands I ran to "integrate" the
>>> submodule (replace the submodule with a directory containing the exact
>>> contents of the submodule itself):
>>>
>>> #!/usr/bin/env bash
>>> mv "$1" "${1}_"
>>> git submodule deinit "$1"
>>
>> This removes the submodule entries from .git/config
>> (and it would remove the contents of that submodule, but they are moved)
>>
>>> git rm "$1"
>>
>> Removing the git link here.
>>
>> So we still have the entries in the .gitmodules file there.
>> Maybe add:
>>
>>     name=$(git submodule-helper name $1)
>>     git config -f .gitmodules --unset submodule.$name.*
>>     git add .gitmodules
>>
>> ? (Could be optional)
>
> Actually I verified that it seems `git rm` is specialized for
> submodules somewhere, because when I run that command on a submodule
> the relevant entries in the .gitmodules file are removed. I did not
> have to do this as a separate step.
>
>>> mv "${1}_" "$1"
>>> git add "$1/**"
>>
>> Moving back into place and adding all files in there.
>>
>>>
>>> The above script is named git-integrate-submodule, I run it like so:
>>>
>>> $ git integrate-submodule foo
>>>
>>> Then I do:
>>>
>>> $ git commit -m 'Integrated foo submodule'
>>>
>>> Is there any way to make this work nicely?
>>
>> I think you can just remove the gitlink from the index and not from the working
>> tree ("git rm --cached $1")
>
> What is the goal of doing it this way? What does this simplify?

You don't have to mv it back and forth with an underscore I would imagine?

>
>>> The only solution I've
>>> found is to obviously rename the directory before adding the physical
>>> files, for example name it foo1. Because they're different, they never
>>> "clash".
>>
>> Also look at the difference between plumbing and porcelain commands[1],
>> as plumbing is more stable than the porcelain, so it will be easier to maintain
>> this script.
>
> Which plumbing commands did you have in mind?

None specifically. I write scripts using porcelain all the time for
personal use.
But if you were planning to publish this seriously then I'd recommend looking at
plumbing commands.

>
>> I think this would be an actually reasonable feature, which Git itself
>> could support via "git submodule [de]integrate", but then we'd also want
>> to see the reverse, i.e. take a sub directory and make it a submodule.
>
> Integrating this as a feature might be fine, I think when you bring up
> the question of retaining history makes things much harder.
> Fortunately for me that is not a requirement in this case, so I'm able
> to do things with much less effort.

That reminds me of subtree merging, which could be used for this case.
(see 'git subtree')

>
> However the primary purpose of my post was to find out how to
> integrate the submodule without the error on next pull by other
> collaborators of my repository. It's a real pain to recover your
> working copy when going inbetween commits where the submodule
> integration happened inbetween them. I did quote the exact error
> message I got in my original post.

You could try this patch series:
https://github.com/jlehmann/git-submod-enhancements/tree/git-checkout-recurse-submodules
(rebased to a newer version; no functional changes:)
https://github.com/stefanbeller/git/tree/submodule-co
(I'll rebase that later to origin/master)

>
> Do you have any info on how I can prevent that error? Ideally I want
> the integration to go smoothly and transparently, not just for the
> person doing the actual transition (me) but for everyone else that
> gets those changes from upstream. They should not even notice that it
> happened (i.e. no failed commands, awkward behavior, or manual steps).

It depends on how long you want to postpone the transition, but I plan to
upstream the series referenced above in the near future,
which would enable your situation to Just Work (tm). ;)
