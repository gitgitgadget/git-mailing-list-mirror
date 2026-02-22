Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9084C92
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771791344; cv=pass; b=Vja84C+Yb8/OiAMoePR+VfSgrD7VJEA6XKdqH/xiMbO/yPdyHnDrS3sUnKPb5R89/fwHEsxaldQDaATGI6cSaPExXT2xlFY/xM7Z7qvDOBs/xbd4npU1jyaNgG8zHD01L1ixKwniQj/Mn4nC5ySxbqdZ+2ctIm7CQcYwK0dXaS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771791344; c=relaxed/simple;
	bh=bXfbaAApv/3ZggaljPEBkZCnZCQbJpS3/nZWoRnglsg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzY6W8gt0L878GbuXXQTUozEEPc2MYAGmryFE5BkErxbqngnIzEod7apZALYM6paCyHJ4a+yR0EDeRxzxmIhCd7iHLAaHhv6izbSIp0xshzG9WisQ8bl2+KfFqA1MJcQCBsx2L07c+QcF0R9DGFBIuOIYmWrJN2KxBMcpAofDIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVtFBDpo; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVtFBDpo"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56706fd623fso2571241e0c.3
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 12:15:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771791342; cv=none;
        d=google.com; s=arc-20240605;
        b=QtG6a8ME3I4zZZ2uAmIs49oVciXlCUf85x0cTjpWYzPuJaQZ8vugsNMvem7evqOWV+
         hoA8riyA09ZbhRxhLSU6jo6ljKPemAHnQRFHa8rnPh9VfVY7pcspff6yInA2//IVnWfG
         z3BwSv1e/96csFbslZwcKUWkwVCEwoY4UevKTc5htFhObuwbLc1jfZ+zOBX3/Y6DYMqo
         ctmRK+07ltbGuvokpm8A14wIXSpbfyRu5a8bSYDnFOelfWvfP5X1k6zbAB3vlUKvLqLB
         PpC8tY79P6rA64C3UoKbGqm1A/sRETH5nT4Xo0UV1nRLroYvocMt3Vt2JWB8LG9hS3bY
         ZxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=X2EM9TybrHu2l7IjDJe4Ojt5JW8LU8LRCLs+Y1j3yng=;
        fh=/TBaAqmZw2i4XTLXF7LaIZIjAn/j/SoAPJGgEUJpgpM=;
        b=MZkee78fU+jtw+qu4JCpesAJILnR5XsbUPgdWhEtHQt8lWnyhHU/SCZ6yYnZEGHpj6
         t58NNU7lfYfkusmbQxgGDkz3BbCsCkDxED69EMDOH4lwO4On1TrGPLr4E87hkiI0LLbP
         yUKC9EYWPYWnhANZTwM6GR8g0nOhh9Ih7QTNh57OGG1RYJtmPZm6YSl+z5gpcLRySegB
         NXoi/MzypWvj03ENERH/hs8eat8BPOAX9YZoVOIqT5uW0NhEO8mxu0sUo7UZEW9x2Biy
         ZWesdF67haYDL2wKjzGpSLtzW2zPZFENljDWUnAStubsQvVkQ1ByUYgff3rnSSznXQSr
         ylzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771791342; x=1772396142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2EM9TybrHu2l7IjDJe4Ojt5JW8LU8LRCLs+Y1j3yng=;
        b=WVtFBDpocPvIyqBwI4LkNEV5jNzoX5+eByYe/xtjLFWq0LT9GPSeMkjUnuNSrTl8hv
         4/URDhKsHgscpm8ezLRo0TCMcKhXhtgSnbyjjDzNj7Q4MVYQP479uiOSk97N+/BqdZA+
         bYcWG0MUo8CY2Z1n7OIkJAysYqdwOI18Zopb8N59kwTCGs104hYWHa/nTVt4xfJLG5th
         K6nu83wobeGjjviVUNX/rdPgkleff7i26m8+iy447icQf89UrhqOjleZceyP4W5Rleqe
         oP70hC5aZ5df2inR7iMwSk6A+PCu7OhQKBlzfYiv1gk76eDI0uGVPZytfvuJMWwExbyT
         D7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771791342; x=1772396142;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2EM9TybrHu2l7IjDJe4Ojt5JW8LU8LRCLs+Y1j3yng=;
        b=ge73ovJ2D/iC/QUMcYEkvVb1+kl0q+PDI2f8t5A5Lqyp+xYjWtuzBQusnmDTtGCQ7S
         n0t2lgzDZIK/OJZt5gVRtHmxpOpVAPSQ4R9jFHHAIH89tZhSjM1e1kP0waQKuQ4rjuPE
         imDLA5V/U56r5CZmX5+FA9Eb+OWPxdJwa75nHQ6gndyei1sFMDYXtDAw4z8LEKOKCnbX
         T0XfHUMtTLdWdOu2WzzNsatmKts6fyTDp9ScrVvNXzNuNRx7rXCddTei+myqvCDMkV+7
         lQmT7UtJGLxRDPgh6BCsUsub6s/M5wCewShy6KwiIOdrza1/T9MCm7XTxLMM9tj5HxjA
         LF+A==
X-Gm-Message-State: AOJu0YwH40TCoF53lAKgaTfDCt/lFhAWhAy+3ykn2hRblfcg+Qy5sW91
	bWzr/E9UoOAuSdfBnfyN9ZJuk4Uyp33N48E39EhG0Wr8NqkWm0Lokx2Buds/50sOe2HbvEB2484
	ElAR6xrXF2mTMk+CsEIFCxvuam+xCyzw=
X-Gm-Gg: AZuq6aKbY/UXNn/9bzQk7t0zIjWPAjX3OsxJvXlNmWiujAr6G4JIUID7jNjlrFsuepP
	3BL/8ep7jdOu0RVHHD/7RCcyQjwozL66yGqeyOZKj5I0tyQH2gGrKuxY3kKB/y5dhscMuF9P02Z
	pkv+7L60cvHXjeDuRpm1Ai82oM0Q4BuHgpmjTeBql52V4ZTDLyShrqLuzaVhgED1voQkuTYMQUI
	LIEVT3iDYB3WN/MkVyfGAJuqSmlxds5yRmIaZTo6XyFcXp91LMHT+TuoaaScS0Is1GO9xevgVUd
	ctqTmfGC6CqYwK1Ly4IYLV1z33IVPDKIm3uSJPK2
X-Received: by 2002:a05:6123:4208:20b0:568:f213:7330 with SMTP id
 71dfb90a1353d-568f2137459mr604488e0c.2.1771791342379; Sun, 22 Feb 2026
 12:15:42 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Feb 2026 12:15:41 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Feb 2026 12:15:41 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbjhjz793.fsf@gitster.g>
References: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
 <20260219-kn-alternate-ref-dir-v7-5-16f27860dbdf@gmail.com>
 <87342vfmud.fsf@iotcl.com> <xmqqbjhjz793.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 22 Feb 2026 12:15:41 -0800
X-Gm-Features: AaiRm52ByQmiogTGl78W04Gi18fAXBkl0-iffRZstvyN9EBkRcLaCWJvPx_dym4
Message-ID: <CAOLa=ZQsfOpP1cxFCjLWqbfxQ_upzuKHDojhNYtU=oFmeZsjVw@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] refs: allow reference location in refstorage config
To: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000944553064b6f51a1"

--000000000000944553064b6f51a1
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>>> +static void parse_reference_uri(const char *value, char **format,
>>> +				char **payload)
>>> +{
>>> +	const char *schema_end;
>>> +
>>> +	schema_end = strstr(value, "://");
>>> +	if (!schema_end) {
>>> +		*format = xstrdup(value);
>>> +		*payload = NULL;
>>> +	} else {
>>> +		*format = xstrndup(value, schema_end - value);
>>> +		*payload = xstrdup_or_null(schema_end + 3);
>>
>> Also here, why did you put the negated condition in the if clause?
>
> Hmph, would it make it easier to follow if you swap them?
>
> 	if (schema_end) {
> 		*format = xstrndup(value, schema_end - value);
> 		*payload = xstrdup_or_null(schema_end + 3);
> 	} else {
> 		*format = xstrdup(value);
> 		*payload = NULL;
> 	}
>
> Maybe it is just me, but I often find it easier to follow if the
> case that require shorter and/or simpler body, or the case that is
> narrower (e.g., error condition), comes first before the main logic.
> It is in line with preferring an early return on a more specific
> condition.  It frees readers from having to worry about these cases
> early and let them concentrate on what is expected to usually happen
> in the code.
>
> In this particular case, I do not know which one I would prefer,
> though.
>
> Thanks.

Kinda similar thought process. Since the URI format is new, the most
likely case here is that 'strstr' will not find a match. That's why the
negative case is first.

But I'd be happy to change, if others feel differently.

Karthik

--000000000000944553064b6f51a1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7e04d2199ef9c8e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tYlkrd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNTRYQy80M3NiN2xBaFdPbUlRTTB5TVZBdzJTbFFBSQpsUmNmb0hBUXFY
MmVwdHgrQ3psYWdBTC9YVGdFUXVmenFHaTI4dGxPZGNBZXBGcUo3TXRaaUVySno3a2xVMm11Cmgr
ZkxpL3MzNjFkS2tvR1gxcjZ3NmhwdVZ3MVZmQ3lMenRreVovNVVXY2hrMXBCV3N4emhxRGc4c25h
d09pVVoKd1pod1Q1SWV6cmVnTjhSdFZjdjRza3diaUdPcjJOWWhWLzdqWis0SGo3MFZwdWV4WERO
S2FjaTdtOGoxN2VCcApmU2hHR09SY0IxT3k3aUdsdkFLVFhLdUp4c1lKaEhuVDRaV05rcG1HbnU5
endFVHoxN2FKUlBZa2lNL0ZoN3kvCkRLT3hDV09BMnlQU3BlR3VOTHBWZmR4SmQ0UmZKZ0ViNXRR
bjh3a1JNUVprWEp5czVJRXJSVVAvQ1p5cjlQL0MKclFmV3dTMkJrNEJBd1BOY1BKWVBQblhwdVZi
OFNRN1JXR1ZVSHNpWXViaEVIVG1McDQ0dG1MYUtPWlkvKzZ0WAo4cHNCVnIyd1dmZmMxNjRDN0l6
Z1pKdGJDWjBXTllzQXhlUjlsWVp0R1d5bE1rclpNQUZ5N2JuSS81aVY4WEQxCnZtSGlJMnJjVTBO
RFpFT1dRbnFLSWxWY0RTNVgyL1hRdTJjUndaWT0KPUN4b00KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000944553064b6f51a1--
