Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F1E501293
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682502; cv=pass; b=TRBG6K79DgKA+hQ5lAL0d+QQwGXqBRl0gjSRn17eiT5tY3Sg5E8aPXNl2oD1A00THjT9+spZ9G+pQ1MuJ4zzdW1NbW2au3wjdLr9hVNJyGXm5fO2yKj1+Dcj1hRZBS8JY28Dr121b7lI9YBK3pzTNJNINdeBvC5tlL+IhNWei44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682502; c=relaxed/simple;
	bh=HofOdsvEvhfR4SGLORATKinaUPRb2YtDWAeHqTpO+KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orqNmgNOM5QliD0ygRxcTxsovXZ0U9qNFwjm5UXFP7VXzBz2ADsJeui5A22wXrtQ3xInxlI+GBOlEiPj7LAFKNl5/qpCjXmkDkK5JgSAH8WnFYor1OFugUViSNvwndafYlb7RSPS1XOtKdlAka7euEsXIHuZ3ND20a/3oaaCmm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt5mE0KU; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt5mE0KU"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f01363so23594395ad.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 04:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790682500; cv=none;
        d=google.com; s=arc-20260327;
        b=PxdCfWLREwz9zQ6JzphNxL3SRwm2A6dZivJu6Q/nAp8aXfeVTFfObzCbDO2/hxNnrB
         jg973SdHZKPc/L0kaPbHsMmuCimxf1zx1d/g9fXrb589oKmKam4MdnZQn3TGcFlVggAA
         fs8fynRhJnlBpC3RT9/7ZQ0Hk+mwjz6ZwKQhXtcyL6YrbrdEOEADti9HaxMepAFBSv2v
         4Bg0B436YlarC8gfl+fp+SxSPqwNNDVUMfvpy8dQ0hHbNf8M1/fYRCQRER+9AEH1Mdub
         xJJQi/tMqw3NHcDOYlNikVQEcxAW9QI9y09UEW5bjADUqKdCZ3+D/Ue+6a9EYgx/Kjg+
         VhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JRZH3wpSw137oKuhyPsGTaMzW3pc1c3bKkJAhsQeVBc=;
        fh=RSj3hG9dGVMqrRdGTcNXHMDg/DJuaXpFWRZOmnoml/s=;
        b=LfAJ1wwDSrJoRvgo5aP42pRlo0Bu0LNflxzA0X0WHrSGQZDAaAgNZ1iS3dGMUX5Bgz
         zouBO6hIC126WrdKE8iDLCTGU7+8YKtUgN80CVzapvS5vxa501QwfiTCOnH07Rd/qS57
         DinWinuLsq/+TAucTr4rAmCbRvD6QbjyrSq8Wpfa4thxbefBNy7JBxPFeTOXDUL1Hpka
         mcHYwQ+J2EEe4LV/CkMwELQ2iR/HMJJavfAXKGXS/ecj+vrFYSBs2MAJAEE6togxoDtn
         XzcO6ObBtEwsT75/KjMW4KLuCSOLyY1VmswgvuGm2DWCj9Hjemp9rq/gOn2OllvM7VBP
         IZZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790682500; x=1791287300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JRZH3wpSw137oKuhyPsGTaMzW3pc1c3bKkJAhsQeVBc=;
        b=Gt5mE0KUYcl1jdiE9E+jkNxZ2AxEN1rcYib1PY+JqaySc8fHjyAtSITR5HXHFqbFdF
         TBiHQyC9pK0VSnximRvKgCv0wzS9/6e2zaQKh7aXrthEj7Fp6IkRpnChQ+dyBwkxHeut
         w7u+CvFtxwNwezFxAQhZ4si43oyuBYAVrEQCx7jytfr2RXVTIPqJwWgoB8MaGT8ZIfDo
         eeL1VfBLXNkqht3CFfFIUfSLqkII+U4VXJ8zvNj3BNvfl/MNM7Qs6LFLMwey/GNFEWax
         GgOUMrh3RaoPGWk8FSbcDcFwXgfu1sYotR98zP4FZ3B99L1KS2VMLym4vBV2U0nJz6+J
         ORcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790682500; x=1791287300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JRZH3wpSw137oKuhyPsGTaMzW3pc1c3bKkJAhsQeVBc=;
        b=yqLP/amtKIhRNudJUTYoa/29HSQ53yuqDu6kYazMIYfwUinmgWLqpE1Zw11c98yQzn
         F+UaXiHnLs0tf710XlCicXfUVVCyqP2M5DVSX6iaQ/aLkEodc0tD9/xvAUA3tZz/dc73
         5FRPaAXRUsBy0DslLXJJY7Lx//t+Uoqcm5tBjCO6F4X6srOaUvJJAlJivT0J39B0SM4o
         HGJFrMak3UZ3KQDaVgTcR389Nl0qdJZqneCzxh6y09bDRP+gY6e5LdusllxRup5Q7oVj
         sKyc6J9UjLWYOCeqEjjDWyCoEGJZCaNqnva4RCxohU2jojgya1DudUYfS8nIbWqzcw0p
         e9RQ==
X-Gm-Message-State: AFuF++mEg9w2gWQwzQUI2tEaz5h+4PsG9quoyS+PnTCSGK2yMA5Hjkmd
	/ygUGLj9kRmQ2+rGFCIG9xEuxyf/nf5ZFmhShMnmXXQoI/xHl6W3YcrrCflsZF5K+/82MyI/FWW
	o26NTtL47nW+24A5bdNcded4tTLG3Fqk=
X-Gm-Gg: AYBFou0gzlbiiQrz1m+xPAX1kCKxLsQzyNyttr9E7QnIyvI5Q2JJPZuKg3yw2++1J0z
	GJ3b9p0vOLWKEyS2hss5rrQMESUMjvlSOSxME40bhH4RhpAwtK/ulVJJ/RY3A70CLVAhUKhpLuM
	g060VuPh60cgcNRhp+Q2MEHUuCpB7wgqL7Mm6NbVDeBYf7GJqQJxZ+n/VVs5RoMEGEbyMxEk/6Z
	UHjczTNk3arH841hTMdvmGgJBktvMhFKAA3M7pHzac8a+gNVRRIGl3wtcLV2JTXWl06SUdDWa4W
	fiFMNd1N/jCMjvGROqYeVF5TX1F5bq+7u5LfGhPcIrzSr8E9iCInFK3ytgrqpYqiVoM/Qyva025
	arTqdUqpLfeMS439QaE9vsgT4l4WTxtP5VTp3bW5aXBHwFqo9xG7mPxn4eXZX+al/q1rqYC5YkQ
	==
X-Received: by 2002:a17:902:fc44:b0:2e2:c602:2072 with SMTP id
 d9443c01a7336-2e2c602252dmr16868895ad.36.1790682500073; Tue, 29 Sep 2026
 04:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2243.git.1790606282769.gitgitgadget@gmail.com> <89E3CD2E-8366-4C5A-B3A4-8F44AC5F89DF@gmail.com>
In-Reply-To: <89E3CD2E-8366-4C5A-B3A4-8F44AC5F89DF@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 29 Sep 2026 07:48:08 -0400
X-Gm-Features: AclHuK-W6WFzdqw8aOHvElMpDV9DZ3vHLl3GJAtA1AbZpgjqLCrsn_X3_LvWh8E
Message-ID: <CALnO6CDMTHw9EqvvD5_s7WhFVhukr936ddhuJwdOhdJGdwmrRA@mail.gmail.com>
Subject: Re: [PATCH] t5520: don't expire reflogs where it matters
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Thomas Bachem <mail@thomasbachem.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 4:45=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> w=
rote:
>
>
> > Le 28 sept. 2026 =C3=A0 10:38, Thomas Bachem via GitGitGadget <gitgitga=
dget@gmail.com> a =C3=A9crit :
> >
> > =EF=BB=BFFrom: Thomas Bachem <mail@thomasbachem.com>
> >
> > The "--rebase -f with rebased upstream" test computes its fork point
> > from the reflog of refs/remotes/me/copy, and the entry it needs is
> > the one that the fetch of the test before it wrote. Like every reflog
> > entry the suite writes after test_tick, it is dated 2005, so the
> > first "git reflog expire --all" after that fetch removes it. Pull
> > then finds no fork point and rebases onto the merge head with the
> > merge head as the upstream, and the rewound commits come back as a
> > conflict.
> >
> > Since 452b12c2e0 (builtin/maintenance: use "geometric" strategy by
> > default, 2026-02-24) auto maintenance runs that expiry once the reflog
> > of HEAD holds a hundred entries it would remove, the default of
> > maintenance.reflog-expire.auto. Which run crosses the threshold
> > depends on the entries and maintenance runs before it, so the script
> > passed by chance: a stash topic that no longer runs "git reset" from
> > "stash apply --index" and a rebase topic that runs auto maintenance
> > at the end of "git rebase" together move the expiry between the two
> > tests.
> >
> > Pin the expiry as ea7d894f44 (t34xx: don't expire reflogs where it
> > matters, 2026-02-24) did for the rebase tests. That covers a "git gc"
> > as well, which expires reflogs on its own, where turning off the auto
> > trigger of the reflog-expire task alone would not.
> >
> > Reported-by: Junio C Hamano <gitster@pobox.com>
> > Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
> > Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > Assisted-by: Claude Fable 5.1
> > Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
> > ---
> >    t5520: don't expire reflogs where it matters
> >
> >    The t5520 failure Junio saw in 'seen' with Ben Knoble's stash series=
,
> >    bisected by Ben to tb/rerere-lock-grace and taken apart in the threa=
d:
> >    https://lore.kernel.org/git/a59c4225-f093-4001-b77a-2083dfecce6e@gma=
il.com/
>
> Junio, if it=E2=80=99s simpler for you this way: I=E2=80=99ll just pick t=
his patch into my series rather than wait for it to appear in seen and recr=
eate my topic on master + it.

I've confirmed this changes fixes the test interaction between our two topi=
cs.
