Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817A75D486
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799657; cv=none; b=tEnHsJMuMPxP5qq0NUAp9mygPHoPh8Zb2MmC/diOQ3xsenZ0+2dhDsUeMy2eyHwKwgTpBnfyFqf+DCEBu6QAl+uEVHfHh3FnB9qorO4uVB9wz0ip/0eDm5TlPC9v7/B3rR6nszqqKiZy2j1IXtfhS2vRDkV4kjRuFEEuFmEwDgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799657; c=relaxed/simple;
	bh=A/RETc5aKrTBMgGRqnkRUkAO3mZBwEDu3Tqi30L82sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sH4UyRbpLOMTd1exYb5Eg9D8dqxCuqIGK08cvyOCz9R7NxyEVNoEWdGfrQHkCOfL/SEuS6XwoC7ID3Zm3yE5i+t6qtc/xCPGMXPR05wefw9s8loeKImlG/fgC4AELMbyZJsuCtHQZapzybckJZdMRiehED+NvqYMzKJI3grGdis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-686a92a8661so5657326d6.0
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 07:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799654; x=1707404454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/RETc5aKrTBMgGRqnkRUkAO3mZBwEDu3Tqi30L82sw=;
        b=Pm+aeYBFFoZFaYuAgFT/FFaJvs6CEpd9CmLMrRgB9Mo617QteOaYuJJW4MPzP3WGTv
         uHPzcITgbG3qZ742T8HJG/d/jZIor0G4g+DBkcYkjOpOrxEVPIR/nb0H/I4cUYuGLVA/
         e57ZI2JdgpyQVcfgzcqPyv+gRULyokubrYwzT65CWrEO2NTnsI9CuGI419H4z0k5O6Qo
         dVg16j04FTh2CsO8CoDEQYAwIfOElKEJLFb4Y3UW+i37F39ECZho/AByittfhkXlSgn+
         7CN/n50rjzUBjXD6aCG2RwXN9ktWe6RCh6tx44Tt7S2haEfuW0wQNzZp/+pwLb0Brp4Y
         OfkA==
X-Gm-Message-State: AOJu0YymSuJM1MRh15+Qn+aTpubjnTxHWwc9GEGqa1V4zHlHau5EDv7u
	pPdt0aeQIu8mTwS6lnG81MBFC792ogevA9JgYlaZbo4lXX48wHHi40GDUDAhAHLcN8EGLzGTX/o
	vULKKAR3bRltvJCkV0mDexneNjIe9m+wQ
X-Google-Smtp-Source: AGHT+IEtCm2LOrNeomVgNdhvI68gIW6e8AjfBobv/uaM+Cv4bCbx0yPYqcesuy9y5ol+S7xUxccaVfZbth/GVkRJM3M=
X-Received: by 2002:ad4:5bc8:0:b0:68c:5e33:dc9 with SMTP id
 t8-20020ad45bc8000000b0068c5e330dc9mr5712287qvt.34.1706799652685; Thu, 01 Feb
 2024 07:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706782841.git.ps@pks.im> <fadabec696f75ae0fa25bcbf87012fcc4768acaa.1706782841.git.ps@pks.im>
In-Reply-To: <fadabec696f75ae0fa25bcbf87012fcc4768acaa.1706782841.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 1 Feb 2024 10:00:41 -0500
Message-ID: <CAPig+cR0iMPQWeTjC3RVnJFydGL6ZNdV3O63uC84VJ+TJhv_Ew@mail.gmail.com>
Subject: Re: [PATCH 1/7] reftable/record: introduce function to compare
 records by key
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 8:31=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> In some places we need to sort reftable records by their keys to
> determine their ordering. This is done by first formatting the keys into
> a `struct strbuf` and then using `strbuf_cmp()` to compare them. This
> logic is needlessly roundabout and can end up costing quite a bit fo CPU
> cycles, both due to the allocation and formatting logic.

s/fo/of/

> Introduce a new `reftable_record_cmp()` function that knows to compare
> two records with each other without requiring allocations.

perhaps: s/knows to compare/knows how to compare/

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
