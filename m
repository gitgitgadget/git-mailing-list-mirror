Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41CCC20285
	for <e@80x24.org>; Wed, 30 Aug 2017 13:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbdH3NRb (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 09:17:31 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38656 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdH3NR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 09:17:29 -0400
Received: by mail-wr0-f196.google.com with SMTP id j3so4143924wrb.5
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t+mug157P2NhQkkLXp7J/gJjCivjgZa7NW9cZxVEz8E=;
        b=ah6mO+ANe0trLXhhsKinzeryaBlV2zOLTH0bJvGlW04pEnJzEjBk0H54IEcUVSK2AM
         qN+3/D1gQyPXkSmwHdcc55VwVQ6/n72XbaBR2O3OSNhOsYuVUxgZUxYcxz85HVPUgya/
         gdOhTJDeFE1XvP1lbeqt7OElqT7Vq7yT2tg0TvTaXf0l4n3b06CqmlsoUT7V69f+0Rak
         LCrXVCd/C7hKkhuISiPd29wJgkTj6ABNTHSS3BuIOCA6ZOhL7Dw0FKDmPaSIgJSLT2Nj
         yxTJO0mx27YfCqNIsOZmxXThymEElDm8QjeZuKX0urTqIWEQj9fFrMi57PnvcpOGJe+3
         Lmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+mug157P2NhQkkLXp7J/gJjCivjgZa7NW9cZxVEz8E=;
        b=YjQdTGGnhtfFQeJoYuEvIaQEpSnz9Uejs+nO9SCAgL1gGKTfuQHzjs023czGg+J5MS
         3TFvGTegDhJKac4RgaeLl//PHiKUZ7IsGeYM5Xb33qOU96ygltxRct0knUfRrB+Yj6VR
         eunApkPx2JRWtJjESft+60ZEmzmd2UCVQoln9aaIy/ZwWPRdolcNOqAc1rgTp8eACyFz
         tcynBSqI7lcykhUWfN7HKfSf2K8LGRSFjui8rzqiExVgF5b5WwEz/ne4aMbbxrnJYmWT
         KbsmdaWlLsgggzWCiUxeFY6MKzLXkm3eUJACVBrzB0Cywx7mqjHc+6T7VfeR2XbKSClL
         hdbA==
X-Gm-Message-State: AHYfb5hpSCIwzMAR7CmigFbEIw0fQC1tM7xZKRsqnRtnMOUjK04oKnWs
        +x2pc7ETc/2n2Q==
X-Received: by 10.223.136.206 with SMTP id g14mr1087795wrg.272.1504099048184;
        Wed, 30 Aug 2017 06:17:28 -0700 (PDT)
Received: from mimir ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id m16sm4360222wrg.16.2017.08.30.06.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Aug 2017 06:17:27 -0700 (PDT)
Date:   Wed, 30 Aug 2017 14:17:25 +0100
From:   Richard Maw <richard.maw@gmail.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/7] Implement ref namespaces as a ref storage backend
Message-ID: <20170830131725.GE2021@mimir>
References: <20170813193611.4233-1-richard.maw@gmail.com>
 <CAMy9T_HNGEv+HX7Zyj+g9i=vmrB+hTx7NJdd=FVatZRUv1b-yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMy9T_HNGEv+HX7Zyj+g9i=vmrB+hTx7NJdd=FVatZRUv1b-yQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2017 at 06:17:07PM +0200, Michael Haggerty wrote:
> On Sun, Aug 13, 2017 at 9:36 PM, Richard Maw <richard.maw@gmail.com> wrote:
> > [...]
> > Fortunately the pluggable ref backends work provided an easier starting point.
> 
> :-) I'm glad my years-long obsession is finally yielding fruit.
> 
> First a general comment about the approach...
> 
> I've always thought that a workable "Git with namespaces" would
> probably look more like git worktrees:
> 
> * One main repository holding all of the objects and all of the
> non-pseudo references.
> 
> * One lightweight directory per namespace-view, holding the
> "core.namespace" config and the pseudorefs. HEAD should probably be
> stored in the main repository (?).

I had pondered something like this as a later extension,
since it's an iterable way of finding out which namespaces exist in a repository
and allows you to explicitly say which namespaces are meant to exist
since looking for all (refs/namespaces/[^/]+/).*HEAD
will also return HEADs that were created by requesting a symbolic ref creation.

Given how many of my problems have been because
namespaced head isn't located at ${GITDIR}/HEAD
I'm not sure how this helps.

> Both the main repository and the namespace-view directories would probably be
> bare, though perhaps somebody can think of an application for allowing
> non-bare repositories.

The only application I've come up with so far is:

1.  Your git server stores configuration in git repositories (gitano does).
2.  The configuration is stored in a git namespace (gitano wants to do this).
3.  Instead of making a clone of the namespace, making changes and pushing that
    it would be nicer to create a workspace to make the changes in instead.

It's not a particularly strong application,
since normally you'd be administering by doing a clone remotely,
and even if that doesn't work you can do a clone locally and push that.

Similarly you should be able to create a workspace
and check out the namespace's head yourself.

> Even though this scheme implies the need for extra directories, I
> think that it would make it easier to fix a lot of your problems:
> 
> * Each namespace-view could define its own namespace,
> quasi-permanently. You wouldn't have to pass it via the environment.
> (You might even want to *forbid* changing the namespace via the
> environment or command line!) So fetches and pushes from one namespace
> to another would work correctly.
> 
> * There would be one place for each namespace-view's pseudorefs. You
> wouldn't have to squeeze them into a single reference tree.

I'm not sure that un-namespaced pseudorefs are a problem.
At least for the git server use-case you wouldn't typically have them.
It would be nice for it to just work of course.

> * The main repository would know all of the references of all of the
> namespace views, so maintenance tools like `git gc` would work without
> changes.

The same is/will be true for worktrees from walking the gitdirs
stored in the commondir.

> * The namespace-view directories wouldn't be mistakable for full
> repositories, so tools like `git gc` would refuse to run in them. I
> think this would also make it a little bit harder for reference values
> to "leak" from one namespace-view to another.
> 
> * Remote access could use different paths for different
> namespace-views. The externally-visible path need not, of course, be
> the same as the path of the namespace-view's directory.

This talk of worktrees got me thinking about an alternative implementation
where instead of mangling refs to add and remove prefixes
a separate git directory is maintained, like worktrees,
and the namespace handling in the refs backend would be
to create a files (or reftable) backend for the namespace's git directory.

Having a separate namespave-view would be like having a bare worktree,
which would presumably be just the gitfile.

This would require extra tooling to create namespaces
since you can't just create a sub-namespace by copying some refs
and adding a symbolic ref for HEAD.

However since you can't (or couldn't last time I tried to find a way to)
push a symbolic ref, so the git server needs extra tooling anyway.
You would lose the ability to trivially see sub-namespaces by fetching refs,
but the only use I can think of for that is mirroring for backup.

> By the way, there are certainly still places in the code that don't go
> through the refs API (e.g., the one that Junio found). That's because
> the refs API has still not been used for anything very interesting, so
> the bugs haven't been flushed out. I see you've found some more.
> That's because you're doing something interesting :-)

> > [...]
> > Bugs
> > ----
> >
> > Most boil down to how special refs like HEAD are handled.
> >
> > 1.  Logged messages display the namespaced path,
> >     which a human may deal with but confuses the test suite.
> 
> I think it's clear that the logged messages should reflect the shorter
> reference names, and it is the test suite that needs to be fixed.

It's error messages from inside the files backend.

The namespaced backend gets passed refs with the namespace prepended
and when it produces a message including the ref name the prefix is added.

I'd not put too much thought into ways of fixing this
since if something goes really wrong it's probably more useful
to know the real ref name.

> > 2.  Reflogs for namespaced HEAD are not updated.
> >
> >     This is because resolving HEAD to split the transaction's updates
> >     to add a log only update to HEAD works by transaction_prepare resolving HEAD
> >     using its own ref store rather than the main one,
> >     so the namespace translation isn't performed.
> >     See split_head_update.
> >
> >     The fix for this may be to move the transaction mangling out of the backend,
> >     unless it should be implied that every backend implementation
> >     must be responsible for symbolic ref reflog updates implicitly.
> 
> It probably makes sense for the namespace layer to do this step.
> 
> I think there is a similar problem with `split_symref_update()`. Here
> the problem is trickier, because you don't know how to split the
> update until you have locked the symref, but the locking necessarily
> has to happen in the main-repo backend. So I think there will be
> places where the main-repo backend needs to call back to the namespace
> layer for some things, like deciding what reference names to use in
> error messages and things.

It sounds like perhaps struct ref_store needs a pointer to the "top" backend
for things like refs_resolve_refdup,
but also to store a "parent" and add a render_ref_fn:

    typedef const char *render_ref_fn(struct ref_store *ref_store,
                                      const char *refname,
                                      struct strbuf *result);

This would return the rendered ref.
Passive backends are just:

    const char *backend_render_ref(struct ref_store *ref_store,
                                   const char *refname, struct strbuf *result)
    {
        if (ref_store->parent == NULL)
            return refname;
        return render_ref(ref_store->parent, refname, result)
    }

The namespaced backend would be:

    const char *namespaced_render_ref(struct ref_store *ref_store,
                                      const char *refname,
                                      struct strbuf *result)
    {
        struct namespaced_ref_store *refs = namespaced_downcast(
                        ref_store, "render_ref");

        if (skip_prefix(refname, refs->prefix, &refname) == 0)
            return NULL;

        if (ref_store->parent == NULL)
            return refname;

        return render_ref(ref_store->parent, refname, result)
    }

If a backend did anything more weird it could put the result in *result
and return a pointer into that.

> You'd also want to prevent actions in a namespace-view from affecting
> references outside of that namespace. For example, you shouldn't be
> able to follow a symref from a namespace-view ref to another reference
> in a different namespace. This also implies some cooperation between
> the file-level backend and the namespace layer.

If it's created via the namespaced ref backend it can only point within.
If it's created from a parent namespace then it may be sufficient
to catch it at resolve time and treat it as a broken.

The files backend using REF_ISBROKEN for if a ref resolves to the null OID
seems like sufficient precedent for using it this way.

> I guess it is also clear that symrefs on disk have to contain the full
> reference names of their targets, but when they are read via a
> namespace-view, the caller should see the short name as the target.
> 
> [...]
> 
> Michael
