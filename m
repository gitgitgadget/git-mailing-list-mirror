Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683A6207D6
	for <e@80x24.org>; Thu,  4 May 2017 18:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdEDSah (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 14:30:37 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35928 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755729AbdEDSaI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 14:30:08 -0400
Received: by mail-pg0-f54.google.com with SMTP id q4so5015287pga.3
        for <git@vger.kernel.org>; Thu, 04 May 2017 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZMaFoXC6fGKhFnt3NPT+Zp7mS84NmNV4KoaQqkLHE7Q=;
        b=KasfovtD0WI4dec4PZ4bEk01/zeT1wXk+HCoHD5yAE8JAj+fbjTYaiAz1BrWEeDeY3
         ymiEka6UbpDQVqZAubrhnGw2biMxAsGpRkUu2ws+yU6/p9USjbdPSYJ0t1MB/nf8FOKJ
         azCGFSpAzOz2YNb0qzjVIDiiw28qb1Jp860XMdekyOHfHCpFP6v/fOG/DXXdbTTKHJf/
         EByFkZFdRVE+7i8rdxGpGGiAOQLnd0PMvr34P0bdO4fWGO6YpRtFXPEKc5R8/FUt1GZP
         jDxZ45JPDBuqN8XSQW6MEjZ4OpFTMkV2vRnwbmPITGBnQieHLf7p95Bhx0SPJJRyXmTE
         WLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZMaFoXC6fGKhFnt3NPT+Zp7mS84NmNV4KoaQqkLHE7Q=;
        b=jXrZbNG0mxDpBpnu/rPOXnE8nAR2IkmcDZKIeLD4GEfFtaipOXySB2VJTPEQFWgqGc
         gLC5ezbk03xOdd1Zt2xSszFGNbY0iQwn1MxAlRr8xN63ZmI/os71C6DfObHVKcb2S3Uu
         tKygAEHxHAWpqj/NvMcjxjn+tm9nK1L+OpzzAN8zwfWawTS0rl7hE4I1EhwjWuc4bbAa
         p6Ayqr41O560Oprsq9lmWgy7Mxd3qURZzeFpbTJj4aVHljCqaem77z9Ga+dhJDZLXd/g
         lI5BjAhn8pOlXIqYYvKKijuft6EqSIJR8ZkRPMPczx61YnSpkBiVlBq4eO4htChahaha
         CEMw==
X-Gm-Message-State: AN3rC/70PFWSZR/OQz97NGoEix8vtHkrvz5/Z7i2GEjIb2fF4TNyVg24
        KQHXI6JwFgGx/agzQIe0VRLpaQpyH7c8Dt4=
X-Received: by 10.98.2.213 with SMTP id 204mr12356468pfc.125.1493922607295;
 Thu, 04 May 2017 11:30:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Thu, 4 May 2017 11:30:06 -0700 (PDT)
In-Reply-To: <xmqqa86tbamh.fsf@gitster.mtv.corp.google.com>
References: <20170501190719.10669-1-sbeller@google.com> <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
 <CACsJy8AZevgFda4ZJAmH_Nyrtuk72FUjdk6B8_SJB=n6quPnbw@mail.gmail.com> <xmqqa86tbamh.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 4 May 2017 11:30:06 -0700
Message-ID: <CAGZ79kZiBOrY6Qno_wFpvFHpbpCY0BtriqYGW5JKG+1hfgJwiQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Start of a journey: drop NO_THE_INDEX_COMPATIBILITY_MACROS
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2017 at 7:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>>>> In the long run we may want to drop the macros guarded by
>>>> NO_THE_INDEX_COMPATIBILITY_MACROS. This converts a couple of them.
>>>
>>> Why?
>>
>> Well.. why did you add NO_THE_INDEX_COMP... in the first place? ;-) j/k
>
> That was to mark the code that implements the underlying machinery
> that the code in a particular file has already been vetted and
> converted to be capable of working with an arbitrary index_state
> instance, not just the_index instance.
>
> Your mentioning "at least outside builtin/" shows that you have a
> good understanding of the issue; they are infrastructure code and
> many of them may become more useful if they are enhanced to take an
> index_state instance instead of always working with the_index.  With
> an infrastructure code that insists on working on the_index, an
> application that has something valuable in the_index already needs
> to somehow save it elsewhere before calling the function and use the
> result from the_index before restoring its version.
>
> I think unpack-trees.c used to assume that it is OK to use the_index,
> but after it started taking src/dst_index, it gained NO_THE_INDEX_COMP
> thing.  That's the kind of change in this area we would want to see.
>
>> I attempted the same thing once or twice in the past, had the same
>> impression and dropped it. But I think it's good to get rid of cache_*
>> macros, at least outside builtin/ directory.
>
> One thing that needs to be kept in mind is that a mechanical
> replacement of active_cache[] to the_index.cache[] in the
> infrastructure code does not get us closer to such an improvement.
> In fact, such a patch only has negative value (keep reading until
> the end of the paragraph that begins with "One thing is certain" to
> understand why).
>
> The entry point to a codechain for an important infrastructure code
> that can currently only work with the_index needs to be identified.
> There may be many.  They need to be made to take an index_state
> instance and to pass it through the callchain.  That kind of change
> would be an improvement, and will get us closer to mark the
> resulting code with NO_THE_INDEX_COMP thing.
>
> I think somebody else said this, but I agree that in the longer
> term, we would want to have a "repository" abstraction for in-core
> data structure.
>
> Imagine that a program wants to read into an index_state the tip
> commit of a branch whose name is the same as the current branch in
> one submodule and do something with the objects, while keeping
> the_index for the top-level superproject.  Thanks to Michael's and
> your recent work, we are almost there to have "ref-store" that
> represents the set of refs the submodule in question has that a
> "repository" object that represents the submodule can point at.  We
> can learn the object name at the tip of a specific ref using that
> infrastructure.  Thanks to an ancient change under discussion, we
> can already read the contents of the index file into an instance of
> an index_state that is different from the_index.  But after doing
> these operations, we'd need to actually get to the contents of the
> objects the index_state holds.  How should that work in the
> "repository object represents an in-core repository" world?
>
> What is missing is a way to represent the object store, so that the
> "repository" object can point at an instance of it (which in turn
> may point at a set of its alternates) [*1*].  With that, perhaps the
> most general kind of the infrastructure API that works with an
> index_state instance may additionally take a repository object, or
> perhaps an index_state may have a pointer to the repository where
> the objects listed in it must be taken from (in which case the
> function may take only an index_state).  In the end the enhanced
> function has to allow us to read from the object store of the
> submodule, not from the superproject's.
>
> Depending on how the design of the repository object goes, the
> interface to these functions may have to change.
>
> But one thing is certain. Many users of the API, just like a lot of
> builtin/ code works only with the_index today, will not have to work
> with a non-default repository or a non-default index_state.  Only
> the more advanced and complex "multi-repo" Porcelains would have to
> care.  Keeping active_cache[], active_nr, etc. abstraction would
> isolate the simpler callers from the inevitable code churn we would
> need while getting the "repository" abstraction right.  This is why
> I see that you understood the issues well when you said "builtiln/".
>
> If we want to have the "repository" abstraction, the "object store"
> is the next thing we should be working on, and such a work can take
> inspiration from how the old <active_cache[], active_nr,
> active_alloc, active_cache_changed and *active_cache_tree> tuple was
> turned into an "index" object while allowing the majority of code
> that want to deal with the singleton instance keep using the old
> names via CPP macros.

Thanks for the reply.

So instead of a mechanical replacement, we'd rather want to
see "the_index" not appearing at all outside of builtins, which
implies two things:
* If done properly we can move the macros from cache.h to
  e.g. builtin.h. That way future developers are less tempted
  to use the cache_* macros in the library code.
* we'd have to pass through the_index from the builtin function
  down to the library code, potentially going through multiple
  function. For this it is unclear if we want to start this now, or wait
  until Brandon presents his initial repository object struct, which
  may be suited better for passing-around.

So if I want to further look into refactoring, I'll have a look into
the object store and hold off sending a series that drops the_index.

> Also, dropping compatibility macros at the end of the series is
> unfriendly to fellow developers with WIPs that depend on the
> traditional way of doing things.  It is doubly insulting to them to
> send such a series during the feature freeze period, when it is more
> likely that they are holding off their WIP in an attempt to allow us
> to concentrate more on what we should be, i.e. finding and fixing
> possible regressions at the tip of 'master' to polish the upcoming
> release and help the end users.

Personally I have not noticed large variations of patch volume
correlated to pre-release times.

Thanks,
Stefan
