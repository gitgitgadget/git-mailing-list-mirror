Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9955322A
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765332820; cv=none; b=lYVfrxvQvLNLDGf1le3EDzxR02i1Sp1f11Had++CsnIOVhSeMV4ib386o5Hu7KBS4P5QaC8nUjzAIJvrQDixwypuJxLFUjuAkgbUI0x3A4jFNyQhkDCx9px5mxeXceSLhAlu4EseUMZ8AfftsyrRsSiEFTIIeHa46P124Jdntaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765332820; c=relaxed/simple;
	bh=1ZdsmuIxErm6LsMY6VrYwozCWDhisRiCFzcYXqu41ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eH/LLDVy92gETOKmJfsymV+ClxUcSem+GijQkIBvc9PCDrYIIskVS9kaonucs6q+SwmGslm+xkyyCaA/UNlhw2/4qWM9CdnZl457yYavQFN+UFXgW1lpkgbL7UCiXSc5P4JIgwtWQm4bnKRYM7Ke6xzv9GXHO+8LpVroGMIEchg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2aSJl1s; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2aSJl1s"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c77ed036c3so299295a34.0
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 18:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765332817; x=1765937617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKcJkfMlwPaGjDS3ckP1eCxYPj1MU7Vt2e+ZX9K+e2U=;
        b=T2aSJl1sbGVagC8HxWa7MLjpJLWMQ2c45ZQdMpcFoTkQejr/2eqlAx6tpADN8IR8Tj
         bFMhIUdww0uDtVtBH/ib+6fcaA3WAKgOY2BfQN++FSVdXrOMCzUeQISeCCSztI4us31L
         W0EUwdsXe6JbJ2xbmwuAvYi4AVUqtYwtyFkwCSqQvnRsb8dTTBedQiWhc7CTnGosNsHP
         xYsj2vybGf3sw240uCrP3euAzQ+WLPwfCrdQApyxFIgcpxC8+Jh6a+Tts5qTgBJlf+hi
         D+PFj4aiNsRKhoCskXv7lPBgXw57DAnCRigKYAdLoTmcTTekk2OjAwTeDI1uot62uAuS
         DLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765332817; x=1765937617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKcJkfMlwPaGjDS3ckP1eCxYPj1MU7Vt2e+ZX9K+e2U=;
        b=kJsJ5l7wMSutBTCz8sKpUzOr/x8dX+Aa1JSQbBcQtXMSYVcT4TNxHojUOawWqzhmAi
         3tITDwjvFzar6blvZ50u+i8fRde2UivMkCWbe9Qv0Abo+SFiH18Ko9C0LQSsRrZ2UeF9
         j8I24kapuhKx7467xWuUYjz8pXzddn1pvzZpbmIVbU5Eb307BXtQd4LYrfoq/d4FmSZf
         iU4ciDGUCQKK/YTgFQkFy6ZatIwGYqTHIuV7d9g48JnsTxgyy+5kj6f+y2dlSoMhZpHW
         gmCzctgBPvaX7d3GammGLt9Q6DYRuQX4LMiEE1LZFkRcLQVUcbu9xg0JtmsO1R8Q3bBS
         j9DA==
X-Forwarded-Encrypted: i=1; AJvYcCX7d/kVGq1GB2EXTFxrC1W+dnsALgO24N7dL5m/7Bo1Q08Fq4k7/NrHU+/HF7v4TaVQ+Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfteE5nA9E2c9cNZV+X3RuGSc2cHTgJ1HL+hr6shQpbRQaqnM
	M/+n1k/BSjDBUS0EbkTcrlTatsqK/ci6LRIeYINFK7Fq22FHGJ0pYd0Tp25ASk7g5mSwRb7Dg01
	ucgnTWCof01rPHGcLBWQtiwXOJ0ookEg=
X-Gm-Gg: ASbGnctWPyuYXhYX52OMFd7FRzyu84B0rQD/6qYAt8quoY5Xy9kM5g+ThsuVopKgHdv
	7XVBErYXBhISc4O+YYCfBECN1gvcr08L7u/HT/mKO0da49va60f2L4qccoU0S/5hzgYeQwBisgp
	NBXO/Gf3VnWMKs6iUIDXNvF4vKqumlsjhu3TFlDQnRTibC9MQf1T/Zov0hkV9pvYovdiOIJCra/
	SlR26S7IQ+o41Nc199ldURT2AgrjQCJOoImvJkm7+M11o4ikDsbcm79teaXkFVktpAQbQ==
X-Google-Smtp-Source: AGHT+IH4Q+pieQGBzOEibxCqygdBxvaJH+KzhlBlT3SW70ZTfHhp8nAPiuyFklv11aLIC4uJL1h5J7beqCMn8dYwWnI=
X-Received: by 2002:a4a:dccd:0:b0:65b:25f6:e86d with SMTP id
 006d021491bc7-65b25f6f539mr1256069eaf.34.1765332817590; Tue, 09 Dec 2025
 18:13:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FD2160CA-DD56-4BDE-92B4-0859C3BD2396@gmail.com> <xmqqpl8ni7bo.fsf@gitster.g>
In-Reply-To: <xmqqpl8ni7bo.fsf@gitster.g>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Tue, 9 Dec 2025 18:13:26 -0800
X-Gm-Features: AQt7F2pJVtV79wJoUD-aJ3UyCZweBVxS5w2b2NCa0SzNRDkpgCm2mBxKaf9NLcs
Message-ID: <CA+P7+xr6HHCXsiXi=CDm=rccNO4b6gmjLbuWt4KLAEwSs20aww@mail.gmail.com>
Subject: Re: About --staged ang --cached
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 3:07=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
>
> > Do you think that it would be relevant to add --staged to the other
> > commands just like [2] did to git-diff? Perhaps this is just a personal
> > issue, but I find it curious that those commands still have a flag name=
d
> > after an obsolete name while newer commands are using --staged.
>
> As long as "Only in the index" aspect of the name is kept, I do not
> think the exact phrasing matters all that match.  The distinction
> between "apply --cached" vs "apply --index" must be expressable even
> if you swap "--cached" with something else.
>
> Would it be simpler to remove the label "obsoleted" from the name,
> and remove the "--staged" synonym?
>

I think it makes more sense to add a --staged synonym to commands with
--cached, than to go back the other way.
