Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC3183CC3
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385839; cv=none; b=ofuwaPIwq2dvNkYCReWVAiOXhb9QIeBwvClVNbJtdwWXS8QLyLjNhZBZlLM/Ly4/rsEz95PbPvxnbR3q1NoicE4/sl/O9CthKUof+Cr941ju4gxUUbPA87HG5fDSx9TIuLPeRUgsZGN8RXhjQFM7jkGYIxI0ERiq23N8RH2VQDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385839; c=relaxed/simple;
	bh=EUBLnL4qOOPrJLn2IPG5nhmUkz/RFhD0UWqqgKvmAR8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CMu5Khf8p4tZERoDQHoYEIjXTx2UU1EF2Ct6cIIz4yE8sNXR/qdMSnOaH8hJ93FrJV9QOj57YOXABVyt6PmEmEliijFxtosWn7J6rmGp0bRHb3gZYElmN23TYnQMsZQt21kMouavYcG1ZAle327gqTK++JRWZR3NUa3zxSwZhk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnDsrmVv; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnDsrmVv"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-76bf3dafaa5so2166068b3a.0
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754385836; x=1754990636; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXv+lGXpQqbq69g3qvxwojb9WRgGeIrQwKwYgGG6w9I=;
        b=CnDsrmVvKmQNMq+CahjAq/D05ZiXhfvn4Ev1qVYsCK06agUCRvRs99E/BtXujgk29v
         fWzRDMF+YxvJDbTclCGwMErhmQORmyW7aHSqGfPcEiwbg3ZfuV8JdZ0Nw5Mv8nMTDITx
         BWcSZ8DfPKlSTrynqifhyYyBLQqV0yer4VVD+N4v00EGt5h9IN02NsDFpzbAKojEwXbk
         TwNBXajx57aOqFL3AmT7j5/9oXNgsH1xUuTrx48I3SfJtnCex4RSRCGflPj526nQM5YE
         adS1qaiGev9nLtqitDWol90O4da0Qn5iU/m/od3JrJnzg6GWlZatEEnB1W8Ptlub9gDR
         HhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754385836; x=1754990636;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXv+lGXpQqbq69g3qvxwojb9WRgGeIrQwKwYgGG6w9I=;
        b=LVO/pCw9bTUEqDWpw4ZNZGcUT8p4SE9bGBwQ188prA57eRt8b9v2a4xAIZg4d8i6Ve
         HMdidJSP448OFdZ1ZsEFdqFYAlsLxAiB2pn6WwVq5Y8+m1ye9vKH5u10CiANyiPUsr8U
         VXGYW+2ehcU57Atc7UKbacyemtmAao/Bv6A1/+2gdJf3sUvhcpiQag905CBnVKe0Ttio
         Rw+r18oMPEbvnP/wYT+wsW/MGLkVOenNB6bQdlakbjhV2RVkY9Y89ZjT1md4B075cq71
         PMGrQXss4wHVr0BU5ksAn3cGGMAam7UfFEYhvN2rUembNxzTiKx2mI+G/2P3Yl9zR0dP
         qefw==
X-Gm-Message-State: AOJu0YzvsIwMdiXHoCUhZDMihKSwQk+4x9zU16zX0p+NaCI4yfkU4nk7
	faxb24iPAyb9VBY5KN/uQN4Syty4b/Bkls2tb52xZV8etTkMQBNcnW+cTfZjwGAmN5NDFQ==
X-Gm-Gg: ASbGncvI4sl3Ch7L0Gu79ii4PsQEcMI0prjgoFcxgDDispC5Ebkmn5EIYT3PRz84F3x
	buyFFKk2Dpe1T2i0AlcU3WDyOoHoRlbgNz86aV2T18jWJ30rvNGehGFlAAC/GA/DM8CtKMFhUkI
	4kSzFprfTXwv/QKbVlbJN8tyhlSItW6ly1tO1voda2TK0PAJG2QJeK/jdDnZa72zyRkv6utmT+y
	i/fYfRQsZVSzAwxOuFDmbVV636PyAGxzgefBO332ZOgxI3Hf+Dr3eDlXvaa/5mM3v3rZ6d593gH
	Se89M+K29iIp3FxKK1LBZBPjoQ8K2BkaT2ybbjdSOTyTEiLuZrdNxlVrBkx9zjqJx29lUYWovId
	t/RO0neXqSlUZcM3Peomzw3byRrBeIvUv8/ipOKnrzBQVmMeoBgzdntv9Vw==
X-Google-Smtp-Source: AGHT+IHtpfmUQb9/cOTYe/L1T6lSq8jetUiNA+JRyNaIvEMpRnvWi0B4XGF2w0TOFeR2Y+Trp9HY0Q==
X-Received: by 2002:a05:6a20:7347:b0:225:ba92:447d with SMTP id adf61e73a8af0-2401ea18e5dmr4051083637.9.1754385836093;
        Tue, 05 Aug 2025 02:23:56 -0700 (PDT)
Received: from smtpclient.apple (n058152109003.netvigator.com. [58.152.109.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8960dsm12477957b3a.34.2025.08.05.02.23.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Aug 2025 02:23:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2] diff: ensure consistent diff behavior with -I<regex>
 across output formats
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqzfcfd7pp.fsf@gitster.g>
Date: Tue, 5 Aug 2025 17:23:38 +0800
Cc: git@vger.kernel.org,
 hi@arnes.space,
 michal@isc.org,
 peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <F21E21EC-4894-4396-A126-8F6638731762@gmail.com>
References: <xmqqcy9io73j.fsf@gitster.g>
 <20250803145155.57894-1-yldhome2d2@gmail.com> <xmqqfre7ex8x.fsf@gitster.g>
 <B1F1EBB7-1824-4776-B8B0-B557114546DB@gmail.com> <xmqqzfcfd7pp.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> But I think the refactoring of diff_flush() codepath would may
> involve some new mode (perhaps DIFF_FORMAT_DRYRUN or something) that
>=20
> (1) does not produce any output, like DIFF_FORMAT_NO_OUTPUT, so
>     that we do not need to play with /dev/null like Peff's
>     illustration.
>=20
> (2) knows that the caller is only interested in each path having
>     any change worth reporting, so that it can short-circuit once a
>     change is found for each path.
>=20
> So, just before you want to decide showing name or name-status,
> you'd do this extra diff_flush() that is run only to learn if each
> path has changes (with various "ignore" criteria) in the dry-run
> mode, and it can do as much short-cut as it needs to.

I=E2=80=99m proposing to add a .diff_optimize field to struct =
diff_options, which
would support three modes: DIFF_OPT_NONE, DIFF_OPT_DRY_RUN,
and DIFF_OPT_BUFFER. The appropriate value would be determined
before calling diff_flush(), potentially in repo_diff_setup().

DIFF_OPT_NONE will be the code Peff provide, DIFF_OPT_DRY_RUN
will optimize for --quiet, --name, --name-status, etc, so that we can =
return
early if we found any change. DIFF_OPT_BUFFER will first emit changes
and context around changes into a buffer (so there would be a map from =
file
pair to change buffer), then operations after the buffer is built will =
use the
buffer instead of calling xdl_diff().

However, I=E2=80=99m concerned that DIFF_OPT_BUFFER could lead to high =
memory
usage in Git, and I=E2=80=99m not entirely sure if this trade-off is =
justified.

Thanks,
Lidong=
