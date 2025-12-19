Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D4432AAA9
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766156586; cv=none; b=sj2oFVfMIuLzwg1u8etNWQVVkikfv69nTRp33yO2IMFiZo7WS/iVCFWPtWUzfiO0VRXRdDzg7t/uNAjnLvgj+2aPrE29gD6a4g9m8+dmngqGB7w3CqHkeJURau6gmtOShu6UreBAdYKhKmFte1ZeGPLxY6GMXIxSdjx2NAYeQPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766156586; c=relaxed/simple;
	bh=CZhlJNNXIjuofr+hcna2bzs4SOhiLJ0lwm1hzA9+6UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKpFqoPpBMXt3fN7KCiksOC6yZ85OLHiU7EXavCVacRmSvlJPxEgDOosXSFN9t+OzCQXgNovbZbeBfRbcqHsqbtqJx3pPZZzX+P1xvE0vwjPfPD7DBFadoWK4DDQoWmHDQYiBlwVkuJCZk66bHiKm/jSfU5LFXOKyEdcihsxHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVMs88At; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVMs88At"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37b9728a353so23296011fa.0
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 07:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766156582; x=1766761382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY9Axv7MN4sql6Z8ggxWKLYeKqOGH7feR2jHJ8aHCWI=;
        b=DVMs88AtktBQy3yZBckDX51qaq6Yv8GD/A2JGcbC78Dv2e4RoRi0L7HTDVU9BhhFuV
         PxMqA+ExilQWhdTO4tRCwyQ+yxGwVLS2cteANCyHpFji6qjEWbyPHp8qkoAiaY1bvvq4
         UlUwqVnn1wRHHEQPIf8IJwPI+6luCYhvnc+wJhoNHh0nalB7PBSL/sL5kJuL3u9rrfc7
         ZUHTNIsEBaR5dEZ6PtfBOOgPiZoKaRRcyFInPXraEoOu6PJBAgb3cZI4NOQO9+1ZdOXO
         UFL0EYdhg6ym7g/MlwfA9gYT0tWF4Ql6Q1FPoiA7iKTALuddsb0DaQTyyQ8UhGhG1yhY
         5tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766156582; x=1766761382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RY9Axv7MN4sql6Z8ggxWKLYeKqOGH7feR2jHJ8aHCWI=;
        b=V9MRVPnhNwzPCF7ZL7JhBL0MaRpZb8pPf7Coy3GaJnwyRBDQ3/7lDgWpO4E/zcm/C/
         AytvEW/3pxriwZhQQpPF+G7uL0nWJlywj6I4KFbjnMJr/Skj38PZMwGvbR7C3Q/afqgs
         PN1m0aRs1kUTY2Tcqp3rM5BeSMW6NK81j9CnkbIwvnuAj+opfqbjMdqrrnCAhd5duaIw
         nMY/VsMALa0T29G8vIPemTha07YiSKnphaKRKKVOHVz3dy43Fav4xKV0r8gtB/dVhg3l
         n9/y0HkAVhDxfQWIMYGYN/D94xwyXJdF29PVHgGzmDuTLylFuikBgwaLfOONHLwGwwFq
         78nw==
X-Forwarded-Encrypted: i=1; AJvYcCXSMtcdTR2GiiieRcx7gjSjE5c6Coi2bwIkrZRdziO9YygsR233m77P+zoD/xBEHn5iiJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhjviCG9R4l6ejrg0tyr42dRztvW/L03Nx0DQJ3R4+JwBeZ/ez
	NfbUsgqKmgBQXoRSh96BHVsYVXYH66OZPaB5pMHpVKypGpcGhbq7ZV6Bl884tOHedbQ3jo9/c/S
	8HraCr4y9hMx/dwa+FXK0rWPsmaTxxQA=
X-Gm-Gg: AY/fxX52s1cBzviHot/FF3NP66wunndPeHtxX3yXgoyAZcjfh3R6C76kd/DzfGy8GVa
	+prcYcaF+5oQGpWCdnwq66cXL+g/OePkl24KIUgAZWuEIv3LjR6+/wEVQsMX9FN3bJTfhcOZxph
	b4A8QISvLzLkOFI8+7cekLqsQbf7OqNU/uFMFL+gQ8IlLw2LVhc3hZodB2BxlngqWqn6l9yem6G
	qZPoU7jmKVl9YviDG6si/zCGRgYIg3QSLOSz6HRA8+j1EXHRmJrKKWieyv9UXxMkZa14mt4
X-Google-Smtp-Source: AGHT+IFL0hki9gGXSrCmhwt21t9SfK+nAVU5r8Eam2Lhy8RTCpCaw5mOLZkM1qwwRl+28KdKN0x2TePzUVLG49/ldVY=
X-Received: by 2002:a05:651c:241:b0:37a:3189:e7b9 with SMTP id
 38308e7fff4ca-3812158e5b2mr9166161fa.16.1766156581780; Fri, 19 Dec 2025
 07:03:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPx1GvdNQbHY0avQ_Gt4bkLiuNHPW80E0v1vxrwyQYDD=zpc0g@mail.gmail.com>
 <20251219145447.22234-1-haraldnordgren@gmail.com>
In-Reply-To: <20251219145447.22234-1-haraldnordgren@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Fri, 19 Dec 2025 07:02:50 -0800
X-Gm-Features: AQt7F2olSFgkh-hGiLxHxLthWQ0yNJ1LhNW7t-E13i3gjY4erUznBlhdyhMVgtY
Message-ID: <CAPx1Gvcc6P08F=HiqWOMcWjGtv1TsqeS3aR=GtzVxpMBzorqFw@mail.gmail.com>
Subject: Re: [PATCH] diff: add --no-indicators option
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: collin.funk1@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com, 
	phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 6:54=E2=80=AFAM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
> Hi Chris!
>
> Thanks for the idea, but that doesn't seem fast at all =F0=9F=98=85

It's terrifically easy to script. Instead of:

    git show $rev -- $path

you need:

    git show ${rev}^:$path >$path.old
    git show ${rev}:$path >$path.new

which in sh/bash is (you can fancy this up some):

    rev=3D$(git rev-parse "$1") || exit
    path=3D$2

followed by the two "git show" commands. Using ${rev}^ gets
you the raw hash ID of the specified revision followed by the
caret / hat suffix, which means "parent of the given rev", so
all you need to specify to the mini-script is the same rev you'd
pass to "git show" and the path name.

(I don't need this often enough to bother with the script,
I just type in the commands.)

Chris
