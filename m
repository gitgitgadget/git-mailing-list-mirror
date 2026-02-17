Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA13563E8
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334505; cv=pass; b=k5FiN+w2OxSSUr4g6Hc9noL+uPplL2Npo5D960cO0j3TYr/ebHCOp5lGdyLlb2tu+dG7dW7MbiSPW4XDaQesILZAgYTV8ODS5fwq+XERjUt0xY5dbUQltGTg88NVIJVPmiOaYtnbEyi6/9V35jLb9dZRSfQC5iIQCVss9pkXXPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334505; c=relaxed/simple;
	bh=a8Y/s9oAO9KKLi14zn7VoGhicKSd98dMwGgIRzw5ZJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adDAr6tWVusKhX7iM8MUhh/Zyt1RL5bg+uDBPNx4RGscAw94DafRRkiFjsQAnKvbBS6vi/tRUxmApIdz2ymfetpzlSTTF2JNyqcKVZ6Kymnzuv28+mvO7PRDV1MIgWvomHQFkZXEsqCH8ukdHNRqSLfiG+G/FdRZfuryll/g8eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFoiwg05; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFoiwg05"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-823c56765fdso2072584b3a.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 05:21:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771334503; cv=none;
        d=google.com; s=arc-20240605;
        b=ewMv/aAMIPWgaC6XvQlWWHxNLMAecVTmZbDOGKYmoR6bxgEXbOTxdmc+SFm5CaT3Sr
         QPPpFg91Xk5HDNLCmbcp9qhnY9VajEaLlyz4LB4hhux7hOFzS+gbllGdFJ+hOmKV/6+Q
         0uEzNKv+rtVLnJUwWLXNVZ/KdrA9o3Zz6fei55jf75bG5YlmM4c4NGekW1wLlRzy2/L+
         5POGfD6ktTWjijsbRe7unIXOss70NuLN+x5cq7IOELSrJ1vTMwDUu0Q5hqPByePRt4zM
         z+Ys4u6KT05p7zmLECGwnSRnHDJQMK4yioiBiKlCih1s06NlhhrNWgO2M5GL8eQ9Kj9K
         TDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BzkAMBHYlYFznHkxzeq4W+cUyTfaxS31fZMfNMODYSg=;
        fh=sMtFedBVw7uX9XF3+AUzEpy35qp5eB0acqzaLGKticA=;
        b=Y4k5sj7Nbjy79QsyNls1duiAC5Khsgh5fhgOf+QHRD5H2CugjnKBXP8vBhx9MzUpRx
         +HPE5R8e1BsXStOIHOInafuqR8xCYyW4w92hmxey8FvSLFCRgLxijlayC8yKyW23L72g
         GxPpxKDQYgiohL/L5BupmpYHj8yo3Aq1njoYz68NWQCPFlYj3hNyxsxQWOkUYgH9DEgf
         Vs/Zn5oMoC4Ei/O7OhMrjEULi2JgekaVyvU52+wol6sAG4EphAVGfY0vTXyc9Z4qslow
         hd/SivGVDbLXVd5wxDQgkoFSsZr6oP5RAJoupRW7Qujg4ZyY7PNuwEwK9C5WhmBjOa9D
         lYiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771334503; x=1771939303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzkAMBHYlYFznHkxzeq4W+cUyTfaxS31fZMfNMODYSg=;
        b=lFoiwg058N3XgMfsK8RH/Z+te0ktnKmTT3Riaoegi25DgdOsHr88kpNFXsurlqDAcX
         u5jLa4f8jslWa4bGIQwFRp6ufFzcIJfEAf3LH+fnYrL/XvuKsthDkwwrj5XVMaChk0Jv
         wI/7sKWfVeVg6djisePkiQDRFMb79YIXWYIsJQur65qu61R25/k5fS9Wm/DACIv16S9X
         k+aDSfAaIDYdmxiZ2k3bfikcEahQj+EtWIOk5xwTQfk13ekVcw/zKSNbIevzCCWs2W0y
         tXqL1t5om2d8kMCDw+gohrPKEMpUY1vUIHrPS8Lg9COCWwiODhUEuLNozhi9UKQVlB28
         GfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771334503; x=1771939303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BzkAMBHYlYFznHkxzeq4W+cUyTfaxS31fZMfNMODYSg=;
        b=as/9YDJWWMCfLajH//lPG3DjrYeHbcJ4OMr/lXWhv/hVPI/F7BCwUekj+Dbw4Q4I5U
         vSNgzQEIhIb11JVvsZdFTlCMPf930L0vHf/JWzHJDjwqzlfTBaEv7A6eQwdn3sxr9o+V
         OO77QKwqPcptvU6p6Zi9hcB5t2YWrA/oe2JhtRXoJCcwNJcngIDlAhiCnkqk/OlpknSz
         /PTVwGtovzcaJtIV5SvK3A45WLQns7GfWb+msiUoCEA8ge3eJdM8zJdoCetHdtdZw1tV
         UbTXdHPbthQ+qjwfrmFoyoD0LKNZc9Inevb4Ex5nVsuNZnw/pAjVZRjBNWLcPwZD/VEi
         jvGg==
X-Forwarded-Encrypted: i=1; AJvYcCUgL01UJXMddmhTY768Br4EVU359nIx0OtZ/B0rjhb1FYcPl8SvPU7DdzAgwZlZ+07vOs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydF94CELFrQy3CMYQuwYbcPv0asycRM2RVfgBX5nVkpqcVUJlH
	mf6btf3OydqtLFjiT9QdZaQDHfnKA0qIzqTI7cvALw3K3/UdSo9HA8PBzV/lwQ+eJXJ2fFKOP+W
	R65crwXk18XPfWkimaKR31ud/H00yKXY=
X-Gm-Gg: AZuq6aLY/+4Vvq2vL4FkWjtLEb/hrgECPVRQWpC/02La2PNN5rpowYcUL4d2nZ+HRui
	XxyFhZhWQ5m0igmmQXyIrMeP6+IovD4sze5AQLSMJo3KP32xfXuE1bppQtJPd+bUQqsvbvsGEZX
	gjuDTHroIycU2HIeK2vfEasoG7Jjq8etdQntuLVhLEAokTPNzUN9l2nvclyi3+IdRc4s5xsVzY7
	o+1rk3G3o9mb7jI4ULJVnh18WixBHYgn0TQQraLXjt2dUJqw36vN43LS2fSU7XfoUo0bGftMsbj
	xYkPNf+/oYjfFTkG/lJq27KiJpdd8PcIyjNHi6WeLBKrr0puuqrBWs7mlVHIa+ZYkeiRtbCn92s
	bshJ+CZKxTaphcVd4J5IebnrICw==
X-Received: by 2002:a05:6a21:9148:b0:366:14af:9bd8 with SMTP id
 adf61e73a8af0-3946c913544mr11697158637.78.1771334503427; Tue, 17 Feb 2026
 05:21:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZAMr6XOwKkTa55q@exploit> <20260216152730.37478-1-mroik@delayed.space>
 <aZQJEDyUyMv4_c1l@pks.im> <20260217063400.GA101988@coredump.intra.peff.net>
In-Reply-To: <20260217063400.GA101988@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 17 Feb 2026 08:21:32 -0500
X-Gm-Features: AaiRm53VQNNPzJfvNaZF0mPGhKqzuuKga96jPx4sHC1PXnr8-kugEznPEkCyHVo
Message-ID: <CALnO6CD6c36ur4cxqNAB=Jy=m6yxVfoSzAAekewQZr2vjjKn2w@mail.gmail.com>
Subject: Re: [PATCH v2] format-patch: fix From header in cover letter
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Mirko Faina <mroik@delayed.space>, Junio C Hamano <gitster@pobox.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 1:34=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Tue, Feb 17, 2026 at 07:22:08AM +0100, Patrick Steinhardt wrote:
>
> > One thing that made me stop though is the folowing sentence in
> > git-format-patch(1):
> >
> >   Use ident in the From: header of each commit email.
> >
> > The option explicitly mentions that we use "--from" for the commit
> > emails, only, and that may be read as implying that it's not used for
> > the cover letter.
> >
> > I don't really know whether that wording is intentional, and I cannot
> > come up with a good reason why it should be. But I'd say that the
> > wording is something we should adjust.
>
> I think that wording comes from me back in 2013, and I just never gave
> any thought to cover-letter generation by format-patch itself. I never
> use it (and I probably forgot it even existed, given that most people
> would use send-email's cover letter generation, and I do my own thing
> with mutt).

Funny: the send-email manual's main mention of cover letters apart
from setting Cc/To fields is in an example=E2=80=A6

           $ git format-patch --cover-letter -M origin/master -o outgoing/
           $ edit outgoing/0000-*
           $ git send-email outgoing/*

=E2=80=A6using format-patch! (Which is how I generate cover letters, and
probably part of why.)

--=20
D. Ben Knoble
