Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D3192590
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950725; cv=none; b=adMXBcPMkMsBkTTw1nsFwq2Dt0us6mlA+nyTNsWi+nwG5/tW+WNV3ixBYDj89fobEVHEi9K5a9rAfNSwyp1cOkaG6fVXFjxOyVRuKe2yhigcYpR8BPqBEDM6jfrUPvCqnZmmjX7Y0fdILoMs9aJ9EXYm0xs0AOE1tVKcmow6LrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950725; c=relaxed/simple;
	bh=+uPJXVBRpOlkc106mfJMB0ebGaeigLPlJmxinVdxsh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVZ3P8Yc9OSXwQ7xAp/7oOndfxye5ri5tU+W6GDhn31f0ZP5Fw0bNnXFybBfPl6Ii04FH+hsgppYtvZ4RfUvtEbJu9QVpL7BLElsrzR7/l36IJHVlGQGDap05CJ7Xl1vR3OX97EB0qX1h201KikbfE6tMTAbacK9g+RztMAW3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laOzlWV8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laOzlWV8"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab795eba9a3so61300766b.1
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 09:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738950722; x=1739555522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Npjx8fq12c/ZQqbI8M8I5LblKjIgcDKxmOQ/NvKKJn8=;
        b=laOzlWV84sxWC4qa7vtps9yHVU+HRJoNaK9Rt404t9Pk4wJImTwWwBxG0151lICmow
         LUXluLASPtcxbjYt+qeRFaY03mkEJjbin33yZVWh9LNUk1XPNzoBOGau0ptB3jh0j0Bl
         0GQKbRVk1yrmX57xY16ygr18Q4Uroen+dT5hfZ7kH5OApQxdI7KN8JINzYZx/0LQJ19I
         YEgBujSbfidWftBpQ8vwo6JjCaiAGMNn1F29WraU1XYRMEBuSXMIEKOdP2+gMM4Q3PF8
         nYQpymLlmCYoqb369LtN6qr8ib8wNTGeb4GZ9QnjQU7wkVnH0/bWlXc6p365NJsMuPhV
         NfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738950722; x=1739555522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Npjx8fq12c/ZQqbI8M8I5LblKjIgcDKxmOQ/NvKKJn8=;
        b=Z2oeBKMLCUwCOiieHbDMbze4tsfslDKkRugP3bkRLNRka2BgiALTl+8W3aNYAeYa1G
         PAVysKIkMs37Bw94GNk7O8CtJrfZiZjc+f4yQmq4FKeRn/sTAWnDsxlWJwxzlNbQRCWp
         i+HReJxbpsQ86GDjZB3rDZUMe9m69eArag9jTOgu1ghYIrMzvyLfMO0B4O8K+lr9FIeI
         WBwfQvqszIYeK38Wh1YJzp5dkYuDJeqV1c1D4N1FJN8TIaKRDzGjpMHtxFwdNuqGgwnk
         +5jIBeRLy6zDknTM+b971+UwVVeN6VUJMIP74UssePdJrAU2dGJs0WRmSWYf0bZ0wK+J
         jfPw==
X-Forwarded-Encrypted: i=1; AJvYcCUo28urUKL211qf+Ye+H7QiMOKi2gzsDKW8CSC1mzmqBBvXMm9tK+2qPvlF2W66hOIWRKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG+GWS4hxa1HXW24o8keojtjSatyn96pqsbAo9RsJvcZxa76Ph
	HBhPeZLzG56ZhqmCm6P3cVWUgbw/McN9V0JFHvXM0WXb/1gydmMZPnLyJPAaXPcgREVX1NFFJSJ
	L+Bd6Gr5jn+rvhsYIwj0iH18nRVU=
X-Gm-Gg: ASbGncvQo4VgD1eIpjoPy+O1RpX8s+kz56Sjm2D2Du6/16QnQehqGy2da2KsnH6KEr8
	ZyT3qYZBQWNkUyw8yks2iW8lxwXEkG3bopgtX+f3vxADYgaHeY5i8IaR+GlQLVNcBT0Y6lvR5Pq
	3HctmAduasEYOobtLi9svl+N6szT8=
X-Google-Smtp-Source: AGHT+IGrUB8TNuGKHQ1lgYX1maPOT+NV1dcUogbmLZg9PVpHF/1V4Od2FnBBK8qU2WL6AaAKD5UwwO49uWR76doD18A=
X-Received: by 2002:a17:907:1c9e:b0:ab6:d819:feb9 with SMTP id
 a640c23a62f3a-ab789b1e023mr485627866b.26.1738950720212; Fri, 07 Feb 2025
 09:52:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
 <20250120015603.1980991-5-sandals@crustytoothpaste.net> <CAGJzqsnFNfK6DEcbRQsUB4S8qVBnQ2PcJBgbvCPYLd-xAVVQBA@mail.gmail.com>
 <xmqqo6zeixnk.fsf@gitster.g>
In-Reply-To: <xmqqo6zeixnk.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 7 Feb 2025 12:51:48 -0500
X-Gm-Features: AWEUYZn9XabQ98o704nelEDSahU_V1okesI9QcXADFh-ZXOA_X216J8zyqXOl04
Message-ID: <CALnO6CAa+6xx885TdKFrpruxHbN80S3RE=STaswnaUz_3QZQ=Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] doc: use .adoc extension for AsciiDoc files
To: Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 4:14=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> M Hickford <mirth.hickford@gmail.com> writes:
>
> > On Mon, 20 Jan 2025 at 01:56, brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> >>
> >> We presently use the ".txt" extension for our AsciiDoc files.  While n=
ot
> >> wrong, most editors do not associate this extension with AsciiDoc,
> >> meaning that contributors don't get automatic editor functionality tha=
t
> >> could be useful, such as syntax highlighting and prose linting.
> >>
> >> It is much more common to use the ".adoc" extension for AsciiDoc files=
,
> >> since this helps editors automatically detect files and also allows
> >> various forges to provide rich (HTML-like) rendering.  Let's do that
> >> here, renaming all of the files and updating the includes where
> >> relevant.  Adjust the various build scripts and makefiles to use the n=
ew
> >> extension as well.
> >
> > Hi Brian. How about also renaming SubmittingPatches to
> > SubmittingPatches.adoc? This is AsciiDoc according to 049e64aa50
> > (Documentation: convert SubmittingPatches to AsciiDoc, 2017-11-12).
>
> Do we pass SubmittingPatches (and CodingGuidelines for that matter)
> through AsciiDoc?  They do not even have .txt suffix, so I suspect
> it is not.

I don't know how (I didn't dig), but we do build and package
HTML-ified SubmittingPatches as both $(git
--html-path)/SubmittingPatches.{html,txt}. I don't see a build output
for CodingGuidelines, though. (We also package
ReviewingGuidelines.{html,txt}, but it has a .txt extension.)

--=20
D. Ben Knoble
