Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C1126659D
	for <git@vger.kernel.org>; Tue,  6 May 2025 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522358; cv=none; b=cpxBIBKOV4K8iu3tZ+kBEtSUAmMzQ0PsVbaaR43d5EjqXjQjuOs91+Y6PvlazirB6zadAmDR3jv13L3+xMr5/pggl5FexMk0eP9niq+nhnRoHeleqdimxbwuEGr47q71QKZENTGMy4G9LFZL+/WgQBBNufE0X0VN6vnctWIhOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522358; c=relaxed/simple;
	bh=jIqLRerVtHqRQ8To4qIApR37R9qq7ra0Kd/eWvGW/Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmt7wABT/hO3w15kvvZ6/ASeLvjvJ84xrTTU5iexBqQvtuSveT9J7jqwPrhDutNE9P5/9VjxRZSQCFQNbtTz+Vv7rUxbAg83DUcqSiqRR0StvXCD2rx/HajgW+D3uHybLjwhinEzRzs155okhHTJkFcRpuEQDTPbRkE9yBsu1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4t4kKuv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4t4kKuv"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fafcdac19aso3213271a12.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 02:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746522354; x=1747127154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6y8KdnaVKFspkobV0508YSGUAgsOjpPucFAViMEqFc=;
        b=L4t4kKuvw7QWCUkxg20hadqAhTnRjXlLAgaRsIe4Ywt34qXaV+tSKg1ZaOQuGp6KVF
         y3C2h8VNka+iFtVOlVUbQXg9Ue061efQHUo+MFylsye26c7ElN5HsuglesSglpkCqc5Z
         Uj1suPbZ1IKhdTdyWkQwNdD4EOoNkimm0hjTRta+LYCxBD8FkLuxlzBX530TD76tYx3H
         XQFE/Oltpt3FbITKi4NO5JWGi3puRnPeWL6Iuk0JsH2vDTEwvqS6XTgni82raOSq38ZE
         T/uiGs5DtiEC5LZbBnYGmZDQoC9c0aqGX+IIP7GuJqaCxzeIWN6FFTWigzwhPtuQYopg
         y3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746522354; x=1747127154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6y8KdnaVKFspkobV0508YSGUAgsOjpPucFAViMEqFc=;
        b=UacngTYuoL9B2Ryw+yHOSDoF18YDSLTInjdRVtiefEzfoNHzReCVOIzsPFyHC9PX41
         Fbz6W9W6PpRQvUw76bIIWoZZ5JNcf7QS7VHqRhvt2CoXIdUiEFDhtcYbKZCAe7vKuL6S
         TmsvoppdUryjr7e+HL29XENlybgeZc8gkueGRYi/UWNlrsOOwM6+O4/Yl46QiXEd2nEP
         HR4yWLzDGerUPfv2Hpk+wQA7kQ7aFd2NMOH7sfgS5jOZ1K5440qRsu4no9wAOhA/LA4E
         snvGT32PJfOz2MngEAjzri84V3KpBxWRRYbVK9gL/UBLVpQoAw+lkz4MJFc0wT6EgJaJ
         Y46Q==
X-Gm-Message-State: AOJu0YwvwcX+ANLOfaNN2G+vy26uNFV4Cr6Gt0ZRAvb+LV1T2QucLvaU
	3EEoRe9ZJQFoZyAJCfnGmlqkxefmk8ysBGa4xyfWW57Zvs3Kl6Kqm9ibCtFqWBA7fqVHVIwJiko
	sAGFIm/Vso03zxWb8j3JKA949WD8=
X-Gm-Gg: ASbGncvyjaSYuGh4uPGyizTnzVDomR/eOX3sRcpyQIz268SbwmcfVN1cEZJ6UfVdRLi
	yZuq6ZxifKia9QXIuTwmLgV9GFnzwE5TXQ7GNsB83GqO+/yA3NZqNaEra/x//cBJD6XIbCju2k8
	2OfLx/igP3egH2C1ET9MNQZ5T+XKSRJpktwelZLF6ynSO0FkWs34APwBM=
X-Google-Smtp-Source: AGHT+IHCW7AsRFJgECQ5XbyhfCc9P8c1ZFX1tdyb1udpReiTLJBdww3QLw6MMGwvCcy3fLyIGCB4sPtfzM1k12SRmDw=
X-Received: by 2002:a17:907:f818:b0:ac6:fc40:c996 with SMTP id
 a640c23a62f3a-ad1d34c10bemr216772366b.23.1746522354012; Tue, 06 May 2025
 02:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im> <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
In-Reply-To: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 6 May 2025 11:05:42 +0200
X-Gm-Features: ATxdqUFiaf8kij5whb38dVhLSR-mcr_H8MbPDmUmXA4dy6JN_dpAUwQOVn910vA
Message-ID: <CAP8UFD0twBxZvEiLq8OBi2xhT+BnbL2k7swqru5CTQ67rdYM3Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] builtin/maintenance: implement missing tasks
 compared to git-gc(1)
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 10:52=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> Changes in v4:
>   - simplified the heuristic for "rerere-gc" even further. A positive
>     value for "maintenance.rerere-gc.auto" now indicates that the
>     command will run whenever there is at least one directory entry in
>     ".rr-cache". The exact value does not matter anymore.
>   - Link to v3: https://lore.kernel.org/r/20250502-pks-maintenance-missin=
g-tasks-v3-0-13e130d36640@pks.im

Except for a few nits I commented on in my replies to specific
patches, and except that some comments from Eric Sunshine in
https://lore.kernel.org/git/CAPig+cScor=3DE2i4w99NCrsaUd-Po=3DFqhkrLSyT69PS=
o1+h2dRw@mail.gmail.com/#t
seems to have been overlooked (especially one about a memory leak),
this looks good to me.

Thanks!
