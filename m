Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EF923BCF0
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473774; cv=none; b=f879ZvFDsN1osNxJRx+93J/ObTolGj5ikYIVOgXbZLApcIihqke/r6Ybv8sTxzHga/Mn1Km7rB1JyfztJ/07ZZvF8ttd+wVuJHLMh+/KQEFKQt5OZQO4kI30gD7hpERCbwIqobSJHZSQTlgBZpMabI0DPHSJiYQEqnN8iwnwCJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473774; c=relaxed/simple;
	bh=JqNcqe23uev1y8sosDHmtdLUNkkbS7pIQFZ+A3BjkoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlpHA0ipAUtHJ+7bSUwTf+Icl6tbBSmTpulqeDhz6oIkdp8b82fKc8J+3VDNk7fssKITLlA/npvbwqkyiObNB6mBfkwSahEjSzSbp+YS+REN0RUw7WyWVKekVkGBt3xYT+1rhlkqCLc0RCDrXdreKb0Uc+LsSdvwjXNV6YdgCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbOOHdIZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbOOHdIZ"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61cdab7eee8so2859834a12.0
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756473771; x=1757078571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqNcqe23uev1y8sosDHmtdLUNkkbS7pIQFZ+A3BjkoQ=;
        b=NbOOHdIZgidwf6zHy1lb9V4Ds2EPkBmOmh8M3uVv6pZ2ady7WQ8Mw+J3ONA+nqmZ7Y
         ZlIaf3nqeGBqG+d7KBuKpTuOLoM4TThRwwcejtq84lcId7hNVdJ12zb9CY3tHauxcbGX
         fH5RFNUob+2GY7ThLk9Ck/p/WiQb9citSXWfUocuPEEHgqCdrbDyQWF8n7NLKZfl0tg2
         E5XwMncSXEaG9IGdh9wuQi+eXIykKLctCWPfMh4QISHOzGLmjNHF+XcEbR7EVCZO5R7h
         d4a1YdZh2RZqF94KK2k2i3U3IiLjBtkXfzaL4CC9UQUAJ4/lMOAm+C8g8UsnLFQcaRJG
         xEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756473771; x=1757078571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqNcqe23uev1y8sosDHmtdLUNkkbS7pIQFZ+A3BjkoQ=;
        b=wxnfZiY0EzXXO67nzGNB7CbxwGJepWQ7bP47slVPZ6tNY7qQAf3r31b9XT8KDSz7it
         lWaMyRnVDS0q8KRacJlUEdF1ZtANabF2Gaq/9pb5HAYrazydHE1lGT1OmNj3YZ6sIckb
         coV0x3yZ43wBz86hT9P5OqQ8JmvoK3WYk9ZeUlPfF5oiy4adSy5KTX+ORDY/MZkcS8fz
         aYEYGPebRkkMcBvimzQ3yAL9KANkuyCZnIGKRD31Qf+G0rXHDeQWPUoGpYlunhQAnp2W
         t5TVdbu0dYwM7OhxyeVLuQBFE1M9Huc/Tc6/OuGE6XItBS6rJ1sQkkx7FeHnXOifzjhl
         Y12g==
X-Forwarded-Encrypted: i=1; AJvYcCXRt79xwOs6OJME9vz160xvFrIt9pHh6eHK8z8a3taKrG6sT2rwWGwd62+YRKiXkzzNRJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXFCYETxl2ytsDL0+ZpSYG2CAfprZMDHaeP83Bbz3wUwRZDyHe
	68hWNY/O4BUZevtFvT16YWMIaUFz8g3zHtWlkTKtlM2Lr2PwaJkvkm62TQWNtJmumlXMLjS2faO
	PTD8Dn+1DaKvH0dBAS8CYvnShZzLlsPU=
X-Gm-Gg: ASbGnctd9huV63oc4TY7tqX+GS8RUYrddvnE8gRuNu5Ggg+C1qbQlN0raqCqdZcn72t
	cfqyaydNncsNoQLEmXI+KqM0L/WSUa3nkgGLK+bhaVk677hbSTn9wJYYqQudfalb33tVjInNmld
	FzwsmnMx6zxWBbDcPb37zLPAmtxnep3ciRxug8Fr/Z8h89pPSKdfb55b0aobE8Fh5c9c5znRjao
	tn9MtolaCb9GkK9pXH+Vp2sJkgE0lkR61ijpCIqMw==
X-Google-Smtp-Source: AGHT+IF2LCcpo0zQpk9cn6S+Xa4ayfsrZR4NRyTO1VrFpkeo7TIpPZ34ODjceIzSmsfUnkLpClk178h3y2CQ4RgvR9s=
X-Received: by 2002:a05:6402:350d:b0:61c:e99d:fdef with SMTP id
 4fb4d7f45d1cf-61ce99e0697mr4191158a12.2.1756473771242; Fri, 29 Aug 2025
 06:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcya63cqx.fsf@gitster.g> <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-2-usmanakinyemi202@gmail.com> <370f11e1-b335-4111-912c-94429c5018d6@gmail.com>
 <CALnO6CBbEB=94YsZn8vtjcwYENuMhMdg_wb2RbQunVCxnf53jQ@mail.gmail.com> <0548f4b2-6c36-4958-8725-5c9ac91e31e8@crinan.ddns.net>
In-Reply-To: <0548f4b2-6c36-4958-8725-5c9ac91e31e8@crinan.ddns.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 29 Aug 2025 09:22:39 -0400
X-Gm-Features: Ac12FXzW7ss7CQbfUISNqHuCPTuv92l_GNUI8j651v8NfLlp92kY3jSHQP2Fr4k
Message-ID: <CALnO6CBU0Y+JXdXsGgFR-XUMx=oheaQh3nEZpmidfwMxR6XYHQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a repository
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: phillip.wood@dunelm.org.uk, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:06=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ben
[snip]
> Thanks for taking a look and sorry for the noise
>
> Phillip

No worries, glad it worked out!

--=20
D. Ben Knoble
