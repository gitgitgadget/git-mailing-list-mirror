Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535B322B8F
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057921; cv=pass; b=s3s9JoaKUJOUTS2QRSksZaSLJO58DnVDetRolgICUJDSN2iZmiOAyy6DyQvwOJ25jBha0nTlBEhyJ1fbnuLgiYEv/kEpjpxOiPVX2K4fCobuCtnFgAQS/vlgmUn5kZj9+YICBzuDH/gswlf6pRlna6Imt6vanwik6OYfUXFLVtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057921; c=relaxed/simple;
	bh=+7V+5TJu33pZIjzwiP8juoacW9TFzWO4c3jkyf4Q/X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sK/jhyzCgSdnsib1G3wHouJptXhFlorKZ9b/th+935KTU6mw+lpM+5vHSbLhoQdRKbrciZ26EGi/dSRiNIaj4qwR9Wfs0jQ4JxFg1T0KQsR2g5dRwa2LTH3DRd3a3ImvH9XruTDKHXKslhyR39OVK+yaE61lCWf+gTVc9kNbVn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=jPKrS1u3; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="jPKrS1u3"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8871ada1a26so16604277b3.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792057917; cv=none;
        d=google.com; s=arc-20260327;
        b=arh3lAQ0BoN4p9W5WP7TfagYl1fzEI6niIDuPSsKyPefoFEgoNyLVLIkT1TSn/Lu9Y
         lWkG0ntjQ61HuG5ugPX2DOSxA51WD6J09ULSLBOGaqLI5uJSLf1IA8SZu9hvLBBAB4h6
         BuPkCYbOdiaGCFkylNRvrzaZOq9pMnPCVGgRZNyMXfXXHI3gqgk7/InYPLcyZFKpkAIE
         V0Hu5qtL2ngewho2KQr/KJ1rMA0VxRQIppe8gr+7Sgt+a+AC/Szr7aichkvF+lOGtUE7
         g3QoaDl5XKdrt3ipRsqx75V5IgAvcMOP2LwJc00T47B6VkLsOiO9Eqky7eQLfvRnPLW/
         yu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aLHST5ofgpJtO6BVDd158OevcKhrilVtWVhK7aonmFc=;
        fh=1KCEsa8gg7qfJWGpmmOPSHkhlKkpDMxNQwJqnDMACfg=;
        b=nZro/X8UArNha6a6fJiVOSGZSqVgEPtsDdoFibTmjEjQbGj3haWeQ8fiuWvisUnqSU
         56mk3OukGGjDYY5o5PUc0upnQ4eabuFy6jy+IiEJMZwPD+N14pd4hxpYEo0wFZNA4N7k
         FgMBXayT/+lB3+Ac4EokO/wfw4j8P2kL1Q0VvGhAEbiETNWwmCpCy6kKy8vKxkGhpAPW
         5x0RBPydPQ1QwyZPNQgAttssfkhIm2rfwJByLr5KcxorJE7F4s7JPsyb98XzdAscnUD4
         pllG/HYlXvBfk7dvINMIcuWiJRFkzuPP19QU1ullTsYieyb8rKI8F/5TQ4WuOw2Ir8sN
         ZQNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1792057917; x=1792662717; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLHST5ofgpJtO6BVDd158OevcKhrilVtWVhK7aonmFc=;
        b=jPKrS1u3agjf+bVROnSmsHy2CsTZwRFlTjjyndM7/hoFVAYQUVbwXHKwM97O/dYCqp
         5WqMad+YuXSeKh4QUtt9Je+5Tve09/StuBrcTbzNi+cMS97qlVlTgE1notSZQGC/mXRz
         qZA1FHYS3hKSKae11HpuBTauHmIiqgcJhAs7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792057917; x=1792662717;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aLHST5ofgpJtO6BVDd158OevcKhrilVtWVhK7aonmFc=;
        b=zWWXa4fRXRoNoPvEEWSuYWcUigFMreQ2CmhDbOj/RsEmhf1Uz+cKYzJ7yfnCwD/PSZ
         PGWCXuM2Jj3eGsV0CKoqT9HEFyGpBJ1pkS68he+OX9VCPDA4xrzrDWm+5UAoQX9NWDtA
         eNWFnneAq9sUgB9+j1Ozy42MKdMgqBa62kLHpBOoaV8iHhB7GiAhOSCcGgEqtueydOrs
         szXQDp5WeVhXpUkCoFluq8TwYgtwsmTE0L1NxU7JYz8G3eAhSl3iIsFn7Uxr5ynZd8c1
         z/+l3ZZJ/KyCGnLql6EHFKvuPIM3jDgWv5xt/vCv7QT/KMd5wG9F05YJ+X7RXSrPg/8X
         lL+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxwKplnFxSZOi55A/LA3yk+ZJRQWEtqnqmzQUME+8k8/OPCK4l0jrYk1HqQoMkV8DEEN6c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKX7Oml4Jxr5KcmLaSbj1uh5+fKMUTEbBrKwHKWdfxZ087RSPa
	Cj5OIuH7avpXQj/rq5YWSy/Nk4p4oHeEpHQLXN5EjA9gW0yARjIkZWl8TA7oAoEbKfAloueZG7l
	Vkpz1FXxOlUbdQsfqF8h+lU6EhYlX59W+O77E+WjDrQ==
X-Gm-Gg: AYBFou39Xvkx7VW4dnZ0J2/5xiYsvxCSUVFz2PD8dtmHyA3XT/qcbpKxir8sZ5mDt0l
	xgKI00JsTUtHkLjjXsIhe/uPZH6Bhi2xNE26402pezhsofaEoyeZ6SmQpyYLQrEWpVYsDLVVT9t
	yc0HzHFV6asw7qUmLECScXijecywwcBpnB81nt1CXs9pauzpWY137vrCCEs6TKURftRszdGv6Eo
	oa4zdpEKVeeJb6e0/G6ZUaBXRuhkb2LsZvkWKNPTTGvUVKmukwAzL9ik8n8GmXBr6toqF/Yq0Aa
	hslk6dX6hAZ89bxrFbSZyrRTrZqdtXJoYRi2k6FxExBzGVw0p66otMs=
X-Received: by 2002:a05:690e:4088:b0:679:9a92:5d58 with SMTP id
 956f58d0204a3-6799a926d7dmr784408d50.8.1792057917361; Thu, 15 Oct 2026
 02:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com> <efaada0b6a8ffdb4d1c01d7f34a0d6596a99c149.1791806877.git.gitgitgadget@gmail.com>
 <atB48HLgZr3ssOfx@pks.im>
In-Reply-To: <atB48HLgZr3ssOfx@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 15 Oct 2026 11:51:46 +0200
X-Gm-Features: AclHuK9ZtZlhCW1TKobjf3z54Z7d41xGq9VLXDUZNh2cZ_ogTXI_ACKu-U9iOoc
Message-ID: <CAL71e4Meuv1KXTX9HeQzmyVdmtYDCrd4M6VNcRRt5HZ-DKzbQA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] connected: add incremental connectivity check via rev-list
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 at 08:55, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Mon, Oct 12, 2026 at 12:07:57PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> > From: Kristofer Karlsson <krka@spotify.com>
> [snip]
> > Scaling tree size (10 incoming commits, 10 files/commit):
> >
> >     files    full  incr.  full/incr
> >       5K    0.01s  0.01s    1.0x
> >      50K    0.04s  0.01s    4.0x
> >     200K    0.15s  0.01s   15.0x
> >     800K    0.61s  0.03s   20.3x
> >
> > The full mode must walk the trees of boundary commits, which
> > grows with overall tree size.  Incremental still scans the
> > root trees, but avoids descending into unchanged subtrees,
> > so it grows much more slowly with repository size.
>
> Okay, so this is getting better the larger the trees.
>
> > Scaling incoming commit count (200K files, 10 files/commit):
> >
> >     commits    full  incr.  full/incr
> >           1    0.14s  0.01s   14.0x
> >          10    0.15s  0.01s   15.0x
> >         100    0.19s  0.05s    3.8x
> >         500    0.32s  0.27s    1.2x
> >        3000    1.23s  1.52s    0.8x
> >        5000    1.88s  2.43s    0.8x
> >       10000    3.72s  5.36s    0.7x
> >
> > With many commits the per-commit overhead of scanning both
> > the new and parent root trees accumulates and incremental
> > becomes slower.  Breakeven is between 500 and 3000 commits
> > and the ratio stabilizes near 0.7x for this fixture.
>
> And worse the more commits we have. So the new mode is only really
> applicable in scenarios where you know what your typical workload looks
> like. The big question is of course whether we can have the best of both
> worlds, where Git knows to switch between the two modes once it crosses
> the threshold.

I think this is where it gets tricky to reason about.  The win
from from larger trees pays off without bound -- the larger
trees you have, the larger the win.

Scaling with commits on the other hand we have ceiling of how
much it can regress.  I am thinking that could be reasonable
that anyone who enables the config flag for this mode could
simply accept that it would likely speed things up in most
cases but in other cases they could see a ~1.5x regression.

I am hoping that this tradeoff would then be acceptable,
otherwise we would indeed need to add some way of switching,
though I don't think there's a single good indicator value
for when it's better to switch.

I could add a new config flag like
transfer.connectivityCheckIncrementalMaxCommits to control it
perhaps.

>
> > diff --git a/Documentation/technical/connectivity-check.adoc b/Documentation/technical/connectivity-check.adoc
> > index abef02debd..a1d2e9709c 100644
> > --- a/Documentation/technical/connectivity-check.adoc
> > +++ b/Documentation/technical/connectivity-check.adoc
> > +Algorithm
> > +~~~~~~~~~
> > +
> > +At a high level:
> > +
> > +    verify(commits):
> > +        sort topologically (ancestors first)
> > +        for each commit:
> > +            mark parent root trees as trusted
> > +            verify_tree(commit.tree, parent root trees)
>
> So based on this, `verify()` already knows which commits it will be
> checking for connectivity. So wouldn't it be possible to fall back to
> the original algortihm here in case we see more than N commits?

Yes, but which N? I think it would depend on the shape of the
repository too -- size of object tree, merge-heavy vs linear.

> > +enum tree_state {
> > +     TREE_UNTRUSTED = 0,
> > +     TREE_TRUSTED   = 1,
> > +     TREE_EXPANDED  = 2,
> > +};
> > +
> > +KHASH_INIT(oid_tree, struct object_id, unsigned char, 1,
>
> The values are `enum tree_state`s, right? Why don't we use that type
> here?

I tried that first, but the natural size of enum is larger than unsigned char,
so this reduces the memory usage.

> > +struct verify_state {
> > +     kh_oid_tree_t *trees;
> > +     struct oidset trusted_blobs;
> > +     int trees_loaded;
> > +     int blobs_checked;
>
> These probably should be `size_t`.

Sure, I can change that.  Or intmax_t since we'll need to cast
to that later anyway for the trace2 output?

> > +     if (type >= 0)
> > +             die(_("object %s is a %s, not a %s"),
> > +                 oid_to_hex(oid), type_name(type), "blob");
>
> I'd love not having all these calls to `die()`, as this logic is
> essentially part of a library, and dying inside a library is a bad
> smell. We do this everywhere else in Git, too, but we're slowly getting
> rid of this as part of our libification efforts.

I think this would be a bigger refactor in general --
the existing connectivity check also dies as the way to
report problems.  This works since it's running as a subprocess.

If this is something we want to change, I think it would be
good to do that refactoring separately and make the connectivity
check subprocess only die() at the very edge, and making all of
the internal library code support not dying.  My first prototype
tried to do this but the amount of changes to internal code got
out of hand, so this version was the simplest I could make it.

But I'm happy to take a step back and revisit that approach if
this is a blocker.

>
> > +     if (vs->exclude_promisor_objects &&
> > +         is_promisor_object(repo, oid))
> > +             return;
> > +     die(_("missing blob object '%s'"), oid_to_hex(oid));
>
> Maybe the object is missing, but it may just as well be corrupt. So this
> should probably say "unable to read".

Hmm yes, perhaps.  I will need to dig into that more.

>
> > +}
> > +
> > +static void *read_tree_object(struct object_database *odb,
> > +                           const struct object_id *oid,
> > +                           size_t *sizep)
> > +{
> > +     enum object_type type;
> > +     void *buf = odb_read_object(odb, oid, &type, sizep);
> > +
> > +     if (buf && type != OBJ_TREE) {
> > +             free(buf);
> > +             die(_("object %s is a %s, not a %s"),
> > +                 oid_to_hex(oid), type_name(type), "tree");
> > +     }
> > +     return buf;
> > +}
> > +
> > +static void verify_tree(struct repository *repo,
> > +                     const struct object_id *new_tree_oid,
> > +                     const struct oid_array *base_trees,
>
> I think `base_trees` is a bit of a confusing term, as I think those
> always are the parent's trees, right? Should we maybe name it
> accordingly?

Technically you could use any base, as long as it's trusted.
That said, the trees here _do_ come from parent commits
(not necessarily direct from the parent commit, it goes
deeper down into the object tree).

I could rename it, though I think it would leak semantics that
verify_tree() does not require.


> > +     int need_subtree_bases = 0;
>
> Nit: this should be a `bool`.

True, will fix.  I think I got confused because the code base
use both styles in different places.

> > +
> > +     if (!nr_work) {
> > +             free(tree_buf);
> > +             goto done;
> > +     }
> > +
> > +     for (i = 0; base_trees && i < base_trees->nr; i++) {
> > +             const struct object_id *base_oid = &base_trees->oid[i];
> > +             int expanded = tree_map_get(vs->trees, base_oid) >= TREE_EXPANDED;
> > +             struct tree_desc base_desc;
> > +             struct name_entry scan_entry;
> > +             size_t wi = 0, base_size;
> > +             void *base_buf;
> > +
> > +             if (expanded && !need_subtree_bases)
> > +                     continue;
> > +
> > +             base_buf = read_tree_object(repo->objects, base_oid,
> > +                                         &base_size);
> > +             if (!base_buf) {
> > +                     if (vs->exclude_promisor_objects &&
> > +                         is_promisor_object(repo, base_oid))
> > +                             continue;
> > +                     die(_("bad tree object %s"),
> > +                         oid_to_hex(base_oid));
> > +             }
> > +
> > +             vs->trees_loaded++;
> > +             init_tree_desc(&base_desc, base_oid, base_buf, base_size);
> > +
> > +             while (tree_entry(&base_desc, &scan_entry)) {
> > +                     if (S_ISGITLINK(scan_entry.mode))
> > +                             continue;
> > +
> > +                     if (need_subtree_bases)
> > +                             wi = collect_subtree_bases(work, nr_work,
> > +                                                        wi, &scan_entry);
> > +
> > +                     if (!expanded) {
> > +                             if (S_ISDIR(scan_entry.mode))
> > +                                     tree_map_add(vs->trees,
> > +                                                  &scan_entry.oid,
> > +                                                  TREE_TRUSTED);
> > +                             else
> > +                                     oidset_insert(&vs->trusted_blobs,
> > +                                                   &scan_entry.oid);
> > +                     }
> > +             }
> > +
> > +             if (!expanded)
> > +                     tree_map_add(vs->trees, base_oid, TREE_EXPANDED);
> > +
> > +             free(base_buf);
> > +     }
>
> Then we expand all of our parent trees to exand the trust boundary. I
> think this part is rather non-obvious though, and could really use some
> code comments to explain what's even going on here.

Yes, this is the trickiest part of the code.  I tried to add
comments here in a local draft but it became messy and did not
help enough.  I will make a new attempt at it though.

>
> > +     for (i = 0; i < nr_work; i++) {
> > +             if (S_ISDIR(work[i].entry.mode))
> > +                     verify_tree(repo, &work[i].entry.oid,
> > +                                 &work[i].parent_trees, vs,
> > +                                 depth + 1);
>
> And here we then recurse. The recursion isn't unbounded, but we may go
> up to 2048 layers deep here. We already do this recursively in other
> places, but I do wonder whether we can maybe avoid the recursion and
> instead use a work queue so that we don't bust the stack.

Hm, initially I was thinking it would get very messy with a
manual stack or queue here, but maybe it would not be so bad.
I will investigate if I can rework it nicely, but otherwise I
think this version is reasonable, and aligns with other
tree-walking code.

> > +     for (p = commit->parents; p; p = p->next) {
> > +             parse_commit_or_die(p->item);
>
> This part here may die in case the repository is a partial clone with
> missing commits because we enforce that `fetch_if_missing` is disabled.

I think it would be unreachable, since we first collect the
commits via the regular boundary walk.  But now I started to
doubt myself, I will try to re-validate this with a test that
puts the boundary exactly at such a problematic commit.

Thanks for the detailed review!
Kristofer
