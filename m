Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EF7489FD0
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533445; cv=pass; b=fTuAIUT0xZwfUU5AQIM68cxJF5UcHCyVfs0LOXTbGBJNXtNe2A6Aacr9FYq+kfGdhVkHos7zVaN9pQXRVdYdBgPeWJDRwAelIUFzRn6c7QXwtDgNByws9seiu2qScj8/ZAIWKgj+qbS/Qw99n5R1FU48qd5bXI1CttiTC8cl+XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533445; c=relaxed/simple;
	bh=o8ZZSofgm7omJ5STxAPnQOzh7hSbylSPdA+HGRcBiPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8LCnbamBMQIw7XATNPVALTePcfJvvmQI+FbUNs3wYX3pz8f4c1R071DcsSf+SxQCfxBNYweLtn6LJPu4kCrFzUF7u0veARSCkMmhneyouPl2vlxCQyLleR5L3/CLoE7Xnk0ww9Ywc4i0+4QEjmIfPuC5ujmyONsHBAi4sUEMjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk2Gyxar; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk2Gyxar"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b13fb95060so2225194a12.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 01:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791533438; cv=none;
        d=google.com; s=arc-20260327;
        b=jqVUZfhN7hyLGWuRCMLQ7gM9v32REqXZXvdrmSEPibz4skYktUWkUzWEOUdQHlV6XW
         gXi+iXNaggRCmcUu9kf2sraiKZJf/hMEhz9KkXTh9Dxsc/jFYeoCRdchRWMXvwU6vFcf
         tK1JfaXrfoSaBvjOSja2yhB3uK/CC68WVPZdoV5qfGigJYtvj6Ia0DPdWVy7pnEXtCYB
         yE8vlVzvTo0nwRRJqFlsCgcWu+e4MMW952yAE86kjIO5JTI+6rB42i6JJVv8WG70PF6w
         LMUQZP0eapR6wn5CWkPVeCKItBcR1tzzzCntskWmd+42nwL1VyQ/cdJ++iwNagVirdEN
         X6hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VHAvk/mVo5Cy+zXAswqdVS89QpwCxNEvjP86wBikhaA=;
        fh=AnAZP7jdtMlksBEClF+pdotdkiHyzQMuRWDr27IpPJA=;
        b=sGlDI33agQG+2jpI2qRB00rQFW68Bfn9IQ4m7QAupyEAYyumwIISkwKJSSUJ9FztFQ
         ZsqDeefFZALRwyH8TYerLQuIj3uwc2JV7IcXEiHq/y6J+aJvRLMsDJ/7BzTf1DvRyFxH
         g8EZqkkqks9eTW5mWcjFJ1WcaKdMmQDMw6AYEkayF93kk6kuBwCDHcO3sVmolDowumSu
         oUQwZiVb/cY/7XITi6kleIY2jMwBvUQA4Xu3eB5t0DCtj8LBk+oyjpq8Y3gtTc+NxIsj
         cq1iZQxjzc18ynqq3r+A6OhNrzoI+NDNdXEV1eDEUlt4wX0t7jFjK+z025h0H3ofvz/c
         FJHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791533438; x=1792138238; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHAvk/mVo5Cy+zXAswqdVS89QpwCxNEvjP86wBikhaA=;
        b=lk2GyxarIbIDbc8DCWQKoU0Dxa3UBe9UD968sxWeQE16+VskB6CbIO6wBR/EYHHM+E
         CUtRv1M4f/nNsRrYiqag4OkJU6LhwL/vRjwCnI6PP8eZQ6QmF/4V+7ycbHiEmJ5sxlX/
         5vt0xkjl9EqstHxqiKXj5XfCrBBMSsw1qPG6onQqP2QCxF0DzUb/V4CvjIpk79lcN+u2
         84iV/5/QTrvcAu1nU+QM8ZX4Ykj+MU7IHZSMt4jF/3XWi/1bt7yFXKOLxmAGrpkwlXj4
         6b/dyoXIA8kJvBAxYbXz7hDrcJM8J4DSX2W9V+Rzk9ijIwPnh9AoNXS1gWpwiRWhSS8u
         IiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791533438; x=1792138238;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VHAvk/mVo5Cy+zXAswqdVS89QpwCxNEvjP86wBikhaA=;
        b=099PRbzoBbZNnvE1Lg4xSk/dcRPN3+cqhehbO4hA/jvbKzR50EyY422NPS73Chq/MM
         2sOUEILI897qe7ZIc9Erdk2PLWo21iSMQJPkBVPXYmv0UWSvY2FirkAVae1c/VWMdD/F
         PqCVLL8XKaqyQa+XY2F8wtJq9gNBVzljBD3hgJiy24KNlLqaYbUohDJ/5RtxUta/amjh
         6l9/PsLALQa7nMWzuWtdvYymQegSA2EFvFr22zCildSPzSEh/G+fKRzo5iUq00WJplZq
         Q7Mme6bns6sNDvHsgWqtDZDzYpxXzmz71ja5fHc9kpOKoPcoypajOPLSuQ6i2Vl+1lhY
         ZFsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwi4Sx7Vj4DUuaSTiL6+ZGoGSsDx/AL3BAl3qFFgR5vdAbMx49E+GhadqWU9dixZKMlLaY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRm7p1Qcok2wh9n720YD4wz5IPDyq8oLa8oS+KufL+FBTpinQ5
	EMCqo/6VfkcI8WO+xNq7A0j/1zELMNYO9SpitZQmQgjY42NTQ9l2ZQ6dbGRBZufP0WN9kWQTjMT
	ljrqhJy7A9xxfYxp8ybWrgQf/QvxTGTA=
X-Gm-Gg: AYBFou2k1rfhXEgBewpPUpkWtWxOa2rBOyCUZMFBOKmrm27OEuIcH2JZCKrHN44SV7K
	2pUxhnL3R1K4LhOVJ0TBVoBJEcReEUHxJhKwa2wVaRkJi2elxKLY/p1gT2xaNsjGGekkXyIQ61I
	p4lW+3eObFqCdMaYQ1CyM4Z8GBOFYCLf8o1Vu2Je+w6AD21FO9RWlicWEPZltez1PZM0AxP2BSg
	XA5IpmEI3j/pwXMDW1xiQKUlWobrFqRuG4aSRluaF+DRclAhZXiBXZGnJnhhnBz3x0JqgXP7/la
	5K+f7pdcomuLRq9psC99PxMtXcSdbwJZIJ4lzULwqzKoQULNjctUtIY=
X-Received: by 2002:a05:6402:434b:b0:6aa:e46b:2c3 with SMTP id
 4fb4d7f45d1cf-6b17c269619mr769222a12.29.1791533437471; Fri, 09 Oct 2026
 01:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v7.git.git.1791410164.gitgitgadget@gmail.com> <fd6864daaf47dc3cfbd3cc7dadb5f0bd76d4eb79.1791410164.git.gitgitgadget@gmail.com>
 <xmqqo6d4163l.fsf@gitster.g>
In-Reply-To: <xmqqo6d4163l.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 9 Oct 2026 10:09:59 +0200
X-Gm-Features: AclHuK-YlEJA1mR3ZshU_CDNXNPKQzE4BguzPXxCdajBAL0L0Fxakz1K-KSQSvE
Message-ID: <CAHwyqnV7HufU_=T31KNa1m2PgpdVYU_EJj6doELgB-SiBQKDRA@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] fetch: infer branches to fetch from a refmap-only remote
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Perhaps something like this instead:
>
>     ... but nothing to fetch is specified on the command line,
>     branches from the remote that are used as '@{upstream}' of
>     our local branches are fetched.

Thanks, will update.

> The unified diff is a bit messy to compare the before-and-after
> behaviour, so let's see what the preimage said first.
>
> >               struct branch *branch = branch_get(NULL);
> > -
> > -             if (transport->remote->fetch.nr) {
> >                       refspec_ref_prefixes(&transport->remote->fetch,
> >                                            &transport_ls_refs_options.ref_prefixes);
> > -                     if (follow_remote_head != FOLLOW_REMOTE_NEVER)
> > -                             do_set_head = 1;
> >               }
> > -             if (branch && branch_has_merge_config(branch) &&
> > -                 !strcmp(branch->remote_name, transport->remote->name)) {
> >                       int i;
> >                       for (i = 0; i < branch->merge_nr; i++) {
> >                               strvec_push(&transport_ls_refs_options.ref_prefixes,
>
> So, when !rs->nr (i.e., nothing given on the command line to be fetched)
> and there is no fetch refspec, we checked the current branch and if
> it has merge config to merge from branches at the remote, we
> automatically fetched them.  This is the world order before this
> "infer with @{u} and refmap" work, and we should behave the same way
> when remote.*.refmap is not set.
>
> Let's see what the postimage says.
>
> >               struct branch *branch = branch_get(NULL);
> > +             int tracks_this_remote = branch && branch_has_merge_config(branch) &&
> > +                     !strcmp(branch->remote_name, transport->remote->name);

Yes, this can be improved.

> This variable tells the code that it must infer branches, but named
> as if it were a list of branches that were inferred.  "When remote.*.fetch
> does not exist and we have the refmap to use for inferring".
>
> > +             if (inferred_branches) {
> > +                     struct string_list tracked = STRING_LIST_INIT_DUP;
> > +                     struct string_list_item *item;
> > +
> > +                     branches_tracking_remote(transport->remote, &tracked);
> > +                     for_each_string_list_item(item, &tracked)
> > +                             strvec_push(&transport_ls_refs_options.ref_prefixes,
> > +                                         item->string);
> > +                     string_list_clear(&tracked, 0);
> > +             } else if (transport->remote->fetch.nr) {
> >                       refspec_ref_prefixes(&transport->remote->fetch,
> >                                            &transport_ls_refs_options.ref_prefixes);
> >               }

I'll rename it to 'infer_from_refmap'.

> It would have been much easier to follow if the existing code came
> first to make it clear that the new code is an add-on.  After all,
> when transport->remote->fetch.nr is true, inferred_branches is never
> true.
>
> > +             if ((transport->remote->fetch.nr || inferred_branches) &&
> > +                 follow_remote_head != FOLLOW_REMOTE_NEVER)
> > +                     do_set_head = 1;
> > +             if (tracks_this_remote) {
> >                       int i;
> >                       for (i = 0; i < branch->merge_nr; i++) {
> >                               strvec_push(&transport_ls_refs_options.ref_prefixes,
>
> How does tracks_this_remote and inferred_branches interact?  Doesn't
> the old code that grabs necessary remote-tracking branches for the
> current branch add the same branch from the remote?  Doesn't @{u}
> for the current branch added twice on the list of branches to fetch?

Good points.

> > @@ -2009,6 +2046,7 @@ static int do_fetch(struct transport *transport,
> >
> >       ref_map = get_ref_map(transport->remote, remote_refs, rs,
> >                             tags, &autotags);
> > +
> >       if (!update_head_ok)
> >               check_not_current_branch(ref_map);
>
> Useless patch noise.

Fixed.

> > diff --git a/remote.c b/remote.c
> > index 99a086ea5a..c26312beea 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -1884,6 +1884,35 @@ int branch_merge_matches(struct branch *branch,
> >       return refname_match(branch->merge[i]->src, refname);
> >  }
> >
> > +struct branches_tracking_remote_cb_data {
> > +     struct remote *remote;
> > +     struct string_list *tracked;
> > +};
> > +
> > +static int add_if_tracking_remote(const struct reference *ref, void *cb_data)
> > +{
> > +     struct branches_tracking_remote_cb_data *data = cb_data;
> > +     struct branch *branch;
> > +
> > +     branch = branch_get(ref->name);
>
> I know branch_get() is defined here and allows implicit use of
> the_repository, but can't we pass "struct repository *" around in
> cb_data so that we can use repo_branch_get() here?
>
> > +     if (!branch_has_merge_config(branch) ||
> > +         strcmp(branch->remote_name, data->remote->name))
> > +             return 0;
> > +
> > +     for (int i = 0; i < branch->merge_nr; i++)
> > +             string_list_insert(data->tracked, branch->merge[i]->src);
> > +
> > +     return 0;
> > +}
>
> This is more or less identical to the "if current branch integrates
> with branches from the remote, then fetch them" code we saw earlier
> in the builtin/fetch.c:do_fetch() above.  I notice that its return
> value is meaningless, as it always returns 0.

I'll look into unifying.

The 0 return value is there so it can be used with
'refs_for_each_branch_ref' without stopping the iteration.

>         static int add_if_tracking_remote(...)
>         {
>                 struct branches_tracking_remote_cb_data *data = cb_data;
>
>                 collect_upstream_from_remote(data->tracked, data->remote, ref->name);
>         }
>
> This will mean we will have a very small preliminary patch to
> introduce collect_upstream_from_remote() function in remote.c and
> update the "help current branch by fetching what are merged into it"
> code in do_fetch() to use it, which will have the above ontlined
> if/else if/ cascade except for your new refmap code.  On top, this
> step will insert a single "else if" block to add your new logic to
> do_fetch().

Yes, good idea.

> > +void branches_tracking_remote(struct remote *remote, struct string_list *tracked)
> > +{
> > +     struct branches_tracking_remote_cb_data data = { remote, tracked };
> > +
> > +     refs_for_each_branch_ref(get_main_ref_store(the_repository),
> > +                               add_if_tracking_remote, &data);
> > +}
>
> This also hardcodes the_repository, but shouldn't this function take
> "struct repository *" pointer (and shove it in data structure to
> pass it down)?

Good point.


Harald
