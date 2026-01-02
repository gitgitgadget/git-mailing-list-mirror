Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C39E42A96
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767317081; cv=none; b=ZXXWsb0zDAsgRXuPZjrE3HHdYhVUE8nzIdnI7dQsKjJaoHlBr4KQZRLboYA60HBXTeehLKdV8jJXNSD69mkU1eOgLPX0+eky/UeIVq5lCP4148bwI5o0kOFaLYRM2lD7JsRzWST32/RxVHhir/W653xsh6YckYtPj/38TOrc/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767317081; c=relaxed/simple;
	bh=EBnP/oaox2tsYdls8ZW5KUGokwCvG+AnnsLqwYL1oGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p77n1rZtBGU/gaoQG7PMbOLO82/3G5zfTZD59dmRVNeqQ2l+kDwGMqWyASvJ1kQlRL92WQUs5hCauUcN7LwjN8l89G5puDXZ6IegPfjIQfpXsKtJXrQJskEu4jQagJcdYnMSqLAe4Ck8zFY7eAtQCBOzOlyZmNA8k3VugAeT+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=paultarjan-com.20230601.gappssmtp.com header.i=@paultarjan-com.20230601.gappssmtp.com header.b=0ErciuAK; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paultarjan-com.20230601.gappssmtp.com header.i=@paultarjan-com.20230601.gappssmtp.com header.b="0ErciuAK"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-646d9eb45afso308969d50.2
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 17:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paultarjan-com.20230601.gappssmtp.com; s=20230601; t=1767317078; x=1767921878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBnP/oaox2tsYdls8ZW5KUGokwCvG+AnnsLqwYL1oGY=;
        b=0ErciuAKroe0yPpbUcVkO59nqDd7Jva5DcA2Ii3nNWHFSEcVbybIrk0C+ia7Lz3kva
         vih5r9581sIf7OFB9lrsRXsq73tO55u3ZvlZlIBd1ioMmhcOggc2K/y4sE6cwTjdy4/n
         598GDfeGWScjnrrKiTJBjYAbOLtubGIRJY/nDaliwnxbECJoNFs23j4jX8ljTDqFexvM
         JE4RBG2qgPvZhljHclFOOrNgSTWNy2Oq8zRzvdAUauJd5RNJBNn/9/PI378BZQ2a+ZWT
         lp4aXraRDe2v9HSD11+OykRRD8kh6UmoofOhLPUur89AxYGgROg8iGGUq3lNDayWYZAt
         s9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767317078; x=1767921878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EBnP/oaox2tsYdls8ZW5KUGokwCvG+AnnsLqwYL1oGY=;
        b=uMPhO2td1ZbmU71dJxBCZZ9jgPhzOk9xJxd96/0v0N4ZdeTDQ9lq4vHYcsGOKioekd
         yH7EIDiGgzc/KnSiMbOGcS1HWmoEG0cB8hb5GTU3QvIBoo1pQ2E4ywy6xe61ZtCjo4Bk
         rlWNDrrWZhMTQwUx2vtKVdUicx4lsfPm1I80DltWrxZU3sQRIcRvgaXZgjjGFeZ329Cs
         VZyVtP1+sqIyhtc9DyzgYvGDOBYH6Hg88VvPpCOwG97ZDmYJNePoB5qmgBSsC3e7wd0/
         AIaw6D5ut2rcTR+CS5ZzkW5ktFu5De2SKq+BGv+UoOOCzhaOiuZX3ZAUmn7rVbioED6f
         3raw==
X-Forwarded-Encrypted: i=1; AJvYcCVdwujfiEc5RwAy6DSYGBjR5BvVhy0czqbF4g26SYIGlLrzyHg0gUh33nP2lta9hqjXS9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzBAXck5MUyVeUBrA4KFekeyuDW7H3yV/M9x0pc1EnZFKlJ9oS
	EaWEaxW/VgssazsFeV/CS7Fbxb/YxOZeqpm3JbnnTymCvaR13Ila6GfXUqdQ/AZlL8Dyyjqt3ju
	ph3roF1pR7nsEQQQ0a0+vM7EUgq5IxM8=
X-Gm-Gg: AY/fxX6l127Ac4s1Z61xG28Yay48QWwy0JQErldZnTomXPbrPRzA+NKA6x5N7AqnSkY
	TA3xRtEADjqG7+Eo0KGstcwAackOD63LxdF4Jc23CJMV1KSkB4KqzqgDodP/Qimv9Zr6fMJ0SoA
	Lxfp1h7F15v3m+EtV1zin6k+NPfkH/geuF7SGURZ7V7JQ7DcgNMfWQ1tmruPAVznb4nD/I59lvN
	Mvh9QK89KpNKUfsKNddV1XwoHRiOoYf99OW+UrlolFlCEMM2mcAD6aPp6Lq1dBIlFNu5Yb6wvOe
	LSBPhSzsNDidfe5UH3K/Xo7hkzw=
X-Google-Smtp-Source: AGHT+IGwOLT1bOAb4jUWsZjCuNtz5JWTbob1L/ji6B1QTgjBigqXpqemXwTB6zVH1VTYwgOlx5rTPHkq34uPJ0LXE0w=
X-Received: by 2002:a05:690e:169e:b0:640:fabf:565d with SMTP id
 956f58d0204a3-6466a87e489mr31724084d50.43.1767317078511; Thu, 01 Jan 2026
 17:24:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2148.git.git.1767098576384.gitgitgadget@gmail.com>
 <pull.2148.v2.git.git.1767191943962.gitgitgadget@gmail.com> <xmqqbjjdc4d0.fsf@gitster.g>
In-Reply-To: <xmqqbjjdc4d0.fsf@gitster.g>
From: Paul Tarjan <paul@paultarjan.com>
Date: Thu, 1 Jan 2026 15:24:27 -1000
X-Gm-Features: AQt7F2pjkUUr2nunVvrk-RkCZer6sVJq7STeGwVVk0-n0ANmqHu8GSmkWk6IS9M
Message-ID: <CALvWuB6MW8g3Vd1-gKkZa_r86o0-t3gGazLSvsoBO4m6jjubeQ@mail.gmail.com>
Subject: Re: [PATCH v2] fsmonitor: fix khash memory leak in do_handle_client
To: Junio C Hamano <gitster@pobox.com>
Cc: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Paul Tarjan <github@paulisageek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 1:14=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Paul Tarjan <github@paulisageek.com>
> >
> > The do_handle_client() function allocates a khash table to de-duplicate
> > pathnames when responding to client requests. However, kh_release_str()
> > was used instead of kh_destroy_str(). The release function only frees
> > internal arrays (flags, keys, vals) but not the struct itself, which is
> > allocated by kh_init_str() via xcalloc. This caused a 40-byte leak per
> > client request.
> >
> > Fix by using kh_destroy_str() which properly frees both internal arrays
> > and the struct itself. Also move the cleanup to the cleanup section and
> > initialize shown to NULL so that kh_destroy_str() is safe to call on al=
l
> > exit paths.
> >
> > Signed-off-by: Paul Tarjan <github@paulisageek.com>
> > ---
>
> This is already in v4 of the other larger fsmonitor-linux patch,
> right?

Correct. I sent it separately since it is currently a bug in existing
code and you might want to merge it sooner.

>
> Thanks.
>
