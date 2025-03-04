Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1727296D6D
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108129; cv=none; b=dcrF8LFjZ9m6z6GHqvWaSh4Y2X7wG8vt3BunM7oLgDbxI39yR8dnYSBDlhoENf3k+lVF/tc+mWMV6yP5RF0kJAqMhTeNg11+43IDYd1Ywk0GwQjE2+HwTbpQqAsc/Qu9NOY2U6ij3+Zjmaiv0Zw4yrr6gHXAHFsoR6WYKgqQzyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108129; c=relaxed/simple;
	bh=VBOq5yawOwoi/Kohfho+K/m3J1v3FkmEngml3YQq4FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nneuL/h8rrDBNwxRnwPcgb6GcPy6w7lpnlj/DpauszVQSd8TPSkEppR819VtQpkqkfBHWLS4DjB08505eOrF/mCj2nEZk/5uUlWtzUuir6qBCbJwGDdqJFQeO5COSMzxAhSqp66viPLzPBrqBUuz5UVhtYGYAStnQqni9ZWd9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8a1a92bb3so5557606d6.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 09:08:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741108126; x=1741712926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBOq5yawOwoi/Kohfho+K/m3J1v3FkmEngml3YQq4FM=;
        b=SR447rExSM9cx+xyA1B+l59CwMtnpLJ9dM2l9rU8UgZ5emO9HYMypVlweILaoSJvMw
         +HQKFR1DLfXGa8yGlKBxO2dP/34/nzcg96HHkgUkUVWuN3NwcoAETPTOSqO9hvcAVTNA
         1B/DvYAbD7vlUd2JDJUPVojFGNtB4wWMdapCXdlVpe5zVEEdNWKeOJguRGQTYwdi9Ir5
         szf1msBIAJiYzbIk7bjmlypXho9Ab57foLJ5KplRb7EyMw3Pipb/7ZUu18CYr8QTJ0V4
         AtD7a9+qLrcWrBZHYAA0TNTn5GoBElik780cdxBk0G4hQDDAym4QfUsLPCMjlX6RV6OF
         AZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCWq+Ki/AoElrzegD39aT9D6qLOOw/d7E4+vPwOo4QG2UaN9ubjj96E7LqOY1XwBhP3k72o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0xzBlYM8SC7vLQP6SYEu3gfNI+blBuKvHlQOz7g7IhTjprVsF
	DFzt2M7ru9yDDbGuBl/IsgVcLZoMgrb3TMkmYX9CLvfbFRn/t5K5b5N3uccCR6Tk2+nKqJd2mAk
	e8Om8LiWzeqbRB5w57ys5+cSdcM4464ej
X-Gm-Gg: ASbGncssp5LsmPENktxgSguHo7vgCouTq4WLRzJbNUZG9L2TBgIZA2oBAsv+aECHQSa
	BUNSl5Q31mUGgdA1OquKnLfvXjI7r4F/b+nY2MPDZ15UQ56+X4vgtDJ7ZH2zPlpt8TzZsvcrUAG
	i2Yfl+WpWkUW/cS4dgvN1FV4w6g3ugkfZAUSPSwDUBG5keNvdNPz2TxCSgTBo=
X-Google-Smtp-Source: AGHT+IFl4r9qU1I4rQKn8HM3UAFWqFyVnqbqip7D0WrkKOt5DMqqT92CbDDtLKv47urbgUlEeYB83leGe00eqUUWKXk=
X-Received: by 2002:ad4:5bc4:0:b0:6e8:9c91:227a with SMTP id
 6a1803df08f44-6e8e6c8cbf8mr443786d6.0.1741108125583; Tue, 04 Mar 2025
 09:08:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPeA_SNEbXMJnz=-qAjNoJZFWxW1fV0yQFsZYzW9VcwEUOSjA@mail.gmail.com>
 <CAPSxiM9JE_cKRSMec0t8m3Ev-xx9Pdk6_D7QqLodXJiU=_eGpg@mail.gmail.com>
In-Reply-To: <CAPSxiM9JE_cKRSMec0t8m3Ev-xx9Pdk6_D7QqLodXJiU=_eGpg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 4 Mar 2025 12:08:34 -0500
X-Gm-Features: AQ5f1JpLYoHALX9ElCFg7-q46eFuo3oGwuqBELq3rf0AG8YylcgnHzfs9wOmm0Y
Message-ID: <CAPig+cS8MJ3BjEb+iy+d9sk3YLUGPR3s7mr15J0-QpyygG0MfQ@mail.gmail.com>
Subject: Re: [GSoC] Introduction and dev environment setup help
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Hisham Hasan <hishhasanstudent@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:01=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> On Tue, Mar 4, 2025 at 3:12=E2=80=AFPM Hisham Hasan <hishhasanstudent@gma=
il.com> wrote:
> > To begin with, before I start working on a microproject, is it
> > possible for me to contribute to an even smaller task (A
> > nanoproject!?) that pertains mainly to something like a minor
> > refactoring issue. This is mainly to ease myself into the codebase,
> > meet with members of the community, and gain a better understanding of
> > my capabilities here. If this option is not suitable and it is more
> > preferable to start with a microproject, that's perfectly fine as
> > well.
>
> I do not think there is a nano project discussed in related to Git docs. =
But,
> I supposed you mean easier and more friendly. task
>
> Actually, If you check the microproject, some of them are actually easy a=
nd
> friendly.

In fact, what Hisham wrote above ("ease [...] into the codebase, meet
with [...] community", etc.) is exactly the purpose of the
microproject, so what Hisham is calling a "nanoproject" *is* what has
already been called a "microproject".

More importantly, the microprojects list exists merely to suggest some
possibilities for newcomers who might otherwise have difficulty coming
up with their own idea for a small change to the project; applicants
need not restrict themselves only to ideas suggested by the list. If
Hisham has his own idea for such a change, then that serves the same
purpose and would be equally applicable.
