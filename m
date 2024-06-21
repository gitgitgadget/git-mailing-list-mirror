Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E04012C48B
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718944534; cv=none; b=p5X1q13zXdREHi9VWtiI3sEShFFu/lUE33w6VFRKl8bYH274Acx83aBxMvayo/e8J/6bGisvle7LTHoM1XpDG6NfkhG6wBp51JrXUeRw3MQOICAHeElNgDlIcXqEE6dvP7zhT3Dc1fzPN3jrSZuo2hqVpLtvk8bka9kSjHzw5DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718944534; c=relaxed/simple;
	bh=7QwJJ78dht0NaRKP+kPMC+veln7c6dAX+dRxrWtp9K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ectYKTdtkixbG6WBvmIrt62uVYoVjONrFI6U3yi+jMcXO9wvIf+zu8b7sZmISiHWQnWhFdFb1xqC3UMzQpOi00rZOEThQa2qsskJqsYOYtw2F+TqZwqEshB+lN6S/VMQ7NU4RB9VefsYQdwAmbH1cTvORtz546PrDnQ8QMySDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-630daaec9c7so15579457b3.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 21:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718944531; x=1719549331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QwJJ78dht0NaRKP+kPMC+veln7c6dAX+dRxrWtp9K8=;
        b=oHpHjp03MRJ3stYwK4cfjO6bOgHnvteS0EY5E1bT/Hp7S+bM2nW/W5JTsACPraJUfh
         yX5g7hUtdAxxqn+TdkeieGUsQjaIJ3ap5TRb1Xsrc5EJbkn5hBbWi7CXEXOrIAvgNw10
         Z8pI/GTwtGTzuaYDqKeaRzSbtOEDPmKSTqR4MHpWQFskMfSSlSVed35VMOVni9V1QP+g
         4Ha5zx44judpiNFz12aeEejTdBtEIIGtd05dDUzmZ5QU/imdXRSRghyDcVKiU8OpKyIu
         jLYGbMhN1Ix5w04Ushnjeetvj0sWL7x/zkJcy8HZuvyURJh3pNkKVhrAzuoDBvsgUaih
         wEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3gLx9s0OutCCWMBOyH3UtoIqXWO+10kq3fuTc2BAayVyrYcS7vuYwNpA4bR/Tc9OG5NVrBVYIDm6oMqN92TqupR4
X-Gm-Message-State: AOJu0YxRGB/5j/klPNFTyzEEpPgGJiryGoR6HzegvfQmRAayvySZDYuG
	Ys1RGL52V0qXbcLTkSqelsIhbur2ug+m1mq/gQX392xnXJTfSXEQw8Vd9BEVfawjzV7qzssImX9
	p5huU2FHAiq2639EYlSSb9VqQzaA=
X-Google-Smtp-Source: AGHT+IFLQ8AkuphP8o7uDVAGnveht0G3E6p01N9KHGfl3yMELSRlKRoBgCgEnB0UtFa9h625SL23FNOXOYzVjRezX8g=
X-Received: by 2002:a81:73c5:0:b0:615:800d:67b2 with SMTP id
 00721157ae682-63a8e5b6806mr74412637b3.29.1718944530840; Thu, 20 Jun 2024
 21:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38A18180-3CC9-411B-B5D3-36C5C32B6EE9@gmail.com>
 <CAPig+cS1o5bqK2Ph1fFt2wi6QaOO2=83xwoqoTLifA6z3NssXA@mail.gmail.com> <41408b88-2938-4112-a02c-53876e20f5b1@haller-berlin.de>
In-Reply-To: <41408b88-2938-4112-a02c-53876e20f5b1@haller-berlin.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 21 Jun 2024 00:35:20 -0400
Message-ID: <CAPig+cTaBxoJbsVsZLYLZueZpSkmt2zRJzgE=HOO30FvxpUUnA@mail.gmail.com>
Subject: Re: git-gui: Visualize * History does nothing on macOS
To: Stefan Haller <lists@haller-berlin.de>
Cc: Ilya Kulakov <kulakov.ilya@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 10:40=E2=80=AFAM Stefan Haller <lists@haller-berlin=
.de> wrote:
> On 09.05.24 21:05, Eric Sunshine wrote:
> > A patch to fix this problem in `gitk` was posted[1] in 2018 but never
> > got picked up since the `gitk` maintainer seems to have disappeared.
> > Considering that the patch is still relevant, perhaps it might make
> > sense for Junio to pick it up himself and apply it to the Git tree(?).
> >
> > [1]: https://lore.kernel.org/git/20180724065120.7664-1-sunshine@sunshin=
eco.com/
>
> Whether the patch is still relevant depends on which versions of Tcl/Tk
> we are supporting. On recent versions, the whole AppleScript business is
> no longer necessary, windows come to the front correctly without it. So
> a better patch might be to remove the osascript call entirely.

That's a possibility, though it abandons users stuck on older systems
(which may not be a big deal since it's only a minor annoyance if the
Gitk window doesn't come to the foreground).

Unfortunately, it seems unlikely that either my 2018 patch or your
suggestion will be applied since the Gitk maintainer seems to have
disappeared(?)[*].

[*] Interestingly, I just checked git://ozlabs.org/~paulus/gitk and
noticed that changes were applied as recently as 2022-02-20, however,
the patch I submitted was not one of them.
