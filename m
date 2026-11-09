Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.216.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794228526;
	b=dxFwRPeYLAdMCUrYRlkp2y73il+CMEUpxsjZZOTI4sUtvEs7GhVVctjOeXUSKxZ80h5j
	 0D1l7bPOwvg4D34xxaE80q3p+zrdJoSotmuVZH5npsvsMhZgeplGXMX9ec1niEnTpR1Us
	 IyuP0PWSiAiua/8GzMnFaWYkfdrf8+2pIR/M/G+kAyCtyHQIyB8vVyAZzGwAGXQqfF2dq
	 HdVNAUYPFa4wfP6afUUsIKJfNENFZdeI6hM341ng/yhObFXiftqbp+pS+8nuT2ekfyxzo
	 Rk0t/Oe+JJgc/0DW05es/VsWb51TbKYg+1PxrffsHx9aFQfmO+vEvaiszVqt0PGKtQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1RypJESWWJdhMupeBDSlDLwTy0jPEmCej+0o6D23f3c=;
	b=JO3ZpC70bci9PDak1fuGBxSgFEN85XCYVvCKjbSnP7a4sO7Xe50vatN6m7uPbqro36r2
	 O3PAXCdID3gnQW+2qLDcUgdZLCuPKl27hRZFLMor6Dv9R0ZhEMPXLpCyE9ApZehFYo7G0
	 OGYQkyRrdlRdm73XSNKldegUm5JQSFq+XQJGq0ArD6/xIGjZqQQuPeJVsf2lMAE+so7xD
	 TUJAUBVPe5paEsT605W1R4EZxKvJBcNqFL7GHbUsXN+mDfiMBt30hA7rc7TwjHpxoBDyE
	 I3QBUVkHsiH+g1ZUAAAYE+JvxZuPA1K2CpW98jghl+AwQZ8q7iWLPjEH4Hf7276zwfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BhMcyZKO;
	arc=fail smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41259606A339
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 12:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41259606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BhMcyZKO
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so430494a91.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 04:48:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794228526; cv=none;
        d=google.com; s=arc-20260327;
        b=re6D4IU7FMFYRrMet99pGHkHFLz34245B+ccoZgwi1iz2GEek7TybpR/LeI3Xcu55F
         txIUSzLXcF6tQDPhteyvCyrDELxVl9RwLUUvnnm3RDn/DlO/AtbqDODzm5d/G4M33cRn
         4fgwG116+/ahPFOdtmfJUZ+ngQafr1FY0Nr5XezNZaEnEm1MWykcK6G5Hlubo+kTwLSy
         4jfNhbHYADEKifD7L5b51hHwyYNPF3y0l9pdvlLysCBNedd/k93M432wWm2TtBLch3Z3
         +Ai8mI1OgKvU/VkQFQjC6P9tXJQ8xanqpBUuV/axa2vG4mwAac3pShAKKCv3ZlZpCH3K
         jUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1RypJESWWJdhMupeBDSlDLwTy0jPEmCej+0o6D23f3c=;
        fh=X+S42iq2wEi6wq+Xh73cj886RQhPvFMjgFdJNOuGmIE=;
        b=cWOyTlEB0/0wggi1FfC8IFhq1s3NSPGzWEn+GNmgVoXDXs2ZWlTGVfeOs945w3QrFa
         EyStQKbFmVoDK7zlBLKo2B9bCRVQRfFmg6ixv/AQqyGwyp7RXIRrqPSxVJO+GuTCfwVP
         9rs7xVoM0w/80kfGMxYGM/X9qY/80EKpcg/jVl1Jq0k9Be0YrkFB6bMVas7hS3FoLYvh
         t2foxjwpCK66kqSe4P4CUjrI6oS81M9FUMYOrWrkceWicJTthrl909X9ec+3XIa0v1Bq
         STQ8zFF9WfeVdJaoJYn8fjX7l7bIgPvKB5edkUOGOwxXA/4Sp/ocMxaSLomBEbalsmv5
         ThyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794228526; x=1794833326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1RypJESWWJdhMupeBDSlDLwTy0jPEmCej+0o6D23f3c=;
        b=BhMcyZKOQCTixGX5KAskm56nIP4ZxfLrFeaMjyNT3HYCX+hNY1LhuAhQK05PZukc1Z
         4BtzvhPCtNOUIjf/eS+cJIv7z41zmjCJFFso+keMfHtoVnQl5/4WZyY8DpSIuzbfbs89
         0iV1ixT1vHfUs6c6RV0JWpweFpHWWKDlEX5DnhS2XhCE+1xTGTrXi7SA4EwetcrBWHtm
         keMgiXlC0Vz2h3LJsLetOZ7CEJ7gOcCyJqKMCNEoodYZUcrV9w8dAbaWcNcEfzQkHjiA
         cwDIduAfdcJMdOBdV/Nnqttztr/sdu+6b53xcBq72U/t7DbVF1RNNXA7mZchh/ytO1GL
         P32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794228526; x=1794833326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1RypJESWWJdhMupeBDSlDLwTy0jPEmCej+0o6D23f3c=;
        b=p2Slg9susTYn1Exv+F6IJ056AgNEdvYMNqpOmUiau2TtdZ58i/MjBF31/aHbBpswSc
         E5fHuNqfyk/2EdQJJNFzrHiKHvqJNpvFErp6aXaWjyOlEL3moOsQlWJv6fJwaeR9HzjZ
         38Q8+vnk8oaLkVrfA5rlRxfCp7iPe05hv9CdlSjoAGighop6trbZ0VfeLeGdgF32ufd2
         4yTwoK4Y1gRom/gzU1rZUgC2tg55kf9A/fdEkmGqulvXoLZs+thm9WyTptLNfX6lvtdZ
         /vy+Rettc/AAseFyXbI+HGkJMpeFt6dGffF7g+mNWVKN2PL/TE6dFV/9p8+6c/iXhyZZ
         1XAw==
X-Forwarded-Encrypted: i=1; AL+hErE6HKv/N3BPHg6ja+AD5NIbVxbyQRXyMA4rDE5KmZ9bTNRAf6KNy35ZUcVamnVPiTytsvY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Rzv0SDBtxgvlgR9o98ukiuAdeex7iMHNs+NEDPO8HYyzQ/zlZ
	SKYGnxS4zzZuXsDg3CTUopfacBMTH8C/vZpQGo/3kuHzELU0qf2G+A0vXEkf1U2vkcxCfWTpN6b
	tWmeLxe4ePnwV9GDt5okvotLRkcTeievTFIgDUKI=
X-Gm-Gg: AYBFou33dOAemtY8njYIAM3F+yev6FIeaEhthwPFqsVXGNg+0wGNDtaQ90X6aknsJw4
	qpLtFwkjLShPUqIVCnwsSRNxtLpJfMEpU3D+9hNvon+LYA2xxgdZTd/8NfEHxI5sW77BBfHoyVN
	igGAVPSqE+7wwp2D7KAe3PGE2KgSAzutIZr0irjV2gmerBk6R1svXlwO6hKr1ulcJ+KFch6jws1
	/lZh4VrWYhTYLm2Sd8+wiWElA3uDa5J1ZXRbOnTXz6+u+FCU8jj4WuRVaM+TgzOvYIXCtLWZZL7
	+tqip9Jgkc0LfbRCUncB2KfFm2XOKaKIM9SPClKqALezI7/eAIA1uVV7SmZQDz7lxnGWoZByImg
	aNmcmepodslBwmOa0gFf+LM2M+U3m0vBDeFQXaJZQnr8UTbmcBSh9Bw5UFah3v3yeYHuwKHM73t
	+2r/zDfvIOSa3UNQMd3LldUjDDa/dqI1o8BO2STp1NE5Td5uPQIcG3jGBP5oOheU4aRpLq3PA6b
	jKldHQKQD+QpQ==
X-Received: by 2002:a17:90b:54ce:b0:3ac:7556:8eed with SMTP id
 98e67ed59e1d1-3b12d57c488mr3443954a91.44.1794228525343; Mon, 09 Nov 2026
 04:48:45 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
 <pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com> <xmqq33tfxm2k.fsf@gitster.g>
 <xmqqse1fuoof.fsf@gitster.g>
In-Reply-To: <xmqqse1fuoof.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 9 Nov 2026 07:48:33 -0500
X-Gm-Features: AclHuK9N4EudRt5Kjks7vuHJ4aYxhvN9aP2eFHhFm56gfoNP-6OZMSXPSPqcI2Y
Message-ID: <CALnO6CA5UD4e4EHhJy2Ng-JOZcE7saBAX4fbDaDLK3B1OhBeEg@mail.gmail.com>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 1:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> Clarification.
>
> The point is that there is a difference between giving wider
> exposure to "--staged" as an accepted synonym and swapping offical
> option with the synonym, let alone deprecating "--cached".
>
> You may have heard from several users that they like the word
> "staged", but I am sure there are more than several thousand users
> who have been using Git since before the synonym was introduced.

For sideline readers, some of this is documented in "git help cli" in
the "NOTES ON FREQUENTLY CONFUSED OPTIONS" section.

--=20
D. Ben Knoble
