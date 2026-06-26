Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE9437D13A
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782516402; cv=pass; b=W9t8NSisoJ0qK/sE09bbZ3LDLKZl1FeFTl8G1BQwy071BvRojd3aDTWF8CdIJaF+8fH60R5LeWUuYKY24ZIbUwB1/r4bWRilKungW1cnWfk1Q19ND1Ne+ZPSFej//FDkYNaVSMObjBW6qJ/Dj0RgS7GS1qaHT0x0rF4JNfktN+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782516402; c=relaxed/simple;
	bh=RnT+H7H5iaUrIPw+Bgq9/E02+9wn9ZAegqmSCIuNcVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tql7q8PM/UwJI5ld0n0qPQ3kzY+qWYxmIjLdCVUTv3YV0P1iLxAqn9rrS/jDmDQAUoB4FF/hkx/d8HrhOJvdEUnmVjjFYGesohCReMFEbPrJAd6aOdhvV+FyX5pKyVs/QpSs8GI+0RahdhiRzuw7PrSqoLh45AvFAQiipy9mWJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys/QVB7B; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys/QVB7B"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69de16f5e80so753062eaf.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 16:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782516400; cv=none;
        d=google.com; s=arc-20260327;
        b=Le9BLBEAp7gQJjK3iO7oxaOEb/sZH8uPjwvWrwu7apRf0LnlvZLNly1DGj0qgE+cg+
         XK1lAfrtRgax3VMwhuyypivaVluBgc/T1sc34KLjmBhhJGChi9alTwRp/DLuLZsZpZz5
         MHiiVUCIaGyi6bhvZzBUX+Org2QsCJ8mp8ARvjhbGlYXXIDtu/42Rw7m468MznEVNZ1K
         cW+ok+OJdnVGU/HxpEs1mO7CYFfEFJiQ94lKq/I/e0TfRl7FnS7e4YMRngAJh6xbAf04
         x+sGYe0SlLtvBrRJeN++YUjz7FfiSIAJ7BS7TYJBsf9Z/EMIeKcpL2Jkp96e+yrpKK79
         l8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RnT+H7H5iaUrIPw+Bgq9/E02+9wn9ZAegqmSCIuNcVc=;
        fh=GstklGvbfeOoaYV3DapNyzuOHNjT74/wb/HnJS5oUso=;
        b=F1bKSWWbqxwhLaswEYO+CCAIkELmzIXxh5WBVJaPgVcJ4efRvahOqVJqLNZp8rMEP5
         jo4p1AubX9CywJTWdiKrGJ+Jt5DXSBtqTFld1RpMcxOoCSUJiKdQcD/6VEe1mxNiF5hk
         lWpXRnXGI3SnSb9HZj7G4n4/GX1OQtCx8UfqWu1kNp8Ynoc8/B6ksPtiyt2xCQtUxXow
         /hBJ8mvUrAIH5JQq71v+ngB/d7Os/xZgaJO2gsxuurijRFIovzPNeryiD0vvNNk5+yF7
         rSbUVht3L/7MhHUoRHs5cRmyQhijvT6hQ4oiFonzgzYgUjBdobzoWZ9lnBKNOWLy4b/4
         shxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782516400; x=1783121200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnT+H7H5iaUrIPw+Bgq9/E02+9wn9ZAegqmSCIuNcVc=;
        b=Ys/QVB7BhCpwWbcICZbQjOIRquJNsFJtEME+TRwvoUUWAu7K7pHHcEb6Wxl/lIa0JC
         QphS99UZKdNG1C3Pnto5ONSEa0CZl3SqgWcKD8kbSx7A2EXwL4cBZ1YaCVNwXmdwjaVS
         vbS6apPo4bvnsDABHZYDS2lcVPETAsP8XLlbdOd8R75qpr6BAAR19p/hpVn58KQmggs+
         uML2809Z6jp5BTGBI8n7fcYqF65+7mp4jVl6GNCkk8Ivoa1P8yYMdDIGV8yJFZdwS5q/
         ZJ764WxIeJZL7HMXedgf9AE2K+5gSu8Jh8hdwA4hPdeyEitqH+uynREt9lfCgLRKmxKE
         KBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782516400; x=1783121200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RnT+H7H5iaUrIPw+Bgq9/E02+9wn9ZAegqmSCIuNcVc=;
        b=S0twCoFELQvRLF4m757MBKyZgbYm3G65bcSjr80P7mQV/s2ILk6qvOZ+6X6D/H4mOe
         MNuws/RY6MrMqABWxdQe9WgcX99liqgafoTz06trsRzAAnIiwk8RY4yijQhMZaYNv90U
         25lO1twLAyM/HDpWdELpPAbJmpFy4U4iO/SUAJsSAc7sWmoTHTHM4IetBhEayCTaBw/A
         +cri1+sAmaQrL3Gk74eGuwUCITBVI0KlkwhdC5PQY8hYJQoMnx9R+dTFTBXww29wilPW
         wcriF8mk1mcaCFYhghCOCozbdUxUkPhA9SOl9Me018VN4Dk8T5nbJU/T8HzjQJY6lwYZ
         IBbg==
X-Forwarded-Encrypted: i=1; AFNElJ94/T4Z+AuAfj2sWltK4dxNlepcmGybhfBJ1tPQ3zeHBMo1ntnPvOTGX9LGshv+EZoH1qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQMXI/WE804wosEOmOX4RGmr4GUPUMPvSC6H98GKRGs5ZV/vDS
	1VRXGQMh7SXEwyK5whOk5b6Hjf83RCO1AVkuwvfW63Lrbvv9aEQzMX05ycwpMR1j/lqFgfAxadI
	1NvR44ufCtdrUcT4W2Ci8Skmwuon6Vj0=
X-Gm-Gg: AfdE7clU25KH4aTtQYY3o9BDnAqIrLZP2gdARy9I/UdgulKKXxbjbTftEhJVsl4ymZY
	JoCbsFh6Bi97TKtuxB94gf8BQk4ZHTizDJHzes0bpb4w3RBzwoFtpwwZ7Uq7iJComW/ETCEBUH3
	vthd8MTwo3RskHBCK4hfZfhWJODkSmf7O+ohGyfVbAuEZpCi19/oP6sbdgiyseE/i9UkwKUlBKf
	K6mFgUsn6w3VOEEPkgvmBh20C7HoII589CLJY7R7JxCgdn36urCstqrSCRNAnPzhBNYLVQXAzAL
	mIh33iD/JA0grH2Nof8j+ZQG1VfDJ/mdWSDa/mp8yx44URcFPYZMj5AGecn/ABXWBoO+REp80UF
	NLQtT4gzyUR/TA38=
X-Received: by 2002:a05:6820:f021:b0:6a1:55f8:6bd1 with SMTP id
 006d021491bc7-6a155f871f8mr654111eaf.34.1782516400026; Fri, 26 Jun 2026
 16:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>
 <20260621213407.GC2297179@coredump.intra.peff.net> <aji9MOE-NTHKXYqn@pks.im>
 <ajkEzhdqzmAePk_P@pks.im> <ajkGkB2ckf3p43QR@pks.im> <ajkOoRhqaAcy6gBg@pks.im>
 <CAC2QwmJA2TH6BmO0O61qRYvV2pqURUk0dTXpkJtb9e-TZNZDZQ@mail.gmail.com>
 <20260626051657.GB3138423@coredump.intra.peff.net> <aj5ZaZK7xylfs4Xw@pks.im>
In-Reply-To: <aj5ZaZK7xylfs4Xw@pks.im>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Fri, 26 Jun 2026 16:26:28 -0700
X-Gm-Features: AVVi8CfG9wdCvO3QEYT4UIJLNHKreaPQC5LHrGOLA1QsRcynNVTXDth0uCgElG8
Message-ID: <CAC2QwmLkHUymvtYbjY8aQO9_VogvaSXdbb1_DSZtcBttGfN0tg@mail.gmail.com>
Subject: Re: [RFH] Why do osx CI jobs so unreliable?
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 3:50=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> The bug manifests both with HTTP/1.1 and HTTP/2 though, so this wouldn't
> fully fix the flakes we see, right?

Yes you are right. The linked fix would just prevent the hanging after time=
out
for HTTP/2 tests, but still leaves HTTP/1.1 fakes.

> I was also wondering whether we can maybe work around the issue by
> increasing the Apache timeout value. That sounds like an easy potential
> solution to try, and from all we've discovered so far it doesn't feel
> like this is something we can address on the Git side.

I think Peff and Patrick's suggestion to just increase the Apache timeout
makes sense. I ran some experiments using a really long timeout with an
artificially slowed down CI runner and all the jobs made progress
(if slowly) without stalling, and eventually completed successfully:

https://github.com/mmontalbo/git/actions/runs/28267019651

I haven't spent a lot of time trying to figure out what the right timeout
value should be. An hour definitely seems like overkill, with something
on the order of 5-10 minutes seeming more reasonable, but I don't
have a principled number.
