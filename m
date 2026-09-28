Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84C48D88E
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596959; cv=pass; b=PWQ9GUSdfSt08QYrMmCl4eefejNPVDnEHixMTwMGXV1Y9Bpe+hpteOlewU3Nv8B6InW3ScJ67CEqqKqD39uAPEmvjcphDrKCbPJJyL5Ucf3pXjf/hrvN/R8xCADGYvWHd+dcFm9+AWdjCDZkPXJ26rSquDiz4adWLPza3QFoSdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596959; c=relaxed/simple;
	bh=MS2zXWrKjf25V3m1r41YRsMawXdsc64a9rXNlcj9O98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klZz567JB6hWHWguEmoJwf+S1J2RA78of09OAR+0fbYEDFQl8u4a553WwJbe5slbNjXs4DLKLIFrkOa1xgN4KF2Kzm5h026zfdPES5vQfRvGjzklVwlpS6bYujLGnt9zVKvTRjILFDgKYTOfi0HEexZhB6PvSk/Ykvr/hQPHUdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuLEP9h5; arc=pass smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuLEP9h5"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0eeda3e03so729024a91.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 05:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790596957; cv=none;
        d=google.com; s=arc-20260327;
        b=o8l3LAQOlcE7kzPk401yiyp0EUfIPLAJ1PYGBW3UT+QKR1ur/Pp3EyxVfGvsdVasCx
         4nbrvR15O2cm0v+Kw1h0JdY7lyr0+YJmrXdzi6JMgmJYP4DQqqK5Ln9RKhTuOioKZeXk
         mJy4p80XLhu8lGm2Zv0HQmaWG8gNZP3bpJIwQUojt2yEEdpGDd2NKnSOAV548IIlua0t
         GgoVmRggYJEfCRiYF0f1RDxgDVFDjSHV+V/VU/tINLUKfjIXp/0nngKpAQZzV3VjCZiD
         NGHfOUi+cQCXHew+8mqb3Ha0xD5u4T9ZQDBvKNna21wNaV+6EwMb98/bXBkZIHj6f2ql
         QKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zVUoPMaVBHjxRryu1c16Fko5TeQjTCi2gH0y41TYVjQ=;
        fh=Z3CCosVd4sDZb32LVg0WeJBc97tT2N78jkAGs3iZyx8=;
        b=n25fvaBG2/A4wsziU96CrrW7LkHrfEChxPFhLWIZ0nLRQ3w9w7ihxlAyD6xLWG3REG
         D0eBsWg0H1it3e3Hh523wpbprMDv2OBfQRAwkVg9yXdWBOkuqe+z9/cNYCmCUybqGSS2
         zrPjvWxzoLn6a8RQZVqgjSaKCFN0Nd3wvzzHFa9tDzsaptSe0YfIeT1qffRjjMoNqgZR
         KgmNF5UR2JccfBIw5XYj0xj4JxiHN1g0AKs74qet7Rsz6Jfv7bSjZfhi/89hWfsM+FKh
         VUcUUa8pPvN1RWVQc59RbMQQiX3ALhsL1dSXUT2KRfe8rhmJgR5tvu4TSlMtFtuy6lnf
         SLCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790596957; x=1791201757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zVUoPMaVBHjxRryu1c16Fko5TeQjTCi2gH0y41TYVjQ=;
        b=kuLEP9h56aD+FOls/bNR2SZ3ELq5VNYYu6faF8xl8Er4acLEx24iLa6t119w1434xC
         xCaqPEePDtmk2RkkVQES4KsE92uuw3uS0KqSkpI17hGvPvxjICvjUKUreB27VniSmBLs
         wyz0BFICVWR9AVPZMZhsZRLBDRzl+v2okcDLm77y9yiHaU81i7cHZ3EPBmjvG2I6WOmA
         h3+n18Y18K7sxz4cthBdVhvIzhwpYnAVVtTR5qWG17v7ApyNqMd0V1erd0jRV8XYGN6Q
         xtqKbY6mMMG52xDx3pLfoMG0OkIQl6tB79h9P6oALdlWqd6S9tBHS/M0zwWg55D8y1A3
         /Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790596957; x=1791201757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zVUoPMaVBHjxRryu1c16Fko5TeQjTCi2gH0y41TYVjQ=;
        b=DWw0O19uwC5aiHTXwDTIEz2NJ5w3qSlKSWfW94ZapVETpavwhQ2wnqMkiKqDdYnhsP
         OVd/FZMdiLHvNKZAYR9oxJfelVMVr5MRsTF+4/RBnpdXk67TD1kwnUrDcIw9g6nQ2DKk
         EJrH1XZwkeDystsJ9cNctRceVx9LwpEVK+0Ydi0XtT8vwasz/UgOXjODIEFfO3lcPi3V
         Ow64UqF9sNMFHPmt2C2j7j+YOiwYre5w4cqJ/41rYfOIcEWptscL/fOrS/UO4+VkJEDm
         oLqa8Wb1lrY2TD/QUdyEGfsJ2DhF+R1SoWIRRg48SkeQu+aAxJMNrrTX59A0j1Wn9nIM
         0t6Q==
X-Gm-Message-State: AFuF++npkNX7uTFJRejWnQERCfhNC4jxrMVhZJa+2WEYoqa+eUwTO1F+
	5Jbbur76Wympr2yTpYnwK6k0F6189Gf7+0l9NR1NSEwwckLQMDbC3UI+QxHRKY55oCfOWMO6vl+
	6v4DCvAhPGC5gBGfxaBFXJkCOPAAuQ1I=
X-Gm-Gg: AYBFou2o2fjkHvPi9mNgfpy/9qd8TUcu4niHka3eeyfC6K+Sh6f2T3IMaXMKa3LWDRZ
	PcMBfIO7nFyPP4Tv5N5A+NAkW6ysCbI6n1U/MhUS179np9roAGyqK3+CiiY9fhiEqvBnzyD3vwU
	a5iWZM0OjCwcoK56o5KHpSE+yCUKruu2rb/O9/0RbCzxldYL/CsiuTsc/n0qA8AJT0fW4Okztg/
	F+qNcrxAwrDL9PL+2G+cGsqvzbTvjFJymYGWKpp4M6shOLjQ32QhI9eJ/7paBRWslS7O5U33cXN
	jqgsFc+K/cD2pxrp8s/Zvp1gGp0TvXh3EtBfSVt3rw9NbhlUy9/XUmqn37gB0kTwzHBd1yd+D6t
	6Z89XS6jjWmceWI8ufz7BKpXxSFOseZb+ZHXrAdwvh2iyEp85/fdM5o29YlW6uBxOwU8WqZ+Cwj
	bnEKBajqk=
X-Received: by 2002:a05:6a20:2586:b0:3de:6dae:b7dd with SMTP id
 adf61e73a8af0-3de6daec0e1mr1544340637.91.1790596956947; Mon, 28 Sep 2026
 05:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790168285.git.ben.knoble@gmail.com> <cover.1790425008.git.ben.knoble@gmail.com>
 <fde7fb7988b695707c6f2776adc18eec7fe4696a.1790425008.git.ben.knoble@gmail.com>
 <xmqqo6dir04i.fsf@gitster.g>
In-Reply-To: <xmqqo6dir04i.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 28 Sep 2026 08:02:25 -0400
X-Gm-Features: AclHuK8YXD3XqckQK2mli-paeHGrMeb5w2LbOaoeP5FfWBtTA-_I1fslKi0lcvM
Message-ID: <CALnO6CBTsfMsPrkSMHj6bRMqHc3vEfNEJnh6vz=2+_qCf_26Sg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] builtin/stash: merge index in-core
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Elijah Newren <newren@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Victoria Dye <vdye@github.com>, Adam Johnson <me@adamj.eu>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 2:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > @@ -671,29 +627,27 @@ static enum stash_apply_result do_apply_stash(con=
st char *prefix,
> >                   oideq(&c_tree, &info->i_tree)) {
> >                       has_index =3D 0;
> >               } else {
> > -                     struct strbuf out =3D STRBUF_INIT;
> > +                     struct merge_result result =3D { 0 };
> >
> > -                     if (diff_tree_binary(&out, &info->w_commit)) {
> > -                             strbuf_release(&out);
> > -                             return error(_("could not generate diff %=
s^!."),
> > -                                          oid_to_hex(&info->w_commit))=
;
> > -                     }
> > +                     o.branch1 =3D "Current index";
> > +                     o.branch2 =3D "Stashed index changes";
> > +                     o.ancestor =3D "Stash base";
> >
> > -                     ret =3D apply_cached(&out);
> > -                     strbuf_release(&out);
> > -                     if (ret)
> > +                     o.verbosity =3D 0;
>
> We realize that 'o' is a struct merge_options defined on the stack
> for this function, initialized with init_ui_merge_options() fairly
> early on.  It would have initialized '.verbosity' to the default
> verbosity, the merge.verbosity configuration variable, or the
> GIT_MERGE_VERBOSITY environment variable.
>
> You drop the verbosity here, presumably because you want to match
> the previous implementation 'diff-tree | apply --cached' (which I
> guess was fairly quiet, but I do not use 'stash pop --index'
> myself).

Yes, the original piped "apply --cached" output to a strbuf and discarded i=
t.

> > +
> > +                     if (!result.clean)
> >                               return error(_("conflicts in index. "
> >                                              "Try without --index."));
> > -
> > -                     discard_index(the_repository->index);
> > -                     repo_read_index(the_repository);
> > -                     if (write_index_as_tree(&index_tree, the_reposito=
ry->index,
> > -                                             repo_get_index_file(the_r=
epository), 0, NULL))
> > -                             return error(_("could not save index tree=
"));
> > -
> > -                     reset_head();
> > -                     discard_index(the_repository->index);
> > -                     repo_read_index(the_repository);
> >               }
> >       }
>
>
> But the thing is, this is not the end of the function, or the last
> call to the merge machinery using 'o'.  We then use the same 'o' to
> drive another three-way merge.  Yet nobody restores '.verbosity'
> that was unconditionally turned off above for that second merge.

But you're right, we should restore the verbosity (which is not what
the sketch patch does exactly). Will fix.
