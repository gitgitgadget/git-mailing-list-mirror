Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B13ACA51
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289777; cv=pass; b=jixKEHY3zrb1mMXedokv4hgCxER/wP9zQXYRXD7YVVbovw+2lzUpVBPA8hTQAnHBhaQqp6dDsMe32A7une2Qhvmxil9eA6ac8WbS5fFoOaOei1C5+uGTiZg/MBEXZQ4PWA82qxxSaKwUzVXVfTFUrj4HIndxQ4HnHS7I8m5m4yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289777; c=relaxed/simple;
	bh=HwMFwliVDsyJMp07vV7SoBqSeD6T5dk+6EzlBQguyvE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbsPtiYfb2rx7mkBol6YOehHv9c+3egSIrRU130kqNemRQzkQru/sfwOMTmTrsH7Dn1SAueqJR7v+NQnsNlPCEo9XBRdpW7gDub6bFVuwcgmSy8JkAa1prKSIXvNSPF2tz3IOWoYH0BgrbSXWsfFNWmyn9Lg9MKDlPzwXmLR8dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMTRsrGU; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMTRsrGU"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-948cfe7403eso183990241.3
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 03:09:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770289776; cv=none;
        d=google.com; s=arc-20240605;
        b=EewjZpj71xH6Al2qZBvxxhkS1cnTUBPg4iD797qqRWJjEvbefTroOb8NTPleDW/e/T
         1EgxHrHBgynqDhjNCGNSGxPOp72kSc7XGXHEpmWE3TP+sWpWOJjmok/MUcCepkA4n22m
         cJyU7zTgujtqoAjnRvjYtJy31TYWKjHiXWcYCIdvJOp/lpwncDn+xdAgF9wFRDA4jC0D
         w2AbiXJEg4NE8lbn7j1ML0sfCBTtDyNambVN+ZoQyF2M2wAM3lYa1yCOaOsTtL9JTBi7
         xYx55t7KMdBYaYj1LV5L2LIK+WYsHxFkjlTOJHkeL4aY93ia578AVS7EXLZktYhb5R6W
         LW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=HwMFwliVDsyJMp07vV7SoBqSeD6T5dk+6EzlBQguyvE=;
        fh=sT4w2HFs6mVrTm/rZxgl08orFohr32C7UPuZ+QakpO8=;
        b=awDgarvFixJs3M+k9BgIZvICPPi7UUZht99ZRAu8JkA4Ryc02yclI4oyNYW2tQA/Jz
         kp6Vdqd91pRTF9BW7LnHWiXSppOjy1pJya3i2PV137A63OkeethIACULoAn0Rlbh+Ffr
         ANg3lEyj+eEBICedEPHA0pB56pOhauVdpaS43So//XjU4msr9U9Pajai/gnLNp4FNzs3
         aWD7biExlomQBu4iV7wQqWc/LbtZxeCSsLybYG3rvYI7sOgJHBk80v4BxjsC3jKfFdPc
         hWfhHwgQtg3dKHLYx6NgunwCqWnL0PytcYKyVCKHyMW7ZC6JGCEgvSpBRF4JY7FFtIGs
         vjDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770289776; x=1770894576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HwMFwliVDsyJMp07vV7SoBqSeD6T5dk+6EzlBQguyvE=;
        b=ZMTRsrGUfKo7k834aAGRWRN9a3wWpLj6qucvMq33EmWuhoDhUlthJhccI1DAVqd7ZW
         jIIx1r/YUoh9zt+d/ZDnT1QQW6sOpIcZWbPNuZxcamKBXEWLCtm6wDuGVqAMV+5xb0jS
         zba7+zUkZkCx1pc5kpF96tDW4vMmRNHJ6pvVB/V4547sbmRMDyj4818wXm0n6VfXz3pe
         5FHBYw4DVJBx06zv8XC3/8t6st8Fu+2++phL9rNrQYnEUX/OOCA0QB+rC7BQZT/dEYny
         RWKRGBmmINEFB4tONyA5h+gI89J2rV7UHQKD1t4luGvnw1IpKMdsDc5L1wEvcraOihQs
         BAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770289776; x=1770894576;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwMFwliVDsyJMp07vV7SoBqSeD6T5dk+6EzlBQguyvE=;
        b=gZ4r6FVoc9FnD9JCaJF9t7Q1QdVfJthMzNifVNUk8V3q1CiAj2HHqNYJyYuZXI85fo
         YRdoVRnyxEAKFz9YpO+agX4fl6Bd07/R8fcX5MYkdNoM94Goo8dLkni3XZHU5GOtxBiO
         ZOGc63p95g843Z1j3Jg7PrLN0V3u1quW5V8x2cjoJsOYmnUUoprzr2UqeUTYUggcwqDd
         Fom9kwCJjzeiz4KIcJuMrO9TGJScCQji2bHcpT05Ju/pnJyAGkg4Z02O3Ca+ogVMzehk
         d3JP4r2XMG1D0MxjjHuSpV+dZfPsGFn5vf9t06otc2L2QcxdrDs75sYhKhRjygsAORtH
         36aw==
X-Forwarded-Encrypted: i=1; AJvYcCWvPX5coLGf0vdPaZ6X0CfbhrLCgZz/5gc+wAFVuTXOi5qBkBdJGZf3YmkJwqtPodaYD+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGJOE4ZVFYpgBBAHiTJWZsFWrsD/lMN/KdyEM3nWNCRXMI29m
	U3olaX6ZxD6g4FecIdUUmciORP0a1TDLMnbNF9qzLgJcL6px75ikiydif50luULAXrONfItgNpP
	jneQHZ6EMCkCxp0QyXXoYlRDKIGDwBUc=
X-Gm-Gg: AZuq6aLprPJioO9IAzYct6iIEV302C+Drw25bkFdYyEdauABjgJqrAphoLTREiBU9IU
	tpzcUgHF7+yuQHAYHyGi0Lsi8MWuV6ysNhOXtAzZrEAvrd0Rp8eSqTZxRuPsNZayi/4cvTVzRt9
	qbmkWie5N38vh8FtvLjPD6UHaGlWPfZRinYo0w9WB3oURRGKt31YKwNX3tgInx+i2UbZnGObnhK
	HmPT4JwYRf/e5E3k1gsrbNbLi5XyslB3MdA/eR4fVg7ZiQevscH15ApbjGYUXhCr81dzivzBCO+
	DViG9JbqwiY3XJ9SAMfFvsSP95E17lJcodf6eIEi
X-Received: by 2002:a05:6102:418f:b0:5f3:6a26:1277 with SMTP id
 ada2fe7eead31-5f9394c31f1mr1827612137.14.1770289776394; Thu, 05 Feb 2026
 03:09:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 06:09:35 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 06:09:35 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260205101524.125452-3-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com> <20260205101524.125452-3-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Feb 2026 06:09:35 -0500
X-Gm-Features: AZwV_Qjvg_VYQpZgT8prnbhY9pexsipKuwar1fCjxbJm4T3vbEsYBQ-C7bbe77Q
Message-ID: <CAOLa=ZSkTH8KC04KubktP1EkU4EHYs0CtmUPkPVe74zi0wcTBA@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status
 through function parameters
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="00000000000045a407064a11b5ab"

--00000000000045a407064a11b5ab
Content-Type: text/plain; charset="UTF-8"

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> Some functions in wt-status.c relied on the_repository because no
> repository instance was available in their local scope.
> There is also a specific case in wt_status_check_rebase() where the
> worktree can be NULL, so accessing wt->repo may lead to a segfault.
>
> Update these functions to accept a struct repository or struct
> wt_status parameter, and adjust callers accordingly. Replace the
> remaining uses of the_repository in these functions with the
> passed-in repository instance.
>
> This removes the use of the_repository global variable from
> wt-status.c completely.
>

Okay, but this doesn't fix the issue I stated in the previous commit. I
do wonder if we can re-order the commits and pass the repo struct to
functions like 'get_branch()'.

[snip]

--00000000000045a407064a11b5ab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6b9be44405cb0069_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tRWVtMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjZOQy8wUUgwY3NHTVlxOFh5RjhqM3Nya2MxT1JpeApMbHoyWmtoMTdY
V0V3Um5ZUlFMai8raUtKdVQvL0FkaUsvSXh3bk5SMEF0anhZb3pJL2lnYzgwcTFYUEJzWkVDCi8x
aU1jdlpZYlJIUjFhM2tRdzFUdHNtZFhGV05lVjRvUnJRNlY0VHFkZG1sZEh6alV1RVJocU8zRENm
M1ZyYncKblZBcUgyTDYzQ2tGOE8yb0F3dmFieTBMQUJuRDQySjFrTS9nQjFvNkdzWEJkajY1N0VD
akUzZDg0QUpwU1IybwpBcGFCSU9JdzMvK3daMmxPeGVZOS9aNFQydi9tQ3gyaE9wbFhVM2E0TVVl
QzZpb2JGT0txVHZSMjBmcDVHWEFyCi9XRXJ2Smh3dGM5dUUvdTF3WWRPZVBUbk1TT1I5N2pMaVUv
blArWTE3dXBzQkhJN1huZEE0aGdkbW00dW5MMlAKZDdySUE5M0YwVmJFZisrcXQxQ1RscFAvVFFn
RzRGRnRXbUdTMjBBTGhaVW5vOGJkZW1QREZpbVhud0hGYis2cApRczVBTDY3L0M0dUZFdmsxNDdU
bXdsNDJHbzZHd0pUZ3ZhMVJCN1RZS3NraUlWZENBNk1iWVVsZzB5V1dhVjBOCnhBY0tRVjZPY2Fk
YitnNEFyTjA3VDJxQ0V4ZDZ4Tm1UM2tyMmlCRT0KPU50U1UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000045a407064a11b5ab--
