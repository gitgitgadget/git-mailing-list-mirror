Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF20B190688
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729336770; cv=none; b=YiEYjlKvpHXn0EVKdeT8C9H3SYpva9mXh5pdF7vRZT1ltBhTUU+tEU9jjEZ6TZ/VT1zZz8iEGfRvxmhV4oM/e+H6PnXNyVCvinJModPgjPHa742r8+pP3o6BpJ7U9d7lqhH2C5U0Ga5P5160YeXnQAE1IRawmpNqnQ7JtJZtNpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729336770; c=relaxed/simple;
	bh=Dcm/EljORpxx8fNGKaF7ahJgpKL6WVI+hW22Tfq6oK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mY9u9ndtPEYXc4c9QgN8RjyKgHU0RXixoqOD7SQyCDppEXAUuaT7dVL9CQqbxWKWTSeOk/FihnWbDWbXzQi6DPLHJq69k9IS9ozjpSk3iwOLSAokg09PNJ3UjTLFUvjanw9PwiJyeEG8LW5F0OZSqaeMvMB7Hg883iGwo/cHNK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLeO/h1t; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLeO/h1t"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4314f38d274so38237395e9.1
        for <git@vger.kernel.org>; Sat, 19 Oct 2024 04:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729336767; x=1729941567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+rUOmkfCwAqjuIC2pA6ZezKkxF7f0T+zm2uUxf96Zo=;
        b=OLeO/h1tvkQM/C49lUWHJDKiBJwpRsYknUfVMeycJjNgitPBsfFXiur2J0IQjT5s/c
         db1di3+XQ5vH/NMLhxuOxzXw/IM1wGeNDLNRcdB+cGEpAZYm7Za8NTfioTFMQs0i5p8o
         6pynuU32fNdwNcVrSXwPzLa3CmjgTqr4jr0OzKj5jV1HXSaZy4o7lJVN6QqNL/lU/zBg
         p1yDO5EjEG7PTjY4yAnxwtdTm0i+pX+R9lYNKnagRRtYJaC01A/6p7qJ5YmPnx/qPjYb
         X+aFXj1wBDmO2jiQmh2pbeq3TeQ36RDnFUQv0RCTNzI+iAO4dcABkg3Zd7om2BBX46ML
         pQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729336767; x=1729941567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+rUOmkfCwAqjuIC2pA6ZezKkxF7f0T+zm2uUxf96Zo=;
        b=WzJ2PGyc9/enD6LkiNksRM7/qCVw+/IlyNkhKvgK7ALhXP9gIzoDlUrxBUzCoD2B7V
         bOVQuQKxBfOSHIUUFTGKyc39UpM5+LG5GKo5X2PjTQgCEYNtn4UGREYXFj/hVEK7OiAP
         faHMB9ZkC6xolpfCEOcm7VCsyERPAto2m9+XIMbdBLJ1oRg6672E5Ch8AqV1bEGveSkH
         wmX90jxd9HaSOwtkUZqNkF7flxCJlq7y+2Bwbq9BpKD9VvgOxocYpfjzgDxx1yXYT3nq
         lCSI2R3w/KBFjrkRCGsjtFQhBDWOVA+kq7KsSCaonJoy5/FGet+C3RD1Zik48Gf9I1Md
         w/UA==
X-Forwarded-Encrypted: i=1; AJvYcCUQI2O0fpK9AYY6NdTzl+Ei4HAyEZujFId2nCcfIjygSrm74S2GLfCrk2ettlPjo8idASI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznzZACqrDXQM5WT2xCyUzqLUfEIOnc+Ku9ukknqDnhjQ2vnq/w
	paWow0Tf9KmALpjoYWG9zkq/EYc8VhFf9+Tp9iGr9sd6iSG3uxL0tIp5zgcBdh8Nh7hHstz/slp
	jQ2R4s5zhq90ApGz3H9VjFMBBdTE=
X-Google-Smtp-Source: AGHT+IHKK8Mn/bftuqo8yHKH5+E4XWWc/Cc0w4qhOtYC6YodI8FgGgDf+T+lLpm3dbKC3O8KaqwRym5LOamKYHoF0dQ=
X-Received: by 2002:a05:600c:4ed2:b0:431:52a3:d9d5 with SMTP id
 5b1f17b1804b1-4316158fd55mr54989745e9.0.1729336767137; Sat, 19 Oct 2024
 04:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1817.git.1729296853800.gitgitgadget@gmail.com> <5e41f019-f37f-4860-b672-78b85e24d9bf@app.fastmail.com>
In-Reply-To: <5e41f019-f37f-4860-b672-78b85e24d9bf@app.fastmail.com>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Sat, 19 Oct 2024 12:19:17 +0100
Message-ID: <CADYq+fauh0ZBzvtBDLvHGx-=VDu-E+Z0U8MB8iZQxY+siOrw2A@mail.gmail.com>
Subject: Re: [PATCH] notes: teach the -e option to edit messages in editor
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 11:28=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> Hi Samuel
>
> On Sat, Oct 19, 2024, at 02:14, Samuel Adekunle Abraham via GitGitGadget =
wrote:
> > From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> >
> > Notes can be added to a commit using the -m (message),
> > -C (copy a note from a blob object) or
> > -F (read the note from a file) options.
> > When these options are used, Git does not open an editor,
> > it simply takes the content provided via these options and
> > attaches it to the commit as a note.
>
> Thanks for this work.  I think part of the motivation here is to make
> git-notes(1) act more in line with the conventions from git-commit(1),
> which is always nice to see.
>
> It=E2=80=99s also useful in its own right.
>
> > Improve flexibility to fine-tune the note before finalizing it
> > by allowing the messages to be prefilled in the editor and editted
> > after the messages have been provided through -[mF].
>
> Here you explain how the end-user will benefit from this change.  Nice.
>
> It=E2=80=99s important to explain the background, what is being done, and=
 why it
> is being done.  And this commit message does all of that.

Hello Kristoffer,
Thank you very much for your response.
