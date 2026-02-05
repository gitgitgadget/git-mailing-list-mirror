Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA98F5B
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770253503; cv=pass; b=fetwq9xeYBour8ujPrZvObH7wsrcwW8Rfc5NeGStW6MDwPr5WIJu90PDEerysVaXyxxx2m5c/7SeDxwOBsLKKY7pJWwu7tmmOfpZ80Fh81vdazjtpWOTDJ4KN06IueL6GUjZScr6smYTQd66yHTCrUKBKGJd9cYTZXeNRIhm0PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770253503; c=relaxed/simple;
	bh=ltoOhbwuJvFiYcORbcjZKFsa/Loq8hDETfrnlti9xMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5I8HRGrY+cQq+yLgFwebEq4xKiR0GfkC++/DynnDoAC5VS/3rpay36zY1pdG1r7DZc97qF1y3S5A20ij3+lh2NNj3gwcfNjiKn+yg6uQh5O1yjFPLWd1FwN31Q5NSvcMOQQWcRPGqtzeu7scnEOqwNHpjJo6M51DFJBcz//4B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQBLGpBV; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQBLGpBV"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64942ebf1a3so483156d50.3
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 17:05:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770253502; cv=none;
        d=google.com; s=arc-20240605;
        b=DIPWTAISlgVcnpMhD5aA2ksJth22J3HcFMoGDYJCA6nCQl/55I24FTIiyOmJsnf2eL
         Uvn1oWxxUV1dPSnaPm5wLiLOmofANwpwqPuW8Rp++6UN8cfzJ/S3Xrt6ikk6W4FH8hJQ
         ylwSbQ/8b/i8egfoCxmwyF7H+N+ePigpdSIhccZEznN5bNZIScVLvabQFqqySQLhE4uO
         IPHPx7zNg+nsV6e6rN3D5rUgBGlpenxbucNdGLHq+RrivKhSMg1dyTTDOXvH2AAcScKT
         66RKvBZuDx6rPKZaJS5osBTMQZ9fvp5JPEweFAeJ/rLJcIKY3Mg4c7rLU1ySJrjf8pXm
         EpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ltoOhbwuJvFiYcORbcjZKFsa/Loq8hDETfrnlti9xMM=;
        fh=9l6s4zgyvTZr6rM38+4nmzbABNKwJqmxvBEMBFKR7UA=;
        b=UdOMex7VINRlk0+OjJ31qcP9xUeKH9o8R5Q5r7/PBi/++MBDmuIsrYtWyIIaqicsB3
         wLWm+ojLe8w2guH44nip1RuqrxuVItFqyxuDKt11U2NVUxkYKA9nBVU9xnhQl9GFxX7Z
         mIN6Wnts51A2zkIjz1g7UhcVbblTSEHdxjsmR3LNMSQ4NYA06OYdAZO7KEBGv5QgnGMd
         YBptll5cZNjHCuHSi2nXMSRwpjlITepzUxOwL8Ujg8XDYZzJIUDRCXu6b0o+nKY9hIg8
         cQYPZix00jA7bKhuIQT/1yU+8sjQU+cpG0BFyLQeaM48pYE2qqs6cMvp0k9XOZpm5jdB
         SuLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770253502; x=1770858302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltoOhbwuJvFiYcORbcjZKFsa/Loq8hDETfrnlti9xMM=;
        b=lQBLGpBVbJQzXo0tAEHVmE2wPRL+Lg3v4gbWto/8Uk5PD58u1SuGHVrU1PJ08Adrc4
         C3gvnSYLbIYG+hwrwismBpYuKiXexQas+poqrV7dolSP+eKf6J28OUzRF/48JKoCAODe
         AoUP8aZuf/KaMo5lLOt4HW5kyetm2+xXtfiUUSUT67U3lLrQiIoYTzqc7XlJhiPYva5U
         dTxVxmjlo9A3EHuh9zgO5Fsqe6Mpx4BinzQLW5wO6q0cp61t9GmsPUHHFd8KHUS06Uut
         gUP7xmJcUmUGTrD8KKO5JXVyBaM0RFhHDIM/vJo9BLO4Z5QSzVtAe32vbcTQjPoMDZwW
         Y1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770253502; x=1770858302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ltoOhbwuJvFiYcORbcjZKFsa/Loq8hDETfrnlti9xMM=;
        b=aWHxoTxOeGpjJa/zYPVaZpgE2CwhJEeOSStTS0SkHoA1dbVXrh1aL5/bbdgrpOcBgL
         it1YPk5XKgYNnaRKKLWYO5sCzaSBmCg7JSTuli26bm3G7Zvrdhy3/ufnvivsqNj20gUZ
         15l5UjCsZ3XeDTO5gqKKBENvZ5nz0u40jK1qb671DNQC/Ed/NghNitzLYJ+iMH1dLyjD
         O8qoFoioLAyJvFxooC8ZDtJFqJQo0b7XDXR7iDF9BkVBDOUH7lwZaLvTBA7iFesiH+Xv
         9o5y4Ghxn7hC4kGcf077Dli+uqMz7f81Ary2JT4K5CS1aGX9/Be3KQd+7rItYNmLhmFq
         IEew==
X-Forwarded-Encrypted: i=1; AJvYcCXMhnhQceLWWDCZ0Ss/rrlwvj7hi3GNDrepY4gKAbTQCCjkjzhBG0e23yz1Iababq2rOLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLT64XZcqio+PkyhHU8L7DidDBENkhygk8IWkku4d8a1wh7yAs
	KH1T1h5DiGU1OXQyrEV7m8Dt2AJNx97tQQbkydDk5NaZLJTMQWjw0h0ZbP+2vkFeE/FY/8V+SYO
	WEZCwZwvYI4s8R1WBUMgO7FDty/eJHZw=
X-Gm-Gg: AZuq6aJt1RKAgLEDtxjw0gW0fE0EohrgaKaDmZteNOsG9vji9BLOANpVHy0Pm3NOlr6
	0JhnYWyKydTTM3USF12TBQXWwpr9Rl2aMroKA53MbblSJPpvYHiaKvaSDsG+MaUHi4ncxbCRdRz
	Q/Yil8kcZ82qFx6vR0zwUQFRUBY0P4vL0WaJRH50cmAZC2byViy78xH1iEqsvlXK960Dcsj3Sqw
	J8mz21WUvxvIlU8fRXm9eMaKdDe0NHWQ3zkqSZI26/SRCeAZS609I/n7gF9gdGQlTEyOz/7qqLp
	2KZLTke7K7WfhHZXCOxbrbSXDZYoExXKjEkGYXkfnWAGaUgNtFc0dX86mh5DpehW0mw0tdY=
X-Received: by 2002:a05:690e:124a:b0:649:6053:15da with SMTP id
 956f58d0204a3-649db48d530mr4413545d50.63.1770253502139; Wed, 04 Feb 2026
 17:05:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
 <534b9313b19a73bcee6e0ac1d7299e19@softwolves.pp.se>
In-Reply-To: <534b9313b19a73bcee6e0ac1d7299e19@softwolves.pp.se>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Thu, 5 Feb 2026 09:04:51 +0800
X-Gm-Features: AZwV_Qgu8ALSkkEsLJMfIuO-ezqqQ7kD9wrslErVtDxibgyPj-9qvMJYmVEyGWw
Message-ID: <CANYiYbEpfC1TO13U1DF+3ZmBYw=HkgFtZvpWdiZ5PaJLw6t-Yw@mail.gmail.com>
Subject: Re: [RFC] Introducing AI Agents to Git Localization
To: Peter Krefting <peter@softwolves.pp.se>
Cc: Alexander Shopov <ash@kambanaria.org>, Mikel Forcada <mikel.forcada@gmail.com>, 
	Ralf Thielow <ralf.thielow@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, Emir SARI <bitigchi@me.com>, 
	Arkadii Yakovets <ark@cho.red>, =?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>, 
	Jordi Mas <jmas@softcatala.org>, =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>, 
	Phillip Szelat <phillip.szelat@gmail.com>, =?UTF-8?Q?S=C3=A9bastien_Helleu?= <flashcode@flashtux.org>, 
	insolor <insolor@gmail.com>, Kateryna Golovanova <kate@kgthreads.com>, 
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>, 
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.com>, 
	Ray Chen <oldsharp@gmail.com>, =?UTF-8?B?5L6d5LqR?= <lilydjwg@gmail.com>, 
	Fangyi Zhou <me@fangyi.io>, Franklin Weng <franklin@goodhorse.idv.tw>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 8:28=E2=80=AFPM Peter Krefting <peter@softwolves.pp.=
se> wrote:
>
> 2026-02-04 10:31 skrev Jiang Xin:
>
> > Please try using AI coding tools to update translations in po/XX.po or
> > review historical translations, following the prompts below:
>
> No.
>
> Please disable this altogether for the Swedish localization.
> "Translation" using stochastic parrots is not mature and just creates
> gibberish that takes more time to clean up than to do the translation
> from scratch manually.

Thank you for your feedback =E2=80=94 I completely understand your concerns=
.

To clarify, the intention is not to enforce automated translations via
a central bot. Instead, each l10n team should retain full control over
whether or not to use AI assistance in their workflow. The recent
commits in the git-po next branch only add optional guidance in
po/README.md to help AI agents (if a team chooses to use them) perform
specific tasks more effectively=E2=80=94such as recognizing glossary terms
from the .po header, locating untranslated or fuzzy strings, and
splitting large files for easier handling.

We fully acknowledge that AI translation quality varies significantly
across languages, and for some=E2=80=94like Swedish=E2=80=94it may not yet =
be reliable
enough for direct use. The goal is to provide tools that teams can
optionally leverage, not to replace human judgment or community
oversight.
