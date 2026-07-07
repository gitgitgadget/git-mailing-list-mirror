Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A40272E56
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410734; cv=pass; b=gMbXAJ5WozTKa80zw8BwbV0YpbKWy3vTV06viEzMlLBFza3JgJehV9RNOjj55Ajmst0RrkbyCrTtQrRqdt0J3UtrqvmZOytB5FuskkyhXRdaiar19RwJQuDQ2biwCnU45mOQ5LivTL5LS+byYqFSDM075fD2m5fU6AyEJ0YCSnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410734; c=relaxed/simple;
	bh=WJFdEa+nQkChk4xNbJQB5EvQMVu4qM1PVLxhvodUKp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBjd9rnctN1oV7zUAsPT5/1u4FuhorpsmtZUwXxEzGheA0XjHRlNp8DmlzVzehxv95e8v8PS/ZIuFpB23c/IkMljZIdXK0wAPcnevsA3RpPjQlXIMKmPOqJgW0RNiOCZiyUoR06e1I1qUucpTh9Gu16EdE0u95l1/gJeF7I7J1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq2ggPSl; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq2ggPSl"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so5482564a12.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 00:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783410732; cv=none;
        d=google.com; s=arc-20260327;
        b=G+6FtTLwTdDU0tz1PuJOXPaLw5Zeq4bVbtaqXVBnh0emtnoi7q5Oq2dttdfH/fZA0y
         c3sVSJT3pnMqxihT9HL5P3pq41N1HRX0rQiD2Dy/60NL1Z9qxm1/maqBXFkM04QszFiL
         N9QeyJEOH+25uai6Nh/klSFotIWeGQxCZr1XSigZPtvLd02sjQgvuMq3jZPqo9Ih5JZA
         tiFbECG/s5K8QG0JGufyp5R239yrq6jXmSlxfNa7K2s1St7owc6jvgAryQejVu2WtL7Z
         fgk9/DdQoiXzTF6c729uTFzjxmf+pt3g9LYfNLhI0m04DPMv+606ODqPAJEX78VOh/pG
         URJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1VfcNfJLxpk4v1WIye/xdvPAymccDrQg6xcJJW2Ujx4=;
        fh=/tJ/7z6Poha6xBcCl8jXE6hKBBzjgWUcXYb30xqhBuo=;
        b=T8lv5WyoeLuJQUWVQ7CjO99cQB2VgDFSoYMff2drQsKia4D6jeF2t10TCTGCp+tSU+
         UB/qB0bkLNBLMBKgA6Fnw7Rj/wWGs8Yoml0PV1YggOZOnG3F7Jl88Vjwj6d3n2yy0n5Z
         t4gIbiKTdygO9m7SWyWLVu0B9sPwu8jbwZs2ieqabQKqMk+J0zyA69Bn/q5AuulOq6uq
         88Ie59/K+hfYs4EJq7hUnLh66w9i1yOfS+L30TmrieSi64L3Np0zU+TYVd8ZHJBktine
         C66GzvubeGuRVvJyiSsXMD7+a6jNhu1/JDh507wt1d61kG7E4f9uaviErd8baa6T0bui
         i+Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783410732; x=1784015532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1VfcNfJLxpk4v1WIye/xdvPAymccDrQg6xcJJW2Ujx4=;
        b=dq2ggPSlwrFxz+ZgTtz6gZsPiM93QpTd8834GVSkRcK6qMpJlRzlm7gvFY/WnnK1jo
         JZBY89h4cIWBoatPThWFs5yHZhZtvSEQAZhT7sK79QHdJ16XScGvQ5JqY+ezOYNLAL0n
         raHkcdMfGqmGL3VAMHwjKe8z9BplcSt6Z0XymyUEqom3ONeROdCwcQTuqNHRp/s21782
         UP2ff43i2a51n+F1wNWF5twqyskAk0ztH0bTYNfeA92DcjC8P6pNRd/ynuWBwuLznkcZ
         T3h3GZ/aToAIS8bGtkVlAbmQde+lxt8wuC2o9pS9WdxMQ9Z8fR6zgpfxHV9aPj6uFubf
         41+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783410732; x=1784015532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VfcNfJLxpk4v1WIye/xdvPAymccDrQg6xcJJW2Ujx4=;
        b=UvsWVM1iNY4eRfZDCqNK75yoI3Gl62yY8TiadMNqTfMCtBuq8ubBqkykerHa/qusV1
         Pf1lMfviSYMh4XTqQu5ylGetq8pv6SjRBmSkRxwtOmVGqA3HLuwYUfc0tL4vAyIqdyj7
         sDeVN0wbZDA9rPmMo6+8YMxt+FP4DsW6lSquNk2FlMHgu1SRY9FfRT2ue45UnstNaNEU
         iibr7r80EsS2yS/oyu/j71+ZSW6m1pWRXW5fsKOPXWcgfIinZilexpGz0DxBw28ZruO8
         OIRZm5xP6kWahMz/WwtvyxuGeRnnDKNd5OzNnn9iID4VTUZBHkGz7qOcEMpPMElAZT8T
         hauQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZ2lAXjPX2Qya2uR9xBBFgIR3WaWPk/Qr/19KmjQz5RtwF50fI2FegnnbsGrlxY+F7Kbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeQFMf424Z7MyFwkmPWVxqCpx4d/6C3RFBJ4kA4Kdo4D44kIiR
	fjbMRuqCgysYgBtaV0vOl/M4AXrc2Dbu586eB3z+2H3RBV2gP/NzmaSZVY9Hl4q+YyDiW36XqbI
	svEljT2JND26WSKLobjbnfqjju9v15Ww=
X-Gm-Gg: AfdE7cka8vU5FRe3/K0mpVp6WhCNpI9kcN9VRW5VarM1uSiSiwk7QaApMoM/kvSPP8K
	YPeHNiiK2wp/JUM6TPdUeQLTeWaLJaH+23jKIRBn6x6XPDJ5x0KJ0I1xygndGIxGZtx9y1tb/HL
	CpNA16JsLodatXBSUFm3cDw/UidUkJ2Ajk9RDsjnwXvZIAlzk5PtSgQ2cXWz1ygkIOkmu1vUgGU
	38u++LM6DPutDOgAuGhQXGSE/O1wNKbrKT+USlLuKDzq1InuR/DpNQNhWyaDpYa/zRt/Xq4
X-Received: by 2002:a05:6402:1941:b0:699:8397:55f4 with SMTP id
 4fb4d7f45d1cf-69a85c43702mr2160005a12.35.1783410731182; Tue, 07 Jul 2026
 00:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
 <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com> <5a5dbfae-4525-4b00-9e44-936be606ee85@gmail.com>
In-Reply-To: <5a5dbfae-4525-4b00-9e44-936be606ee85@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 7 Jul 2026 09:51:33 +0200
X-Gm-Features: AVVi8CfXh7a7Tp3ISR1QkflS9R91VTnU-rk_wC0EO_TYlQuor5iRg_GvC0S_etc
Message-ID: <CAHwyqnVxa34iGmFvL4Ujrc2dTbmtF+7j7b=q5v95y=-pzUf0NA@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] history: add squash subcommand to fold a range
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, Matt Hunter <m@lfurio.us>
Content-Type: text/plain; charset="UTF-8"

> There was some discussion [1] about making that the default and renaming
> it - was that overlooked? If not it would be helpful to comment on those
> discussions to explain why you don't think it is a good idea.

Not overlooked, but I side-stepped it because the discussion died
down, and yes I don't agree that it needs to be the default. I could
have mentioned my thinking in the cover letter.

> >     now builds the same editor template git rebase -i shows
> >     for a squash (a combination of N commits banner with each folded message
> >     under its own header) and follows autosquash for markers: a fixup!
> >     message falls out (commented under a will be skipped header), while a
> >     squash! or amend! keeps its body with only the marker subject commented
> >     so its remark can be reworded in. Only the message text is affected,
> >     every commit's changes are always folded in.
>
> Rebase re-orders commits so that fixups immediately follow their target
> - do you do that here? I think that is very relevant because here we may
> be dealing with several different commits each being targeted by a set
> of fixups and presenting them mixed together will be confusing.

No, I'm not doing that now, but I can take a look at that.

> I think it should allow squashing a bunch of fixups together though. I
> thought there was a plan [3] to refuse to squash a fixup unless the
> range included its target.

I attempted this with reject_fixupish_oldest(), assuming only the
first commit needs to be checked as not being a fixup/squash/amend.

But now I realize that maybe we need to check all of the commits, and
also check if the target is in the range or not. It just makes the
logic a lot bigger.

> The range-diff does not show any input sanitization - what happens when
> the user passes "--reverse" for example? As I said in [4] we should copy
> what "git replay" does to sanity check the rev-list options, otherwise
> we've got no idea whether the parent of the first commit returned by
> get_revision() is the commit we want to use as the parent of the
> squashed commit.

Yeah, good point.


Harald
