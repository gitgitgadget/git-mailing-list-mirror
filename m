Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909329B23A
	for <git@vger.kernel.org>; Wed, 21 May 2025 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859896; cv=none; b=LpbIQVIY6rDhSJy5SS9R9hn1iatXuGW+h3l70/IRFgGJkuw6SJHevd0JpVeyXa0XWTSltUBDOcMMQwlqotr4o6l2KMbLldy4TqkCZIa/x80z5ZmeG9LNERAHpt8qljWSMzVg8f2r1FqzhC3AeaAwuovpPr94GYDb/UGWpM2iONU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859896; c=relaxed/simple;
	bh=+LxHowxVPhq7G8FdHRzUiWYhB+V1liY9fTm38Q8RXHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOsgSZ2btulId5pWoLLK06zCdw4/rObFThBvpyaxbzeyN4AOtNUbghp0xOP97NQ77Xkw/dlajy893VeqsmdW426ycqmOfXriTAYWkOb6Tur90BHGmH+RV4LURyaMxb4/9bQNKTMw+WsVCO9vnoNO2yfnfjakZBpx2MjZRoaqVms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7/IWuiq; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7/IWuiq"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-551ed563740so5635102e87.2
        for <git@vger.kernel.org>; Wed, 21 May 2025 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747859892; x=1748464692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=np6sESoj/Aod7PLYr1rEzUaG/tBahbMy2byo/FhjOx8=;
        b=d7/IWuiqKyMIcms1Tcn9cOmb45rPyYLxuIAH7NCvPs0vR0YmyPsCpjRMoNQU6e/txh
         MBppDQ5Bw5osOXReUC1VAwfQ6yYDrzyna7iG6fqW9I6XkqCUqmfy+F1VC1GZOidTtHoU
         veCkTe09FfQYVxeYKRq0F3zFc6TFYQaCDN7FfCGNdGPdMn45H47ef8yiIDuMQzjqu7+x
         KDUGsNlZxiIpTp0CKWqn7uNm7krqx8s67RZIA04zKsLkHPy9iyUi8U2hDCkXPObHG8Wa
         pBmMXUab4VUWADXD4BVooQhkFdffvDfhwLXmfnezQyN+MjmXuBxgVEEGRE5P6bFRuPFy
         JROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747859892; x=1748464692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=np6sESoj/Aod7PLYr1rEzUaG/tBahbMy2byo/FhjOx8=;
        b=CUs8PZlehLQnTQitbnLzYmmzdqB/RvLl2H+GvNUiJ2meoINAi5YR5bUS1zZ+LGkCKt
         hct03ifpttWV9cppwH7QvKMeNdlG9ERwdsoUduq2Tm2/KpNBIVIlL9f5ZE8wmlfyyRCs
         7bOQfX3suQs23kb9nDaErGz+o2BssVe+f1tr3LL4f7fHPTd1Mv/2zAQixnRQKi7TNBtM
         j0cs7It6bUlU4JV0DR78AIiGz8/c/OxAN25OleVH1E3k8he5DvdsBIsJPnsp1yXibXWK
         pD9SbUQUwPkw+/lAos3EnpmvPOS6A7sJtK6segtRHv5Pk3uh6opTsMsBV6slNQQdtoZZ
         DXGA==
X-Forwarded-Encrypted: i=1; AJvYcCUkNTuDTNxnAPU26i7VMkXUDo48yrM6kBAF6AGUqVNt1LxUAZQtavoP/3dv7DlPl+jqAL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1+CV3jQTouAGd3Pf51U78XieVQididy02BpmjbQ8Ca6qFxV9A
	czegzskv8cIxqI69v5mRTorRwdJ6zhbiu1s1YiIDSRmVMrJNhXu4Ga28tOkgH5Gf4S8jZkI5GzA
	2OI87dn6VN2lrFZ71HW4e4zO3/9QRoSiQFnma+wA=
X-Gm-Gg: ASbGncvgigeWVez6hizmTY5n+Emq9FOuLM7cHCXla4ATdHDLqETHy9Ik2oy7hjiO5/t
	HM5fbhh10WoWuZs4LmeadJ+MJ6uYmLL1sQdKHeH3zBvhtoXJEXkhF0lHmLiEwwlUoJtef5ulBrI
	q5Xy+niumSjRil4BmozsYS28Ev65CLAZ02YC+0XmTlLz7E4iQSGjvjc3t8cnbNyEHq8NM3RPBpF
	A==
X-Google-Smtp-Source: AGHT+IFRu8074Gk06XT1+pCceEn487d1W7mHI18AwvaDJb9WIPQJM6YJJJASQusuQWuIvqXkOBIMxjMAPAFnhRfaXP4=
X-Received: by 2002:a05:6512:460f:b0:54a:fa5a:e9b1 with SMTP id
 2adb3069b0e04-550e7193751mr7059269e87.10.1747859892198; Wed, 21 May 2025
 13:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1970.git.git.1747827645129.gitgitgadget@gmail.com>
 <pull.1970.v2.git.git.1747858585623.gitgitgadget@gmail.com> <xmqqecwhaemu.fsf@gitster.g>
In-Reply-To: <xmqqecwhaemu.fsf@gitster.g>
From: Alex Mironov <alexandrfox@gmail.com>
Date: Wed, 21 May 2025 22:37:58 +0200
X-Gm-Features: AX0GCFvvvGKAxDhAuFqJOq0Y2eR2IX8oIg69cTEcPWhtPRRadOxKwzqPNQxKPac
Message-ID: <CAC97EbxRpG1ecWcQ=yJHnqe7gXYG7BNo1sF9e9Kf-EOkDySfpw@mail.gmail.com>
Subject: Re: [PATCH v2] name-hash: don't add sparse directories in threaded
 lazy init
To: Junio C Hamano <gitster@pobox.com>
Cc: Alex Mironov via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Junio,

With respect to messaging I more or less copy-pasted Derricks message
from the original commit for non-threaded init: please check the
referenced commit. Let me know if another wording is needed/preferred.

>  Also, can we have performance numbers in the
proposed log message as well, or is the improvement too small to
measure?

In their current form benchmarks do not show major improvements
outside of special casing I mentioned in my previous message
(existence of files/objects outside of sparse cones in special VFS
setups). So, for the general audience this indeed can be treated as a
correctness fix.

On Wed, May 21, 2025 at 10:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Alex Mironov via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Alex Mironov <alexandrfox@gmail.com>
> >
> > Ensure that logic added in 5f11669586 (name-hash: don't add directories
> > to name_hash, 2021-04-12) also applies in multithreaded hashtable init
> > path.
> >
> > Sparse directory entries represent a directory that is outside the
> > sparse-checkout definition. These are not paths to blobs, so should not
> > be added to the name_hash table as they must never be queried.
>
> The second paragraph sounds as if this is a correctness fix,
> i.e. "should not be added" hints that we would see a wrong result
> returned from the hashmap if you added these entries to the
> name_hash.  If this is a performance-only fix, that should be more
> clearly stated.  Also, can we have performance numbers in the
> proposed log message as well, or is the improvement too small to
> measure?
>
> Thanks.



--=20
Best,
Alex Mironov
