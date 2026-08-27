Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D837E5D2
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825129; cv=pass; b=mDvgBLtchIgey0nZxTzeRixoVgxjz1270r9gyferu+pKaIcMzXyN9kVO598Thh9ro0458iPKNuZwGtvCDwTwniIpmqJC1Y/MvLBH7Qd58jQL0mHFAJ/73ilS+yShpUcVTl6VI2DyFqbssQjOaAxBT8KKc1GzCbSAaEfY21ryla8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825129; c=relaxed/simple;
	bh=C8JtRC8NTeUnCNYlrSeyj/ETM6n/x981VVkYOv3Ofvw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=iL5yOC0V8zy0+9P8U1qM1spjEXx/wMDh6g4AsmOq9Fs4kEd3+dd2ITV7MjBZJWtAvNcBH0yXleb0eyIgRUUkae1i8ZjSSU4AKgwl/n3Fx4ZbAm54jCv/FOgC5ZanI0LcXWwsxCPDDnSErJYsecXiQTbUnckqg9zJw1Z0J9I30u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVT3C1+D; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVT3C1+D"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7838857b001so766520137.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 03:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787825115; cv=none;
        d=google.com; s=arc-20260327;
        b=sj8705qHSHlTuasM6KfmqTzsPCFGFu0nhAPFVbJ5V5hm5mU7oiIMnM9gTrMqV0hwxK
         fss+4NtHXs0D0OiN3ZXM9MEFUOPZ22Vf5tfzAfWEDOcQA+Is2hFuivDU0k/aHbkJaHz6
         jjPEKsGLZazKqrjarMCWx/at200EZxbGKdC8Hzj7tj7/Ng9ha+X9KYQYCXMURkRryFpD
         L4+HKumvFozET35xO2zqJI+Jng+gTx7yx+mQHEE2wqqsf6e+k/d3zud+06ayR7kR4sup
         66w3fLilmQuKOeVdc8sz+U9kOLdcnoo4QNVOJTt9PMq8tQh3H2Aeg9XtziSGQVPnV0rq
         i7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=C8JtRC8NTeUnCNYlrSeyj/ETM6n/x981VVkYOv3Ofvw=;
        fh=XxsF5RW5pjbpiL/37vKymhnAt8umi//Co7DDTcwNvEM=;
        b=QEITQmS1EH2GcSD2dMAFW1AwdDh9A/mBXLTH6JSCVyrJqnrovc3Mo5mSQsM+XJ9Czd
         Deq9KlwS73lBG7piuwEokjbBnHsbecMe1+cIoC7uv5HK0yATk5a4qh//2pO2eU6T9oyV
         fR5p7D7ua5pLDgqXWnbIMKMdCjXdnw9jgtxr9wlVfKE6/I7dmcdTEZh6x+Ds+O0jFuD7
         UPRS5Tgjj44o+ax6ZjEPjpSxMQYPE6bnLgT6oi4n4qnQkXJYfOwShqcTt5x4Xy7h3PWM
         HRU9w6lU4ZSJB6W4eVR7aGLlqNmCDTDDwYcB/ZNnJzkCvMkOCfbBUREHy1xC4P4P+Xev
         yJjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787825115; x=1788429915; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C8JtRC8NTeUnCNYlrSeyj/ETM6n/x981VVkYOv3Ofvw=;
        b=ZVT3C1+D1SAkclWnpxzhYzLfOTsoFE5HonjRNFcgKyJJaFVFLe0ZgYn2vKzPWlBRvC
         uwLVyPGD8p3AkjWneXpxWX7iXF9egdkPGyVPey0cNosSoLzOGIY6AeAZtYYXtbdxMouJ
         GIvRkpm6123xZbYwo8csE3oGnQgtEnuoxEMrsOMglboQRTz4jIBuawaw2R1FmH01aKlc
         mLHo5kU6SpQuYH0QkBdNCb/Ld6xDVt2sm9jwBBk6fJ09xKeOSQ15vzP1AkoWG/Dt7ZgQ
         KYvzXA9V9QDtAqfTRSI3wBequ27x9eSR57G4Be6wK08UEbCVgkxCCFvJADzzUGMT2k+R
         3bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787825115; x=1788429915;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C8JtRC8NTeUnCNYlrSeyj/ETM6n/x981VVkYOv3Ofvw=;
        b=mCrVRWZmBgRS2xJ8kZ/kWcoeEPGW7Mz+qzX9SkRz5wZcJ1QSNgmBicSWnajo3GWtoN
         jYT3zPJDOEQplGi/SIhc6WqamKdKXCIduVd8Bxf0H8sKu7wVaEHBF0vM6NeIa2wrELB/
         +2t+EbqsOVyxYsXYkW5qJCb6i0djj0VdSivGryQHQRcrbiX0NhKD+TfmHl5RZUNkSxzs
         QB/Fdwc+K3PsO5Q8WU1GV3Lxpar5/BOF7LEia95E8Ng7KUYPBpX/5VhuD2rJ4yC/PzHM
         dObJ34o4pN7tjhXplKxFR69r8bSJeoRAPZqPDPh2rUUlKPNlzu1lfb0J2wm2+MB3RPHL
         cT0g==
X-Forwarded-Encrypted: i=1; AHgh+RruWnSPDYslf39CvXAih54P1FhNZxE9gzGXA4C3ax6sMyAqYUcWTNsZeVZ+fPJiukPneGo=@vger.kernel.org
X-Gm-Message-State: AFuF++klhVIa98hOxWbWsXSdUXprt7k1FLcJyVKymSm8tWapJEtubTD7
	ND1VcJMlpnT2Z6kx/yKUeEw0hDif9wH30RM4DeUN0kvAcOzxe2a0nwZ8auzF4LIqgqWq+F1oVUf
	8hQK0YTHpnH8Tr3LnclpDnQOsdaAy3ag=
X-Gm-Gg: AR+sD11WZfPy7IUmbVgsPjze+dAzGaEYfzT4yJ05TCgbuiCiPdj3/hkI1xrvklAVbO6
	MJ5iNgCD3VVHxYguZYA4oWqL7xDhjavc9LJawsC0KqxNDwSzpvYFpNt233WXmXN7nTAwFZ3Vh6U
	NlJOr29JtmKw17Aag0/rmRfCPilEKVWp/FoMJLqGJ97rcoTcF2oXZm2uLDiCqbQ4cOLEkbARhCL
	xKwEkWtPvWfn1qvzXwA77YQL48eWBWAu+kRPEw8ZKl2smZ5gYehUs0ActHdJCt9kGsegYc2f38T
	sio6Rwxbs/mVvHuTVRCdZ5x4uz4qDNnapgFe+aTYhnyhhwmfQ3dV5gMFtgL/zw8EmQW0zhehJTg
	A8iLIi89Y8/7gEbk6ycttsi0QHDvrfm6RdA==
X-Received: by 2002:a05:6102:5cc5:b0:779:328:8a2e with SMTP id
 ada2fe7eead31-7841da85156mr1344200137.5.1787825115384; Thu, 27 Aug 2026
 03:05:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 10:05:14 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 10:05:14 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-3-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im> <20260825-pks-odb-source-fsck-v1-3-b756de0bf24f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 10:05:14 +0000
X-Gm-Features: AcwNN1U8QFk7_dQZtKK3XzD-T_fzpz5txhd4BP2q1tIk923-fb3hY3TOrW85s0Q
Message-ID: <CAOLa=ZQoJotCEXWxbOz9sHs0+Xen=7NwW-3OcrNXFL461VEz1Q@mail.gmail.com>
Subject: Re: [PATCH 03/10] builtin/fsck: de-globalize option handling
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ec7010065a047817"

--000000000000ec7010065a047817
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In subsequent commits we're about to rework some of the option handling
> in git-fsck(1) a bit. It is currently a bit of a mess though due to lots
> of global state that makes it hard to see which flags are used where
> exactly.
>
> Refactor the code by moving the fsck options into `cmd_fsck()`. This
> allows us to convert some of the options into function-local variables.
>

Nice. I was wondering how much work this would involve, but it seems
like these variables are only used in `cmd_fsck()` anyway, so they
didn't even have to be global. Good spotting.

[snip]

--000000000000ec7010065a047817
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8d0562c69d1f47bc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xUUM5Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjI4REFDR2t6OWJ1VnZwUlQ3NlBDNERGNDRaUk9SNwpwSmFYdUtoRHg1
NldEWU5hRGc5S0pzMWl3aTlxcVZYc2d1VHFrQktERlJicVZjOFJRbVlQVHM2UTNGRXpLbDQ3Cmx4
ZUxpc0Vqd04xcjhuT1QwdFl4NkM5MUE4cGNPdnlsY2JZZ0FpQUVVd3VSQ1B0NHNyMTE0MzhVSXNB
UUgzR1IKUUJBNkN6cDE2OWxzMjlDUkxPOGgvUFdmbU5seTVwUWxlRDJ6ZkdQcjRxZDhab2k3amJB
VTR6Q0hWVHZtOEhSNwpiaVZjeDMvM2Z5TzlKU0ZPMzF4dTJhT0NUaEtmSGw4S1F6ZmQ5dWhneVZY
MjNMcEJidDRtWDJTM2I0REQvam1MCkJLQSs3RHg2eDZ1Y1dMTTAycGZjTVYrQkhkb0ZNWVdxT1gr
OTZudjhwZjMzQTRIbEZsNDFsNldXRzNvZjNGMSsKZjlYTVJjdzJCR2R4Umt0V05ZSE1uekVxUjVs
cmNaZ2M3QTl1T25jMFgxcGJEdnhpa0JNaFlYR2xsMC82WUhnUwpuR3BhWDlYTFJOSXI5TUgxcEdz
YTlUOGxUVGVNMEZIOTY3aWN4NE0yYTFlYnlzUStCNm81T3BFOTJlRDlBR1RPCmZKLzRCeW9IWXE5
cS9lMDl4anF1N3BCS3Z4U21oakF6YmUyTmVWWT0KPWtra3QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ec7010065a047817--
