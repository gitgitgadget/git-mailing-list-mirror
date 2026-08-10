Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10933630BF
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366840; cv=pass; b=adh+/duMIdK0yUk8XIsMoIKwBvZq5lkH8z3N99ZYpN48c/eXIfkgowJD3FhUYTnQEN9fHqQmcUYbiG38sOE5/V9lxcQWHxHaGmbX+L6o6yhm4/Rbu79exYW0CCay+4JXUvQG7gbgMvjHR2YBtPLDxAThuVkz4ySDzSrDefT7bz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366840; c=relaxed/simple;
	bh=MusymiGKPjTl36G4Y40mlMfN3sv5VSxTGFmURABRPAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQu7ST6mq0W68Ag96VFGrTf/CsbAt5W3FxnN/sm0hW3ZgTCGlSul/2zjByIr8jUxEKkgkZYCW/arVvib0sdnIPjagTNcTh/kvaXyf+M9h5DovhIG4uByzuZQPnv4v11Harh0J06Jf2AYmgQwr3tNA/TaV0nBInbOODT1BUAJZcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcBGOyCN; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcBGOyCN"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8edda5d56a5so15532056d6.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 06:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786366837; cv=none;
        d=google.com; s=arc-20260327;
        b=lZKHiZ3yAwKAF9WRkmQFOeLQIrw/s0346dvCWGCNx0km2g4JswwKYgakKRRiY0RWV2
         55/ZkoQnDZIZDiQJr7cfTGrynH0Crat4ctlhkcFKlVk22eOY7V8YRVlKR4wyjAR3jj6y
         RhyqeeRk8FWczFn/Rn6oDXLLhGqmok9K3TwTYvgx8eriBAMZ3LekX3Wq/ljOErqnoSqg
         M8D3XKP9q/XdpSwgwk9KxmhByD6Ql5kdmyWFz0e/DS4pnPkh8s5HwwgFdd9jWqOFoHbq
         9KJ6TVpbhAng/R/x1QZPxKvEVlUni6JXXJpoFyMB+1Pf6fuLmDbEYlY/Afnb+ACFgj9c
         aE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mLz1Lh/3Ghbq2nKibQmzuZGgv2motDECLBaDFZ4y0ik=;
        fh=OacTIZzgN/+/9PfaozQ9eQkp4hV13c+/B6x08+kAZ8E=;
        b=m5wj4Q3TGeCZANv+8aolMP4YYxQqsVfRCYiK8CSPEuqsiaOjQfvwZpDs0dusTSGSS2
         UcvZNyLpkSDpKuSWrJave9l9jqGhMg3Gq0Z2MTpzIx9THcVCU0xPDGN54N1X3pk3Pkf9
         n5kybBk+pj/wYx6yKGx352K1eBHK4nGqt2OZ8RYNx9OghB5XRDotjosS1pYwBeh3CExO
         JPqFCnlTBMsaa9pltghtrn30mAVBwiqaP5YqqDoLCSVuSPzieCJPix1igkTIHGWwZ5/q
         nrGU+QSp4rou4WhWwt1pbe4DyenY1OzKjZA4YMwXiGL5m/7FT3JQqdvT9kutXNTOhAhl
         mucg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786366837; x=1786971637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mLz1Lh/3Ghbq2nKibQmzuZGgv2motDECLBaDFZ4y0ik=;
        b=rcBGOyCNQorXnQqMp6k0olOe6qw6NrJE+k2VWmMcNsdJh/aXR1knnLx7JpgDXB46A8
         8rIS9ZR7Y44CnzIziayYZ5VCOA0JNzsEWUB9b3Z9d1Iyz2kvLJ6bqQWYQyt6hqDtmZCU
         cTZ8kbw9ooM9tvd5ebkYn82aie2udUSGOp9ZMQ6FgorZFEBWuNt3nyjPvqHlVlA7Fhm3
         QXlNzteWeWrHP0sN5C1Vd+ctSP4iu5F0sanYW5x2PVUnN2hiR/s7RjZiU/0VjfgxpH+d
         ebdsldZXJlNT85fWRPHIeJe22layoAf4tGabps7nUfe9fxSHBqWM1dh5Ngmd1WFQZRuO
         GzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366837; x=1786971637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mLz1Lh/3Ghbq2nKibQmzuZGgv2motDECLBaDFZ4y0ik=;
        b=K0Fl8b1vf6OkiF6qFrXRVkQVe9MwuU2Zz+NvuJA5DHQszgVydSB4QCQ77/rELdpiiZ
         fzl6anE+r4QO8GodrlUwom8VvycP/oVY8s0ak+vWzgLYe+36dzs9b5CAQ4j+0CSdqnau
         otInVveLY9O2Kz9dD4LhLjoKdGKy7pZ+bIwhNmztUUyidmAN394v6a9Xkf1QswbL8IB0
         3pJ1ZcWhAO1Mekdb3q6+bEkTAp8pjBTyQwOHYjUQXlyhPJMZC/KPn72fbDU66Z5MkoE7
         p1Kms0E5QNTH77ywSqjrTZBsaiFjdORozCeYOqITa/TqWCXjgPJ6Lvx3Zj1dmv6Qbe3G
         8R+g==
X-Forwarded-Encrypted: i=1; AHgh+RqbKUsYyz26Pbg/zIQdTcSB88DmeSDB89+yM1ZDeDxOJpRGKmVd6IMZitrhLOutZUpWeW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNoTUcv+tpw77YnOZWw8Uhol5foX7NMtPpSHkwbGosp/OlRVHk
	aE/I7igUDqD3B8H3WZeVEKHovxCv+53OVlseqnqQJzWPK4ZGj+0CssLn7qthQNbn/82vBstj1OI
	JFxu/zfvzI6p+nqjQcdAvsowz0abihrq54OKz
X-Gm-Gg: AR+sD12jUMef3ICU+gGtGTLvwIfsO3yznM8PmLrXpULFpQmkkWRtinRJo5QGkChl8ol
	oMA89xKUEZAGkfrajlXfKQimPdSRx9+u9dLarl5rbIh1wKlv87wFyLgNN/4+YzzCXOZUJkNd2eU
	YTYSFynnG3LwYO8NW3MzMgOwbQbM725rq6bQ4Ie1ZwWYC0QC5ZdddJGr2sh3itar4hhAUz50pfh
	3/Q/mO83hPK9O1kX8TyIvrQInS2j6mGJRIc7BV/StPQVZTL+fyr6C8tYV0XVFshMGZvixecHqZH
	2n4wNj+fUx6ksiuIuTJp03xnr8hb/kk781bYisbzN7uSATakhmtZwbKlGJGOf2bVMAOuBg7L/Fs
	oXHhaNo1nv7qA+q+tF2lPRzLa9hIDAnxW2Q==
X-Received: by 2002:a05:6214:540e:b0:906:2b80:4684 with SMTP id
 6a1803df08f44-90a345ece0amr246662456d6.3.1786366836949; Mon, 10 Aug 2026
 06:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com> <xmqqzeywa6ol.fsf@gitster.g>
In-Reply-To: <xmqqzeywa6ol.fsf@gitster.g>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Mon, 10 Aug 2026 22:00:25 +0900
X-Gm-Features: AUfX_myg2ClnBl1gZ0pa90vtydC9738NOl7ypUki1GBVahE13jbjYSJ_ueHArw4
Message-ID: <CAF5D8-tvqwN6+ZcrRyy2Dbiv5KttrsT_rr07XPUFbtD7TLZrVg@mail.gmail.com>
Subject: Re: [PATCH] worktree add: improve message for ambiguous remote branch name
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 2:00=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
> > @@ -781,8 +791,14 @@ static char *dwim_branch(const char *path, char **=
new_branch)
> >
> >       *new_branch =3D branchname;
> >       if (guess_remote) {
> > +             int num_matches =3D 0;
> >               struct object_id oid;
> > -             char *remote =3D unique_tracking_name(*new_branch, &oid, =
NULL);
> > +             char *remote =3D unique_tracking_name(*new_branch, &oid, =
&num_matches);
> > +             if (!opts->quiet && !remote && num_matches > 1) {
> > +                     if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMO=
TE_BRANCH_NAME))
> > +                             advise(_(message_advice_ambiguous_remote_=
tracking_branch));
> > +                     warning(_("'%s' matched multiple (%d) remote trac=
king branches\n"), branchname, num_matches);
> > +             }
> >               return remote;
> >       }
>
> The worktree.guessremote configuration is set.  dwim_branch() is
> called when "git worktree add A/B/X" is run with a single argument
> "A/B/X", which comes here as "path", and that is munged into the
> branchname "X".
>
> We used to pass NULL as the second parameter to unique_tracking_name(),
> so we were only interested in the case where we have exactly one
> matching remote, and if there is 0 or multiple remotes with the
> named branch, we returned NULL from here.
>
> The patch does not change that, but using the branch name, we try to
> see if there are multiple matches, in that case, we give the advice
> message to say "hey, don't be so lazy, as X appears in more than one
> remote, so tell me which one you mean".

I thought the problem here was that it was impossible to distinguish whethe=
r
the guess was successful, but it was not true. We can distinguish by
the message:
    branch 'name' set up to track 'remote/name'.
I will not make changes to this part.

Thanks,
--=20
Yoichi NAKAYAMA
