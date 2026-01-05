Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD062D3ECA
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767641226; cv=none; b=hszEZs874/wVl2vW1uNxds5Dy7dk6hoznTZUXhXR9LgL5QWrozut3+ZLoMMSCngwPPt3+tFJbmLwZSzezaB6Q/Mk6SYvRY2bjhh9XBNqKEB56JrpFRqAhquwDr4W9jgSFB8YlZOYGB6fnEJpG9HiZwfysEDfwj9ihyXCP13yhM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767641226; c=relaxed/simple;
	bh=/ngDB5h4auTNXqmk090hYjtGvOLRl9JSuQWZ9nXWylE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKhQQyZCAAgogdKLOCfy5NtPBb3+dVVUOHJmadd2U551f3vq87DtypenLlKZNnrZqIfEbgqB/XkSD313uST9U++cve4UCtzdQIx5Fx0bTq0OBTHWEOIKRRRBmYRlNC7ByRbmdLMQCAdsrVvOCDRlTdQ7J07b1N47NWEqbX5ipTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqAjl5kf; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqAjl5kf"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-55b4dafb425so1348766e0c.1
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 11:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767641221; x=1768246021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ngDB5h4auTNXqmk090hYjtGvOLRl9JSuQWZ9nXWylE=;
        b=LqAjl5kf3KTTwamJfp6/F/Gin46T4AHA8XTjTkT35kkqhR5dLrKiJ/o32Wxcyg1bX2
         m93np2tHyXpeR+kA0SgcY235a1I5KD5spDpok1lTVaLCeoqnQwSdHq/rQ0EUuAdYWEwK
         IUeJPXMWWl6Hxmnl8FUg5yaxB/6d9y5mVxwJ89MG3LK+2EpSmMcAQJVQqEAGb8IgkdDB
         +X1beqFBMBzB+ajo7G/gKR7gQbF9YAkbHfMSakNJfbvo0CR+tTIbV1wUvzE5xi7OWFKK
         vXtW5og6gCmpa65dRCxO3i2Gj/mRYc5QpC692Al/gPJjtEiMR/cwlsovdSsNioQYyys8
         ixyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767641221; x=1768246021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ngDB5h4auTNXqmk090hYjtGvOLRl9JSuQWZ9nXWylE=;
        b=eyaq58RVrgaKqCg9ukhqCUhQ+1Z9txvBftsfybUJNOLsz1NxM2HYaIPrFCSJI3ATBh
         KBN5YhEWefJ186mZuJZvsUPIu5MgHWvPpNefblyQVt7VanC+F6kvo/G2ZRaC27jiRwOL
         jB4JpBQxkUCiy+YT/M8z14+k7KOQV3WV2CpYqbveZ0bdmkKNdnee0gNorgDlCOr2FSli
         nvgGpfrwTTlYW816u3oBW8nty2DIImjo27i08Y1tnCywJqb3rKR0941A13FtfHSff5hg
         t1smcV1uBE96mEpdH6itvSAq92iZB9zJAMeYXC/NKB9fVarACQkR1JdmxF6GKHPB8IFB
         yVVw==
X-Gm-Message-State: AOJu0YwpZIsNHsBu7N3I5PhT8g+Zo87RhtWCySO+6lyn1gl/qVl+fMoz
	Z0NbVEsaPN2LLS0++p8J/XI5LiUqXZeJd9PSjiXcSIthFw4iG8Vya6WV2vF2ROdcUvOXG8MQvfy
	fh8paYJOj5GpFoBIvgcxFJ4eh1eJRgjeTFA==
X-Gm-Gg: AY/fxX4p3itxO6TnVF0AFd2CEvcFwh6Gjzr5HdNj8OkHmcZa5nQuT83qfMtugkDwxmX
	5qNpvWs9f7Do/Rrd0G0uJ0VqeDtYeyZgwpPr5JKDtMAJVmTwMuILIioku+7e74gAaq4HR+yMtuT
	8I/L+1qPqem6dg/tPCBWb5U+FQEKv18U9DTufhPfAVay49N/xo3ujGd2tkb+uOl9tcgVV1vX2Qs
	AQ430Ak7qkLvN1pifvsOVxowVpAsWMMBQqCbLkM+wKwFxhqzHQsauQoYAkfVTBO6bXwCF6Lypr7
	xWlEF6D6WNcuQwYckplB3YuL7RxmlAo2B8BJRioVf0KPCTcvz+fmp0l+vz+tw+T+v0pe646VULq
	ihQTEOZVbJ/RCqg==
X-Google-Smtp-Source: AGHT+IELm/vpiyDw7Qblinw69kv6Fh+9sKpLai3byr8OrsGQPsScGzT73ZrlxFJiCZPxJ78ezTdz8E5Dl/qadCJlYMY=
X-Received: by 2002:a05:6122:f07:b0:55b:9bef:2530 with SMTP id
 71dfb90a1353d-56339e86247mr74954e0c.6.1767641219820; Mon, 05 Jan 2026
 11:26:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANG6c1XhaL1poT2Myo2sy4xbu86vAXO0xQKe33vg7pERmx=TbA@mail.gmail.com>
 <1ee133df-2bb0-4aaa-b628-e7e2655d4332@app.fastmail.com>
In-Reply-To: <1ee133df-2bb0-4aaa-b628-e7e2655d4332@app.fastmail.com>
From: Wayne Rowcliffe <wrowclif@gmail.com>
Date: Mon, 5 Jan 2026 13:26:49 -0600
X-Gm-Features: AQt7F2rcsnXmHKQ_RZpB1q6v9RxUolzxpteknD46qjnM7xBpGpKSoNGHJrmMXa0
Message-ID: <CANG6c1V18xUEHbvTysykPT6A5LfV4wQSRQuEXi2XVDs+q_Cv7w@mail.gmail.com>
Subject: Re: I still use git whatchanged
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

`git log --raw` looks to do what I need. Thanks.

On Mon, Jan 5, 2026 at 1:23=E2=80=AFPM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Mon, Jan 5, 2026, at 19:05, Wayne Rowcliffe wrote:
> > I tried using git whatchanged, which I use probably daily, and it said
> > I needed to send you an email that I use it.
> >
> > It's very handy for figuring out what files changed in a commit.
>
> This command is being removed because it was supplanted by git-log(1) a
> long while ago. Both commands use the same machinery, just with
> different defaults.
>
> You can replace it with `git log` in this way:
>
> =E2=80=A2 Given: `git whatchanged <opts>`
> =E2=80=A2 Replace with: `git log <opts> --no-merges --raw`
>
> Additionally for the sake of readability, you might have more
> use for `--stat` or `--name-only` rather than `--raw` if you are only
> reading the output (not feding the output to another program).
