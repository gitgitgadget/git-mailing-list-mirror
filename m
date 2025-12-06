Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D02D9EC9
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765021435; cv=none; b=I/kSlDKUh1AAVpkf2a4RwxtwE+m4OirzKi7eR6TBG7KwwRBgXSNCnRaW3FoMM+ctIXhMBBWQHNvwYD8k7n9FJpX+rH2uXoIpqMnvlY8E7htvl4GQyhAqs7h2SzTNaA2fK2LoZt9CyovJVFfipHEnS4p/uuStKM6z0id0FA3I4BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765021435; c=relaxed/simple;
	bh=0gBdt9GawTmio3bmJrWKfimjym20urTBMv0ukRV4+3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlLucfQ5FDWymiTiRIr0MHPJZ67dRlE48UNXoos8x5k2f+l7W+JAn1yx4E1/1nMvV6m1RJGk7Z4wvachmeDyhSyF2BPEJZwT7WsjZezxF6cnt0kntSC5+KzNL/ir3oQpIwp0cNPZk3V6p9WUg79kHlttCgnC1Kw1P0TOZZDEOjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2da4fb076so55521185a.2
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 03:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765021432; x=1765626232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xmsUZNjD9Yn1xqOzE7qn8lpMmTQDAN1s/t3Wnb6BnBA=;
        b=VREMeqPvL3wE5GBwH168i0RKLxdd3OU0JeMINXHxyp7tefTFcWh+/qKMzW8ae1XzuG
         UUlIMdY61blNXW6BxGQfijioM84baFdAGPJogNp2I37izXVzeTYpDvpe79SVRLlWwkQ6
         bFxRz5Y++Q3jPZF/hCFcVIKcosYHJZTuFM6OqBehohrpVOdaqrnktj/RkTzLPQSnY+4F
         Aw49Jb0x7Q9R5Gr8yAbRhTiIxDr32lQf6jT3p7MLNglWYeUyAJonMSt4KO5FzanZqmv3
         lUSXVhaGLvk2rjjvjGVQH35lAnfoSSkYUSU/NIv0RBkJ0rIpG9ae4dJOd6/ibrU4Rsll
         MxSA==
X-Gm-Message-State: AOJu0Yz6FtJIpO3VQn5v7NVryqqCdgD8ScpmKkg4SMzCx4TEggz9AxE4
	8C5CkU1+QmKubIA6rnxHPuNnzaYPaFB39aAcdr3aLcwEZpFa/3Mr/VOFCYEx9xcXFAMrvsjFrHq
	9bEXeeLn0IgLyhv5GuGXj5VLkwRBcGAoR3g==
X-Gm-Gg: ASbGnctF7gOMvylvlrnfCsrriueKyM4j9n9qvS+NwmbkKq+uTAxvBHLgc7rlsZyK2/y
	c6FeKbESesHH6XefaAvPzcFEKBSZtfmejhUs43dQRpv/6kZUe+sl056Z8fukp/7S4TX6RMRGnxi
	2tEF1+WeaRqyJPch05OuLkC6pTKYkRPlkH4OJ8yF/Cc5mkBIhIdxkxzW/WZt6T6YCbqH4rpq4JP
	GlBCsg4mKethUuAQYO1WlyNWhEYQoLz8Xgwq5e1GbYS/tMV7O3Fq8KgQXyutywg2AWGYWy6WHqo
	QJUP5YIojsnNmpghIW8ASuLlR1f8gwq6+PI9B0I=
X-Google-Smtp-Source: AGHT+IGXzynPhUUrFIH8Y2g25wwMIFsGnTl4kwgaxCAV/Q8Kxmax/y+zsj3XWSV4bNi3bv6N2a+ftyPJRvaLWFeb8sM=
X-Received: by 2002:a05:622a:1ba1:b0:4ed:67c4:b7b9 with SMTP id
 d75a77b69052e-4f03fd5240dmr22580171cf.1.1765021432265; Sat, 06 Dec 2025
 03:43:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
 <20251205-odb-related-fixes-v1-3-ef4250abb584@pks.im> <CAPig+cRW6tXFTqqnhH1Be33TgzT2dsdzNLFii3Now7+DNiTTvw@mail.gmail.com>
 <aTQVt4zgMbsX_6tD@pks.im>
In-Reply-To: <aTQVt4zgMbsX_6tD@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 6 Dec 2025 06:43:40 -0500
X-Gm-Features: AQt7F2qQeeSNwYsU4ITCOvpWHgCtgC658CuxMQN7Xpa_evaYqOrDeNW5AQnarIo
Message-ID: <CAPig+cQNKQt=kMaNYNWAPAfGej-mhLUR_BXS4J58JjVUtG7VKw@mail.gmail.com>
Subject: Re: [PATCH 3/3] odb: properly close sources before freeing them
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 6, 2025 at 6:38=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> On Fri, Dec 05, 2025 at 06:14:22PM -0500, Eric Sunshine wrote:
> > On Fri, Dec 5, 2025 at 6:36=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> > > In the next commit we are about to move the packfile store into the O=
DB
> > > source so that we have one store per source. This will lead to a memo=
ry
> > > leak in the following commit when reading data from a submodule via
> > > git-grep(1):
> > > [...]
> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> >
> > Considering that this is patch [3/3], to what does "In the next
> > commit..." refer?
>
> Good catch! I split this out of another, bigger, patch series. But as
> I've started to hit the leak in a different patch series, as well, I
> decided to split it out into a smaller patch series.
>
> I've queued the following change locally, but will refrain from sending
> out a new version for now.
>
> 3:  a06d0716c3 ! 3:  c9ca233c29 odb: properly close sources before freein=
g them
>     @@ Commit message
>          In the next commit we are about to move the packfile store into =
the ODB
>     -    source so that we have one store per source. This will lead to a=
 memory
>     -    leak in the following commit when reading data from a submodule =
via
>     -    git-grep(1):
>     +    source so that we have one store per source. This can lead to a =
memory
>     +    leak when reading data from a submodule via git-grep(1):

I would think that you would also want to drop the "In the next commit
we are about to..." bit (considering, again, that this is patch
[3/3]).
