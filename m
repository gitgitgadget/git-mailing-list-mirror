Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FB9C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 05:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77E360F6B
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 05:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbhI2FHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 01:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242323AbhI2FHY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 01:07:24 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D2EC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 22:05:44 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so1418594otx.3
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 22:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krmonHRgM8yswJ7awlFo2VPaiSHygLjpF79Fms5aXDw=;
        b=WLYmXsMFJ0Iyw2QaA5w3kvUo8RizJ5WmKtJ2Uv6RsiqK55OUu8lLJozbt6h4ahysEw
         wUFUG/kNGYEJYZXdRr9hPdVslUDQVsx3TKD+DRreVCyf2hmABL3tP33Rk6+g0rYNo/zf
         Y7XWuXWqDaEaxTkv2jZfn9+k/t7wdAOuqGSbqZn9UJrBonqecCACtQ4VpmmH7+FGciyI
         b3NNa6nkL495k8LGbZHlN+jAXopIi0W4quKwZkkxPKBV7GrAvRRQWcdsFqFOuwg3I3Ki
         js5Ed3b4RVhqfli6ZDfTkriCgKBKNIfqICuUih+jw9WfZNxmqGq5aXXW++Taf1fjeAd+
         ijxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krmonHRgM8yswJ7awlFo2VPaiSHygLjpF79Fms5aXDw=;
        b=FgJHEcOdnpvDxQb/FsDLKttx9reFXmFgp99i9fjuPUQXu2NpfOffulDNhR3+9EvAZL
         JYFtqHy8tVM/5Vv8vJFr2QcKjNkAsvTLD8f7Q8rcxN9+vrJEDssOfiLdN9lRfLtCpHeI
         C+hikNZThiaPVhNw2Q/9Q/62oAv/juLTPq5c6Ea0zbpmTn3m+PeW7kROrILklt7z3x6n
         c06xX2YKtYmn12tsfGxymzHtxJKPbgxD06m15CPzlz/IZDjfjmVyBSQMszr/2rWvXK3z
         FoPNKIoCackY4D02feK7fvSxVFciNMyzvn0zxcQzSBMVzIaUFqMQyopP11mGJNgcVR5S
         6oCg==
X-Gm-Message-State: AOAM530gSR5ZEN+N8r5X6aLUnDxLTQyLf4NltOMgGNEsGiHsfdIKcs7Q
        V4Bu0z5D4gol8XgtyMXQAFuINAzu1sQdSyDlKdQ=
X-Google-Smtp-Source: ABdhPJwIPGIsTmG3LQ1L5boSj9Q7S9ck3+RRXqEnNyKEgkvsHSXV5+Uhmsj17fhUWWIbPe2ll/5l7s91rkDFYY72eLg=
X-Received: by 2002:a9d:7751:: with SMTP id t17mr8448848otl.276.1632891943475;
 Tue, 28 Sep 2021 22:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <YVOiggCWAdZcxAb6@coredump.intra.peff.net>
In-Reply-To: <YVOiggCWAdZcxAb6@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Sep 2021 22:05:31 -0700
Message-ID: <CABPp-BFuj3W20J-aKU4BL9cqgA-GPZ2prEbAebY_kR0adaGzHw@mail.gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing primary
 object dirs
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 4:17 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 31, 2021 at 02:26:38AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > The tmp_objdir API provides the ability to create temporary object
> > directories, but was designed with the goal of having subprocesses
> > access these object stores, followed by the main process migrating
> > objects from it to the main object store or just deleting it.  The
> > subprocesses would view it as their primary datastore and write to it.
> >
> > For the --remerge-diff option we want to add to show & log, we want all
> > writes of intermediate merge results (both blobs and trees) to go to
> > this alternate object store; since those writes will be done by the main
> > process, we need this "alternate" object store to actually be the
> > primary object store.  When show & log are done, they'll simply remove
> > this temporary object store.
>
> I think this is consistent with the original design of tmp_objdir. I
> just never needed to do anything in-process before, so overriding the
> environment of sub-processes was sufficient.
>
> I do think these are dangerous and may cause bugs, though. Anything you
> write while the tmp_objdir is marked as "primary" is going to go away
> when you remove it. So any object names you reference outside of that,
> either:
>
>   - by another object that you create after the tmp_objdir is removed;
>     or
>
>   - in a ref
>
> are going to turn into repository corruption. Of course that's true for
> the existing sub-processes, too, but here we're touching a wider variety
> of code.
>
> Obviously the objects we write as part of remerge-diff are meant to be
> temporary, and we'll never reference them in any other way. And usually
> we would not expect a diff to write any other objects. But one thing
> that comes to mind if textconv caching.
>
> If you do a remerge diff on a blob that uses textconv, and the caching
> feature is turned on, then we'll write out a new blob with the cached
> value, and eventually a new tree and refs/notes/ pointer referencing it.
> I'm not sure of the timing of all of that, but it seems likely to me
> that at least some of that will end up in your tmp_objdir.

Interesting.  Thanks for explaining this case, and for the testcase in
the other thread.

So there are other parts of running `git log` that are not read-only,
besides what I'm doing.  That's unfortunate.  Can we just disable
those things in this section of the code?

Also, I think it makes sense that textconv caching causes a problem
via writing new blobs and trees *and* refs that reference these blobs
and trees.  However, I'm not sure I'm really grasping it, because I
don't see how your solutions are safe either.  I'll mention more after
each one.

> If you remove the tmp_objdir as the primary as soon as you're done with
> the merge, but before you run the diff, you might be OK, though.

It has to be after I run the diff, because the diff needs access to
the temporary files to diff against them.

> If not, then I think the solution is probably not to install this as the
> "primary", but rather:
>
>   - do the specific remerge-diff writes we want using a special "write
>     to this object dir" variant of write_object_file()
>
>   - install the tmp_objdir as an alternate, so the reading side (which
>     is diff code that doesn't otherwise know about our remerge-diff
>     trickery) can find them
>
> And that lets other writers avoid writing into the temporary area
> accidentally.

Doesn't this have the same problem?  If something similar to textconv
caching were to create new trees that referenced the existing blobs
and then added a ref that referred to that tree, then you have the
exact same problem, right?  The new tree and the new ref would be
corrupt as soon as the tmp-objdir went away.  Whether or not other
callers write to the temporary area isn't the issue, it's whether they
write refs that can refer to anything from the temporary area.  Or am
I missing something?

> In that sense this is kind of like the pretend_object_file() interface,
> except that it's storing the objects on disk instead of in memory. Of
> course another way of doing that would be to stuff the object data into
> tempfiles and just put pointers into the in-memory cached_objects array.
>
> It's also not entirely foolproof (nor is the existing
> pretend_object_file()). Any operation which is fooled into thinking we
> have object X because it's in the fake-object list or the tmp_objdir may
> reference that object erroneously, creating a corruption. But it's still
> safer than allowing arbitrary writes into the tmp_objdir.

Why is the pretend_object_file() interface safer?  Does it disable the
textconv caching somehow?  I don't see why it helps avoid this
problem.

>   Side note: The pretend_object_file() approach is actually even better,
>   because we know the object is fake. So it does not confuse
>   write_object_file()'s "do we already have this object" freshening
>   check.

Oh, that's interesting.  That would be helpful.

>   I suspect it could even be made faster than the tmp_objdir approach.
>   From our perspective, these objects really are tempfiles. So we could
>   write them as such, not worrying about things like fsyncing them,
>   naming them into place, etc. We could just write them out, then mmap
>   the results, and put the pointers into cached_objects (currently it
>   insists on malloc-ing a copy of the input buffer, but that seems like
>   an easy extension to add).
>
>   In fact, I think you could get away with just _one_ tempfile per
>   merge. Open up one tempfile. Write out all of the objects you want to
>   "store" into it in sequence, and record the lseek() offsets before and
>   after for each object. Then mmap the whole result, and stuff the
>   appropriate pointers (based on arithmetic with the offsets) into the
>   cached_objects list.
>
>   As a bonus, this tempfile can easily be in $TMPDIR, meaning
>   remerge-diff could work on a read-only repository (and the OS can
>   perhaps handle the data better, especially if $TMPDIR isn't a regular
>   filesystem).

Interesting.  I'm not familiar with the pretend_object_file() code,
but I think I catch what you're saying.  I don't see anything in
object-file.c that allows removing items from the cache, as I would
want to do, but I'm sure I could add something.

(I'm still not sure how this avoids the problem of things like
textconv caching trying to write an object that references one of
these, though.  Should we just manually disable textconv caching
during a remerge-diff?)

> > We also need one more thing -- `git log --remerge-diff` can cause the
> > temporary object store to fill up with loose objects.  Rather than
> > trying to gc that are known garbage anyway, we simply want to know the
> > location of the temporary object store so we can purge the loose objects
> > after each merge.
>
> This paragraph confused me. At first I thought you were talking about
> how to avoid calling "gc --auto" because we don't want to waste time
> thinking all those loose objects were worth gc-ing. But we wouldn't do
> that anyway (git-log does not expect to make objects so doesn't call it
> at all, and anyway you'd expect it to happen at the end of a process,
> after we've already removed the tmp_objdir).
>
> But I think you just mean: we can build up a bunch of loose objects,
> which is inefficient. We don't want to gc them, because that's even less
> efficient. So we want to clean them out between merges.

Yes, sorry that wasn't clear.

> But I don't see any code to do that here. I guess that's maybe why
> you've added tmp_objdir_path(), to find them later. But IMHO this would
> be much better encapsulated as tmp_objdir_clear_objects() or something.
>
> But simpler still: is there any reason not to just drop and re-create
> the tmp-objdir for each merge? It's not very expensive to do so (and
> certainly not compared to the cost of actually writing out the objects).

Ooh, indeed.  I like that, and it turns out that the majority of the
cost of dropping the tmp_objdir is the recursive directory removal,
that I wanted anyway as part of me inbetween-merges cleanup.

But, of course, if we go the pretend_object_file() route then the
tmp_objdir() stuff probably becomes moot.
