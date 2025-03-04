Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE8711CAF
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055261; cv=none; b=hG+nnHAW60Stb728e+WB8HMYuvnSr6kjDPRdio3hoB2agpDqxcZCDk4578bEoiENzDi1Tw3DBxUcY9L7xVvmfunvk502lTmwNYOb1GPX6pj0fZ3b1rlLtemV77WIbURgwq+sXUMTQYQWoyvDOXqzKwxG2t4L60VJOYLix6fSUDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055261; c=relaxed/simple;
	bh=SxsoaYmeiVEQ8aw74MgNbGyZdXPk4NYYQvY6KyfmxCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ttogang7k2seXmcgTpc6yaCJqGpcttJKk5tcz1RBtIokwC72YgPaJtnlcba+gK6MCMxvr+NjZO9Nn1Gu+EdzG0evXKLWLPbNgg0vICmaDF5kYGL4S1jVgJrKvEXXY4owb/d5S1feIJc74Ll6bSELqUhwcLVbeW73yuNlLIg8NMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9q4lBM2; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9q4lBM2"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30b9b1979b9so39499311fa.1
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 18:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741055258; x=1741660058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gIfQ7vqNUaIaxpO/iJt1vHF7lnQRGLFnh0Hr/4fd9g=;
        b=d9q4lBM2qJDIRaKauK3UZekFRaJxqsLsueC2ApZ341lof2IlaxhKevfAfOyvRixmKR
         OA1AKeRBjVEG6P2GQi/FF0/RbjjhCmPkdIKJh+hJk5BsERH2+KEBHPsfzyYHKHzD395f
         Lo4qHblmX5wOBZwi2B6VBUGyYkljPNr+VT46NZpdTIdVMHWw5D0u87NP2G5Cd2V38LTt
         S8N/CdcSN0kU1lQ9jjD4e2EW80i/jxI9G6DnFljwidDlW2oVKzpDcFrCxXP9N6GGSZJr
         S3EBtQcB5vwBtTb5ojcDK++DBslu0DggeDnwMnOPKnmgQFsYjCJ/i307gXNMFxBC/t/q
         XlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741055258; x=1741660058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gIfQ7vqNUaIaxpO/iJt1vHF7lnQRGLFnh0Hr/4fd9g=;
        b=QeRZR0UTlvuuEPwclai5IaAXz3YPokkcoJbAgV/RJYnblRzSaI3MrxYdCSTm4nOhkA
         L6zYXZMO96gnFM2ER2HgW9kM4e3k2p/2WhGZ7KpHSNF8XV/D0lnrQa/dctK1cfzltMJe
         bW3lvlIvWPjplNzArjy7/7mBG+P5auCRQZ821k7qoR33QqgGnnLt53WUmk3tCKQCWaFg
         Boo84uoTQeiEhAWddJIk/GJLUY61ADDOeKO4+Jes1//pLiYEm5lX1/LK+AHh3ic1zbQY
         PFOv/Cs4/yGNJqHQHFW7PidFPTsxNLoS9pPzJH7/+0mA5+jWXb2MO76Yi8/cpW1gSKML
         1UQw==
X-Gm-Message-State: AOJu0YyvqBH4C1Bx//Ekf8EwP2vDilLbcKlbFMPE2l1uEHEZc6f7oniC
	Mhw8lvVp/2SbBADpWGy6aL9PCD5YxrlyuRrQVp3tdRco/g57G5gJi1pMKfO+2YuP5ibx/tcV65Z
	bVPskJjM58KCm+HFMMIUZC/vNOR0=
X-Gm-Gg: ASbGncupZot2eYI4zAH7BSfEibLLkh7Lv+uc1uZ8OBOuZIrKYeap+aWo4bg+VR4X9fQ
	6UtkAaNzqeCMrzO+MxSxfNAwxpLvuN6D7EQr+nKiZ+T1dsZ6CHzDA0Bcblvtx+THqwrTT8LKdpd
	U0mINvQXhLYGDL/FwYNyXQZaJNXOHX9B2pbSy8KRgRhDX82k4IT2zTaN6oDA==
X-Google-Smtp-Source: AGHT+IGMO4nKOuNaR/qNr9TXotMRiiNVvleKQ7mP64lV3C1++7c6Qbp7sdrvjKlYPY6XciN5wVSznTeMD9/zjyDnwYI=
X-Received: by 2002:a05:651c:2129:b0:30b:be23:39d with SMTP id
 38308e7fff4ca-30bbe230db6mr22535201fa.14.1741055257729; Mon, 03 Mar 2025
 18:27:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
 <20250301105838.1481-2-danimahendra0904@gmail.com> <Z8WD2MeHpOH7Ni8A@pks.im>
In-Reply-To: <Z8WD2MeHpOH7Ni8A@pks.im>
From: Mahendra Dani <danimahendra0904@gmail.com>
Date: Tue, 4 Mar 2025 07:57:25 +0530
X-Gm-Features: AQ5f1JqeQfWIfyhgj1UZGgOkW-EbUKrG261WFIHzKmE6WrN1hWMMv1P-eHDiWYA
Message-ID: <CABGrwBB1-UiiPEOptN9csVP1WYg2X=SWeMxxiyDfz02VmDp1vA@mail.gmail.com>
Subject: Re: [PATCH 1/1] t1403: prefer test_path_exists helper function
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 3:56=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Sat, Mar 01, 2025 at 04:28:38PM +0530, Mahendra Dani wrote:
> > test -e does not provide a nice error message when
> > we hit test failures, so use test_path_exists instead.
> >
> > Signed-off-by: Mahendra Dani <danimahendra0904@gmail.com>
> > ---
> >  t/t1403-show-ref.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> > index 9d698b3cc3..12f7b60024 100755
> > --- a/t/t1403-show-ref.sh
> > +++ b/t/t1403-show-ref.sh
> > @@ -196,7 +196,7 @@ test_expect_success 'show-ref --verify with danglin=
g ref' '
> >
> >       remove_object() {
> >               file=3D$(sha1_file "$*") &&
> > -             test -e "$file" &&
> > +             test_path_exists "$file" &&
> >               rm -f "$file"
> >       } &&
>
> The refactoring is true to the original spirit of the preimage indeed.
> But we could also improve it even further if we verified that the path
> not only exists, but exists and is a file via `test_path_is_file()`. If
> we decide to do that we should also explain the change in the commit
> message.
>
> Thanks!
>
> Patrick

Yes, sure.
I will improve it further using the `test_path_is_file()` helper
function and change the commit message in v2 patch.

Thanks,
Mahendra.
