Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1ADC433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 02:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbiBKCkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 21:40:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241955AbiBKCkA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 21:40:00 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE2155AD
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 18:39:59 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id f9-20020a170902684900b0014cd6059ecdso2607726pln.7
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 18:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q07c9KiPHJEaItpmJ3BAh2D4g3iRHjOZVSBF0dhoQgs=;
        b=NWhlWmjDcl8h6uto18KhvOvXW21x7WqUdGL592BaG7hq5n8NnyH/AuUHO27mSpVf49
         jwQHEeJ9XCpfbNHNJbQsA0LOFMV0KVgcSz+KUAUlTcK66riFkzC9R5jqIQj/i39m+EZP
         GyDxNW0ze/FYVMB7h+h40iK0vu+KHTkGMBsbi/CoOPsGtEnx8kwtTX8xtBXlavV9SQoO
         ELGgk1RnNekNCIOi4WkLExMHUwXZDbzobYVZTfbSRE++VIDierP1van/gjBFKUhtwhys
         OSteVWiXjUWU3b4rUJX2R5eYVVz8entvuylc2K8kqIucKPGj7ryGzWMrvDaLIpA5WrPB
         tgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q07c9KiPHJEaItpmJ3BAh2D4g3iRHjOZVSBF0dhoQgs=;
        b=0K4IJaSxB+QDM0xPp+sXUaHcWM4EYqHZ7anM9bCCwda43vHQPKIh9fv1cuCBED9fG2
         M5/wwJvxAc8gcH5t/JvLoFTAlJkWlrSFqd/SvK0KzLtj9/D/lho9a/fgFLRaZ0bfzr6j
         BJzyMyleQ5XOrzva9F+b1ZBtDiyPH9XLqZVr3Vu5reJPdAyNEFbcLDqDus/iXFr/Jrfn
         1yK+PhsfGWMd98dN6z5595WSX2djA58Sx4gPOIUYHF2Jk8zMS1e3G3ykGUxxA7WWD+Ut
         Q0YPLlhkY3gVoRKDP6tQGQSRfIMg/G4PNqHaD/asstvuWL4TpvNL/lV4fg2vHej/9NvR
         KXpw==
X-Gm-Message-State: AOAM530t+PYEmTr/znY+CC5Bdl0M09rS9rj1Qkbqakmzt5sjOtU1YnnB
        IG9/WF8UZUCbm881JT07R1Dc5XRdQpKBpQ==
X-Google-Smtp-Source: ABdhPJz6b5nKzKD8WEyt58FvcuLRoOZTL1PraMf4iVFerCIMeMYIvYV45kHEKZDl9L8cmT6m/F2oixZXtqTa8w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d2ca:: with SMTP id
 n10mr10479614plc.28.1644547199364; Thu, 10 Feb 2022 18:39:59 -0800 (PST)
Date:   Fri, 11 Feb 2022 10:39:56 +0800
In-Reply-To: <xmqqleyivcvv.fsf@gitster.g>
Message-Id: <kl6ltud6dt37.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <xmqqsfsrw67a.fsf@gitster.g>
 <kl6lzgmzdrz2.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqleyivcvv.fsf@gitster.g>
Subject: Re: [PATCH 0/8] fetch --recurse-submodules: fetch unpopulated submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> The real question is not "in which submodules we fetch", but "what
>>> commits we fetch in these submodules".  I do not think there is a
>>> good answer to the latter.
>>>
>>> Of course, we we take this sequence instead:
>>>
>>> 	git checkout branch-with-submodules
>>> 	git fetch --recurse-submodules
>>> 	git checkout --recurse-submodules branch-with-submodules
>>> 	
>>> things should work correctly (I think we both are assuming that the
>>> other side allows to fetch _any_ object, not just ref), as "fetch"
>>> knows what superproject commit it is asked to complete, unlike the
>>> previous example you gave, where it does not have a clue on what
>>> superproject commit it is preparing submodules for, right?
>>
>> So, given my prior description of recursive fetch, we actually _do_ know
>> which superproject commits to prepare for and which submodule commits to
>> fetch.
>
> Just to make sure I understand what is going on, let me rephrase.
>
>  * To find out which submodule commits we need to fetch, we find new
>    commits in the superproject we just fetched, inspect the trees of
>    these commits to see gitlinks that name commits we need to fetch
>    into the submodule repositories.
>
>  * For that to work well, we need to know, from the path these
>    commits appear in the trees of the superproject, to find out from
>    which submodule to fetch these commits from.  And to make the
>    mapping from paths to submodule names, we need to read
>    .gitmodules from the same superproject commit we found the
>    submodule commit in (as during the history of the superproject,
>    the submodule may have moved around).
>
> If so, I understand why being able to read .gitmodules from
> superproject commits is essential.  The flow would become like
>
>  (1) fetch in the superproject
>
>  (2) iterate over each new superproject commit:
>      - read its .gitmodules
>      - iterate over each gitlink found in the superproject commit:
>        - map the path we found gitlink at into module name
>        - find the submodule repository initialized for the module
>          - if the submodule is not of local interest, skip
>          - add the submodule commit pointed by gitlink to the
>            set of commits that need to be fetched for the submodule [*]
>
>  (3) iterate over each submodule we found more than one commits that
>      need to be fetched in, and fetch these commits (we do not have
>      to go over the network to re-fetch commits that exist in the
>      object store and are reachable from the refs, but "fetch"
>      already knows how to optimize that).
>
> Am I on the right track?

Yup, I think that's quite an accurate description. In particular..

>  (2) iterate over each new superproject commit:
>      - read its .gitmodules

Prior to this series, .gitmodules is read from the filesystem even
though we may notice the missing commit in a non-checked-out
superproject commit.

>  (3) iterate over each submodule we found more than one commits that
>      need to be fetched in, and fetch these commits

Yes, this describes the new "fetch changed submodules behavior"
accurately. However, we also attempt to fetch checked out submodules,
and this is where the two fetching strategies, "yes" and "on-demand" [1]
matter:

"yes", aka "--recurse-submodules" tells "git fetch" to attempt to fetch
_every_ checked out submodule regardless of whether Git thinks it has
missing commits (if we do not find any missing commits, I believe it
defaults to the "git fetch <remote-name>" form). [2]

"on-demand", aka "--recurse-submodules=on-demand", is the 'default'
option. (It is 'default' as in the sense of not passing a
"--recurse-submodules" arg, not default as in passing
"--recurse-submodules" without an "="). With "on-demand", we _only_
attempt to fetch changed submodules. Vis-a-vis "yes", this strategy has
no effect on fetching non-checked-out submodules because we only
fetch changed, non-checked-out submodules anyway, but it lets us ignore
unchanged, checked out submodules.

[1] From Documentation/fetch-options.txt:

--recurse-submodules[=yes|on-demand|no]::
  This option controls if and under what conditions new commits of
  populated submodules should be fetched too. It can be used as a
  boolean option to completely disable recursion when set to 'no' or to
  unconditionally recurse into all populated submodules when set to
  'yes', which is the default when this option is used without any
  value. Use 'on-demand' to only recurse into a populated submodule
  when the superproject retrieves a commit that updates the submodule's
  reference to a commit that isn't already in the local submodule
  clone. By default, 'on-demand' is used, unless
`fetch.recurseSubmodules` is set (see linkgit:git-config[1]).

[2] Sidenote on the "yes" option: I think the rationale for doing
unconditional fetches is not clear to reviewers. Admittedly, beyond 'the
test suite fails', I don't really remember why either. I'll dig into
this as I respond to the reviewer feedback.
