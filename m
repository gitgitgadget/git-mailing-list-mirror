Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8184D3C1985
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791612739; cv=pass; b=Wx0zz3eHTOuxPsKKkYGvibdy0Yaa0MBfXSzM8MGZ9sn3q7n56Eh9iEnYwHiaL40LksEVpABcxMobQ2mEZO3PENNSlJ2PhOjsozpsXmLHuGqZbRJ49AoTXIDlwQmKW7fbC0oV7Z4L/hQp9WfC89jQsNHvV/VcjwkNUlgFKG9XNoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791612739; c=relaxed/simple;
	bh=ohM+FQkzYG2l3+E4rw3V6kcrOq6MErSlcouXVhFP6FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrHPEvqr4Rvgq9bQKKAt1im2vx89/4495TiaMVVqBgMlTLpZH83EmN9POVRQxJe8x/Lgixq1EO2a2WbEq2dyKJLCuDY+PKdw7sWNGZP3LNmK2YRfvVdqdLRpuWD/dpE3rpfCSFxk9sXN5aUKgAGLL6X/CNAvQ71vJIOaEuPkPHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-355724d032fso36234eec.3
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 23:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791612736; cv=none;
        d=google.com; s=arc-20260327;
        b=eCFoGjv+NzmxzNxf1iUamuEB6dwweWjH7YFdsX7fPhJk15NvZQSIyi+SHcEftm0F/C
         IjprJmnYVeVlhC/BFqmN1+m0e6deZL9PUxBTtUd4vfPEamTGfYhzbarltaQLtE7biTRd
         oF6wvj9ihst7s+ulMaodCcbD0EhfvsA/guYRvpYxr214vdvMz5bHK6nHSThAsXJNlTVy
         xgdG9pGCSbmbhsy/xWtwySPULQviP+o5T2TcDiVqWajHn914dNRA0iekCVwT6A3vNTzo
         wqbiH3cx5SXu80LkkEUnV1SqFL02z4mPjeH+8321d6ZbKC2NXVJ3kmpcMXNs1wYcxIgn
         ZBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=QQRnZ+iYpAA0/uQk4cDrAkl0QsPCEReOQcF3h4IancU=;
        fh=No3IyoikrV+Z8ojXdCX7LzC69n44giKeX5JPRHOzuLI=;
        b=hucR8OKzcxWHU2n5NIFQUVjN14QtTGsB5+xfusPAmh7EYX9aI0k7rp35hgvS8RF/lt
         gnQ2YYMvH+qb35vuurfS/tWZC+gjMRjoULPXZSqLg6DkIv7G9G/NAGWz01aFVNDrEeQ3
         Wm7hcoeYmADwJxVbqxsMaDQJabTUCXMTr5whGk+YiNk7DiSHPLslHfXvpqkfL/hN+Ui1
         9UYMjCUJFXRjETorM+D7fFT1Nu+ewwUEkhr5zGS2R3Ue3uniF0TsxonTp6qY83djTSwH
         AuzNdIE8uHY+7EKbWsh25GdaGjYWuSqS/AMAZVuZrYHJExwpaLG2ARrS3iLIoUDHD59k
         WlhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791612736; x=1792217536;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QQRnZ+iYpAA0/uQk4cDrAkl0QsPCEReOQcF3h4IancU=;
        b=axN+2SSlThQE7kAm1bdRrOr7PXe2bX2gjEaKEJ6BZqxO4FAqIkj5J3oIjMb+ekWorL
         2xFclL1DGL56YWNF6DKny4gW4nhftRVJTuuzSkuqz3OM6Rk/ZBbl7b/uZ9lhgcwfvwp1
         DUoxBiO2L1b3fHkAuJwAuJ+jn8RgvIdJVWig08W3m/7rBAy2lVohk+WHS6xg5r0OiAdt
         enpbdyqCUpUoVjzG/WnXjLBi7ylP1rpQCxziY//eIeyxfMpC3JthSHvr6BJLL361gFRK
         r0HPzgYQnzUwtg5jCuzAiE2dobwybl374eJrkZOcNeCOvdvQ7Rt1r8V7WqfgW0O5ZDuI
         X+GA==
X-Forwarded-Encrypted: i=1; AKwUvBwa4I4IqJ0Klp9FMNRVjm2n/sezbHC7VjCvWvil7rZoCsQNFgNOTDUDgfMyaFGzew67qLI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUU05fu91iHBm0DV5az/zAhQj5b25NGOR0qgaa2aTc30/Hs7bQ
	4otk/iGW7uux6jgInntPboSs4JC7kEdXCfoHmvvY6hPA9P+2jvTiBTRCntXfbeQm4VuRHSIZQCZ
	cBF8tp2wVBJJkeKug1K8YAn7SqMe68Y0=
X-Gm-Gg: AYBFou2GRh6bg+w+HEsG02/ai7sK9n1/4d10M9fpf9QtjoqARFyUldfNg5c+qCtvMm+
	hKsqTV2Wx4+JJAfjpzuKEL1ihykpw58VlD6OqfdI+W7YGVDFVxBSsEA/81nejZ7kOCd+VbkGa3U
	n6TMCKGO20JZSbljAbTyabPf5pvrFC5hXLrSW3AqpbC8CHVM3Ps13zA7ByyX/cICkBjjl4X+kPT
	IA5i0Px7Ilbg8Qb19QsSixq6asJ9hVHX/xDMmIxcqrBj6zxqOjTkXsFNkTcuqCJX8kHwvB22hLz
	P3udGKefY0KPl58+NdVjuCqvyM6tQUY0kO3Bw41KjVYM+zX3YHK1xQPOMxyMNBYOfm6odlwjF1J
	1DlqYd5H/JmcAYQ==
X-Received: by 2002:a05:7300:c8c5:b0:351:7e15:9c59 with SMTP id
 5a478bee46e88-3537dc89f58mr8103973eec.0.1791612736451; Fri, 09 Oct 2026
 23:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
 <pull.2224.v2.git.1791493644.gitgitgadget@gmail.com> <35e303d65bc378e733b1e9e8d6908a829352e857.1791493644.git.gitgitgadget@gmail.com>
 <xmqqbj92ochm.fsf@gitster.g>
In-Reply-To: <xmqqbj92ochm.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 10 Oct 2026 02:12:05 -0400
X-Gm-Features: AclHuK9zRiv8p6p9uRXqjigK22C9roL9c82ilzXGimUtSdCc3EEunkv_fiObdbY
Message-ID: <CAPig+cTZsbYq3=9AnN+00EiWZPNhQiF2iG7gFdmEQqjFcGfM+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] blame: ignore revs in HEAD:.git-blame-ignore-revs
To: Junio C Hamano <gitster@pobox.com>
Cc: Ravi Mistry via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Abhijeetsingh Meena <abhijeet040403@gmail.com>, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Ravi Mistry <rmistry@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 4:17=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > Based-on-patch-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
> > Helped-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> > Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>
> These Helped-by: drew my attention as none of these folks commented
> on v1 of this series.  I do see they have helped the original series
> <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com>, but it is not
> clear how much their inputs have survivied to this version.
>
> They are all CC'ed so they can give their Acked-by: or Reviewed-by:
> on this round if they want.

For what it's worth, having skimmed the old thread, if anything did
survive from my reviews/recommendations, it would have been only
extremely minor style fixups.
