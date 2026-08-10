Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9B73E3167
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368959; cv=pass; b=fcDc1NWtLUZpoXfRzmyOaFlg/7H7RPoizW5dvv2NgLVcon/fklLQNNWuryuIwo9ETMp4ko55/8UIeJ8b8+hQSCSp7ssx76EsI6MD+PhdVr1uy9F8+TolDtwBN6J+QLtIhjRLYM+oVqki1RJ2MvaRlrI03h/x+VwcQWhj+NMFk3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368959; c=relaxed/simple;
	bh=3MD3a4u58KpPUnX4JN/AjaLnNMQuonQUmmq4ObTPhsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Px19GZQuPDQBxC/8iSeiAzWlbv6mGyQjZjQcBJSuKt654F9SZWHyy3FLg2qncnGgCLQsCblNjW92AC+cEjH2RysrLHdoJ2ET4B++v8pdWxX7Pr0lEOwOQtvcLZ2+zFZSJ/4ydPYRf3R6TA6nPhYDldsZJ/28ctiA5GqI4Z/SPxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLJSbY7t; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLJSbY7t"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-908239232adso8019806d6.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 06:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786368956; cv=none;
        d=google.com; s=arc-20260327;
        b=JjNV6DsR4oIl1lSaMxa0MYRD+Rhiik0AGHg+RKMSYg8qy+Z6GkUbv5HL9Ynf9xJTuZ
         J2YAv6l56F7xeQWShvnWJPdF6bQUWcy7v+2o/iABGgTrR3VQdpm1vyZfM7kA1bJMUd5t
         bQR5xWSj7P8B3KO4ljo3rAp731K+iLE+VyLPG7UYTZmmrauZcCyJqZqixHdmBkL7h1xm
         nkR/qLGaaR+SjkjV/5Zk5qzKoZ8zYJqulCay3Ph02VuQi9xbSvHsDO4GWCWLw2vIzGzt
         RpdbP8sjCX7RpiojD+tisuw+X5hwEmOdV4fvZp4jaNjpvDRFz0c6zcclCJHVs+nIpmvp
         yZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tx/12n9q1u+wIRissqdfOi1eejV7f9TyR94cAkpmXKo=;
        fh=/dYD6CPpFJ+zJc5ygPtsFST5kuLqZaCrbIxTpVX4OSo=;
        b=ZpZ/LsBayDUXRD5SHEVTqC02AsJQ611LRJllOnBHlcVt8OJBRYglQNICGfGOOkD9s9
         nGdBmGlSBNkARrmieC+X3c7729i8TlBz8HIw9cnzrSBRYrS3sA2GbFSvIeCe9xeBxquq
         eWfOdXieh+c0Fp3LCuVCT++vp4VlcAdhxAphUkZxhyNsaGYcTsD67C80EAQ+0pAALEjw
         /5OQcFBlMA3q1n+awG34vSiIW/8bLCBzpCUvIlvCU9qeqeYF4s68UbPGpf7/fSvRhqoo
         1qTDiohkOnoEMzL2x7pHmwjGyjPWoWvHJaoDudS8Ngd0yk7erI22ifCEtRbkCmSDT8Yd
         IVlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786368956; x=1786973756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tx/12n9q1u+wIRissqdfOi1eejV7f9TyR94cAkpmXKo=;
        b=QLJSbY7t252SXBJE6Q+/9JR3S0FGJb90PDJ6R5rit8R/miVHCJSigSTZM/fkBOJBRa
         7FEBqRRrpVgnbp2STU0x/irnMN2wNiKm071jJWnaCzv8dB08zB70+KmFUIKvqn3q1k4O
         P7i8YMtPE1GeMyoxnh7knwBCZr2ZxQ8oaQz8LXxoKymif7fKqBZQwTsAHi9Dp9PQfNAg
         QB2VBYNxzTUeMo2S0+g1RHDZjSs5GlXwv7brgGGO2AG5+ITlnzj0vhNyw7iTGJV1P1YM
         pgEgNd5d/KNxa6ovhNW5CBlSnIoyMquaT7jwZ8M6LTBK9X7yihrcFV8NYRTWP131N7o1
         RQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786368956; x=1786973756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tx/12n9q1u+wIRissqdfOi1eejV7f9TyR94cAkpmXKo=;
        b=Q7Jqt7MdtdqL1I9ImdSaG/m6PVl2MeOHz271LSYpgKFEIboLoLyxXiFxdev7vBS+VT
         8/CQ9ysF6U3TADtY3aTNd/r7kZkdlU55j/yo/8qAdxY7Fa2Z4l6ETlgGo9nkdm4I0WAC
         gdMB0Tc8EmXqf/Qu4IgXS6AJmEHEq8h8/yYtXF4WgbNTIdEOITEuQZuOj+h94Pjp15fq
         //Sg8ZmzbmjgbwyCUENNNMd0HGMhcWAQ37q6pw0Dtvr6YwX/yiIFEZh+1Z/7af2RRBlc
         JhuX3TsKTfhxxzADON7wS1ZYAp4s2rWkjA3vSzAEUlCTkUPZFwJFY6I5xD2aFOMdzJUF
         Ls8w==
X-Forwarded-Encrypted: i=1; AHgh+Rr1LtZwAKQ/38DyZu9hRKoKs4SCohWDxjwNQlEq4ygP0iOtrHizg+S20x3eYu23aXdrj3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ4gvMSFPmgEEBSltt34nVov1f+eO3h47Yxx8K1BlYjmv3t45C
	cXKPHQfr5mbwQPCSZmeTEBdSHEFzvnXT5riILKJIIFGzksh3DxorVTDfrMRgczLuqW3J44F7yOg
	/FhoN04EFKQgJQm+PxUF6gGoAe4wtCJE=
X-Gm-Gg: AR+sD10PaLeH7p3kn4WNZSgdCifqZP8eHk1935oA9oSF5ws3GDiXi/MAvLCDJiFy8DH
	Lx79+4iFKhRt2VJarp9YVHnbAQUedVQthaPwxBBpdAG+4KL+NirFQq1L3YKWcncee3dNEZVJw4C
	NpyQB6sQ5uLvx+1AnKnNzxGiZKDp59/p9+sMRQnkMAO3ex6c9SQ1lnUqcLjYTzGXs0kUQaXOV2z
	n0/N+eHSPf9S+MNE3BbfrWYkyNE6hGQPHT5jKkiyUdcN0+RSPF1WyQJXbLM5PAcxwp9ChgCR5sv
	LGfOZinCHvhxvvQeagZGeSpjviYGi39D8cIqC1VXHTJI2H3IUCfmnwykx6xk+CJ7g5YZMc6z+zC
	me7W6RtzNXVymiPUCQ9JM8kLhNcVcys7azg==
X-Received: by 2002:a05:6214:b6e:b0:908:598a:91d4 with SMTP id
 6a1803df08f44-90a366e8fd0mr197698626d6.8.1786368956251; Mon, 10 Aug 2026
 06:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com> <CALnO6CAdr0ft8KFgGCFX9ueKUdX9-2DwB+SNs3Q8ykw4ne=54Q@mail.gmail.com>
In-Reply-To: <CALnO6CAdr0ft8KFgGCFX9ueKUdX9-2DwB+SNs3Q8ykw4ne=54Q@mail.gmail.com>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Mon, 10 Aug 2026 22:35:44 +0900
X-Gm-Features: AUfX_myC9vvuIp16VuWs0hGBr4Sk4h1YOzMSsA-_eqKA0gF53sQhWNZW05E2ihg
Message-ID: <CAF5D8-vkd3GOOpdaC=swLv-gxtCzkdhNNUpbTSwr2PBH_Jk=1w@mail.gmail.com>
Subject: Re: [PATCH] worktree add: improve message for ambiguous remote branch name
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 10:08=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.co=
m> wrote:
> > @@ -904,10 +920,16 @@ static int add(int ac, const char **av, const cha=
r *prefix,
> >
> >                 commit =3D lookup_commit_reference_by_name(branch);
> >                 if (!commit) {
> > -                       remote =3D unique_tracking_name(branch, &oid, N=
ULL);
> > +                       int num_matches =3D 0;
> > +                       remote =3D unique_tracking_name(branch, &oid, &=
num_matches);
> >                         if (remote) {
> >                                 new_branch =3D branch;
> >                                 branch =3D new_branch_to_free =3D remot=
e;
> > +                       } else if (num_matches > 1) {
> > +                               if (!opts.quiet && advice_enabled(ADVIC=
E_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
> > +                                       advise(_(message_advice_ambiguo=
us_remote_tracking_branch));
> > +                               }
> > +                               die(_("'%s' matched multiple (%d) remot=
e tracking branches"), branch, num_matches);
> >                         }
> >                 }
>
> We would now die() here where we didn't before. I'm not suggesting
> that is wrong (I haven't given it much thought), but I was surprised
> to see it in the code without mention in the message, which I've left
> quoted above. In particular, the proposed log message talks about
> giving new advice, so I wasn't expecting us to abort.
>
> Now, it may be that this case already causes an error later on (I
> haven't analyzed that), in which case dying early with a better
> diagnostic is definitely helpful. If that's the case, it would be nice
> to spell that out for the rest of us :)
>
> If not, I would want to know why we can die() here without bothering
> anyone's workflow that is expecting us to carry on.

Before the change, it calles lookup_commit_reference_by_name() again
in the if condition and die() at:

    if (!opts.orphan && !lookup_commit_reference_by_name(branch)) {
        /* snip */
        die(_("invalid reference: %s"), branch);
    }

The motivation for the fix was that this error message did not
accurately reflect the situation.

Thanks,
--=20
Yoichi NAKAYAMA
