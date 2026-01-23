Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C00B34B1AC
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161944; cv=pass; b=PSRTwEzR3tY2RJlpppxZu7JNP7JalBH2qaLoQHTPlNZMirF36v3MvD+cYKsO1WQ2KcGd28+7wQWj5LUz3QmlErO6GQT6zx4pgmAUHkAU04e2rU4+q0fELuI8wG9Zf2Kxwsf1hYsryi5IJsNHszOt5/NuTgz1LYOvBHd8pLthry8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161944; c=relaxed/simple;
	bh=ztuXG/lh10Gx9B5FtrbhQC6AKCXKy3kJzw5iBzXhpJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YISmFRwFzShaSa8oG4ULO4HIeWYOpDf3QWPyXc/ieePomvdDdW7SeHYgJVN766vSr8KY/GORVld4XHhfckYBhrAyoBpetfd0VdnP++CMNlYfmZXeSw2EbDAocR2+XirG2ofDC1R6FygqxI88+sdWtbDgzWYdletCYtLaeEtrgA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MD4im2iE; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD4im2iE"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-385d75e1a79so10814631fa.2
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 01:52:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769161932; cv=none;
        d=google.com; s=arc-20240605;
        b=iAKqS65vrNfL/ydYvODyPDL3OZJQMQpIu/ySpC8maFykF1NfEhDSNEHQIuOeyvUn1r
         LilTrlHUHwfXSiuDH+sSbaTeCx8HQWbsb0KvmF3b4RboyduOj6C9ScNS5OEn1B+S5zbL
         6j2Kc5gkiT+veHllkOQZGH1iguskcXmRcnTG1gUKBudqcdkOqvYlbI5DYVcirBabau6d
         FwK/up8qaxfORlFO9ZyblEsiibbaaZGJTJn9vBHuOvi51A/RPwBvGE7UAX2Ilj9Vbz9Y
         RDG664o7CaFbRvi+Qhf1flXgB87+arp4v/fCFJeV8d7yct1qDhC2XiC6vZa/pxRwvLI9
         QPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ztuXG/lh10Gx9B5FtrbhQC6AKCXKy3kJzw5iBzXhpJw=;
        fh=9cELQ7nFtszHYpLvAmU3KlDzW61+4J1JTx+Nz1FnoDM=;
        b=NERC+qWZfFfM1Skj32zpHgHpzQXGptC/u7cqNkTBiuO22W02ZS/pgCI3H9XiAVWKYX
         Dfb8AwvT9SGXE5lr95xr0hKrAQtFBalNu+wvcWq99GQoWnYsY2Gnmem2GyNOwa3Ih0ws
         hkbbh8N1tkQnmkV6Zc2Asj4aBsygxeb/Zvix7EPtBVQukGAaoySDxAGASmYv3PSjLy3r
         e/dbl/IaJZAAUjEOW03SxKOGGMn2sIwX3ohwogYxFDqz0HLfADagu0eweIxpfnyn59Y8
         SnJpXUuOuM/U6Yvh1scuu5ZPhTmiajNplRojCRXV2Cikt9mfOMPS73taIlLK8N3JJViP
         vg6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769161932; x=1769766732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztuXG/lh10Gx9B5FtrbhQC6AKCXKy3kJzw5iBzXhpJw=;
        b=MD4im2iEAS83nCN7Grcn7C22ffWwB+/ikz5tltd/c5ePMM0uYT8lsMPHKZGcOotjrV
         Wij0TwzfagPKKhG/Cwtj/xW6FZZJXv6/HWvJHBfcCMKbuQXNxSSOX2PHfli1zlGMctzT
         u+e+KFdVse8YlGT9wlEY3KyjFJ3FX8/KeJiwdvy6Bf0KCjspEmebjLWeXq0pXdttwet6
         N6/dwFdHF1aNrVwoXMOsAT2zIjWjK+Q5wO1dr9DarMEpTS4OAvkMJ73FsCZLaFi+07Q8
         x6AO6n3WtgfvDrE18wuOxUSzlBnCQJCenN4q8HlNRXSMXeKUfuc6v9sFa9Y0GH0tj1e5
         MZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769161932; x=1769766732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ztuXG/lh10Gx9B5FtrbhQC6AKCXKy3kJzw5iBzXhpJw=;
        b=aZINc0mmGr8aetj0xqymQJOO5y9AMHDDsJoQ695GRQUFaI60J8w+D9NuLkFtRQ5FiB
         Oy1JKsedolhgM4AuPGOaGjMLb4FXAzQ5swU092ruI4cZwW6MHGBU3I0hdAjRmynOAA7m
         cuatI6+BPxiqBwGU0Txjt7cwbhsgcEbs8+v1SYaRr+CALb9a4vl9n+NScrKhNTr4aStw
         ll0UfOYxxrDAUrpSOzfbBz0BiGlNOiwWW831EkV+q5moankAZjR79kJ02d1oKOgJ4/HM
         VV1kdYNle04TI7WdrYZTdJRTNXD2VIm7764V8u2PvtOHzQnDdPQElA7kN6pbITNWz+e+
         rVaw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ76IBdmhqqBXLFlhNYVVmvEuCDuMR8fV39HSTOSZ2HOliUEk3Yh5LOj6ZmJYeQevAldg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGbcDEDTz8/cjdNavsHDpOfiwUszTTphKWALDomguY+R3yeVyN
	dtp3eWUrnMIseiaAo7Atp/oTjUEsPQMbsP2EwGnMXrCwAMDxCjQGGi1fNBLL7EixrghGrCAxxoa
	FZDC9+6S+eU+nWaIwhqhC2p67GJ4WXK4=
X-Gm-Gg: AZuq6aJPDWRE0l8nmPpj4zThpTbi/QxTffOFHEtTC5p1Ih27jRK9iK4Q7OrFMp8TeLI
	T4Z5NKd753rcYAAhJHsvt582aQtgUBH7Gwr5w9aZ7PqO5xgsBVJxfvD+CH2v7jfx3zHxTNz8diO
	QlvrKp2l0LGLznN4ACcI+aIAidYtm06kzvYzlfyb4g1+oKnnLMTpdBSITzyr+iyq165gMgVHLZk
	bXuSlRdEd1TGeLmhGzsr5TfTgYIoQgk6rpfn+sKhEQnXonxUcR0g0bnuzbgXhjHdrXnzkbm
X-Received: by 2002:a2e:842:0:b0:385:d162:bf58 with SMTP id
 38308e7fff4ca-385da06820bmr5738721fa.37.1769161932229; Fri, 23 Jan 2026
 01:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-6-12c4dfd24227@pks.im>
 <aXK7cSJW2syew89a@nand.local> <aXNCjT6Al-4YLah5@pks.im>
In-Reply-To: <aXNCjT6Al-4YLah5@pks.im>
From: Chris Torek <chris.torek@gmail.com>
Date: Fri, 23 Jan 2026 01:52:00 -0800
X-Gm-Features: AZwV_Qj4NsKVyP2YVzUUhJxgFLug1TGrUhdhj97B_RupmDuXzZhJOdEaBpLDQQA
Message-ID: <CAPx1Gvd6BGPeVmN5b7WM_r6OFf7Y6KooJ2O1jT5O6LzNzGuEEw@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] packfile: introduce function to iterate through objects
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 1:43=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Thu, Jan 22, 2026 at 07:06:09PM -0500, Taylor Blau wrote:
> > On Wed, Jan 21, 2026 at 01:50:22PM +0100, Patrick Steinhardt wrote:
> > > Introduce a new function `packfile_store_for_each_object()`. This
> > > function is the equivalent to `odb_source_loose_for_each_object()` in
> >
> > s/to/of/ ?
>
> Hm, isn't "to" correct in this case? The remainder of the sentence reads
> weird though.

Different English dialects. The preposition after "different" differs...

(It also matters whether you use the definite article, "the function F1
is THE equivalent of F2 in case X" vs "function F1 is equivalent to F2
in case X".)

Indian English uses "a doubt" to mean "a question", which always
drives me up the (a?) wall, but then there are languages without
articles (Chinese and Russian for instance)...

Chris
