Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FDB1DF261
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774486515; cv=pass; b=j97mCh9M8N3ymgPYkeHycy2kTgoUPUrhma9JiVJFxCy2tSrzkjy7b5GSEHeW38qrMxHo8ZRfTlF1DYYwsDkXrCdzoc8++utqqcysRi+paJf957OHWRp/j06bcJlkhNFLJEs/CvHD/cRqNpUsxYqqfwWJeAJv+dWmDg0TSRlMjfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774486515; c=relaxed/simple;
	bh=IC5WyGpdDiV/uowUgRYLJqFpSJ9xSERClBLfwB4NF5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWFQz4Mg+o1GLdhz3b9CPsIQhBA0icIkMc7wxsCCMz5iw6e6PAdXdf7OAF/Z6zlzddRVjJsfS6EIYbGnHdRwRnK+SIZ2hppm9CrFOGqdcWnSVhA9GR8S39Zvd3f+zz5KpzJh7PnQn32Gijh1j97hkyVXcBCJbc4iz6LPsH9Rt0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acokKv7W; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acokKv7W"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64e8c7f5082so508435d50.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 17:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774486513; cv=none;
        d=google.com; s=arc-20240605;
        b=QtKxSzztzuue4xP7A9AAi89nDAvLLRbvx2n1kQpb280RITBP5BfQOy0wDkI1jjiDLZ
         ntwr9uQ9Vwt4u4gCEdQwlYeVW6u8psCKSQ4jSgyd0nrb5OW+Nrs6eWbcYZ1cIqz4ag+p
         wxaH+zNg258jnznfHBdEDVA/F/NUiF/QZC+3XfURE6YT5gulHv3a1pmNz4M68AABsJHO
         YlH4SjurMiWkzw/mJFvMeCPAkhUZJIMaAr1xzCANSVQsRbF/cAO+HKH1CoTuMP/ShL3D
         WmITsJJmodB3FV5Cjb8dkge8HOFkrytVscwlwMh3fxin9WOcM/wUcomWWKLn41QL9REY
         BO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BVMqiFl4EF43Sp5qwv5TCSBLQxZb4fBd95wFQJYc1aw=;
        fh=RtMFSjjeYGrRbJ9Wg8RNbmZc24Qfrd7PQWKjeOJm46M=;
        b=cyjpXP2M1QvqTdI1zjpXIWtRtJ0OIL1Q9Ht+Pswo0avkfrizRRzL7jzZW3Q5heLkdU
         8nY6YXtvNHi1TnlSCEaM2Lxux+0+zAgAO7kQJpV9Q6QM/oQypMNEtsF2Oi3AJd0ZIZVn
         cIil9Zp+FWRpilfFHOOAGwkcJeRy3UINC8z6ToRfE/2VRGIMXFOr6aoFudIOJOtM4WSH
         uS2Wv19sIvDUP/QbmKvCKdR3Hc56M2TK0Wqyl301S3Y+/fpmGAtcGNMWFl7wEVFi5zld
         sHd3+40NtAwON9en3dp/brqCUAz0H9nWs7FWhTSlzD0jHlh1ATr5ARkgMgBIEOEsASkP
         lZ4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774486513; x=1775091313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVMqiFl4EF43Sp5qwv5TCSBLQxZb4fBd95wFQJYc1aw=;
        b=acokKv7W82Y++icAqeGedyN+zCLuNqulaiv2HWM/qchknL4D2pScTLSy3/ZBt0RtDA
         e+vZKEoeWhZ7FphHoCNQuaNNGTkolTQgvgmxrdKA3C9aZNJSFr4sLc47R2hdWS8A2ZKx
         /xSjY9pG2Zol+DjOzLIMSy7UtQfAeJKWeDftZQH39JsN843E+9Iwe6eRZyp7E+I+DjZ7
         0HawpachXvatzxb1qzgk4QhS3h64AfoCWqzNNpVVShxEI5KelDk0Lie2AgttES2FCPMs
         HibB4YtLr88A91f2S4wzbTJ+8rjHBaVKJnZ7mI76/Z9hD+ZPMUhpfzysaKjxYnPVrVzu
         LIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774486513; x=1775091313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BVMqiFl4EF43Sp5qwv5TCSBLQxZb4fBd95wFQJYc1aw=;
        b=oDhuFM8x7xNVqDtz9TjqlkX+K+IAlQtkCvALqc56lt7LQvQ8f8cv1vYAq0coTmh8m6
         zx4NS5q1P/YTgOwRG5mP0j2ioZHyQub0QwtnAEoaxUVfDJVDNrD0HRoBXqf3RwphLV2+
         ylKbeX2xAJeBvVxvEC1q8pOfEaEGD/xkHLyL4GMKUG2wO5G0Mjv78LeSLhCuQfZWg9sW
         LwvTy1HzhuCXXLWIgbI2wkIikr+xbWciPkdM8qVj2WSNGgLj0mrl1fImqaTg7gDIHIW0
         fkB+qdlbHvlO/jPdHgKO101SpN4RsFOA8vkCQmE/WgrhmXsUxZsPXcWICkyfxbyGR1xK
         mT/g==
X-Gm-Message-State: AOJu0Yw+0yPYjY4x81fruV5iIk0s1jv7QvAq2LdbvvZlgwzOftdMu8/L
	XKf8wmT7Yq9EkLIA9jjImwpEDexJj1zCqJzYH8SVQAoVMI04u7oodfdy+vVLcPD8TNizN8VTVQv
	LY3xUtFAbboPlcbsNVUJ/ajC0bmrBk01IbGzaziQ5Nw==
X-Gm-Gg: ATEYQzwzOWmLo7wQlh8mvBL3yaLnPE3i0ZBUXWRPohUiB5igCt/Y5G0q14UL6YlokBK
	3iR8AuLnpEJDbA5xjNEvns9gicrpMaywwqIYbWjOcQ01E2KAbeHNBj9p8++zapsCKZGy/gqn2+e
	JiYlk5BaMl2IpUvo3lQRjQZbyAZVcu281obKEtt5AzYaxnHXrrklAdmaJLgaanM+hXnbfwdkAp5
	lfqI37cD7/bqT5H2bMI/V/p9JeS9NKnJEiMrYXDH2lHbEirfh2c/KdmWGcpwnjFiZsda04KOCZG
	z79tGF4gHwJRK61zZflbCkr9hvMEkvsQ1gNlUzUs+5dXD8Mf0fhXkoMbJKM6i2aGGxSq4UyeVRv
	KjgH34mqT/1Btor1nwV2TbwEWvcmgVYGwoQ==
X-Received: by 2002:a05:690e:d4a:b0:64e:a976:dc0f with SMTP id
 956f58d0204a3-64ee6077c2fmr5060974d50.19.1774486512645; Wed, 25 Mar 2026
 17:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPAKoce5BeXMPtok+dni+WDTkokCAq0o4uMHGg1KZto9-UniXQ@mail.gmail.com>
In-Reply-To: <CAPAKoce5BeXMPtok+dni+WDTkokCAq0o4uMHGg1KZto9-UniXQ@mail.gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Thu, 26 Mar 2026 01:54:55 +0100
X-Gm-Features: AQROBzB0KmYg-4-AAnpkCQyPNtceI9Qyi9YfXcRJrdyeK6AYEub4u_EEEzuiR7Y
Message-ID: <CAN5EUNR2yh+OhZ-JtW-dcAFQ3k_WXyB3SXUsEb9FLReuRsMLow@mail.gmail.com>
Subject: Re: Github Patch
To: Zakariyah Ali <zakariyahali100@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Zakariyah Ali (<zakariyahali100@gmail.com>) escribi=C3=B3:

The mail is empty but for the attached patch.

The patch should be sent inline in the email body, not as an attachment.
Please read Documentation/SubmittingPatches [1] and
Documentation/MyFirstContribution [2] about how to send patches.

Now, about the patch:

> From: alibaba0010 <zakariyahali100@gmail.com>
> Signed-off-by: alibaba0010 <zakariyahali100@gmail.com>

Your email says "Zakariyah Ali" but the From and Signed-off-by says
"alibaba0010. These should be consistent.
See Documentation/SubmittingPatches [1].

 "It is common, but not required, to use some form of your real name.
We realize that some contributors are not comfortable doing so or
prefer to contribute under a pseudonym or preferred name and we can
accept your patch either way, as long as the name and email you use
are distinctive, identifying, and not misleading."

> Replace old-style path checks using `test -f`, `test -d`,
> and `test ! -h` with dedicated test helper functions for
> improved test clarity and consistency.
>
> This modernization improves test script readability by using
> Git's dedicated test helpers: > - `test -f` =E2=86=92 `test_path_is_file`
> - `test -d` =E2=86=92 `test_path_is_dir`
> - `test ! -h && test -f` =E2=86=92
> `test_path_is_file_not_symlink`
> - `test ! -h && test -d` =E2=86=92
> `test_path_is_dir_not_symlink`

Try explaining why have you done this, why are these helpers better
than what was before rather than clarity and consistency, what do
these new helpers do to be considered valuable to refactor it.

> Found instances using: > git grep 'test -[efd]' t/ | grep 'test -[efd].*&=
&'

Even though it is mentioned on the microprojects to mention what have
you used to find the file, because it is only one file, including the
search command is not very useful. Drop it.

Given the date and that this seems a microproject I guess this is for
GSoC, you should add to the subject [GSoC PATCH] and CC your possible
co mentors.

I encourage you the same that it's being encourage for newcomers, read:

      https://lore.kernel.org/git/

There you'll find other microprojects similar to yours where you can learn =
from.

Code seems OK.

[1]: https://github.com/git/git/blob/master/Documentation/SubmittingPatches
[2]: https://github.com/git/git/blob/master/Documentation/MyFirstContributi=
on.adoc
