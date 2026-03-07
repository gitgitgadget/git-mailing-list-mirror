Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F471B4257
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772849469; cv=pass; b=fRINvFqhjSFxAdhk3IMDxzXMJtjJKllkHLMZDrGHh+cgaJp3lsAsPho2ZDt5cZ2NqvhbD+mPK7mahKfJp00cA9vCMnIX7zF4XNqDloizwYewyVGheDsaJx7zzXHm9pVIcDhoma/N6F9tA6o3ghTxDTsixAJptbMdGZfjhkjrn0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772849469; c=relaxed/simple;
	bh=H1tB7pDZegGMwC+zWgHR1rB7iWMfHmxcQqhU+QAjN+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXuVuBpBsdr05FtuejRx2CvyRUwbYDDfkOrKXNPMeEmlT6vgCG3KGWo5uYzbV9CHgDhUP5ROHMLmswDBUpHOvcHyfHag9Ppj9XmhiE2a4GDErO5fa1e9lBl7mWXcsSPa1P+M/rhyWI8GcEq0vLN3WJUt5geW+B5yy13n1/BYWMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+MNe4dy; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+MNe4dy"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-463a0e14abfso7394173b6e.2
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 18:11:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772849467; cv=none;
        d=google.com; s=arc-20240605;
        b=LZ2ADPLJQOiRt9XmPfZRBuuFjZGdMh09ajuBbEXyH3wMPIB122CI3o9WtuMo7hpI40
         dBW82ltt1Le7UCgekkFoUceSk2OfPs63RGf4mPxcpY+WW8mdmTAZ/WYefXrplqVa+a3g
         v5pwn5YfJjBkBTmTdSwbO8gOMYTIFuYj55OAlgPZvAzA/62rvxF7YABOMRidXhQ9HD/6
         JtmxIUkkAuqGuKfZ+EnD+IRLwUq9DLJ6sq80htXhqrk/SV7cwYGM21q+oNPn9gJmP2Gy
         cfmWadZ0j0WhulGQQIUCr7aqnmnpuEwnitUcbFICdi9e0Wsmq2HbTn0Qb31o5UK9hEDe
         J/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xEwLrOxeVu3O2YfF6noEPVYgfIJqKaJLRz3FG4EV/SE=;
        fh=nEQCINaOrIBWSrSU5EHIEaVYek+yzp0G3HMogMBTnNA=;
        b=C3ezhMOHMtbkGdHJ0QdpBssBQ0TE62wpw323rqa+Gucy2nG3c5cvDb/5Gk657LJqCD
         4ikWYi4Iv1qnCKxMhexdvkg70BAw5j4wb5a/+2hZLiSRjkDvd66b+WKbPNc2AazVwrte
         oKxHrQRwBB6cUcTApFi9iL24LqAQVq/N1OOBhz9J8vomIcZRFmA1OL6ttkQIZM8jwDuC
         yWWvR+lEb8FBXdFZqrkKhnGrk9QpBZTw8gRyjCr0xdjDMYL1pUpvEv2CidBLLux5hUlv
         ks9J0vZcQlZVvV4SXMYLxPtW6prel80FdGU8paF7htMk3/vHUPX5kVr652aP56eh8aHH
         oTog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772849467; x=1773454267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEwLrOxeVu3O2YfF6noEPVYgfIJqKaJLRz3FG4EV/SE=;
        b=P+MNe4dytAwFX8kfEmz/OIgteADLmFBu6ZHjmMnl2uf9VHQOny6MoCkjG3PQ5myPuK
         VXElPFz4yByCmvKGUZuVCNH10T045jgRE4l7xOzL4BjMCOV5dQBkRY9y30C3NkMXU//z
         BxCGUKLbUgjcMpOHkH5mi5NW8CIaFNx94qE0M9eU66AuVUGjjV07arKVpYW0WzPb2kE+
         wTI5/zUklhFVEtnUSJbEDH00vA5yEcTVWvADx6KvxAt/0DhOdmPZSelgGMffEFnQf2Rk
         1R5FW4P7lM9Qz2jZ1PKvDjHMSFtIgW3OQYUeaj9S1lCL5Uy93uG9ZwdM8woxW4QnZSwr
         2+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772849467; x=1773454267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xEwLrOxeVu3O2YfF6noEPVYgfIJqKaJLRz3FG4EV/SE=;
        b=scQtDeiCANd37NCLBxnIriqObT/QSaqoboSXFyHTpfAWmsF2IvXdZh6XNSubH8PMrf
         WodpGNx10jj3d4hDJ3HRQEbvyz4gtdB/wBHDHYXJ8YihJOXSdiF18AxCDDk/xAmT7663
         98QA9iw/xmwVHnZqI9NYHUYUYXOWVrxKVXiROAgap0u+xt81BvUygokwyKQTov1YeBK6
         tFMwj5treO7ysuPliaAk4d6xa6UPLExv77YxpNqclfP7K7ziTTYIf7oBS5k8Vd2mlg7F
         vT6LXmUtjL08FnEXnNL86ysrSqllohUSbn9NClMAKVro03FgYBDTm7h3ByahDx++ZoNg
         0MTA==
X-Forwarded-Encrypted: i=1; AJvYcCXV4kzEaXeiL77PXLSOvmhPF5+K53aEngufpAtNRr0Y2LCyqDdEVsD5X9Mw8uGDAoVMe8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA/QbICYqExvypoGgrZgNF+h0v/bk/DoBwF39NSfAb9qn/Lgya
	G3W4BWt1tP9LKkgui+2eHsMv9+AWZ4s8oiriDC40ycGmZJHZmsNepRCplFRP0z014Ao9jWZUfYQ
	8e/ZdjQC4rdMV8s1zVAUEGfD7OLplx0Y=
X-Gm-Gg: ATEYQzz8AF3M/NcRVyLxGAp9t3OwZOs8ziFTnV8M1xM9YA626H36LTgJYWMS8B+PzC3
	jMzR9mAJim5ehqPX0LBVkwNQ/lk2OSHDyUStGBu0I9+eRnaj+84Sl/1AmYMXh1IjZ5TZEKPnGDd
	JpGn9UvlcpqH2r6xukrVDW2vA5AKGOaCFjRnrFTOGh1E/ZLD3jPSwQcNNytQm5RUxCzkfTdQ3bv
	RBH7vHZK+x7f6t6ZO10dvJ5ESLNSpzJB4KwrNNc2/A9Z8VcwdBGIXRcEMKG9W0UZ97pPvPRifzD
	dMU+wtIHbG10NIjbtfYrljT1Wkb+07F+leOkJscYhA==
X-Received: by 2002:a05:6808:1b26:b0:450:cdc3:7a0f with SMTP id
 5614622812f47-466dcb8b673mr2191807b6e.57.1772849467104; Fri, 06 Mar 2026
 18:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
 <xmqqcy1gv351.fsf@gitster.g> <CAC2QwmLnLqMcWc8az6pVzz0oEdY282Nq-Lun5OrHaqHUiVE_9w@mail.gmail.com>
 <xmqq8qc4v1fw.fsf@gitster.g>
In-Reply-To: <xmqq8qc4v1fw.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Fri, 6 Mar 2026 18:10:55 -0800
X-Gm-Features: AaiRm51SSbgRBeZS8z0ATgAVNCqGgiS3ceZMp30e5gjoqrqAeJsjRlloptjLJgs
Message-ID: <CAC2QwmJoQKVANqjkHmuLVgvGKrkvHaZ0woL76-Z=Knm0gvLk4Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] line-log: route -L output through the standard diff pipeline
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 6:05=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Michael Montalbo <mmontalbo@gmail.com> writes:
>
> >> >  * Non-patch diff formats (--raw, --numstat, --stat, etc.) remain
> >> >    unimplemented for -L.
> >>
> >> It would not hurt if these are omitted.
> >>
> >
> > Makes sense. I can omit in a follow-up.
>
> You are already omitting, no?  I took "remain unimplemented" to mean
> exactly that.  Mentioning that we are not adding support for them,
> like you did in the above sentence that I commented on, is a good
> thing to do, I think.

Ah got it, I confused myself. I thought this meant updating docs/code
to more explicitly disallow these options from interacting but this is
already the case.
