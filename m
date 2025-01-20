Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11E149C69
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394338; cv=none; b=PWxLbIQ1Ot2xACWevLYxgn2zrCJHhf7/kVc8Rmap+Cqc3y1NFrUBlh2XxY3yH5fc0RFsGPvlriJnadiiKeLXt0DYsPY0qN+DztawlG1h8MHajhTx2KHcLvCJBY+kMra1yADHNvsupSNgfMVci+5g68qrVxlSn1uN9BQyR3CkaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394338; c=relaxed/simple;
	bh=pWU8J0Nu541ERAy05Zm7K9dA068gLyoFK7I5bxZ71aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AraAt3SGqHBX81rZ8eu7qzctjYQVnWrr8vVjBxelyH0vz/DkKWEIzy8CC9Wd/lZQbv9cQx+VxsaWEoXS5qtmkGSsEEpDFDjKjRvKL/f3JCSAEVM6lxfdeQwvSOKPvOeTb1lo6GhYT4ExnbAyPca9TQ2oPvhXwjgfr8StdreZvxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F03fPU3u; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F03fPU3u"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467a8d2d7f1so40485391cf.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 09:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737394336; x=1737999136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tABdKfzMC77OWeY9xGejclnD8c9M9cf85PHl1cJEVHw=;
        b=F03fPU3uY3SQyosS4q0fPL5qsOVg43US+GWKSoVaiINqTiUF7Mc+NuDaMiKDOIkKmA
         N7eHFzrfMlclJcRT/HHhDxGOcUO9Qhd9LVNlbfQuwuSS7qQ0IrdcYVQtnri0+lHQnEMc
         wlOQfqBrWdugEgqHW4Md6GtVS5TAR9W7E2yLdvueNr4IRxAJ6+BEKKoxuJoWygsFI0yz
         a17EFyq+hQfFNphcKdUjCn9O/uVaaw3DCMkK74JK03EhIDCmgX8hBLMvq7X1EZWPsqVN
         L/fcGQrLkJ5B+yGtdi3SHrZ3KlfA3XsTyZoZBLALwjR1jla/N0qdZhQwqLRSQaHXkWXR
         c0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737394336; x=1737999136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tABdKfzMC77OWeY9xGejclnD8c9M9cf85PHl1cJEVHw=;
        b=HMMd3fVXj4NRJ9MOlpjRb36IT0VMYmGvprVxnUhvkriEwwAMsyhHtOh8LPgSj5qemG
         L7VZYSrBiAly1tiuqu48y4/c7q3lzCYSrCJWDAUB+8p3q70P2IhQe6mBONNBkBPA/VU4
         YMFqYuY/zyJU4oMSW7hAV1HCi+FLzxyjuAuwo+fTNw3oDd14kcXSFnbSD74MR5yMUYxH
         tn8XfVY0k97Rk3/oXA5ah1sIS1rtPBKFd8j0cpTsTI3HSpzsMZKOJFte2lMQY594cNU0
         GlY5aBj0InOubT4fiIOSJ+g2yrYm4RPcTjDvgkplBFnyPdBNQLvC0q5sHsuIlZGGxRya
         F6GQ==
X-Gm-Message-State: AOJu0Yz9nf0o/okNygYd7dtWCn7bmDV0pdXBc8WWO6iFpT8nPTVqf1l2
	a7kdsWJaHk/q8tlBhlwTzsLltvvjo7dpgVgRigK6a+U/iX38QjcehxtPKyEYHPIRUZkK/zvCpIk
	B55XF4ub/BDB3eQPGyNk8/9NtlDs=
X-Gm-Gg: ASbGnct1fZNE+RO69IrXC2gggk9hO1JHldceBte+ctjG7sME7haTrdoApNnzH41LSUu
	TxZ0U08y4pyNPJ9sD2yuND1IJo787yPCU+hkya8Bt+mCZkjnvyRg=
X-Google-Smtp-Source: AGHT+IFntEdiqbLEO1M0ISVE+QQWE+G637aH/uOFZBJOVL4Cf1UlFO8POqbRzwg6KXl6+gtVObRsmLJ96jX8VBh8aXc=
X-Received: by 2002:ac8:5f48:0:b0:466:85eb:6123 with SMTP id
 d75a77b69052e-46e12b679d5mr212624411cf.22.1737394336268; Mon, 20 Jan 2025
 09:32:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
 <20250117104639.65608-1-usmanakinyemi202@gmail.com> <20250117104639.65608-5-usmanakinyemi202@gmail.com>
 <xmqq4j1xkzir.fsf@gitster.g>
In-Reply-To: <xmqq4j1xkzir.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 20 Jan 2025 23:02:05 +0530
X-Gm-Features: AbW1kvZ13S_mLg7lIxsGq_bEcfkjOxg3VIe6jcmVmXj7_Ub-LZbkRHVeOik9Obw
Message-ID: <CAPSxiM9qRQ2HuTJDmhq_xeCRmn+yUvjXokwEwJE0S4av9Y-TKg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] t5701: add setup test to remove side-effect dependency
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, sunshine@sunshineco.com, rsbecker@nexbridge.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 1:02=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > -test_expect_success 'test capability advertisement' '
> > +test_expect_success 'setup to generate files with expected content' '
> > +     printf "agent=3Dgit/$(git version | cut -d" " -f3)" >agent_and_os=
version &&
>
> Is this required to be "printf" and not "echo", if so why?
>
> "git version" could contain any character if the builder gives a
> custom version string by saving it in the "version" file (we use the
> mechanism when we create a distribution tarball, for example).  What
> happens if it contains say "%s" or something?
There is not any requirement to use "printf" here, I did not think about
this case before, I will change it to "echo"
>
> If you _really_ need to use printf, you'd want to do so more like:
>
>         printf "agent=3Dgit/%s" "$(git version | cut ...)"
>
> Is it required that agent_and_osversion lack the terminating LF?
> The use of printf without terminating "\n" at the end of the format
> string hints the readers that it is the case.  If you did not intend
> that, perhaps doing
>
>         printf "agent=3Dgit/%s\n" "$(git version | cut ...)"
>
> would avoid misleading them.
Yeah, that is true, I could not notice this as the next commit of the
patch series
was able to fix it. I will change it to "echo", with this, it will be bette=
r.

Thank you.
