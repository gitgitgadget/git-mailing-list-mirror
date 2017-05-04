Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A217207FF
	for <e@80x24.org>; Thu,  4 May 2017 03:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbdEDDYT (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 23:24:19 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35289 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932550AbdEDDYS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 23:24:18 -0400
Received: by mail-pg0-f53.google.com with SMTP id o3so1197977pgn.2
        for <git@vger.kernel.org>; Wed, 03 May 2017 20:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g1kI8V12yDk0iroGx2kIjfNGW7bliRb87/PvQUvphzg=;
        b=bclEaeUNqJAlx7oU0fv9nc6DrjYSpMoDk7G7EAY9iKPUUelJgRV5deAX3WOPn0RPMi
         UMPZRKqtZLtCt9H5dAcj0UPvyHQvtRucVJkM7TGNAxRbzghIx5xJqJMnFWspDrt0bpT+
         txRXigKTT9eQYZDj3zqkXv6LRn6JE7PZaa/fdOjXIpUwEJMZVHyw0nCQJvBzviT/TfYd
         8CB5psSJN2ls6IIl4inT3a6rWQbtQTijTfx3lTCuZHf4vxs7ZO/cgBwiW9Zvjhe1DA7k
         ZnyEgesD9xIF48Tt8OlxAR1w4Uj516EXBpUzUtsZC2JlxOqD0F8htWkFPzMfp8jnt76u
         32BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g1kI8V12yDk0iroGx2kIjfNGW7bliRb87/PvQUvphzg=;
        b=E/2+XrXygpb7Nkk64eqEWRakRXdgcEI3UaWcLZwNRvN4CTeukzyar/Qjk1gnnt017b
         TgCEnU7Quv9A+zILK44oli4G1NcH+7CBwxkjAtyMTriG41JXBjLzK95i0lrmSmK4GAay
         bdSGW5UxJDXVUuJkTnUr27xk/xXwSYtCbsSO9zofoPxhjAeTxl3NO0+GMMEob8muxOUe
         wjHF7EHjdXv9JY/gzc6yBytb1t/xXE4iu3pAB9Nl0J9+yjqrB/NsYCSFZGDcpMtFTcv4
         3NsadllebXhHB3eDEZ2NpHJlzsIgEKXlVn+AJhCULp5lQpGsohSwxRkSmzKWb2noveKj
         /P7A==
X-Gm-Message-State: AN3rC/4qZ4qIkooQffLtlTJuT8pEVbXz09g5b+Mv4+iAgczL2MFAVY8I
        aWajfec6qk7zPeKn
X-Received: by 10.98.9.68 with SMTP id e65mr8267789pfd.177.1493868257692;
        Wed, 03 May 2017 20:24:17 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1c5a:250c:656:7a04])
        by smtp.gmail.com with ESMTPSA id p13sm868649pfl.4.2017.05.03.20.24.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 20:24:16 -0700 (PDT)
Date:   Wed, 3 May 2017 20:24:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] Start of a journey: drop
 NO_THE_INDEX_COMPATIBILITY_MACROS
Message-ID: <20170504032415.GA139188@google.com>
References: <20170501190719.10669-1-sbeller@google.com>
 <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
 <CACsJy8AZevgFda4ZJAmH_Nyrtuk72FUjdk6B8_SJB=n6quPnbw@mail.gmail.com>
 <xmqqa86tbamh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa86tbamh.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/03, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> >>> In the long run we may want to drop the macros guarded by
> >>> NO_THE_INDEX_COMPATIBILITY_MACROS. This converts a couple of them.
> >>
> >> Why?
> >
> > Well.. why did you add NO_THE_INDEX_COMP... in the first place? ;-) j/k
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
> > I attempted the same thing once or twice in the past, had the same
> > impression and dropped it. But I think it's good to get rid of cache_*
> > macros, at least outside builtin/ directory.
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
> 
> Also, dropping compatibility macros at the end of the series is
> unfriendly to fellow developers with WIPs that depend on the
> traditional way of doing things.  It is doubly insulting to them to
> send such a series during the feature freeze period, when it is more
> likely that they are holding off their WIP in an attempt to allow us
> to concentrate more on what we should be, i.e. finding and fixing
> possible regressions at the tip of 'master' to polish the upcoming
> release and help the end users.
> 
> 
> [Footnote]
> 
> *1* Instead we have an ugly hack that lets the singleton object
> store add objects from the submodule object store, and it does not
> allow us to back out once we did so (unlike the "ref-store" thing
> that we could).  When we need to work with a project with many
> submodules, we should be able to say "OK, we are done with this
> thing for now, call repository_clear() to reclaim the resources we
> used to deal with it".
> 

Thanks for the detailed explanation on what a possible transition to
having a repository object would look like.  While digging through the
code it does seem like the object store is one of the main things
holding the code base back from having a repository object.

Thank being said, I spent today hacking away at 'ls-files' in order to
see if it would be feasible to convert it to using a repository object
for the recursive submodule case instead of using run-command.  I picked
'ls-files' mainly because the majority of the code paths don't touch the
object store and mainly deal with manipulating the index.  Despite the
hack-y, cobbled together state that it is in currently it seems very
feasible goal.

-- 
Brandon Williams
