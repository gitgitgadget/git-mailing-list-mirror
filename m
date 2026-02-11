Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8AB227EB9
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770805624; cv=pass; b=SZfnmawBD31U6J5JA/OLNi5/Qe/aeJ7rl9QUf5kzKxshOg6uysM3LHEP52YnFvZCXYBBKoNVTwEMusqXxXPK21IBTfjBE6xHk3zfjZitwQ4ZV6FsoRABHCJigIiilMrMsAaRHQp1XIHTxWs7AZ4+Ad6QmMqS1vcOlZQtKdjr9Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770805624; c=relaxed/simple;
	bh=lMQR1sVTKQ0IyTg1gXvhR4+9yOF5doyxnQOssMxYPQk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6rA2EPJYMYZZR9TI7cRYvKimseocGoStBBaPN+JsW1T+sSMZQReYA9SzWpG04AYzNFh/FY4iKO7BYOS8GyoTZ5HM7Zv4UGw+GDS6es3g5Q8T/HrazNJDMZ9Hy/epugHE4eynt81wb/pz10PndIs91fX6H8x0khIMI7Mtmzfi4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6GrZ5Mr; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6GrZ5Mr"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-948d0d5d4d0so1089312241.3
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 02:27:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770805622; cv=none;
        d=google.com; s=arc-20240605;
        b=fzpTqedhvfrgR3VcVk72aZiArNFvYROPtAskYY4tmTpy/vHa4qL1dw0p0ip1rXt2jC
         mma1AQ/rxs2P2kQnuVXakhtqpXQ6Dh48KLuXVSOeA8zrt1FSuPzv6jV2rEIQ1W1ZwyFR
         RTR3EesQE5asUG87xKHRfxMe334rJkRhHviW0xkf/ZEWTfI8UPzBCsdMicWRY8lNCoTg
         Bnlqzh0RuCzSb2KGOI5lpTEPKlp6mWC2kabcxwYyVnNpKlQ4PT3AY9TUFpEAGN/2epmZ
         uh0hJfvd3CH+sYn2zhj+4xvQQKixsLJc5QdKUXB45ATh2m/n6frtwK2JN86KbYB4El2u
         R5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/H8qeNoMjgp+duk7qmtEiZiepdEaom2snB7vZRt4lNU=;
        fh=MPMvdI4OKdwoNdUqlzx/FPwWfkTJ3ZzCcYeiizfGmP8=;
        b=hRPnCI+BjApMnG79/94fzuwG9SUMP5GPnOJLFpJe19LWD6ezFteIwp0ACe00zKchQv
         iK/yCucS5oqMeagpP6wpm2pKlU1D1XPAyFOCYpthY1inkckuVADsRwYNSSLG8HkTRrNb
         PI73xM1IrGlJF0jSQCXc+acGO5/op4atkfP3ToS78sKapeBDqnbUcP+AQspv1GWAfN6P
         cuXff86Ni8rWkC1j9BiBG4YVomb4eUqnmKadwAnAQWhtpUGF7ug5RgRh1Fnb8JPdksjF
         /NbjUMiaRs3M83iGzjkv431H4kXFus2IwsJdatqqoYbtm9MCASpY+HhXMTfencGeirNq
         W81g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770805622; x=1771410422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/H8qeNoMjgp+duk7qmtEiZiepdEaom2snB7vZRt4lNU=;
        b=J6GrZ5MryLAqA/nJmUAC0BUwLKcBnJw1KcND9EAJJvDC27Vs6zkkM11+uBAa8D4kIt
         LbhVt3gphic30MwhlhPX5uMqMy3HbNv06Z9Vj5yh19XIttgLMpPgnh5ws91vgJFvxw5U
         fEQwoDPogDKUSu/Ya3OB26VuWtuRHt3EBpgw5t35+OpsqQ8Y6+0looi/g6GoQswloihm
         rVmVSd7ug2sxtj/IQ0rXVsk3GJLXBcY2UgRtk3yWEcQrpn7U9y78EFWGkUk+AK8K7fnr
         d6m1Khiz48XWdgvEHGfx2p4RquLNsCyZJjPamuUFqCtTCo66pA03MiRPVPcQ3fjMdUMk
         3nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770805622; x=1771410422;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/H8qeNoMjgp+duk7qmtEiZiepdEaom2snB7vZRt4lNU=;
        b=qdYXcqJh8z9lZMtExOodoqqQLGU645elnynyB1AEfDffKecYRBp+cJGOs7r1QL8mPl
         C4Ootp1ysIGaKC3VRUjYeAgjMtQTy/Tczf2iI4b/TppgZdW7DFvtxqN4F51H6z0fGEUh
         NWdKv2lBGkPa6RUckteqWJDFBBWNvrSYvYZ7m78i9Vyzcx5D5cKKIF8I7MJJSVJiSyiy
         mC6fOaUDzszMVFQwnVXxjHoGpDidP7UrPrP1Q5LPOzypLeXvX4AUPSkV37CJndzcfNaT
         XABnD4j0izCNcD2sIvrVUXoh9P+WdGO7f5KQmydwfiviBVjCmkohGxi4xkA5PLUMvE9E
         4vRw==
X-Gm-Message-State: AOJu0Yyl7C4wW+kd+wu87TTTHfkwlxfSpwpVtLahHBUZaLc7KFuTrhU4
	kA0GWBHpKh/7yquWGrMNezADV75mF0C87jBXkRFye81C9PIMiVzzapdSL3ty3hwXouxFep4KO2G
	6llnw1MRKN64O86JImPloiCWQi5suJAI=
X-Gm-Gg: AZuq6aIgZsfBRzSUDw8TVwzV4A36cY0f2O5kHj/o4pXOE5ULjLhJBu4zfPhxaIhoMRE
	AK2GG8Mu9aGASn0Wlw6z4x64eWuRpLWRZN2AVbCdILBPZ4Es6a+4AV3a93JNHxxoFC0dI4U3y62
	6A9leDyyZDktoYAAFcFp/2floDKDamQ+R4NK0nfqxHwQoWtLd1bBNjYMAUyqSkG+6vSh2Rq1svQ
	qxK9CUOcugHhT1V+dFNNyObcHU1KLgNElsXkNYs4r95OphUqeZ8GWjxm7nxrm9udK3KyP1NJuvf
	kU3zwKg=
X-Received: by 2002:a05:6102:358f:b0:5db:cc69:7399 with SMTP id
 ada2fe7eead31-5fae8a26639mr5431615137.5.1770805621740; Wed, 11 Feb 2026
 02:27:01 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Feb 2026 02:27:00 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Feb 2026 02:27:00 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260210224401.GA1836788@coredump.intra.peff.net>
References: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
 <20260209-kn-alternate-ref-dir-v5-3-740899834ceb@gmail.com> <20260210224401.GA1836788@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Feb 2026 02:27:00 -0800
X-Gm-Features: AZwV_QgsMRb3Uwa1OQmcROaC2rrv7MyWMQ1JK3KYSNSV-bSvtp2Kh7JGvfuz9YE
Message-ID: <CAOLa=ZS00qJuRvDA0Ud34MiUAPuSMTe7M76fSWXmHmbPtc2wsw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] refs: allow reference location in refstorage config
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000000cfc10064a89d08b"

--0000000000000cfc10064a89d08b
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Mon, Feb 09, 2026 at 04:58:20PM +0100, Karthik Nayak wrote:
>
>> +static void parse_reference_uri(const char *value, char **format,
>> +				char **payload)
>> +{
>> +	char *schema_end;
>> +
>> +	schema_end = strstr(value, "://");
>> +	if (!schema_end) {
>> +		*format = xstrdup(value);
>> +		*payload = NULL;
>> +	} else {
>> +		*format = xstrndup(value, schema_end - value);
>> +		*payload = xstrdup_or_null(schema_end + 3);
>> +	}
>> +}
>
> The schema_end variable should be "const" here. Otherwise new versions
> of gcc/glibc will complain that the strstr() implicitly removes the
> const from value (and compilation with DEVELOPER=1 fails). More details
> in this thread:
>
>   https://lore.kernel.org/git/e6f7e2eddbc9aef1c21f661420a4b8cb9cd8e2c1.1770095829.git.collin.funk1@gmail.com/
>
> -Peff

Thanks for the hint, my Linux distribution is still on glibc 2.42 and
didn't see the error. Will fix it in my next version.

--0000000000000cfc10064a89d08b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b9a5962f7e6ad8c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tTVdYTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0M4Qy85dThlWHozeDNLYktqSEFlcnpHemw1TFovYQppMlZCVy9hdkZn
czcrMTdrYzE2NkhUQVk2VEd5UFlyVlFwUi9yd2hSU2E5TFZSRGZDaXlPKzUxYnBvZHJ2NFU4ClQ4
cFdEeTFCQmg0ZDZ2MGg1cXZHMjNWem10VDZ2VDJVYUhaQjdQWW0xclBOOXQxUkxwRG5qQVVBaUE0
d3BUZksKa3drY0o4aXdMekg0aHo3UUpHcHNsbldGTDNSYUdwZ3IxMUU0ZXgrM0tYcW1FbUw3aDBi
VXozdEMxN3AxNDdkRwpXa2pTc1hUWjVwMmRxZXorQSt5aS9Ia3VpOWt4a0FwdUxLUzF0Nm44bXlu
RjFaNmdtY3NJZitLbFpFL3FMREZkClJrNC9aZm1oeXNrNkZvRHVwZHVUYzB1MXd6RW5aKzJlMUNa
NHl0NnJzUzhrSkoyelU0QWtnNmhMMEU1K2JJM0wKa3BLanFLTzlFaUZrTFFhc1RqRHE2NHR1bmNs
QTBCMmhFRmpzbVB1YVVVNWllODNMd3R1L1YzeUNNL21iVnJnOApSSmo3TUF6ZnpqdTVZV2xaZG9u
bW13WWZwUWdhV0VRZE1rbHZFbk93aW9QR1l0RVRrOStLMUxYT0hFV3Q5bGs2CmtES1F3M1puaFJw
Vy9jY01XOVNoVGk2Y2JtMHNzMi9IM1FZM2w0OD0KPVp5NTEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000cfc10064a89d08b--
