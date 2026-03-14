Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10AF274B42
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773468718; cv=pass; b=RqHpjR7y5TbL+xaYIqkGKsJdXHAvmLJbQpQnL+FpwfXU7y6SyYPHHQ+yVkhd/JR4OTkjv/+e/0I1PYNMlCM/gbVEVoYj5Tpnb8DnKbhe5KM4dAfNN9y6o32FTkgmIwYdFCh4hKOkausICLk6cJJgVyqUUNipLwItKq5ymuaID1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773468718; c=relaxed/simple;
	bh=KjbONplagaI2iPegj9v/hJsvXNHRr6HLDNxRbZFvLKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hf8+CItLz4lHLndDi5IGyq7NZT4OY/14Zsdsun+phEJ9+MKXF5GLHZ0anD/EHV0YMAU/FWOD0fXdFdVqBisQ4le5nGqj63oui20okPRnH/r8yrAWLr0qzOw7kxvvfOgqBcVB0t4915gsu/Bivy4Z/rPbpz3GRO0+wrFtm9+o3bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2nCaRaS; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2nCaRaS"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6611d20c026so4257488a12.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 23:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773468715; cv=none;
        d=google.com; s=arc-20240605;
        b=ENVa5XbHI/6R4KfQ2bo/YFWtsDNDyqLW2xYk6bNuePxYCIjuHGf16ABT65KCoLOtdR
         ZvpgTZWfk38+gznBkHoAboszOOm8cv0/IzZSDk1yR+tR7DfKQRrzquzIyTwqV43SONqV
         IoX0rLtmX72OXSLtnCxny8YIB7i4zOuwl/jpFYkOJ/mH11mh6BuGMWANDrjk4lmZL68o
         1pAPYdnayqt0XkegW9PyzbVLIyekmCCDp5RJR1QfE+jfLm0QuW5IrvSkwVMdW+4N7+h1
         4Mqhy5fc1JuXyrPA/RaceTR4isz4lADOBcLcq2sJqtVaGrz5XEJu5hYy1PMIsZwOCEfY
         3jzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hpnvAZEogTvAMun+uKSIuPzgZWmSTIahJ0WrMHm+g1c=;
        fh=/M1frRP/jx2R9+VJOHQsP0FlKYjkF2tScnXBBP09wm0=;
        b=WQuHhUEzS4ZIamo+IGktNoN26UQRpEo4BEAyj5fUbZuvmUG7aeglN85OAvTMS1LvUe
         GPMhGBmq9y/wZmhiVQeSmhE5Osne0Yh8n/WeTMFVryLJ3vhykTThsWhg9WZgkv4Ke4cS
         j+S0DlzeRE060uuJIMstBls++ptR0lZVNsgxAAfu/j+OC2ZV40kVZbPvkcoqYnOL5362
         Dqwxz1Oqdbw8XheEvmh/F8LUvG9dY9oGLfuPt9Z8cLbUS1N0T3aCSNSmBnt+to4jafC/
         unOy2TL6WOnmdu+x0IGxrS19bD7NK+MmlCkTlF93APxA0PbToCCE1UlR6GXLl698xS23
         f00A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773468715; x=1774073515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hpnvAZEogTvAMun+uKSIuPzgZWmSTIahJ0WrMHm+g1c=;
        b=m2nCaRaS84cPbIuSh7Kia754qltLkmlAiVPb7FNyQlqNRczqyi5n8qMSTLJh2oQKZV
         iSmOPPSOq7vgrCdE3elmk6V36e12MsO08ghRb5Gv7sbIO4NHpXSxpPYFLAtdAHUYrfn4
         yXlvcNeZeZmZ6nl9cX8WvhHxywdPK62M/2WyxplAxvRNySJNPHbeTVbMlBcGR0UZRbo5
         EofC+NFQarnTwIdr2lh33UDH20vj/DKmGoI5ZodajQMwARFT2lHZ8UXINHVwSLZa6eYZ
         bf9SUtFsQFP8u2X2HBMzgIu028aqrLjv+R1aRSyPADdNFWYCAp2Ae6I+GmExdJnSIwcW
         PAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773468715; x=1774073515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpnvAZEogTvAMun+uKSIuPzgZWmSTIahJ0WrMHm+g1c=;
        b=pzd/O3oEr88dyQOqB4LArn//1fWErz8cDcvEXm0r1YiEh6+mp1SL4pwe/gHuXnBFkY
         qn+g6teXY69mtaHbOeJLGPIHriqXWBQIMHS3dlEPLhSRHcM/L41rdBVBTry1VYKzhHzD
         d/NqLDgBnfEOeTFjXRVk2mmaUBC5Cc3BtpP/n6mdUN57i5L4+vhkMrqyMAMkDNZHOsiV
         mO//Oo+YT6xf5YrsmgRN3xMp/HRGSw9WCvYk8pbzmniNNliHp5tX8G/i1PmJIjCP7wOA
         7K/FDZ/O/QHzJy6s2hQr1NJX4s/in7sSyR4SsSfBQuYYGuT274Mdh9kILIGak0pqU6cV
         Vjxw==
X-Gm-Message-State: AOJu0YwCSwfhyvBXhQ8gUo/PTn8sEgX3prxsS2WHBTtGm10W+liDvk8T
	KQ8HfE40J2nGPkCrBEoxZ5daVsGTXrW57Ra6Tdy3B3OfNRl1lmmXq35pVo4EYl+F0yhaAkF4snU
	SAIpvsXytePwUOLvcH2vNIeyXLi07MoE=
X-Gm-Gg: ATEYQzz80Dtco/F/sNBSOhe2J2kUdgPBkkYJpk2HSeYmiKiPp9KITxLdEpeZMH0bWT+
	EIumX8czw+cMiFB76OE01CppBQrE0R4MzrGHTgJSVPI7kuSLvVZ10nlIQKoVUkq9mw5Fz2ScDlm
	0NpPZiA4nNRELZSauJSMnbjZMM5RxV95WMTTS5Htqocg1KklLfCdgvrLf9RARSvmNJBVM+NZuYz
	HJvAJuJuCx+qtBo4oGLKHlLJU0cBhu4hyTSFu4Snr84H1mVWGMGdIePs8xF46u5fFPP+95Im5ku
	XiP4y3nbmr/QrzGFjvch
X-Received: by 2002:a05:6402:f20:b0:663:79b3:a995 with SMTP id
 4fb4d7f45d1cf-663babe2110mr2361908a12.27.1773468715118; Fri, 13 Mar 2026
 23:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5EUNSxS_A=XT7cmUiQ9bsS5vtzB_KAb8URCzc3X5AzkQci8w@mail.gmail.com>
In-Reply-To: <CAN5EUNSxS_A=XT7cmUiQ9bsS5vtzB_KAb8URCzc3X5AzkQci8w@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sat, 14 Mar 2026 11:41:30 +0530
X-Gm-Features: AaiRm50ZyUH88uJH62K8Dlz1ib3_kwsn2eIbXSaBG5CgwbGm83EDviYsc9a8dV4
Message-ID: <CA+J6zkQMN0MnR7OG0vr6B0fa7jefOSP7B2qG=fhv_zYubg5gWA@mail.gmail.com>
Subject: Re: [GSoC] question for an additional objective
To: Pablo <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, christian.couder@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 at 22:43, Pablo <pabloosabaterr@gmail.com> wrote:
>
> Hi!
> I'm working on my proposal for
> 'Complete and extend the remote-object-info command for git cat-file'
>
> While thinking about what else I could suggest to contribute to the project,
> I had an idea I would like to get feedback on:
> In a partial clone, someone might want to know what blobs are missing inside
> a concrete tree and their size before fetching them.
>
> The idea is to build on top of 'remote-object-info':  given a tree hash,
> return the missing blobs (inside that tree) ordered by size.
>
> Is this too ambitious to be on the same project or even a good idea?

I haven't caught up on the remote-object-info work yet so I cannot tell you
if this is too ambitious or not, but as far as your proposal is concerned, you
can add these ideas to a 'Future Work' section and maybe try exploring
it further during pre-GSoC and Community Bonding periods.

The best way to discuss changes like this is through [RFC] threads where
you submit an initial draft of what your proposed change is going to look like.

It is always easier to understand what you're trying to do when there's code
to look at. Motivates the reviewers as well when they see that you've put
some effort in your idea ;)

An example here: https://lore.kernel.org/git/xmqq5x72m4lu.fsf@gitster.g/

Thanks,
Chandra.
