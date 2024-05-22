Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6414295
	for <git@vger.kernel.org>; Wed, 22 May 2024 03:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716348597; cv=none; b=dMlCqATocJ00q4egHN/5hyyjOfzc6G0GC3YOopnVTZT5JXVXYuJh0SeNnVeAc+IXRogD+9EO0HMbYdIFU10pjsWDWvYx64pD2+nyl0Mftf4C92EaW/nCfwZJQbutoR03VGOXQCiK6AO4YU9j1yiNrTzn/i/i9AeQpgsE2lVsT+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716348597; c=relaxed/simple;
	bh=KcDTRFc50cK81Su4b1AJOXxvtGyxpSymxpBCANrQTcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoKat7kAJu8Z7Cy/Zp6gXMVxoXf4pSSQJB0bInCg/0okpGJ/CyAj6rMYncYH+NZ9fegysx0HVcIGZDBsh3W++pBYun1YPYIUVM/zM+hO4MGPBDn4m/7xQEwT8wH4yyDTnHPiTzVzxNm+vVLCqKVCE2MC/63ehaxGUbKn/s0tmMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7f15c0296d9so1633069241.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 20:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716348594; x=1716953394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qY49a7JK9kw7lqK0dZHYMC/oZxw/kDOlqk5MYlxu5c=;
        b=WQAhfel5XBgb9MNUT/v9PsAz/axRCQZWv3k3unp86UtQATajdM3V3aRPFrzZgbsprB
         N/EIgC6dKe2jnTtQElVNYOnDMFVvJEIMkR8OJrH7YVQj1O7fGo+lQDxJKAof/eyGQOOF
         Vyfsz6nURwmS/fg8s8RFcRUT703RbvqvqIlmfTLmzW/87PUucLg3SsCbN7iWcioXMsq9
         KKXPDiIn6wnCwKcSathlnI8mRu5vvGh9r5rUr9diFHNHie9lKYoDk6Il/R4Xz3GM3VS8
         iBMQ+Nkyt+yrMnWoVa7U1Xu8nJLwcy+bZftp6U+Q7et458prpAMuQP+o5Undo7JjdUnG
         2irA==
X-Gm-Message-State: AOJu0YydkRafI9L+EfsOKuNHhNw31Yi+IqDfWRJaMr0EZ64muQAa78Wq
	CaTVoYDUq/lRhjYXZfDjJ46e6qmQeWUsw/t2KGxC493GlJ4/ULhPjem8ZNpJdKeLUZqeLKrgMpE
	rvK24uHhWDo9oVIYMXAeWpKOmiA8=
X-Google-Smtp-Source: AGHT+IEp/3ig1lbNUppnyl17Enmi3NdZPps8VfZ9Y0VDkZTnk/ECypnlLTJiv224OSBnim88hyFSqTwT6NKleJ71DCk=
X-Received: by 2002:a05:6102:c50:b0:47b:de3d:dda3 with SMTP id
 ada2fe7eead31-4890a2c5669mr675676137.20.1716348594599; Tue, 21 May 2024
 20:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522024133.1108005-1-iwienand@redhat.com>
In-Reply-To: <20240522024133.1108005-1-iwienand@redhat.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 21 May 2024 23:29:43 -0400
Message-ID: <CAPig+cSDZzwH5RLYXbUXvdePHUtrPDDEdapQakB22zBkO25kuw@mail.gmail.com>
Subject: Re: [PATCH] alias: document caveats and add trace of prepared command
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 10:42=E2=80=AFPM Ian Wienand <iwienand@redhat.com> =
wrote:
> [...]
> For a "split" alias, e.g. test =3D "!echo $*" you will see
>
>  $ GIT_TRACE=3D1 git test hello
>  11:00:45.959420 git.c:755               trace: exec: git-test hello
>  11:00:45.959737 run-command.c:657       trace: run_command: git-test hel=
lo
>  11:00:45.961424 run-command.c:657       trace: run_command: 'echo $*' he=
llo
>  11:00:45.961528 run-command.c:437       trace: prepare_cmd: /bin/sh -c '=
echo $* "$@"' 'echo $*' hello
>  hello hello
>
> which clearly shows you the appended "$@".  This can be very helpful
> when an alias is giving you an unexpected synatx error that is very

s/synatx/syntax/

> difficult figure out from only the run_command trace point,
> e.g. test =3D "!for i in 1 2 3; do echo $i; done"
> [...]
> Signed-off-by: Ian Wienand <iwienand@redhat.com>
