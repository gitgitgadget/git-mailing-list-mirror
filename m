Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792673195;
	b=K4XM/+DP7Kh/kyPLomVvVOF49ocaVB9JqjDwOzqwmQILHCHwBMCtdQT8dvh9rncgpVD9
	 ZWpmvnvA+DW71BJ4CfxnZBFrN5+3Y2T6qOAh8eEFlxvsU0fZD4G8IvNI1R8t29hesqkYB
	 15v3jPVKI+ToZ3FodnXYh1U2AGAgZB9nzSrdkhoyOGquD6QMnXJVfK3+qTnTrR+w/MolI
	 Xu0NTDFw6EgC/EL+rxLWcNrPw/4E8dAnodnBxF0s3B1xA160HTDJM3RzS4NmfyoVxJT0S
	 HQeLczXfJ+nhC6o5PAQ2WO6nNgiiAR3qn4x+vQgdrx9UH2trOkoxFbt3Uv3/qVHosHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=uJVv1mrKv2CGpeFoezod/AzVK9KCSqwSDaxPmS0pIHQ=;
	b=YkakEFPdfgd9b2MkALrtTkOJn1uxVO52o6G12FrPguqMFVhmflYcVyBKvHXz6AyMvNhf
	 dWdgejBrkU6DDmgnBnCMBBqoFrEPN10I1Lu0jdAGVYSpKCAOTcQdTlU4Sd+1rGbQZwBxB
	 KVo7QS1s+zObmPkHl4CdpOqdlPEksid7ZOTi4rEmhXQDIhHz11t+6TjBKH7fqInlq/fQd
	 LyXq1NVXUU5a6OhrRs1pJCc97LDe/zfMXe5OryI8tjFqijlsbVt3J9/xx7/rx74bqQLWD
	 +m5FQ2cfAcWDSrqdi724WRSaNM1+zjYmRcyxlepj/QRkHe/Xm7zkBc3OwslUkhDvz0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=shbx4tBY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD3606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 12:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07BD3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=shbx4tBY
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e946155442so14955335ad.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 05:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792673194; cv=none;
        d=google.com; s=arc-20260327;
        b=nzqBJQGd0ORdLszs6FL21GXy4ItrqtJ+cg+RlF3NMufg4uc52A/N5glvVGEO0BC2fn
         CyJLJjFJ8KVqthxedf4AYXw1/+RhaezHl3Qy9yjMqCcOD05qZbhJJS1LY/BKne/V/7r3
         gGBS4mkOgrxNTa/QTXTuDo5yQIeNpIZmmlPL0nICCtU1rCU7WJMNZmfER66APpi6amZg
         GYgc9MRIjGdvGHjjgSCLOZRLUoek8TN0kdqfwtmhYk73YbNzYIxkYANF4Evo8FnC5tzX
         SvqF1QdUPY5mGvH71Bq1653WUkO8sNlqzYCf3ylJl1NXL4dpUnNVpE4J/MPyMTxNWT+x
         eRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uJVv1mrKv2CGpeFoezod/AzVK9KCSqwSDaxPmS0pIHQ=;
        fh=fO6pv7++hJjYDCNhVhEjNs3nD9/3bOotda8HnHaqFzc=;
        b=Y7hLqZAYbXOSHCtWqS+cH4ljbAD3X8Ch/qRzI48R3sKbPSPR1VGjHNHHh8+0fMSq0N
         d2Sn64Hg86H4Hdyw60Ok5aoc1s1NfdGu6w8pLBPHF6Vt6S1i1zReazkscgHW0Yd+1Tr6
         KgBt19gRyAqWsnY3wNprjUYFzWrZPI0YtkszQf79P04E6o/OJsvAcxwkENtpHEn/Y8Qf
         in9JshHtb47TYWPufiMridVVYds+LNLCW6SPC4ECTHngcnv208i5GXROIga5TMM9c1Kp
         LzrJL8qVBH338hMblKGdfXBNe7cervEbwVxMJM/UdHgZDnxwz/cM1k/X2pOQO3RBIk0g
         0KqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792673194; x=1793277994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uJVv1mrKv2CGpeFoezod/AzVK9KCSqwSDaxPmS0pIHQ=;
        b=shbx4tBYRea1AXNpH1v9X/ln2GA3fiBQWKul560+BpQg41BEAt5wcZ3PpftJONN/hc
         Ltfewa5JL//pVs+SInsgixAAMwdX12ra8foBF3I+UVnD9CFahvq1POfU2qrIP1J4AaiM
         O7EFitcULHDBcDYKtF5VUwoiNX4IvZ86SFhKq9qgWjCB+LHfnoDj97YLp7LjfJ5P//vI
         G7kxAoqDynwQAgQiJefDT794nA117tdeEsU6qHFoRqaD0T8AFMZPzXcblEWA+Bm/mwMj
         lyRG45YeBiVuNptY9d6YBTmW0isD8VWO6+g1+HYNdtnPoE9izh5DeowavhMV5SLPZiW/
         fB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673194; x=1793277994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJVv1mrKv2CGpeFoezod/AzVK9KCSqwSDaxPmS0pIHQ=;
        b=ruhENdDOiUQMq9PfhblsJehzg5IZYHtulroSiF1fedh0frjUDVIYrlHCwAJN6RfMVS
         2cZvTc7pOedr6fsxi1VGkTLRcbduTIKhkjuy3pzV6ceTqnv/B+ganTUzqMZdb+sNTWZh
         oRA1ep/usJHidjNcAY3U2LbHqyg2g5gAkMjVOugrCzGHI8O8VdRD2yMhDtWJiZ2njJMg
         S+Ya8dNlRo1Kf6zQ40HzKUlq6Qp8JIi5ph0I4wb77LagInsprNoC3Q/w9xfZ+ejTKCQe
         loBT++dwt1NP+IGbn/LGoYIwIgdDkgDQbz/lRQ2bcd+P61CrCMM6VxGgMwO27GkzovfC
         ajpA==
X-Gm-Message-State: AFq9FYJs5iWk/4qVNDZK7z1JT9JGI/4mCTkB6yjyR7G45InrZ5hr/H3q
	5oR1ZiJKJrhoZKuJ+YfPSiyu1OQB7rgvogv3dfrbO/kz7KvGuKX+S4MlfTMw+rSiblyE/8SIN9V
	JhlBCy3wRiLAldY4eDU+dzPPTUXmyBGM=
X-Gm-Gg: AYBFou2pLAAF+R5LoxEmNC6a2KE4anuW+HiaV7awNjqG58U8A4QrrjgXYktJ267gbBS
	Jol6gaM+Hrt1erAbXDtDD4FxKyv2HG0CXgE+ZmlZezBf6mP/C78RngZOlKibe/aLcLPL5pkEzDu
	g+9l/Ku57eH69bLWnmF+pwZ6KXFZR04nOzo4XSSCC2BGQn+3xQ6mhX1fXyKIYm3dr2pqQrOfUql
	7rac74gwEssuTetsux+I6yI1ZcO+WvbtUYjji+ecqThj2MMfdrB97BWKTTw/pjqIBOJVylqiHjH
	mB8J2gafEnGHnub+fXwGdiAFWPZ9Pcder6ils3jtX+PVGqg8swdyiSkJ+9hU7uQ7MMNSSFb9+z1
	8676di41nLSrZ66PEMLpls8NdhVprqKOtF854pnTg/ubweQevL9Or8AdbaLNdZyInEdfZkYYMou
	mDgScY8z2oAiWJpbzEbPUro+9EK2VHY1CSmiKydDT5BUEb0WwZ3iRn8EnJcUZ7bod/ig==
X-Received: by 2002:a17:902:ccca:b0:2dd:c053:a6f1 with SMTP id
 d9443c01a7336-2ea43ca61c6mr38550405ad.35.1792673194183; Thu, 22 Oct 2026
 05:46:34 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <a8561fb7c2da446e7f7acc7e2a443991@donquinleone.com>
In-Reply-To: <a8561fb7c2da446e7f7acc7e2a443991@donquinleone.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 22 Oct 2026 08:46:22 -0400
X-Gm-Features: AclHuK8PiCRhqaiQfg7tl4omisSmGMp3y_ZnpK7_lAgEh-tptLCtwkp-FiosJb0
Message-ID: <CALnO6CAsCvJRywkw0WpO1nEhL+yU2-r_4Z2AHdJch1m=NK8=TA@mail.gmail.com>
Subject: Re: [RFC] branch: delete gone-upstream branches only when proven
 merged into a named ref
To: DonQuinleone <don@donquinleone.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren <haraldnordgren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 8:41=E2=80=AFPM DonQuinleone <don@donquinleone.com>=
 wrote:
>
> Hi all,
>
> This is my first time posting to the list, so good to meet everyone,
> and thanks in advance for bearing with me.
>
> I've just noticed that "git branch --delete-merged" is now available,
> and that it never deletes a topic in the workflow that hosting
> services (e.g. GitHub) encourage. Before writing a patch, I wanted to
> ask how the list might consider closing that gap.
>
> In that workflow, the topic tracks and pushes to a branch of its own
> name; when the pull request is merged with a merge commit, the server
> deletes that branch. With master as of c51408889:
>
>   $ git push -u origin topic
>        ... merged on the server, and origin's topic deleted ...
>
>   $ git fetch origin
>   $ git branch --dry-run --delete-merged 'origin/*'
>        ... spared, as pushing would update the upstream ...
>
>   $ git fetch --prune origin
>   $ git branch -vv
>   * master 61e9886 [origin/master: behind 2] base
>     topic  87d0c48 [origin/topic: gone] topic work
>   $ git branch --dry-run --delete-merged 'origin/*'
>        ... skipped, because the upstream is gone ...
>   $ git merge-base --is-ancestor topic origin/master && echo merged
>   merged
>
> So the branch is provably merged, but at no point in this workflow
> will --delete-merged remove it. A script reproducing this is at the
> bottom.
>
> From reading back through the archives, this is deliberate. When v7
> of the series fell back to the remote's default branch for a gone
> upstream, Junio wrote [1]:
>
> > If the upstream itself is gone, removing anything based on some other
> > criteria cannot by definition a "safety check".

Hm. I had a hard time following the "--delete-merged" series, so this
may come out of ignorance, but: we are asking Git to delete things
merged into "origin/*"; I'm not sure why we'd need to consult
"topic@{upstream}" to see that "topic" is merged into "origin/master"
here, since there's a merge commit with "topic" as one of the
parents?!

Ah, but the manual seems to contradict my (personal) "natural" reading
of the command: "--delete-merged" actually deletes branches whose tip
is reachable from their upstream (when that upstream matches the given
pattern). So, phooey. In this case, if "topic@{upstream}" was
"origin/master", though, "--delete-merged=3Dorigin/*" would work, no?
Incidentally, I find it a shame that GitHub's documentation encourages
a triangular workflow (whether or not there is a fork remote involved)
without talking about how to configure Git to help you: fork or not,
if you push to a topic branch but merge to another, it's extremely
handy to use push.default=3Dcurrent or some variant so that

- @{upstream} is the place you'll merge
- @{push} is the place you push

and suddenly "git pull [--rebase]" does the right thing, "git status"
(esp. with the new "status.compareBranches") can tell you where you
are relative to both places of interest, etc.

IOW, "git push -u origin topic" makes upstream configuration very odd
in the GitHub-ish workflow!

> I agree that a vanished upstream proves nothing, so I would like to
> propose separating selection from proof:
>
> "Upstream gone" may select a candidate, but it is never proof. The
> only proof is that the branch tip is reachable from a ref the user
> names explicitly, so nothing is inferred: neither HEAD, nor the
> remote's default branch.

I'll refrain from commenting on whether we want to make
"--delete-merged" delete a branch here or whether we need an
additional mechanism for including topics whose upstream disappeared,
but Git's CLI is already a bit notorious, so whatever interface we
design should be composable.

> I can see two possible shapes.
>
> (A) A modifier on --delete-merged:
>
>   $ git branch --delete-merged 'origin/*' --into origin/master
>
> Branches whose upstream matches the pattern but no longer exists would
> become candidates, and would be deleted only if their tip is reachable
> from the named commit. check_branch_commit() would be handed that
> commit in place of HEAD, as suggested on v7 [1]. Branches whose
> upstream still exists would be judged exactly as today, and the
> worktree, stacked-branch and deleteMerged=3Dfalse exclusions would still
> apply.

A standalone modifier for another option makes the interface (IMO)
complex; now we have to explain that "--into" only makes sense in some
contexts (and add code to bail out).

I would much rather see more --option=3Dvalue,value,value syntaxes, like

     git branch --delete-merged=3D'origin/*,into:origin/master'

If we gain another form, we don't need new --options. We would also be
able to say "--delete-merged=3Dinto:origin" and DWIM without any
upstream configuration (or, with push.default=3Dsimple, even when
upstream is just the place one pushed to).

> (B) Composable filters on -d:
>
>   $ git branch --upstream-gone --merged=3Dorigin/master      # preview
>   $ git branch -d --upstream-gone --merged=3Dorigin/master   # delete
>
> --upstream-gone would be useful on its own for listing (today the
> usual approach is to grep "git branch -vv" for ": gone]"). But it
> turns -d into a second bulk-delete mode beside --delete-merged, and
> --merged defaults to HEAD when it comes last, so a forgotten argument
> would quietly bring back HEAD as the proxy.

In a world where we didn't have --delete-merged, this would have been
the natural fit, I think. Imagine:

    git branch -d --merged-upstream=3D<pat>
    git branch -d --merged-into=3D<pat>

etc. Or even "--merged=3Dupstream:<pat>,into:<pat>". Then we could also
take some of the "--list" filters and make them apply to "-d". In the
ambiguous case of a ref named, say, "--contains", we could use "--" to
separate options from named branches to delete.
