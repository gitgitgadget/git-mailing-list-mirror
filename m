Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81C41DEC8
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411975; cv=pass; b=U8diH8gtonwuAAmAoyq6smndza9Fq9ov9XKy/AhbyKJYVxJDVH/3djXNOgpHQME03vKDaL1HLes+oJQb+R6eMi9+sby29qnF1lVfFGGToAY9pKBzCq1Qq6UHtTuj9n5cCz2re8jH0O7JH9v5fdluOqm0rs1eVcX8lMBh0nsTwu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411975; c=relaxed/simple;
	bh=iL7E3REks29m9L9zpiaYnYUEkw0xTf8SfTNSsLUlnJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssWswXUHPR1uAvbwc5b1H7u2A6ER0d36wAnnQAlDMKJdfTAa9DgS1Vf3zIunYQaq1srPldmGt9YFUmijMzPvM/vQXZEvMto8IgVLm56XrEuSwvE8YVhZcBz8pwoAuMDD+n3FSfd8QLaw+UTR6N7RUUP4Hts5cjlpcOpDPjeByT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaQ6Wf7n; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaQ6Wf7n"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1f7666a90bso283702666b.3
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 04:46:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785411970; cv=none;
        d=google.com; s=arc-20260327;
        b=Y8hXUli23p38e6gsGhZ/Pn0Z8AvHOOzIrNy68WiSaNLBgzhowPjEdAIO+Q5ZUYdplR
         C1bmqyuCNlhgGVA7CtP6eSktgrUcK2GwNOhwbD7GN9jAr82SAPzHhuT7infoqBr1emPP
         bs5sXhDwpoyABz/0nvCDCLYsbE/mi7N6nWO5rwi53jf6BNcUMUMQ5VcusiTzMiGmOh4G
         zfUaxmaRLQiOuCGqEo7eOhjkqLxzWHYXgVmH7aqf/q6NWBLYDRwuzY7DsJ+32fBLW50Y
         P814dcLOs7bi3+UMjxKCaZAKBvUJnsKmVxgNOhkhSAkeZ4mU/815P7LjLh4P2iIZJmJq
         gwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/Pnxyg36NHLRsz+bS/w3MsQSqQJD2VCijyyhUmprK5g=;
        fh=mQ6I4t0DJhD4D7O2kQEi5MTzCqvYjaNfF55/Izu4gtM=;
        b=WOgilKHCDancJZeBxX/lpsRdBalQtWllidMKVDULO0wa5LgBSO+b0VZvAeS8WIHnRn
         tw2/nWajLosunQwQxnS8BUx4KwE6zF+PVTBNulQQwuP8UGO/OYOoZikr11virofz+fa5
         kGpkZIzDdfcAK6mryNgafDjN5oUiCmbB+Se77/bos1+X1y07IeMFdAoluqFHxxem88+n
         indkizFlPgqX6zApWTbcHCkGurcSvPjRrhZEExkj6p9ipSmRdiebBh0hvHByAo11mVcz
         5ViQRZJE5+z5Mj1pIQCxs7NQUpPydlaqRJk2YS43vaY73DVvJpy1csq6ZisQbIsrfO4M
         BMrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785411970; x=1786016770; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Pnxyg36NHLRsz+bS/w3MsQSqQJD2VCijyyhUmprK5g=;
        b=aaQ6Wf7ntkzESfTPrXEbRdqaaZup0R6m2MdTHEY6nlcJGAmcb88pl4ck9mIFMyhCIY
         VUETFatK2KuSJUrRewKoUFHn2TEAVBkJICkyKquqaYvPJB8wEq8TdUbQBfm/I442Pakv
         IllenIQ1F6sxYbn08ngYJr2Jl1w17gKEmXmE/cP3iEbO8VnBI8ouwEMNsPichnhICEOY
         o2fxn1FxQfCeZfLd1WVno31fZ6DwQ+q8bQkWIMLQdUW3xg9r1amMYvCkcs1PqD15vERi
         5OJ0pxW4+oVduUoCtEsk+E4ABtBYFKGY5sqbsZEZELipWb4bivihboPel3PuBpPE6nSU
         hXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411970; x=1786016770;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/Pnxyg36NHLRsz+bS/w3MsQSqQJD2VCijyyhUmprK5g=;
        b=L+eYhzTh9avKUJj8588lWmslb/9fxkpnP1YfIlpPBf5ZefQWQpAaLVNgizS4R4yDNF
         QpMhmKxrAtbPARluunaAmKMGHSpRxUbv8HlhKc6fhTAavAmLNEmbkOZNYXSRtxhaom+4
         Zb2jZobiWAKxBjuxBSWerDNy3hgRd7UWaEtTrCYsht+CcvUAW+/7CFTiblGxNY8cdDwH
         49hUmDj/JZB7lnPeQX0RQ6qebQ1JGlmoe3A4unWCFvDjRerDdJRYLvF0fELu0muGR7ge
         gk9Co+bUE8aPz4K3+CxO3RaJPGJSRJVy1WyzujgDsAwU6P4NMlP1KR3bV3mIhNsyMBMw
         3pwQ==
X-Forwarded-Encrypted: i=1; AHgh+RoxG29wKa6QiMkbfp3SUgHRZzrA2oYKm/+MABDxZqdW8hJtPWDnoGKJQLFNCltRtllq648=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpASOufZDvuQbKv99CpPwJYoLTAo6a+JmYEBYqFrG5n9guoTCz
	cswa9CgwNYUw+dLP2tAvyHD5+GnM68Bj1jQzusCBUw84ryp1F9IDSPqWftSuoy/VlhWFevDp7lC
	E70lcmdZBSw2Y42WyjcO3T7lLOlAqXV28E7JB
X-Gm-Gg: AR+sD11aI65XgRBz5awymms93ukherH935LUysImaJtNgZNI2VRDTqI2iREIJx+G9GS
	lHNVErcS8P+sud2mEXAE17W1xhUd5zO9Yh85dftr9zCanOSywCXssvhB5vE9L+6Os2vWv+I5tKj
	ZmSIsA9ukPz1p9LbcZRuYfr1AkgOZwlVKzxv0ULOa1IlJukfeE46+E4jHEc4a2SjyPJFsFx5IXL
	exm5Bc3WI02xbIKrilZWa20x0qDR2F9Q8JB98yO5xhyz9UFdgPzqW/Cn0bpdVvCW8zbf7o20Dz4
	m5cS2eT2Wfs1HPRrJ8xqWjqKJacxn7CnSMbJlmHh9kj/
X-Received: by 2002:a17:907:7b87:b0:c1f:1520:4de5 with SMTP id
 a640c23a62f3a-c1fa53ab939mr112678866b.1.1785411969892; Thu, 30 Jul 2026
 04:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
 <pull.2285.v23.git.git.1784979136.gitgitgadget@gmail.com> <5fd74f0050e5af1f2ab03ddae56dc96385e6a237.1784979136.git.gitgitgadget@gmail.com>
 <1f282ad4-9937-4c95-89d4-70f7a1c883a8@gmail.com> <CAHwyqnV_Uj3anbU9xRBtEUP3M84y9obK6+kx3c1s18NV2ta8eA@mail.gmail.com>
 <2574f79a-f04e-449f-aeb4-10d68cdc9437@gmail.com>
In-Reply-To: <2574f79a-f04e-449f-aeb4-10d68cdc9437@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 30 Jul 2026 13:45:32 +0200
X-Gm-Features: AUfX_mwwmm_BASnR5QW9NtMnxQEXHFDrKmJhDenuoaoRtW9YFY8Wv3NO9g4fmag
Message-ID: <CAHwyqnUbo_oByuu_CXdqZ=6uVSnTOCXM+fyD-hDWUkDzP6iMsQ@mail.gmail.com>
Subject: Re: [PATCH v23 5/7] branch: add --delete-merged <branch>
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

Thanks for all the help to drive this across the finish line!

> >>> @@ -38,6 +39,7 @@ static const char * const builtin_branch_usage[] = {
> >>>        N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
> >>>        N_("git branch [<options>] [-r | -a] [--points-at]"),
> >>>        N_("git branch [<options>] [-r | -a] [--format]"),
> >>> +     N_("git branch [<options>] (--delete-merged <branch>)... [<pattern>...]"),
> >>
> >> I don't quite follow this - why the "()" and doesn't --delete-merged
> >> take a pattern?
> >
> > I don't get this one, but would this be better?
> >
> > ```
> > git branch [--dry-run] --delete-merged <pattern>
> >     [--delete-merged <pattern>]... [<branch-pattern>...]
>
> I think I just didn't understand what "(--option)..." means - grepping
> around that does seem to be what we use for "give this option at least
> once" so I think the original is fine.

Ok, will use the ().

> >>> +static int branch_pushes_to_upstream(struct branch *branch,
> >>> +                                  const char *upstream)
> >>> +{
> >>> +     struct remote *remote = remote_get(remote_for_branch(branch, NULL));
> >>> +     char *tracking = NULL;
> >>> +     int ret = 0;
> >>> +
> >>> +     if (remote)
> >>> +             tracking = apply_refspecs(&remote->fetch, branch->refname);
> >>
> >> This tells us which remote tracking ref corresponds to the branch
> >>
> >>> +     if (tracking && !strcmp(tracking, upstream))
> >>> +             ret = 1;
> >>
> >> Here we check that it does not match the upstream branch. That ignores
> >> the push refspect though so does not tell us whether pushing the branch
> >> to the upstream remote would update the upstream branch on that remote.
> >
> >> We need to apply the push refspec to the local branch, apply the fetch
> >> refspec in reverse to the result and then compare that to the upstream
> >> branch.
>
> Oops I think that's wrong. We should apply the fetch refspec to the
> result of the push refspec, not apply it in reverse.
>
> If we want to pretend that origin uses "main" rather than "master" we
> could set
>
>         remote.origin.push refs/heads/main:refs/heads/master
>         remote.origin.fetch refs/heads/master:refs/remotes/origin/main
>
> so we map refs/heads/main to refs/heads/master and then map that to
> refs/remotes/origin/main. There's nothing (apart from maybe common
> sense) to say the refspecs have to be symmetric though.

I'm writing logic for this and an integration test. Thanks!

> >> Why do we keep "lower", rather than clear the upstream config of "mid"?
> >
> > We keep lower to preserve the upstream chain of surviving tip.
>
> Yes but why do we want to do that? It's a change in behavior from
> clearing the upstream of mid that wasn't really called out clearly as a
> change in behavior for xxx reason in the cover letter of the iteration
> that introduced it. Why is it desirable to keep the whole chain rather
> than just the upstream of the unmerged branch?

I can do it and get rid of the graph traversal (visited), but I think
we are once again going back to an earlier iteration. One of the other
reviewers wanted to protect transitive branches I think.

Either way is fine, I think it's a pretty small detail in the grand
scheme of things, I just don't want another round of ping-pongs on
this part.


Harald
