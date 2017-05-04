Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DDE8207FF
	for <e@80x24.org>; Thu,  4 May 2017 02:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932540AbdEDCs1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 22:48:27 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36108 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932485AbdEDCs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 22:48:26 -0400
Received: by mail-pg0-f42.google.com with SMTP id t7so795372pgt.3
        for <git@vger.kernel.org>; Wed, 03 May 2017 19:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=2MCLmai/gT1lGJUQ9hT1pWOkij/jEM2bkzUCounWyoM=;
        b=rJZT+M9VdDq+umxd0HlgwReW9sGSj7R+Q/KQpjuAzWkMdNQxhcwGKJZ2UeocLmUXkc
         ASmGEk6BwlY3At/cLXvoJDVSiqmWa5Zw1fnkpPs24WK5gp+DjEBIfRs3+nAH3FbC7LKh
         ODmuLaWJHGO53flucYz5ipPy1caKMhpY4xCRPSm78pYaGrma7ook3cS5jV3zXVdhyiRW
         0Znb7UjScZoJy4vpwgIJbmqZloJNfk09cyjJTZKVZ5TTDUAEGOXd7OC1jyR66m9Jxul4
         Wr7YnA6t61Dy57PF2BDCv6aGTLDjxTWni5h2+j+60XRddcW58aIjPpZeUyVtHgy8Usid
         yN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=2MCLmai/gT1lGJUQ9hT1pWOkij/jEM2bkzUCounWyoM=;
        b=Hxlh0RNFGaX/3nE1Q74JSSoEFUCYm5EpoNgp14Me8D904qXBHVzPrsCdt8SsKw28bu
         arYn3uZBG+bhtVBC6mzWyXszKsRgXutiIYog4gStqzo49gMgz0/krW9UxUPLpcA9w9sQ
         fUTnXuQ1kDBZs4QgRkTLBMjwj2/GMDXdzSmP6tp8f5GjMqCMMM82GgjxEGqyY29hVVGC
         6yC5jZhCYppqiewnK5st7gly/sjYW0rVJcYHS6mEGNTRzFW56gqwbLins60GKyW6okim
         HTF3r/9hjol68eatQB8+eYi9COoa/AcCuOOq0u9KviX8em6skmbZ/Lc7YNfYh0C9ot7q
         M4NA==
X-Gm-Message-State: AN3rC/4BjQ5ksMSQ6ruEH1rcRg+FF5wgI37Gk8pWgMS4qrC9c6K0GNTI
        UnsWyWH8TQkmXQ==
X-Received: by 10.84.149.168 with SMTP id m37mr53996124pla.74.1493866105239;
        Wed, 03 May 2017 19:48:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:21be:aa3e:8063:4b3])
        by smtp.gmail.com with ESMTPSA id v13sm758483pgo.44.2017.05.03.19.48.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 19:48:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] Start of a journey: drop NO_THE_INDEX_COMPATIBILITY_MACROS
References: <20170501190719.10669-1-sbeller@google.com>
        <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
        <CACsJy8AZevgFda4ZJAmH_Nyrtuk72FUjdk6B8_SJB=n6quPnbw@mail.gmail.com>
Date:   Wed, 03 May 2017 19:48:22 -0700
Message-ID: <xmqqa86tbamh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>>> In the long run we may want to drop the macros guarded by
>>> NO_THE_INDEX_COMPATIBILITY_MACROS. This converts a couple of them.
>>
>> Why?
>
> Well.. why did you add NO_THE_INDEX_COMP... in the first place? ;-) j/k

That was to mark the code that implements the underlying machinery
that the code in a particular file has already been vetted and
converted to be capable of working with an arbitrary index_state
instance, not just the_index instance.

Your mentioning "at least outside builtin/" shows that you have a
good understanding of the issue; they are infrastructure code and
many of them may become more useful if they are enhanced to take an
index_state instance instead of always working with the_index.  With
an infrastructure code that insists on working on the_index, an
application that has something valuable in the_index already needs
to somehow save it elsewhere before calling the function and use the
result from the_index before restoring its version.

I think unpack-trees.c used to assume that it is OK to use the_index,
but after it started taking src/dst_index, it gained NO_THE_INDEX_COMP
thing.  That's the kind of change in this area we would want to see.

> I attempted the same thing once or twice in the past, had the same
> impression and dropped it. But I think it's good to get rid of cache_*
> macros, at least outside builtin/ directory.

One thing that needs to be kept in mind is that a mechanical
replacement of active_cache[] to the_index.cache[] in the
infrastructure code does not get us closer to such an improvement.
In fact, such a patch only has negative value (keep reading until
the end of the paragraph that begins with "One thing is certain" to
understand why).

The entry point to a codechain for an important infrastructure code
that can currently only work with the_index needs to be identified.
There may be many.  They need to be made to take an index_state
instance and to pass it through the callchain.  That kind of change
would be an improvement, and will get us closer to mark the
resulting code with NO_THE_INDEX_COMP thing.

I think somebody else said this, but I agree that in the longer
term, we would want to have a "repository" abstraction for in-core
data structure.

Imagine that a program wants to read into an index_state the tip
commit of a branch whose name is the same as the current branch in
one submodule and do something with the objects, while keeping
the_index for the top-level superproject.  Thanks to Michael's and
your recent work, we are almost there to have "ref-store" that
represents the set of refs the submodule in question has that a
"repository" object that represents the submodule can point at.  We
can learn the object name at the tip of a specific ref using that
infrastructure.  Thanks to an ancient change under discussion, we
can already read the contents of the index file into an instance of
an index_state that is different from the_index.  But after doing
these operations, we'd need to actually get to the contents of the
objects the index_state holds.  How should that work in the
"repository object represents an in-core repository" world?

What is missing is a way to represent the object store, so that the
"repository" object can point at an instance of it (which in turn
may point at a set of its alternates) [*1*].  With that, perhaps the
most general kind of the infrastructure API that works with an
index_state instance may additionally take a repository object, or
perhaps an index_state may have a pointer to the repository where
the objects listed in it must be taken from (in which case the
function may take only an index_state).  In the end the enhanced
function has to allow us to read from the object store of the
submodule, not from the superproject's.

Depending on how the design of the repository object goes, the
interface to these functions may have to change.

But one thing is certain. Many users of the API, just like a lot of
builtin/ code works only with the_index today, will not have to work
with a non-default repository or a non-default index_state.  Only
the more advanced and complex "multi-repo" Porcelains would have to
care.  Keeping active_cache[], active_nr, etc. abstraction would
isolate the simpler callers from the inevitable code churn we would
need while getting the "repository" abstraction right.  This is why
I see that you understood the issues well when you said "builtiln/".

If we want to have the "repository" abstraction, the "object store"
is the next thing we should be working on, and such a work can take
inspiration from how the old <active_cache[], active_nr,
active_alloc, active_cache_changed and *active_cache_tree> tuple was
turned into an "index" object while allowing the majority of code
that want to deal with the singleton instance keep using the old
names via CPP macros.

Also, dropping compatibility macros at the end of the series is
unfriendly to fellow developers with WIPs that depend on the
traditional way of doing things.  It is doubly insulting to them to
send such a series during the feature freeze period, when it is more
likely that they are holding off their WIP in an attempt to allow us
to concentrate more on what we should be, i.e. finding and fixing
possible regressions at the tip of 'master' to polish the upcoming
release and help the end users.


[Footnote]

*1* Instead we have an ugly hack that lets the singleton object
store add objects from the submodule object store, and it does not
allow us to back out once we did so (unlike the "ref-store" thing
that we could).  When we need to work with a project with many
submodules, we should be able to say "OK, we are done with this
thing for now, call repository_clear() to reclaim the resources we
used to deal with it".

