Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5A374E5C
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702505; cv=pass; b=TF8TflD3pRbYIAkzRz9mBT2BLTCina5iWLmnbtOs3OFJiH5V1hU8Db4HY5HMh5pRKnRq9LXYR6H8v7EQEnYud1pQfkiphaBu0zAkYETdC002pGjN86UF5C1d9B/aoaX+ODwjqbzpDdOr+MC1b1BM42bpfFJ0zX9Yawh+9DsdGxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702505; c=relaxed/simple;
	bh=ITSLVsTkZ3fAwIaYkkuHKkLEvsKERg5EW93pIjqTygI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auepJtYgZ/jhANkYZwVNN9XrBi1XJQHX5lB1mJd4W6a6bPGr/j6oGpElx/u1FAh+71SZ1L/nnzQJ8qDfOo3qPyvqlBGyh/awTVC0EUy8Y9GoRvLnqYI5MhElfaFw3Zn01V2U9FGlMIoCvgvGrsq2UYQ81M/GxIxWM4i2noSm4mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdqtliwX; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdqtliwX"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7982c3b7da9so43972057b3.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 16:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773702504; cv=none;
        d=google.com; s=arc-20240605;
        b=VFzH0F7040ckGtpLTgxKEUDkqgZUODsJgMpFiGQTPGMs47VPhjW16bcuJX+yVwzUE4
         B9+UhDwwDeBSJuclNULThdXjW40gPB0NVxrokngih6Gh5EstrgLdB4SU57u0baocu+xg
         EFgNY4muco//hsYy3qEkiCheMkxTj16f52W78jWUcg+kuwrg3BZLoYMoVp0WxTPym5/8
         Hv7WPoCR45xhB6WTgTnFR76e2DUgjiVQ1pmfAN/RNNMJengEIY52rIQHwEayGIxpoy6n
         TupJCW9PSJppGpRdy90xcH10f5ENnZ3D6c1B2ZtzeehHK0At3mu95N65D5bT7NxDqRwV
         IbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UREZqX0Q90KPqApvdDeGpazmGOeuAfWcP20yrTsyQIY=;
        fh=j5Auco4cfrX3TYZA30zsL7eZhR2DKXLQGyE88JnbsoQ=;
        b=aA3NR4dQI0Alqskff/YM6MEDHXOS96xZRBhR66m429VLPmJwy8tASSGx25kJBiBqOn
         81KGJsFEMGROyERPG+44xwA0CHhDhdEGtnnYAjuvH8uU2DbBcUxVKIoqLEoyidB5Evha
         4FrCn5yKZpJOPrZUewbh0Lffmwtz7OYK42uBMd8XDZHXCjr5Zg6a1oWR3DSRDcPP+PZC
         sXDMXUrsM7pIrS07Syou60LW+KBKnM3ht2Jnivcm8ylPrZjI9TGT2CsdLhCtKdzQA4bd
         DgVFNNxi930jPEbl8lfhdIYshQTPnXYtQe157VlT9fBbXbz/CgUgHiKmFTGZbEdDm3dq
         qfzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773702504; x=1774307304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UREZqX0Q90KPqApvdDeGpazmGOeuAfWcP20yrTsyQIY=;
        b=fdqtliwXOsw01Hdk2751IRgAz/iqvKCI3X1Ulv8t6i82Rfp3JGpcYwVqf5pUJ/xKU+
         CfBgjAecS1QK+xaVs4vIpMvclKhhwU/1sRklYmAItStxr6Ei5rRTr7dlOr6eUei093sz
         471pT8vhkpIHNq+A870E+fhboc3fs18L9jy8tCts09GfBj0bPvlSnueHRXhCpNNOmPUL
         UDnPjdUcnJcdWprscQaFgUQtrihLmnEQgDCeGzDb4UXw9SffMGdw4+/+/OQPgT1nVF9I
         O17R8lQukQE5rLL1Lt5OhCGTVff2/Iv6qdVyhJzGOB7VThML2dZnB/55Y6i3JDdR/9cl
         gFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773702504; x=1774307304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UREZqX0Q90KPqApvdDeGpazmGOeuAfWcP20yrTsyQIY=;
        b=JL5EtuZJvsgsSqZwZ9tlbDtHpISlzT9I7ylw7CNfp7NCfz0O1d5d5jQrvo0NeYDDz2
         CbQihDgEpRCU93raiy7cPM/bdMzFtjpk2yVvPIlr3agoF4g3Xa4M9DCCpCq5EUt13u+N
         OiEFhl7XkexRfiSzmJLC+WS3sNXUfB0cZEb5GIcjjglKg/gGi8W71czuT3rr8LtIBkDV
         00NLpVyERSZbToJ2KTFIPWdPYkSe8E7QiCzaZYERIs342HY8RMvia3gkgU1+DojOpfZ1
         8rJij8VNxr4I/JdiniEe295MMStVw8Q9BBJeTDN/QFhxkGJMsKSBd8lVc2/ybyxEd7o4
         7kgg==
X-Gm-Message-State: AOJu0YxnBsJkNQg36r2al73BTScRi7AZ1ouIAA24yPlzsYhkdVKozDd/
	M73RkzA3GonI1bbNZUvDriui6Gpl0dYfSYixsWYsrxCagiWByWGC9IYRWbOCTXu+ttgHL+lpPbU
	TdUBNstJW+wn1VygL6OKBG4ACTehhBYc=
X-Gm-Gg: ATEYQzwg856lw6GF7aRp7HaaW43V76Ma6IoFobN2CJh7JAkTtp6gmQoxMlEiST9dpe3
	tcCShRCmvWt9sZHFD9XDLuepdWB20LJnqIuAx8rOWRZbbEoienL2DtgWvk1jAuJ4Qu9IZSaucBP
	KcuaIwLiDPk/bYPSeag/jTZclnOU1WNZQdVRGV8/fN5gZ+yC1rop27RrdZaWoH3NMzKYWyqCDo5
	JrxPKhkSbsvQASzaTsNqOtYAeCuQ3dbeusV03pGhQFamjdBzerFc3a7FfJ6rVrXVWCmAfnjz+w3
	thKpdQ==
X-Received: by 2002:a05:690c:6d84:b0:79a:4dd6:140d with SMTP id
 00721157ae682-79a4dd62163mr55676447b3.15.1773702503631; Mon, 16 Mar 2026
 16:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313193537.62827-1-eric.peijian@gmail.com>
 <20260316045102.70551-1-eric.peijian@gmail.com> <20260316045102.70551-2-eric.peijian@gmail.com>
 <xmqqv7evpwrr.fsf@gitster.g>
In-Reply-To: <xmqqv7evpwrr.fsf@gitster.g>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Mon, 16 Mar 2026 19:08:12 -0400
X-Gm-Features: AaiRm52dAY-392cll9MABDXiRT7XZkPoybqn9sDrFwM9to0Nry45F_dK6lkO-4E
Message-ID: <CAN2LT1AeEYbCFvhUSnWPvCUtahVQP_cG8edVhURHg2N3OgMuwQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] refs: add 'preparing' phase to the
 reference-transaction hook
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, ericju711@gmail.com, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 12:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Eric Ju <eric.peijian@gmail.com> writes:
>
> > +     /* Preparing checks before locking references */
> > +     ret =3D run_transaction_hook(transaction, "preparing");
> > +     if (ret) {
> > +             ref_transaction_abort(transaction, err);
> > +             die(_("ref updates aborted by the reference-transaction h=
ook at its %s state"), "preparing");
> > +     }
>
> On end-user's terminal, the above should look like
>
> fatal: ref updates aborted by the reference-transaction hook at its parpa=
ring state
>
> consuming more than 80 columns and having the varying part of the
> message at the very end.  Can we shorten this and highlight the more
> important bits?  Here is my attempt
>
>                 die(_("in '%s' phase, update aborted by the reference-tra=
nsaction hook"),
>                         "preparing");
>
> Enclosing the phase name in 'quotes' and moving it near the
> beginning are both my attempt to make it stand out more.
>
> Another thing you may want to consider is to extract the message to
> a separate constant, i.e.,
>
>         const char *abort_by_ref_transaction_hook[] =3D
>         N_("in '%s' phase, update aborted by the reference-transaction ho=
ok");
>
> and reuse at two places, perhaps?
>
>                 die(_(abort_by_ref_transaction_hook), "preparing");
>

Thank you. Fixed in V3.

- Eric
