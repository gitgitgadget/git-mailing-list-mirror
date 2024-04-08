Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EAB5B1E0
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593195; cv=none; b=EB8+9c997j+HJuVYssu7R8rKiSrEZBnagkkaG7zXpuFXpdnbpBUGwGsmJMBBm4BATnW/dMqtgCDVWafXbBntZnxdVadP4qudwygVH5Ccnbw3HkfiGinfIW6Uo1TM7i2PNsPSMyRE5r5ALIac4KFCIq/JFDpt9CiivxTv9HVLeNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593195; c=relaxed/simple;
	bh=xMrM+44W8i6zTcxzea4RlMDJc02LlnBQjhzRcMZsX14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXhvRThkz32vS+zWy7HjkShuQ3Lj4G/71ClwFkXc6SwAnbhRhnMwpmk/Q8wYp1LIKis9Mf/4p0rd1yFIygqmUCX4o4yWaxS8AH7z1ROfOKNsjqxHM6eYjQF3cWsOCh2BP3Gj/7XWZZtaoCy5Okm33nm8PJWvpFnzAR6qoEQS6Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69629b4ae2bso37539006d6.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 09:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712593192; x=1713197992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHauppU+DBFzNlHZEd+0RxtB/wKAOB3Hj4wyqRgq+Ho=;
        b=oNtLMC6Dc2UBTDWBeBBXZ6xFxwFN2e3MKT+ObK3IJJ2Nq03b7VmWttJt7LJWfGcQJK
         5mNllmCfn1V/W4YVrjGbuiEIFeFySLTD/jmrm3/0RsrM7xUdxN0K5YF/eTsvKOwmojBe
         bYBRfg4k8djsOG2sl9KQAiP9ER9tmos30JtlxFo2imBzknMndQ/LhlizgaIDU6M3lVGB
         LKwVWFTKHXYlhL1nrNwV0R8NAupA2AlNkebTuixuPgrUby7oGoZVx8tE/BLYgwhfR0TH
         DlzPmgwEsFvCVEyavNqzryGzg2b/4/ANJyjrgdoG/0RVDZmCUiR41lj32KYMMEBQi5ZW
         a53g==
X-Forwarded-Encrypted: i=1; AJvYcCVVOi+fCnrSU6fZp5sC8Mk75oJRNQK/fz8VxhuDOl/ClwVU+Hnz1f7L5Cgusqf5uxRDyFYyqT6VJ4RKbBhvk1PDY0zO
X-Gm-Message-State: AOJu0YxhxloEgAYt4hzkie4GwND10iAFXdM6g4u85jCr89zAchQXibrx
	Muq725Tb+yB+YVBS75d3jUJ5YEZ93z5vjwzcEQesSNdu3c0rJ5662dZi+QvgTu2e+Ab7hRgnbZY
	syoHSP6cVXYldRFJ0F4bYFM+6IdU=
X-Google-Smtp-Source: AGHT+IFQO4dXNahW32Y4/Bsb7UGpQYdqtjJPLRTEh/mkoW8qNSu8AvRD6PxH/Hr9p+JBE4EAujezjT9gWsYsVZ3BcU4=
X-Received: by 2002:a05:6214:c86:b0:699:16c8:8517 with SMTP id
 r6-20020a0562140c8600b0069916c88517mr9252236qvr.6.1712593192522; Mon, 08 Apr
 2024 09:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712235356.git.ps@pks.im> <cover.1712555682.git.ps@pks.im>
 <160b026e69547739a526fb6276a895904a4d33a8.1712555682.git.ps@pks.im>
 <CAPig+cT3kvvHL+wLTFj58e5BnB7yBA=HD3C4vWC4zQhys3GCHA@mail.gmail.com> <xmqqpluzet2z.fsf@gitster.g>
In-Reply-To: <xmqqpluzet2z.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 8 Apr 2024 12:19:40 -0400
Message-ID: <CAPig+cQd7yfVVr+yZDxYY_oe8wC5OGt-SKtCnhCzZqJ0avP-Jg@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] t0612: add tests to exercise Git/JGit reftable compatibility
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 12:07=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > I was going to suggest that you could accomplish this more easily
> > directly in shell (without employing `awk`):
> >
> >     {
> >         echo start &&
> >         printf "create refs/heads/branch-%d HEAD\n" $(test_seq 0 9999) =
&&
> >         echo commit
> >     } >input &&
> >
> > but then I realized that that could potentially run afoul of
> > command-line length limit on some platform due to the 0-9999 sequence.
>
> As xargs is supposed to know the system limit, perhaps
>
>         test_seq 0 9999 | xargs printf "...%d...\n"
>
> should work?

Hmm, yes, that should work nicely.

Whether or not such a change is worthwhile is a different matter.
Although it is perhaps simpler and easier to read, Windows folk might
not appreciate it since it spawns at least three processes (and
perhaps more depending upon how test_seq is implemented), whereas the
`awk` approach spawns a single process.
