Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E5522DFB6
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041391; cv=none; b=tjDMetn5fOENrMWu5s7qQNZJr1Ry47UJZHDy88Zq1UQtIVsX0cdrFdYVI+43RRzdgucwne2pHxu/9Pc2Y6qUjbhfvO3Pazc4fvyKRqawZTLFdvp9KQk3k/IXBtRA22uYqWqwznt7dTOLRVAfQ88N3FtQ6tV22tIGuU3TKZMBU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041391; c=relaxed/simple;
	bh=z6/uLbqqD5EDQOkZSmt2NQNAIv2OiHTdebJR/wFsOKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gh+HUNs4S9+1TPZLyGejHYZSW1y4H0msxTw4Tczlp9SCmTvOiN3quLWLrCfdbPHbcfjl7yfWBACfUICWXb7lQus8tW5H6JlXJdrQ9Ydy6vqq/gx3QmwdYeDy2ycr7xErb/fpOOYBqZYocTlO1OTAjp1wE0tV3bTf6sbNY15h+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0a45032f1so22917385a.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 14:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741041388; x=1741646188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6/uLbqqD5EDQOkZSmt2NQNAIv2OiHTdebJR/wFsOKY=;
        b=J31xKsBXmEeEN2D2SJkCYtQZciAnoUIw1zxn9VsetiK1/3e2yItlVDmt38B7UACgq2
         Sb7OjJkTaVTq0CkSNPFU4SAsjfoH0hJGcNs9nl1SigZc2jjRaY1JzmD8XSAN8I3Zp6jr
         OnOz4dKdzKN6IHVcZs6nvNDccrE0YHdM/vHUe1gPnldxarW77/bZGf498+apE/IFut5r
         RXhCsS/YgLwju6mIRgOUxk52kpXxhSFQsXP/gNK3WhyG29JmT0zBECjMlchUkqboBcPs
         9ZvUrlrINXZd2TFxbiC6f+ZVXPRmZpL6fMogNBDvB25RXjD8iy3zkMtE5Bdm6fTy0L2Y
         6aCw==
X-Gm-Message-State: AOJu0Yx74D1ogcf0QZ/qdcOVA627AnpFJh98BBdUGnbAi4lKV/cn5BKz
	IN19kaJzGomMFJBLEDnoqOO6OhXKwg63WqLdyZ1cam/658m4DW+JXA0sKg3MoKPd4OYrUrm38Ke
	5gfIXyVcy7zqkcuW5CvAs1oAYHvg=
X-Gm-Gg: ASbGncvf6vltQ4JfMd7sefKR0hoMqeoIhhky57KX8EFp/M1p8T3/C0xLF2bKFwiwPiY
	nqCzleXJUHzNtM7oOUqiQh/Jd/Htb1EA5i5QFCSNxwDZgOw4OyU5CHxJWZ/txtgSu4voU8N3ifd
	hyloWzoWWqJWDfOwfl7ZadyejAPmALpZy9PCuPdSE/zXZ0mB8ZLQ+LeuLMogE=
X-Google-Smtp-Source: AGHT+IFuSWN4bLm6XUbxeZODC+AAq4RKIDJVF6uxbeSXzpYWV2ITMiZTnbBmObVk1jjpv46RFGfsvcmUgA7K7i9v5hU=
X-Received: by 2002:a05:620a:1a0e:b0:7c0:b8a3:20b0 with SMTP id
 af79cd13be357-7c39c4d1bd6mr813220885a.9.1741041388203; Mon, 03 Mar 2025
 14:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303220029.10716-1-lucasseikioshiro@gmail.com> <20250303220029.10716-3-lucasseikioshiro@gmail.com>
In-Reply-To: <20250303220029.10716-3-lucasseikioshiro@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 3 Mar 2025 17:36:17 -0500
X-Gm-Features: AQ5f1JrucZ9f59JRZeedjmyrIL0lPrSxHWNNe9H1TvyQNuKha619Jh1N3D66bM4
Message-ID: <CAPig+cTdNYDWzKgZsWadPiorZr-WB+53-ncPZC2nHTtzuPVp3g@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH 2/6] builtin/log: die if -k and
 --suject-extra-prefix are used together
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:01=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
> builtin/log: die if -k and --suject-extra-prefix are used together

s/suject/subject/

> When calling format-patch, -k keeps the commit title as the patch subject
> and can't be used with other options that depend on the existence of a
> prefix. This way, -k shouldn't also be used with --subject-extra-prefix,
> as it introduces an extra prefix.
>
> If -k and --subject-extra-prefix are used together, die.
>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
