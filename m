Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA96246326
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751013506; cv=none; b=RNhhotTvlFYw0EPqE0sRaJxWf791mp88wuFkDfT1wv8ssJTFHxsqlGuDfivMaOZLvNoseoJVRBwCw4v9afiBsIXBxBf6O00IfQJ74EljMRY2oa3++xRxJ1gQjoVpyP+ItqXbUiehlPF4vyZs9jHq2yEQL5/DGVeZxpxZINqHMvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751013506; c=relaxed/simple;
	bh=HWTssarjUf1MRWDW0uGSqp60NOt3/+3jY7g0LWJtH2A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkZ8hXlpMs6vHJzzrfXUio1cfx6OTYN8wAmOKIZEKfxE9aPs/E1AA04CeregUPVzFVUOzWe85CCOfq1GK9PqFfr2/6fgK2uPijUW39ceKXMf3cXrKdlp+NEjo8jZSISxwnWX3jE1OpB5UcdM8YsEqzyGA7y3YUW2+b+RcKoI8jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/dXEbV4; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/dXEbV4"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-528ce9731dbso462444e0c.0
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 01:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751013503; x=1751618303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+EaDlczv7pTeiP/Lx6w8TXZ5Hp9oZsqesX4z4HIAHU=;
        b=Y/dXEbV41vogSdjAT3SdXqb/HOyG76pBsPpSBnB/0EHY9U4m+xzcYjcFHd3p+a4uoI
         vwx4lDYTBaZqgXAoCceQAkQ5EghbkPRxrVaZDkDrgEXjh3vYFLmX9E4cuU7bRScpW86O
         d7lFA9BCR54UOn/kssECcelLnWrsJf8Q4mrKlVh7Fw+HUoJnzr39DnzgvQ914tsRPUmN
         ScOBZN8IZ8NToW1u7R2/HRXgnsFGaFChHz19vA7OaFIX9MF+RmT2Z9vq6uWGjc0g/Ubu
         Dy5oRWVpC97PA3b97o2WbdmC2BP2BNyAPCrTdkRdiy0Gz6cvMZ6jdZ0qummDhP61ljYR
         D2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751013503; x=1751618303;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+EaDlczv7pTeiP/Lx6w8TXZ5Hp9oZsqesX4z4HIAHU=;
        b=UTngUmecatBNkot8v7QVYgurF/jGbtV56kByLcsuAPukhE6lDio4RuaAKcgryiC/WG
         FAMHrICkOEYPAN3pgvB467AsE7tc5K/xkeIMvCq35CvW3NUyIXuhcIbhSPJT2oANC8Fn
         lntJyMidKqT+JSIDCM6e84n7BuyM1FupJjS74C35HlDncOmnpj3K4zOWOR+9G344hMIt
         NehBCODWlMBnDSxkADgmnaw1DaXX0QUTrO/zo8Kdn9qFz0DtntzAzNzQYOPAbrl8fGTi
         MhXaHPlsFVV7+4tbHcA04SVOn4xNDQYaoaefzQvOqM4BnG3azG2h8AdYE6jd4hj05HSj
         wOrQ==
X-Gm-Message-State: AOJu0YyFU5KnRyJAfBoXi7hgX03Ccdi9C4NlX4PoGQ7RoXNl06s4La3A
	fV6lyQJ22ZyaIrtr5+laWH7nGboustoJ8/ZoX9wRSM7tggLJZIxdBwakipCyiIoJx8QKJaVNdj8
	yJHdmAT8nw7vKhtgp4bswyiOxdihtWg8=
X-Gm-Gg: ASbGncs2iJr4nx6QAqzBEm1b234RBq48f6p4FxHp9BscnRFaMtK0oF86/S24UG9TQKN
	e8pw2g39kWFNRYwn195k58GBV26q/7ARVBShXW/v9042uIGBwVbR9JK8dkEhnSVvsT8QE5BFE7g
	0bG4/YAx5fx4VmzrtMqi2u/BrK00Stxlpq/NK32hPHohkcTETodGqhxNo=
X-Google-Smtp-Source: AGHT+IE2SfGeUj8hChBLX70rwxe9meUvEUKtszJex//JUYm/hQlXeMMmMME26XDCAKGdoEzHmAHmg6A5FaV1ufvZj3w=
X-Received: by 2002:a05:6122:2514:b0:52c:44a6:4801 with SMTP id
 71dfb90a1353d-5330bb10275mr1762563e0c.0.1751013503592; Fri, 27 Jun 2025
 01:38:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Jun 2025 10:38:22 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbjqar35m.fsf@gitster.g>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
 <20250625-525-make-clang-format-more-robust-v1-1-67a49ecc2fd5@gmail.com>
 <xmqqo6ubu0ic.fsf@gitster.g> <CAOLa=ZRu-fBsNpoSzb8z2xUfM7WUUcdR1XRd8zr1U+P61QRccA@mail.gmail.com>
 <xmqqbjqar35m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Jun 2025 10:38:22 +0200
X-Gm-Features: Ac12FXyNu65ao5NPORt97DDOCNBDeI-7ZmbPd6lHPDZ8gCJ9xBESniiFpOlvlVY
Message-ID: <CAOLa=ZRrBS9Jzf_p_cLOhB+meSTmQ8=MF67A_tihLZ-qpj42Aw@mail.gmail.com>
Subject: Re: [PATCH 1/4] editorconfig: set maximum line length to 120 characters
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000e11a3906388999e8"

--000000000000e11a3906388999e8
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> So my intent was to instead was to allow the user to be in charge of
>> line-wrapping, but for no reason should that go beyond 120 columns.
>>
>> I'm happy to change that to 80 columns, this does mean that supported
>> editors will start wrapping at 80 columns. Users will have to override
>> as necessary.
>
> OK.  So stepping back a bit
>
>  1. We advise people to avoid exceeding 80 columns
>
>  2. A line can be easier to read without wrapping strictly at 80
>     columns but left as a single line, slightly going above the
>     limit..
>
>  3. Even with the second observation above, a line that is way
>     longer than 80 columns is not acceptably long.
>
> Now, what is the line between the #2 and #3?  If we set these "hard
> limit" to that number, as long as the tool does not pack multiple
> shorter lines into one line using that number as a limit, we'd be at
> a happy place, I would imagine?
>

Spot on. Doing some backhand analysis on our code base:

Total lines: 2136626
Max length: 904
Average length: 36.2
Median length: 32.0
90th percentile: 73.0
95th percentile: 79.0

Lines > 80 chars: 91650 (4.3%)
Lines > 100 chars: 54589 (2.6%)
Lines > 120 chars: 35529 (1.7%)

The `max_line_length` in '.editorconfig' is stated as:

  Forces hard line wrapping after the amount of characters specified.
  unset to turn off this feature (use the editor settings).

So it doesn't force packing shorter lines together, rather, only wraps
lines above the specified limit. This limit can be thought of the limit
beyond which a line is of unacceptable length. We can move this lower to
perhaps 100 or even 80, but that would force line wrapping at 80
characters. Which can be great, but there are situations like you
mentioned where we want to extend.

> Thanks.

--000000000000e11a3906388999e8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 69c9e7a1c5a61a46_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oZVdIb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0hDQy93TzFyV3A0RE5oTW1wekhsWlJ3clFvZ0syUAppNVY0eWVhUXcr
WkFOdWVXWm80SDBzVzlTUkZzYm9vbmp4Q3JITnBFNkJUR1BwRDVuV1VjU0RuQlcyQkFEbnJkCjk2
R0h5dDUxOGx1ZU9WL0MxTHVjY2J0L2Ftalo4NXdMZE8wcmI0WE1JYlFOaW9RWU9mS25KVzFhQ2Fx
WTVGMEYKSTNSL0FXWHVTYmJzaC9iL0RBMHVLUTVGWkdaeE5jQllFbzlHUFBOV2RmZkNxeWx5VUpk
bldNZHBHd28zWHZDaQpwNVYydzZmT3Iwb0tOOStvUkhpNmd2VzZac25tRGhWbExibFdyQXJhSTJv
UU43dmdYNHZEa2JjNE9yWm5wZno0CjFPcXVCb21WYjRoMngrb0xlditLN2w0WjJPUmZBQ0JKZldk
aE1YZ3kvZWRYWk9oWnkxNmRvWU9Sb1NDWERVRkgKdk1lN2FsdzRkYVZISTliWWdiejYyekZPNjlS
K3FHQmlNRkx3cE1VbkxVN2dJa3pPMnRlVklQUzJKRnlNNzRaRQpoVlp0eG9qMWFpUmFFdGNSZ21Y
Uk0zbkRLdUFUMFMwMjlEYk1sYU9ERko0bThOOVRmbElpSU9TUWk0dWRCUGNuCnM3T21tbHNjSmVv
OXprUEJJY1R1UTI3azVhTkpiR3VhaXVQZjVpRT0KPS9RT2IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e11a3906388999e8--
