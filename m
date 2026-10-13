Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470837A83D
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874118; cv=pass; b=CDMUwoAXhL4ad2peROuY3l63xVsqUL02gVK2KHBWVeAP3QNaPdpNZkSnhRFPypg0ysn3zClZuABy2YLbW8WVISDU9EcHr/2gaM27DItv4uJzsBodpjeX4/ASwSShUTzQfgA9uKTBZNPZWroRj3BUxRRcJq2TcDHDqs2uWiAFyEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874118; c=relaxed/simple;
	bh=ds2lpvBs6HDcATpb/Wx5HpksY4Fqk0lJUTb6Gqt4pRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnZM8IYYDVb1XlPEEb1lj/CE+QrIKh7ThKOUUWqM/gtfowbcmviyi0oKkPg7yaT4FkClosUCDxtgjMih876qvYHn6LMuTQizbl9VhlfWzHFoVx6T+Ap6FF0RRN6mV4vOECRYOZ2liSxAQ6NammxWy6iFEo9+UzMrTfm2+DNt0WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWYgV4+s; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWYgV4+s"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-939a5f8d16aso19241085a.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 23:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791874115; cv=none;
        d=google.com; s=arc-20260327;
        b=GyMH8dqZBjo89Do10p3aPXhIrOpzoFU8qAW+9E9X5zLo9e1z3rjed4SkeURwR4lC0v
         x+zFjRtBeWLXfdDCscAQb9jraatfBTeALj4Q3Ro4WCUUGDmYJUU7/7orkLSK5FsbWcyT
         8B8aSt1tFmyvIc8m1vP3FTuhKxNcc+PX3XsURId1hmn8N+Izm7x6IgaiaH1QvS0LLCEH
         S49zImyCJzruXokmliFaK9FRIvwOX2x4SijDEDpDGkf63R9UzI5aLFWEyLZMez2+k3yE
         z2r2ailWcf9xymMNM2krUQMn2EuM5ETaNY+XfkxeEVJSNo7vc5U4IS+DEBWGlJYvoH6H
         wx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VcBktbr07qjhzJjlErI+y8u0nvgdzB420+YiUJj0J8I=;
        fh=ikU2VsQpBzZ6Sss+F2hX2lvH8rE3tAgaLv/m0mcqPEs=;
        b=lvoNvUzqMh0EHoGcQZvwu/EBd02+p82bod/QysP+4P7MvEpa5A/ilZOy1ftaQApXvD
         G6OqBt/5VufS0ez+TNxlvkTUSVHdpTg/cPju8eXKH0zfL8ZWDukRHj+wObn+d1gcpgeV
         SLB0felC/rpaZfg2bLZf/357T9vhY9UvWsZA5VZfzBctldczpA519ui+eaK3Vhgr8XTJ
         Wb/f1XAGhf7s1aGKhu8P+A1KYJgs3AG4qS//IWeZZmtRRq5t+SJdj5+qoxQUZVNSHEgm
         GX4E7mZSEKXBXsHWc98yTt0FxxWPFY07/+NT2eTx3GDqLii5w71F0WWpYArBBVlS94PG
         nKuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791874115; x=1792478915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VcBktbr07qjhzJjlErI+y8u0nvgdzB420+YiUJj0J8I=;
        b=RWYgV4+s6hwDK/MNzpD2wrII7pBvwGhzbZoUH6njeOLpgxwBSpcB2dIyEpfjXANzvy
         LkXRQq5oK15zn1mOvhE3+UBaEyOT0+9afwiKruJmh7xES4+8sBoXwycOHiM0os2UGqqh
         UBkE2Zs8twGb87sTHijtn/bEc+mHJf4uXfoklshCLBaTmY2VhNBMmd5EuetlXnd1DZcu
         SsrvUeCxadfp/cLQ+Y6N0L0xoB755wrRaHl9QR01Rryqyykt4W/FfpbTuNWNtkTUYMgJ
         Vz+j1ckMcdL0CyYGX5aW/XjHVrkI+CFM0ANq+obzMomLHhp2D7MEk3uk8MNs1Qyu+bi9
         e6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791874115; x=1792478915;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VcBktbr07qjhzJjlErI+y8u0nvgdzB420+YiUJj0J8I=;
        b=YjXAzaPaxcpSejt3hijwPZJy0sGqdox5el9Tb6F8mC48zwh6jRTJGQnF6A17qHcMTu
         E2Ltrd9XHQJne+z8C1z6ct94OeUJiSei3cc/IvgH0drcxDwZIybcw8w1zmxZ3W6qtQFF
         OGiVRfV8+WlKgZN1triMlJ6KfjfQaqQ1E6buiDPQh4TKKXqkafvD2a0CE/Brc/Z97bTA
         MejNYqjiZas4VOdV0X4FQU89bhqoAoKt8A+fcppIHRhkRUk+PJqHyIBP7tAvxDoJ6A5F
         xky+YhE8rXiFUuMphshQHekTWqLhh/eDPjmIl5gEBKm1qsfNcGGsgYvdLBS8Cu4oU+Nu
         yqXg==
X-Forwarded-Encrypted: i=1; AKwUvBx46C9qFpAlNqyvAZqXnFavSRg/I5F1Rygq4eyOrW9Y2Ae+eMBP5gtr/Q0HY3VzqGuJTQ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI811fFtaFejF7r6fm3/Z70Q7vly1aXu0J/nKnwIAY7DgoDovIF
	N6IX4ROtVfbMFlzQtNW9tk1kB2E+tjz7jWKazCxylzOHrEkUqrKHosCiDac9em1syKFfuu+TuJ9
	Rt2XpPrDGCw4CobZul3iT8B7lkyfbo14=
X-Gm-Gg: AYBFou3V9ynoZ0x7do93ojUqUnjgPMSPGgpjVQeitwUOk2zI58lI6XOEBTx2OneBjzk
	/lHHqZQe8RtvfdvH9ZU5YGrWYT8LMi5KMk41CHBln/GMF3Ov9UOAgRpVZJz4sB7hPuq7EnG24J5
	JWvIW1WlVQC90n7jh7O/Ndwi8M2Jct4pzm1KLfsfCI5FN5H+AxbrhbOcjqO8gdb7H57UNR0t2fr
	Px0sCA65Pwl5CoYW+4NrxZRXkj6eaVvYBFc+S2POv/dTnjmbYoir7Jc/M2FPZLda8tRKSyoayeg
	IIBvS0ljsT9C/SYK9dI1Cdf9LfBg0X2WyYhqDtCx6ZXijWh/GBftg8hAywH0GJt7vJYWScDj3Tn
	aODLdsI53NVyQ0qZviAj5EymkkD0XZvl4Rl6AumSsHNqZ3Q==
X-Received: by 2002:a05:620a:3186:b0:939:8bc:8826 with SMTP id
 af79cd13be357-93ebd10c0e2mr2308610985a.2.1791874114874; Mon, 12 Oct 2026
 23:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqwm1no29m.fsf@gitster.g> <20261012175638.3712-1-tboegi@web.de> <3b36c428-6d67-45ef-9f6f-e78da33646ac@kdbg.org>
In-Reply-To: <3b36c428-6d67-45ef-9f6f-e78da33646ac@kdbg.org>
From: Curtis Smith <curtis.allen.smith@gmail.com>
Date: Tue, 13 Oct 2026 00:48:22 -0600
X-Gm-Features: AclHuK_D0Z2Ffi-NfJp5DS3BRLCs69PceYdS8oh8VC7P6NGj6EpFXB8Ha00MxvY
Message-ID: <CACnh8r+=nRvCbJYj7=M9BiK=ac94xLOVPhcKbPNpjnfr50U_ZA@mail.gmail.com>
Subject: Re: [PATCH v3/RFC 1/1] read-cache: do not trust a size change when
 conversion is active
To: Johannes Sixt <j6t@kdbg.org>
Cc: tboegi@web.de, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Johannes Sixt <j6t@kdbg.org> writes:

> I cannot agree with this reasoning. The index is a cache of the stat
> information. The size recorded in the index is only used as a clue
> whether the file was changed or not. It does *not* record the size of
> the data that the object database holds for the blob.

Agreed, and that comment is worded badly.  The size in the index is
correct here: it is the size of the LF file as it was checked out or
added.  The tool then rewrites the file with CRLF endings, so the
size on disk really does change.

The problem is what ie_modified() concludes from that.  A size change
proves that the bytes in the working tree changed.  Without
conversion, that means the content Git would record changed too.
With conversion it does not: the CRLF file converts to the same
blob, which is why "git diff" shows nothing.

v4 has no such comment, and its log message says it this way.

On Mon, Oct 12, 2026 at 11:34=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote=
:
>
> Am 12.10.26 um 19:56 schrieb tboegi@web.de:
> > @@ -438,6 +439,27 @@ int ie_match_stat(struct index_state *istate,
> >       return changed;
> >  }
> >
> > +/*
> > + * A difference between the size of the file in the working tree and t=
he
> > + * size recorded for it in the index proves that the contents changed
> > + * only as long as the two are byte-for-byte comparable.  That stops
> > + * being true as soon as the path is run through a clean filter:
>
> I cannot agree with this reasoning. The index is a cache of the stat
> information. The size recorded in the index is only used as a clue
> whether the file was changed or not. It does *not* record the size of
> the data that the object database holds for the blob.
>
> If your analysis found that, after the content was `git add`-ed, the
> size in the index is *not* identical to the size taken from the
> filesystem, then the problem is that an incorrect size was put into the
> index, and not that the size between the blob data in the database and
> the filesystem's file are different (and unusable).
>
> > + * rewriting a file with CRLF endings under "text eol=3Dlf", for examp=
le,
> > + * changes its size in the working tree without changing the blob Git
> > + * would record for it.  For such a path the only way to tell is to re=
ad
> > + * the contents and convert them, which is what we already do when onl=
y
> > + * the mtime changed.
> > + */
>
> -- Hannes
>
