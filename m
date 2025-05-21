Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2201624CE
	for <git@vger.kernel.org>; Wed, 21 May 2025 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747863635; cv=none; b=nS5WfF+j8kFDbHGZPR8qeLy9ZbX77fJzoBc+a8FcZb8v/q8Rcac53wZrKs8UL4ZxIGnd6qDz11F3+/axfEtZ0w6pm+VJbqGrt4gFJTMbxV6IrxqP7A0/k1i48uPYE80k52fFJWGjSHtoNTIFu8hhzYnUzcF2IeaWgI3Ycvo2SMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747863635; c=relaxed/simple;
	bh=aS3phiSeuuLIOvAypL/agl1tmHCxHc9ja6VjADYhv2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkMaIieHRgDS3BhMqY50zEJyEsMc/3QhTO8hN8elb+hWMapn42tfAhyK5CGVuGqbpeMDzT1+ZZkzuT4yKsyadGIDoErflIRyZ7J/qAXHiHowjfKoz+CZ6ZHISZAduRtS3Y5OrZNAaEHm69q92CYckzQL30e2dkPFOOqOh2UkBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMXqc7WA; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMXqc7WA"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54d98aa5981so10827422e87.0
        for <git@vger.kernel.org>; Wed, 21 May 2025 14:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747863631; x=1748468431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR3au4b0Doso24uLm/LDeCE6XD2AoSBWx6x001EqCRQ=;
        b=AMXqc7WAiXkGuvUJpeZQ/raADnCzQ5NtURQJU1lOAAokk5YLbD1QvbLWpqmlHcSvlb
         R3rZwuKxDfmxVWWwai6sum8Fp4HyJPT6pzwrogdhb9kT5KITTn5Magkbi58SemnxXXyx
         I8jGUSbdRp0ZVrjd0F6jAG/XQsU5pJu2waN3Y9M6Z2m5MnsOLh7W81RFamli17rrr14k
         zEEFPOsVomCT//JLjLHe4GIBsQO3jmkXghY2pedhV5L8dsJFFRXlztVy2yUgSPPXZmf9
         CNcmVeqM7epOysUSGUzzWREHUVvT41sWo9q7oEoi/zhnuKthuvD82BNE6qD8yVoVBs3D
         U1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747863631; x=1748468431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BR3au4b0Doso24uLm/LDeCE6XD2AoSBWx6x001EqCRQ=;
        b=Mu+vhiZcuW4Q3VNcQfPCuQ+L+MYep3u9AjAsBfv+NTSvpD/qEH554DITVZfX/b972K
         fCqEmxuC5FIyljiLPJ26aZx8zPYjPTdtZGwJEGbPRr3Nm6dXKetF2NWfo1TnfA/lYG+y
         WC8Y+xAlK0iLgxgaK+UtEiNnQnmIupc+Fm305E5JyaXNPSoQKKyCManwfUmSbaQ4RVU3
         cP7Gv8Yq6ZYdDgb+1aVCbfKam1hFw0TkRxl6Y9L59fknZGPbgIrFfjnXnMpLCxZCROKZ
         qcLrdlA3F1SKkiJ1QuVmdviXUO/TqO85csysMVuIVATwxz6CHcIXRYDXb7SYwutEcixu
         mwsw==
X-Forwarded-Encrypted: i=1; AJvYcCW+oi26Eynk6X2u3ayrfiwh0WRhavRex/vNKjbT1djszVpSSsEKxCgWbwokTVteC6H6ITY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5/FFo+jnSIjSxUqwKD8l8phDXHuIzqL9awBBJvb+V99ZxI7r
	TNBI1MUxGtxH1IkD004C01jTeZGf6ldRJLupKQPsGhrvPYH+0ZaMP/uicKuTLy7rpD85frnY4L5
	GGV/IEMtjM9OlqY+9BBJm0VbgyrQQfQdujPEs
X-Gm-Gg: ASbGncsML0vaQRexqAzbcn6jyiqHT5MshB8fVN6dnS8VsO9yD65Pfx7tTc1wXNwKsrP
	vE0pqLD+022MM8OY0YSJjA/NXTlVTd5/csU+xSryYGlR5O6OGGDKz2WjjYAnSUo/b1Jt872RAbW
	XM09DR1ej2E5SCwfHhw18zLHAxZTYHTfRs1B3F8yy5PkHaH4EIaI+B2sr2CFT4HEo=
X-Google-Smtp-Source: AGHT+IHY3ASDQsxKt4EbqhMOoVh7Kqhmmk0tq7/K19CG0F+eyBS6Q0PUn5uu/8Viz4l5I1AnILoGWt8ro9hEoqma1po=
X-Received: by 2002:a05:6512:b8d:b0:550:e31f:1d22 with SMTP id
 2adb3069b0e04-550e71a6739mr5758541e87.13.1747863630853; Wed, 21 May 2025
 14:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1970.git.git.1747827645129.gitgitgadget@gmail.com>
 <pull.1970.v2.git.git.1747858585623.gitgitgadget@gmail.com>
 <xmqqecwhaemu.fsf@gitster.g> <CAC97EbxRpG1ecWcQ=yJHnqe7gXYG7BNo1sF9e9Kf-EOkDySfpw@mail.gmail.com>
 <xmqqo6vl8y81.fsf@gitster.g> <xmqqjz698xqb.fsf@gitster.g>
In-Reply-To: <xmqqjz698xqb.fsf@gitster.g>
From: Alex Mironov <alexandrfox@gmail.com>
Date: Wed, 21 May 2025 23:40:16 +0200
X-Gm-Features: AX0GCFtcgqyJV8H-fz-Azjoth9xoLyvHdxdKePIOrUL4kUvZn2bFfLnkd2zz6Go
Message-ID: <CAC97Eby+FQd3p5YVqgvvaYuxKD1yoUPWJ7RSuFNd4Gd92+ZSxg@mail.gmail.com>
Subject: Re: [PATCH v2] name-hash: don't add sparse directories in threaded
 lazy init
To: Junio C Hamano <gitster@pobox.com>
Cc: Alex Mironov via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Junio,

Thank you for the feedback, I adjusted the commit message in full
which hopefully makes this patch clearer. At the same time I don't
quite understand the need for the perceived hostility - this is not
some "fuzzy" words, but the messaging from the original author of the
sparse feature. I certainly understand your desire to uphold the
standards of contributions to git, especially from the new author, but
I must say I feel quite alienated by your reply.

Nonetheless, the adjustment is submitted now and I hope that further
contributions remain welcomed.

On Wed, May 21, 2025 at 11:23=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Alex Mironov <alexandrfox@gmail.com> writes:
> >
> >> Hey Junio,
> >>
> >> With respect to messaging I more or less copy-pasted Derricks message
> >> from the original commit for non-threaded init: please check the
> >> referenced commit. Let me know if another wording is needed/preferred.
> >
> > I know what you did.  Copying and pasting others fuzzy words into
> > your commit log message does not make your commit log message clear.
> >
> > I already said the given message is less clear than desired, so do I
> > still have to let you know???
>
> Actually after re-reading what Derrick wrote in that commit, I
> notice that you didn't even copy-pasted his message in full.  Here
> is the message in 5f116695 (name-hash: don't add directories to
> name_hash, 2021-04-12):
>
>     name-hash: don't add directories to name_hash
>
>     Sparse directory entries represent a directory that is outside the
>     sparse-checkout definition. These are not paths to blobs, so should n=
ot
>     be added to the name_hash table. Instead, they should be added to the
>     directory hashtable when 'ignore_case' is true.
>
>     Add a condition to avoid placing sparse directories into the name_has=
h
>     hashtable. This avoids filling the table with extra entries that will
>     never be queried.
>
> Notice that the second paragraph here makes it clear that how extra
> entries would not contribute to or hurt the correctness?  You failed
> to copy-paste that crucial bit, which ended up making your version
> of the explanation much less clear why the change would not affect
> correctness than it could have been.



--
Best,
Alex Mironov
