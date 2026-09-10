Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F23603C2
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032575; cv=pass; b=AL1lTvtR/y1huOa4qb9NdW0bEWIS/9BtAyk2pNSC0DyiE1sbcFFkv1UQ0Zqr5V6ULy/0aBhdV8tuTbv/RG6ZgP7a9yxK9181x7+gfmRomqkFzT5lK8q8exw/xI+1uiE7ctIgV+va0W3y3RDELeWx95VkRj+VTqjbalk/yAwuCkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032575; c=relaxed/simple;
	bh=lQPUZD+w+U54iNIKKtTLr6ZfZXkD/7Ccpi364ZXrvLg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oudiRF6LjFuVyLb6VmfHrJgwkomzAXqwBaA+yiVwUUc30WzcO0nvdW8AjChwE5h0BqSZRkRuv2m5zknrgSk2MmrxoAxC755r5f5OxoGp4OZWMmuAn3ExofmqejArF+Wynb3CdDdw8Cegom8nmLYugr6hqtYnwlP9+xqXbTeM2+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZtbrnHO; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZtbrnHO"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-783047c8464so4647421137.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 02:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789032573; cv=none;
        d=google.com; s=arc-20260327;
        b=C2CzyCDtJ9n91vgHrSBTqKf/1V05MnewMqveXjnadzotVl7I0PCBFycdd7CYk+Yi1k
         ST0aab5zkWdaBv8GcxbnGDPKSv24knqKYfyw7i8nznKA+J2ZV7V3dv5t345OZ8zv7thC
         RVszX/q8AWRolQVGe9Shj7WFgOK7Fbcg1HtmGeyip15BU8ew/YZoWwb8zZh5ZkDUxBOA
         dH4NDpgTB5/o8Oiz9VG/dkj3uE+nYwtkiBo/dNjsh/kpOJ9TKdeJj9+IXcefIl1/1D4T
         lb/YCO16cndXVa+TRCVvAI/F8uHIbEP0il5DTwPhFdaq+SjNMCbJNLGf1B8bUyHMb9iF
         Zq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=lQPUZD+w+U54iNIKKtTLr6ZfZXkD/7Ccpi364ZXrvLg=;
        fh=e4broUHp+zGNwdul/XwC1ZNxIHQ9sFigsfzhHhrp628=;
        b=KxaKl+dldA+WFF4bkttJe6yJkvxUSDSsLJs+qvMpbLMy7xAvZOjDLuILC6+T7XXDbq
         B+UEG0urEYpf4xuugNzBMUNnYlRoCsJAEjgxOBhG1Yo5kwTYNkmSUEOXFpyebWkhX7Iz
         5PSSeAc7dQzjLfIInLEb7v7nlAv6M5RNWk7KmUP3dEWGK0rLy8msMp/iOmTzgcS9F8a9
         0YFLP1mVFncYTq3fw62Ld01DH8VmSoHSOAGDC7cH8h3a+VonSSl6AC1zkFfn9x1JIbjD
         W7WXZVvunChvyBYBuwEFk0Y8ZShEaJ9wrkEhMSgpxYqhLoZbDbt5UUx7TWBkyacSKpUX
         zerg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789032573; x=1789637373; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lQPUZD+w+U54iNIKKtTLr6ZfZXkD/7Ccpi364ZXrvLg=;
        b=TZtbrnHOSSTeLZdP5A5WmxYxt7g0QFgDptCzOePKy9AkbvwEK7sY77bbAB9uI3wsU/
         zVy850jW1PjNl0JiP789gKq2Ic67MxicwIxRSwsS+2tNRbTVhDsJDsHq4AkrQ0SG/FJJ
         2PlzgLJPsiIc2TLa1LQ1BFudO7ZwD481XGPHRXFxEp2kMrX+C2hxOVCwPU9Gkot++Qmd
         aJHYWArz1cF/APRl3koCgUHwjKBoY/G0CuHdLtPjoklJrxv3VGD9CnU1DNec+pgY0VqS
         bgyGV6sent8Q/PzX2Y7Rm9Z7uIB3jFsRPuvlI01iO6yGLmqctfAokFDPMG736TrEoiJE
         0Wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789032573; x=1789637373;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQPUZD+w+U54iNIKKtTLr6ZfZXkD/7Ccpi364ZXrvLg=;
        b=kLKLDOlSidtd955Chahfjkn2JAVYSnztgVXgEhesYmXFQBdfiXHcG1b4cQMB4KBHON
         SVDlrS4eknCE6e2MjvA90SEJv8QXrN1dgjy5iraRjZXNJJgCfx10S3u5b7q5AlJtk4QZ
         AxmmA/RQTWLaRVS7zELi2pwXpVVkigOz+2hb2nUsMOZCeSJI5PygzY/Jj+OTcqkr9CXK
         DiV14j1OiNQ6w65JVVeNen7TCd1XMp/xzWjNNDZJXCKYvgrGLW8ZncFMV1pa6hXAQBfu
         LvNdJ8/MjyYugjdi7wn8pKGhNE65cbHeVvn0cmGEIOLM0ZHix1HOm9xdVKMiPVmXr7at
         R+kw==
X-Forwarded-Encrypted: i=1; AKwUvBzcptZladSTVvup9K9/xMAg2sXBlFKLyje+dJVBrkZ6GLxNyCJGGMyF2xXgW0xVt7qncds=@vger.kernel.org
X-Gm-Message-State: AFuF++lc2lXbxFc7ByfzIbBUmf2/UIgRXKnkNYK0Y0RqHng6DT4Y8wxz
	4sNuPUVIIZtjYj0PUMnQUvyyqe9NDk3MNNldc1KtEJQ8K5VA0AoIzEgQnBK9jEhldB/Z6iiUy08
	vwms7qhH6UbnZV6XzfwGqeHvkE4YBhso=
X-Gm-Gg: AYBFou2kyMp8jXjOrjcOqqq/fVSh2ZBRqdaFAocrARneUMhPy9BnQjn3wgLFStgblVI
	9GGlR5O8MahNOGv4k8YuAraior18npj0HxZ74P+M7SoDFrieGct8GVgm3JLh7VIXdXGZ+Sc1E89
	fwsrnFUliY6yWgD07gttntDETrKOUmUxuUgrMpno1ZH09oClM/F+udr/+5wBHJjacm/qRRlXlqs
	ZLB+HWxT+FIFsm6bBHyJa2236lZ6MTiONIOe2fXt7PYufrOAF367KgnYXVtnpgiHmV4iDyjmalv
	hH55jK99+iEnsH2QD0csRLY0VUREF2N2RsLNYP5J3yOqgeRnpZ42PfabyvWBBc5zbBBQbyYHyDS
	8pAEznpyK9XlRh+D0EUdt0wphpQ45DL6BRnkhSmn4IMP2
X-Received: by 2002:a05:6102:3a06:b0:77c:6bdc:824f with SMTP id
 ada2fe7eead31-78a4a90fc19mr19281719137.1.1789032572809; Thu, 10 Sep 2026
 02:29:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 04:29:30 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 04:29:30 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-3-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
 <20260909-pks-odb-write-alternates-at-creation-time-v4-3-d8a78ffc32e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 04:29:30 -0500
X-Gm-Features: AcwNN1W5ncuzfKUW-WZ_qv6HO1p5ALpaW48vJx6xR9I-70XLJF6YfW4zPQBWEEQ
Message-ID: <CAOLa=ZSrDLpuAghLzXt2Fyzimi2n4qkEtVCcRLDZcqx5QNkTZg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] builtin/clone: move around `setup_reference()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000fea8a3065b1d9ac7"

--000000000000fea8a3065b1d9ac7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In a subsequent commit, `setup_reference()` will start to call
> `copy_alternates()`. Prepare for this by moving the function further
> down so that we can avoid adding a declaration.
>

Will we rename setup_reference() now that we agreed it is a bit
ambiguous, let's see..

[snip]

--000000000000fea8a3065b1d9ac7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 77792397e0b9833f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xaWVIa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1melJGREFDRzQ1M2toSlNwYVdNNDhwREhNWW1laHZHaQp1UFBQam5hc2FK
d1d2RHhGR3h2Zys0ejN1OTFIVlNXT3cybW1ZNDZCR25PbDd1ZEF6Y1dBV3Q3YXl2aTBDdGZrCkpC
a3libmZYWjZsZzhNZXpPSFkwWWdRS1oxcW5CVTJaQlhML3ZQd0JGUE1FODJRZnZ6enNjdGtmMVgy
Qy95VTQKckJHbVNGeitwN0pBelZKQmthS2taLzdXMHZ1VHNmdzlYQ245aXNLTE1ETlRwd1hKdFF2
dmRndHlmWjhyaktOVwpNQTVzcVpTTlZOYjBUWmpLVHZLZ05xMXBoM25Qbzg1b2NyazdURTFrT2x5
U2VONU03SjV3STYzUEh6L2NhYUhTCkVKNkNaSXc0d2x4RUI2SmdYSDBlR1ZkM2pJU05MaHExK1Vx
NTllWU02UlpVMlp0alZGYVl4MkVSblE1M0tBZ3oKSG5UUXgzd0diT21jRkFGcjAyK3RRd3A4YjBJ
aHZWbWlzaUVvRFhnc21oK1J2SnQ2c09zR0JreGtJRHB2eWV4LwpJQnFyL1pMNnI5M29JNm00WFRn
WGRJUUdMOGF2OGNCSUFyd1J2L3F3VVFOT0xJd1I5bk1pckU0N2VsR3lWQkJ2Ck9RVHJmVXFYOUVz
d0hHWER1UnZOR3BRdFd6MEdOaXNuOUZPOTRwRT0KPWFsaUEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fea8a3065b1d9ac7--
