Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816D918D
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346809; cv=none; b=rWSBMq8/FysePoJLyEJxGfPuDI9tvutFDAOTLdglX2NCjYJrV67MR6gTcbH7dx8NF/TGjrK7Q0XXVXMZYd5+6zTQpvMHeo08PbfkF1OuiObNIkKuN2QKsnq9O5JMilQ6+18wMmnelzRU9SNaZMSuDuXcgaUu+ka6s2YTLoXcWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346809; c=relaxed/simple;
	bh=A49nmnjpYCLWpfqWUdljVk0Vx/EnH55O52Wq/ypG2nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lz6KG6sM9QDiEo/4tz/tuPAqa0mye7uvQ2We/2iRvsddO9NPYlL9H9qHZjHHlnwwrHaUdf4FCyMRwyWqFtINFIst5oGYgEynbGpsD+Z93vQb+7WUYQR88bkow9H3XPKNpSGX8+h91z+vUOm0aRYQ7ZQiCi6orTigvBRAAgvWJbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEepONEv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEepONEv"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313910f392dso2999862a91.2
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754346807; x=1754951607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ6oTrec0njGwEsWvadP2hzg6khH0eSCZPCoswQoBSU=;
        b=cEepONEvsFCvMxuGixNfWjJHs+5yGEkFW6qGttFhIeieMDLBkKw7ro8HXecWHdMbvM
         AmmxeDeAfSMD84bmzMyb0gvIc4AzXN99XAEiCEFt7z+qG7ELBtq8Ex/jHUBwiwbXcwfG
         +xRLBqrxAgzj9ik9QXSHxXr/y2wxqVIP/SYqO9Nc21Svi/+HsacbsE0GnoErWFWD9jzA
         H2aVGC5ZcPn8e3/AY/+jZar9Vu3Ud1uvZwuX2WYxKedmdNZALJaJGYHGiHEi5kc12Wwg
         JdhsI+XWNrrxvYreVh33xQbFpfVGZF78aj4rQV4fHmMGIXmkQCwoR88dF6d8vNCyGHdc
         D5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754346807; x=1754951607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQ6oTrec0njGwEsWvadP2hzg6khH0eSCZPCoswQoBSU=;
        b=UJAaG0eCzCkAqu9sZaWNi1wNVe2/3RntXsr/sracUsGA9+Qd8SyBVPsqMeKbxOksEi
         yWwDCJz22tzfz1kJ1i3zmWiqORY7wqIVD2lin1RCbI8Nh2XQ49TnAhFeKvXbi+Kz0Hyi
         CmnHW8gGMDCwqZ/0FEYpO5SEjukpHw5IX44poz2un1Q75AFtO/nJPhwpduzsSTwXqAZK
         Zu2MLIY4hdmuO9hof6cpePXiMkdbXIcfKeVM3OJcddG1pSPIUV36HbPb4VmADhyDhe+q
         cCV30Y7cmAUY1Jf3Oq+tYZjb8VSo+CO+xvWxTWu/3S7srJLrZ0U70RNFDoKVfNyJ/Nfj
         BCKg==
X-Forwarded-Encrypted: i=1; AJvYcCUwkPn3gRwGsbV2OyH4FhMueRuijrW9VaiXyLisSOtiE70uE0Ey2QcGscUeM6J93XH/1LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFCf4E48+IoP78cJVq8UBJ91MkJxZKMKpsDi2/O8X8EZGII5/
	LN0Rt2zOJD82cwskUTBJjPpYKdYMwRWDaCbMS9Lchmxoo2zLxoRNd7fHxJf74JaUcsnG8vk9384
	61CAHXtFguRRjHpBNZzamTmJZnX5L5gs=
X-Gm-Gg: ASbGncuykvuhKlQJg4/H6L1udvDdWgtW+N7eY6v/wDUOzhhllOiUL2ZCcHJTeGQruhj
	GVsf39OPYCdJVA/dNLEl0YXMvZgYi/SYn4LwbgRQXiai9tJ7PnyC3BkzfWHQNtvlm4vb/YfKIrZ
	1JuOeVPi8uryN51RfmwLHall9fd/c2qRT+YB4YooTBmm5W/ZYrOr2Nh527x6YaBrAJrzgC+S41C
	p3Un1iwrkIzZI3TrZdiCP+ilM1zDh9BOsTesPMc
X-Google-Smtp-Source: AGHT+IGKWzKueJfJ11qR2yriCD61E0k2HZkYBJxxf3YBkg893Oq4ez4OhrSdS+5SFgDV6oJd8G2O1gzdLqhvO0Q5Q7o=
X-Received: by 2002:a17:90b:1c86:b0:321:265a:e0d3 with SMTP id
 98e67ed59e1d1-321265ae4bamr11051044a91.25.1754346806461; Mon, 04 Aug 2025
 15:33:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <0813d42d91fe9e27f713de3c7d2377c28311ae57.1753197791.git.gitgitgadget@gmail.com>
 <aIx7TxhXHhRI3vEt@pks.im>
In-Reply-To: <aIx7TxhXHhRI3vEt@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 4 Aug 2025 15:33:14 -0700
X-Gm-Features: Ac12FXx8S78x1o5cHgwj2rGHn2RHP4oq2pz7WqE3leV0BSA0ayX_KQzyMnY83MQ
Message-ID: <CABPp-BFUCPdxHi6XqNwGrUf7JBBJnd1SuPkHckg-8VyX=RGm+Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] merge-ort: fix directory rename on top of source of
 other rename/delete
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 1:31=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Tue, Jul 22, 2025 at 03:23:11PM +0000, Elijah Newren via GitGitGadget =
wrote:
>
> What a massive commit message. It almost felt like a blog post rather
> than a commit message, but I certainly don't mind the additional
> context.

Yeah...it certainly is.  I was spinning my wheels for a few weeks because o=
f
  * the number of items needed to trigger the issue
  * the misleading/buggy testcases we had, now addressed earlier in this se=
ries
  * the number of other nearby bugs that also existed
  * the fact that "relevant renames" sometimes tricks you into
thinking you're testing a rename testcase when you're not
and when I started explaining it, I realized there was lots of assumed
background needed to understand the bug that I'm not sure others on
the list would have.

Besides, I was worried that _I_ would forget all these details in 6
months, so I wanted it all spelled out.

Thanks for being understanding of the lengthy tome this commit message
became.  And for reading all of it!

> > From: Elijah Newren <newren@gmail.com>
> >
> > At GitHub, we've got a real-world repository that has been triggering
> > failures of the form:
> >
> >     git: merge-ort.c:3007: process_renames: Assertion `newinfo && !newi=
nfo->merged.clean' failed.
> >
> > which comes from the line:
> >
> >     VERIFY_CI(newinfo);
> >
> > Unfortunately, this one has been quite complex to unravel, and is a
> > bit complex to explain.  So, I'm going to carefully try to explain each
> > relevant piece needed to understand the fix, then carefully build up
> > from a simple testcase to some of the relevant testcases.
> >
> > =3D=3D New special case we need to consider =3D=3D
> >
> > Rename pairs in the diffcore machinery connect the source path of a
> > rename with the destination path of a rename.  Since we have rename
> > pairs to consider on both sides of history since the merge base,
> > merging has to consider a few special cases of possible overlap:
> >
> >   A) two rename pairs having the same target path
> >   B) two rename pairs having the same source path
> >   C) the source path of one rename pair being the target path of a
> >      different rename pair
>
> So basically file A get's moved somewhere else and then replaced by a
> different file B?

Yup.

>
> > Some of these came up often enough that we gave them names:
> >   A) a rename/rename(2to1) conflict (looks similar to an add/add confli=
ct)
> >   B) a rename/rename(1to2) conflict, which represents the same path bei=
ng
> >      renamed differently on the two sides of history
> >   C) not yet named
> >
> > merge-ort is well-prepared to handle cases (A) and (B), as was
> > merge-recursive (which was merge-ort's predecessor).  Case (C) was
> > briefly considered during the years of merge-recursive maintenance,
> > but the full extent of support it got was a few FIXME/TODO comments
> > littered around the code highlighting some of the places that would
> > probably need to be fixed to support it.  When I wrote merge-ort I
> > ignored case (C) entirely, since I believed that case (C) was only
> > possible if we were to support break detection during merges.  Not
> > only had break detection never been supported by any merge algorithm,
> > I thought break detection wasn't worth the effort to support in a
> > merge algorithm.  However, it turns out that case (C) can be triggered
> > without break detection, if there's enough moving pieces.
> >
> > Before I dive into how to trigger case (C) with directory renames plus
> > other renames, it might be helpful to use a simpler example with break
> > detection first.  And before we get to that it may help to explain
> > some more basics of handling renames in the merge algorithm.  So, let
> > me first backup and provide a quick refresher on on each of
>
> s/on on/on/

Thanks.

> [snip]
> > =3D=3D Directory rename detection =3D=3D
> >
> > If one side of history renames directory D/ -> E/, and the other side o=
f
> > history adds new files to E/, then directory rename detection notices
>
> Did you mean to say "D/" here?

Yes, thanks.

> [snip]
> > =3D=3D Testcases 8+ =3D=3D
> >
> > Another bonus bug, found via understanding our final solution (and the
> > failure of our first attempted solution)!
>
> s/solution/solutions/ as there are multiple attempted solutions that
> were discarded?

Yeah, I typed up this commit message and then found more issues, and
inserted them earlier.  I'll fix up the wording; thanks.

> > diff --git a/merge-ort.c b/merge-ort.c
> > index feb06720c7e1..f1ecccee940b 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -2313,14 +2313,20 @@ static char *apply_dir_rename(struct strmap_ent=
ry *rename_info,
> >       return strbuf_detach(&new_path, NULL);
> >  }
> >
> > -static int path_in_way(struct strmap *paths, const char *path, unsigne=
d side_mask)
> > +static int path_in_way(struct strmap *paths,
> > +                    const char *path,
> > +                    unsigned side_mask,
> > +                    struct diff_filepair *p)
> >  {
> >       struct merged_info *mi =3D strmap_get(paths, path);
> >       struct conflict_info *ci;
> >       if (!mi)
> >               return 0;
> >       INITIALIZE_CI(ci, mi);
> > -     return mi->clean || (side_mask & (ci->filemask | ci->dirmask));
> > +     return mi->clean || (side_mask & (ci->filemask | ci->dirmask))
> > +       // See testcases 12n, 12p, 12q for more details on this next co=
ndition
>
> This should use `/* */`-style comments.

Yep, will fix.

>
> > +                      || ((ci->filemask & 0x01) &&
> > +                          strcmp(p->one->path, path));
>
> So if we have a stage 1 index entry and the path is the same due to a
> transitive rename we can say that the path is not in the way?

Right if A -> A, then we know that the original A and the new A do in
fact have related contents and thus the old A is not in the way of the
new A.  I would have rather just checked for a stage 1 index entry and
said that the presence of such a thing means there's a file in the way
(that's what I originally did), but the rename-to-self case is special
and is why the strcmp condition is there.
