Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF3221F03
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488431; cv=none; b=PzsSfbhJI6QFNiqjcaNaWJuFOqUnRvcpAA5414RD50u2iluEdU5QoPgERW5gZRmkROnvyyhzL8VtcFgr6IS9A+suJvJ3DdQGHbsAmRJ0Z5qJ88FlwiRLOxL1/gO3txouBzdo4C3g4s9xC6PXPCuqUKIENacmn9WIPM6d7DXks90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488431; c=relaxed/simple;
	bh=pQL4w5FkuTs2B+f54zAQOUtHJt7/DeHAIvKWXtuEmCg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=krQDCvQKHspbIZn8fHLSmuD35SieVCR0ICuPFi4NDCrL7J71EAyU5cpp86gHakDyjqz3jWZmQqFNB6DU2iEr/tbAMfu36W1JvIPbeVttci5udfs1aT/rBMjOVTp+cctacDrNSwwh+1+zUetpPKcnQWXwDu96FOSrxTt2CoGkkpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOpv6Gy3; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOpv6Gy3"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-87f36c458afso2776217241.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751488429; x=1752093229; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bg92gWFLlEriKrkqiJ9lbyQFvX1IuNQqtPmu5A/+nm4=;
        b=TOpv6Gy37V12duZppNTU4Wh91vxgbn0v9cQ6mqpVFubvHoa+6N7B9xEb2GI9ZInvCC
         8FtTQjkRDo40yhBCR7rQSISJ3ACPoXz3mL78fz4nskugVwD8krgiCm3L7hk/LeVHzPRd
         89l68mDY1cJSbLlUHDBe7dw54X9MskYl81sYa5iwR97Jyp1lKlpWWG8A4JCSXDYamKT1
         S7JoLx9i06JICWo+FKCOlI1kkckI9Rg4qJBu8Z5HNh6kZ5c4kjXFup4fohTdt/MX2s9D
         x83vJl7P6zQOGi0TCXEKVTFXNFoHH6eXtt3zfkba25ccpY/iP5e1BLG4Byd83PjjCpnk
         yr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751488429; x=1752093229;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bg92gWFLlEriKrkqiJ9lbyQFvX1IuNQqtPmu5A/+nm4=;
        b=WC44wAGJU74ks9OAY8lX8p0BE89eDfWV7tPpEBj6frKx2236qdDWOYB8KwhG/lhQJz
         EkvzNKUiwzHTCzhoBSW0rDiIC9gwoC+RULpQaVIROahe6jcCRFnPahItNZF371BFe1cd
         LE5VvQHroyl8B+TmNM46mv/m8lqY1YDWyslLpUnH5yKA5o78Z+Sr9eiRZE47+gkHYm4W
         w9x/BTOoyj/fkTtXXSpxtjvrse+CCl+QF5xs4eY2TaacGPE0CoFZVXerx2YejNgwYHXE
         dvogaiyqBj8NxhycbLigh1IHayxwOCMdxorrrsZP4dqDJa3whXWPjhLY8Adaz/zZfIhc
         ouOA==
X-Forwarded-Encrypted: i=1; AJvYcCXHRnRY4tgaXlqIKtRJKYvy5dGTUYAM69mRJd/FOH81pJgXqyBH/wOk2ujciELYnIm1Drs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgFPIf68Tu6wi4g3jFDeDbuBsrBpe+m4IRfZB4lb6yG/RKJGTx
	jhi1qULYHFxO2QutlM8O3qYtfT0HHFJ7zN0AyEj569117XS5jJU8i0fpeLA+ia8UWvWdTAapPJK
	tWVJKxx8QNQnbQTsiP/zc9pIaXudW2p5iBv/j
X-Gm-Gg: ASbGncvbAeIANaFCJGmyVitDL9m4OEzuCnjB9doD3o395r9EkaxFerW5I2/lRHkLs5R
	OTN2h0Ve2OP048CDv7d+mwkaSrixdA0yXfHWzCuptS+fmDkavR/wbzrsLQAP3mEPRBjNAjgfj+C
	gU8aaQPCmVQCYqrUuAZB6D2X88hCIzV75umDZW/CtKBUvo8toel8nG8WiJMp5Rr+Iyo9fmitYp2
	CwHww==
X-Google-Smtp-Source: AGHT+IGcYwICqeqOW2L9ET7wZCcqBk90za9cwFLWZND94DESUrUMaAOqb3BH+eFm2cMlKUSutJMBTRzytXrYEUBvkK8=
X-Received: by 2002:a05:6102:5a88:b0:4e9:a2bd:b455 with SMTP id
 ada2fe7eead31-4f1612cfee3mr2919429137.14.1751488428632; Wed, 02 Jul 2025
 13:33:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Jul 2025 15:33:47 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <5e9b3ef1-931b-4b70-8275-5aed5da3d6f3@gmail.com>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <5e9b3ef1-931b-4b70-8275-5aed5da3d6f3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 2 Jul 2025 15:33:47 -0500
X-Gm-Features: Ac12FXzvaqXG68euNBi4zCmffdg8rpd_jY6Mh6qdc0qAHHOnNgArWxzROf9LjZs
Message-ID: <CAOLa=ZTwvOiCnYK18GTEUkcW0-YLHkJ=MBggdzOYsbTT+OHPwQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] for-each-ref: introduce seeking functionality via '--skip-until'
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009e108a0638f82dde"

--0000000000009e108a0638f82dde
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

Hello Phillip,

> Hi Karthik
>
> On 01/07/2025 16:03, Karthik Nayak wrote:
>>
>> This enables efficient pagination workflows like:
>>      git for-each-ref --count=100
>>      git for-each-ref --count=100 --skip-until=refs/heads/branch-100
>>      git for-each-ref --count=100 --skip-until=refs/heads/branch-200
>
> Doesn't that require you to know the name of the ref after the last one
> returned by the previous batch? If the use case here is pagination then
> being able to provide a numeric offset might be a better fit. For example
>

It does require that you know the last ref from the previous batch.

The reason for picking a reference offset is mostly for performance
optimization. Our reference backends are built with prefix matching in
mind, in short they do a binary search through the reference namespace
to find the required prefix. By using a reference offset we can utilize
this binary search mechanism to arrive at offset.

Using a count offset would require iteration to reach the desired
offset (basically a O(N) operation). This wouldn't really matter in
repositories with ~10^3 refs, but in larger repositories with around
~10^6 refs this starts to make a large difference.

> 	git for-each-ref --count=100 --start=200
>
> would show refs 200 to 300
>
> Thanks
>
> Phillip

--0000000000009e108a0638f82dde
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cbe2f86063bdc452_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1obGw2b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODVXQy80NEhZRi9ZU0Z3QUJTVTh3azRRTCthTEZGRAptbnRjMlV6N2RM
bkdqWUkzUmVCaEI5NkJMcXpQRzlDN0tBZmdOYjF0Q1N3c3Y1UEpscGRsNVJZc2VzR0xuTFMwCmtE
Y1ZBZC9iWEk1NmpSdmE0aHFwQ1lZVEFBb09GelZCMDJLWC9JVzFkdHFpd3ZYVTVZKzVUeVdGVzNF
VUg2TGkKNjBVcDNINDkxN3M2aWJqZ3FSRnVrV1EyVlBsSWwwUXg0QXBGMnU0Y1RaTGY2eG9aV2ZF
bnZUOFFuWTR6MDZucwpGREc2bytwRmFnSDdmdHczT1Fud28rOE5ENkRNSjNscG01c3EySUVWZFEr
eWhaYmY5QkJQd1lWSStOL1hqTWpiCmpWNVRYeWx6ZTZ5Sm0vYVRNTDRnaEp3Y2twUWlQZzVCYkN1
TUhFb3BNbEJIRGFaY1pMZWZ5Q0dQRkZnS2xVWWcKZjlUQUE2YnY4Ym1mK3I4aGhxOW9GTGZGSkpG
azY3bkRLckNPakFQWDV0MGMrM0ovdzJ2N2RiRGRHVWg3K2lISgpsQzBodnVVLzlhbXlnVnYyTkQz
L2RGVVhpZnNZWG5rNHp0RGFQWVFCZkJpckFlTlhhQTJVbzQ4emlyZlBIUXZjClNyVlJtVVlrM0h3
YnoxcjFhbE1rZ1J4UkpBbXR6c2pUWGVCcmhwOD0KPWtBYU4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009e108a0638f82dde--
