Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D1331205
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578422; cv=none; b=b7mN2hqCaP3c4NZ0DLXtAiTluCFDkARXrdoFAkAtVF4nPmlVGRp3sZXkXO1xfACL3pzC4lDyhXRw8eXvOYBncmUzd40WJUkD1aRERQDXc1lB4oc9y+XW42BiVCG/ac6ncwLP9GcefLqzZiEIXYYPpJZ66k59oey7qL3kdV02V1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578422; c=relaxed/simple;
	bh=c3O+5cqAibEko1nEaZwjOyGT+4/fWdldggBIbmBhQjM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=m/mTpVbR/dY90LvoHXuPxyan+vguj34T5dU+FS+vFFMKeZL1z8P93oJSSnWT3pTcK6Kr8TYX7qxxlU4HalCt+fABhmQzTO7eFBctdcyPGK3gWGmWW2ZUQMsy6UtK30Rzg4+89YmqYRrRk33kGwOg5Cek//r1hqa6YFybEA2wjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0kSsvze; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0kSsvze"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6501d32b04bso5764081d50.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578419; x=1776183219; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEMkKgFqa2rBFOwKk4npCreddCc7Z7jv/0lhcfPirLQ=;
        b=L0kSsvzeLABAALcHA0EKpyXLicnejuzOhi3k6PXq/mOdQABTEolS2w29oKJTPBdg0A
         I9s8vqv0eTNTkAL2WzNePFjw7swlz2iju/5GMKf0qu8myRb9RGNbEJ1O4r7JESVIvOSd
         tbGpm2qECInK6103BngzmlecJPsoCQmOtYockXUM3K/Hb5/+lCi93npNzkQJW1S5u1xd
         XlsYbE7MJPCXfcHuoCQdlSq7NFZT99AzQEc11S2MupaPcyuK0VikarhdxyAJcd569B2g
         hpDfn0dAyerv1bF+ZR477P59M/eTYr9Jb994UqrrF/gJES+sdec/2jDo1WueTinPHfTJ
         UN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578419; x=1776183219;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vEMkKgFqa2rBFOwKk4npCreddCc7Z7jv/0lhcfPirLQ=;
        b=PBUnFAPlEF58ayhspPRSu358HL3ydbZwHvx9mirbejNPYIXmj6cF3+WoxUvt2iiSg2
         fJZVVAxPxtRNp+WAUM78MHAl4M0upFOzFUBxVC1u2VTANO/JaY1AmD+8BL2xN2S2ohi1
         ip6yn+Ciw+RWNmnPGAfEKaAM0ob1HScwhhK6XsCqPXnmPqrFt+/BARVl0XbfQiKacYwE
         TU21Sm/QIkLag9FGHjFj++eZkO5v/YDQV2YxE8Jm1hZsYxn1Qd4LwVBN3aIk0cqZULvX
         0H5OMyGBWXRBUet1ubmkN3nZQeIVgh9kp/gQ4bC+Tsit9XAoQweQqI4M71w2Tm6XOhHe
         D3wg==
X-Forwarded-Encrypted: i=1; AJvYcCVM9kHdbzgh2SDKBSOZpF9w0FlHB5wfLrtVKrNbYVgGTKRVIJyXlCA9s+O/oEFvpj05vqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoE3vQNh6c4mKdIjMN8g0KQTjQZNMGux8LLanFD/83l6Dp+/qE
	cCwnGXIy4nsjFRHijsPOm0g9l5IbEuNA6mIr/AGY4vIqsi26C4+PaQpwPnkWjw==
X-Gm-Gg: AeBDieuzRhlH6wxp3ypBAcNhdkIWZ7T+o8B6tSpNyOX9WRD+bqjdhwuPiFEAHY3hK7R
	jNKfA8nYobY85FmMNXyMKzJpRpxbtZsmfecm3B1lNwBRd65j3NSzK7xteqajEMYMR4s3hhYe4Wo
	a8y8F1yi83hwJqVdIwyjb9y5fiDcmUg4c9l+KIqouutqISOobiEPQ05pjFKkhmzj1YEXn7WfJ8u
	kGzrtzG8MbMJyvffP4cqc8zWmnxYk4ZtdrhNZ6BOfb3koV6jqaaJnhJZSOj6f0EAO0Q52XPFIfw
	DEhhqwNcy8A1q4idp64iqIuFF++Sh/Dj7NJh2Ocjj8EqQT3+KwUussLD763hJIddVEOyiUBJ1H8
	XJ/3J1pYfMBRB8+KO503CxSrxXLsmREkxdPQ+s+pqSP9DNpX9kRZkcZYsPo/PoAgCEV3fl5BcU6
	pgAr7GQJg+2w4UPGXjbGgwsVAuzvibLT0fZFjZ5P9ucD2IZ632mfwxFVvzLOtuumr460UC/5XXZ
	4x5xMLBE55ZOTkZTiU36Gvfr0kawKspRkWrl+W9ChUe
X-Received: by 2002:a05:690e:c4f:b0:650:8945:b0a7 with SMTP id 956f58d0204a3-6508945b0c9mr72702d50.14.1775578419155;
        Tue, 07 Apr 2026 09:13:39 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:4d36:eac:7121:d122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a824d46sm7970890d50.4.2026.04.07.09.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:13:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: checkout: clarify "up to date with origin/" uses local remote-tracking ref
Date: Tue, 7 Apr 2026 12:13:27 -0400
Message-Id: <5DFBE9D6-0EC8-4702-99C5-827AEF8C6265@gmail.com>
References: <xmqq4ilm7q1n.fsf@gitster.g>
Cc: Jesko Schwarzer <jesko@schwarzers.de>, git@vger.kernel.org,
 git.vger.kernel.org@schwarzers.de
In-Reply-To: <xmqq4ilm7q1n.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


>=20
> Le 7 avr. 2026 =C3=A0 11:28, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BFJesko Schwarzer <jesko@schwarzers.de> writes:
>=20
>> Would the project consider one of the following?
>>     1. *Clearer messaging*, e.g. indicating that the comparison is
>> against the last-known origin/<branch> (or similar wording that does not
>> imply a live remote check).
>=20
> Surely.  Patches to start discussions are very much welcome.
>=20
>>     2. *Optional context* when available (e.g. from reflog or last
>> fetch time), so users know how stale the origin/* ref might be =E2=80=94 i=
f that
>> is technically and policy-wise acceptable.
>=20
> I am imagining that #1 above would add something that conveys
> "relative to the last known state", and this will extend/replace the
> phrase you would choose for "the last known state" with "as of N
> days ago" or something when necessary pieces of information is
> available, right?  That sounds entirely feasible.

I seem to recall a recent (last ~6 months) thread about =E2=80=9Clast fetch t=
ime=E2=80=9D and there being some question of how to record it. Alas I haven=
=E2=80=99t searched the archives to find it.=20=
