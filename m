Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF013C5DC5
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366867; cv=pass; b=YAVyQlQoskMfNeX4LVDBl35Lo6VYGEmNsLaayrHR4Dr6mzgECox+q9IyyGDyJIj/Hu/2urFZfZF+UJ9oG2jHz50YIftL2oaW6iHIYrHtsgNX6MH6phWplmBt6HM9T9QKmep2JBp5TMun4pX4v8kW9OFUF6S65GU2rLrOJJLdHcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366867; c=relaxed/simple;
	bh=s7IpGDw+BRd+kggTpMbWxMgb3q2BBonu5rx8K3RGPdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5FjRkvZkV5K0EX+pVx/rI6PADeS8harDYRBkZ61gdE816bIBmxyf0FhU4zE32YZUHnPTi5oReAoFOcIbRi6cmhmNLynWGj78UIFpOjYTDudYBpkdL6O5XYqQIO8uH16Wa6lqPDzALu54BJjZlXNdcWCDg283RLBXH5Mu1TH9V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjXvh3+r; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjXvh3+r"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba3e6so2196247a12.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 16:14:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785366864; cv=none;
        d=google.com; s=arc-20260327;
        b=FNlL28Ue6S18FpWtbX2+QYyH5PsDh7x0dosI0okzMN4BH3yGEroVxH6wGxwy92VGnN
         izVS96QG25xIRflBCf0qGLp04GfGvMkuJqOeL0dU/QPfKtclh9bMBngY2g5oj4SblSuQ
         Yy+Zssr5BNAn/AEoRZTofo0F7aQp4PaNrYS52JKOkoUbIr2v0bDSeEtOWDOcFpKNq58h
         6INf86OI63DVC2Usa2BSTiTrHKB9rTB147KRhY+nEnLeHYWtBcmt5VDGqSXbpUhTr2RB
         AJ5jjVpRSrP3NUkNEnhQMaZAsUQvntwE1yq/viBuEL1Kybep/Mzj3RBjD1MN7Z5V6peZ
         2tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=B26GZQBTAIBc1OPEQ5XZNsnOM1vUNv8NO8QkyWgTe8o=;
        fh=zxSqUrmtcdSS6F5mB8rxZylpiqPq0j6xd5BY3gWjef8=;
        b=UjZjzMhHDSwS5qNwdIGaKoxwRORhPjtBdX2I9H1Mgru+AcHNOzmg7EG45+0KxXlfW0
         pX7BevRTUjBZpRP7nt5wAAsge5+G8OqHJHJN4rZu9N4jwBQ4u/7lH4suEL/2mcoXaTya
         nCrBKlDtp0XsXXeeI3sO0PHxKoP7q+kfhjHVsPXffCa25KibwYUiedKIihK522bA+d4T
         1FOIvZOAtjhyXUlyh1pDik2z5xo9Kj+KU1O9jXb4C4PzdALbbBBlM3plLZF1vpG1/lfo
         zAQcTTMktTbsswgrhT6AudO/V2KsIlFj/2CbabW10CuGo8gfboc5YS23ruV6vuJP3/qY
         xbmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785366864; x=1785971664; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B26GZQBTAIBc1OPEQ5XZNsnOM1vUNv8NO8QkyWgTe8o=;
        b=HjXvh3+rr/Di4SrSweWPfkN1DK8fHNvEP1US5XhvRJYtiu3ZhkGsKIUB3AAJ1ShGSj
         tZmQSi8Z6GuLmXphnBGhRx9wj5eyQkoTy45YndWpPTdjpnCqYAYP/RUDd1O9aaKQB8vh
         LqChdxYuYcZgl3t1RFO7AZpXSP80oNCa87BAOa39BCHWrR/fzSZIrC9hmlLA37PPkPRs
         ny36WuUfPFJunGB75NUI7t0TkM1Qa0GFeaPRHR12oCZ16OAtDgYYIAMo/UnMQPTv7YiP
         Vdm3vFNDJyBLokyGFKD+V5OZeyfDxiR+syLrTxWtsiLy/IgC+1BhxNdpjCUByHSdJA0Y
         L2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785366864; x=1785971664;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B26GZQBTAIBc1OPEQ5XZNsnOM1vUNv8NO8QkyWgTe8o=;
        b=qgiro9amxgrdq/uSciizQ4IMNG0WOOih6V43LCS8iEDmKmEcBXEtN1thKT+e5R+cZO
         LPfrEorU23XUdzKOBGxJI6Ifs8P8pxVpBrdNn7j6ymVehYhG/H895sQxFhzhN5TvguCG
         ru3qMFICVHZICsEhYQ5z6sf0MaSyi04n3PZOMa0O7CS8jNmezsdqDDiROdcTkaUlf2iq
         A/Uz+Wr35mV8qpuib+SVQmWLpJuJrHIaVRr9+UEc7XwS6zuFesc13U87u7EFr5XWf/Yx
         RyDVcIOf0TPzBF2H8bITyOHql8qmrqSv+WFdEzYRiehi9wNsUd06IXIs410X7+zRrw8z
         Nhvw==
X-Forwarded-Encrypted: i=1; AHgh+RqZ5ylZYN4LBfVZbHsFOpK46JC5dn/pYlled0VVeOJuLqMBPF/BLLlzueE+kEzswpEp/Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTFvwlwjImiocFNx4Ka/15qfqYlf+Jnzic7VOpvRqqIwpzImbE
	y53uwBRkYP0U8AamQ0XscMQZRRGxUMQVtxziIAKyWdrN8Wdm9U5yFW7HnkPlLWO4nf9t/yjS1mo
	DvQT/JkO+cpldb/TchnkDLI6eQYOVaGk=
X-Gm-Gg: AR+sD13vs5p1Kejp7Tw875AtFTyroyqs17G0zjBRWwYZ7ygIwzXwaOGqNysP0ZeNWSt
	Fe7XOC3DEGblI6dbIOKNGTDWa/fwGwNPIG2ylwYEDv6oE72prgK+zV9h0+vuX1CQkvBbyghlYhD
	UoDo/3ncLevaSxLPOLU8KssGayPOfXEUQMo+uYN/QOF8/eCjmy2XKOC55lbOPNWihhw5roYTrDW
	JzfmDDM87a3VideC8lrLGZRU2M+fnfiP/GIguB3R5uubREMKMiQubkTooBgEzBZ0LkRNj5Vfb8h
	lCsCMMmVwd/YIZDTT5RWORrZ/1b9ohGh1ITfXfCKjww2
X-Received: by 2002:a05:6402:254c:b0:698:c208:b7f1 with SMTP id
 4fb4d7f45d1cf-6a07b7fe78emr155498a12.14.1785366863522; Wed, 29 Jul 2026
 16:14:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
 <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com> <5fd74f0050e5af1f2ab03ddae56dc96385e6a237.1784979136.git.gitgitgadget@gmail.com>
 <1f282ad4-9937-4c95-89d4-70f7a1c883a8@gmail.com>
In-Reply-To: <1f282ad4-9937-4c95-89d4-70f7a1c883a8@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 30 Jul 2026 01:13:45 +0200
X-Gm-Features: AUfX_myFY-Q6DgAfUo7GlrEoz8wpkprkaZT5x5Dl3tLgwbMxAH2wJj64Q2PQEFg
Message-ID: <CAHwyqnV_Uj3anbU9xRBtEUP3M84y9obK6+kx3c1s18NV2ta8eA@mail.gmail.com>
Subject: Re: [PATCH v23 5/7] branch: add --delete-merged <branch>
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> Hi Harald
>
> Sorry it has taken so long for we to look at this again - I'm not sure
> where last week went.

No worries!

> > A branch is not deleted when:
> >
> >    * it is checked out in any worktree
> >    * its configured upstream ref no longer exists, since a missing
> >      upstream is not by itself a sign of integration
> >    * pushing it by name to the remote configured by
> >      branch.<name>.remote would update its upstream, as determined by
> >      mapping the branch ref through that remote's fetch refspec. For
> >      example, a local "main" that tracks "origin/main" is kept even when
> >      remote.pushDefault names a fork. Right after a pull it merely looks
> >      fully merged.
> >
> > A branch whose work is not yet merged into its upstream is silently
> > skipped, so one unmerged topic does not abort the whole sweep.
> >
> > A branch that a surviving branch depends on through a chain of local
> > upstreams is also kept, so no branch is deleted out from under stacked
> > work.
>
> Shouldn't this be part of the list above. So we no-longer delete any
> branch in a chain of stacked branches when one of them is unmerged?
> Previously we only kept the upstream of the unmerged branch and deleted
> the rest.

Good point.

> > +* its configured upstream ref no longer exists,
> > +* it is checked out in any worktree, or
> > +* pushing it by name to the remote configured by
> > +  `branch.<name>.remote` would update its upstream, so it cannot be
> > +  distinguished from a branch that just looks "fully merged" right
> > +  after a pull.
>
>   * it is the upstream of an unmerged branch

Thanks!

> > +--
> > ++
> > +A branch whose work has not yet been merged into its upstream is
> > +silently skipped. Delete it with `git branch -D` if you want to
> > +remove it anyway.
> > ++
> > +A branch that a surviving branch depends on through a chain of local
> > +upstreams is kept, so a branch is never deleted out from under stacked
> > +work.
> > +
> >   `-v`::
> >   `-vv`::
> >   `--verbose`::
> > diff --git a/builtin/branch.c b/builtin/branch.c
> > index 1ef8362c12..78b694034f 100644
> > --- a/builtin/branch.c
> > +++ b/builtin/branch.c
> > @@ -21,6 +21,7 @@
> >   #include "branch.h"
> >   #include "path.h"
> >   #include "string-list.h"
> > +#include "strmap.h"
> >   #include "column.h"
> >   #include "utf8.h"
> >   #include "ref-filter.h"
> > @@ -38,6 +39,7 @@ static const char * const builtin_branch_usage[] = {
> >       N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
> >       N_("git branch [<options>] [-r | -a] [--points-at]"),
> >       N_("git branch [<options>] [-r | -a] [--format]"),
> > +     N_("git branch [<options>] (--delete-merged <branch>)... [<pattern>...]"),
>
> I don't quite follow this - why the "()" and doesn't --delete-merged
> take a pattern?

I don't get this one, but would this be better?

```
git branch [--dry-run] --delete-merged <pattern>
   [--delete-merged <pattern>]... [<branch-pattern>...]
```

> >       NULL
> >   };
> >
> > @@ -699,6 +701,148 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
> >       return 0;
> >   }
> >
> > +struct stacked_branch_data {
> > +     struct strset *deletable_branch_names;
> > +     struct strset *protected_branch_names;
> > +     struct strset *visited_branch_names;
> > +};
> > +
> > +static int collect_stacked_branch_bases(const struct reference *ref,
> > +                                     void *cb_data)
> > +{
> > +     struct stacked_branch_data *data = cb_data;
> > +     const char *branch_name;
> > +
> > +     if (!skip_prefix(ref->name, "refs/heads/", &branch_name))
> > +             BUG("expected local branch ref, got '%s'", ref->name);
> > +     if (strset_contains(data->deletable_branch_names, branch_name))
> > +             return 0;
> > +
> > +     while (strset_add(data->visited_branch_names, branch_name)) {
> > +             struct branch *branch = branch_get(branch_name);
> > +             const char *upstream_refname = branch_get_upstream(branch, NULL);
> > +             const char *upstream_branch_name;
> > +
> > +             if (!upstream_refname ||
> > +                 !skip_prefix(upstream_refname, "refs/heads/",
> > +                              &upstream_branch_name) ||
> > +                 !strset_contains(data->deletable_branch_names,
> > +                                 upstream_branch_name))
> > +                     break;
> > +
> > +             strset_add(data->protected_branch_names, upstream_branch_name);
> > +             branch_name = upstream_branch_name;
> > +     }
>
> This looks correct, it is a shame we have to build
> "visited_branch_names" but the code is clear.
>
> > +     return 0;
> > +}
> > +
> > +static void protect_stacked_branch_bases(struct ref_store *refs,
> > +                                      struct strset *deletable_branch_names)
> > +{
> > +     struct strset protected_branch_names = STRSET_INIT;
> > +     struct strset visited_branch_names = STRSET_INIT;
> > +     struct stacked_branch_data data = {
> > +             .deletable_branch_names = deletable_branch_names,
> > +             .protected_branch_names = &protected_branch_names,
> > +             .visited_branch_names = &visited_branch_names,
> > +     };
> > +     struct refs_for_each_ref_options opts = {
> > +             .prefix = "refs/heads/",
> > +     };
> > +     struct hashmap_iter iter;
> > +     struct strmap_entry *entry;
> > +
> > +     refs_for_each_ref_ext(refs, collect_stacked_branch_bases, &data, &opts);
> > +
> > +     strset_for_each_entry(&protected_branch_names, &iter, entry)
> > +             strset_remove(deletable_branch_names, entry->key);
>
> We remove the protected branches from deleteable - good
>
> > +
> > +     strset_clear(&visited_branch_names);
> > +     strset_clear(&protected_branch_names);
> > +}
> > +
> > +static int branch_pushes_to_upstream(struct branch *branch,
> > +                                  const char *upstream)
> > +{
> > +     struct remote *remote = remote_get(remote_for_branch(branch, NULL));
> > +     char *tracking = NULL;
> > +     int ret = 0;
> > +
> > +     if (remote)
> > +             tracking = apply_refspecs(&remote->fetch, branch->refname);
>
> This tells us which remote tracking ref corresponds to the branch
>
> > +     if (tracking && !strcmp(tracking, upstream))
> > +             ret = 1;
>
> Here we check that it does not match the upstream branch. That ignores
> the push refspect though so does not tell us whether pushing the branch
> to the upstream remote would update the upstream branch on that remote.

> We need to apply the push refspec to the local branch, apply the fetch
> refspec in reverse to the result and then compare that to the upstream
> branch.

I'll try to do something about this, but I removed a big part of the
push logic when introducing the stacked branches, it simplified things
a lot without it. But maybe too simplistic.

> > +test_expect_success '--delete-merged keeps cloned main without a default push remote' '
> > +     setup_repo_for_delete_merged &&
> > +     (
> > +             cd repo &&
> > +             git checkout --detach &&
> > +
> > +             git branch --delete-merged */* &&
>
> Unless I've missed something main does not have an upstream branch set,
> so we'd never expect it to be deleted, even if a push remote was set.

I'll take a look.

> > +test_expect_success '--delete-merged deletes only selected merged branches' '
> > +     setup_repo_for_delete_merged &&
> > +     create_merged_branch also-merged &&
> > +     create_merged_branch merged &&
> > +     (
> > +             cd repo &&
> > +             git checkout -b unmerged origin/next --track &&
>
> In the tests we try to avoid mixing options and positional arguments so
> we use either
>         git checkout --track -b unmerged origin/next
> or
>         git checkout -b unmerged --track origin/next

Good point.

> > +test_expect_success '--delete-merged keeps main despite a different default push remote' '
> > +     setup_repo_for_delete_merged &&
> > +     create_merged_branch on-next &&
> > +     create_merged_branch checked-out &&
> > +     create_merged_branch upstream-gone &&
> > +     (
> > +             cd repo &&
> > +             git config remote.pushDefault fork &&
> > +             git checkout -b local-to-delete main --track &&
> > +             git update-ref refs/remotes/origin/topic refs/remotes/origin/next &&
> > +             git branch --set-upstream-to=origin/topic upstream-gone &&
> > +             git update-ref -d refs/remotes/origin/topic &&
>
> As I think I said last time, this is a very round-about way to have the
> upstream gone. It would be much simpler just to set the config directly.

Good point.

> > +             git checkout -b tracks-other other/main --track &&
> > +             git checkout checked-out &&
> > +
> > +             git branch --delete-merged origin/* \
> > +                     --delete-merged main &&
>
> These lines look very short why the wrapping?

Will unwrap some of these.

> Why do we keep "lower", rather than clear the upstream config of "mid"?

We keep lower to preserve the upstream chain of surviving tip.



Harald
