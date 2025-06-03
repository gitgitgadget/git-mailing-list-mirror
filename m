Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B9227E80
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967666; cv=none; b=lohh2LqWGnBcX7mUKSscMC8d602kXE5kj4gW8upr88Eo1/lirPMEG2f+4heyW547XTh0qqpBxOTQN1akcBjUozYEuVEtFOmJ5vKy0IvCT/Mvq7ORaLNrda3/x814VWAHZ3lyBup9j6EITSxQ3ltxOuYqTQqnWdyqQQrzOi+phLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967666; c=relaxed/simple;
	bh=qu1xGI7PXH8AF5CKlaWj5F9t9zOm+oCaaj6inEtaNFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQSjw24n+Ymq2xI3HVFAgdOjLTfVRvlmUjIuGN2x6LOWajqC2zks9rZBWN8yC4chuevhjdPB5sidhxL86a4o6JeX2P8hTwMUK7/bG7VPjMRl0P5KiYKhGEY2FafqzYuRiu0RDQtyOteI8hpbouBFo8jVOkEcuQPdf9xPpMFHidA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTx4w5Dy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTx4w5Dy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2350b1b9129so34329775ad.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748967664; x=1749572464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jyL2g/HEMuCHeG5afX31tsHlrww/ziocNsx7zXsP4uk=;
        b=ZTx4w5DyupTiix6Marl9IMOqae91nm7nx67UcQmWbavtRHx8M3rXaFSqwXu7f2RPMT
         GwAZVqZ2n7TAA40lq0raev5yVfEWN68eHnkQjyTW+v8DJsQlLLQX8z7UZlitpePtsH+I
         Zf2N81vJNBdRGzAzskI1FWTcgpc+q74GQ0LyoIrfUKjvxn0saD+mI9f61ZCJS9iUPkRi
         hsTxawPZ/aifRxj7t2pOALcb9WPY3CVbwz/sI6zxi7JKF/k31KO1YIMo2HkN5laMA7Sp
         4oVXiZnIA6N7sBj5/aSuDmHhZtPO8j3ZR+V+EbRgMggHykNOHarYDF0xdcHMWKk6X0cU
         QifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748967664; x=1749572464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyL2g/HEMuCHeG5afX31tsHlrww/ziocNsx7zXsP4uk=;
        b=UkysbMZ2rLaUu8Hhgg4LMBYlFXV0RcYc9ibQFYyEiz0hAaDP1k4CNHHEcmM06hGD/5
         flkfT6GG+RRxs7rtHjk6RRfv1dJLpU33FOTYR14VtzJbohx+ZI0fI0i//iAzJQKm/HN3
         wGVBGJiR+8k6U5guDkYQN1eiXGshjBRJcF7YAg2EitrKjxXBj/B53f6YJ2gAUqtefJxx
         0NIxAOY1isJbGbDd0FOmJbKnDzLwND8HrNcAz45c5dgTQdTKYaBXB1atZKFYlActAoMO
         GP2Xp1KWl+CgNyFRFv6UwfboFLg6E6l7cgD7GzE+7MHwgnmQuGouxjy1Ost3HDPBG+fD
         skMQ==
X-Gm-Message-State: AOJu0YyFLiD53hF71MajmJCSj2hvIfNg+rdcj71kgyif/RtOzyvU0yo5
	p+U/hNC6D8slCocaPiut5d+5lNEaTc8XXMcmLIqxHVuJpI9m2Cv7pMgHH50ZJxcNq/NrEKJGht4
	CS9J7DejbIWQYRwM0HiaeLSBtOefRL2s=
X-Gm-Gg: ASbGncuL2eltFtq/BmO0yccoKkpM7TPUc1Va8LxDHLHkVkXXlk72VYleeXiDhyuXfif
	0QIiy5biDQ+IoRWpSbxlhxdwJKRFxvyO/hqcCnmvzbSBCRPbstkBgJVT6o1XUxvojgvfLFPvvqJ
	LzgHgL7xsS8oS6bFUBl/TZA7xh/itKoOIw7camOuGjUVfuHIgqcIwCnyvHLfXypfLjLGA=
X-Google-Smtp-Source: AGHT+IEns2Ug+Q/GHIbMBWa6AxcnbkLyGcJwZuyMt4s25ELPBQn1N95jT8hu8NxlOjaJYNbLx09Ua0S/JFTZ4w5HaLs=
X-Received: by 2002:a17:903:b88:b0:235:60e:36ee with SMTP id
 d9443c01a7336-235396b5e00mr232130865ad.39.1748967664225; Tue, 03 Jun 2025
 09:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603131806.14915-1-ayu.chandekar@gmail.com> <aD77fz3N-fLI8DjM@pks.im>
In-Reply-To: <aD77fz3N-fLI8DjM@pks.im>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Tue, 3 Jun 2025 21:50:53 +0530
X-Gm-Features: AX0GCFtDxsnW5-4HW9HECqsiWO3_1l7_82WWJT4vTTaNPVXlgvlQKaBb46DV7M4
Message-ID: <CAE7as+Y0hzkPUC-q7dd-eSJVi0H_nwzQL1AGZJnKMyYcrX1dLw@mail.gmail.com>
Subject: Re: [GSOC PATCH] environment: move access to "core.sparsecheckout"
 into repo_settings
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"

> The config is called "core.sparseCheckout", so why is the variable
> called `core_apply_sparse_checkout`? `core_sparse_checkout` I would've
> understood, but where does "apply" come from? Also, for brevity I think
> we could just call it `settings.sparse_checkout`.
>
Yes, I had this thought as well that adding "apply" doesn't make a lot of sense.
But I thought since the global variable has this name for a long time, there
must have been some reason. I can change the name if the "apply" doesn't hold
any value.

>
> > +{
> > +     return repo->settings.core_apply_sparse_checkout;
> > +}
> > +
> > +void repo_settings_set_apply_sparse_checkout(struct repository *repo, int value)
> > +{
> > +     repo->settings.core_apply_sparse_checkout = value;
> > +}
>
> Getters and setters only really help in the case where they actually
> provide a benefit. These don't though, so it's dubious whether we should
> have them.
>
> Also, shouldn't these functions call `prepare_repo_settings()`?
> Otherwise we cannot guarantee that those settings have already been
> parsed at all. And for the setter it could happen that the settings get
> overwritten by the next caller of `prepare_repo_settings()`.
>

Oh, yeah, you're right. So, if we use `prepare_repo_settings()` in
them, wouldn't
it be better to use getter and setter functions? Otherwise, I'd have to call
`prepare_repo_settings()` everywhere I'm using the setting.
