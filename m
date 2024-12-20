Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8FE2594A8
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693200; cv=none; b=kBTi9R4Sp8E6y1hXHunG86PdeEkEPb/c1/IAYO0pnokGxSWggQdBPVxBFk3KMCUjQmF9shfZV0VL5NOS/k2E7p8fRU28slpXw12SQgHjdgXbe0lwWLtSH+nOZFc7aCnG1JZiD8P5zGrIPQ3+vS7vlbe+r+4kQSWWmkT4f0HLHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693200; c=relaxed/simple;
	bh=ccd70uCsPRnCBrzSVAjCac5tPEj5hQS0yJnFXE1vPms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBc66t8kt9XC6RrVvNL5M+HKE4NRMsrgUK+4Qr8lte/2tsSRWpRzdDvxDDteqwcKr5o6m/sR7XTG0MwQLy9YHyK+4g2k/Rg+LGp4b/96VP4kulcnSfv/TKepHD+aePuqLGQDhmpta4Ude0bTpniC2PJC8l2KNGnmy52jIae6TEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=akorzy.net; spf=pass smtp.mailfrom=akorzy.net; dkim=pass (2048-bit key) header.d=akorzy-net.20230601.gappssmtp.com header.i=@akorzy-net.20230601.gappssmtp.com header.b=j1LpP7pV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=akorzy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akorzy.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akorzy-net.20230601.gappssmtp.com header.i=@akorzy-net.20230601.gappssmtp.com header.b="j1LpP7pV"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fd51285746so1108231a12.3
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 03:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=akorzy-net.20230601.gappssmtp.com; s=20230601; t=1734693195; x=1735297995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koli2ceYHoEuB3LSOBeUp0RX+gEZiXhHrPf1l7x/FnU=;
        b=j1LpP7pVnPUfIKWWNyVG/cntc07T6RGyhI899i4tS8aNgZUo+0VanALHdL38vsa5pP
         mRI76ayohuLr0ns7Ldn38IUGirr5fUyBtV++J3KUesCOuQuEsAKGfOnjWb766+7zlLrb
         4nTWO4FLluym8SOlE91oCmaFdK7R7dDfigFlLxoGizhIl+FErQm5nEOOSYJFW/i+0obq
         NSRKLpCAnAEpYEwy69LjeruF8VX9JoZIAXRNxbmLMnuBtEA/To+850uYu+EV8iSV2HK1
         eAZSR6Bey+TGDdbYfdiWRHNoeP9ZTvJdoLObd+qh6/eMTKdYRocfW/pjl4cz8EbuQK0Z
         4PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734693195; x=1735297995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koli2ceYHoEuB3LSOBeUp0RX+gEZiXhHrPf1l7x/FnU=;
        b=DcucJyrS5ukljPHqITZ2yaFqIBEJ29pdu1ZF+Dj7lEW2XHtYGGzCrmKTaAeRsm2zr1
         p1U7lc2yN2I1y8mGcdqMEf+OpybipOAvp/VYxMcsAx7SB8i8SYKqB/k9iFl0by97BnP3
         vzduQlFdPhfS/ycUAJnceFCWwJy7wyDNWfmHtx5GwjBw+OcOJ+JLSsHn7vCMwp39Psvt
         74tsA2CF3/7b9CoG/tMMpMk+BwmDmx9b6oSoQ6xQj70nlW2JJ7lMlBHfRCbiSdiT3GGU
         NPf04VFSNERDrxvYKsvrUvFL/qDpEjR9ISJrDpWIxvx6hdJUdGW5kMyugzny7de/i3gf
         rlVQ==
X-Gm-Message-State: AOJu0Yx7pWQBNIBwIjTTqAPE7yr8bQo4YQ+fZajtTtq9oP40KHOxUzed
	Pc6M013L+ybYEIj71VgPv7gHjCkNUcFfyapAMMEwlsv8HWidAGjopIvJLwJabDUKLao9FkEKTTC
	1F0FCNXBNboHHk800RvosXEa8k7GHCkUZdgGP/g==
X-Gm-Gg: ASbGncsN/E7OvybJ7PRzsvcSPl03fsr9XeCBff9KBWaLQJYzdLIpTr4KhzW8mspJ5+S
	v8UEybwivfpMy9HpYJzp8KLE7/Yb5UTtPbFaDgg==
X-Google-Smtp-Source: AGHT+IFs/2rBmngY40STpfnCxwuvSYVMAl1IuB7i3Nb6P0Ii9HFtlN93XqDhE9JqRBV/JDggtKQHVlotzU3f4u6OEds=
X-Received: by 2002:a17:90b:2c84:b0:2ee:bbe0:98c6 with SMTP id
 98e67ed59e1d1-2f452dfcb28mr4436785a91.8.1734693195089; Fri, 20 Dec 2024
 03:13:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEtHj8AXKrQfyAW9FSv6yC-8GF1AkPixMFjSye+B51pJ4fOtWA@mail.gmail.com>
 <20241218120831.GA695807@coredump.intra.peff.net>
In-Reply-To: <20241218120831.GA695807@coredump.intra.peff.net>
From: =?UTF-8?Q?Aleksander_Korzy=C5=84ski?= <ak@akorzy.net>
Date: Fri, 20 Dec 2024 12:13:03 +0100
Message-ID: <CAEtHj8DUaDm7Hr+Dzc+K=F1MONj8u=GmuB1ju5kMU-swPa6Whw@mail.gmail.com>
Subject: Re: [Bug] --simplify-by-decoration prints undecorated commit
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Peff,

Thanks for the response.

--
Best regards,
Aleksander Korzy=C5=84ski


On Wed, 18 Dec 2024 at 13:08, Jeff King <peff@peff.net> wrote:
>
> On Mon, Dec 16, 2024 at 04:09:07PM +0100, Aleksander Korzy=C5=84ski wrote=
:
>
> > # Now, let's try --simplify-by-decoration on another commit
> > $ git log -1 --simplify-by-decoration --oneline 1e3ef455cc
> > 025a87d9db Merge branch 'master' into master
> > # The above output seems incorrect, because the commit isn't decorated
>
> Yes, but it's a merge commit. From "git help log":
>
>   Note that extra commits can be shown to give a meaningful history.
>
> Try:
>
>   git log --simplify-by-decoration --oneline --graph 1e3ef455cc
>
> and you'll see that there are commits along both parent branches, and
> thus we show the merge.
>
> There are some other options listed after that for changing which
> commits are shown ("The following options affect the way the
> simplification is performed"). But I don't think there is one that will
> show only the decorated commits (however, I could be wrong; I've only
> ever used these options to show _more_ commits, not fewer).
>
> -Peff
