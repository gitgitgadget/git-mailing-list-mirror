Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC401DF24F
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242532; cv=none; b=VsBFpscmATqJXjP/KZrhmTLOa4BskIQ0GNeddX1LBX/w53oBYI7JITdbg+zoDXaE0bqJHFuQOEUpvy/23YRXGY/yJbVbEsCiFSZdVQ9lRxicDD7zoloZpaCpdQLhHiZh54wKOGwNLFh7Ky9dJZoorahJShNYqjQqkD63qeoUF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242532; c=relaxed/simple;
	bh=HhtkG3uBI8SzDJdxwI4PZTa7Pua+7mEMYncEDUYzNlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+cgxCSb7WeetLplGhFpvgJzVsqH12GmkHDQoz4GnsbhVr8QWSVf2mUOEVRNcu01cWanK00XeJz5W5j8NdM1CBVHTnHdphJksHNQYNym2c8san3p6rZkJA6FyuFPRvY90rQdCkI5wUqhK3aBgZKIBinRCGV6ymgkYB9MaGd5FGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERlSMWXd; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERlSMWXd"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3515a0bca13so29298931fa.1
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 17:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758242528; x=1758847328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdLLhSg574CrKxVKAG2iUeajP656yF+ZO/PxO7o/f4E=;
        b=ERlSMWXdWphkp0dd0GGTvca2tCAG1hQ+mtan7H3G96bRUEHqhZLaeTfL59JVXFpxRF
         caL2jFWy7xV8wPWMeTWGQ3tNVCyKGSvSdNXP7z/JwJRaasfx0V+0pfRnc1wE1j8qVUBS
         eQmDNF68zo177gQ+RvGoXA9Uh5VPUCBFfv0grfFfw7zq8prkki1KC0Ika52IVXbaJkhN
         nQSqkTkYRF2OHmLfGg02Ls/xaEzL6Pean2iGUYAf9Ttu21ZmDb+L+xyqeCCPtPrwQPRK
         E8hrvA5gTv0gDV4FOV4X8UxYdPzwTjNrNrb1w7MT4z+8tq5zN576BGQZSnbBQaYtVa3y
         Dv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758242528; x=1758847328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdLLhSg574CrKxVKAG2iUeajP656yF+ZO/PxO7o/f4E=;
        b=ctBDFmg0JyAf85dONCR8l9KRpILn2FLcJCF9UPofa81JAvxbVEK909RMOUGSZCVvIc
         3tW9kmFYz2xnlkuid5Hus4q3DBTY6ZbSZvXR0KUtLlB1z0PhaJHIFdcUOlYwmTh/W3Uu
         A3MSILEELqIzvigI+Fvo5InMxOBN6J5eKberOMOD6Kb0eYfeekzuNe3Ec1N02t2/UHI8
         p71pCSZ9A8bjW2iSccxm7kBcH4CE9LYcMNcDdQRj6mJBK7nGdHDcQIxRZG+GZr0EzNB7
         zXbK+TDCXr47AhiRu422/QmOUPARbmfL0Iq8l6KKC8EfstZR+YNXZ1nNIj7cfuA6OD9O
         O4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgNjzcfsPjheyWt7j06oClKUKHGpxiSzUp7sFcC0V/LMkw8cwdqstlVgA+6yYOOj3h7to=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQf1YPoqx/6+fcHhxAdXpeds8NdYV3FuncOnarTeojyrFYt2wS
	2bC0Z9sbkhzVurdRPN3s3CrY2zJExlPpDw6PaEh6ztfRwFVO7UC6ZnAJ2VAe4NG2jhrc5cfZnMz
	udluDxn14DUoq/Q5PRY8jxX4vk7RmVe4=
X-Gm-Gg: ASbGncsyvOnEB/GZleNzokoIX0m6ix3HH7yPo2AiFdr+rO+pKSaool8NPp6j9FZieUd
	CI4uXKl1/rPL+F3LSHI+Rv3u0bbaL+cvM4kQBK++R7NlD13hgs/HnVx9YWgKMKp4rKHEFrg+IF/
	uE1zENK9/WjOMhUi815zZd1YRWGLABAszF75mXlVxB+ghFNWrmou0RvS1qDkrCKnAeo40BtbzNL
	B16BVzm8zqGKK70YIIUGjqoHjw=
X-Google-Smtp-Source: AGHT+IGZ/XJgKj11Cll194+3GJSyMh2p/B0wmVkf0Ixb0OK1dZt2wg55jeANj75l47s7AcXe1UXIgBxHWMm2yANYsVY=
X-Received: by 2002:a05:651c:254c:20b0:337:e5fc:d27 with SMTP id
 38308e7fff4ca-3640783dae7mr4480721fa.4.1758242527586; Thu, 18 Sep 2025
 17:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
 <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com> <xmqqa52r702e.fsf@gitster.g>
In-Reply-To: <xmqqa52r702e.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 18 Sep 2025 18:41:56 -0600
X-Gm-Features: AS18NWA1imd_gZKGOS6jWpaKJUDWbqb3K2S1lSyH4CjCFcAvYCSe7T1Z4MrzH9U
Message-ID: <CAH=ZcbBfzcd33SD2f2GLmwSN2MHic7zG0cVBqO_9kfPsBRR=BA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Use rust types in xdiff.
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> This is probably stale.  If the patch numbering is to be trusted, we
> are missing [09/10] (at least we haven't seen it in the list archive
> 30 minutes after the other messages in the series landed there), so
> the "clean up xdiff" stage consists of 10 patches, and this cover
> letter does not need to talk about "Patches 10-17" (yet).
>
> Will see if lore.kernel.org catches up in the morning and process
> them.  Thanks for working on the topic.

You're welcome. There are exactly 10 patches. Once this gets merged
into 'next' I can post part 2 under a different patch series. Part 2
uses [ui]int(8|16|32|64)_t and s?size_t everywhere.
