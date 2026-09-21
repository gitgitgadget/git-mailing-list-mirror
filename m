Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7B845198C
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999428; cv=pass; b=QgfsBH8WJr78trbh4o8q5GFnWKaja0nj7gi3CP2nMeNAjPJduNtsaF2ysIX1302au3HGWcqm8+YCs88ScddfreJvBbFK21prblLTbAmnIWNbRyu7rBJmtpHfvp7trkJkJXS0J3K11wVVQglzbu9xIFawVE8LonklUuCpVzN+Tk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999428; c=relaxed/simple;
	bh=I1S57Yxcn3Ra2fCbgxqqvejX3A4i9S9fh7efvGOzUOY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXNWwgw7hPeF6PFGoBPIpBh/iWfTGnbLYdNYYoY6V4V1/OSQcQwbC4rIqrpDsdSOURmwSwnd0MKwjEvCfOSqiwmGERxorqZtZMCrRSWafwsI/pwduiyZh8zocwMVnEqx0RSBECyzgT5bslfDMIWiLUUajeDlITELEhe7Z5BEJXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/T/fFRy; arc=pass smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/T/fFRy"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-97e7c62dde2so651072241.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 07:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789999426; cv=none;
        d=google.com; s=arc-20260327;
        b=l665ozXE0o6r3Fei0nSFjKMDBfS5hzwp+optG0olpLXoEY7Q5yaSDyt7u49ZCM8w1I
         CMbHBsAeFgylIXibjZjiL8w4otsOuni4jU7WUtBKK9e5zqffrvXXXL9aepb+A17FFi6L
         /nsxMI84x4+n3cgych61IkPcuKtcWb0J/zuGRm4M4jqMSOiYiPR9momZf2fwRJHM/Wz2
         FqItUufn9CI6Wse9ydvCZfEv1QQAgl3N9WTI91Tys8tcO1NHYCLruQMiY16BC/aleeMg
         MEyL5CarCLc7b7pcOFUAtuIZxfUNPMP5ec3sOzpFqGtuXnMJYjsKefRHkeFD9cTh840E
         FsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=I1S57Yxcn3Ra2fCbgxqqvejX3A4i9S9fh7efvGOzUOY=;
        fh=yPGiKH2JygXCvJx0ewcdh9yz8r4N6JSzAXk0Phu5AgM=;
        b=gNaGGJWbsxg01G62wLEYjts8nqnckKfuZqFEIHxlO+VjeD/UtH9jb/YyS85dYYsQWU
         /wXPw+smoyv1Lm5/+jQOyP2NbxlFNfTAMqVTPqpNhvn8IXf4LUXJWc2qbvPyw+SC9lan
         gNc055/6QFG7t8vyPeDL/IlCkiC7PBoYSlmDYIWZJosEPQi6M+mvbEgy+CW2NRM0SeYh
         vVEinoQxTgm0DEvxca2Bhi4O8REBviRpIkJygXhPC7u3dEKOZNQUHWJjdERrlRKTwTWK
         wXaJSJ9MtcJ0K5WttjWNo0o0C5urZSfTxXsyV8yjqzSysAOCvZavGW+U4dBQcS0QNljM
         7CQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789999426; x=1790604226; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I1S57Yxcn3Ra2fCbgxqqvejX3A4i9S9fh7efvGOzUOY=;
        b=X/T/fFRylXY6tNECIoUPmA3BisE37dYUYATvyWk9+12s4eWxhIgbaHtj7OsgWsti15
         zWJI9ljXt0DyjBGS5yDaY6w3KVpdlvBWzDiuQ4avXWSWeq/y+SUpZUZQ7ahTEzfN8sRV
         gnEh3COta4wyD6AVL7vQ+DyRs4srzgtjSLmYG4mbsXs/E8MmPdscKHnjcR/IjeCdJLLn
         ro9+3yYDzOpI7dF+EK7CzN4tNGVS5qHcGgq9Z1uL4uJQ57yLX+j5NeCkBKBwWkggvVJj
         qlydyNgmXLijPX3oR8gRqOoCtQlvikoOOt8FXHO6kbtTGiI2JDzip+3rcW+xieN6QOL8
         CDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999426; x=1790604226;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I1S57Yxcn3Ra2fCbgxqqvejX3A4i9S9fh7efvGOzUOY=;
        b=qpnaIqWJH4840FP15DdPrhZrs4zPOEe2NHc4o6kiQ0KN4USK0BVoaoir6IR43NR/4X
         IxJZvtjilLgokLGy+5PC/oc7RGBQGXKmMSCWGPQkBiBigots+lOSk5jVckDrH1Ad3fdv
         onuTTbSxhM9F5CDZ+TXxYIEy9YjUBbs34mxs+1GuhRLKNnp++JGKCKAjnZj+pyGhd5Ld
         wWuAclsZ8Xw381vYIFQXPNl/AtPv2kXUsITZ5hC8glkqy9Zv/mhqWBOjyVqRsWrKSwLY
         1RdvHZfxewhsl53j8lNepuCcvI2XYVimlLB6+34dOJF0LnVhKBAj66y9K4/Kb90SUkIL
         1SIg==
X-Forwarded-Encrypted: i=1; AKwUvBz+3iUD33nL3GXuNI7aJzaTRHQmKzbLwHeupG8+SXl2NFtPXNd+dDAYJkkRDiklWkPVj/o=@vger.kernel.org
X-Gm-Message-State: AFuF++nFxYi56XL17OtQXpbnsgZ9P+TPvTh0itqUfnvl5Hnm2TzkvwtY
	q1D+CNT+un3flRjHUstg+e5ZX95iiGXcFyj7CpZok2xowPfiawjIUkqzF8V8dg3gIdVR2fcAEfU
	TQ2XQi0Y2CsFH5NIoUDEqRHWlV/MJdhY=
X-Gm-Gg: AYBFou1LlwQSV3VjVPhuHt9wSEs6b0+UsZ59ciaCeN6jzVVMP/YLiWMTIOtWhrMcsWP
	gPA0X8pgBTdcZKscpAKnD/3kQQSebNZZl22H9oqq2+ZnELN5nVc+5lh9OKgW7lwfIi7akRHsD/D
	5hMGk3CkFk3u6U8jq2ByGoSjR45BPLORSQH0jnC76MdBhATVUqfyNcclREDqktFjJ/lw4D2alpT
	fsI8Y3OwFRS/xH1t3buZNqPLT+2jxNVfL7nDs9EK4hne260RipViDVpwumaSwjsfnfYEJbGzbtW
	vOeU2j/5fUAfI0pVNvmfUIXWven4uyTwNnM9J7B9BENfeibmbKy6ZCtJo7XHN3tQTRE9C8B+Txk
	kS3mHV3rybuUL1tjM3vxK+qvtNy4PVB6btmJtxermk0HDJw==
X-Received: by 2002:a05:6102:4410:b0:7a7:3485:33d9 with SMTP id
 ada2fe7eead31-7a7348549edmr2339995137.24.1789999425570; Mon, 21 Sep 2026
 07:03:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 07:03:44 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 07:03:44 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <6c2bba91-a1a9-3547-4be3-f4f9ce03e696@gmx.de>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
 <CAOLa=ZTgF+Qw_1FMUEF-YyBYo-gKnhPVk+qxd+gt1PMrt9GYqQ@mail.gmail.com> <6c2bba91-a1a9-3547-4be3-f4f9ce03e696@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Sep 2026 07:03:44 -0700
X-Gm-Features: AcwNN1UlDoZn8IxhvLn-6G_VJs0pYFStsCRhbt4QbdBDKZ4uuDpd83BXjdns8cQ
Message-ID: <CAOLa=ZQkJui77Xz2HL4sAWsaYLAzU6EPvBk+RzKkKxoiY_8aKw@mail.gmail.com>
Subject: Re: [PATCH 0/4] gitlab-ci: fix the cargo invocation in the Windows job
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000e9040c065bfeb7e0"

--000000000000e9040c065bfeb7e0
Content-Type: text/plain; charset="UTF-8"

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Karthik,
>
> On Sun, 20 Sep 2026, Karthik Nayak wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > In https://lore.kernel.org/git/xmqq8q4zosri.fsf@gitster.g/, Junio mentioned
>> > that the GitLab CI seems broken since I enabled Rust in the Windows-based CI
>> > jobs. This patch series should fix it (lightly tested, but I don't have a
>> > whole lot of build minutes on GitLab).
>> >
>>
>> I've created an MR [1] on our team repo for testing, I'll try to update
>> with newer versions (if any). The pipeline for this version is here [2].
>>
>> [1]: https://gitlab.com/gitlab-org/git/-/merge_requests/671
>> [2]: https://gitlab.com/gitlab-org/git/-/pipelines/2863888081
>
> Thank you!
>
> It looks as if the `build:mingw64` job succeeded, as planned (although it
> should now probably say `build:ucrt64`?).
>
> The `build:msvc-meson` job seems to have timed out trying to do something
> with credentials, though...

Re-ran the job and it seems to now run as expected.

>
> Ciao,
> Johannes

--000000000000e9040c065bfeb7e0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7a612506589ea2d9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xeE9UNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnhCQy85Vks0UkF0a04ycnMwbjlkZS9PTTV5MHc0LwowWWVVaFNSRWJI
MWV2N3Njb1owU2U0OE0rckdheVpYVmZVUDFkbzVMbVNMZGNSUmRZT1oyY09pYUlXMXFPTjdiCkdI
MU9BQTh3YThWSlZGRlpqVXE2Q2tOQTlQWHlwSXRkMHp3aU5oQWxPeWJtQTJaZzAzOE1mcVJ0NTRo
dlN2MTEKNnFEemxjcFh3ZUlmazZWZ2JVQXJyRHBqSkl0NVF1aU04Z29rdDVFS1BTTEpxbjkwODV6
ZWVJU3lVaFJtUE1xMAp3WStsM00wUHBKeFNES3lVaGRGWjhNSU5zbURHa3czZkpiSjErWnk1bnZr
WDNtTUw3U2RqOWxFdmIyUGZkT2txCm1MTmY5Qi96cndXakFVRUM3Tkd0WjlKSTJhNytucDNlV3N3
TFkwdHRpbkQrSXAwVjJyMlZGZjFsc0pzaHpNS2cKL2NWSUhWQktQeUdWUnJMT0JibWRZTm5SODFo
NnR0ZlplWmx0b0QzeFRGdlIyTVd0MDNYTnRITDVjV2hkdTZVego3ZW9oTFFnSEhmVFMyVkhLSTln
K1JlTGhOYlE0TFdyVEprdTBoZFFVUVdFWktkS1BOWld5YUU1ei83bVJnTEVBCmlTSFhZSFRYcE5S
RERiYWwwUVltUUZ5UmliVzRwQW12am5oa21tND0KPXRZUlYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e9040c065bfeb7e0--
