Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094B311588
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371533; cv=none; b=I04roJij5rM3Lenom8CmeRFq6z/ggNGoqPX3XqDTLVrZCmjV2DpIs7ZGza11MNLtobVbRDMvSh6NH80DS1C4WGVdW2ZggRZ6AJl1wH8A8WnPwem4Dv6OY8MG4Hyqc4Y6DgVe1X5v67CQq0E+281SosHwao0Nvaqy/70Aj4z6dnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371533; c=relaxed/simple;
	bh=kNXoSq/bR9HdMB4i4I99Z+ollZZ8feWnIojhUcPzoaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLcDj+dGh/u6Ofn1/vzU1b7SV01H0K+LgH47YQe8R/vm/28XbRJ8SbcCy4x2j2IIvPNbrh0vItmmoKipXYPtKG8u7BRTJIpEtWPYA0FEFxcVt7tl7ziX8Mwkc0HBvrAP6S5kshVvoXHWuGD/1D8YFi7JWYKIZ84t7vinb4I5ueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sympoiesis.com; spf=pass smtp.mailfrom=zeta-soft.com; dkim=pass (2048-bit key) header.d=zeta-soft-com.20230601.gappssmtp.com header.i=@zeta-soft-com.20230601.gappssmtp.com header.b=NWYPhHhj; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sympoiesis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeta-soft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeta-soft-com.20230601.gappssmtp.com header.i=@zeta-soft-com.20230601.gappssmtp.com header.b="NWYPhHhj"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64669a2ecb5so600173d50.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 22:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zeta-soft-com.20230601.gappssmtp.com; s=20230601; t=1768371519; x=1768976319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFTSiZHf5w1rn5qQ3oR9cDbqQkeKP3prJfJc/2/+mbA=;
        b=NWYPhHhjNHMP204ukxEx/BgkvTiW9M6056vOtI02mF0ovplp4vm9LfLzefRtCHNO/R
         kIcFVLXmeZMg+3TcWKR/Em35yWXoOvoyykLlMMEsauM9UqCU8z3SozgCFmRx4kiFRpdU
         m9CsB1EZblCaOxJCcm6kL9zbBpeglykQ++W3mr9AkrwLb3SFCSQMb2zIp5rTIEDRV9O1
         8zj+rN+Q6z56s3UwyaptrCTIzu9WFQuD6O1oLsqeUYnFPb+oK63LYfArrgarUAoRHdq/
         iBk2AheAJXHZfD9mq0lDIO9wvAfPkB3rZGbLDydhQLsAlmt0DvkmYLNsmY2Af+E8HIBs
         Mf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768371519; x=1768976319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kFTSiZHf5w1rn5qQ3oR9cDbqQkeKP3prJfJc/2/+mbA=;
        b=UaWDr87pUuMb7kk6CL7aBhcrPE4Y5ebfi0gDZ8MLtmQmwHnasfJYH4wnwUXskPLUgm
         wrD1nEaZ25opGqUNlEVFDbHTGaE0nlDHh+3c8o4YXsD+gprNAtUQm+02kZrumO2RjU3Q
         D0aKCuc6XjjJCKM11Gclp4noRLCeXY8YoIvftc67wxYLb9mOP3v8OEJSH3ELNv6ccFik
         F8TJT489G19BTKPGzSHFd3O0hn/l2NbMtWTT/l0uRkchDg2szT0YWNJ9AIRWKzicN9xL
         Kzg2wRY18wM8PtO0TCQc3wpNPc1dUXORYXqJhlZ9bOVZ4mCOK6kUPAuaPkojMijc6Too
         g86A==
X-Forwarded-Encrypted: i=1; AJvYcCW6NhzGpif8FmJt+pHZ7PsHpz9wlF1GzZL3SeGCH9lpEjzl53pUh2woCBMU0ODp5vJlR1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0wkdVZfQM98Cs8HqxD5oM6GeDDkHPO0lPH4jvRka+/KnEeEDh
	M27KN1xRebB1ZBuA01NUU/nZ+P87I/uevDgEUqy8gkezTDsz5TWgQJXv4fSOwBRsYxq5qyYxhEz
	7omr1mXtwwi22IH0U7LqBEGzd891XC15cNsf04XnsIA==
X-Gm-Gg: AY/fxX6IWim32TofV226+lC5NPlM/iRi7FyD/lNnSX+NgNmUxQB9I3+ndJ2U8wnuHfi
	02TG+xS84K4584vVahpfmm1CEuVlRbmr4dziJY2jD4aKiWe0/cZtD+g6DPbZvcP4RT23iyrqUPQ
	xvB6nqEfy1pJgkUs3HiJvvJet9tvRCHKBDV4mSwiZ2h5BE+4NUI6A6V97ib+jv62ha45jtLVWcJ
	DdMHcEbCdcgsftJ0pBCBC/THkKdyyZLvkI8877+PqsZCWC+rHsCUCKQ7GYEAZ0uwTrxYes=
X-Received: by 2002:a05:690e:c46:b0:63f:b353:8fb5 with SMTP id
 956f58d0204a3-64902298d76mr1222667d50.15.1768371518766; Tue, 13 Jan 2026
 22:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
 <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com> <86315aa3e36afa1ee741a2c9b9e95a71ca569302.1764211096.git.gitgitgadget@gmail.com>
 <b6656e6d-d1e8-4ebe-821f-9211643a71ab@kdbg.org> <7c642644-09a5-4a50-931b-a630d459932d@kdbg.org>
In-Reply-To: <7c642644-09a5-4a50-931b-a630d459932d@kdbg.org>
From: "Scott L. Burson" <Scott@sympoiesis.com>
Date: Tue, 13 Jan 2026 22:18:01 -0800
X-Gm-Features: AZwV_QgJFgZ-S-vHFQ0Tji2xxJL7Vn3yMp4bxUFa0TL4t7YPcvO1_s8h1UllYQ8
Message-ID: <CAF5LJ4DrKkJpCfOkkEsYvDH7qF1Bx-v75GryxUbr6UgmJq05cw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] merge with Scheme regexp; fix bugs
To: Johannes Sixt <j6t@kdbg.org>
Cc: "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Jaydeep P Das <jaydeepjd.8914@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 2:27=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 27.11.25 um 17:09 schrieb Johannes Sixt:
> > Am 27.11.25 um 03:38 schrieb Scott L. Burson via GitGitGadget:
> >>       /*
> >> -      * R7RS valid identifiers include any sequence enclosed
> >> -      * within vertical lines having no backslashes
> >> +      * The union of R7RS and Common Lisp symbol syntax: allows arbit=
rary
> >> +      * strings between vertical bars, including escaped backslashes =
and
> >> +      * vertical bars.
> >>        */
> >> -     "\\|([^\\\\]*)\\|"
> >> +     "\\|([^\\\\]|\\\\\\\\|\\\\\\|)*\\|"
> >
> > Without the C quoting we have
> >
> >       \|([^\\]|\\\\|\\\|)*\|
> >
> > So, this is everthing from | up to the next |, except that \| does not
> > stop scanning and \\ is also considered so that \\| is not regarded as =
\
> > followed by \|. Good.
>
> Actually, no. Regular expressions don't choose the first match if a
> different alternative gives a longer match in total.

Ah, good catch.

I noticed another bug.  At least in Common Lisp, and I expect also in
Scheme, while backslash and vertical bar are the only characters that
must be escaped to be included, in fact any character _may_ be
escaped.  (This came to my attention when Emacs Paredit escaped
a double-quote for me, between vertical bars, unnecessarily.  Of
course, in a string, double-quote would need to be escaped.)

So the correct regexp, with both of these bugs fixed, is

    "\\|([^|\\\\]|\\\\.)*\\|"

Or, without the C quoting:

    \|([^|\\]|\\.)*\|

For example, for
> the change
>
> -  (let ((|one two| |three four|)))
> +  (let ((|1 two| |three four|)))
>
> we get to see the word diff
>
>   (let (([-|one two| |three four|-]{+|1 two| |three four|+})))
>
> but the desired result is
>
>   (let (([-|one two|-]{+|1 two|+} |three four|)))
>
> I think it helps to include | in the bracket expression.

Done.

> It may be worth its own patch that also adds a test in t/t4034/scheme/.

I updated the existing test to check for both of these bugs (and verified
that it did so by reintroducing them).  It's all in this one patch.

The branch now contains two commits, yours and mine.  Do I just
do /submit at this point, or do I need to submit them separately?
