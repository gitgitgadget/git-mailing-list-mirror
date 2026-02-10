Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5E13D539
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 00:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770684343; cv=none; b=C2VP41VI98Y3jX8r2nKo+QRQoiJf8UHgrxg3rhtPNS15ndjGNYuQZaQ1k/y5MM33SZG/gcs5sRWX9Zz4b8KHtHIJaSqkN8VHIoIgcD1bxsuCF5jHFIY7th1qvIaxg0vaYeGoESc+GDQ7t0FpCfgzAksDdHpNid30A8uvuCTL928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770684343; c=relaxed/simple;
	bh=x1if7HQrTvp5RcbUVvlnDYBXDE5ckJ2y4hXzEPP98aQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Q/vah/rL54VTHuIDGD5Ae4AVBh6NemGrmlxufxOuZG9vw8QDpcN3Kb+59Y2jXTFdS2qDoDDx8sJrx3qJD0TVU3kMFfE+NFCy/9Py02e7I2f5Qp0j96AoiSMdXqiJVASc58833hywJJ7Yi8BDoyH2SU8Vr7gGc0VUhBZ8A2xZ9eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ibe0dC7Q; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ibe0dC7Q"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7964fb9ae3dso14221697b3.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 16:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770684341; x=1771289141; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4WXIVCUTMSCMyMdMc28zL+ErVZwYJNY3gZelKuops0=;
        b=Ibe0dC7QIQW1zhK8w1G1MrCTwN5+JEclMb4xojV5amlJzEF62tGGlQ0xwkpb5I8+aJ
         NN+4y6S3rx/oe+eSSsMvY3rTspGiJSb6j7NeT+mFfZRjRhaVHDwCPox4CLLCOHqlKdqP
         hXlMAnDyH+QxgXUsVQDGEmXjdWbgMDJFm8o+IJAtjuxoG2K0cxf7LFtIewxPRaSlaMLr
         W+Veq4tECTF6rBPB2pmH8cLuY/uzPdGlFCXXtGhbnHAOH+yQkPEdipneWZA3axOTWZ2v
         xP+Rg12+Lw0urUqcuSzKZ8xbLruJdiDQV0DLlg74tk21Ompl2wW6+EMFNfjlxQRuG1zZ
         cT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770684341; x=1771289141;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R4WXIVCUTMSCMyMdMc28zL+ErVZwYJNY3gZelKuops0=;
        b=Sj4I0Zi2a+m6GM7aZ/uD7xOldu7qXpB+naGxfHv5IB0EoYqJ0LyYJAcEETAgNbX73r
         XfNgnoXEGu7YWymVSBZFy3LodZSFVy3GswvdYMj1eRkGDdU2fQUWl9OavknNbuKHQJQ2
         Mg84ANj09Y7AowKSLzheXVyERaoWuDdsl23Davge0OYFUrZN7GI2bW/lIabxf3AAvoBN
         g9PJSg6hiZPAG0Q0jxZYoIlYLZ9AvPMTMQEGiA81UVECpRq1PE0WWg3ehWggodpr+LRx
         2aYaVKICvvxUwFt3xGRoBjELnq9yBTlu0TvzNXoDK7ymJK/smvx23DRyShGK1Mymptbc
         ubwA==
X-Forwarded-Encrypted: i=1; AJvYcCVgVZyEY4+rgxy+KbYysWJUO6he1c0pF7HEYhJaf2gTqM7KPbZyi8Q3i4iknMS6vOY0z7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAhPwZRVLObnvFpNVGCZD2UV6Qjyvv/vvvoEH4+fy7wo5uFLf
	+2DnGxBB5LKq0Z+Buln85xEfqp5HQM22xSAfjRi+Y7jTCQeHVoYE8lWj
X-Gm-Gg: AZuq6aKtzL/3NmYSU74VfrOX99icPSrivz3CtiBPbXu2QaGq7eIkzG4+VqVAHpUQcFQ
	93T3mdvXIiJzBZglgbU0ssI9pFv1DpC8XC553WHzfbUsfxt1MRFLh6Hdy2UlmoDYkK5epqXuYrX
	hhprJeJHRiQuzZvMCuQUQodfmTUm4b6Bn2YowOOAPCuHztXcqYc4PGBrUnXYbCZtA4kPKoYZbLx
	w5++e9yBnsyQ7LzTnoC7pVQw21lVChduSBY81lzfjodyVGIxcEvpyTDPc70w+wegdpZYV3uqEsU
	RGQWLiU+TYfCWBAWDNjLhC0wLfyAFNWT+SL1ccaGbkyTLcKcdunfGtLbjaaiDm83KF5I7PsHjg2
	5TB2UhMpFdrLt1bKMRJFf0A7CxFR9gRhlRVNMcvfdgPmrRk9DCyja04UFSqyFHUzSDaWspmmBle
	eHbmBE6mzk5tr/NGodIJBN//seZgQdN2vvY0sQTSUJz9cVzirG3O8JgCFwmyIHPAiGe4nsYk0oW
	s0HlKcIWTs52lLOJVxg8GOnkdlXvBt2A7K7y1U3x9r4hg==
X-Received: by 2002:a05:690c:6c90:b0:794:77da:aa55 with SMTP id 00721157ae682-7952ab3fbabmr106801667b3.42.1770684341266;
        Mon, 09 Feb 2026 16:45:41 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90eb:5600:1cfa:97ae:441a:82ab])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79644b06cfbsm43827577b3.52.2026.02.09.16.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 16:45:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC] Support UTF-8 characters in Git alias names
Date: Mon, 9 Feb 2026 19:45:30 -0500
Message-Id: <D96BCAD5-5482-4BD5-B22E-82D34EBC1F0A@gmail.com>
References: <xmqqecmt33xk.fsf@gitster.g>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Jonatan Holmgren <jonatan@jontes.page>, git@vger.kernel.org
In-Reply-To: <xmqqecmt33xk.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


>=20
> Le 9 f=C3=A9vr. 2026 =C3=A0 18:14, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>=20
> =EF=BB=BF"brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
>>> On 2026-02-09 at 14:55:51, Junio C Hamano wrote:
>>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>>=20
>>>> I don't think we have any Unicode normalization code at all in Git,
>>>> though, so if you want a quality implementation, that may be a thing we=

>>>> need.
>>>=20
>>> Isn't NKC/NKD a macOS-only issue in practice?  Anything on the
>>> command line "git" potty and "git-blah" built-in commands receive
>>> goes through precompose_argv_prefix() to be normalized on that
>>> platform.
>>=20
>> Normalization is not a macOS-only issue.  Many accented characters can
>> be written in multiple ways,...
>=20
> Yup, but that wasn't what I brought up macOS for.  No sane person
> would write the same string in multiple ways on purpose and
> everybody would want to stick to one, so that byte-for-byte
> comparison can decide paths they created in the filesystem can be
> matched with a list of paths they added in .gitignore, for example.
> And for that everybody uses normalization form C, no?
>=20
> But the macOS makes it harder to stick to a single way when it
> involves filesystem entities; the pathname you gave to a new file
> with your creat/open(2) may be normalized in macOS specific way when
> it comes back from readdir(2).  Ahd for that glitch, we massage the
> strings we got from the command line and readdir(), which are in the
> normalization form D, into normalization form C.
>=20
> I think the suggestion here is to assume that the users are doing
> the right thing and treat alias names (which eventually end up being
> pathname components) as bytes, and everything should be happy, even
> on macOS.

In what way do alias names end up being pathname components? Or did you mean=
 to insert =C2=AB treated like =C2=BB (as in, normalized as command argument=
s)?=
