Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057F165FA1
	for <git@vger.kernel.org>; Fri, 10 May 2024 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335141; cv=none; b=FQF3KPkiNV/PYGJKv0USHPdpMz4iqRAPUYEInZsx6ZVnI6Q4Kv1xw9ZZz6Bq4UrJdAybL5ai7SbCBb9s9tD+SVSBVHhOuLpiXTQ/z2MA9BPdqD0Qc8S7gOZwMZL+ngwplAvVQFZpuBfN88uoVe7J0W1+1vieftB2+xxl690dPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335141; c=relaxed/simple;
	bh=nclLJg1bsx+jt1yb3K288YpCGfcJEe0XK4BsotYbhRs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Ka2F43E4YA4oQqrUJZLMne3oJVzr2Bt9zFxcJgpbIi7qd2BdJpstNBHjfQW3PA/RVFu/y5PqpaiIwLAV9XPLQYQgQlFwHVdEKxUj/kS2meXe/ah7dN2P9Q1Tcl+OIgHBN1/+TVQbHcB9bHqJP0UMyUQiXY8YGi7TqorLgtqLFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6cwf32x; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6cwf32x"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-23e78ef3de7so953432fac.1
        for <git@vger.kernel.org>; Fri, 10 May 2024 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715335139; x=1715939939; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJ6cI4CwgoUmfYKzcWX9FDfjATVRTm3xEWregmuEjkE=;
        b=f6cwf32xW+3WNTxaADacvAcVgjK7Qg9Qu7QEslM7avMePEk5bkvS7UVxhgoiDWMzD2
         E/ZbMH27CrfIXQSk5aeN8XnCHdfVdPTDfmzO+7yO7Qv4lXeRKfPiYWfr/ReiKItmGTez
         zP4U4/AZrbNXOaAbFwNdvVxj7jHF8Omr/ZliZR1LVEsgLSpLVdXeJIfZNhexa8Cs91b8
         qs44sVa6kaq8X5vXRg9sYQxjY1eBvJlby5LuDtaFCCb214em69q98TRfe40wCNGbpqqB
         53UnHQiTOC6Myaf/70RWy+OrCKdksDoZy4V0GJYrhpVF+wpyj6qB4Z501+9q3Pwl+fDB
         bOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715335139; x=1715939939;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ6cI4CwgoUmfYKzcWX9FDfjATVRTm3xEWregmuEjkE=;
        b=jp/h+lfxLf+JLFYItel1urL4/8OFfviX8CjYjuXXAi1ZSRZa/BXPpZu4ezA4LbsBwf
         N+ZIdC93GSypRhY1JWEG+0qCX8z8J3V/LgIygCqMNdPhKaTZlE4xij4pLH4TedlNCaoy
         KquUQxdS3GFdOp3qHElwpuoFPlNC5d3ykWr1qGJefWPDg8Dir/3dnLNjODE34haO3vx3
         6ik3E83vECwKJsDerZlXP5Zcdsaw2leRY+inX/JDbQ+BykFAIb1yd/VGi7lOgMdDoWQV
         yBXaNjSYbVS6jwjnKFOiRMW/5OlOAubxZHp5B/EViKott7n2XHfG/FYtl+NoO//HvEcK
         fPfg==
X-Forwarded-Encrypted: i=1; AJvYcCWEODvPkkGCm33quNVGlspeynFPUH0U4OGUffMbfRwsGnpbeF4ITHppsu68f9iBk5oP9XghJjoTDZS0r0ckL3/P8QzL
X-Gm-Message-State: AOJu0YxUKjJ1MESybjf4MQopR3kZ7OQyt9SRX3YJ5BQcFGZhw1WQPx8u
	Mybyb88c7nOJqtOBcDwf2V3vDrZWJC6cCC8rgotlxbR8ulUPE/KU8xYMJuaKmz9KxzMru5ahqtq
	/GpdleXUZW7WqoJTfrPC89LHKu/o=
X-Google-Smtp-Source: AGHT+IHkbehq6I8EFg34JrKKQZ+Cfgn9CzNFQkdO9OTzH0xdvogehhWO2QEXzr6vw/DqXBlDh/NgrDYFbkI6uRBjsfg=
X-Received: by 2002:a05:6870:4209:b0:22e:bcfd:debc with SMTP id
 586e51a60fabf-24172a90478mr3116025fac.13.1715335138946; Fri, 10 May 2024
 02:58:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 May 2024 02:58:58 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <861f2e72d987d17b00d68cdaf400d743e2f8c118.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im> <861f2e72d987d17b00d68cdaf400d743e2f8c118.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 May 2024 02:58:58 -0700
Message-ID: <CAOLa=ZSLx7fAo0kT5OR6wyjyTczDLOpcS82xGd195uWVs7JRFQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] refs/reftable: allow configuring geometric factor
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a0d59e061816951a"

--000000000000a0d59e061816951a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Allow configuring the geometric factor used by the auto-compaction
> algorithm whenever a new table is appended to the stack of tables.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/config/reftable.txt | 10 ++++++++++
>  refs/reftable-backend.c           |  5 +++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/Documentation/config/reftable.txt b/Documentation/config/reftable.txt
> index 6e4466f3c5..1c381dda04 100644
> --- a/Documentation/config/reftable.txt
> +++ b/Documentation/config/reftable.txt
> @@ -37,3 +37,13 @@ reftable.indexObjects::
>  	are a reverse mapping of object ID to the references pointing to them.
>  +
>  The default value is `true`.
> +
> +reftable.geometricFactor::
> +	Whenever the reftable backend appends a new table to the table it

This doesn't read right, did you mean 's/to the table/,' perhaps?

[snip]

--000000000000a0d59e061816951a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 90dfa4cd2f5fac8e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZOTcrQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOGdXREFDY2hmVXZjN01yMTZDdmd0Z0VCVnJsT0YyMQppWXNLZ09OUlBv
NzdYdzdKTThoVXhTYWM2UDFGRVFzdkJJRjVtMkVwZHJlZ2VRNzhDRWU0S01SWk1vWDgweTcxCi9R
cDhBWWxCVy92M2JKMTRTWk95VW1SOWxDNnRpNTRsbHlQV1Q4TVdWNVFCdmJYdi9jeTBLQ3VXSTNT
Qnh0V3AKZlloUVRpTFhSQTNxWXVIa0NmUEhYUXhHaFAybEkwQTVtT1JtSi9DWW9DYTNoa29CdU82
S2JPZ0tTanA1Nzl1TgoxY0d5eWpTQWkzYWZOdUlKSElvcUs3dExZZ2JTckkwKzBCWVQ5aStaeERy
Qm1PR1liL21BRWp4Mm9EaEdRcm1yCnE0aktXSDVNQTFHVndOR1ppK2Z2QkVoSm9iMVpCRXRTaFpS
eTVRM2NVclE0U0RxZzdyK1g4cThBUDI5Kzl1OWMKQjlXalRSYVo2T1U2OXQxZ1czN0RiWXZhUTBR
OGFuQ0NSVzFvd1FTM1ZuUXIxbTdQTVFFZ3RlSjlHTlVNcGg1dwpWdVI0cWNsWW1KeVVZdkxmTVZ6
K3JRYTdrc0Z2UDhCMWxaQnJBS2EramQrWHE4M2VWR0hYTEpUM2RaZytNS1BKClZ2bGFSUitBd2I4
c3k5cHVTL0c1a0RsTWhGL3ZuV1daQU14S1puUT0KPSsyMzAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a0d59e061816951a--
