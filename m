Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549DA232369
	for <git@vger.kernel.org>; Fri,  9 May 2025 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805982; cv=none; b=aQ9omoJtA8C2Vo6j0DKdRpnhLfOBd04a0sy5bTbqPWaBwOzOdPYjjPiT3krVCHcLo7sDzmk+cQ40JmkG2Jsi9mLf6iJc0AxY6GNRGk2GX46+G8zInDJhpSopF4GqoA8sZGZoNmczrSJbuF7Ynq4HI4C+UZPZuuaElSdG+VECa8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805982; c=relaxed/simple;
	bh=Dt87ZwOUpPnCT1CJl1FESpPKt9QBO0tIJkrpV24Hkno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5lhW4qJN565dzuIqckunlWg68bz8VCxpsx/x0kN262OieZYTxUPNULQRl0LZRHjwiwmwPp5c6hbKGWZCl0bSxEQWmJL/mvgx8SOUFyNqelSnDSifD0/AZSO6KcE7oZDVfMExHaVhtcLg396xDhbTbXe+hYALcJHSIBLoOerN7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv2nos35; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv2nos35"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ace333d5f7bso389876366b.3
        for <git@vger.kernel.org>; Fri, 09 May 2025 08:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746805978; x=1747410778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt87ZwOUpPnCT1CJl1FESpPKt9QBO0tIJkrpV24Hkno=;
        b=Lv2nos35RzMhClIc9zzdXVCTEMv2QNWqE8heE+7z9eek4h0Qv0D1wDyUL52xFaujKR
         OW/y5qEiF1b4b/ffqYbkqsaFfX1IdJ5JpTkrV5eeji5/CtlArx2497iyF1M1i4cpz5ho
         JnFjKPeFI53uEBhBqoLmEbk+OgApkGHwKJdGGpnLED5rQVos7yNyYg1usSetPK3lgSus
         /Me7eVLX1Pxv1fwfvZDBGZXPbMxn5+2BXEtWBsaSeomLqsUywXDe4xa7q0zYYpYAnL1N
         wSUyuSZfLjS6u4LziCJOEkSJwiZBbOG5np7MIkUOVn7Gl0AfhowivsbXPxYmvdO20VB0
         cDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746805978; x=1747410778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dt87ZwOUpPnCT1CJl1FESpPKt9QBO0tIJkrpV24Hkno=;
        b=IWkQAqsoKWOxLTRd3mZgoSvOVkuJqi/gVuZeB/zFb8Qq3erTfrFRMI7GbZvKVUAOls
         YdSj/ULNHyfy1H2xG0Fk/zzP5bJXq/28JfP/ms/ScVu0ln2DRkQ1aMdjri66Gsyyenla
         l+BJU2tetrNvTSmVQdLZzt8l4iyPKl9p7HIbz16JipHI5Ab9WTmPCm8nSXGdNXvyxoMQ
         LFFYY13VUuP5YAKAj6eleVBhwCIvKM++rjnnQTffJjigaRrLqUzaU6NqnJGRneWtWty4
         8eCKQ7LrL8mHFYYOKO+PHxEXddmmJyXT1iIEGvL4LPH/L0rNsU+9D7epanvxv339EFt5
         htEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmsj4sSqftxRaIkAJLGNNj+2NZnDM4UJZzX7gGCKporigeoYUVvhTUs6FTiLvO4/s70lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrU9j9nFzPXsZZ5Y2l1eB6kQop6J2oJB2bgsGQbE5B3VIAakQr
	OxvyldOxCGhy6u1QtjmUG6OKR4nBEIO39z5WA5ZaZyjBRwCbmgifRdS3WVPHOptDPuaJFVuwsol
	MBRZ2PVLWb4p028WG8XINMS/Jqk8=
X-Gm-Gg: ASbGncuj7Tuuib3ud2UfwEScfp37rihn8okYICNl+JK7bE5TGbLYZmXR31b9nK05m9U
	yOmB06QA3RVRDneqSeHRZSczHvQq1hbc17NbcOP+MO3xlQ8fhdyH6G3zFJjrz1NLtpTCzPjp2hu
	9URwtRy35tAdwpKy6WVMDmEN+96qd6rl+Z0Gt9IWauhphmMWl5lH+wlZ8fEQdVTqzRnQ==
X-Google-Smtp-Source: AGHT+IE0zdo3YNtG109FD870NZcPRx/HsDq/v9qt8YPXirVcg5ukckaRe59ptoT1clOz4XEa0agL4HRVapGVf5TodQw=
X-Received: by 2002:a17:906:f296:b0:ad2:1f65:855f with SMTP id
 a640c23a62f3a-ad21f658715mr245809166b.12.1746805978297; Fri, 09 May 2025
 08:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC4O8c9OJQQn_22i0-bZUDtHoi+ti6aT6FwupnQBoBFg6BNK6w@mail.gmail.com>
 <50428492-8ece-426f-bfea-071b7bd2c374@kdbg.org>
In-Reply-To: <50428492-8ece-426f-bfea-071b7bd2c374@kdbg.org>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 9 May 2025 11:52:47 -0400
X-Gm-Features: AX0GCFuUwmswbc9zMpXHKOLnWWc46FALrjBgRDrEqv2tKCERIsJRZIGzC5NiD0Y
Message-ID: <CALnO6CDNPWWCWXvkpU0BUmaCzUfyZQhrtcxi1Nw_MBwVO6BKnQ@mail.gmail.com>
Subject: Re: easily use meld 3-pane view to review merge commits?
To: Johannes Sixt <j6t@kdbg.org>
Cc: Britton Kerin <britton.kerin@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 5:38=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrote:
> [=E2=80=A6]
> When merge conflicts are to be resolved, you have exactly 4 versions of
> a file to work with: base, ours, theirs, and the merge result. (Meld
> does not show the base and uses only 3 panes.) For this reason, it makes
> sense to have 3 panes in a merge tool, perhaps a forth for the merge
> base. That's it. You never need to have more than that.
>
> With a merge commit, you can have: the merge result, the first parent,
> and the second parent... and the third parent, the fourth parent, etc.
> You can have any number of versions to deal with.
>
> How does that fit into the picture? Can meld (or any other merge tool)
> have any number of panes and still work in a reasonable way? Why should
> 2-parent merge commits be special-cased?

Out of idle curiosity (with some Zsh shorthands):

for x (a b c d e); print -l 1 2 3 | shuf > $x'
vimdiff {a..e}

Turns out vimdiff can handle this and be reasonable, yep. Partly
because we can have arbitrarily many splits. It's still a bit
difficult to understand, though.

--=20
D. Ben Knoble
