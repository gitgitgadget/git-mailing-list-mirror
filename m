Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795213746;
	b=EOAT+CUD6rwN+ieCwhoCnjYKHfzvXgUFtccH8fBl833+GbXBKHsup3qP2yR0zT88UHQY
	 5xdolr9oGz0xGqU2eVZVVTziW1nTIfRik/u3e6Qq+52ceaimvhzqEsFiG1Pwp0JHkymqp
	 6lPhBEEkVB0deHnB4L1IrSRpJd9zhi6k6s20HEqxbjwvIsi/3SE3GGcd9NonVsn3dkUci
	 GwpLNlNS/3U5EV1yAaPsFosw/fxk2QupQygiMfXuluo+o7Xtwfw9KM45WomeuA/2hsvF4
	 zjC895kE1xdPYv5/iqkpYSvKMUfFBWvX7abCKuzPUQRifCPbxfGcWJ4I0Im+DpbQQ3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=aDddaJETB4ylXXTU1bX/iOjNelrrffsXneODPVSlyKU=;
	b=OGTzFkwnDUPhX4LIkK1kCnq0FaocbHMPa4H6/2HRMGTxlHfuk3YU+tWV+amRiqrYRRjh
	 hJekCnCg2T3hVv370lGw8pr0QKnJI81YcVryFzVDY2r48cXf/EAcnqrijTYCSlJDCOzTX
	 pUS9xe+sjN88B1yuLUjDMlnCizEVGqwHBx0Mw3dRYRoHUf3WvNiw171iqCj7yjPSM4PbJ
	 D/Rh0b83G4dDB/vUoynFBw1v/nYd+5Ul872j1R3U1fVeIHAmpuPxLXK45MpSqE0WMIrbg
	 Qns8tSfxA61PBNCu15i12+NEqHmFhLlHGZg3e6yqfijZgNuNTP3ZREjjb1onkbWdulA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrT31VmU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35148606A32A
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 22:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35148606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrT31VmU
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b4fb5d96b3so21106397b3.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:29:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795213745; cv=none;
        d=google.com; s=arc-20260327;
        b=HI8/2WN/KgODnO717Z0FL//kBjWuUJv/zYsgTOZTKFRgbePkbnWMvO6vFrbE0h0Red
         pMWWiMsqx1f8D0DwYqTuciwu5UBA6RwcUwsqwVHVFk+KxlTrYhyUAnsKYSIalMw4Vu0Z
         o/oHcUfH3GdqoiqDsv3ZxihQSOxrmM9QAG+xkvgEf7b2iqnRxwvUMhHYuovg5by+wuKD
         ddfD5y5kdpGKkHVfsTXt6Wg4jxlv36XOMqZ64MxAsTwuVrgR9HtowCHeK8GlGwvVGayW
         Kj/yd1N8h7DqqNR6eLnDKikOUrh6ZvrZpRjgq86yoFJRZxSUeHl/gY9ohVxbtgR9U5DJ
         p4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aDddaJETB4ylXXTU1bX/iOjNelrrffsXneODPVSlyKU=;
        fh=Pol4HaNpvslWcrEBQXq0C6A+B6qvSAVwkahxNxRSj8I=;
        b=RDydn67Z+tIdLkmqcq8ZYc/hUkyLLpbPdVRY2OjeADRRSfDvLRpCRoSZCCryEwuFCQ
         ihYpE9wqAtmIsqKgl/CPnkkcJLPf3qEh3zFTu4pxByuB10XaODWQVAuqUrxg0fRxjK0a
         uChobizTO1P4//hQxvSWecaK4YutB0H8Jn5pj3B+yY5rD2KONyMYu0FbJpN0eQ3/k7Hx
         skkb4aHLNp8H6qFJObeqh25RjL6pmWfrV9YJwaa8j9eQQyhI1ZF29ISj/2vM3cw0xMcc
         bfV+A+plH70V2lbC7fY7I5MMjE0YaPJwoVnONViSVKi4Zuh2Pnh2aS8bBv8yTz2TxLJT
         DAbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795213745; x=1795818545; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aDddaJETB4ylXXTU1bX/iOjNelrrffsXneODPVSlyKU=;
        b=jrT31VmUAsGp9t0Kz7YMDaNPP8SYzJOvK73Iq3VNRDF91gDtMPmRodw6K5p8eChZu4
         QwMRciMFr//ZxbeKS/WH/zEj7BtIL6LOIMXSElqo+qCFYmYJGy1/FbZgOP6Pn8icksp4
         Zaa4t2TU0RikXkv83lQSgE8DiclLbb7uwZ9LbDY2iq0Yta4JSz5/oR7QsJhOcujbXqwg
         fii9i7iEuwYRviyVuQenrquFwLZURKDTVz8j1hgu3AZLjSMr5gSdm9vRfJ60tBSioamY
         t0kePZLIL8KPBsOxPiluSnSDkBsoQzKBKsqKeOZR6j6FkpiYwD+ynvgkRN0r0vpkKuks
         ZPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213745; x=1795818545;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aDddaJETB4ylXXTU1bX/iOjNelrrffsXneODPVSlyKU=;
        b=YrAY8b5p+XEM2NCLJ72TBF7IWFslaM11mP3AksqQrAnNRninS7X2x3W60M5KbZ0iLK
         kdWWo90SBHpvZxiP/rZycxggQtpYXpQ68fT50WPTmx6kVgh70ytYCEJw4G502aTZ7+ai
         tft/c6rS4X5jTScmDdyeV4ahi+Z8NtdH3YiNf0jFTj//I/sgF4jjbGnZxiddJvFk4bK0
         j4D5xOKm6KnuLgXmgLdYYzYPkkMmCl1LDl14V4pwnmUMsZAonkcSTNH2VUXFLoStqR3x
         Nkc9TQoELXTh7MGuUkHRJeDXmf7Qbz0vGSgbG3/22Rf5k+lFPQRGjdJA2y1wHHrLSu/X
         FDNQ==
X-Forwarded-Encrypted: i=1; AL+hErGiMFoT1wswzN4TV5ylIrRAeGqwaoSzhlUf4ZdIbvxzM9fmnlVTrt9CD3xSHNMjzQMvI3A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+joe//g7qq+2MuKSWOJa00HL3n2X6rSDqW8fzk3cSyL8nqZV2i
	SRv8XGlIczgv6vq8xcvJaQQKms/TtG+FzEx/NWzR7EOByuJL3bQbXcOUWhT7DZrxeJHmh+PVh3C
	rAy/mrBFY0cbkxn9giNNdy9V/QAO3xw==
X-Gm-Gg: AZFdTZcGODVkEivEzTteMKEjlBq1edYcptITLPlfgF27h9KRY7Y4zXnev+pyeMIH+se
	aZgYZgctATVcnB34BWptPdfD+LJmIYJq9E+8mn/9gMwYXMtrJLdvD+MQjfgyyZ9vH+Zg2GvR+eb
	alr5QnoFNGf61Qh4gQ/8neLv/RGl80qqNnKuF/NWm2w6DOh8foS8CCVKt8D3jEQlBDHLmg9EBaI
	rLe69+/ghNqu1UjUADn0RoXqquJf4kx44Gr2LB6dndX1nfRVZNN5TVRDn+8XTNG1abgZIq5D+Zd
	nN9M0Q9lW8Wd+xJ2wLPmZ4Z2X30gct/MXF0Gx/zM13XvITHYI+CtQJxpg5MMDG+Em8SBtQ/tJ0M
	KXIDc2nHFlVUt2qisP9Ab9IrV6cim05P7dQ==
X-Received: by 2002:a05:690c:6e84:b0:873:5c7b:c132 with SMTP id
 00721157ae682-8b518f3d513mr24459107b3.26.1795213745334; Fri, 20 Nov 2026
 14:29:05 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOLa=ZS3ULcNVjV1DMO-iB+LcC2Gnw+9oU2_7VXKoLvgiVRnbg@mail.gmail.com>
 <20261109074352.163019-1-husainsitamuwala21@gmail.com>
In-Reply-To: <20261109074352.163019-1-husainsitamuwala21@gmail.com>
From: Fien Dora <fiendora5@gmail.com>
Date: Fri, 20 Nov 2026 23:28:53 +0100
X-Gm-Features: AclHuK9eFNfocgDbLG3RKsoML0HRnwMXU_txJIUp8kxyk80JGr4Pj9M2l057Bvg
Message-ID: <CACWAS-VFwoO58vbGsjyhsden1oJ2btoSHPcNnqbPWXuuGdU+5A@mail.gmail.com>
Subject: Re: [PATCH v2] check-ref-format: use parse-options API
To: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 08:45, Hussain Sitamouwala
<husainsitamuwala21@gmail.com> wrote:

> No. v2 adds PARSE_OPT_NONEG to --normalize, --print and
> --refspec-pattern. Only --no-allow-onelevel is still accepted, as
> before, so the set of accepted options is unchanged.

Hi Hussain and reviewers,

I have been following the discussion on converting check-ref-format to
parse_options(), particularly Junio's comments about unsupported
negated options,

In v2, PARSE_OPT_NONEG is used to preserve the existing behavior of
rejecting --no-normalize, --no-print, and --no-refspec-pattern.
However, the existing tests do not explicitly verify the rejection of
these options.

I added three tests to t/t1402-check-ref-format.sh, each checking that
one of these options is rejected with exit status 129.

I tested the updated script against the original parser and the
revised conversion (991ca87). All 112 tests passed on both
implementations.

For additional verification, I also tested the earlier conversion
(9f05296), where the three new tests failed while all 109 existing
tests passed. This confirms that the additional tests can detect the
behavior change addressed in v2.

The proposed tests would provide explicit regression coverage for the
behavior preserved by v2.

Since the conversion is already under review, would these tests be
useful as a separate preparatory patch, or would it be preferable to
include them in the existing series?

Thanks,
Fien Dora
