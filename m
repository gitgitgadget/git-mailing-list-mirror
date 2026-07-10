Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063A13A6F1B
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783715398; cv=pass; b=tVndQw/GpXaLqgzyy8YH5aIMm5iGCDGA+t5FRoWKW7jFkDv4hpvNr2KEcoyPOTKAKcZQwufhxMMnmFxo3YnvAT+p/mqNNUkc0rQeR6Bvoec+CCSdGNjuccnS617kr6qoKtDlWN0Hkpmh4qltj10rvEMpDFPAC3d52fXePK89RI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783715398; c=relaxed/simple;
	bh=VMw09u47tsVAsWjSf9X0GBM5Q6vXdIO0EhGp3GgmuBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gopfsqsjIySoPk2c0YyLZmQwF8j1cK1+AVL2Qtgsz1Csk5YZwoSS7vWlbWEZ0R+1OWmay4lsTUsfom+zBl2NIbWrOpxWqD9eZu+KBzJ2fj19oj9INe1oJqhPpfufC+NLRAOkfmn6K9vaXfaUYGy5we5YAW38ffe413TrgHsEJX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uy3POJQ9; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy3POJQ9"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80a123ef90aso22305147b3.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 13:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783715396; cv=none;
        d=google.com; s=arc-20260327;
        b=jIuD2u3Jwb1T3vqRfDcSFR3xY5Wf851WMCTBX1oFrs4AXyW/9LuNn/qqThsp6drl75
         ZqSL1WCD2VhgLKDDKKZJPHrIacLH0gnMQLpHfJfX1dRO4EWQ/X55hc7/HTEn2Ofs8+F+
         Zs9ODFXq9hW6QQgE2fBhhwHbFNl9L+Ng4mrEC4aqrsfm3Ji9GzcyF0jTZKG8m7txg3dC
         +zyE4PGll+70aAa70JHqxdS85h0O55cDZM8NMB1E8X6Ysxm7b/AI40RyCcLGWE9pfH45
         u2kBOAnPRuTVJskAkqjPbxKpCo2z4b8UG0Np6RrGdlUiMiVeeuvrRCWKkKFWegqS2vjJ
         B+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JD/DLnyydv0ylwVpjDKtRb/jilYtc4QFJuOA6i4PFXQ=;
        fh=9XgzLfStU2RW9Io/FkYfLLBArPpIzZKnNXjJkBFCKlU=;
        b=FqNiSNs8kTCDFsC7rsvv+Par79ksU1sleGIOXUY+xiNo7yZI94/eJhqkQVAPlsmpb8
         3C0T58hEyaTHmUmV5ez7zAT5ZAyaffS1qlSXLsknGMLFUg2z6ynQlbasK8byE2ittxeR
         mwYgkXe8QUCxLGnoPlrfYV9nANK1gf9rCBxumXmxU8rWJkrkE2u26pQ1h0ecVPJVqO7f
         sDOm+URt5NlQ5sBRmCIbwPCUVxcsmDrhBK14nYu9sEy39lvvDTSw88MF/hbmFM3Olz+3
         9R0zc1olhIW0FWbG+UM5E6p+B9SGDFuxVgG0Ds+JTHqhdMM3MMOoFhuTytHXSuPirfU4
         M+6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783715396; x=1784320196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JD/DLnyydv0ylwVpjDKtRb/jilYtc4QFJuOA6i4PFXQ=;
        b=Uy3POJQ9YogDgWZASp6BkdOHRwpLwGY0XshnBD7tKDIKGJ5cd6qlZ9P7dgYBi1D4bX
         x8IYIv762Xt/zGovjYG3oQM2F23qsHx1u2VX3BpixH0HtYc0UC/wQgx2U9J8OYGH3eJw
         lyqEtGlEc5FY0jdUYb4RFPzUYlh+UiYO3HqedBGqAcBgY512E9GR8NAGoCfgHU7HSHTr
         0uO+hcsLp3TLrtEhlxjMOGItr3OldHdwA+madEJlKfOD4WFOL2VtCm/vWtvMQukaAhQi
         BSD2Ggo4973xR3sxA5bSgElGXPbshbYDsPy47Vs1srZMFaVsjpjAxrmsRdASKrB6fEbr
         COKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783715396; x=1784320196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JD/DLnyydv0ylwVpjDKtRb/jilYtc4QFJuOA6i4PFXQ=;
        b=i/KonxoHTraj5KvBaNt06RWv11OZHH5ZSWG5J/Gz5NqIX33GQJtGPmkc4Ake9rjPpc
         psVjJy7fDvAcUspnDw1CphFSB0E2nwLc3yvu3ApIPVgv9aqjv5sJl+ca/PHiyYe10AgY
         HcddZhyLy6BhFA4eu3XMVSYYHcoqNfM9DPO3slepejuFtHe8Foqa/0ZzXLyT7ti+X9vD
         rv2kQFhqUzT2UNC/MoF8xc7lts9U2UwGjSMkEg3FxwNZH3yWKPLMF18vSNUhQ2jb0dV+
         7dEtu2YMFEtamk4loEG8RtC860DZP05R1LTxpxoFsssdZcuTBtafQ/xfRFWxejOjnn17
         k7+w==
X-Gm-Message-State: AOJu0YwTJoMg7f++axRAsDF43PWJE7Kl5ZYWpnoh6y6rLNb6H573N+t2
	oxj55SvWZlKHz7ZVj6hnV1huMnpwvUzPtt7FERQ4ODDFeBTLYACklbhFbHp0240kUkkGkxM8laB
	CGgz5oOjhZhvYwNs9V5kirmGaJW+wK10=
X-Gm-Gg: AfdE7cl/lR75/wsI5EyFzj+XC1nk2ov61VEcN5g4xtnue2gSwsQ8WX9pwYGmdyyOqEm
	MUFClQwINs+Yptff3zp1HgmJL70yJ9HazUv0k1oucVVJ0Dw78KjS/2V2Z6QQj0ZagXjHUrwkQ+o
	w7F6Ejg3wwS+gg+B/8GSSqhvXV3dAFjUTsBaftILrF6mx0g4uDK41XvkZbtT07xF5ve1X/e1Jo4
	sd2LNgm2gOW3q1STTyz4DhKTAvnIB+ErYGzZYfbTf/H3upOLT1OJNGg0J2b3osZTKgzV0RWvfIg
	2Odi0kkawTClCSKcvgdFlSQbNIB8CVpVnUMHJaHas1B8V/nO1XC/OElHjUBlTfTn97YoxajsZSW
	lxH7yxSdy4l4Tk4k9gLDMVyRXnqH/nF7e8YOVsM6aLnZG5EA2DwV56Qm+8dLZNB9Q7cmhrc4=
X-Received: by 2002:a05:690c:10d:b0:81e:6def:63f1 with SMTP id
 00721157ae682-81e7bcceeb8mr39727177b3.32.1783715395870; Fri, 10 Jul 2026
 13:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704-ps-pre-commit-indent-v7-0-a94706cc8376@gmail.com>
 <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
 <20260710-ps-pre-commit-indent-v8-4-d3b636463bf4@gmail.com> <alEroo_DhFaWm3DH@exploit>
In-Reply-To: <alEroo_DhFaWm3DH@exploit>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Fri, 10 Jul 2026 22:29:44 +0200
X-Gm-Features: AUfX_mz4TKBLilIr_ahoXdu7yeLlmeNI4Xyua7AoCozv_ig-zlL0A5fMzWhIwm0
Message-ID: <CAN5EUNQNFsUZD=7yLMo0q4hgNEdWxX+fifG+zxJeL+-eRKSDuw@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] graph: indent visual root in graph
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, ayu.chandekar@gmail.com, chandrapratap3519@gmail.com, 
	christian.couder@gmail.com, gitster@pobox.com, jltobler@gmail.com, 
	karthik.188@gmail.com, krka@spotify.com, peff@peff.net, 
	phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 10 jul 2026 a las 20:07, Mirko Faina (<mroik@delayed.space>) escrib=
i=C3=B3:
>
> On Fri, Jul 10, 2026 at 12:37:07PM +0200, Pablo Sabater wrote:
> > When rendering a graph, if the history contains multiple "visual roots"=
,
> > actual roots or commits that look like roots (i.e. have their parents
> > filtered out) can end up being vertically adjacent to unrelated commits=
,
> > falsely appearing to be related.
> >
> > A fix for this issue was already attempted [1] a while ago.
> >
> > This happens because the commits fill the space from left to right and
> > when a visual root ends, its column becomes free for the following
> > commit even if they are not related. Once this happens the unrelated
> > commit is rendered below the visual root. Because there is no special
> > character or way to identify when a visual root is rendered making the
> > graph confusing.
> >
> > By indenting the visual roots when there are still commits to show the
> > vertical adjacency can be avoided.
> >
> > Add is_visual_root flag to git_graph making it visible in all graph sta=
tes,
> > give graph_update() a new function, graph_is_visual_root() to know if t=
he
> > current commit is a visual root and set is_visual_root.
> > The different handled cases are:
> >
> > - If a visual root has children: similar to GRAPH_PRE_COMMIT state when
> >   octopus merges need space, an edge row needs to be printed to connect
> >   the child with the indented visual root. A new state GRAPH_PRE_ROOT i=
s
> >   needed to connect the child with the visual root:
> >
> >     * child of the visual root
> >      \ GRAPH_PRE_ROOT
> >       * visual root indented
> >
> > - If a visual root is child-less we can skip GRAPH_PRE_ROOT state and
> >   render the indented commit directly.
> >
> >       * visual root indented
> >     * unrelated commit
> >
> > - If two or more visual roots are adjacent: by having a lookahead to th=
e
> >   next commit that will be rendered, if the next commit is also a visua=
l
> >   root and we are on a visual root, meaning two visual root adjacent in
> >   the history, the top one can omit the indent, making the one below to
> >   indent only once, if there are more adjacent visual commits, the
> >   indentation will increase for each adjacent one, cascading.
> >
> >     * visual root
> >       * visual root
> >         * visual root
> >     * last commit
> >
> >   Even if the last commit is a root, because there is nothing that will=
 be
> >   rendered below we can omit the indentation on purpose.
> >
> > [1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.co=
m/
> >
> > Helped-by: Kristofer Karlsson <krka@spotify.com>
> > Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> > Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> > Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> > ---
> >  graph.c                          | 235 +++++++++++++++++++
> >  t/meson.build                    |   1 +
> >  t/t4218-log-graph-indentation.sh | 473 +++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 709 insertions(+)
>
> This doesn't seem to work for every visual root e.g.
>
>     git log --graph --oneline --author=3D"Mirko Faina"
>
> The visual roots are not indented.
>
> > +/*
> > + * A commit can be a visual root when:
> > + *
> > + * - It has no parents.
> > + *
> > + * - It has parents but they are all filtered out and
> > + *   commit->parents arrives NULL.
> > + *
> > + * - It is not a boundary commit. Boundary commits also have no visibl=
e
> > + *   parents, but they are not selected as visual roots because they c=
annot
> > + *   cause the ambiguity of being vertically adjacent because:
> > + *
> > + *   1. A boundary only appears because an included commit is its chil=
d.
> > + *      Children are always above, and the renderer draws an edge down=
 to
> > + *      the boundary from that child. Rather than starting a column li=
ke a
> > + *      visual root would do, it inherits its child column.
> > + *
> > + *   2. Included commits cannot appear below a boundary. Boundaries ar=
e
> > + *      ancestors of the exclusion point; if an included commit were a=
n
> > + *      ancestor of the boundary it would be excluded and not rendered=
.
> > + *      Boundaries therefore always sink to the bottom.
> > + */
> > +static int graph_is_visual_root_candidate(struct commit *c)
> > +{
> > +     return c->parents =3D=3D NULL && !(c->object.flags & BOUNDARY);
> > +}
>
> I suspect this behaviour is due to these assumptions being too strict.
>
> When we use the --author option the parents are not filtered out, so it
> doesn't return NULL desipte being a visual root. We realize it is a
> visual root only on the next commit, but once we are on the next commit
> we can't indent as we have already printed this commit.
>
> We realize only on the next commit after hitting simplify_commit(), it
> calls get_commit_action() and checks if should keep the commit based on
> the regex we provided. If the regex is not matched the commit is just
> ignored (we do not filter parents based on regex when we expand a topo
> walk).
>
> At least that's what I gather, if anyone can confirm this...

Hi!

Yes, I just tried with the same:
  git log --graph --oneline --author=3D"Mirko Faina"

And no indentation sadly, if when we use --author the parents are not
excluded then the c->parents is not enough.
I think that it should be fine if we iterate each parent and call
graph_is_interesting() that also calls get_commit_action() as a
fallback.
Something like:

graph_is_visual_root_candidate():

/* We keep ignoring boundary commits */
if (c->object.flags & BOUNDARY)
        return 0;
/* Check the parents if they are not excluded because of options like
--author */
for (p =3D c->parents; p; p =3D p->next)
        if(graph_is_interesting(graph, p->item))
                return 0;

return 1;

I haven't tried yet though, but if --author has this problem, probably
other options like --grep would likely fail too because of the same
reason.

Thanks for the feedback,
Pablo
