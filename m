Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2DD423EB2
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173842; cv=pass; b=LVnNinSTBh3xVSecsyQOeHEPJS2nIyQn1UGsbXOZm3m6Jti4nYK6N6HwtCrNQa7fJfNYy5IwA22+sVNQ/BiBScLdVVdBThtMxFiEO6FkicmrwuLAupUAiAizICdgTxiKphZDbmc4ZXi4chK67p1NZ4WQkMRiBW/3RG4KZ5iIz9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173842; c=relaxed/simple;
	bh=GTz2054GWUDBI7CKgsCM50hN20ruC3eNY9HAJJdO9PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLjk8Bw3rMAmWVtOSchPhcAk0slSTCUpgooq4czrYzrmmIcUrFD6DlUZCemYCZWMGJA+GzVHY++J5BSOrR5O43MC/c0q41CQ90w521ttGms7NJdsyN0D4vIOQrEeF5eolB8nsGU2DImCqPy9Q8lTYoPyOpP3MEZmVBAz0FSiD00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ3giCEL; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ3giCEL"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7ee4399c3abso2264084a34.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 10:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785173840; cv=none;
        d=google.com; s=arc-20260327;
        b=iUeHRaRBlk728s7hu5ImB07T/5/M2ChQ5YZNrSbw/YMouCZWYupkYUC35opT8q0Qwk
         nWh8viqAdC1BVD4/TnFBiqpT4L/hY/wMFBdpnVgETwq1ICqsD/QLm1W0EpCQJGTxG3ZB
         VIg0Iz1iacNYahFart0ZqT68BHIPIQHG2hV3Wm2tHZg+K/ISb1vlNsUqtgrSKprt85DP
         AYg6L6+vlBHCK78NmkH6lv1oEEHDuPvMHEl2nI2Hg+/oFqWI5Bj3ONFw9tpgeIi2dDR1
         hqWGZinlX35UueU9xaAIcqBKXEKqqLBSButqUgl9fOwRycDSu3pko6ya9CEEzQdpH52/
         ID3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GTz2054GWUDBI7CKgsCM50hN20ruC3eNY9HAJJdO9PE=;
        fh=0MEXze/YyaZIS5ggcNlAV81rzJsgCeE/hRC2GicnnxY=;
        b=G7ssvVnfna3tffmPKDdV6vLv6iq80+iibGMxSuX5eYomqgHj2nQbsR7qrsv7Q8aoUY
         udr+dy9GBJ1V3Nyrkp0w9bdhX/V1YbBaBptzb0Nrig40FDaAVw4L5ryWkkdumq9i4NgA
         F+WDGiluTXYmC6h/6+wQso67XWcl4yzdSqLQ1+4im4M7x0xHxtW6hT2W8yLCCNtJ7XVd
         n51qgNQaCAFfNtzsEaQiG27AbvHQNi0YODkd73xc+NtZH7E8OYIthaiF05IVe+ZCJwxN
         RymBFg6VE4F5gsUZ7FSm1vI0u/fYnri+w4b7wdeJTPtpUXqDIIlVAtMCKyqjeEqbZFvD
         kLUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785173840; x=1785778640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GTz2054GWUDBI7CKgsCM50hN20ruC3eNY9HAJJdO9PE=;
        b=hQ3giCELbE6MDnMX6bzl9vozf1/0pH2nTWimtT51V4ubu0koaFlDhAxYWKTMI+32Fs
         km/oFn0C62s+Kzv65NJb3xMaew09UaIw9t5jBYamslJXotShkOBT3wbrZCbQ6vuauhv3
         QHUaq7zEHx4moTkBP5+xIpkFCvROMhXJ4736r6C5rFKE7Ulsb3lsm1kKx8sPGp1ycsWQ
         6zp2bHmhqpUIaVIzH0sfHc83Lu8jROL4A0Q8b2RJjqW6EM9zDOn81tviOIYUj+Xf0IZZ
         z6A5co63zU5z1RwxCG7xWVkBvgmMlR/ebqHIgBNWg3LY0ccvfQAe88ArBnSi+cgzJBLx
         HRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785173840; x=1785778640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTz2054GWUDBI7CKgsCM50hN20ruC3eNY9HAJJdO9PE=;
        b=NW/PzQL4i27GpFMADkpuPsywBgp+4okiykLVFd/NIuVUSeeHwFTjSL7jeoepeLhOoG
         AcmPPnbWK5OMXuWIGv8LKkTQ6EPjsGslVhyyGkBGiBgLWvHvQivRSPuMm0E0rEd46ElV
         U6q9plOuwWDMKt4ON7VDKCrIR9hrap5MyqGWv6mcCuySAezpFwOK6kdQJRDyqXRIt+m3
         Nwek7XsWFNGrPZF9sdKEGDDaiFQiGxZChFGawlIi2TFU3fM6cLzA0rqWEcuxEH5H2x32
         pw7GR2wdmymNvGzRif3NyeUebdkAVMO7aY6oEHdO25120OGvA2Pylucw0QVSqOHe8Aef
         r+sw==
X-Forwarded-Encrypted: i=1; AHgh+Rp3ctj7buTlPjtgsXfUDpz2s2ffoxjVSostvsrVtPL0H4VAiUgUKtjdtEgQMnnM+A8ULls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCsrLMP3yo1D13Occ5Xb6D7HXnjq2Xft5e1hUbGNdONLgXI6z+
	2hz+xbEf9olSlFkPkvyCx5vaQppHaPFsXMToGg7IYroK9dzxNqv9/uaK1tDLGEpzA0vXtJrmrVz
	umlvV3zaLDjDpljmS9FsCXsnkYyshwvs=
X-Gm-Gg: AR+sD10/9as6QlqASWq7+evzGAzuAaIl4yXzhe3uvj37GK9c1dz4meoTk4JE8nl08IX
	HzhQ3cX7ear2y605xaKVKwf9R4kU+J3/N0FP6hfdNR7CQbNQ5/yk3Ch3B0mH5RhkwJBGT0ZQHmy
	h56y9zWKvVwNVz4QFlSxfTv3MsQW4/ySyRNIPnkdG6gg/Lztzf/e3P+8atKWRhw/39MB9gFv+F5
	deTiPN5TKla2SYGeEHzo7bB6FApmJOmFxhfAuQpCRFFgIeAVC9YH958W84DlK4b5z7w6Zybbmhb
	INHxZfbxLNYqDb23FnLCMQGNIDsrW9OAfN72csBqsXCWUDvnNDFCn/P7r2QES/xAQiFakE9Sf8X
	58Gv6JcEOIMY03g==
X-Received: by 2002:a05:6830:34a8:b0:7e9:b4d1:78b1 with SMTP id
 46e09a7af769-7ee78e13a97mr7490031a34.31.1785173839779; Mon, 27 Jul 2026
 10:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717140232.6722-1-diy2903@gmail.com> <20260721065736.8747-1-diy2903@gmail.com>
 <CAC2QwmK7HVma7HMxmXvC7qa4XQVomteC0x7PpX61MjpDLbvDzA@mail.gmail.com> <734cf745-ff32-4681-be2f-ad3225c80bec@kdbg.org>
In-Reply-To: <734cf745-ff32-4681-be2f-ad3225c80bec@kdbg.org>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Mon, 27 Jul 2026 10:37:06 -0700
X-Gm-Features: AUfX_my-_CDzDD_g5BXav562qnKgRF45y1TdqCBeQTTVsf031EPiFsd89llmXGM
Message-ID: <CAC2QwmKuNEnFHraKTUkaskW4aeEWJvS68SyMfxMnhwMEoJuhrQ@mail.gmail.com>
Subject: Re: [PATCH v2] userdiff: add support for Swift
To: Johannes Sixt <j6t@kdbg.org>
Cc: Shlok Kulshreshtha <diy2903@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, "D . Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Eric Sunshine <sunshine@sunshineco.com>, "Scott L . Burson" <Scott@sympoiesis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 11:44=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote=
:
>
> Am 27.07.26 um 07:03 schrieb Michael Montalbo:
> > On Tue, Jul 21, 2026 at 12:06=E2=80=AFAM Shlok Kulshreshtha <diy2903@gm=
ail.com> wrote:
> >>
> >> Add a built-in userdiff driver for the Swift programming language so t=
hat
> >> diff hunk headers and word diffs work out of the box for ".swift" file=
s.
> >>
> >
> > I noticed other languages add a test_language_driver entry to
> > t/t4034-diff-words.sh with corresponding pre/post/expect
> > fixtures. Should we add something similar for Swift?
[snip]
> In the past, these test scripts turned out to
> be non-trivial to get correct and it was a burden for both the author
> and the reviewers. It would certainly exceed the scope of a microproject.
>

Got it, thanks for the context.

FWIW, I tested the changes against a recent WWDC 2026 sample
project[1] I was playing around with, and the new user driver appears
to work well.

[1] https://developer.apple.com/documentation/FoundationModels/origami-craf=
ting-a-dynamic-tutorial-for-apple-intelligence
