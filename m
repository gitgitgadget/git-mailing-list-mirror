Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260F27FD56
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723783; cv=none; b=jEA5sJrEjqk8fAUOgp7qlFi5GcWr4eBzWCN7wNV59NZrShoC8KAWlgdneD90JzsRp3LGcmwlDsC9WMtsN5H0DS6ZzlgeXICU44D7EGyB6NJzOuKD7keCl4FUq8JEiQhMBWh8Ibtlkl6ddGPQZO/e/4SvPrFIWXpL32UHNijV9GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723783; c=relaxed/simple;
	bh=gjcY/m186ZwslSGwLMj7OHbKBSXaLSMHbX4F8FYrwOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F25+r3jjPDgo6VRQYXUHavvcNu/AhndLpvmM4bUZP8hSWRaTV5yU+sDgxzxVgv4/8eh26e9kcdH6iZBILLO+ExaPWm2EMSmPstJijXP45nhg05DIj2OSKXpi0NidKLH7i1mZ+ZRQfLCtpoxgTH6W6SU1loGGMdNYtBT/Gu6Tcuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZkEgA4O; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZkEgA4O"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-333f8f02afaso2871711fa.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 14:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755723780; x=1756328580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZBlM07IXZUNNkQ4fGMwvNshvjJGrwqxo8vLrMSzoOI=;
        b=iZkEgA4OxUUyu3NbgKk1yW0HsHT/0vvZbCzNnRdlNjf+/L+jti58Gk7X04kmUwBf9d
         BwMHtSDVJTVXS6J+Oiflz5frC51haawi679k/fntQ51rmrd705Snr7m2Dd9k8No2Al7W
         LL6rRaAE/oKAS5XBjkIp+WXqn4ichY+n4NnMLQX4j9ve/yCABXnrkqWFf+glVLdjXvBQ
         KrKPO9dAUnAruAwJVsFtZDA2UGoiSZVavTgF33etjAK+IKOOy53G5+Smfxv1NTxQqkUd
         IT/u9XQQhh9gHL8Xt26DPBG9XLCUlxd/q9osfob+mtCr17llY9tE+Y6KMvjXrP2awDsA
         PHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755723780; x=1756328580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZBlM07IXZUNNkQ4fGMwvNshvjJGrwqxo8vLrMSzoOI=;
        b=MM3AXbJqenbN4DYsbza7NyYP5ZKoTwIOJE3cX7BAGdNH7EVAwI0S4NKUy7UeGJSnQU
         faXsAoszejYbWWGzTS6rxIAJYJOWHbVp3Qjh/Sr9qC3wqn7CcIXf4n0I0Yxr/mXbI0Wn
         6r6UmuVJ/HzeC6WWCE45+zcI1tlnd9I1ve1Z0ty5bxoc1Ndj7hEnDzauce1+RIGX/KXP
         kVq5HFz6YxAjH0NQso8MjIt9vH0WcqldaMz9Ovy6BeK4ythVZ+lYRhogBjPuuyAfnFiz
         BPoeNjZ92dtqouv7Ic9Qy+BATUC2OsFvKj4AWf4/LblYm2PTjJ8mJEepUA4wVImgvnzB
         KlkA==
X-Gm-Message-State: AOJu0Yy33i/i1cLsi3WrnsM/IB2Nha4iFXBktbkwGS9vOSyvSWT8laa/
	Y6vphQdMIWZrQTF2xDrqp263c4qHg64imliMTis9BdeHsFba2x8Y8Pt5WMWrUj3eNts2NU7SsGj
	jXuS5DO4/LDARnnUCBJ2CMRCHGozqKy8=
X-Gm-Gg: ASbGncvhlHUJllLXXhTz3N5+bLzkixnRcNWR0RFfUJex8vdiqkh+xJPZKYyVZ7lDKU4
	QknwApPB5FtRk86TadMWjQGaE0TJEjnA04lZ9JG9wbq32yxfG4DpIMz1P4zXgbnh53G96QHft2I
	FFc5PjAjmww0bsbmDTjeL5M3JOr2jSykpGXVrXAMWZfVv4nmTtpgQi5jtfQ9RiBjMjZbE75F3Au
	BKx+5kBfw9lBLe9/w==
X-Google-Smtp-Source: AGHT+IGcM8m0cx40MBQJeqSePMjAb0HnFFHqiIOO7WsqRS532/hsCI9QYihD8v43FNbmnYOOY4NA7fRzM8mTNcWBeK4=
X-Received: by 2002:a2e:a541:0:b0:32b:a9a4:cd4b with SMTP id
 38308e7fff4ca-33549e1dc28mr164261fa.4.1755723779845; Wed, 20 Aug 2025
 14:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820195229.45943-1-rappazzo@gmail.com> <xmqq349laeyb.fsf@gitster.g>
In-Reply-To: <xmqq349laeyb.fsf@gitster.g>
From: Mike Rappazzo <rappazzo@gmail.com>
Date: Wed, 20 Aug 2025 17:02:47 -0400
X-Gm-Features: Ac12FXyCK9Zhxcn3A_I9IPCx1mL5WYfVzvhLKf3lAitTQC0ONQE_HZiSDEgW2d0
Message-ID: <CANoM8SVTROfaQpRNBfwxU9opjXFPLzxN1W-xXTrA2bhx9KJ0LQ@mail.gmail.com>
Subject: Re: [PATCH gitk] gitk: add README.md with contribution guidelines
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, j6t@kdbg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 4:57=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Michael Rappazzo <rappazzo@gmail.com> writes:
>
> > +#### Creating and Sending Patches
> > +After committing your changes:
> > +```bash
> > +git format-patch -1 --subject-prefix=3D"PATCH gitk"
> > +git send-email --to=3Dgit@vger.kernel.org --cc=3Dj6t@kdbg.org *.patch
> > +```
>
> Just being curious, but does the project strongly discourage a
> multi-patch topic?

I don't believe so.  I think most people know how to submit a github
PR, but J6t has mentioned that he prefers the mailing list (as noted
in the readme).  So I wrote a simple example to show that patching by
email doesn't have to be scary.

>
> It would be really nice if you add "review them here before you run
> send-email" step between these two commands ;-).

I can revise.  I will wait for more comments before sending a v2.
