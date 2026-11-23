Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795463191;
	b=pUzGLiT7OL+UVC5kfrMW6Xp0qVzUNwiI9nkY018djNy6gdOPAh7aPzYJFaZMXB7ra+08
	 kEP2GzJDLAkxluPRwxF4Vjpb9MBa54d9sCEu6SxusrCIGp2dmCbhpxnH5qJTNCizx69DD
	 dt53cM6dgE78RMbZ8GO0uc+zFC30bzZRlLbCk5nnm7kO9DcROn4TqZgKjXw6DzOWl0qYQ
	 FWclY/7k178C+XbvmDQlhi82CYV1TPUJHIkYkKr2BCSQrfcEMkz5t2ali/IWxCKI3seUi
	 DhrOKSBkws/1ubqPJfdWn0uDQ5S5HeNrWroyfCqn9U8hGIqzTfIrWnQcODubNwsjPkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=koOOOa3LnosPQm21KMMVwUkqy5KjVIJAWJ1wQIxe6zg=;
	b=D3l4CjS91PyiBXrILXf954o89zQk1Pr3G0IRVOTYUbB3YyhPvIPpMxCgkc4eeNvbxTNz
	 4DKPFvnnZaBZRqNBaZ3YCeFbHAIZnJm7W7g8cbAdAknghEQ2lDsR7omiqVMj8Ey/mH2H1
	 fJcw+dsOaC9npS8AwlN2voSqHc5QqBd2DIuENKK8gcsB38X2MBGZH0nChUGKmP6PhI3fG
	 0X3CVH8nLR/LPv+HnGUmkcK2LpRfwc0owUCnaKXxKNso9MGhYudNw3LJ1OXfrPd1zM7u5
	 hXW89TNF5soSP4Z6U1EsfIVAUVCz9DE4ja69JbFl5nI2+f+MoxLLslkXiTFKLhkdE2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=adm6AAmN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268C606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 19:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1268C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=adm6AAmN
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7d2ccd3c7a2so1166986137.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 11:46:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795463190; cv=none;
        d=google.com; s=arc-20260327;
        b=fo2ZlF0MgSgTvKAHlKyOM17I8jjrLYP7ix0Q8gHOTSAPLkr/J7RfD/2SVs3AoDv2wd
         cJ3zZgsvXmNPmdr5LIOgCAS11tWSm/7q6vlSRTuolOYwdkkBRs6lKmNdvpTe0jaaFnPl
         7UdFYVgyXqJvFeVugH0y/8Afslb+PDeclARPqO2sA7ob0MOFrXDa8lyYEO1O4ezTxRH3
         668FZQmFh+8bhoDJ4SFQ71x7wRUHAE4cyEZCevofCRz2ApDBmc5+LRkC+dT9khVlu1sD
         RgNV0DtvNG/jFJPC4on8JshfT9YN6fCUvHSMT1cveAhqBhkovlAUOQts+LI2ING63Ekv
         gQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=koOOOa3LnosPQm21KMMVwUkqy5KjVIJAWJ1wQIxe6zg=;
        fh=GB9wyb4sVWEWK2tqDDlmGzdWqVQJ54cgSOQu4DNtFb4=;
        b=X/aOnjtJKMbDhlZ9EgBQ84vixxzolYHTLeOtiWYtW/g4ORfsnlShog17lSgCa7Tybx
         pv6LdSMqNSS138sM1uJoPOEzpGrw28/nxYDlVKxSTKEjqPZXQm1Yn5dxCsRnFtT9i6sc
         1mtEu9M9aedtBa6vWQjeFDTAlO6oJqyV+sZjqn/9LnIwjHUh++hWex6uyZA1F284yGFJ
         4bfvJgWwwj4szxxTN3k/DQPGIFNOU95CJ9v4DPAsrYFsYkSQNmYwahVHfIQyEL0nhQ4n
         bJhAPDLAMjcr5XwjddEfPeb1zhgHAw6fy9gFLsuNVs5AHmD+ybI6QIzB3h01xRxSYQpo
         FC8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795463190; x=1796067990; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koOOOa3LnosPQm21KMMVwUkqy5KjVIJAWJ1wQIxe6zg=;
        b=adm6AAmNEhbObfA7dLkqHThsyZLofOZGsqTdfzqQsiw3I8J4Ddzh0TF+2Ev5+RaRZL
         29cKBgc8xIv4/MXBvqdqaLN3AVzf7ER6hBGtsEbPW4mCwcyDza8TSenTnXwWB+AtugER
         WrGjuSVHkd9D2mFFrWNo/2oLWEff28jz0fwe02D0Yl/l8lvmcHMtu1639Wjw+KNPI5j+
         y25Kj2xP+kOPharpnGsHsWX3hI6csRG2Y+LjrGUjGgodNBiPMfs+Op08puQvIf3ok15s
         54lziIXAMVMk+E8GccbaGdyIYmvikS9Y1uuDOaGTU5CsuvHjfMRDPTYCmQEmWBCUrvM/
         wxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463190; x=1796067990;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=koOOOa3LnosPQm21KMMVwUkqy5KjVIJAWJ1wQIxe6zg=;
        b=K9DJPVZtsOSBVP1YXigEe42bqnizXlxq049FFog3piR2UI/7wxo0NWaMs6zlMpnA2t
         LZA4pBnPO5AxELG2XeVFYPZqkJlpBWoLgwznVYjE3Fuwx5fkGk5t2jd35zHcDJNVN5uM
         Wo08FrPeNSzAiz3mzHCFpXmocZrmYzr0TBudgLTgx0eH7/MyH/3FFzy4i+J4JVp22vSY
         /gtpfU+4v++BzBK/dI1qaeYulJkfVSvQMPa52WcnbC1mnoy8G+HiiN55LZ1kPurdJ1TE
         3Lrgito2682+z1r6nohLC48++f4DVKlnmf1T8lt88MFVp72IhlXALwXy8QkY84wTZF9C
         ywJQ==
X-Forwarded-Encrypted: i=1; AL+hErH7X4ednxajHlJJRcmxCM2KZonL9nVveY/w7DqABnKXTqPLlCRvaa/pAJkSrv12VuZa9yg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pY+HWs1A4I3/wOuas4UkhAndms5vivTEnRXpScHYf/K8WCRl3
	hq84p7rDF+m3Z+Gq0r4126+cl+6ydk50Ph+1w7LRVKySOwUy5SkfRdJSGWKe/zitTxu6WS4qjHy
	DIdlF8R0r07qX+29NobS6kvwG+/HthPs=
X-Gm-Gg: AZFdTZfogoqUDsmJ/RQbiN1Bowhehy2vePZuXGvNkr21g1D5rE/pRvkqALX/r+fE+Su
	FdRqrxnkGLO/HZ2OOTv4AYQuB1y+RHirikTRmeGYyN3atYqrWgpXPPwfZz0tTunNf2FMwom5U8j
	MW+Zllsjejql1XuP/+qGUQavurus5yJ9wwdAp2wAyvypAtHSBZwvCAnSQYMPgQfLWKNLBSvLY2L
	cM0fY6tlp4r6mKqCNralCiVpTbTYGfXkTjcqFS464UG/eJ+SqmXlnqQzqKNG8l5ax9zknHoLo8M
	4Ti/Y8xncIr6KlgxIcNcVx/myhUDSrB6dZ8PISWEdHFArAB4TccCJd7fuZmS8irmKboqw0LgJl8
	winy2A77mHVGrM0ybvDICim97MgXu4XYBuX8oyXqHE/ZX5HQ6IAsFLVinwr4mXZrKNOtIAxk+UU
	BuOd4dFMYWy9RGe7mjM6MaIqFpMt0=
X-Received: by 2002:a05:6102:5707:b0:7bf:74c1:b606 with SMTP id
 ada2fe7eead31-7d7396386c5mr6197688137.34.1795463189699; Mon, 23 Nov 2026
 11:46:29 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Nov 2026 11:46:28 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <953176e8-e475-4a99-b2d3-725fd346c19e@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
 <20261112-kn-fast-import-tests-1-v2-1-b8c3a0ab27e8@gmail.com> <953176e8-e475-4a99-b2d3-725fd346c19e@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 23 Nov 2026 11:46:28 -0800
X-Gm-Features: Aa3M54qRywloubYhanlNuzy-mdaJ7kYUndHrjkneZXLPuyUGrZczx4zY-nKT3l8
Message-ID: <CAOLa=ZQL98oLmKz1MxWPjHafevb=rQtRkZrwBPckHMdsQk+yeQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] t9300: move 'fastimport.unpackLimit' to the
 required test
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000a1430e0660f6d9d9"

--000000000000a1430e0660f6d9d9
Content-Type: text/plain; charset="UTF-8"

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> On 11/12/26 23:04, Karthik Nayak wrote:
>> The 'empty stream succeeds' test sets 'fastimport.unpackLimit' to '0',
>> so that the following imports write packs for the 'verify pack' tests
>> to check. The test itself doesn't need it. A following commit makes it
>> run in its own repository, where the setting would no longer reach the
>> tests after it.
>>
>> Move the configuration to 'A: create pack from stdin', the first test
>> which needs it. The configuration must persist for the 'verify pack'
>> tests of the following series, so set it with 'git config' and not with
>> 'test_config'.
>>
>
> This makes me wonder if there is another patch later in this series to
> turn the 'git config fastimport.unpackLimit' into one that uses
> test_config instead to make the tests more self contained. Or may be it
> is planned in the follow-up the cover letter mentions.
>
> I'll see about it. In any case, I think it may be worth a noting in the
> commit message your thoughts about a change that turns the 'git config'
> into a test_config one.
>

The commit already states why it doesn't use 'test_config', Since we
don't tackle that in this series. I would leave it and not make too many
promises ;)

[snip]

--000000000000a1430e0660f6d9d9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5851df503411f9a8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1zRW1BOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNUpMQy8wVC9pcHR3K0tPSmRRRVFHb1BpNGRkMEtMbAp1WU0zL0FYdDVZ
aktpdTZvUWUwcXVVVE4yOEhnZG9ESzMxK3gvUHdDZzMyalpSbWhmS1Y0clArM2gzMXRCamhOCitP
VXU5OFFra1FsWkM5ckhiaWcxd0xoNmhlUk5UWDhLVktPRENEdDVpc2JKb2F5OUhTNUNuZUFZaCtX
SEt0alYKSnpnazQ2Y1dKZ1pjZWdWNk1pRjVLc01sTXhraWRydk8ySzdvZ2h4TzErYWo2bjJka2JW
RURpRkVkc044YW14egpYYmVIRzBCS1Z3cUlJb2NuczZETWVmWVhpQlFPbzVBRlZLWnU3YzllSmJ4
RlZZNitSVVp1Nkg1RGMxeGxXVzdHCjlwWjN2d2NlNGV0UWFRSlB5YWNib2VYaC9Cd1g3aFZLZnhC
Q3loRy82YUNHT00xK1k5dTVJbGpxQjhleGF1TjgKa3o2OHZUOWdEQVNTMEx4bUZDclJJSkx2WDlD
RnJSSlQ0VHRFMmJORTFOQitHZEQxNmFYamdaVjhvUWkrczFFNgozTG9VSUhkM3lEU3NGUi8yT1VO
aTU5UURoV1Q4Wkh2dURsdGU5alcrbnJ2ZUNMMG5lRG9HTWFScm1xSm5XWXQrCmdlaGxHU0l6UUVS
K1BFREVpellucC9mekVrbndROW5ibFY2aGVBYz0KPWtKUzIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a1430e0660f6d9d9--
