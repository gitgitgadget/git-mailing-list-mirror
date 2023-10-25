Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE83817EE
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAM6R1vR"
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ACFA6
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 02:35:25 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57e40f0189aso2873221eaf.1
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 02:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698226524; x=1698831324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlNi0drLDiiJrgkNvZfVESUPz5kN2maE/Oc5aAdDseg=;
        b=BAM6R1vRqXdtVlJnprbOJKORzYhPTFldgb+4ypn3gRQznEi6kw46wwIGPpWHw7TxpM
         0S9f4rxIvAvYnnl9vD13fD5SbOCZRekYpp5y2eUol3j2vN8oFzfagGIFDS9Vqzd7cDB+
         UEW91hF4D2JrgYNq8GEy9qNRq9D/V+dudbniptnpYFVMfK52HUURfsSBsqF0R0y/tyOO
         8eVPzH6DtIPMnQwmpkPH/VqOpFPHUZwU6SFaLckG0nrFF/WUbBWI3NGLR/QuJ+Atqt97
         fPBlQ1swdKcWtmMF2C+EkLVnYl59+T6XhCUM8OwUskh+ZTuCdl14syebSFFhwhlhdBT+
         i/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698226524; x=1698831324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlNi0drLDiiJrgkNvZfVESUPz5kN2maE/Oc5aAdDseg=;
        b=ANt8P6fioUB591GxVXl8NLmr0neygcnpdPTt+d0TqKXBNAJ9iY54Eu5dw4RkXyOjnU
         92jKy4+yLYvCvrK2uGicKL6SNFV9omTgu1yaLD7n/DgXWzQzG651X7a9fvu/eb4J26cW
         dGoSUwj0XTFkKZ4Ef6yMFiXDSBPk6pZwSubBmZa1jBD1C+XWKUzYHiqEqXuU202OdMyK
         jufqVZPbuR516UF4jEL+jDrPGohHOmeEKPuI79SPwNiViPtU2wIEpag6HbdlNzRv9lQ7
         NlXtm64pTKVJJ7cbch0oV3+37nB0GKPhb8R7RHx8Wfg3T4KdSNBPk/rxv9tasT5+5fEv
         7XYA==
X-Gm-Message-State: AOJu0YxmEhOvZ/culvFdBmjYKZKPvpMH7WYPusf1hBD7sZAuKFNaYwnE
	X7zkSOOs+tIlpBnKtIcABGRz1IMCcCEfbB9pt9BacyDdNUnA1g==
X-Google-Smtp-Source: AGHT+IGWot9YzpEI71dxH1JNuBu4ZtTVJap6Ciy7RPsmfqew+nFEfiRe2oZ+YXqTVLiXdxGN1ftO/UkVoJLEPNvcKPI=
X-Received: by 2002:a05:6871:7408:b0:1ea:9a1:e96f with SMTP id
 nw8-20020a056871740800b001ea09a1e96fmr17491780oac.9.1698226524265; Wed, 25
 Oct 2023 02:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019121024.194317-1-karthik.188@gmail.com>
 <20231024122631.158415-1-karthik.188@gmail.com> <20231024122631.158415-4-karthik.188@gmail.com>
 <xmqqbkcn52z4.fsf@gitster.g>
In-Reply-To: <xmqqbkcn52z4.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 25 Oct 2023 11:34:58 +0200
Message-ID: <CAOLa=ZQ6K8g-r+Oq8Jq53QbB4qhKr6HLgpfT5OjtgzBW7DMzbg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rev-list: add commit object support in `--missing` option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 7:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> I would suspect that swapping if/else would make it easier to
> follow.  Everybody else in the patch guards the use of the oidset
> with "were we told not to die on missing objects?", i.e.,
>
>         if (revs->do_not_die_on_missing_objects)
>                 oidset_insert(&revs->missing_objects, &p->object.oid);
>         else
>                 return -1; /* corrupt repository */
>

Makes sense. Will change.

> > @@ -3800,6 +3809,9 @@ int prepare_revision_walk(struct rev_info *revs)
> >                                      FOR_EACH_OBJECT_PROMISOR_ONLY);
> >       }
> >
> > +     if (revs->do_not_die_on_missing_objects)
> > +             oidset_init(&revs->missing_objects, 0);
>
> I read the patch to make sure that .missing_objects oidset is used
> only when .do_not_die_on_missing_objects is set and the oidset is
> untouched unless it is initialized.  Well done.
>
> I know I floated "perhaps oidset can replace the object bits,
> especially because the number of objects that need marking is
> expected to be small", but I am curious what the performance
> implication of this would be.  Is this something we can create
> comparison easily?

I did a simple comparision here, I randomly deleted commits which had
child commits with greater than 2 parents.

$ git rev-list --missing=3Dprint HEAD | grep "?" | wc -l
828

Using the flag bit:

$ hyperfine -w 3 "~/git/bin-wrappers/git rev-list --missing=3Dallow-any HEA=
D"
Benchmark 1: ~/git/bin-wrappers/git rev-list --missing=3Dallow-any HEAD
  Time (mean =C2=B1 =CF=83):     860.5 ms =C2=B1  15.2 ms    [User: 375.3 m=
s, System: 467.5 ms]
  Range (min =E2=80=A6 max):   835.2 ms =E2=80=A6 881.0 ms    10 runs

Using the oidset:

$ hyperfine -w 3 "~/git/bin-wrappers/git rev-list --missing=3Dallow-any HEA=
D"
Benchmark 1: ~/git/bin-wrappers/git rev-list --missing=3Dallow-any HEAD
  Time (mean =C2=B1 =CF=83):     901.3 ms =C2=B1   9.6 ms    [User: 394.3 m=
s, System: 488.3 ms]
  Range (min =E2=80=A6 max):   885.0 ms =E2=80=A6 913.2 ms    10 runs

Its definitely slower, but not by much.

>
> > I noticed that nobody releases the resource held by this new oidset.
> > Shouldn't we do so in revision.c:release_revisions()?
>
> It seems that linux-leaks CI job noticed the same.
>
> https://github.com/git/git/actions/runs/6633599458/job/18021612518#step:5=
:2949
>
> I wonder if the following is sufficient?
>
>  revision.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git c/revision.c w/revision.c
> index 724a116401..7a67ff74dc 100644
> --- c/revision.c
> +++ w/revision.c
> @@ -3136,6 +3136,8 @@ void release_revisions(struct rev_info *revs)
>         clear_decoration(&revs->merge_simplification, free);
>         clear_decoration(&revs->treesame, free);
>         line_log_free(revs);
> +       if (revs->do_not_die_on_missing_objects)
> +               oidset_clear(&revs->missing_objects);
>  }
>
>  static void add_child(struct rev_info *revs, struct commit *parent, stru=
ct commit *child)
>

Yup, this seems right and was missed, will add.


On Wed, Oct 25, 2023 at 8:40=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> >
> >       if (commit->object.flags & ADDED)
> >               return 0;
> > +     if (revs->do_not_die_on_missing_objects &&
> > +             oidset_contains(&revs->missing_objects, &commit->object.o=
id))
>
> Nit: indentation is off here.
>

Thanks, will fix.

> > +
> > +     /* Missing objects to be tracked without failing traversal. */
> > +     struct oidset missing_objects;
>
> As far as I can see we only use this set to track missing commits, but
> none of the other objects. The name thus feels a bit misleading to me,
> as a reader might rightfully assume that it contains _all_ missing
> objects after the revwalk. Should we rename it to `missing_commits` to
> clarify?
>

Fair enough, I was thinking of being future compatible. But probably best t=
o
be specific now and refactor as needed in the future. Will change.

Thanks both for the review!
