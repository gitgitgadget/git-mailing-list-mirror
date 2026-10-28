Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793218693;
	b=alilh4Vdq7/qcL+/txTISUSMt7dDw1Uy56QMZeBX/2FovWHLV8Bkqx4WZTBds8IpfX71
	 o2ltYIk81EQtOjBhUPrymeeHclEz5jTaNKaU5aeU1Ph2qcZ8r4OKZi9dQtqQ/xEcgp70b
	 KZgg37sqVJhk3CG+MTWK/R2r1GyRRaPbOd9BHRG/mVB4ERfwDozZogereoci2rhKIDt3O
	 NAfO6Gl29FOfzsGq9XO9E8ELE7tR8jukpVdaHOP9JST1FOyj3dVBd32Xim8wHzzjyeH0x
	 s3GZVvNqDmp/2v+O3jh9CgDJD0nGn93harMjpvRsXY1bQJWlHNhwjWyx1Gy4x7THFCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=M13RsYdQALj6Nk0VN+Od1YvVg4O9euXAzay4bTqexU4=;
	b=fYTgCCueM0sWUx43iIzTzPwX/o6riv5/x+E6P0Ny8sfRuQHdGbw4/CUGD6iDFpaQW8Zp
	 F63IcY8gzutVoZLj0fjVIwN6fgDINAlK7gPVF+Xb31dErr7M9LBEFoEcQ+Vr3rvnI86mq
	 xypqbuWU++eaF6zdzbtVymLQy8NPAovy9fq4p7PXgL+hNWp0wosrQlCiEixLGCmUFHZcN
	 oUfAQeHsbvJ518y2Mq0Z3Sph1qF4ly934SZwrim7BFS8Hq3nLmtqZOXe+ude9xX8TYaxF
	 h627b9gH80ac7C0jwNYP+ZLHy7YDo5PeabBBqw/6YYsOXG9GxpqcgWsvshcujYUWThA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rnM06bEM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765A7606A320
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 20:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 765A7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rnM06bEM
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9906034086cso471190241.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 13:18:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793218692; cv=none;
        d=google.com; s=arc-20260327;
        b=RTGdpZvCxIGFz5g0GBjW+SgIp+oPFk9iNW24DxtMrz2ndiDGsHrROV+15w9HyYHJpI
         Iw5vAXhu3BJjciWb3GVwCu+c2DcoYg6+XAOQ/pUg9JEY/FCxmNitUwH1LdvDMPjYgFd/
         UlFZiwIRWWjGK+gMAyAfRJ5cNw+YPSKcXfiy9GfPVt1pxz9FFrAXEPj0NzypxyqtA1F6
         9sV/EAeyUgYNfSSHPFpecdYWhAeVDQRqvOeqFlxgZ4zAORbsX+DYyH2JbpwvCstrg0L2
         xARiPt3kuSpF7qCII9dG9dw0sbLzzT2tpyyVJRFUjgO81+ooutub4e2KfkmfOaxBqlED
         YK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=M13RsYdQALj6Nk0VN+Od1YvVg4O9euXAzay4bTqexU4=;
        fh=GGWEzrIIQ6cHJJb0qSNwyEDctpXMUll4R1Dn3XJ2gys=;
        b=ZrRxChDI9SI0uwg6aO4/NvLIZUSLM1pwPjcaHoPawfnYFkIga8zkDj5v06dlZ9jgZ/
         5Ps0WNSOwqbvSjuPLJpX3x6vtJN9VV/pix/4ms9o9bZzEY1dJlVVmhbEqmRtHfeUwmPY
         GLhGjC+MVbrqj3Hf/o/rqVIP16l17tPBPH2B7/FNxx4EShkwsIW3X5th6CpMUsb/CSAy
         yKjfMlet6u8wKFTnZKWDJbgChJUGrdEmw+p5r8zk9qAark5/nk1LBdCEr6z7p0d3M667
         Znpon1Rzc46dHEuTxtWrAXF5ixEyEwOJ1IAWtvoLMCaje6J3t2DGRXmwLpLdC7B7Dfe9
         SU7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793218692; x=1793823492; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M13RsYdQALj6Nk0VN+Od1YvVg4O9euXAzay4bTqexU4=;
        b=rnM06bEM9w8CytYsFnJ/fOiHQd7P5AVsDRznws63u/FarmSDTld9Tr2nRdoiqXaN66
         ydHk3hKbYBaSEgxVbjRLL9uj0S8tlNUXZS6kK+QJnHKE1kHopwk+uCq5vvFrhdB+DhgJ
         9OKfBugkcQVIlx308RNtm41WY+KJUbSKSm1PjE5fBncwRFUXfV7imur1RCylQ+x2SBPb
         tiG9lhkMhZPj08i9TaiV75zhEBkSqygZCJZueMgdmqk+KduqQwXYdtU+YS9jVCvmYKH8
         uC4H3mhvTzPLpBcbxXYLHap60JJY2aKWlg9/JnCmcGGK9Tq8w5vmUZRXG1p4MnmGYZ10
         zDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793218692; x=1793823492;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M13RsYdQALj6Nk0VN+Od1YvVg4O9euXAzay4bTqexU4=;
        b=UUn265thl4wWlr7CJP/4LC821Ay9ce5ypfmSHcZstisxZ7abAdPiAcXMdQ6q98afH4
         37Oy0DcHPtNJlKuHpT/2C01rIttWZQJbuZ1uPaAyH2CtF+nQU4EHpjRku0Vl75QchFFV
         r6otzYsQUnLeli9u9QAps0qnOtw3IrNCzsrBbd3115JYUBMerzl3HWOydXXCnqwhK9NK
         lh/wHQ+rTWfeGOz0kafp8wlTBxfhUfjC7emZiJkltq9sT5TwC+FK8riPx80Qbx97VrVc
         SWms+tSxQYqfu1BzjSPeK5h9S2pOSsE2lWGXslW7hc248jDlmQlOWvyyC8e9hAnH0MXA
         bS2w==
X-Gm-Message-State: AFq9FYIWpgRrlSuPzbWTgHi4QDQDLlnurFd8irXqttDAWwLMlG/il8vV
	yYyEDOK2xQMTOVFYVnog5RQevL8GR29wlXFvqCekjFj3zlD6DwaYTgPp8uN/M6OmSE6zXFHi13l
	IXORJbQawUbcvSb+OaXpdzfDG978YEoA=
X-Gm-Gg: AYBFou1UVKBCmy4nDC6mO6gIA170GY/P9TwwkDbHR/eiZ/zmbjYy0lG6Ta+R/U/Bbww
	ZK/xSGDrUFNq8sBScZzaLIg9b/e90i/Uzq8jxb663SnyzhH8ZuRvjdjbTxzqL2ooJHTgLC6UJib
	VNpWpJPm7bvbr35VyDIkSB+4IXaOwdpgRXat7QYLPdOLIJ9OZy+FBIuiSZwLpmqR/5z/1Mr5Sjl
	eclW3Ze8pKLLPpfKSBUi/VQyRRmUuEOhyxd4DSUxMIDjYmupGW/VwNzsK8W6a9CuWAuHRAB0PiU
	OMVqtlNPfzFGOUm+lkCLN2DN9L42YkDQIUvu8na7t0PU0ycdP5PxaWU8YYZeKSinil/IuJd/n4I
	CEDgnL0Mwotn18tw/zNebAo4Y/l3iWhRUMMDYK78sEERnbxD/oMprWo6kzYcfAO/aSeW4IqrfLO
	Woy7xPgkZVm2EOhIsTp/XKygEY6ZzL5YOkLBdbfKL1l/n0vUEI
X-Received: by 2002:a05:6102:2d03:b0:7a7:5355:7fb6 with SMTP id
 ada2fe7eead31-7d03a59e747mr1614871137.24.1793218692338; Wed, 28 Oct 2026
 13:18:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 16:18:11 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 16:18:11 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <auHfmzP3aXyonp3C@pks.im>
References: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
 <20261028-799-shallow-fetch-with-tags-v5-1-7c43cc9ae810@gmail.com> <auHfmzP3aXyonp3C@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 28 Oct 2026 16:18:11 -0400
X-Gm-Features: AclHuK8iRjb0VwWQH8uPYTygSvtXLYvoTnrEntT-u9PrC4Rj2a1ZhFCOoPsIA5E
Message-ID: <CAOLa=ZTCwvUJNj6c1G8dU778ejwO5WvVL9F5C-Db=P4Au5=mQA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] transport: add `transport_options_release()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>, 
	=?UTF-8?Q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000297d3c065eec43f0"

--000000000000297d3c065eec43f0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Oct 28, 2026 at 10:47:59AM +0100, Karthik Nayak wrote:
>> The `git_transport_options` structure is used both in 'transport.c' and
>> 'transport-helper.c'. But while the former specifically clears any
>> associated data in the structure during the cleanup of the transport,
>> the latter misses this.
>>
>> This means when using remote-helpers, data allocated for the structure
>> leaks. Introduce a new `transport_options_release()`, which acts as a
>
> Nit: "a new transport_options_release" reads a bit weird. I'd either add
> "function", or drop "a new".
>

Fair enough, I'll drop the 'a new'.

>> common path to release memory allocated with the structure and use it in
>> both files.
>
> Why didn't our CI detect this leak? Don't we have tests exercising this?
>
> The patch itself looks obviously good to me, thanks.
>
> Patrick

We don't have any tests which exercise this it seems. The tests in the
next patch do, which is why it hit the bug!

--000000000000297d3c065eec43f0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f7ea7f541220c5fe_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yaVdJRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHVZQy85ckhwODkxT3FhK3NDeDVQTEhhdlZiMm90SQpadkIzZ1BWS29r
Qy8za3Nkdnh6eTRIb1RrWGt2UVRucXNlSXpZc051U2VtTE5CQUxtVyt0UVM3SGZveFlySFdRCmt1
OWhmY3lONllpWkl3VDFzTEsrZ2lHRGcxSVBEZUZxU2pRTFdZVUZxUncwVWNwdWljN2RYNllzQk5F
YTNXSWoKOWQxS084VWsxSmphK1RKNnBTdmpjNlZFNjZTcGhZUG5ENFRnb0VMakdFbi8rOTZCaEZy
aUNEa1JyZXo5UFJBRQpjSHdoMCszYUI0Uk5ZRzRzemd0SUhMRm1YN1cyR2duTmJsVDcwVlhBTWZa
Tkp3VzVWYkZvUmlrcWtKU2dGZXRYCm00WDBKbDRwZGJGeFdNWC90UFFhUHNVSVlFT3hNYngxZURu
YnhFUTdjMk9qU2drdTJIQ2IzNnNnZWxqSzU5WlkKQ0FjWXA0OXFMZlRKa3F6MDVoZ050cGMzUDM2
ODJrNVlSUkU1ZkpyNFJSRjdrMXEwcVozNG9pT1VDeDM5cmhJZgpQOXAyaStFUUVNNHp4SnZ1VHBX
eklEWFlKVjdYYWQzaUMvZlEwRDdIbWs3TTNVVXJQdGdMRklueElLNFBBTCtkCnZiNExMS2dCREgz
NXRkWWx0Uy9OTU4vWWs0ditLOUlSeFJybG9FTT0KPXZNbW4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000297d3c065eec43f0--
