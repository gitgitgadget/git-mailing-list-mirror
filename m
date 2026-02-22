Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072B2E63C
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771749587; cv=pass; b=S/9KI31aY+hEeci8hqNKk7jozJC+3ZQbCxQ+DGeKPYHzgpFbMOo8mY67/Tx1jI33mlTql5wMNtJEeSfBEO3jYSg2sW6vrU1eKzn12sX9X8udTlgyGJ8tIQzP7GP0UK68MNAvxk0jy87INgu05iOFoTKeGBivWgEgAmSW4bDB4kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771749587; c=relaxed/simple;
	bh=789JVcDQ4JrErjjK3x49tdyrOrIsnOCxAUeT2cuLEdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxcEbOHUCRWT6JCmtH9Vrg7n8X7mJYtlRelSxLZ9NGubvKX1O4SJ5844owxlS4JiENMtz8MGQ0EqmQSh3EL34S4w5BhNH/uneV2H2+FsuI9eDmeiek7uWoubcw3M1Hdim/yV9ZSOhr7+Yx+G+wxMoWKQDl3NBfZdmbqJPjkMbiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bd5658b901so110587eec.3
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:39:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771749585; cv=none;
        d=google.com; s=arc-20240605;
        b=Edza9sNkdJp6ddJwlF2Ho+mCkII88yumdGJl8nNhID2PS/y3oRz7pJSWfhEJEyv6Vk
         DDKa6AA76wSghGdF6/tJ07v2ZULR+tqwRKGri50EmyMOMWT/YAxZsw4PIQoMrd6FxQUN
         vWUnL+ZRzZh3XX9KXZLW4IhZ0aexVzDSJ3hInJYrENS8yUAu5ZpM5Rp/6h24ERs2tOWO
         X4i0ulAG1dp/6NPiw5tddJGQJz7/WKsHK/KCvZiP+c78oNy1JfjyounrYnyvqbrUXsPx
         6byfMV+vM3Ka3FQG0lL/MuXSicdDe5eFbmeVTTcLshZPG2FYrJPko+cwlS7fHTTbeXrd
         NgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=DbFVIvUzBBA7Ko58qu3CR8HkIJuuR7L/4ODvFreepRc=;
        fh=WzQDSfG+8tRUk0dFyLK0A4YzsmgvrEzqraXUiGzWxlw=;
        b=lO021bMhhll1RgDFR2/gHiJR201KvK7947z1jS/lt2B2KfWSe45jneQSvGO4z70JgV
         deRFIlARz4rXcxna9xdd38Awo0lzVejugIWfnlKIHjNXSUIxZUEtCfk7sN/Z2gU0w5vM
         P+8lbfwSWEfcvWjhFOW/4tvEd7vui+35Iq+3DNGltnNcK9xpblCEo7qFmWr7W2ybTjup
         XpjKwhfyW1aCSvNn+ePX7DLVHCrtUC/ySeI1HBnGl7knVBaxlok1w3suY/4El7smn1Ig
         fNgMiTrDPGumst7wZQLK3jtnUdUDcAEZhRlYzpCahryT7m5JrjcBAmZz1l98RIvWixA5
         dx6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771749585; x=1772354385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DbFVIvUzBBA7Ko58qu3CR8HkIJuuR7L/4ODvFreepRc=;
        b=h6EQKWEiHDXmpf4rABrrpE3+Bm3hwXov8L+5UDxksWwTOKLJNCJTYa6ilVyExULzEt
         p5gWBqa5TaSmSpgQe2sxHoF1lChce+09UTYINznat0KpwuCU6J2XUiwhYfIRCuE/dboU
         dQzKK86XryBNLMBLVUU9hDCYUJfOoYNg97kDXp1QVD2ikZ4ergUvStILvtba91drnPNp
         /CGUtbiY5GHrp5RCUz0j7uZUrE7cFfU7wjwBXz6QtHc7lgxOLmkX7clsze2hiA7qPc6r
         L4+kVdt6SaoWYZjF0QM++ZenoKex4tGuIkanqgG6laFdC1rHzom0b4+XwjpdQcQ//daH
         yXIA==
X-Forwarded-Encrypted: i=1; AJvYcCWUIpsa1AK9Qi8Tco64TJC+BBW6hEABYiNazAleig9o0Sbps7DpsZYVxzO3D5khYrxoRfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrzYvJFYHAjq3h+mDAb63o2/sObuDI2nx4RJ0rqSEa0aGfFIB
	CCchJHg8pcPgysMAdSqbIUN4zxjA8bWTUbQ7LwXTUWmGp1LCbtpv2loxq+zpT7kvsBI2H9YC5RU
	q9GXY6mDeYbegTXMDRyhjYNTs/RorzrI=
X-Gm-Gg: AZuq6aJoYwkJrBE1Pk4SIDMD0myRnCLPCY8ytGUPu63aZWYRH8ogDi17o9+v91UcidC
	SIHTHOlTk3R4Ftrw9lTeorKTB3ioiljhZ5fXWYfYzlEcj8aSCZQ87rdyOsYos/0Exghp7kL+wBX
	vPatmipYXqyKnBjBydK8AuQcR2D2B0PTg7NtX9SUDPF86wiBqGsJqUaXAIab+NFTM6QkCs/uK+E
	+lMkZZyUVQeVPqYILts/KuBj8AlWk6ihhYUa8wbfToEbo6nXcMLudIC8x7wThTunrEcZQU0R3Ql
	+6yCYugANF1Cr9X69XpC7LreIx9afhjO2MR1ukmUhQ==
X-Received: by 2002:a05:693c:310b:b0:2ba:7783:d1d1 with SMTP id
 5a478bee46e88-2bd7bb62b24mr1139313eec.2.1771749585032; Sun, 22 Feb 2026
 00:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
 <pull.2043.v2.git.1771257211.gitgitgadget@gmail.com> <xmqqo6ljujkl.fsf@gitster.g>
In-Reply-To: <xmqqo6ljujkl.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 22 Feb 2026 03:39:33 -0500
X-Gm-Features: AaiRm53T-jAvaxgPJl5Iwp9jY-cq15Vq1rPWFU6b96QbW2QTmTdQt9aX5Z3Or8k
Message-ID: <CAPig+cSnD+jopFfgjYU+vv=DudcyFwpKLHaEfu5McS5hdViqWg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] gitweb: fix broken mobile layouts across views
To: Junio C Hamano <gitster@pobox.com>
Cc: Rito via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Rito <rito@ritovision.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 5:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> "Rito via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > This patch series fixes mobile responsiveness bugs that currently break=
 page
> > layouts in gitweb. The approach is adaptive rather than transformative:
> > preserve legacy desktop layout, add targeted mobile constraints at =E2=
=89=A4768, and
> > prevent content from escaping its containers and breaking the layout.
>
> The latest round of these patches have seen no reactions; is
> everybody happy with them, or do we have too small number of people
> who care about gitweb or feel competent enough in the area to review?
>
> I am inclined to say that we should just merge it down and see who
> screams.  Maybe we hear nothing, or complaints, or praises.

I'm neither a gitweb user nor a CSS expert, but the structure of v2
seems more sensible than v1, thus addressing my earlier comments[*],
and the changes overall make sense (given a superficial reading).

[*]: https://lore.kernel.org/git/CAPig+cSb=3DzzDJCoo91detBgfAi9p4a3R8sVc6iT=
XfzpbNxsNrg@mail.gmail.com/
