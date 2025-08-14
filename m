Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAEB78F4B
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755209151; cv=none; b=o4g3fqR6xss9IWPDkuKW/r654nzCUOv1bD3bf+apH+LZyFMOy+G4MEcethUz4p3Y/ODbAFSANntxYpowNdHEmatdKzs5vtHRPOxgveE3EdyZEqIwA+TfmAIOqJf+HyN8cGsrCBw9djnBFpCYwjBZfsUVveCNdpjWS6z5QVKvafg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755209151; c=relaxed/simple;
	bh=5KpcqLszGJvP7paOtkBnp3UL+0jLsW5Yc5AqZ3JFM0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jk4O6PYkaCRRm1helpoP57SUDfV33z25s3tV3RSLyrfrxXV5CVMiGmuuFGk/OSXJjkFm2qvIy+I+kmDjRZIeaNUTFELN5nzgXnGd15PZ+3Ocbb9KG+6jDUehL+e1wWYArQ1OIeItJj5gBMk+Ev5+RxOCGM+d0Tk2DrIc3n4YV3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e8706fbf6cso17817285a.3
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 15:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755209148; x=1755813948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNiiE0H2xHFbjbOjMRjrNhairCVQ3E1YYfs3ok1/pgE=;
        b=a1Of3Pg9RHmlFwLSPZm0bkB06Ov7lWRhvEg+cPvYCq9rS+z25DwTH5D/rR7kQ+D41z
         XzKgZYm2KQJ99KIaovuwW6++9ELLxe+aG1SS5TMddXfPhU+yHK2cRhtTId2RtpLB1Qk2
         Vcz1080T88PmgWXhevXVh7Q6RLy8XmaJm4OJsbFd+RI8LlREtU5OtV0kQl16ktoInr6i
         tvZXX0J0CkjDeVEUYs8iqjt2FRJBy6Ejci/37xYA6ni7oRZ914Ehy9V3lgcLo8Z9jOZg
         SRkvAb1xNUFUvkGxq3m9AxKdGaEeKf5lcrprHAXICfh0Z35xMWPM6eBuu/uZ0AbaKtRE
         /pCg==
X-Forwarded-Encrypted: i=1; AJvYcCVXTIBKDyuQTWei0UAfP7jJEqX7YfkZrsqWe+HEga4USVq+dHQoTNkJPnfQhYHJccGuD3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfqBTh/+HBQp7ECGpC1VmRCOQMrRU6APTfLEnCU/VHUC/pNbn1
	C06lzj3aujxjWppt+8nvnjp4pWEslUbXPhk85hXqz2piRoPW15UDaTUI7DUqWTSzS+oeuKfZZLH
	coX/PvjI5R9fU7zLtJePWtFgqVbgQzfA=
X-Gm-Gg: ASbGncseaedl3fOpZ9UOind6rsPpjCqsBp03F2n/s7iPo3fqT9mamRPLL4zTuO3ep8f
	1+gyvNmrR6+SHgmJDJ3L4pJuCCPah4fM1lZVJuMsWc4b4x0P0G98dqXQG1Y6+Piu4TRW/xmhRs5
	gmJONmMrdyjqjZtt2MrYnIkoDmFErUyzrMR0YVvdzEY/VCNiDHRST3AfJFi2gP21KTU4HmVm8YZ
	iKixF40UgdL8E6uJxyo1F8ZQVTzCVKr1Gm6VQSLB9Z3xWmR7ic2T6gFc3lC7A==
X-Google-Smtp-Source: AGHT+IHNWv/ja0NoTJyUlWc3v30TJZCDn4QPs2xlw/K29SYkokpYJJ1yPFRtD8ETAkmPqQtabs2A8PyvcK21nu5E04c=
X-Received: by 2002:ac8:5d55:0:b0:4ab:23fe:a743 with SMTP id
 d75a77b69052e-4b10ab09629mr37974351cf.9.1755209147937; Thu, 14 Aug 2025
 15:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com> <20250807150239.6987-4-lucasseikioshiro@gmail.com>
 <CAPig+cSBg6oQC4Y81ieH25-A9cHRTfbqC5i+22RSBcbyVo_qtA@mail.gmail.com>
 <BCCE25CF-8546-4320-AB44-9B729C3D6DE6@gmail.com> <CAPig+cTQdEDZduG_UmdHn1JNfj7iTw0=jwdkX+VPJ11Jo0jUGA@mail.gmail.com>
 <xmqqfrdt3feh.fsf@gitster.g>
In-Reply-To: <xmqqfrdt3feh.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 14 Aug 2025 18:05:36 -0400
X-Gm-Features: Ac12FXxO_45w9J2uAXltCy794FaurIcW0QcmpUHDH-3d-YHeyxo78R_rUMRjGSU
Message-ID: <CAPig+cSZnfG7NDCGDDnFvtwS4hpcGkmVKA0hPhLALmXj=0Zbbw@mail.gmail.com>
Subject: Re: [GSoC PATCH v9 3/5] repo: add the field layout.bare
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, 
	oswald.buddenhagen@gmx.de, ps@pks.im, karthik.188@gmail.com, 
	ben.knoble@gmail.com, phillip.wood@dunelm.org.uk, jltobler@gmail.com, 
	jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 2:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Rather than the above, I think a more satisfactory and meaningful test =
would be:
> >
> >     test_expect_success 'values returned in order requested' '
> >         cat >expect <<-\EOF &&
> >         layout.bare=3Dfalse
> >         references.format=3Dfiles
> >         layout.bare=3Dfalse
> >         EOF
> >         git init --ref-format=3Dfiles ordered &&
> >         git -C ordered repo info layout.bare references.format
> > layout.bare >actual &&
> >         test_cmp expect actual
> >     '
>
> I do not think the second "layout.bare" should be line-wrapped.

I typed that command all one one line; Gmail wrapped the line.

> Your point that it is more obvious when the expectations are shown
> in HERE-doc may be valid.  Overly long printf with \n indeed is
> harder to follow.  Even though there is no reason for a real user to
> do so, asking for the same piece of information twice would
> demonstrate that there is no deduplication.

Yes, part of the point of the illustrated test was indeed to
demonstrate lack of deduplication.

By the way, as a real-world developer/user, I do periodically find
myself in situations in which it *is* convenient to ask for the same
piece of information twice (or thrice) because it simplifies
downstream scripting in ad hoc (and not so ad hoc) situations when I
need to manipulate the same value in different ways. In such cases,
asking for the information more than once saves me the trouble of
having to assign the value to a variable, which is handy when the
downstream language or tool doesn't provide variables.

> I also care about future-proofing, though.  When Git is built with
> WITH_BREAKING_CHANGES=3DYesPlease, this test would break as the
> default reference backend will be reftable in that alternate world,
> wouldn't it?

I think Lucas already future-proofed this (and my example copied his
future-proofing) by using `--ref-format=3Dfiles` with the git-init
invocation.
