Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B211CA9
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 05:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642391; cv=none; b=rc2xaS4RngGbfZtPPOTd6dRVNYHLltJQ/QLYa3Fy7y+JMd4lU23ORqbHHkeojJvPUfZ3LciKXdwt7RpohMOgvCnhE+chm12Vqn+uMMu/RDUXKqE/6iHqyBTMtFTkTxaXpyapucCSuOAGQ0yk79yic8FOnidPfIx5feF7leVbYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642391; c=relaxed/simple;
	bh=5B5n61NB/x/PgzsVKOVcdxRiPcgao4ppGgpgPyc0N+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fv6NFkX6kU+ejQwuVdFm5rakqUAu0U357NEJ482lP0gp56f/ufUzFIVLqHfTq/HwvGJ5q/ZT2Ga8JLa6Vwni0fqx7JlqTYDo5JixI3hXP43u0iRgIOxR5V9O0FDTbBnzxEuPRmeKcfDfu0YtDLINIL6ozvsYp6tm7vkfhRzZpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fhji7VzF; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fhji7VzF"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df2dbe85d1so47665195ab.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 22:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752642389; x=1753247189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B5n61NB/x/PgzsVKOVcdxRiPcgao4ppGgpgPyc0N+s=;
        b=Fhji7VzFX2Cg5sydNXbqxiPGI4cDJWP7snLu2lWK7UEGmgn9swvoywnYaoIWfS1r5r
         w2CbHXYGt6FdxS/P+S6qrxBNgxgf6A+MwF1t6DlMznXuMRKiLGb9sPSLuNi5NaXD7IIO
         C6+tTujSQiQQ62CPtlgSu/sveDEoOY4M8gkvTagEZ0X/Wc5nu1PtJdk8iiScKYUlJl88
         v67TxYNJkBAzGtY++oxd9bM2jj/EfiBd4WoemD+P6cCtAXJJJ04vG12LK7ReirYEZ3Zh
         VZl2hzU9xHJ8uJJDuB2u76K1AwHfY+xShLDF6tWAKhL4euAuyZTip5ix0Phbc4CNjbXP
         DoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752642389; x=1753247189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5B5n61NB/x/PgzsVKOVcdxRiPcgao4ppGgpgPyc0N+s=;
        b=kBdEgMngOMBlI1EgjIGmO4b51ky9B5GRgTh8v8DfEN7JatMw6yNAzv7I08D9qpnjn0
         +mEI2Qh1+nYYvslunqjMuZ/qrLc05G7dSSNtQg/TfsfLp3Ts8Z5hT/JhgD9/tbxMibQX
         qBni94oFrgVYpjlh6exgRiRTsbTGJwW/tCukOx0UOq3S4xZt1D1DvGE2ov27Jqf8EWHX
         1y4O/8xz0YcRlwz6F5/Voxxtdwycq+sjhB77RF6BrTbyCxnFlW6BozHbxAeB+ejuy9kn
         DA9Kaq1BO7qdUk9CuIw1jNsL23NWGNFGZffVmMS2VRtMQuivU4aRvJFky3qvjm2TIQHf
         AjVw==
X-Forwarded-Encrypted: i=1; AJvYcCVuLPIX+PWtHnhkLY4iwd1SB8Ib7VhhQxtYwqEntrtJy4VRYD8lk/vdo3Iq68Sp4guHF3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrRCVOidCdlFwJo2I8SjiaOEUBk0zGAAh/9xIGc93pAWHnAjxj
	ihoEGII2IR7V3MaICzOAPq5rz2clf8WjhiB3MCqqzuHx0zAGm2RCoUI1PFTCc8rdnuXlqqSW4IJ
	csasKtofaN7K2vwIfJfHf3sGkGeg3FJfNPs67
X-Gm-Gg: ASbGncvBhj2P+1+5corvCk7yn7GR+eTY5ilCiNF2ZvnEL2/g4GC+pZyOI5SUSun9ejR
	Nj0WcCIJnJ6WU2VfGj6n7lU4JLEWDjcCuras7J5fLtNCbyf6taJYfrHcz2l991XPBm3RH4oz7Sj
	x4aIJeBDcr8EA24h94nHWDNTO/B5jxfkuzLLLhXvyCdTkp1mkmlQxh5EZLFJ8kyKON2QRoFsKa7
	jkNzSs/CppeALvWOhtI2bgxhRvpQ/NGRKFP4cT/FQ==
X-Google-Smtp-Source: AGHT+IEkucA5lQlKKW81DNaPQjMZSLG8KVfBIs5P9RPa4lasy27PuLGZ+9bWyw2tVYKybvz80XiBZNO0l5jV6ShqLUk=
X-Received: by 2002:a05:6e02:3e03:b0:3df:3d4c:be27 with SMTP id
 e9e14a558f8ab-3e282d62b2fmr12410925ab.5.1752642388680; Tue, 15 Jul 2025
 22:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
 <cover.1752587571.git.phillip.wood@dunelm.org.uk> <352f80c49b74053d611e7d64991fed1c16d857a4.1752587571.git.phillip.wood@dunelm.org.uk>
 <20250716043827.GA1395459@coredump.intra.peff.net> <20250716044658.GA1396022@coredump.intra.peff.net>
In-Reply-To: <20250716044658.GA1396022@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 15 Jul 2025 22:06:17 -0700
X-Gm-Features: Ac12FXypPWWLBlduZkOsHR7Ni6FXWany952a8XRaHES6CfUzc6HD8c8vAOeTpUA
Message-ID: <CABPp-BFf1HApgiPwQc_yM2=DdyzN0QTxFZQRt--RBAvJqpCX0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] CodingGuildlines: allow the use of bool
To: Jeff King <peff@peff.net>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	"Brian M . Carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 9:46=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 16, 2025 at 12:38:27AM -0400, Jeff King wrote:
>
> > On Tue, Jul 15, 2025 at 02:52:50PM +0100, Phillip Wood wrote:
> >
> > > Subject: Re: [PATCH v2 1/3] CodingGuildlines: allow the use of bool
> >
> > I was lots of discussion about grammar elsewhere, but nobody seems to
> > have mentioned "Guildlines" instead of "Guidelines". :)
>
> s/was/saw/, obviously.

hehe

> Surely somebody has coined a name for the law that any statement
> pointing out a typo or grammatical issue is vastly more likely to
> contain one itself.

https://en.wikipedia.org/wiki/Muphry%27s_law
