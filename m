Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841319D07B
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395754; cv=none; b=LmlE4ENruhN9pMflo4aEs3bGOza+ZsGTmzlxnQtTjuDKs1TpXCBU7ZE1EDH1U2l5MWtTi4wIhZ7KSrxn0kYJvBPRpm0p/oLUMrNjw6Bg/AAFgOpSLsdVbbMZXFXsPLyx5Suk3of1g4oQFqlYmXLaUAbVzjGW4JAPIC2ROfZEOCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395754; c=relaxed/simple;
	bh=PFUXTopGBQq1N7ZzfcdqrkOpnf/k16c49Q1JY3bZ/d8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owu7rXCZNcRjxWFtOhA2GrQow2V1rC8Rlf5zNvC3xSqv3dldQKFX3PhEahcUw4AsUR7J+TCgutdPq/1TwWn3L27e5DepaPe1S2IkCh4aTw29jIyghGXoxobkIVOJkuznoF4ulBqVk/cwYnEAhgycGvTKduB5wd0SjHjkn4KDudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8amjin1; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8amjin1"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c9b74043b1so1240035b6e.1
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718395751; x=1719000551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+5xKxnre2WayrsY97dZD1+CicY6vqdScENbcx8ZCA3w=;
        b=T8amjin1aRd7EOx5/r0qKAAyXSNDalWDBmBsXBaQyMkl5qElvuaYNeKAX4tFvk5H8V
         3V0lshtQLKxR0V24ptUnilxIwebs8DlcLXr3G2ioiTqy/2LZeZonn15/5Ee6agTPTl/E
         /Nu3xpwdpURf1gUZxnLPNN31hEKtXDMh4uDDNr6q0FnCB2izPp5aCs7KVlAvDCEaB+p1
         giY010R01S2PzyJsO8QKByJMt48bSTK1iuh/tRw20k/4rt4P7mhcCy/gBnLwk7jiYrgo
         qRmt6hXldcFa3c6tQXf4+umF8+xpBHuPXVzFydfil4SjG8/n+ZnM07UO19EfGIizT6jj
         NXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718395751; x=1719000551;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5xKxnre2WayrsY97dZD1+CicY6vqdScENbcx8ZCA3w=;
        b=cP5wC/Z/2xjNXSuttv9FAYM5rHkJcyKlm6C/p5QxT6kqTUBl0/Wg6jL4UPOzuaTZpS
         5zW50p5ew9aiqX+nn7j+r6oId4evAHLRV/Mf4kceGVsZmB0sS9TY0pWQ2IJHNbbvNPmN
         6ebeVOx1CT0cfbdnygt+TpVLialhgNJ5lnUkGWq0RV4H0mNF/YjmeOLsFn9K4ZAFHmJS
         yVUhsMOBkV7v2Gbes0NQJEfLM0FqBvVW7o+hwkibvq6WNXXOkFzGXuBP9yRdCfBtCxQR
         7i7LQjV2/FPElXdFsUhaxIwlmM5/7eOIF+/0UuZYCEsop2hcQmeoVCjqtDGbyb35WlRk
         4pKA==
X-Forwarded-Encrypted: i=1; AJvYcCWVVMkZkJoQJT4UShn/VAZs+LJYsgPKVa5M/uu0ibNzmsnlZn1sr+54g0O8dKgYEeCGNp5E7I+tMORp/dE7KyQLDFdE
X-Gm-Message-State: AOJu0Yy5Jm/+O0Z4xzs9Q7Xc8ERF9YLJKWDbpihtUzszxZbuhTud8bjj
	yrAOliJ3YzqGb1347AXoVoBPk4ZWWJG2MBST+uNPKkdrm5nia2kM3qi0rz+/3o+4nB7X3E5QFLd
	LGbf9mUcnHwj7Onqr365l5/Tdv2gDV7Tz
X-Google-Smtp-Source: AGHT+IE9BKa+gHEkbwYZ2hwNODwUq6wM3ICPIjMf/OkiV9j7rA4lvqQ3Moul8ATqcJo1w38ds44zkDSRzU1WCg/kjaw=
X-Received: by 2002:a05:6870:168f:b0:24c:b80e:ee1b with SMTP id
 586e51a60fabf-25842c13dddmr4485101fac.50.1718395751500; Fri, 14 Jun 2024
 13:09:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Jun 2024 13:09:08 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqle38n7hv.fsf@gitster.g>
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
 <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
 <CAOLa=ZTgP+OwVrT87=og4tVdhsqjErMUJzCuT9bdDatFS=J8hQ@mail.gmail.com>
 <a03cd45e-e4e0-42c7-bb98-b25cac12e42f@gmail.com> <xmqqle38n7hv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Jun 2024 13:09:08 -0700
Message-ID: <CAOLa=ZT2goTBD6WBtjYOYqa6vEsp=P=UzUBzs-5Om3d9HLZYbw@mail.gmail.com>
Subject: Re: [PATCH v3] date: detect underflow/overflow when parsing dates
 with timezone offset
To: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Cc: darcy via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, darcy <acednes@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005a2b5d061adf3077"

--0000000000005a2b5d061adf3077
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>>>> +/* timestamp of 2099-12-31T23:59:59Z, including 32 leap days */
>>>> +static const time_t timestamp_max = ((2100L - 1970) * 365 + 32) * 24 * 60 * 60 - 1;
>>>>
>>> Nit: but since we're calculating the number of years here (2100L -
>>> 1970), shouldn't we also be calculating the number of leap days instead
>>> of hardcoding it?
>>
>> I'm happy with a hard coded constant for the number of leap days - I
>> think it is probably easier to check that (which I have done) than it
>> would be to check the calculation as I'm not sure off the top of my
>> head if is it safe to do (2100-1970)/4 or whether we need something
>> more complicated.
>
> It's even OK to use a hard coded constant for the number of days
> since the epoch to the git-end-of-time ;-)

That's why I noted it as a _Nit_, mostly because it wasn't anything big.
But I found that part of it being dynamic and part of it being static
was inconsistent.

> The timestamp of the git-end-of-time would not fit in time_t on
> 32-bit systems, I would presume?  If our tests are trying to see if
> timestamps around the beginning of year 2100 are handled
> "correctly", the definition of the correctness needs to be
> consitional on the platform.
>
> On systems with TIME_T_IS_64BIT, we'd want to see such a timestamp
> to be represented fine.  On systems without, we'd want to see the
> "Timestamp too large for this system" error when we feed such a
> timestamp to be parsed.
>
> Thanks.

--0000000000005a2b5d061adf3077
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 18cface773902c80_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ac28ySVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejk1REFDQ3p0VnY4WWlqL0ttTk0wYzFmT2dWVXhoWgpZQysrb01LUzRm
UUpLd1Z4dXVDaFNSWlZLdCtBVmFZOUt1OWp3MWtJbUdrakNFaVgwK3MvSTAzMDVJSDlXRHVtCkFj
cUlZWldUQWkwb0xrLzlhMUlhOFNSZ0RQblJVOTNqV2hmMnhpNXQrV2oyQ2JOZ3JxamZCK1FqSlBC
bHp4akkKTHc3VGg3cGozM2QwbktVaVkzdGxZMFZoZkh4TVJBTitXZnplSG1hejN6enptT1BZOXNG
MUxoMU4xTldHUmxKbQo1ZlAyZ29KNEFnM2g2eGIzRVMwdXplV2VoUFpsbjRRRDRjOUpDNDBUcytQ
QzlBejhvc3ZLRXdLaklkeDNBOFNrCmlnU21Td0xOZFFuQlYxWEdXMkxmbDVQSHF0blpJaGoxcVV2
T09TcXhLYTJ6SS9nTUhUYnlWbmRpRXhySUV4TTUKbmM0NGlCbWswL1g1bkhkSldPR3htMTdndGYv
aEFRcW1xNVhwNW8zays3WGdYUG5KcUVucUl5UnNsWmtDNkg5VQpPZHU5dzBibFBjcFRnQU5FY0ho
cEFXRVI5amhJaUc4bEtNT1YvMG1PSU9uZzRrZDU5YzFzVm5zQzZIbjRwMUMwCkRIa0E3eEFyaFEw
NWNQUCtseWtlY2dSVk1HVHdXenVSbGtZR1ZNTT0KPS8zSnoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005a2b5d061adf3077--
