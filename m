Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71426DCE8
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402659; cv=none; b=XJ08s37O6SLA9Zy3Lesax5xELM7O0HOGplmT5mpaNWfVSbWfks3JTmwWZoFyEVkMM5UyHNBKzw3W9Wh6hI+0TnU58Dlu6xRhak/73o38g2NHhGhWoYw8OhrwtOimxOLGbfUSgPgbJFajMbg3I8Eu6WOsh0OSHALPm6rqUogPUm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402659; c=relaxed/simple;
	bh=sFevrzGP52TdN23dej4X32oxmNMnX/5CxGut4vH3aEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a60/CVzT5f0ineJVYdYnTC83I5ATnW1FfDfM3jSB32QQXbWVt6r+JYocxsgvYXXPYs767Yj+Geh0pn9ssyuIy2QeMPnxO5/IcRQ9RPEZtqd8PSgjgR1OMb8zk5HkQXkDJcZloUYXt1EAPK2rJdbo+mNuWPup/RElmsehCLi+ZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-476757820ceso1451519137.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 14:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711402657; x=1712007457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmZXvpFo4nOUmJv/MEhbHAD8joVZUX2KuluREud98aw=;
        b=hTcffrTh4OIr4wcDmuJo+oDfekJm59/x7XmGbiBAST7+IgSOiqHy1X2T1mcf+SM9p9
         duDbMEievgoNTBKK1QceajpYNtMCdUg57zCwrcxv/SI52QRu6GM17LzuQbxo5RM2+QGx
         vktwCmVUxSjWXIupaQEnHA9n43EMECd4ythj7R1edjzAALAIcRY34k4ouIWG9c7hCEWU
         2phHRm7arcxJcsI+4elPXUeLN1saV9tPI/+zTTIA+uDFzgvPJzJcgdq6Lysc/CosE7sH
         UaW7heT0Use0yVcckF9jSXAkDeUhsVSgLLU4k/h5J4ijUWMl9rOlsUOkwgehKdXOlDd4
         Jplg==
X-Forwarded-Encrypted: i=1; AJvYcCUqvZFOahPKoQe+aQ4TZ4PDDm5OFDmMFhqLFe2DeXOcvObsQ9O5wxUXgOZIpzacPrDvcil/t/rA9sjFI7lueglXj+0B
X-Gm-Message-State: AOJu0YytMnsY3DBsrj0Lo03FnYko1n28lwSbGf0rtWlRncHigOY1svJ6
	decGE2fCnYWsFgf/KTwmENFILgMuJwm4yO41n2IWtCThhUVCZ0I6KeVSP8vjaQrs/QW7yVk+xi6
	+NRqK2MbunLpsLFF/Eh24OP6uQwbD+iPM
X-Google-Smtp-Source: AGHT+IERSk9L2HvvWP3oXHTHFhkU8ErV+7To71iJNN8GVBOvjfFFBMbpw4VDWZtUTiDzFR3wpBN6bnHkugcKQFSn2oc=
X-Received: by 2002:a67:fa14:0:b0:476:d23b:de3c with SMTP id
 i20-20020a67fa14000000b00476d23bde3cmr6737161vsq.0.1711402656712; Mon, 25 Mar
 2024 14:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me> <CAPig+cRLUra6RObK82nvm1S_goK8q2CXe3A7EeCFA7xqhJCdMg@mail.gmail.com>
 <xmqq1q7yhupa.fsf@gitster.g>
In-Reply-To: <xmqq1q7yhupa.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 25 Mar 2024 17:37:25 -0400
Message-ID: <CAPig+cQAoK1UkgADFrnJfY4xw0kP6BypPAPe3aLoeFFGT_r2fQ@mail.gmail.com>
Subject: Re: [GSoC] Microproject help
To: Junio C Hamano <gitster@pobox.com>
Cc: vk <g@vkabc.me>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 5:23=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Mon, Mar 25, 2024 at 11:40=E2=80=AFAM vk <g@vkabc.me> wrote:
> >> If there is any low hanging fruits that you can suggest to me for the
> >> microproject, that will be great. I will also be searching throughout
> >> the mailing list to see if there are any potential microproject to wor=
k
> >> on.
> >
> > Searching the mailing list for "#leftoverbits"[1] can be a good way to
> > discover little tasks which may be suitable for a GSoC microproject.
>
> True, but with a caveat that they may range from "low hanging fruit"
> to "too hard, let's punt".  After seeing the anonymous questioners'
> question, I did go to that query page (actually I qualified the
> query further to list only the ones I gave the mark) and decided not
> to suggest it because I found that many recent ones are harder than
> "trivial changes suitable for a practice material to go through the
> review cycles" X-<.

Since the purpose of a GSoC microproject is to familiarize the
candidate with the project's mailing-list workflow and to give the
GSoC mentors a feel for how the candidate interacts, perhaps the
easiest suggestion would be the old fallback of having the candidate
look for a single test script which still uses `test -f` or `test -e`
or such, and converting that to use one of the test_path_foo()
functions from t/test-lib-functions.sh.
