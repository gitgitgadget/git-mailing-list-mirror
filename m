Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F11823AC
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325134; cv=none; b=kKll7g0o4gCp6hOEKbZQI9JUvBAitkYFw6jiLGcZAzO25mJ1N/uk0/pSQDlxs2gdJGN2/JmTaNMZMRady8a3jsjaYKDhODDaiNzahDzjOzRtHq/pmWM9SOWBf3tiCKwNvsmnf9gxa+Z1gnVdgmDdYeSnNruVVWvO2xKlZxRTRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325134; c=relaxed/simple;
	bh=8R+eLT5K6+Dgl++MnpXORB7pQxjmTFIa9S5frWtC8sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JK/wdRdL9HPu8VuCUHOoknpvMmyH84OQqBM7GNHSdI1m3878ldJYtWpZpIlzw+KpkymBBrUKuB2GTZZBnwbFiCX/kX/qUkFKCx/D/YPkOV4L9TJDlZvZD2i6JlrowvSArlUNPv8Ix8oqbeRr5QkjxaOJTScPE/71MZITSQAgtKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6818f3cf00aso5329546d6.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 08:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707325131; x=1707929931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orHOJvFo+vqmjfs9YsSEp2Hhl83wSdouqO/Mc6SeSVo=;
        b=AvXJkTjVhfzF/cpTLHRZRuKj+xXoZHNRuNiQ+ju3plGba7FwQ1sjinEa8yJ5bN7g1X
         t7IdDZZDaP7FVGnoG42Ex0wZnK+aMHRXmcagLACUdQR96T3dymltTMTLJGt+2eqdayz+
         alMR5XjKp5hKbOavDJGJWoDPulS9k+LJshVHTKAPiQrqkVm6xHh8y6YwbbcDxWFlVhkl
         jyx36AboCZnIHLXnhH4Ogu5XGENKvZPy+Pnl7IHpYR7XjCsEGJ9s/7Uxq4CGPCzHYBS9
         ELIXF+fnLpbao/hdYYie9Q0e3tqim9DhZXw4dkpUN25tU2GyAZDg/sHxH0+j6VJ+UfJZ
         eIMQ==
X-Gm-Message-State: AOJu0YxOlTGiy7gq0LM0dENXyvsZCmeot5D2IoS5t2foWM+JKp7q3g7v
	OBp83lUo+nbxeZRTLK0Yi5RUy8yZzEegi4tlPcjKawJbGRGbZ/LCo1wqetpUCm0wn/KWIcxWoUW
	+UWEcfTMuhzXZZ9j2Mjl6fmwI/AU=
X-Google-Smtp-Source: AGHT+IHgsSA5FIpD+GNjDgopfV7Xyk4e+aXbJm+2dqY8/aM1XN4gzJLKbZoO+gVNboXT4/EBHmM+iZLv2CADU9UztSU=
X-Received: by 2002:a05:6214:e67:b0:68c:92f8:f146 with SMTP id
 jz7-20020a0562140e6700b0068c92f8f146mr5711796qvb.60.1707325131380; Wed, 07
 Feb 2024 08:58:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203112619.979239-2-shyamthakkar001@gmail.com>
 <20240206225122.1095766-7-shyamthakkar001@gmail.com> <8baa44ef-4960-4f0d-8cab-38d3d6ff971a@gmail.com>
 <df1fc65f-8716-47bb-b379-1e1f1eeece8b@gmail.com>
In-Reply-To: <df1fc65f-8716-47bb-b379-1e1f1eeece8b@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 7 Feb 2024 11:58:40 -0500
Message-ID: <CAPig+cT4gY_Smhvxs9AHTZVDWaLTtCABNaTDFsR3ukJx_pYJGg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] add -p tests: remove Perl prerequisite
To: phillip.wood@dunelm.org.uk
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org, gitster@pobox.com, 
	ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 8:51=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
> On 07/02/2024 10:50, Phillip Wood wrote:
> > On 06/02/2024 22:50, Ghanshyam Thakkar wrote:
> >  > The Perl version of the add -i/-p commands has been removed since
> >  > 20b813d (add: remove "add.interactive.useBuiltin" & Perl "git
> >  > add--interactive", 2023-02-07)
> >  >
> >  > Therefore, Perl prerequisite in t2071-restore-patch and
> >  > t7105-reset-patch is not necessary.
> >
> > Thanks for adding this patch. If you do re-roll I've just noticed that
> > one of the tests in t7106-reset-unborn-branch.sh and another in
> > t2024-checkout-dwim.sh still have PERL prerequisites as well. I don't
> > think it is worth re-rolling just for that as we can clean them up
> > separately if needed.
>
> I didn't cast my net wide enough when I was grepping earlier,
> t7514-commit-patch.sh and t3904-stash-patch.sh also have unnecessary
> PERL prerequisites

Additionally, patch [2/3] drops a PERL prerequisite when it moves an
existing test into a loop, but the removal of the prerequisite is not
mentioned in the commit message. Presumably, the relocation-into-loop
and prerequisite-removal should have been done separately (in patches
[2/3] and [3/3], respectively), and that's how I'd suggest doing it.
