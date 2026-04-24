Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB14338A736
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023360; cv=pass; b=mHiIGFqWrm1s7gfM7YYVfydr46SpTfRUaoDyIajc8fJ9C+xabvTpX129rNYngELAWsqRyF8T2IpPzT25OPqKNPftDrYmB2nlRsE03fR0LZ+T2IHp3SEFCJHgfgc5YNjNDxd0+GC/O2pBAbBnR+Kf7BoTRsEaIr88eqIdQ82AaxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023360; c=relaxed/simple;
	bh=XHkHwXhlTiUShatb7ch+/FKSv6znMLEvf0oaRc9tTHs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqHUQsPw5aRGb4wUH/3IFScYX1ipycMIL7U0I2m24MZK0rTmg01LNvrZaj9RI1hTakDOHxFx9S8Tgf8XkL8i9VzLlUDwfzbyhHGIsA/NpF97dFHXfruA8xhkY+ZvITg4BA5UsqRSpv0SOJ4s9e7FYZhUm6kVQxaCV7QgAg/cVZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBYsP7Ve; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBYsP7Ve"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso4418347241.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 02:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777023358; cv=none;
        d=google.com; s=arc-20240605;
        b=FLwMwyl7Dk/QetmIetKtTQgUVfRQBTHjj7YXkdfTMAfySYz3rirfRwfRq4tZJxZy2Q
         5/v6F4XqmYPRHtUYzmjiRMRNB7I6DnamyEYVeZ4EJ9+XubW8QhEAZ58ugI6Gby2Xbo7J
         9cYF1HunRkvC160VScivyDJGGYFbdL9ffO1z00S5oENoXSYve5CVx6GDEf/vaDTOnlpz
         wAuzIrEH5BCSHzxuML/A1wEj1ssGjR1V8nJFYn9y5ejMB6jZbis5N8gtHiEwYw+IEAWA
         kqtfZ8v6GoA3uD5pds3pR50LIUSB57/kLDZdZBW2elXmRggsDnPLq3d7JJDES6P8eDfE
         TXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=XHkHwXhlTiUShatb7ch+/FKSv6znMLEvf0oaRc9tTHs=;
        fh=FhCDfeFbmycHGzY7HbKUSS8ZI4XWOfgXn11u3NYB6YQ=;
        b=f+44LC4/FmS5NRTN1z4G8LYBl0AsVaU23YJxy61B2uBSd5vjAnYtNzrkzNE3UEjGUu
         oQ2Hhzlm3y8z8P0haG35v3Z6chL5F+whb+KvOcLgbU56Owc5xTfAyE6i1GejaTaIHE/C
         KTvCoebKhZ8jgUr5OD99AxfjczMsy+0sextJgaq9RPaPgQyMtJG2YteMo+mm2enR/JIm
         BlXGiwoYEqyT1JVnfTU7YcosiREyTrCuv1OF0pQHzlNI4Ru2irbtR90eR0F5ncPirzop
         U4n8eRxcAKyZURUSQSDR1W4TlkGh6d1+hQk27bRsBEmyWyyshGuoZfiFUqr9s/AuhsG1
         7INA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777023358; x=1777628158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XHkHwXhlTiUShatb7ch+/FKSv6znMLEvf0oaRc9tTHs=;
        b=tBYsP7VeWhGQIEhyF/boaksmzoitqumXZhPOnVYRVrtd6qBzwN0RMCa1M4F0I4ryDV
         x5VdDB0n2khyqljlMM7o1+rEd8VPBc0IIjzuW/AlCBpWRrNQZTg9pCC4rbxEc9DADGS0
         puaCTri0oWjqvXJOqkj3uCY3SRUrAOp2iF31RT07YMwMd3MoAmi6u8it3V0nZHz4/CvZ
         MEIp8Y5tDvnjfpK35foKmEbeFpYtQh/NtMXYxI1lYOF4qZa8FX+nJAITKHdS8R3RqzIH
         n/+a2Nsg/p1sGjXejkKQ1h3x/QI7zertbkMuoh2CMuOLDfZns66qNGMESs2QRqglMfFB
         STxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777023358; x=1777628158;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHkHwXhlTiUShatb7ch+/FKSv6znMLEvf0oaRc9tTHs=;
        b=obcEd1t8Kv4WtF4X1uts8Cct6szR2aBQnyzqBMU/fDChQrOeyWdoaPRj127NUlkiRE
         eVRV6iENsXyn9/WeIC+rawK8IiNWweKSZkDX27kPUhI4lFASw744axEt6Bedvw2DT/mD
         JQM52D4qanNkSO6SjB1PUw+k9J9DoIukmFq6DClqEvYV8qXn/60CxJZuxco/JdC2ODul
         eVCm7oMEUFNKUi6JDk4xSxu4UUe87vJR020IsPSNM4rrakZyD+73mae9RDosffbhvdFJ
         O3L5gQ4lIAWCgFSN9/nR851JlLoSQ3HreOAgPPHm/kVUc9xWRmvEB4FIjDCxFF2xtmPa
         LQxg==
X-Gm-Message-State: AOJu0Yylt98XPLJ4WlyMM+oZUmJt9ghaiQuLvoIE7LVKsw0N+ucgw5q2
	JKBSv1mzEFQz34WfMh8q8zKNDfpbsM8B4+K7XnMji2ODxoZVOQ5TtwsCOsKZ+0bv88OdaeFQVeJ
	aJ/TahCHR2AVi9Cellx8g0lBDllPL+eg=
X-Gm-Gg: AeBDievBeyplTnQjJF7vmNm4Q0o8thloGB2FKdA/tcabaKsH/Il3Q6JIdPkFO7t7Eee
	XJcfcaFCcosLvwzP9atZVeQjBRliXiiFSiwLl7cmZAes30VRuGFxBe1Eq91V4wzR5r35y8ANI42
	W0BJ9a9ZeRrxB7GvfDwBcT/zXdf1Mw/NU4ZTIYxtj/1lhMG1EFlIomCf3WS3sdUTmcoMxy8QgHt
	IelZB/hh0wE8kOEBSCGtAI6uOKKXo0cyquledtmwPeTeh1fKuxQ5D7JZhc8stAVg4TOd1nvVqUA
	eJT4ixCGh5T4PJiRpcenART1ewzUMr+9VbHhL/bTZJIOYouD6kOL
X-Received: by 2002:a05:6102:292a:b0:608:a960:c85a with SMTP id
 ada2fe7eead31-616f4f84c86mr16303619137.9.1777023357925; Fri, 24 Apr 2026
 02:35:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Apr 2026 02:35:57 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Apr 2026 02:35:57 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aendymWafXrTblbQ@pks.im>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
 <20260423-refs-move-to-generic-layer-v2-6-ae5a4f146d7d@gmail.com> <aendymWafXrTblbQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Apr 2026 02:35:57 -0700
X-Gm-Features: AQROBzCOpZQWAbLzQ7uZaVPj2ruUBtquYQFnFEl6HxDn0rfHG9SfjwjJeq6rpX8
Message-ID: <CAOLa=ZSY6KhGJz0-fjzW6WWbMNFi02UaFPPU6Df6uSDQ8+2rsQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] update-ref: handle rejections while adding updates
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000001e25b0650317e64"

--00000000000001e25b0650317e64
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Apr 23, 2026 at 10:40:35AM +0200, Karthik Nayak wrote:
>> When using git-update-ref(1) with the '--batch-updates' flag, updates
>> rejected by the reference backend are displayed to the user while other
>> updates are applied. This only applies during the commit phase of the
>> transaction.
>>
>> In the following commits, we'll also extend `ref_transaction_update()`
>> to reject updates before a transaction is prepared/committed. In
>> preparation, modify the code in update-ref to also handle non-generic
>> rejections from `ref_transaction_update()`. This involves propagating
>> information to each of the commands on whether updates are allowed to be
>> rejected, and also checking for rejections and only dying for generic
>> failures.
>
> I noticed that you didn't address my feedback on the changed ordering of
> errors I posted on the preceding version. Was this intentional?
>
> Patrick

Huh. I do remember adding it in. I'll check my reflog and fix this.
Thanks for checking again.

--00000000000001e25b0650317e64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 979a20ad8f4cf67c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uck9Yc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNDhtQy8wWXY1QzVFMkptQU8ycXd0MDJYYzExcDFFRwpVYytnbEt1SnVF
ZGUzUGV3c1JSZDlwK3IvQ1AzYjBzeGlFUjM2SHhIdjEwWXdtOGgzU09BeEtseG5mWnovQW81ClVF
aDdDTjFnQUdaNmV5RHNpdnhXUzJXZ0ZPb0w3aXd3NEptczA0UTduck5vc2orcFVLTlppWm1iVU1K
eU5uSFYKWFdRekJBY1NxTDBJS2FsSGNXSjNXbExHcmE3eFV3UStkZVZxUTlMWi9LbEtORjdkMVJ3
QjYvZUc2SG9wRm42WQpqSlhWZm1DYlJOZjVtVzZndDJEaWtwK3pXaUo4Q0FveEhCeStLY0tKRFV3
d05sTWMyeVAxYzdObHk1bGtXL3htClBFcUxGSGozWE5takw4T3JMMGlXL01Sd0pxaUNjU3pqc2hl
SHN3bkZNcXdpVWhIc2pnWUlweGI1KzhGMEF1NXkKc1VoM0kzYXdaVE5hUzFHQ2dnUDFzNnlOTE9Y
dXpxVjI3VnhTMC9jS29XcUJZbVJNc2VJVjQ4SDlwL0FFcExYTQpKdFVBYTdhQ1EzZ2NLSE9UeTR6
L2lSaWlDaXZWMTJvOVo1MFE4dDFJbU1CdG9TeDZtemVlT0ZKdWRUZHZxUW9pCjQ2aEYxYmJQQnV6
V2ZTbG5SQ29tU1RXR3Vjb1FFYlBBcUVpNlBhdz0KPU5qWlQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000001e25b0650317e64--
