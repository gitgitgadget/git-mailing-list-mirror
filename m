Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795169789;
	b=fmu/IHecNiAEXAJ3iixmRZYnKB0XP11tSjQVzZPpG6UbgdWG30A+pX+v5vRRLa+P6Pdz
	 Cxvzdxqcn/BUGKKG1FatTAR4/6tBAnXkAXPjgjXuW6xec6S61sQWD+WhgyzRbLHGVpthl
	 TpX8Vbixn6S/TPsAqzmLCb+1FpelIt2sB/mWVEH39fWx8l8E59nZVgrNN+TmaHIUiw5Ie
	 OiJqRzR0P7fPSEB9CeqKgEhuhILA1W+39NfZT779MJu2D5AgshipoA9sWm2KjHmpvPGBN
	 5gJVMrDKh5EsMyUG+OL36KofBNQHk2bjHrrNMO4CIXulz42a7Qu3pnhsWsDBCQ/m59A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=rT/EQyh4ET7d9EnnhaZ1BRuO45s3/F/Wf6iPdhniXvc=;
	b=cxI3AecBbPuvRt8Hq0dKR+w+VnkLKYl9xx4KH3wBKBkr3LSjMFEQC79Qz3TwO2zIDO/q
	 j0XfESZBAK38ZRG/aKvAzLZ3QiOeLdhx5hz2elWKCZeJ7VBmZ/+qhKxxlfZA82ct9MtkP
	 I9pfJQLZRyRfahgQR8cA2fuSxaQQSZbu/nMW57YgosVMoVmlIni31LZGOCGcb9UhBbg9M
	 9pdCGekUgKauUWZX6YUyDQnFh1UWk0vlaoFSZLDOhgwibZkQfirLpkq1zeKnY2jvbOErN
	 2xiD+4GYyTdeEhBM7BE3k+hub58h3BBUNwDydFc1kOgjykhLWAbUjmB7AevzMEn9rng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eOEDFgoW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3901D606A325
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 10:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3901D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eOEDFgoW
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-71ac9e15640so433103eaf.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 02:16:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795169788; cv=none;
        d=google.com; s=arc-20260327;
        b=f4SqNH5rlE1BBJl6CE2lLyM6xxna++53HgMO9a7g6dFeUIaFaKnkYyAWxGJOFCSsAn
         9dPZXFGWjXhgzRfUYtQiB3nrnnCp8WUjbAetyesqxYt8GjInqlykKvRNQrTDhZOFDdG1
         F05hBO9HkcYsfWaf20+WRX+IZVvmvQM2HJC4Bgo3XUR812jePy5kHo/Ha86bYzHX76eT
         Djr5bbkEq6icOwADnsgP1YOeVA8XDyCZbdl//db+cgXliMylS9sGlK7OVf0o4BwdrdVJ
         VynVCojbkkJv4zw/tshQgroDUqQN/iuSDFJPFFatBUTO14CqRtwNf25X0ef0VQkEHGsR
         +IvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rT/EQyh4ET7d9EnnhaZ1BRuO45s3/F/Wf6iPdhniXvc=;
        fh=nd3HEuxA5fln98vGCSi5RH/Ty/W7mX2H/lxRLqNd5iY=;
        b=CCEk4bZuWZwtsoU9a57Em+pCTYixOPZoXzpfvAp2vUJU77mopzt7Vo6Y7w9sqIig54
         YdSyP41MrLcjhszCqTfTEcTXhwhwrvzs+5kzGT9F0lElCPkA/6SkF/Ja2r53eHVVp7x2
         qj7LOwEMUAAsaXdS3etIUF8SLoKPNXHRcvTt/TkPf2NDSO33YGPfNY5e++VXIsyNxxjM
         oKhZXheoX6UZ0nJaG1b7gxkpL/lDd0rWlqbRrmQuGxcn/Yx1IzGEMFhHw+OyuzW/v+ex
         tvUBHnpzg0hVgUBox+PPkNzGezv7chwNfIXIZJyfD4hd2WvzHZ0Bvr0xdXUcpVJWijWk
         PJXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795169788; x=1795774588; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rT/EQyh4ET7d9EnnhaZ1BRuO45s3/F/Wf6iPdhniXvc=;
        b=eOEDFgoW/JXKimT9xGTJybIUyl/LoQ9/MZiFBQfisLRA1kf3z+fjFmDx/jwVqJDLmp
         7LgWr5idfzyd8fFR+lS9Pu3wP28zkcC3tJa1JJCizghXsJRS472ECPmgwAC4AVrY+E4J
         8OSJ0pyNzy/goK9mwVcPY2NaJJipwFAJs9JvUWCqox8xP8GJUotUu/obrMJxedMm8fqC
         KP6sP+493a7APgVLR1mjgxWQXEWNnupeHA0ZOOC2tG2rb9iD+Qvm5V+IUtNHm3KJF1wn
         zVv0ikjlX4hAqtQM+MCQcCNW7vNJnTYUZv1IjnkK69brqG+EhRtvWpsH4jPRhGhCjyPw
         shCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795169788; x=1795774588;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rT/EQyh4ET7d9EnnhaZ1BRuO45s3/F/Wf6iPdhniXvc=;
        b=GcoS/eqZFNdPAzXb9VJXhLBCxDEjv6kJZP/fnDCTlUE5ryMV4A1368WWbHkJ77cgjr
         boj4OWqYYcoD0kYb/o/+tw47/MEktdFWaSVRXilrQ9Bj0R/pD9JChixt0/mDB1k0+OhB
         gAzuVLnasNZKcO7+jZP+SpP4V3iGZt23caDdD9ePrZ/W9AAqJHkhxBfNhWVvfxy+cjcO
         1erjFaC3UmeL0vUyKkJVBklennVICM+Uia+WtH7cDzIKumA3MfNDSJ+vhfwHaTKPnqhn
         TPhtO6cfmoAma4DTr1hONAoib/uLYabEyAW6euu1NQVPOBFdtVmmfnhlsHztZxV7k84f
         grZg==
X-Forwarded-Encrypted: i=1; AL+hErFuTOoOFlqfHKehYEB6hHljs6ebxlehW68ZBeRiKA4iJzGa1UhdGXPW/SQTc0N5g/hMD1c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/knXI4KHC+vNpSK6LTaRBEtN/jBnQLVwGiFw8oD9UowForjF6k
	I/rUPankSmrjYeG6FuZYzzA8+aFj6CqzVSHoTErdQa9IPENOZKK8Jp5e6anHgbTyFW9lh11lNS2
	PRJcsSAN7x79plfGkzjFiRgd0Ilz8luY=
X-Gm-Gg: AYBFou1dDQByK+WjaGohA7PJkCyTxI7PZhMOXRaGOkcPUZS527Dt3gasE4tvzC0zaD/
	x5KuZEP0jv8tSJZPN2lxeGA88Gpf2D+F81Finzv47RGCrCOUwAdYsvSID89eijUsPHL5NXMmIbr
	CTcVoge1qjj1+fbo+sBsYKvpOfkZHeEzEQi3E1XDSSFLZidbqcvEv3DB0ReG4pc/zs9/UPm/L4e
	JzzUiJGUIiL1XEFJoLPFkRb/0tuCajOqvx09wTh6dACwuF3XyI0x8rJbISo7kC027r8pcFVfUK4
	I28n2irNY2SaWDavkTf/97n+VjSzMKFDbD9LHgxfWRARz/4HUdHCr+K+OrbChb9MAdtJIbHc1zs
	f9JTx7yUkqanGxBxWkoNX5Y36ZvjXoZXqTWBAH0uMzTS00FIFJJrMcH3p
X-Received: by 2002:a05:6820:2226:b0:71a:ecfc:4434 with SMTP id
 006d021491bc7-71b395277admr2201162eaf.61.1795169787974; Fri, 20 Nov 2026
 02:16:27 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
 <20261118-master-v2-1-3f2aaec15d31@gouders.net> <CAHWeT-aWx1VwUjM+hZ--jjSAbcMenz5Mw11y9ouFavGndUMrSA@mail.gmail.com>
 <ghbj7k1mg5.fsf@gouders.net>
In-Reply-To: <ghbj7k1mg5.fsf@gouders.net>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Fri, 20 Nov 2026 10:16:16 +0000
X-Gm-Features: AclHuK_Y8rWgojlFVIMuXjyiN3Rt-x1YeIVZ4B_TfkEIrW5txGJHYbUOlDxfWY4
Message-ID: <CAHWeT-ZXEXvxn2Zf=mt1tvjLxMvPzgeiMUvC1Ani5mcLbEvFGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] utf8: add display_mode_esc_sequence_len_counted()
To: Dirk Gouders <dirk@gouders.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Nov 2026 at 22:33, Dirk Gouders wrote:
>
> On Thu, Nov 19 2026, Andy Koppe wrote:
>
> > Dirk Gouders wrote:
> >> +/* Same as above, but for a NUL-terminated string "s". */
> >> +size_t display_mode_esc_sequence_len(const char *s)
> >> +{
> >> +       return display_mode_esc_sequence_len_counted(s, strlen(s));
> >> +}
> >
> > This is a performance regression compared to the original function.
> > Calls that previously returned immediately because *s != '\033', or
> > after a few bytes of scanning, now scan the entire string with strlen.
> > It turns scanning a whole string for SGRs with repeated calls to the
> > function from linear to quadratic.
>
> How about creating a v3 for display_mode_esc_sequence_len() similar to
> utf8_width() to accept an optional remainder argument?
>
> If NULL is given, display_mode_esc_sequence_len() assumes a
> null-terminated string, otherwise the length is given in *remainder.
> The function can then update the remainder and return the length.

Callers could already sidestep the length check by passing SIZE_MAX, and
the number of consumed bytes is returned, so I don't think that's needed.

Andy
