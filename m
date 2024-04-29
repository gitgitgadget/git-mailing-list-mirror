Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA069E55F
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370689; cv=none; b=tvZoViZuauFZZRYSAmemaD/L90mcnyrFsxW2Dx+pdJJMcF6tm0BO5OV+y831/MYSy0hoOVdZLoxdNrVU50muA5mMc4OR25FEeCF9pT7CN3eB3fd3045d2s7tm1iFboedGqHqac/qPuZvNQGGIKeUxNp4/k1fT9+MnxxyROrefLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370689; c=relaxed/simple;
	bh=8PLA/rC4gsGfdV9bO148PSmLVJdPv5D8JVo2SpLdLGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mn2HndaNeD/DuuDFzcNhEcGuFIJavyRUf8rZtYwr389m6eeYpkHtp7fJL3qOEYWV87sDt0bpQ4s4a0Z7u0bBJTLcLntUkHyveJTY8gkVx0KqiuJV1fp1QE4E202PBFm97gYv5Qrgji81Et6pF8tEamQTajTQ/e0l15U1Us2vb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6a0c8fb3540so6665266d6.1
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 23:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714370686; x=1714975486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TkAYkbUq2QWX1Dgqb3mQPTyjzxlFm3ob2lrukvik+k=;
        b=gVVneHyahzvQy7tUXHfPwxDKKK7ebCqgyC+e65eFywyfynbgebD87zshpceyfxmyKE
         6ndh+qhGQEdzT4uh4QzWvxs2QxxBElXReJ1pZxngi+LF3m7Qv+2eXGY8Ae5SAixol5AX
         EpkttWAPJL1pZ5c20ABdahnKrOSmlhFFtnlOF6dc16k4XpDeNRS3PX04eBwVRxt3X2TB
         yUfpVrAqJy7NrqK7E+d2x5iQ3S6iYP9xwLGUOcCYCLyBoj+KiX9kCSy1gW/cbYLMhU/p
         2QSVjuOH1LhYv+nHxPLJ+6b8WCg4+/eqvxYbbWp83x4MNiBtXheiaPPvqjVqkJZkelPo
         5TRA==
X-Forwarded-Encrypted: i=1; AJvYcCXI1p1KsPL1mR2xW7qwCzcMJGIkfRXAYoNKvRxj4MUmfSIrn2hchFnd56MKDFhP2vvPop8pN/Ef/RpWNU89dQG0FRON
X-Gm-Message-State: AOJu0YxiTl+qcrkfcRgykpe4ySky07q+o87pyBpdxYzvV8fYL27pqs22
	7Sjinb8b8mojyEkie5M6DsiNWwVTLpJ1nMYDlXNTIiZyKYZIeE+CtgixMUFeBomBZwOkLpzcKjH
	FCuvwM4Tr16SgJmj3HjlwLGh4AwF0JA==
X-Google-Smtp-Source: AGHT+IHZ3F6RTEEEAqsDmVTZhBgpFIt/SgmRBOQqw2AnZZ0z6XBFA3myhW4Gq5Rlp90vpHkN/uukdHSLmYtU1OdcZ8Q=
X-Received: by 2002:a05:6214:5494:b0:6a0:a279:8e87 with SMTP id
 lg20-20020a056214549400b006a0a2798e87mr11029852qvb.3.1714370686630; Sun, 28
 Apr 2024 23:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424035857.84583-1-james@jamesliu.io> <20240429010925.93205-1-james@jamesliu.io>
 <20240429010925.93205-2-james@jamesliu.io> <37512328b1f3db4e8075bdb4beeb8929@manjaro.org>
 <D0WCCOLSMM9K.24BIGLR6EEJI8@jamesliu.io> <809a1452fb18a6c03d9e8ed516d5c9c0@manjaro.org>
 <4991578233e75f5a9f096b701c4b5efd@manjaro.org>
In-Reply-To: <4991578233e75f5a9f096b701c4b5efd@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 29 Apr 2024 02:04:35 -0400
Message-ID: <CAPig+cRQVD9ZrvBd=49S6=9WsWWNdUWp1u9pADSv17bh_vJGTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] advice: add --no-advice global option
To: Dragan Simic <dsimic@manjaro.org>
Cc: James Liu <james@jamesliu.io>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 2:00=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
> On 2024-04-29 07:36, Dragan Simic wrote:
> > Regarding what to do if those two options are both supplied,
> > it's simple, just error out with an appropriate error message.
> > There are already similar situations in the code, e.g. with
> > the -k and --rfc options for git-format-patch(1).
>
> Actually, the -p/--paginate and -P/--no-pager options can
> currently be supplied together, which isn't the expected
> behavior.  I'm preparing a patch that will cover this as
> a case of the mutual option exclusivity.

Please don't.

"Last wins" is an intentionally-supported mode of operation for many
Git options. It allows you to override an option which may have been
supplied by some other entity/mechanism. For instance, you may have a
Git alias, say `git mylog`, which employs --paginate, but you want to
avoid pagination on a particular run, so you invoke it as `git mylog
--no-pager`.
