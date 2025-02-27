Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1441B653C
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681324; cv=none; b=ZOaqw0bG8jbvzpq7WI/Tc2ikxUb/HhvocAf3XlhD0HwOuAaA40w9iXFUXR2TxkOY3DIv81bdsN4UWyKarZiDRIpDKfMmVW1YrDsHm4TIKcPB4ZHzwj3fdYVbOsR3M1+HvmQB7+u1X6quLdfNNdu2IcNG1aahCchwzwlovb4oUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681324; c=relaxed/simple;
	bh=WwZ4CHzbc22ehVfQeY4bb4swCObVrrjWS85MqXFlNLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6cpsi9YjfwvnXHpgzuBiUC4QXC+MHcCN0IOpnui33Qb1AGt434uetqKsj49F0h1RyMWbbFzO3ADAv6str08hNa0rXDqeLSLDd3zxxWSij5phWEY94/I+L8AqmbC+2eZiqfi/mrbWVEY4OEDwpQ+yiFQs/TaYUti6ffW0+ZI4oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e65ee08779so1683026d6.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 10:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740681321; x=1741286121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwZ4CHzbc22ehVfQeY4bb4swCObVrrjWS85MqXFlNLQ=;
        b=dnMAz9sUTDoOTBaYXb4B9FXQGzZTXAzimG19ghaW0YSP3N8VZIVyWu8GCpfG6V16K8
         gFjDAw+tvA1ySjLgUL46R3DVcioxNwzpOKkITTZTPkysSpZ7IJvVX7RAyOImSejoSQvD
         SZLBwhZ8GVHx4K4x5S9IFEEX4iFwvrW7VQdLNdrWE5CHC8hcUGqYWy9dqeMoJSPIJgKp
         sinlIPYTh/FeRFk2rkZwQq+rPfKBb5oulejh5ekk/DXLxQbxyBQMQWyFDd3LiEeFOr2p
         XzLKiPSsgpI7Q/I7c9uEZ3AA5VLIkp3Rw7SuKuAJI/1puz4pMm0dBjl9TC1YwlHSY0Tm
         OuJA==
X-Gm-Message-State: AOJu0Yz8u7VX5U4JDi/ag+V286FtwGdmvufihxRcqHV580zq3y3Y72xA
	yeRFyHpM0M56Lp0skz2MRMgm8AfNfSgAd28BfWuVi5wts7wyPWmV3uDtKuWrpI0UCQM3CQd/99s
	BXtjcYDS8oZY9QLlQ0fSB3ljmOGo=
X-Gm-Gg: ASbGncvHiUElHDjEFxF/BWOBYS4g/xMcnzhwqfUr5aOyb4YRMqMmmruMdCxoFoMrkaC
	vDfBjTacR02eruVTqxKLbd4MW5BuTX0K50hw94bAKFcOTwwoYOC+2Td8AKCZDfPB+DtkSDW2CXM
	vp2FFRV9amn5lQ2y/NZGTjBi7PHJPCBTpSqQQ74AjX
X-Google-Smtp-Source: AGHT+IEtTJ8CzLgTkKk58Bl2OKNzhZ/laV8Np4T4/3zr6l1S65mCbARJbuE0u9jIe8DyQvMhIgG4J1A47EHF/nB3nRo=
X-Received: by 2002:a05:6214:2aad:b0:6e6:60f6:56db with SMTP id
 6a1803df08f44-6e8a0d95e87mr2330406d6.6.1740681321442; Thu, 27 Feb 2025
 10:35:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227175456.1129840-1-usmanakinyemi202@gmail.com>
In-Reply-To: <20250227175456.1129840-1-usmanakinyemi202@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 27 Feb 2025 13:35:10 -0500
X-Gm-Features: AQ5f1JpqhaTYdl5BOtMVDpqpUtcmA9h68pHoc4kgWFi3AnBirBTig9wNgKP5cfg
Message-ID: <CAPig+cSimWQg3VbFUZfxDvy3=LQk2FByx7yYKEi6BX_0jjYhCQ@mail.gmail.com>
Subject: Re: [RFC PATCH] config: teach `repo_config()` to allow `repo` to be NULL
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	shejialuo@gmail.com, johncai86@gmail.com, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 12:55=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> The `repo` value can be NULL if a builtin command is run outside
> any repository. The current implementation of `repo_config()` will
> fail if `repo` is NULL.
>
> If the `repo` is NULL the `repo_config()` can ignore the repository
> configuration but it should read the other configuration sources like
> the system-side configuration instead of failing.

s/side/wide/

> Teach the `repo_config()` to allow `repo` to be NULL by calling the
> `read_very_early_config()` which read config but only enumerate system
> and global settings.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
