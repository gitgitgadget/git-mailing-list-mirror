Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB012E266C
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095217; cv=none; b=D1A+7AbhgK4kfx/hBnYM4vjy8KJBv5pOGP2wiDSCiAEAyTWOBxLo3S+haDz3CA0ajwPVCdGoe3Rlrv8NJR+gTvrocZ1zSyYygv6fzqf9Zh60+DLbu6myJ8AQ42B+0fZrwaTOqHELRHkU4eBqBOpuZeLmodrpJE2+QlSwoGmUo4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095217; c=relaxed/simple;
	bh=RkfhYhAPG11CEz3MpAgLpIL1OqVtLxkU7TSHG8fos0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqL9A5/B74zdkMKumBZvXEqNCSkQWJJBg0PdwzGj5VvQigpEcG94kyvfuu/02XXl1mCOhJE19ZS1P1ZZGhIEeWyCGL4Es9Cf1+SNU7S48fI7p+6JFeJUFETtCVH4IR2WELr0/+XoVeaQ1JxgSefWTUdlbuUiN/tauA9Qqn+cLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-829716c5293so57114885a.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 00:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095214; x=1758700014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkfhYhAPG11CEz3MpAgLpIL1OqVtLxkU7TSHG8fos0I=;
        b=mx/Y/kwNHc1zB+q1CXNdMMgfTtQygkFul1i/7Qpc4Z6NlaxL0VrMbCrkfzaWy0xE8b
         hAAspMi3mAcAQBXhSz9pnqqwEoa8tmNLOZhlAIhfdeMi5nfqKuYB/fpz+FytFvuJRNHT
         ZwCrNT+8JzymX40uWT7Y4DM1tnww+ReyjCoFu1VpLdYR0p3bxGr0a/2glI4RS78/PC4P
         GLBJGxRnMbZmUuh4cRJlavJc4gmvcCSfp12EjA2E6vlTUkH6ooN6qvZwwcEsr7eVG+HR
         78Bh+RwS/ckD7TwatTq4cV/KDS4cMwqiWNtfmEebT1XY2Loju1sVaIlo9hJDFFTR8f7n
         nfrA==
X-Gm-Message-State: AOJu0YwAio9O0D/nxh8ga7nHqwXNIT2UoAwXVCoAhCSV/cJBdOUb3O9Z
	Ri4B7kGVJJBCQNv9b/e2YJKpXkXaYSqsgYnVUEGSsHaGCRn+fa+l/YOKsYdo4oG3tJYMuMxWf0Q
	A+n6pGYlQsLB9R7pAmZXnQpFqdWmhJI8=
X-Gm-Gg: ASbGnctKBqbxec0AS4eHBsCUOgGYbskZe7o5DJgh5PBKHelQJWty5y48FUPjC1KjXad
	tPFv9DLENW5VVs6nZg5p8638TQSAtvFb0Jy8uAr7+vuy/OhuCiH9YGlCIESOLuYOAQIgwY1bJcA
	UHYFPZ+0Qn50qZiwtuz50Zl9/W/196lL89ZwWLk9gRx4zh6N1UYqJCQl8pSn/AUX/V54mfax4dx
	pGnp7tmQq9opwLV78EVAuxPCxZ1ELEXeB20AjQw
X-Google-Smtp-Source: AGHT+IHWSa2pxogmAjLn4ztZ7lXOL+pciVNMc0qrTWBm6LBemZwhR6GFKMyJ+Auwkat1s1tonK5xvvgLfZZNcAP1yjI=
X-Received: by 2002:ad4:5e87:0:b0:722:2165:116f with SMTP id
 6a1803df08f44-78ecf8eb86fmr5890196d6.8.1758095213891; Wed, 17 Sep 2025
 00:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <3061cc46c1910bdc4f66855db7a07d313b37fb27.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <3061cc46c1910bdc4f66855db7a07d313b37fb27.1758071798.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Sep 2025 03:46:42 -0400
X-Gm-Features: AS18NWCehyKTsWyAaNnobxSekVGzq9632HB97_tZFv7m7OvJvaqvGy9BzKN_2XI
Message-ID: <CAPig+cSz3PxY23Z4Vioo+5zhi2hniocUHTmjLZw7tNgvjkuXDQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] make: merge reftable lib into libgit.a
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:17=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> make: merge reftable lib into libgit.a
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---

Same comment as previous patch... please extend the commit message to
explain why this change is desirable.
