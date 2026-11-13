Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575028;
	b=AzGLd0uMRd94Xcg+EF/w4ffON2z8mTltV8nzVuGgOo7qymtCBRklqagK3/28eow1zHA/
	 yhafpU7vot29tsI90xxoGhs07MfC8UavYbz1CivBj8HJWNJ7r/7QWFywJxKHgbhFK5Gbn
	 SOw/aZQcgSKgAAxw7PG14lWNMxpDmKEF74zu3z4XvzrC9PPlyxO8NJvnO4qXJAJ+MO+V0
	 j4ndRJV+OnJ7AtGE2oThDoSArj92O9mAKLiehn4zfx0C35DopfNQY3FurPXBOufJupMb2
	 ajEgcDMNFx2bhzqxPY1m/R0Xfn2v0TUVG9L2rJ9u6oRT07X3qUEGSrOu9E8onXVeYlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:Mime-Version:Subject:From:In-Reply-To:Cc:
	 Date:Message-Id:References:To:X-Mailer;
	bh=IW8bUyh5kynkixJR5Jc86gk1A1wz3NKp4wAhJZTqrPU=;
	b=oYqzxvhQ+spdFtTZkL+JbkW+1BWVtm/ggvWtATs2RrRJGb9GN6NshEcs/owbropDaXQv
	 94McAD0I5xav6pxs6LrRkPjHatmgKZGJM/1EdRl1Q84UjryxYVmVsah7PegHMtwdPbrGg
	 GrwsQ25hVyM/2IkB08cYavlc4hLSiP6ApfiFcg4Z0o876u5Q5/DlfNTbuVyRyh621WZMo
	 zG8RXeUcIZRvpl1dycbEKSB8eXgO0pcRasTQ8a6YGLFPbE2/9/wVLJ2llSbnEbdylse/a
	 wAxqsZmHdOHkkDxJpF08+GUtwhHZanNdjTAilIHoQ93G4l5ZpWPkStYKRiPDxoPXj0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mQLGwyp+;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ABC606A327
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 13:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54ABC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mQLGwyp+
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cc1cf48a39so216359137.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 05:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794575027; x=1795179827; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IW8bUyh5kynkixJR5Jc86gk1A1wz3NKp4wAhJZTqrPU=;
        b=mQLGwyp+5sPpaZ/Jd4HHCEuYzqkrVNNFf32bZhPEnLZEbCqDtp9rLqHHX0BOg30g+R
         wUQx2owF7BvRCdwxh1ensFNmJp9CMRSr8lAWXw0UGsy3FtefrGgQBAjtMTR4e/LHD9FC
         AC5uka4TTMHfLnlwLWXYTFrYMdRVEgMmuw5aKHBpDjNF3nTnL7iHndm0LdKQYL6/+Zd8
         YPxNIyP0+1Z+nBuRt7yeE+9xJKOTuRLDbdSKxGS9iEaBai5tJviu2tJduneo5epqy4sB
         K1BfYxBW1Z0ZrdyjK0BE1HKlVntH3DrXiyl4kBbNIXFDKyCj4b5oDt0d6fe2LFyzLEj6
         Hg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794575027; x=1795179827;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IW8bUyh5kynkixJR5Jc86gk1A1wz3NKp4wAhJZTqrPU=;
        b=V1q54IQ6UGKw093dHc0EmfrZHPqMKRVGWw5H6/rynOfPOgOn3bzyofC7Y0+7TTPZt0
         /ii5P4FRIGEspQ8FHBS+BhS0b9JHbqfQmyVN/JLCAXOZ9cPjh16o0Jt8ZJNxCx/P5CXy
         2dCG1dIHjGem+jA84HjZ3YTZBRcVsRK2uXJQbs1uEtmt4VJR8Zrhb/0IRGryZJkAKG/X
         33CdXO6FnWs/sEdQ4FIPDCSxmdcNGh5Gp51OnK0LRngnIYVvdgsr7MXYPn/lqcQpQFad
         g/ua6waQgzgT6mMTi++y+FRdcuy7nYg5LVfh9erXdWk+r22N8fW2vOxiOwuZZZm1ioyG
         +UOQ==
X-Gm-Message-State: APuU4Z80IUXpmaSw5JLQsDni8knqyTyARm12OP5EPU+yBC39pOKyfYuj
	KVVciRwMXbE4AYfmfNJ7WweC46th3RLPEjnGsr//3HP50SHyzeWLDiWR
X-Gm-Gg: AYBFou0htvVRnbJr7o9+OlDOzok2wFDTJdl5SEhdpHrPCNu0QrC32DGiREQRbgYZG2c
	lw+0nMDF8hC/VggqP0MR2v5B2SzVkcds/dhHVU/SWziiJOrVUARS9Q5Jx9d/TybgMfmIdWymsU+
	UmDZtvxllSYUEHnKk53KCUe0UeW8BNuM7K9/lwuEywpu86FPjzoZOV00UwNzO7r6wWO8sjRtnCt
	Eq++JGxR6udjmyXvWkXbD+76xTRpcSK+uReQOGY/q0S3rGu6wZdHpfZCsgoKaWXDRwdKoU0FbKW
	X1fYj5E7tI2w/sLTa2IJFFCLh2XeQKIQWqIsfyfquU8DW5RJxR5P9KTbTDr1j6f9TfD3AYa99Hy
	1rbg57jKT/SXLBghVdqsQVY4iZuqZ5vPrAEY5dRCIizXYDVWWZUydqMLU1J8BQ1KQZntV+d8DC1
	kON79Gp69aMgdiVwISgSYYmSnw01g75Dpwum2ip34bj7AqVJZJtq1qOdkPvhF4FYg71iDfZKrwD
	/IlK4REOPhqrbpD+GfXSPsShVIVpqwC7jDiMrsgGVbPozOacUULNGRyMjxl8i2dqnd8UIjd3moZ
	wOjhsCMJZdhco+3mpLnqdnE3DX309OuP3gVLMQEK/OjjG5MbefSDNyTl
X-Received: by 2002:a05:6102:6f08:b0:7d2:cdd6:6c8 with SMTP id ada2fe7eead31-7d64d7ed89cmr455276137.21.1794575026978;
        Fri, 13 Nov 2026 05:03:46 -0800 (PST)
Received: from smtpclient.apple ([204.48.95.220])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c7794a699sm1276507241.1.2026.11.13.05.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 05:03:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH/RFC 1/5] replay: support replaying 2-parent merges
From: Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <0107772D-4F64-4F24-9E68-C6709AF264EA@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Patrick Steinhardt <ps@pks.im>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 phillip.wood123@gmail.com
Date: Fri, 13 Nov 2026 08:03:35 -0500
Message-Id: <DF02C354-A49F-4FC2-9A52-FBFBB46C143A@gmail.com>
References: <0107772D-4F64-4F24-9E68-C6709AF264EA@gmail.com>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (22C152)



> Le 5 nov. 2026 =C3=A0 07:38, Philippe Blain <levraiphilippeblain@gmail.com=
> a =C3=A9crit :
> =EF=BB=BFHi Dscho,
>=20
>> Le 4 nov. 2026 =C3=A0 21:19, Johannes Schindelin via GitGitGadget <gitgit=
gadget@gmail.com> a =C3=A9crit :
>> =EF=BB=BFFrom: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
>> @@ -407,17 +550,63 @@ int replay_revisions(struct rev_info *revs,
>>   merge_opt.show_rename_progress =3D 0;
>>   last_commit =3D onto;
>>   replayed_commits =3D kh_init_oid_map();
>> +
>> +    /*
>> +     * Seed the rewritten-commit map with each negative-side ("BOTTOM")
>> +     * cmdline entry pointing at `onto`. This matters for merge replay:
>> +     * a 2-parent merge whose first parent is the boundary (e.g. the
>> +     * commit being reworded) must replay onto the rewritten boundary,
>> +     * yet pick_merge_commit uses a self fallback so the second parent
>> +     * (a side branch outside the rewrite range) is preserved as-is.
>> +     * Pre-seeding the boundary disambiguates the two: in the map ->
>> +     * rewritten, missing -> kept as-is.
>> +     *
>> +     * Only do this for the pick path; revert mode chains reverts
>> +     * through last_commit and a pre-seeded boundary would short-circuit=

>> +     * that chain.
>> +     */
>> +    if (mode =3D=3D REPLAY_MODE_PICK) {
>> +        for (size_t i =3D 0; i < revs->cmdline.nr; i++) {
>> +            struct rev_cmdline_entry *e =3D &revs->cmdline.rev[i];
>> +            struct commit *boundary;
>> +            khint_t pos;
>> +            int hr;
>> +
>> +            if (!(e->flags & BOTTOM))
>> +                continue;
>> +            boundary =3D lookup_commit_reference_gently(revs->repo,
>> +                                  &e->item->oid, 1);
>> +            if (!boundary)
>> +                continue;
>> +            pos =3D kh_put_oid_map(replayed_commits,
>> +                         boundary->object.oid, &hr);
>> +            if (hr !=3D 0)
>> +                kh_value(replayed_commits, pos) =3D onto;
>> +        }
>> +    }
>> +
>=20
> I understand the intent here, we seed the replayed commit map with onto fo=
r the negative revisions, so that a merge with its first parent at the bound=
ary gets its first parent rewritten to onto, but keeps its second parent.  B=
ut I think a further tweak is necessary.
>=20
> I tried the following:
> - amend the first parent of a merge M (manually, in detached HEAD), changi=
ng only the commit message
> - try to replay the merge. Since none of the trees have changed, and the m=
erge-base hasn=E2=80=99t changed, I expect replay to succeed and keep manual=
ly resolutions from M. I ran this:
>=20
> git replay --onto HEAD M^!
>=20
> and because with this syntax M^2 is a negative revision, it gets mapped to=
 onto, whereas from what I understand it should _not_ be mapped and should b=
e left untouched by replay: the new merge should have M^2 as second parent.

After reading Elijah=E2=80=99s tip commit message on his replay-upstream bra=
nch, which does the same pre-seeding as is done in yours, I understand that I=
 can achieve what I want via=20

git replay --onto HEAD ^M^1 M --ancestry-path

which covers this use case, and also covers rewriting only the second parent=
 too. I think it might be useful to mention the fact that negative revisions=
 are mapped to onto in the documentation of 'git replay' ? At least, I think=
 it might not be obvious to some users that to replay a merge with only one o=
f its parent changed, you can=E2=80=99t use M^! and must use --ancestry-path=
.=20

> Since the second parent gets mapped to onto, the merge-base of the replaye=
d merge is changed, so the fast past is skipped,  the new merge conflicts an=
d the replay fails.
>=20
> Also, I think this pre-seeding should be mentionned in the commit message.=


Reading Elijah=E2=80=99s branch, this pre-seeding logic might even deserves i=
ts own commit ? I like how Elijah explains how we extend the ruleset on how t=
o choose a replayed commit=E2=80=99s parent(s).=20

Cheers,

Philippe.
