Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F30085934
	for <git@vger.kernel.org>; Fri, 24 May 2024 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716582896; cv=none; b=RBlCk0RlqKmoq1HEs+rXSXLtCDADqZ7F0hkCc34/QP1Vxpt1UES14jY65iU6cFpoTanYbtqlk+6PuA/9N7G9nFd4oCZUE7u7lPh+s39N08xi4slY6Qj0df2wLez/VXZwqD5amtVIaCXK19Wwe9+lzUu1kl9IMpMn2Gq2NP90u78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716582896; c=relaxed/simple;
	bh=XT7Iht1Ha/LkJSLyf890XhUDUsB4wGfqTeRXODd68O4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=ZwowzntpjfZ5520hAews5hk+Zs94bKoorN2xZsiBWMjI6+Sj3XqkClv/dEY7Pkdu7wNsdQAx7c84uWl3TgzIuIxUCVEOlBYy/t1eeBM3MF6lnG8LENHfw+oPspxlkANWVQRas1nqYPtJcSuvY78vQX7yTm1KBOFH2AR4hRZKfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT4obVn7; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT4obVn7"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24ca03ad307so740482fac.3
        for <git@vger.kernel.org>; Fri, 24 May 2024 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716582894; x=1717187694; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQ8Y3w6W4gGHVfO1EYmGrHp+9y4zjDbrPtoX6D7Hef4=;
        b=RT4obVn7wgVFqIXyq3KWRybSpmvE6crTjNAdsqyJFs3ZPLQEnzPbSQ9A9ZySceWnWM
         /sgS2B6xZOeaTsqDCWdE1PYxkoYGfcpCn28ZMYt4leGkw0R4q98ie0MWbgpCJO/Beg3f
         oI7aTvKrJrZ0ezwkVTMfyQLqPgJUT7iCbknQzq25yF8j6ERzCf8NA1A25+1zQ9TEd54i
         Ln4RTO4UlamQ1Td7zoxE8WmqEQzdCxIIBYKim73fS39rvGu9PEJYAhUmWRauk27TRC91
         31hESoKTdqXW2kRa4hrNYNZZfJ5dcrOexCIlsQF7P0dL9lFl47QfSgitv69XxeMHhci9
         E9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716582894; x=1717187694;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQ8Y3w6W4gGHVfO1EYmGrHp+9y4zjDbrPtoX6D7Hef4=;
        b=qDzU+ZwHRDkEDuJ04KvGaqzpKu88eOCIEPGjSJOD/GKfX+yfusjRrxTeg+4pt6Ridv
         qgbUkheUdpNHGUkDRVphM6SwTi1vscYxmgicxfSIwsOOT2SG8Ef5VmTEvhEq6Frymy30
         e0W3efFOlNwdKBwd7nBgBlpkHtO3wZStaCAgwzLF/SYk1+dmJB4WJmKzLelHfHVma9mh
         7GoUpqKMqejYAeEzmFuImK7Vj/4Y74GzLJr7zxwASEjtVngzwl5bewT65NFfwMHHDwrK
         7bDlLMhyD58MWZsgxli4Ccne7MHSk+W/qcReVtCrVth/SuutF+WiK/TPMOfxT9g8UjoL
         vPlg==
X-Forwarded-Encrypted: i=1; AJvYcCV14+h7H2+ilaS4pm82pDJITqnEhDc1RcSt7OtkoHe9YL69w71xJUIStb+v3O6w+zfn3m1gKmOz2oehADLKxDCN0lec
X-Gm-Message-State: AOJu0Yze9cZMXbsLhkurRAwHreo/HpHZk5N9NCaM3mVLLKyRCXe6g348
	zVoDjz72xVqEztzlEDKfSimx4eNJh2ICQ9Ky9XdU+dC6tc2dHBrmLmeKZrB6K1MWeGLiu44tzfd
	AWOsTV5uEzCMUqS85nMaA1fbHJ9sEDMlYUbZ2VA==
X-Google-Smtp-Source: AGHT+IFY/TusslZu+QF89is81ZS3wRxTBLc7DRkKUHXBqmNb4EwwXE/5UAsei/4gOrEPK5uzQ2vsKk40djqMRc/Fvw4=
X-Received: by 2002:a05:6870:63a5:b0:24c:b92e:a130 with SMTP id
 586e51a60fabf-24cb92eae0emr2118366fac.15.1716582893969; Fri, 24 May 2024
 13:34:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 May 2024 13:34:53 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <0e9fa9ca7386f527903887242008b5b0443ada69.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im> <0e9fa9ca7386f527903887242008b5b0443ada69.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 May 2024 13:34:53 -0700
Message-ID: <CAOLa=ZT5_E86EdCfejF9QR+P3wgsirxxyL2fvQTOf6k_+NUD9A@mail.gmail.com>
Subject: Re: [PATCH 01/20] t: mark a bunch of tests as leak-free
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009f7cd806193919c3"

--0000000000009f7cd806193919c3
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> There are a bunch of tests which do not have any leaks:
>
>   - t0411: Introduced via 5c5a4a1c05 (t0411: add tests for cloning from
>     partial repo, 2024-01-28), passes since its inception.
>
>   - t0610: Introduced via 57db2a094d (refs: introduce reftable backend,
>     2024-02-07), passes since its inception.
>
>   - t2405: Passes since 6741e917de (repository: avoid leaking
>     `fsmonitor` data, 2024-04-12).
>
>   - t4153: Passes since 71c7916053 (apply: plug a leak in apply_data,
>     2024-04-23).
>
>   - t7006: Passes since at least Git v2.40. I did not care to go back
>     any further than that.
>
>   - t7423: Introduced via b20c10fd9b (t7423: add tests for symlinked
>     submodule directories, 2024-01-28), passes since e8d0608944
>     (submodule: require the submodule path to contain directories only,
>     2024-03-26). The fix is not ovbiously related, but probably works

s/ovbiously/obviously

>     because we now die early in many code paths.
>
>   - t9xxx: All of these are exercising CVS-related tooling and pass
>     since at least Git v2.40. It's likely that these pass for a long
>     time already, but nobody ever noticed because noone has CVS on their

s/noone/no one

>     machine.
>
> Mark all of these tests as passing.
>

[snip]

--0000000000009f7cd806193919c3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f80a0028646892fe_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aUStlQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1YzQy85VzFPTkwvNzV2Mk9EREdOazc0UlpzdW9jawpZelNOaEFtZ3U0
K29sb2FqWmdVdXpzbGx6bDZFZ0ZZdkx1TDVUS3BvUEhscitLOHRrSWpsU1NwNjhSTS9helVsCllp
c3paSXNaeGEyK2JuTjRic0c1RVZDUWNmS0lYT2hlYjNqVFkxUW1NUHI5dVdJY291SXJkTmhQMWlJ
UzBoYXQKSzN0SFRGWlpHYTdzRDV6VExxVjYyV2F5UVNsb1hTU1YrOUE4U2NSSGVvNjI3Zy9PWUp4
dm4xVmpRdCtuTStXTAp6alVMTy9GR1FzYUxKVVcvY3M4NlRxQkE4RXFSVzFqQit2VWV2TERjSy9M
d051Nm56WjVKZGp4ZzhuTUMxR3NOCkxTam9lamYvRkNsRG1KSForK1RKQnpPclVURFVMR2pMQ1oy
cFNNamdzMGdtQmtOWDc5ZEdubmNHK3U3TjZvaVYKQXNHNXZxcXJrZk9MdHhoc1p2VVZDSis2N0Qy
N3BYNlVtUXBVL1RpSDI3ZW5OTUtqbjBmQlZBN3NZVXZKaE8yUgp1QUpWWFpUMEZqOWNCRzc1M3F4
Y0dVMXpHdmFYYS9TdktRN3hCOXE5WVo4b0dFMlBIUmNidU5yTUlKUEtmNWNKCi9GN3o2TFRMdFls
SlpSeXdzeGx2VkFGMkdXaHRJWElqcjRyVElFND0KPVhhTkQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009f7cd806193919c3--
