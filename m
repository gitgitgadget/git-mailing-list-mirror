Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F91E3DDB
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767338438; cv=none; b=c4KJYnICXGcLRff6iiZHSt8QSHVhysZy8QV4pdphQpoa0RRHyUEFcTy4pld4wbmzBd4GpehZQqYYvjQBH8Nr58dd4hdCSEkJ5S1L58plYOkKUtVE63lbmP5Ty5s3DVNJFYKYaNSNOBzNNEHNXFYX4ieXI3eyM23DaRfwCGbmLZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767338438; c=relaxed/simple;
	bh=aXg0w4Q2bjxSkFv4For7nVoi0f4UAOxO4zuZXerFig8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2H9vPwDgPbxJc8aLZPKq75YaA0NKT5xYw25HPZmSYv+O0HexvNUzVAcD4SuwULtu2meKdDbzo4TLFV85JTvKUtEf5vo3n5/A9mRoPbaVdmqbj3pQKt6nlJgetdPeld28dlGRVYwlHwiqvdz8wB0l6ZnUVh75hfGq6RZC21m/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMLLzlQM; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMLLzlQM"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-55b155c9ab2so2687546e0c.1
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 23:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767338435; x=1767943235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzMNcbZMgTn/BJCvE2bUMfWecdHflOZag7r5MmnPeWs=;
        b=fMLLzlQM1iley8kgxFlN2A2M2tSZ0wJaPAvP7YUnwkMe2pXtj2NKEVY9ek6Xoz+MR1
         ++ZEBXEtfKyK1Ekgn0v67MbV3pBKvTh1FWHZWQdWyR6EPsUEh7+006uJP04+Czz4VIgs
         1vAtS512O0lNdE747ruKyAuXVE7FcNWMYt21hsN/eJBavI6x7JRu/eYNecwrczscoFJz
         bTsvpRXdbXMzvYXvwwcTnOEjH+Wd8ahp/OEwWCV8guoTqmBdxKpGdUpd9cm/sNg/AvO2
         22ag/up0IjxSt+ZoZO9SPQ8TRByzTZyOKbzSMIpqZjg0YAiHDjGP4iFo4bsnYfqNqrhq
         72tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767338435; x=1767943235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pzMNcbZMgTn/BJCvE2bUMfWecdHflOZag7r5MmnPeWs=;
        b=gt5Z6eIUgEgZwXsEtGsGW2xQ+58bMGYJK7H9bMDbUBC3N4BTzSyepvQU80iGqV/NzP
         ATsmStS5ktjGoWsANQDKpy9/xhtlZxSK/FxfDZyKF+ytINUlrSjxnb78zaeV71CcNGZG
         f2kG/7R/6lUdH+DsT4efp31/2w4lssL8Gzs61lCttYkNpP1ynO+UFRqu8AaNmTg0WxB0
         ljQNfMhMMzHm9H6jHjXlyM4N8UaEywMFPBeE0m6sahPgsEkJC//VvBQ1r3rMvPZwfF15
         nAIoNp6mmJ0idckadkC9qOcQA+dH9RdbLquXuI/z1UGSppZ0zfi/PVdmfRU/C2SnFDjz
         bFsw==
X-Gm-Message-State: AOJu0YxFU43VcsVnv41HqXnEonZJM75RHYdMxT3E9XjWTsByGgulUD9J
	nBeYJ1FZe2UBW0I+tYQ/cfu9wWVYIRiY2Lju//j5SmnO5Wd5mZ9Z1cmctpmvKde/Y0BAQWE1bQ0
	naciU88tST+TGhXrRi5d8foy88nDiXTw=
X-Gm-Gg: AY/fxX5v0f6SvroKcIHFXrGhSctr37Oaar6Okjg4cUGDg1iAk9DqJYISsrhY2cgaR8n
	f+bLjzYxvGd/rJaOL+p9QUS+YzwVTLdjbwFCU5r5pNfsb7WAmwCgx9zUOjUCwG+P25Ja50oVRob
	x2hivvUT5MRK/9Dy4BmrsdF6zX8n7AiXSu91Ex/COENg2A7BifUupOEgV44Xind6/PFrCSe0svl
	OcVgbuuXMUQ0I1DcQc2Y4xHrXvx9JNchpJNiM2sCPC+Ir47kh7L2xhQ2sSpABkpYloL77Eofi8=
X-Google-Smtp-Source: AGHT+IG9VLL82Z9oEzWGae/qOLSIcH8J+ZZhGVNohbNEaiIcKj4wXsUGWsUcZx6YY7kQjSP8IOmGUftnNNhv/CKY0Ew=
X-Received: by 2002:a05:6122:3c84:b0:55b:da4:fde1 with SMTP id
 71dfb90a1353d-5615bd6aa4bmr11421475e0c.9.1767338435546; Thu, 01 Jan 2026
 23:20:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aVbgkySezz8YV6sN@Adekunles-MacBook-Air.local> <xmqqpl7tc5a9.fsf@gitster.g>
In-Reply-To: <xmqqpl7tc5a9.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Fri, 2 Jan 2026 08:20:37 +0100
X-Gm-Features: AQt7F2r9EI9LhFAGxlP_tw-n5II9ggtsRKoEC_OahRqigvz7fyg94A4YVCjUnMI
Message-ID: <CADYq+fZX4sQswQZ2dHe1MZTC0BgyEG8+OUzVDgbNhoPa=MoTiw@mail.gmail.com>
Subject: Re: [GSoC PATCH v2] add -p: show user's hunk decision when selecting hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 11:54=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > When a user is interactively deciding which hunks to use or skip for
> > staging, unstaging, stashing etc, there is no way to know the
> > decision previously chosen for a hunk when navigating through the
> > previous and next hunks using K/J respectively.
> >
> > Improve the UI to explicitly show if a user has previously decided to
> > use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
> > This will improve clarity when and aid the navigation process for the
> > user.
> >
> > Reported-by: Reported-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> > ---
> > Changes in v2:
> > --------------
> > - Modified subject to indicate GSoC participation and user's hunk decis=
ion.
> > - Modified the code to detect the user's decision for each front-end se=
t
> >   that uses the interactive patch machinery
> > - Changes the decision phrase to 'previous decision: _decision_' from
> >   'Selected/Deselected'
> > - Placed the decision phrase before the [choices] instead of after the =
[choices].
> >  add-patch.c | 84 ++++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 47 insertions(+), 37 deletions(-)
>
> Doesn't this break t3701?

Thank you for the review Junio.
Yes it does break t3701.
I will fix the broken test cases to conform to the new code and send an upd=
ated
version.

Thanks
Abraham.
