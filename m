Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795588811;
	b=5beQWDRi6Fq11Eq768hRFDgDlj9RN9QWYR2KnETB3QZVibk8d5VpretTo4432RBNkEJD
	 OqM30BF29tjCbESoU46GHWl9o5Pzg0aILPL4jkCRC8AutiWQONEyLn2sLlrYmWW07i/2g
	 X9ueA/Jy+ayX+48UhQrWeZ97nqwzX0K0ygO7J0aJPSUQA+uyeoPQtVtdwqmWYWFI5zhg2
	 H9iYI/zdNwvMBCzYMoK2r4Oz2B8cLAJFOXFXP6xY/nhIT8nayuJIPbc6GyJFE1TK88InD
	 SYaLw4GHS7bugJkzweWOsJzJQ2pj5btYl4khzyPPiJAz6rnoxTqjM9i5T4m6ylmh0jA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=dE8+hQwbAdTj3oLSxF+saNQ+omsIsFYqHR5xqeZDQPk=;
	b=d54wsGwLN7STGbYj9945tQezpdAEpAmZHb7NX1DfwdQRCQmmw5+hLW0sW6//IOj3g5L8
	 BI8h0yCFFurYZtTKzffEnWUkLFOPVeUAOFfrcPZbeIx2kiKlHH+T4jdPdeNe5HxMJmNyq
	 +cDvb8LTu/uwR1awubobX+aXjWW2CDMNKtUJ5w1l0Mw2mdwqFSs6cnZNQPXo8vj/DeBow
	 wASLHoE1G/W5DN/4fhK/FLEHsvPZPJFoT8C7Q8zmFuImlSYBEKyY/R/iuTJlku6ZAuAvp
	 JVZgXRiUhW4CysWR0l6J1SJUEiUqmvc+4ON5LdPT6uxRnqCzhfaflS4G3JRkCbM1kbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=khctuEBY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4203A606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 06:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4203A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=khctuEBY
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67be9601f31so4685577d50.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:40:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795588810; cv=none;
        d=google.com; s=arc-20260327;
        b=Y8OCmf3DCV9g/VqZCtJPQ8BXsRWG6RT6iYNWnOU6YPRJAgsUmCLv7mxTHPMu7QeITx
         Rg2u12EAQtS3EfOImr9l9oKb2yOS4l2nKoYqy2Wpu8VdnP09PaSASt62FhUdwBdCpKJp
         5aXnCtXffZq0jNuVtf4OPRtAqpxx480sZtcJhWuPkhIDa9uUsCrQOzhqxAQLbjkKBmkJ
         626cgk0J36jjHrNT+8qOUaXiGelW6b4UhD1vI1lC/cBshRjZo7WSb384PAFF49qqmgw7
         Olb+qSO2zrphQusovSZw6O9MNzcm2K64LagANlpcoXZNXavw43g7bxKkK/HQH5BFCK0w
         BRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dE8+hQwbAdTj3oLSxF+saNQ+omsIsFYqHR5xqeZDQPk=;
        fh=zEQd+5l/OBjEyzF6GIR9zxz6BTrbCyvCTKJbHzWgHEc=;
        b=fmbLca+ltHEZ5WP40loHDb7GBJAaRpsprUWmbTBUN8/osRPDW2TDsOVQhCd6xkccTW
         SUkPyizIJHmth5czI9a1Y9ck9CgifxguH/yhtqnEHzQk4IHTYQZsvUqg7+eG/pduhOHa
         xkQK9N/fB4fuGKsEtQ6XIIET2Olq73BwJ4e1IuQyf79mYF1VNGzrD1L/gtEuNdOMWOqz
         dOZRlh99OD2Xjud+J+E4ElcbMnOx1BA4doTENjrhoCDdX9wfvH7VbVsqbnVQFFBYI9Yz
         VP9XiH9FfOrooNwTRvpk7BXHkx9EfU2LdLXUREGGSVXcSslo2dInA5/s0tDLOpc4haZx
         Qqzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795588810; x=1796193610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dE8+hQwbAdTj3oLSxF+saNQ+omsIsFYqHR5xqeZDQPk=;
        b=khctuEBYhwUiHd2LjqxdyrYxS1kZ2jaNR6poZNX6ifQpEBg1sCSboDHeO3pV+TCHZy
         Q82ykW4zDxecLH6M29Pn6pnvXPZlQfueFy3jw1Vow7Fuj7EFPtp+C7S1+wQTYdmIMRG6
         nXy7yqGMfy4xsFmPv5stz3FULAUOyKMf9ecd+NcDellX+wSp8/1vOIPv7zvk5TdjElAw
         V3LJ86ndHw01lXcMnkhFnxsVlFnL/XouOSUfARocmFldABlEe/qUDwlWdUf0BzgUCJXd
         NOT7R+ZmALLcHcoGoHhDSJ8uuI1JS/N8LKLXplZCeqaAXcRd8yUW9S79U2jDILbpzPP3
         vncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795588810; x=1796193610;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dE8+hQwbAdTj3oLSxF+saNQ+omsIsFYqHR5xqeZDQPk=;
        b=vSbhhyBE6CGyoVCkIoHohjjYAo33eTC3bWoeDCv/FSw7kOkbO/EaBgUd7+6Y8wMhx0
         v/4QOVWOrM/Pg3zGGMk6i1Up0t7wqj4r3FEmrxubNZtz/QWtKLLkEaoWsGuw4ZVOt3kU
         7zxoqnNiQlqlWQEu1OAAHpNDB2RIH8hiF+w8xiDaNMrzyuwYnWYhcY7CHBBKpTaj+E6M
         ciYtw4cW7B/q94P6pOxJpnVZqyEI2IWMzPenMZEYCUUTEByVdJNdCHSmLffyu8+1QVtV
         rKt2Ld69KcB32bNvFj1w9I3RgILsy5vxq2uhpblhjUG8VzPjT3BvrcFJrNZK2zjPO8jE
         8zKA==
X-Gm-Message-State: APuU4Z+MtiwZpG4iqCCp6uNdXoP9p8aBdCQiK70qmehlOXBRjErbufLz
	UOsRh++I0xI5454Azx/Nt79FMyBB9ZROyL6r0Vpd750yGR5j99etbzCxpzpDw671P3VMa7kWLoj
	4Nz8p1RXniFcKGT+B5Dwof0qxWhZGefc=
X-Gm-Gg: AZFdTZeW9zSFUAsFvL9dvkqMDPlCiXedFxLqcavr+hur/4Orog4w1s5DS5Mq5mzFP5J
	tFQU0LVTQ8KZKfnyPxI4VD4tDABIQO2WTIfwVSyg7gAbbSR+5LViynE2p8/VGOrRMQkLgVDFeeu
	pM++5ZhtDuoZXF7SgbgupQdKepYdKlqEcfFJ6d/T9C6fPT4P+XIpi7KXQzWpMhPOlCi825mIl7K
	PqgNOe+KQ0orfX0jqGKuRuxRwcI28tKlf9h+7IvfKJvpdQVxLI6JE6CEF68C/ZrVdu9wVi5A7Lu
	I5FGcKHyuYZIO97NpnJWQ07uVXItWOzwo5MndAqXlyuYKYLnW1LCLdkeXfd6wYuw41t0QZNnoiC
	VyFm/yOCyyMY8ZomSj5J2g7fq9claSskNBytFwnCE4q8kHVTbdjIzshMxjx7t/NLMZIlZqFiPzk
	gdj6C6Pln1phUc4LeiPtB4TbdPT6HwXMnBvw0RzUeqtsQcxQv5/lxcpMZ1njJzbFq0yKfjE+gvg
	M1kr+LbqNDNn5NRR5JGcBoAlY9I4Jmcbd9K9Gx4AT1ORG7wRc+ZBgr2siUOqQ==
X-Received: by 2002:a05:690e:b8d:b0:67d:bf51:7006 with SMTP id
 956f58d0204a3-67e444cabf2mr522617d50.7.1795588810306; Tue, 24 Nov 2026
 22:40:10 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261124172146.18330-1-okhuomonajayi54@gmail.com> <20261124172146.18330-2-okhuomonajayi54@gmail.com>
 <xmqq33sphhqd.fsf@gitster.g>
In-Reply-To: <xmqq33sphhqd.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 25 Nov 2026 07:39:57 +0100
X-Gm-Features: Aa3M54p98YN3xEyhUd-YPY-dgI--J4aI8F4SfChS_LYUEQUrsh5Leu93ThJLkOQ
Message-ID: <CAFpMFfD2mbhp19+b_wVTfUk1N_0eJJrYkSd-tKdrph6UB=3iLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] notes: store the repository in struct notes_tree
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2026 at 1:34 AM Junio C Hamano <gitster@pobox.com> wrote:
> The comment above this declaration seems incomplete; it talks about 't'
> being a notes_tree to be (re)initialized, notes_ref [...], combine_notes
> function, but not 'flags'. Now we are adding 'r', so perhaps it is a
> good idea to give a brief explanation for that [...]?

The comment doesn't mention 'flags' either. I'll add a line describing
'r' (the repository this notes_tree belongs to) and one describing 'flags'.

Okhuomon

On Wed, Nov 25, 2026 at 1:34=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
> > A notes tree is always read from one repository, but the tree
> > does not record which one. Later code has to fall back to
> > the_repository.
> >
> > Store the repository on the tree. Rename init_notes() to
> > notes_tree_init() and load_notes_trees() to notes_tree_load(),
> > since every caller changes anyway. notes_tree_init() takes the
> > tree first and the repository second, and saves the repository
> > in t->repo. notes_tree_load() takes the repository first.
> > notes_cache_init() passes the repository it was given. Other
> > callers pass the_repository for now.
>
> Keeping 't' first in notes_tree_init() and putting 'r' first in
> notes_tree_load() addresses the v1 (or is that v3?) feedback cleanly.
>
> > @@ -1034,6 +1035,7 @@ void init_notes(struct notes_tree *t, const char =
*notes_ref,
> >       t->root =3D (struct int_node *) xcalloc(1, sizeof(struct int_node=
));
> >       t->first_non_note =3D NULL;
> >       t->prev_non_note =3D NULL;
> > +     t->repo =3D r;
> >       t->ref =3D xstrdup(notes_ref);
> >       t->update_ref =3D (flags & NOTES_INIT_WRITABLE) ? t->ref : NULL;
> >       t->combine_notes =3D combine_notes;
>
> Here we set '.repo' before checking NOTES_INIT_EMPTY or calling
> repo_get_oid_treeish() makes sure that even an empty or newly created
> notes tree records its repository, which is OK.  free_notes() already
> zeroes the whole struct on teardown.
>
>
> > @@ -107,8 +108,9 @@ char *default_notes_ref(struct repository *repo);
> >   * Precondition: The notes_tree structure is zeroed (this can be achie=
ved with
> >   * memset(t, 0, sizeof(struct notes_tree)))
> >   */
> > -void init_notes(struct notes_tree *t, const char *notes_ref,
> > -             combine_notes_fn combine_notes, int flags);
> > +void notes_tree_init(struct notes_tree *t, struct repository *r,
> > +                  const char *notes_ref, combine_notes_fn combine_note=
s,
> > +                  int flags);
>
> The comment above this declaration seems incomplete; it talks about 't'
> being a notes_tree to be (re)initialized, notes_ref (even though it
> replaces the underscore with a space in the explanation), combine_notes
> function, but not 'flags'.  Now we are adding 'r', so perhaps it is a
> good idea to give a brief explanation for that (just say "the repository
> that this notes_tree belongs to" or something like that)?
>
> > @@ -319,7 +321,8 @@ void format_display_notes(const struct object_id *o=
bject_oid,
> >   * Load the notes tree from each ref listed in 'refs'.  The output is
> >   * an array of notes_tree*, terminated by a NULL.
> >   */
> > -struct notes_tree **load_notes_trees(struct string_list *refs, int fla=
gs);
> > +struct notes_tree **notes_tree_load(struct repository *r,
> > +                                 struct string_list *refs, int flags);
>
> I trust all existing references to old names are converted correctly
> (which should be easy to verify---if not, the result would not compile
> or link).
>
> Looking good, so far.
