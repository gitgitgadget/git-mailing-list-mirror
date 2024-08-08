Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A772218E02E
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120007; cv=none; b=iBhL4kzC+KGSicXEPU5FG+1I2Si0y+XDoKT6bIw26t2D8xNl3PJlYU6G5Lbsxd8A/1gRHC2J+OnYTLFK4kWtAOgZNY4qbgmwZ3W/Bjv3GE6CA8qnfYY5nbNS83DOT5fiZWDYbee4sGQnuIHpxO8Pia7E3Xg7iYNi38PZwj6TCOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120007; c=relaxed/simple;
	bh=kQHqJoLlt7Cj0v3m8zJly7Mh34/0YYaw0kx33WTjbpM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltQSPgPJFWEcza77gcC9QGbUmzHBiwc4xR44eRYMEROdlHQY8ghYlDZuZZLNQqgW/WwLqUJtc7vejApaII/eO+RcqF34ogYADL8X4xPT70mv7PFIs+DLDhxkd73M7roL4FS5/OYjAA3ZfhDl+MKCusCM7SnldC9/1tlFDge044M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1bqnmvl; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1bqnmvl"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5eec95a74so490390eaf.1
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723120004; x=1723724804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MxPxPm72b/c66Cy0rLiCQgTap7/ZTS0k7JiaWUCclzo=;
        b=K1bqnmvlemfVVs96ilQwEZWAKuOY9y6T96s4Z+Oyc9pxrurFFI87CKrVVXVD4W/dVr
         TCPRnpCzzc532Wnxpard27zZC+CmF1VsWr0DOXU+8VxqYLP3+3/eTOwwycB9M4+FLbpB
         +aSx21DRvqD+RecwDzw/5m5UCqBcGv1NRSaR54axYqjUXoF/OLCYqxmsT2drdw5DsGrH
         jXAK0wXSBlRmwrTQ8hMq2jzj1LM+h0PhYpvO+9Br394srGMrTzuM/UkxpIVJiVdEHWLU
         OGhGVQCw+yuIlxB7+CFKjtelRErHjqGElpkclkqtTFfTYkGWhkxmMICgk+wY56kjIOn+
         qYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723120004; x=1723724804;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxPxPm72b/c66Cy0rLiCQgTap7/ZTS0k7JiaWUCclzo=;
        b=nb5rI+8RU8C4GjkeB34QEv6MpfUgimLInG9Q8EIjEYEerkAWbjJ27qHeNvqzg7bnGn
         guDTmAP08fJSCA9fEEF32g2tzV/tfWXzeoTE4k8GePFjBmuHqhPxcrQZgac2UuNIwdTm
         CV5i/ymPqE1aNKfDKKoY1fApNgGlUS0saySWtkNPtQsAKSrceWX+dOyet1N7BpclTGXM
         IFZ3PebImrl1hmOEPCEEf8VfVaCmz/MCLv61pqukBif7GxLr1WOoOokN20SKr0+6ruph
         jbRYliMMLBWk3PDEwDX3WcmpKkuOz+MkmPxuMjVzNYeuSNpI1WJTI++Un8C9z2zOqwyM
         ecvg==
X-Forwarded-Encrypted: i=1; AJvYcCWtkhQvXHAJD74AwIVOcNmmKlXktd8OWWDTfcIbAEGMy9u6wavAkIjTQoPpZFTeIIY1glxnCT6m5RGUhrmtwW1Dra9M
X-Gm-Message-State: AOJu0YxfoQxT0Ykq0tD79idqJaFCTRE2RlPAvqam650BPuNW2JrZ/1tH
	IIfGJXvAhjsfP8sfjGmihfcpKZdwjO6VmkNO3q31f7BLOconoWEgkrTMhcmOd776PUSRVQs/zHZ
	mjuQ2+N0G+I/c2vC+kPMfiYV1Mdosfw==
X-Google-Smtp-Source: AGHT+IHtFXZxTzRHbAMoRPs/ZWMEK2v/k3VoT7UjcE+TutXWUFGtyj1M9xRF3xTJLRJuPTxkS0hF0Bct2qMo017YLAQ=
X-Received: by 2002:a4a:edcb:0:b0:5c6:7519:9b58 with SMTP id
 006d021491bc7-5d855b5da66mr2284170eaf.4.1723120004696; Thu, 08 Aug 2024
 05:26:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Aug 2024 07:26:44 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1722862822.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im> <cover.1722862822.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 8 Aug 2024 07:26:43 -0500
Message-ID: <CAOLa=ZR8D7LufbLnGiZC34UXdYtZgD1YPc6Mt4tvG4=t6OsLjQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] reftable: improvements and fixes for compaction
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000c924b6061f2b2322"

--000000000000c924b6061f2b2322
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my patch series that aims to improve the
> way reftable stack perform compaction.
>
> Changes compared to v1:
>
>   - Extract a test helper function that sets up a stack with N tables
>     containing refs.
>
>   - Reuse file descriptor that we have already stored in a local
>     variable instead of calling `lock_file_fd()` a second time.
>
>   - Remove a no-op change in the last patch.
>
>   - Add a comment explaining why we have to allocate N+1 many table
>     names.
>
>   - Some typo fixes.
>
> Thanks!

I haven't reviewed v1, but did skim through it. I left some comments,
(maybe they were already asked/answered) overall the series looks great
to me.

[snip]

--000000000000c924b6061f2b2322
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8fd9dd1231ac27ac_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hMHVZSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMW1NQy85VjNFMkNkV1dLYXYwaklvdjRJUkNsazhKVQpOclM4OVlIaUJn
SmVULzlKVW5BeXdUMjVwZlljc2E2S1hQRG1MNUdEdGw5V01mUGloblZMcWEvQlZpK1UxaGpwClpX
RzJCVUZvOXY1NDhjYndjNENOSnBmdk5hR3dNaHJvbGdLZmdlK2FnbTBpakVkMU4vM2drYnFVOXdL
d3IyZEYKK0loSDRKelR6aG1pWEduVk1ia1R1elRsM08yK3hpdFAzcUtqOUFXL0lhd1p6cjNSK09X
NWQ5aWtXMzIydXI3aApnYnY3dGVMUTgxOWNzMnp4TVdVOHlNM2NLdGorM3VlNldKR05Ha3lQUGlY
aUFReWs5TWxLVllVNWVYSFpjT0gyCkFVeE1HV0E5cWltcW5IM1Y4RUpZREF3Q0dRRC9FajU1M1hK
MndsNzNCZ1NDSlV2KzdhRnpjUXRsTy8zcmZoRTEKZk8zazRoRjFVVktKMXN4OHF3QTJ0Mm9ucGNz
a2pyUnhocG9XUVdOK3Y4MHQyYkZJdm9taGJuUjJ3RU9kbzJTUwo1VUpzMTExK2ZFOUNSeUlidHdR
d0o2Q1FwTGw5ZCtpTDg4RzA5ZStpcU1kQWM3MmhyQXQ2cEs2VUxUNWZ0SDFLClFxRFp0a2Z0aGV6
NDB3UE1wMDJVMlpyZi9JeWlWKzU5dGdHQXZWND0KPTFXOG4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c924b6061f2b2322--
