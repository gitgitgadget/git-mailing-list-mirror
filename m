Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6398B481B3
	for <git@vger.kernel.org>; Sat, 15 Jun 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718469184; cv=none; b=SLJ0SYtmgRyMOIfYInGcOlpIieWpWCqFCXqWs/Y2Z1VSFDzyNBTt22zdpTUGoLxxKXVPUHUFjTxUfzBpL0GRM1YZXTZlS/dZOxFnewvDv9Ui8ebyEKNnFzQvWAqOlu13lHCJvpqt5gJ+YkMWB42IjZ1eFpDTAOP3z4EmcvFbrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718469184; c=relaxed/simple;
	bh=OYN6nEfKvgkQNxbwJf2U3Vt649abKSCb8aCNPOhDR/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buWP3S8CtOFdx5v5P64oWYiLUzNIwBdMdtEkJv0IfZExjITTxrBIkckqwjRAsoJGyT3BsXIVmCYNwL3bm5po5KoHVN5S9EEJx7sSS6PymBEqGh9/gzCEA0kGJJBerDA2Cz7zv1NigBb0qE+SQbQNM48nOQHpAuud8IRgCwsbb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4415e623653so30983141cf.1
        for <git@vger.kernel.org>; Sat, 15 Jun 2024 09:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718469181; x=1719073981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtGGvKfn/4BB9x/avge4Y6zNMeF+Dwzk9lhB1ag5OGI=;
        b=N/rcwh+cNZ6Ycf2+uMLMZH+zXkQ8oLpxuLdZkHEmCKfaIB1nxCxOj17/GkPzqnyh6p
         aqiuG3Ug3Z5ctKuj+FiMi6PvjlhqJbwWKmyzGCm0ztd0JouOV/idEzxJN2BaqOThb2wQ
         PySGuGf2LVHK2p49ygbA5yvhJgluofQV/oOsMe3Re/AAr6zRTUQgWvv2kVmg59NkXQT6
         rjGvQMBXB6JZhe8vj5uy26OFomEUmjk0T3GXVeQzbh1QkAKd7XmSUN12KZUv+8g92a2a
         pm0Ymjzdhp4VlKYwzIRCaAnrwqzFrOFV8NaRz7DebVIoZkRfLKlnZYM217QEaxhHLIY+
         Ogag==
X-Gm-Message-State: AOJu0Yz+0YLcvmyck+MQgbPtplwRnApuC+ACAPa0EBMHDuexA9mOnukD
	YsMbb+pugbF0GUcItDaFgMdSG+4dbq0E404K/EXOsmGlotIYen+XfMs6LR/ZPHyfW6P4h/BKwH2
	DnoZtbMXLKZE/m59ssI0aM1tKNAU=
X-Google-Smtp-Source: AGHT+IHWS0yV9fDbbpwAepdGfcNXUkAJNsWc/JxWdvlwh2VjBjYEPR/wKM8v9ISJL/KWS2ljzPKywBgdDohyTrikoHI=
X-Received: by 2002:ad4:5f87:0:b0:6b0:72ac:b306 with SMTP id
 6a1803df08f44-6b2a33a9d16mr159703886d6.1.1718469181311; Sat, 15 Jun 2024
 09:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615085345.47278-1-serg.partizan@gmail.com>
In-Reply-To: <20240615085345.47278-1-serg.partizan@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 15 Jun 2024 12:32:49 -0400
Message-ID: <CAPig+cSRkAFu8hnCDT_Fcih9kpiJXsmHZLTdAEdHYjS94wntYA@mail.gmail.com>
Subject: Re: [PATCH] Fix default font scaling
To: Serhii Tereshchenko <serg.partizan@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 4:54=E2=80=AFAM Serhii Tereshchenko
<serg.partizan@gmail.com> wrote:
> This fixes font scaling for default fonts, where we don't set font
> sizes explicitly.
>
> Without this, on 4k monitor with text-scaling-factor configured in Gnome,
> labels, buttons and settings are using very small font sizes. (Probably,
> not just Gnome but anything that sets custom DPI).
>
> Signed-off-by: Serhii Tereshchenko <serg.partizan@gmail.com>
> ---

I'm adding Johannes Sixt <j6t@kdbg.org>, the new git-gui
maintainer[*], to the Cc: list.

[*]: https://lore.kernel.org/git/0241021e-0b17-4031-ad9f-8abe8e0c0097@kdbg.=
org/

> diff --git a/git-gui.sh b/git-gui.sh
> @@ -810,6 +810,16 @@ if {[is_Windows]} {
> +# For whatever reason, Tk does not apply font scaling to default fonts,
> +# but applies font scaling when setting size explicitly.
> +# Default -size 10 is still 10, when you look at it with `font actual ..=
.`,
> +# but explicitl -size 10 becomes 10 * scale factor.

s/explicitl/explicit/

> +# So, we need to configure fonts to use their default font sizes, but sc=
aled.
> +foreach font_name [font names] {
> +       font configure $font_name -size [font actual $font_name -size]
> +}
