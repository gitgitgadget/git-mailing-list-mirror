Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3941DF985
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 05:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760160249; cv=none; b=eEqdyKQxKCIf2wi68IfFQx7PCcsIF62wpVg4mwR+GFQBOBPT6CURA2uft+gmOgHOL8sNQKZQcusvh5alYG1wAXH/mmbuW8YqY+40pTOu9Ft4/VDiLfODchXhjwJikq0POl7Bgmtt03J0M33AzGudyWSMdhv/OJzZ6wiCIuhh94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760160249; c=relaxed/simple;
	bh=p+nQ1SB5ep0CjJEkvKKnfIUBQ8+5vFTqa40c+n7ST1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCil/Mk7/FN0OgMkdfsjXIG1vOWz+APXIe0C1bDSo9/vbz9O8dbVEQPJKgQe8yUMmUF6Wan3GD6EIOVQJ9jXTHNiNbvuusUwfxArtC2IRr9cPl2J5OESb9n3BqQW2oCeH8O4mxgZ5STdCMg58KghQlfwEgm3Bma9fPxKpFauF28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-858324954eeso58314885a.3
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 22:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760160246; x=1760765046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qF6yQJDG9Gr9/UJTbcMyo58JXRLWRjhqTbv9CQwVGHc=;
        b=o8ttwysb0qgU+frLKNf9uQg9gNkY/IX9gg3RolUkRVyZmPNeKbcxHTwntnOSZ2FHqY
         RUHHIqIlEVrsmUiF/nUufwpcVvwSZm8QTTjNWijnJ0jjNtDR9A0LDQA8GtaVxCC/Hr32
         7r/ojno8wb70lFu6k7EkkiH4PjoFusfH1f1CDS4LLPb0RPHDGnDCG/JTozmZCuOM93SF
         yaZYfTDRuq7OQj+iueVfnkKxYoB2hM4luC1Ike6PWpRrt8ZdWnIHk5g8+l7WJxHkz4sy
         YeIXCjIjbPpy9PraseTvjSSO5pO57XwZ63LGy/VqlMA2Ti4O4Ru1J8yY/r59xpocpOVJ
         sl+A==
X-Gm-Message-State: AOJu0Yzfb1Dh2Wh7SsD73QO9APNt+g14XAMMJb8OwVfoDwMOi5hq3Eg9
	NakNWc8R2t5xk4wdM03xHhO9/bUNjIj5X4n8W3IfCDsRdduqQWaintMaN4T23iPQS3AM5Lv+IF3
	00VsZtLHm4NjJJK8AK/gR2mBgf9Oc3hc=
X-Gm-Gg: ASbGncvI1ruXC7VNn5qezAht0gXZuzErydAcnOPxOXYKHuc1PQIMGVBibb7wjYnqpVX
	/7Y8n5cLbIh2KcltRvxmO23HZTjWE4bjD71bFvujb2qwPL9LFcLtz9y/S6bWBtB6fT5Cbc8cOOr
	iqy4zPHTd63JQPqSxSHwNOD+caPV0VDBc4pxOJ/z9mvOm0ZiEO6G8I29AyNRWRSRgWPd+SPdFdm
	cHRtgJ5qZCB6V0WzWIgvh98dbPqNCHFRoyyf3/MMP8FDwnk6p397JXGJbCMnX8lq6r5AHn3CNdy
	7xt5
X-Google-Smtp-Source: AGHT+IHllf9n45VcLQuoSr41muygdMz1PI5nMhojxg5XOA7phvYJ3HOYxtk6lxAPl1EhyMlr7m3yxP3CPs50wFe8sBA=
X-Received: by 2002:a05:620a:2681:b0:855:b82a:eba5 with SMTP id
 af79cd13be357-8834ff907a4mr1293493885a.2.1760160246154; Fri, 10 Oct 2025
 22:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqecra71ec.fsf@gitster.g>
In-Reply-To: <xmqqecra71ec.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 11 Oct 2025 01:23:55 -0400
X-Gm-Features: AS18NWBraPiPFtc8CzxLUUH0ZYaJLCc7VVN4dW5DkNAzSrWibVCDZI5HY4DnV4o
Message-ID: <CAPig+cQOAU3J4qmdtjwRCRkwqpO2FfgDThLt6Yoxdx9T6bhTOA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2025, #04; Fri, 10)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 8:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> * ms/doc-worktree-side-by-side (2025-10-10) 2 commits
>  - doc: git-worktree: Add side by side branch checkout example
>  - doc: git-worktree: Link to examples
>
>  Document "git worktree add" and use of out-of-tree worktrees with
>  examples.
>
>  Will merge to 'next'?
>  source: <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchan=
ek@suse.de>

I'd prefer that this not be merged to 'next' in its present form since
I think the first patch either needs significantly more justification
or ought to be dropped altogether[1], and because the second patch
still needs a good deal of work[2].

[1]: https://lore.kernel.org/git/CAPig+cQRHp7A=3DgtSkrVS4_EvZ9PyqBOdGGHcEaj=
fLPE=3DqU4uDQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cSNesf0UwS4=3DBxe-Qn+G9y3YYPyOK+7y3q=
8QJk+o7jaVg@mail.gmail.com/
