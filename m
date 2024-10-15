Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049F1B6CEF
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022495; cv=none; b=Rm5tzAOywlfDKLiAKglg+EYTj2anXNtF0dqY1OVjFpD+E/WU9o2LzT1jIwSeCU6IRxqx2FM8hrJUhjtEZcqAHa1XLVRjZ0rmvREejptzY51H/dW8X5yMzzETzs0CaZurfnzAjK15AoxEX4SgtiBm435daOQB2VjLkKfdGwTjk24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022495; c=relaxed/simple;
	bh=M0FrEClETyIl/PyuvkUnGV6vYH8gxr3Hv9LimDnvjuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsfCzrPDG6q1AFIjoPSJ88gsnb7BVpLPUvXMjQn9p0LTnVTwfzEQJlYMAnqxKd8SzLlxT2RTPj4w7/CFvOkKgdsgy+rCTTkkHRd9Sx4GDKEtF0RaSlxgNszkkhEuWdXJVbesyFothiS1ssYbapXCGe0MgP0Tx6IPAERM3vKxdA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbf6b2e6caso7214406d6.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 13:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729022492; x=1729627292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7F4k0DWklt23kxwaOzUHIYfrVVVXW2jmttBj5LWVAo=;
        b=LzCk6Dh47yyoyStpSGXJlCgyfbmchI0i7pARfRTe3FxzhFXtpibNjf0f7Zy1+T7CnP
         SE63pXTDPmyiZl2iqyjO/GVoEMQZJtTFr3ziuov61HfXTUL1kpZdTWuB9vgsaX3JuMUl
         izx1L/AP1S/tnbYaVADBT2RpA2AHor21jftkw9aRDxnvvYLJ316nfbWfZbRm8kxJjN0k
         Abszu4ORRdLZ7b6iT3cl3fCh7kN2ORKO9cIX1CB9sMdbboQww/jI2+zhblHwFTiZGUi2
         Epqdex7Qx16O2mXbwbtkpVYKhV376wlKZtIx8E/VjKV40yUtbbVJcetrM5WOSB0uzh7V
         LkNA==
X-Forwarded-Encrypted: i=1; AJvYcCXRJcpLevQ4BX3Dw8MEeooRZQ2xGFnrRshxf04LbUDlhOj+OpJt/i8of/x63utXTWPVOK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwGHU7d3PMYlJH9CrzcmxtI7ReLwZ5y3jQOQVcDsq95DRRuIe
	RY6Aufp34cneUxbUI5N7JssyqBchIqBJgtN0pauTsdgHRPOoZx9JK0Cb0zF3oIAXZ+Qno1wQ9Ch
	8RirMBiFG6qZNWyLh1br+HoP/tob0IO9T
X-Google-Smtp-Source: AGHT+IFjHwbQ6FN0BpAG2BBXlvv+//WYb8G5TiOx/yT3w3NXMYL3rLuXYmk2fqn5j/KUu+2V3Qne9WLykkBCNel5XDg=
X-Received: by 2002:a05:6214:170a:b0:6cb:f0f2:f56d with SMTP id
 6a1803df08f44-6cbf0f2f6dbmr102426986d6.4.1729022492165; Tue, 15 Oct 2024
 13:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL2+Miudq0UXAb=R24v+ftZVkHy2We1CFsFAt__tCYMWtCfOow@mail.gmail.com>
 <Zw2K5xJAOGWitfXr@nand.local> <CAPig+cQZoO8tMZ1Gip-at8-9n_tk4axctkX=WbaO1==JRru39A@mail.gmail.com>
 <CAL2+MivOu=_HYg+2KoMKMUtz+=q2jv-K9u9Zxrhe3OuHLCmwFA@mail.gmail.com>
In-Reply-To: <CAL2+MivOu=_HYg+2KoMKMUtz+=q2jv-K9u9Zxrhe3OuHLCmwFA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 15 Oct 2024 16:01:21 -0400
Message-ID: <CAPig+cQ6=HDD447xTHQ84hmsF3SMbC5nH_PXf3rZWvTWmp18ug@mail.gmail.com>
Subject: Re: git rebase exec make -C in worktree confuses repo root dir
To: David Moberg <kaddkaka@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 2:55=E2=80=AFPM David Moberg <kaddkaka@gmail.com> w=
rote:
> Den tis 15 okt. 2024 kl 09:11 skrev Eric Sunshine <sunshine@sunshineco.co=
m>:
> > This looks like unintentional behavior; probably a bug. It seems to be
> > triggered by `git rebase -i` setting GIT_DIR. Here's an even simpler
> > reproduction recipe:
> >
> >     % git init foo
> >     % cd foo
> >     % mkdir dir
> >     % echo foo >dir/file
> >     % git add dir/file
> >     % git commit -m foo
> >     % git worktree add ../bar
> >     % cd ../bar
> >     % git -C dir rev-parse --show-toplevel
> >     /.../bar
> >     % GIT_DIR=3D../../foo/.git/worktrees/bar \
> >         git -C dir rev-parse --show-toplevel
> >     /.../bar/dir
> >
> > The `git rev-parse --show-toplevel` invocation with GIT_DIR set is
> > incorrectly returning `/.../bar/dir` rather than `/.../bar`.
>
> Thanks, that is indeed a much smaller example and it seems to exhibit
> the same issue. Can we figure out how to fix it?

Someone is going to have to dig into the code, but my Git time is very
limited right now, so perhaps someone else can do the digging.

If you want an immediate workaround for the problem for your specific
use-case, you can probably unset GIT_DIR in your `exec` instruction.

(By the way, please avoid top-posting when you reply on this list;
instead, post inline as I did here.)
