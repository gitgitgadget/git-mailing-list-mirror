Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEFE42A8C
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709250749; cv=none; b=qJ1/CH5Z1BA/YJNJHe9H7r/O0hKGL4WTCaiT67Ehlc2nrTeH18KQN3qGpH/XKAD7CJTU/ozoF+OfRCUNizAtZajLRJ9DnT63YvfKMTEGj6hTOK2dQ/Z8wsTJnWInkc8bJ8mD68gejUWHpehDbM0eX8+oCFihVUH1FkSH+oaLbxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709250749; c=relaxed/simple;
	bh=cC9t+QlfTjHEXpC9RJ//lPB+RRhLdbY/ud808xUVEQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGYYWUAD79yMbcbcdwteRQwPAcvyt8HoFvPrnnFmKrimqayvEcSXx0Xt56Gokf+Nu1EyH4wvhPl5FIJMT6FoJvbnNtsqwehmJ3NSBcDSBtsEDlVkjHUZVZEcoUweLitQt1fgT+feMr0l/2vtP/IsRev3n77KZZAFLas/C+vA1/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68f9e399c91so10596276d6.2
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 15:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709250745; x=1709855545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgoQidKl5M9CR3Su+Isx3SDjv7rCHDQWJwLOaKLPJFg=;
        b=dtMOy3r/34L9VSAJYLPOsY0fZUl2U/kGh9IYIV1SeC57EfYJhj33i18gyknT5znQUx
         9ZdqocgftLcp+7Tca0YfBj8wOusFN2pql5fh27vbjbrowQSxQbmbVnG2Q0/NJx7jOkvG
         40ykblqUDLOlqTNsBNcY6GOGvYJ9N8OiiLdbbJumH0br+/lpgQppblKyJhJKDjyffMrb
         BML18rVkLCOijkFNoERdP3WypUfBwYMfd12uK+Kwkoe+XpoYOygxy5yuL5i4R3EYytUB
         ASkpUtABcEcxNNshRpu2w+YTsphB71G7LLlV3KwF1MbzblOkXoAFn+4vSXY4UKkjAh7d
         Tw/A==
X-Forwarded-Encrypted: i=1; AJvYcCWKGDa6jeFa+dpkb5wuIqI2naJMbE7YQ9nvP5cSkXb10llIjhehkxhtMR+twNASODubMxaQjkDXHMG/M6F8HgYwfyK/
X-Gm-Message-State: AOJu0YwrLl6yibCp07gdwyBkI4v0mkq236IMhRcGUcCWDKmDeHNtq7OG
	6mF3Lh0h0zPwfp+O5jzhD8ge5t1aZglD5Jls80jPqIAcSDibTEUX08nQlgnv3m1KsL+w9S4qce6
	tu3t/dVLyAkVe8JF+9fDQDXQ8uOo=
X-Google-Smtp-Source: AGHT+IHgORopv0mn6WbFcpCsEinUntstF6c+JhWAt2XHesLI6ipYWGrGWECCM19bA/HY2cveBxy1EOi1f2gcTxgTWuo=
X-Received: by 2002:a0c:cb0d:0:b0:68f:e7c5:a1f2 with SMTP id
 o13-20020a0ccb0d000000b0068fe7c5a1f2mr90106qvk.63.1709250745165; Thu, 29 Feb
 2024 15:52:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1675.git.1709209435242.gitgitgadget@gmail.com>
 <pull.1675.v2.git.1709243831190.gitgitgadget@gmail.com> <xmqqle72c17i.fsf@gitster.g>
 <CAPig+cQ5m86=pLTpFrik0xS6XPyK4tZQx_wkc1xh2r9WDFkhuQ@mail.gmail.com> <xmqqa5nic06t.fsf@gitster.g>
In-Reply-To: <xmqqa5nic06t.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Feb 2024 18:52:14 -0500
Message-ID: <CAPig+cSGtcA15aOmvj07Uv-pFZTE58+9gGsQh=8K4BL4KRieQA@mail.gmail.com>
Subject: Re: [PATCH v2] tests: modernize the test script t0010-racy-git.sh
To: Junio C Hamano <gitster@pobox.com>
Cc: Aryan Gupta via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Aryan Gupta <garyan447@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > If taking it to this extent, then the modernized version of the last
> > couple lines would be:
> >
> >     git diff-files -p >out &&
> >     test_file_not_empty out
>
> Yes.  The modern style seems to prefer temporary files over
> variables; the reason probably is because it tends to be easier to
> remotely post-mortem?

Yes, that seems likely. Functions such as test_file_not_empty() also
provide an immediate indication of what went wrong without having to
spelunk the test detritus:

    'foo' is not a non-empty file. [*]

whereas `test "" !=3D "$foo"` provides no output at all, so it's not
immediately clear which part of the test failed. Peff's `verbose`
function was intended to mitigate that problem by making the
expression verbose upon failure:

    verbose test "" !=3D "$foo" &&

but never really caught on and was eventually retired by 8ddfce7144
(t: drop "verbose" helper function, 2023-05-08).

[*]: Admittedly, the double-negative in "'foo' is not a non-empty
file." is more than a little confusing. It probably would have been
better phrased as "'foo' should be empty but is not".
