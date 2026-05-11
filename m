Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05944C9549
	for <git@vger.kernel.org>; Mon, 11 May 2026 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527024; cv=pass; b=NaQxkB8Q5OExSlAEcnexo2DCqsjqerCcIO0o9OiSsV5CiahypExBRtvt2zVJaSjKEruAc3IeW99KxS30H6J1w0pjrR4lvBl+hKgiLx0eBDV+qu0XGpP40wSRWE26UWBLIqv6Ax8KZb3cOXAOh9QeBgUJUxUH8w9qAxj08kimRaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527024; c=relaxed/simple;
	bh=Piun9no5L8xE6eCvS5BpjQVeRLV+o6MRWKZKuoK2gMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uf33lAqXXKf0WA4kgG8oWsDzDmNMwudIwFzGoHZwKk3YVneJ1K7kk86iKNn+J5wyEtskWiULdXJuaZINc8Qd0WqI5PgKNRNKK7fAQw1ajTmyAftrSLG1LvZENsnUkOGzbnLriEQvSr5792gcXu8ty9qptXkayZeSa+q654oPLM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOH7WAGN; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOH7WAGN"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3667cf0136fso2921100a91.2
        for <git@vger.kernel.org>; Mon, 11 May 2026 12:16:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778527019; cv=none;
        d=google.com; s=arc-20240605;
        b=LbxCAv/oZi/cnKo/zoky/wUfp1Yso3uB6FTTBGMlnlu5uu8f1vaUUVonaDodi36Rbe
         C6snadRzIt6l9uoMwMS7jjM7MJzSm0pZIn2cMzv9MYrlxboYO2uKrbZhavhniGZm3VWl
         7t4fUyrjIIt2xeB7FwbLi/QoqU7MWViFTV4EtE5Iy4mbW4yAwYFlqFR1b8kvnNn36Sdo
         UifbVGF0gMHwWlWOT/HwTxxhCH68VPVCmQJ3kqI5IzEsN7r4kKnys7nBRdOgCbXh+hnJ
         uXeM+9jbYRXgKyCrbUkvpbNXubaRt25DAwuzpB0nfETjQdPnBnKowxXWyAH4RSKV7PVi
         zQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=muCzEa+4+YgbglOxQwjWUyXvK8wP+I1+0/iKClY//Sk=;
        fh=gvJab6Y8Uhg77FLQ+6LN+VJACUdKuL0N8IFRf6wg6Kg=;
        b=DKDp/1dODwcHbiCpX+YOMEAG2pnC2RNOp/yg5BBeGIdvUSXcGlVi9KU/7KYYu31cxV
         qRZ+aVBDYa7zU+DjBm9sMtGCpeNqrvhtxG1TMhqudPI19KLTG5VouXR54D9TSR/wKMfV
         3oLegak8DlA0B+ESZXmn0+CsMeMWGuDlnyGzj5IaBN3l+GbF3CS2IjMwSB3fJCytIbtl
         VT2DGE1gA9+r2ZgkZ40WlDUisjVjSLWYKKYMwbHk4+aFQxaGEVL95Qpf0nYyKBZvPbTh
         BD4qsHdcBBmefwUidX9JeBfn3dBkysnqrKlZjz8ulZBokkWukTVBgjgvqqPup3XTu5IC
         Rszg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778527019; x=1779131819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muCzEa+4+YgbglOxQwjWUyXvK8wP+I1+0/iKClY//Sk=;
        b=aOH7WAGNX3WObkxebeRl3RKpXhBZ7GO1qwDXY/iNTbuEz9nIPHET7Cq6E5YS4mfzSN
         1PgcEgOePZdDq8s0Jv9PYEj1eb1D54GeAsKmB2S7AUij2QsdBb4chIQn2cge10rggIfQ
         eSCwmbF/B5lqIlS3kNOSenjR5LA9IW86sVH4xoh6Pbwxcoko8ix2os0rQ99RBhLVJhDF
         ghmYCE72G0Ydd1dq32r/jq+U2YXqEKfJmtiVJwv24a+2stFuLPImaY4sTKJ1JTy7HBIA
         RGE+SBdSr00a6xdzTGGf44ahqhACkGmd9YeRzwVpNwLHpvhhAOFivx3ObIWJACcOXrRO
         saAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778527019; x=1779131819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=muCzEa+4+YgbglOxQwjWUyXvK8wP+I1+0/iKClY//Sk=;
        b=hcwch2ZtejOnLrB81TQriZJI07DAhxNPIRFChwniE2Cc9rvyf55OL55OiSqQjFXus8
         FAmmCKMIj+gpWKgy6O5NhcO3dmfg2TPjtUCHJ9jxH9cf0ACItJ++uxjWI6hh+4nzIUUg
         orfIR1L0zwIey81hqES2qAg2ur7IeCDwMKszj4UHXlUMt68q3+iCiQXnOMhmobbDQQUO
         U1/uOyQf7LbHhmGt9k2Y32yAxaOxlHfkRSgFYXKSCAYPJmxyypqX/JMOzogY1gf6A4JK
         5EigO+tTJE1PPCf2fJyjjkz7wVqnbKITIxN7C8syRxwpw+x5n7fcQBgpzQyHZbUF7hUP
         srdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9a9cx5M16mLgmZIJwZwiV/okxCyDKeQX6rSEIuMlqJcQ0WmhfzAX3MYERu5GxIVXJdJEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC4qRipC+ry7OlIoNRPyP1gqqKlZgycZNNQM8HlxdATeCRTtf1
	ZcXTLhrkk488KRUkYe6y/nxD4ITeh5EPk9dnHU11ua3Y2bNvlQrprMG2/EJq4fFayRCs4dfcvaJ
	uqZ8j0GsExm5WQinfv8MrKBrl0LJO2srovg==
X-Gm-Gg: Acq92OE2Fm66eR6j01tOnJxejOQNZtc/zQbx0cbsaum/DVG9M9RG7KSxoKtaTJrdEIR
	fOljCND+BcHq6m+4LHAYFX0Gqg6b9s0hP882UG1p6yskFq99GQpWTMtgbQs64Y8pVNMukGnFJJP
	NcxdDowrCFAo94oUISCDrLbe33Ba4mhHK/421zYJIYRPonrG7lejy9wKuMkYGqWfA2GurSQ0BIv
	uDwFEjIRaQBw89XTgRjboRAesW3bDjW2oKf5s4ufs7j8ur/5YEZlDxRRHWuQuaW01x50Mlp9kN/
	owGnoczX2hHqIGDkAnBFmxpNIKIdno4jsJWLVqu1Jc1aiYwdwjw9/E83NJyjYwxfJaX+Xqp4/Ow
	GI+mG
X-Received: by 2002:a17:90b:2e86:b0:35f:b987:4dac with SMTP id
 98e67ed59e1d1-365abadce37mr28106744a91.12.1778527019144; Mon, 11 May 2026
 12:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506235459.529862-1-javierbassi@gmail.com>
 <e640ac2d-9e46-4f1e-9aef-deac80c65361@gmail.com> <CALnO6CCsOMyLxAhGW10L4duaahUORwedfmtdpY3zDGpQcZoP2Q@mail.gmail.com>
 <xmqqqznix0ko.fsf@gitster.g>
In-Reply-To: <xmqqqznix0ko.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 11 May 2026 15:16:48 -0400
X-Gm-Features: AVHnY4KUsLLtT-wAZ6WG6VqVCd1N_kwwdOEgqWW0LxmqwUZyK_T_0V2jRWnjHA0
Message-ID: <CALnO6CCR9bQ71LR_buEAzX4UcR4sERnaVLc6_19sJUfXyi-HPA@mail.gmail.com>
Subject: Re: [PATCH] add -p: introduce 'w' command to view hunk with --word-diff
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Javier Bassi <javierbassi@gmail.com>, 
	git@vger.kernel.org, Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>, 
	Rene Scharfe <l.s.r@web.de>, Elijah Newren <newren@gmail.com>, Ruben Justo <rjusto@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 8:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > I concur, though I wonder what other diff options would be useful. I
> > can imagine a world where "add --patch" allows to reshow the patch
> > with any set of custom options. Spitballing=E2=80=A6
> >
> >      :show <opts>
> >
> > =E2=80=A6could work, since we have room to allow long-form commands sti=
ll.
> > This could be extended to arbitrary git-* commands, and ":!cmd" could
> > be used for shelling out.
> > (Can you tell I use Vim?)
> >
> > Anyway, what I like about this is we don't have to worry about running
> > out of (or thinking up new mnemonics for) single letters for different
> > combinations of diff options, so it's a bit more extensible.
>
>
> If you mean "don't waste a new letter, like 'w', every time you come
> up with a use case to show the patch hunk differently",

Precisely

> I had the
> same reaction to suggest reusing 'p' but allow options after it,
> just like the output from "git diff" can be modified by giving it an
> option "--word-diff".  But how would it work for single-key folks (I
> am not one of them so I have less sympathy than I should in this
> case, but still...).

Ah, I hadn't remembered we already had p/P. Perhaps
- in non-single-key mode, p/P can take options.
and/or
- ":" is an exception to single-key mode and always allows more text
to compose a longer-form "command". The first command could be "print"
which takes options of this kind.

Since ":" would be new, exempting it from single-key mode shouldn't be
too jarring I guess.

--=20
D. Ben Knoble
