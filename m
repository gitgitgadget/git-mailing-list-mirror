Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883D3A1E7F
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699991; cv=none; b=dBwaD9agHtSeTo4t1nBUc2zKWAU9OzJXWEf4bsxJk+yt3rHwYyCtPduB7nzcZtYFgoFyKUbUqwHp9HC7dpX4x61hP+GoxDS5FHjRHrD8NtYc95Qai8nJw5cvTZHeg2iVDIcHLQA00MN5TfqzFG6qgPXAMaqQyMhAzRBRuWSfa8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699991; c=relaxed/simple;
	bh=dV4UqLDT8UjUImpPUso/rceV5VfI3uxzj5TyREWNSwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8FDWCo7iNLGaCgIVnOskFssRUorDmdW2mQ4QyXUnUJVnqmSO1DK0gky84G4qJ1/CyPs4IXnW98F7qMqSBWo0gETogCrYqkD70wAZrgqeXIJPXc0cEwsjinRoMBqbjY7K8eAfh9p5twzntKn0DOj27/GmsLkcN/QNbBom+ziD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdWIcEo/; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdWIcEo/"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-559836d04f6so590310e0c.0
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 03:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699989; x=1768304789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV4UqLDT8UjUImpPUso/rceV5VfI3uxzj5TyREWNSwA=;
        b=UdWIcEo/10IdyK9QzZmXzxaK1JP3IbueqTrd5cF2Mnj2TwrwRqLJWdkfWdaZSrMH6D
         STC8VxalXAe5ySAFbTQ5+/5apn9v3f+0zeU8zkhBeTBN15+8m44e3+JIElbG94wsSre3
         jWSY4E1CTpxPD6TmCKEofirzDKyZvI9CLYWc51h7FgfgH1CWbf4RsF6D09TG1VeSNz8i
         Bkv8i7P1PdNJEaAEdt/znx75DotWpRcgx5zhslCrTYwzyKaCfJBJmAxHoLdUZcU1GicF
         G/BOMy1dfe7XYJ1gxe2IH0XmlaAUM81q4zWA3kEHOvtJ5uv04iTpK9fEvo3WNcJPLTLj
         g9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699989; x=1768304789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dV4UqLDT8UjUImpPUso/rceV5VfI3uxzj5TyREWNSwA=;
        b=stVUxxKd71nYhOA6UFY0QWujdUa6Ik1quxdBTIGq8tl0o2jkyDDM71Dql5yUUgD2Ca
         zmK0aSNxRG82Ng40xv6MSdLBAw//O0W4zV39OuM0+Z47Bi/cbJqrLMf/obDS2UiMgeCu
         KVaUaxK5yH15wQknlLso7MJGUstalVXb7rjDqyXlDZZtXTt0oGaEMrE9lNW4UHBVuk8t
         Wd8ZMh9LqYkeAXtrmbbT5/mmKLxpoeqNJVo9LOhHPWD+0p78gea0jF220L9gWV2c95Vr
         H+lAyFyzuGuTxxpiS81QdBxR31iXngv3D/P+WyIpujV2pAURlmVxmP8uCi4XStuXepfp
         LILA==
X-Gm-Message-State: AOJu0YyJRj0hG5Su5e2oRngc44hER6W1wyzlZKRT0GZWvu3DhYhkRMjX
	CszbEIcrEUimyhYKRwnbW3a7ay4kFiwvIuIn3fS9lZXRbQx/8ht7sPG8BoZJcvd3U2Y1m05OYaj
	zyB3cOWUlkdwiWCWKgvrL5DtFmLtnnTY=
X-Gm-Gg: AY/fxX6kT5GVLjU0eE+ypWSOWg+nNoCz0Rw7RsHqQHMWheniCvRt3LovgW8habdn9wB
	tVlob/G7xT/THhfDs6rfiNnicHbkIOqqXz+j1kuiR5mFy9gl89+ntnLTq0msOXfLhM8fmHZPvwm
	DvPfK8gU8UNUN9eaCFdnXam49aXBG8lVTyU7f8u6nqM0tM15fQZv116gLyWFksgwuV5sx8zXnSx
	u5xpZG6ri1AA2/BlDhVSa8m6c7Vceawx8wFhoPV5FmsQHU/HAD5xJPuX0GfoIYZzd0pkdE=
X-Google-Smtp-Source: AGHT+IGT5eNboPv6bgwJ6+N5gxhngoYTgK392K3VgctroKdeApOXVun8bEbEnK3CDImxz6v5fR7elY9NxDtV+SOIKMU=
X-Received: by 2002:a05:6122:3309:b0:55b:9c1a:7c04 with SMTP id
 71dfb90a1353d-5633948f017mr749121e0c.8.1767699989054; Tue, 06 Jan 2026
 03:46:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aVzsltM5imOSvW2G@Adekunles-MacBook-Air.local> <dae478ce-d5ba-4649-a6ab-61be29321131@app.fastmail.com>
In-Reply-To: <dae478ce-d5ba-4649-a6ab-61be29321131@app.fastmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Tue, 6 Jan 2026 12:46:31 +0100
X-Gm-Features: AQt7F2pGwtWq36DjL_c-YJmwCjkmPC0r4fGc5nVQPEc4pR5tBIDDdse4SQ-atKc
Message-ID: <CADYq+fYLoarsgHWZsxBZoijRCdTzYm0VOZ1MFmVX5901akVpYw@mail.gmail.com>
Subject: Re: [GSoC PATCH v5] add -p: show user's hunk decision when selecting hunks
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 12:09=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Tue, Jan 6, 2026, at 12:05, Abraham Samuel Adekunle wrote:
> > When a user is interactively deciding which hunks to use or skip for
> > staging, unstaging, stashing etc, there is no way to know the
> > decision previously chosen for a hunk when navigating through the
> > previous and next hunks using K/J respectively.
> >
> > Improve the UI to explicitly show if a user has previously decided to
> > use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
> > This will improve clarity when and aid the navigation process for the
> > user.
> >
> > Reported-by: Reported-by: Junio C Hamano <gitster@pobox.com>
>
> This is doubled again like it was in the first version.

Ah!!
I'm sorry about this
I will fix it now.

Thanks
Abraham
