Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2736B21B9FF
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908724; cv=none; b=p+h5MzogwU2YR1pDkGHajq3POXpiMW9tUQfEOC11M85qWpu0znJWiJwAOCVsLEWrczODAsouMACvEQpN4i2NODrDkWARWxjSwEtHhvpJXqJ08UZ6yX6zDbzdm0QF/1FDzNuccjfNoVRBEKfxEYBhMPsQdkXB15GqFeZd8MyjQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908724; c=relaxed/simple;
	bh=l64zrdY56mw7oW//0774XpHuz1tAZvgxixciDsji4a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAptUX0rPWdWqpz+NzzuBoAw9J2Vw9WFCFJa7Pq9PHZKiAHDv982YT+46AWfQYdBNX6L4ojFbsBJAmHPe056kNHn12iS02r6muXXzYilO3oM47GLMSPdxd53dMHly5qzJg2pXvw+7f+vesv0xhAyyqKfQaX7g3InkQAJ+Xbv6qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3N/GLwk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3N/GLwk"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b794a013bcso276982f8f.2
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753908721; x=1754513521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l64zrdY56mw7oW//0774XpHuz1tAZvgxixciDsji4a0=;
        b=R3N/GLwkxpIoew4MWNgX0hx0IR4uzQeH32bngg3ifCOsiQ2k3SOF+m62SSg6psttKb
         fLu7tNBgHL/kjCjH32XHWK90OWRLh9VOg/jcjr79UNcIS95nfs3t+qFHBncW0uAMrpgx
         UJszVZ5/XBuHR4gsJqdUqsvctNk4nQ1oYKqG9yCATP2XHuka1Si8w6Crg+prexULYsrO
         D2W1bM5zF3mUnPuVg+19b2MKSyeTqkyYoewJ7me3BPL2kpqjRaL4WPi4ba5J3SUUr2OV
         ITbSdvm/vF7EDeA4s3IxPTtk5WfALfKVCWtz4Xu47PmpeDGW6vVnYKVRNVR0D/6vEFrq
         /FlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753908721; x=1754513521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l64zrdY56mw7oW//0774XpHuz1tAZvgxixciDsji4a0=;
        b=hbrUEiXss5FUvLPO9KOPDcgA3kfIiIlj6lUCsGVTJNt2liAPr0QEwXHDHLaVFo8iJw
         WfpDhkt4pvGryffm+T8fjAS98f0VNr2mhadyX/Se2vJ5FemWBp6R41t+50nkbpDng33N
         EuBPU6NdwI54WgNUpgN6qniowinsD17RRgAtAHvsL1oStvmFnImeS11ThWBiyLpbFS9N
         JNXPGSOEovmRtLRZRenGVY/c63tYQjr0rzQpY+UIjWWHjKgSg9mjwctv8TNqQ9szRDAB
         20MgopLvbRD2Z/i7i3WLtnmlo68KydtABqLJZh3sl5LWxdVTkoGL0FPpLDbRCYz2Z0Iz
         VyuA==
X-Gm-Message-State: AOJu0YwyfZ+LOns3isshG2GDW2wwZ/nkn8SOAjy1n14Zq2HQVtRUqBtY
	w80ApYGRMh1pAP+VtGb4+OQyLKrA4sji8c1jqUZCLcF/uddDA/A1qruYTUgMcSiW+ChF4bgvoso
	yvYxvcDr6/hijX2nSRr6IRSrPEzwtNrQ=
X-Gm-Gg: ASbGncshH66Kgf9UHUBiM9Kwax1S2pRpzDS98hi1W/5lCLj7movpIaodqCUvv1EbwSF
	iQqQRHg5OzK7t1WvErPijcC2aVeKoNxqn/kIw/nV1jOEhXLpVelWhgKYdMkiuAV6zSMZmCO38ml
	Ozw3S7cAKu+r9IIL81HlMZtoqeizHKZFdFKkrkwkC3/k5gwg2VC2+2t60P9yrPfIkh6Gwxmh7r1
	E0=
X-Google-Smtp-Source: AGHT+IHVX8+mvMK5ezGCyKg2PnNo8YHDQ/XieEME4N0j+azXcRoXVEzuNf8DKddMWWzYNXvT+FAfmQe9JpJ6PQTvegA=
X-Received: by 2002:a05:6000:290f:b0:3b3:c4b1:a212 with SMTP id
 ffacd0b85a97d-3b794fc19c6mr3952498f8f.7.1753908721012; Wed, 30 Jul 2025
 13:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730164052.15371-1-carenas@gmail.com> <xmqqtt2tl9yw.fsf@gitster.g>
In-Reply-To: <xmqqtt2tl9yw.fsf@gitster.g>
From: Carlo Arenas <carenas@gmail.com>
Date: Wed, 30 Jul 2025 13:51:49 -0700
X-Gm-Features: Ac12FXzVoFZg782ziCBnuCTdblO4Jur-WrxOUmuxrT6l8IRdGdQ4oywn5eh7zlM
Message-ID: <CAPUEspiP+Xoz_W-X4QrStAFS1BqSF4pws7d6dxaf6m0OeLtM_w@mail.gmail.com>
Subject: Re: [PATCH 0/5] git-gui: workaround deprecation of Tcl/TK 8.5 in macOS
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>, Mark Levedahl <mlevedahl@gmail.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 1:06=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:
>
> > This series adds improvements to allow running `git-gui` in macOS, whic=
h is
> > stuck in an ancient version of Tcl/TK that is no longer supported by gi=
t.
>
> A na=C3=AFve question.
>
> Just like Git is a third-party software from macOS's point of view,
> wouldn't Tcl/Tk be equally a third-party software, or is it more
> ingrained to the base operation system offering for some reason?

It is more ingrained as Tcl/Tk comes with the OS as a Framework,
although one that hasn't had updates for half a decade, and that
prints a message saying it is deprecated and might be gone in a
future release for several releases, when it works.

git comes as part of the "Development tools" (both the command line
that is independent of Xcode and as part of Xcode) and therefore must
be installed independently.

> The reason why I ask this question is because I do not see how it
> would make it a lot more hassle having to upgrade the version of
> tcl/tk on their macOS machine than having to upgrade the Git to the
> version that ships with this change, from an end-user's point of
> view.

Not sure I understand the question, but "upgrading" is not the problem.

Users can (and had been doing for a while) install a newer version for both
but the Makefile that comes with git-gui tries to find the system provided
Tcl/Tk and use that, which IMHO makes little sense once the git-gui codebas=
e
is no longer compatible with the version provided by that Framework.

Carlo
