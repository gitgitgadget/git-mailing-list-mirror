Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8682B233727
	for <git@vger.kernel.org>; Fri, 16 May 2025 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747396234; cv=none; b=pyE/3Q6GA0adSzxI1+pGTVqbpM+H20NfgVHeMNfbKaXXuIFEkEdhLlS3uDemSZJtDfJ3efW3Ka5Ikj7yT8R11e+sakXluQlrCZBI5lqNhZOwemRe5zGmh+pnVx1dmCya5FiACLosimuoO/a9ni1Gph13h5Wt6KNc6l799zh6RnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747396234; c=relaxed/simple;
	bh=7gEQT7Gk+X1TsnaXfdShYKJVbbhTSPoM4QxYR1oPEgo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=dx/1DcXW+fcYBbwcevKqc22SBeMhim8GWqFre5Gpzu7RpSY7hedphUFt+nGY4s/8/zebiCbV/E+Gcnu2VbQrszz66lXf6yJHjPlKnDqcHsT92zkgctZWQELzqxUpKh3czaxFLV1n6QTPBgCsn7zDaXh/G+NXT9h8vhM6wzG2m14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckQJTTHc; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckQJTTHc"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f8b10b807fso11407876d6.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 04:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747396231; x=1748001031; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gEQT7Gk+X1TsnaXfdShYKJVbbhTSPoM4QxYR1oPEgo=;
        b=ckQJTTHcnkCKPJC0TQ3BsAvYH4WgP7wCjIgWvlLx9FSNUDmlfl7Fh1eanmXsEkUWzK
         Kar3ckZnYmthdslO+n6VX4PfGU1XqeOuVt4Urv2PxJndVevIG/zvsBTj3DDRA4UoGrb0
         BHRSdvAnSlTbjJkDQCuYVK36m3cIipQSs65ytenZBRmvj5R+MA2TwB09209nv0NkjAr7
         SlV8drPF0lf7/K1l7p2ZDahsl+kpOcD/m1jEY0iUbeYGnS0K55AL4a4uxQ7PvWJ5e5cM
         pVyUz7aJqUpaPmIiK88Xo5oCHt0VfD1GyGMbqHKOWf3SIO3biQD/NBI/IoNnPiPyI2S4
         6e8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747396231; x=1748001031;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7gEQT7Gk+X1TsnaXfdShYKJVbbhTSPoM4QxYR1oPEgo=;
        b=KFMqhSpqa2nH9zrezYyq/IgICfd8+qfjXU4G7QKfEpb0qhQBPhqYBY9u51g2T3mXwI
         7tDTz2dXkCFIyEq8Ga5Ol6Bw5o3vFKZhse/KZecYX0UIXUv2O4EKv7QrsT4XPwEOsBps
         qgnaVqxw9kneBDgGLWTQSoCQlPKqLiW+eNFfQyGonvC4z9YunJcnMgDIexPb39KYPMy8
         dSzWqsQhzi0ipgI5t7ndyECiVA+htVA75z6X4ytq07g6Qzz9f4w8Ey695+rCarC9Yofj
         UHLUxVDIQLXwq6VVkr7wTDW05rEIMuPTjLygfIImv2T4qHERpHwKw0RTLgsQaOlvKRtn
         zC8A==
X-Gm-Message-State: AOJu0YxN8K3zdqcnHS5tMkuzkHOOsmU1/sHHSzO30PoiRb/GHHhTn3vf
	6akR08KJcjAqorLwphyuefb0QMuVt7aGHf3IY+iYPXxOqmluvd79m1xJpsq/aQ==
X-Gm-Gg: ASbGncsz7dm+6EEbZ3le6HKmCzG3wwi+ySTzOSz7Ip1ULP9L9m+ArwJNtNK05FCLWuy
	Gf37EwfveaaDyMyBrEcYK7sKsIzXO8Tp3doIzV2G/IfvUV7bNTaQlEQRTH8ROHzYKLov34XQbb8
	RlcjaU4IUUTJda1Fm6mUXz3wNMEtZmINy4WekgFjAL+cz89GALCCsRJ+bGPsDVnQTfPkg98EY8k
	R91q91Qn4HWlSfb9nEG2lCV1tjJBP/H2Cys2JXEfuio+THUGTpiZmHboVvWtdG+UGRCF5+QJ3dP
	lB2lW8xiIjYM6WsuC3pPFfoXjmM6nR8yrO7Tbp+RAnVmHjqlo8r41+HP71s91i9ZzKbORCYTipt
	ZJhM=
X-Google-Smtp-Source: AGHT+IEDx+Fmh5cUM9jsoIjptjgq4Q2qAKx5Ze+l+etZnZ4drAmlK5tPHLgfDbrrhRLcGKE8bLltIg==
X-Received: by 2002:a05:620a:240e:b0:7c5:4c49:76a5 with SMTP id af79cd13be357-7cd46718986mr382966185a.12.1747396220054;
        Fri, 16 May 2025 04:50:20 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b011:c7b2:9c89:1d6f:e18:e3f4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468cc89fsm106833385a.105.2025.05.16.04.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 04:50:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] commit: Add commit.signoff configuration option
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <aCTI7VjK5QMht3ws@chrisdown.name>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 kernel-team@fb.com
Date: Fri, 16 May 2025 07:50:07 -0400
Message-Id: <167ABBF2-8DFB-4F1B-B5AA-93024FE8CA9C@gmail.com>
References: <aCTI7VjK5QMht3ws@chrisdown.name>
To: Chris Down <chris@chrisdown.name>
X-Mailer: iPhone Mail (21F90)


> Le 14 mai 2025 =C3=A0 12:46, Chris Down <chris@chrisdown.name> a =C3=A9cri=
t :
>=20
> I understand where people are coming from for sure, but I think the conver=
sation has moved on beyond many of those points, right? For example, some of=
 the objections are about format.signoff in 2006, but we merged that into th=
e tree since 2009 in commit 1d1876e9300c ("Add configuration variable for si=
gn-off to format-patch").

Just in case it wasn=E2=80=99t clear: I think the patch is reasonable ;) I o=
nly meant that Junio had provided some background material that should proba=
bly be addressed, and now you have. Thanks!=
