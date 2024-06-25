Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC11448E5
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336853; cv=none; b=OY3QD60UCdUeOQ+Zry0x4F3+W3wiM0kXj0vIZni1D4jdpnsIUbPT5DqXhVZO1N0tB7c3VJYXxGJKX+MYv1w898ygHsaYxCTiffliuUhrbFfDiPJ7Wlpb1oBDr6ZBQ444uCT/XvRJ89wyKBuPpmVP8StZeA1g4iDJYAZuCmDXqBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336853; c=relaxed/simple;
	bh=OQ0/o2lx64Bx9wD9pr+PuJHhlKjudXavDCmek7Vre2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdFku5IxGN2cipjtlk/42QSmfNJXpZLAzQ9zSPJQnEwjF5nMrIZBlyxVkeVJ+Mf9B//od4ne+96KMTmIARwTMz1+NU71UPIJlIEZZ0IM2xGt9r1diCiN1NAoTRojTkn0BcSlMVs9YIafTKnFdx/itrAuBlb7CyX04byZ6D5lxPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G251pAJs; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G251pAJs"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-376211b3a4fso19938415ab.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719336851; x=1719941651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLbFmZbkFOptBM/gCawRcV3x2Qf4VuabEvEa2enjLzw=;
        b=G251pAJs0dC7TQF17kxYMgVDY1fBU1wjOWRkUvymCHTD6qAjmw60TtRcLSsJRE6rAG
         8f15hSWpc60GWO//3ptVapqKFsz8BlFyOW4dPWwrD/DQTqUP6dX9R/4VLL9hi+yJttLx
         no8OXwBJiC9mLLKffHshY+59HZ18Zru9pkkyyjMH2m9WHMSOkhBeOzFPF1Y5m9KAgTVS
         6g/yWnbKb8cefjoFeu3UtkpGPgTszK7qLn5dyEMHgBCoCMmKH06HJQQA4AeN5EAS8kmJ
         RgAd1fBAu1qnI3vIANlhqFsU6KCNLS/D8jWoMz4e2+vWc8f1s+HHE+zv4UNsyMKiTOUX
         nA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336851; x=1719941651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLbFmZbkFOptBM/gCawRcV3x2Qf4VuabEvEa2enjLzw=;
        b=TacY1i+rY3ARTlaFaRZxGzvsMuWXyCLngRDOyDEhg534ukUO5HighDgz6JsIz2FP0F
         t9IGQ4g3W4flfWEw4X4vpjk43a5DrGkwKPbqlUR8YlIrzFudQOPsBAbfxlaWFPGyWopF
         UJAnynOc/t7GsuZO4w62vjGkGbT8MgXP6cpNfs4onD93FD87na8jGm8zZ+ZAPKedjlBt
         2/O+M9V/niJ/prp0oIKhjiDmHr14E3IAVnO0BAVeTcgk9YaTXKuqovq+S2qPjR2eNWs9
         U5H1IGFzfpPlkSopMHQING/ETur/Zw4W9+otmi/MR7A0KW/M2j6RN5XY9ETI5pidaV1+
         lKew==
X-Forwarded-Encrypted: i=1; AJvYcCUuDAZMQfcCWDNoM7dowZLZjCSi9CAEW9aHgAseXAJ7y0w1Tb4CAKKwxhB+/dvVPW+Y/NMqhSM3cBUw8P1ltDujE8mg
X-Gm-Message-State: AOJu0YyX0HTKbGRk9SovWt3Vfy1RB2bm0HNBw8sspHV4oLUNJrZt8+Q4
	QaiOdtD4Dab54PxTEpL6ARj7ucONHQMefelLjySTQi8Wx5W0KAJHfINnBJ+umrGIOJC2l+jGWYY
	PZ8gbFQaVRlIZxJCbATCBmoiPPHsDxQ==
X-Google-Smtp-Source: AGHT+IFQvjpuuw1DgGp9tZDHdT3nSBTCbgtQDRJat4yIeaLcaA5C/XQ8fJdhnDItL4c2ZFwsAn46zFOnogfLTc+OnFA=
X-Received: by 2002:a05:6e02:1845:b0:376:2a41:5f42 with SMTP id
 e9e14a558f8ab-37639f690f6mr57124005ab.10.1719336851487; Tue, 25 Jun 2024
 10:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614102439.GA222287@coredump.intra.peff.net> <20240614103005.GF222445@coredump.intra.peff.net>
In-Reply-To: <20240614103005.GF222445@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Jun 2024 10:34:00 -0700
Message-ID: <CABPp-BHeBj=vcOMaVAw61YcERyGrDSX8TVXQJn+xNTW12HpcAg@mail.gmail.com>
Subject: Re: [PATCH 06/11] config: document remote.*.url/pushurl interaction
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:43=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> The documentation for these keys gives a very terse definition and
> points you to the fetch/push manpages. But from reading those pages it
> was not at all obvious to me that:
>
>   - these are keys that can be defined multiple times with meaningful
>     behavior (especially remote.*.url)
>
>   - the way that pushurl overrides url (the git-push page does mention
>     that "pushurl defaults to url", but it is not immediately clear what
>     a multi-valued url would do in that situation).
>
> Let's try to summarize the current behavior.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/config/remote.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/remote.txt b/Documentation/config/remot=
e.txt
> index 0678b4bcfe..eef0bf4f62 100644
> --- a/Documentation/config/remote.txt
> +++ b/Documentation/config/remote.txt
> @@ -5,10 +5,16 @@ remote.pushDefault::
>
>  remote.<name>.url::
>         The URL of a remote repository.  See linkgit:git-fetch[1] or
> -       linkgit:git-push[1].
> +       linkgit:git-push[1]. A configured remote can have multiple URLs;
> +       in this case the first is used for fetching, and all are used
> +       for pushing (assuming no `remote.<name>.pushurl` is defined).
>
>  remote.<name>.pushurl::
>         The push URL of a remote repository.  See linkgit:git-push[1].
> +       If a `pushurl` option is present in a configured remote, it
> +       is used for pushing instead of `remote.<name>.url`. A configured
> +       remote can have multiple push URLs; in this case a push goes to
> +       all of them.
>
>  remote.<name>.proxy::
>         For remotes that require curl (http, https and ftp), the URL to
> --
> 2.45.2.937.g0bcb3c087a

I was unaware of these facts prior to reading this series, and I've
read the documentation multiple times and occasionally even glanced at
nearby code.  So, definitely a welcome documentation addition.
