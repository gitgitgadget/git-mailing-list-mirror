Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A33C47C
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882841; cv=none; b=hEN78Nu1aULpJ3Qw09E9iZ1dd2ViJ4Rz1XE/XvhFaLFR8Vfsq4y28sIRPPPoPA8LHFDIObEC2BZnn/eClCTGquqxa1/iuVC+iOjhsPOQGCehO0k+1p3mqLFRiAe1iM9GBdeVKENymwseFu1siifTtdKa/2+sQdL8NAMBwa2PYu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882841; c=relaxed/simple;
	bh=eHPd75++f/5152fWWsiJH9abzodxti5cpJdM2s7lgws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P63UTubcHyrG8x3IAyC65BI0+8kLD6l6hkflNA36OB8P9gVAOS59QbU+feBEJUB8g9j8v6IgRyziag85Kb6C4Es9LEgAE7aEEW/Qo5R9fpSpx8fd/8qbYcO+k+RzFwyVLJpL4vWSXOIRDQnDtYmDw6ZeLxsg+ntVRtMrLSTmwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-429f53f0b0bso37205901cf.2
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 14:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710882838; x=1711487638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHPd75++f/5152fWWsiJH9abzodxti5cpJdM2s7lgws=;
        b=PMGzfX/ZEG/dGtgYEeNBQpBJMAUvxYKkN8Anq1cYDkKAHuxbmFFRwEr69orvMZfiXI
         zD4fRYrA6C7cPF/VvXDm+I/LycBanZ87yp4vSAowrAIky2kIhISBNFzacP2Yg1mRWhR2
         wljamob5CIJYZYvQzTCE+HDZOmBZYUcu6WI2lSbcYZW4+SYVZ/bJ86/DDctS3BENu9Zk
         PxPJ+U8DbhIQ9PeqrnlOTKToKQo77WQEjTHAKWNi+/4jTdxhFXkFglfgl6AbGzb8z7HO
         9qYW8nmszMdNKMJTXClBmHcD0zy/ZYr2vc+oKehfuFI8MTQd8PVI00YMJ90rkUk9MeHQ
         9o8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeShhHYPSVaTqSroYBy3ng8bzVTLFUfzciXFAZ6+BffdspgnlE8xNPtZX1V5QWiznLGXnprNi0QZpVk+1M1/uuhe+p
X-Gm-Message-State: AOJu0Yw29vHmRJgflZQSRa2TcwGRuaGGbkaIly67rSDeO4D296XHP7Zh
	wSvxYmyjtE9OCSaYYre0fwgDfBiiScC5nRyez375uDGl5figaSjnMKhjfhl3Xs2QF4kehGTJjrd
	GAtyVLjjv6n9anLCrBTs7ulWzirA=
X-Google-Smtp-Source: AGHT+IF+ZVNNooSrn4t8ASiEYGM+b9W8JNIumYcVKWlhCoEmQJghW+3fxd/ZgMEdOrzExG5rfmCCVavVbOiAvcLrBG0=
X-Received: by 2002:a0c:cb87:0:b0:690:b3a3:2261 with SMTP id
 p7-20020a0ccb87000000b00690b3a32261mr16327772qvk.53.1710882838685; Tue, 19
 Mar 2024 14:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309181828.45496-1-ignacio@iencinas.com> <20240319183722.211300-1-ignacio@iencinas.com>
 <CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com> <xmqqa5mulycz.fsf@gitster.g>
In-Reply-To: <xmqqa5mulycz.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 19 Mar 2024 17:13:47 -0400
Message-ID: <CAPig+cTFRAmzBGiJv2F-k1XWvGSbT8UeAG57T+XpB-1w66HRkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add hostname condition to includeIf
To: Junio C Hamano <gitster@pobox.com>
Cc: Ignacio Encinas <ignacio@iencinas.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 5:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Peff felt that adding `git config --show-hostname-for-includes` was
> > probably overkill, but I'd argue that it is necessary to enable users
> > to deterministically figure out the value to use in their
> > configuration rather than having to grope around in the dark via
> > guesswork and trial-and-error to figure out exactly what works.
> >
> > And the option name doesn't necessarily have to be so verbose; a
> > shorter name, such as `git config --show-hostname` may be good enough.
> > Implementing this option would also obviate the need to implement
> > `test-tool xgethostname` (though, I agree with Junio that `test-tool
> > gethostname` would have been a better, less implementation-revealing
> > name).
>
> Yeah, I like that show-hostname thing (which I do not know if "config"
> is a good home for, though).

The other possibility which came to mind was adding a GIT_HOSTNAME
variable to the output of `git var -l`.
