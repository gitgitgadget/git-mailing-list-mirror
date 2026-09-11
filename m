Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE964BEE3A
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163899; cv=pass; b=dom5v01nKc2E4EubVSU9Cql77Q6Bd9FiiN3d9kvwT+2nLrwvOrd63CLvWvgb8cxd3Y/ItTNfowhnp/vwUinrgYD6hjsu8KesGLY4x6ICn4rA1dbuBDE8aT1bwejhaEP4P4Yioe2GQpLFJh3k4UPkfKxY+HLdjdVOiZ/eg5Tdpko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163899; c=relaxed/simple;
	bh=/5L8cumxyPiodB0g9flq6ZvYlPOypGkjbo5oM12WjMM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEaRtIPmfa5idZexiS2jkUZLzOjF1UQyCdT0gCUddkE4w1QO6+v1rfJ6dUUvoQh9yOf+ogSudTPN6eVAj+zC22mIWvnzgtsUwlVs9Pn0SH+7VZNaCO7b4o4rKCslYlNxMQNcrmm7H1pLQBKDyppuOC8t2dgSspymbuB80lwETm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dB9WZalz; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB9WZalz"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-97c441e66f0so882046241.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789163897; cv=none;
        d=google.com; s=arc-20260327;
        b=RevvMp7ndASK2Il3lZberes2cVlxIkGXcKIt+qCLYR4yHP9nIBvcQaopPpDasB0/GX
         efnoRatA/cJMOkM/yYHe4wOSD7KkoguByVSGKCo+P6OmXY+rYZerS+MwJPL0IEhE21si
         wVGaT3Wc9RPN6Pg4+A8WQj+hBk4pwB5EEXgFuyCsR5iVo4Wdod1jKF1IEoM5VH9VQi48
         9Grktt+p9g1xo8nDJPO6WbKrTnwheE8OnA7CXsjyr6rq4vIapGlmTomfP6XQPGF/9Bbd
         9VqJER6FvjbZ/5KVhj9AviJlJcuDJFtTu782/ChO2dF92+JW/lSRK4TCzYaQxNwI7u21
         pcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=V2zrFuqGTkiZ5qz2Y7kPNFm1Y8SC3lneHezTz8rKrps=;
        fh=D4uDqIpMAU76UF3y7kLhifPMaIKyWsi4/hRzYZ8Ccvc=;
        b=L+Kxs0ICT+LAc6ZZOqwuQZ28qwzrt1LM3sWUNeiQoHggjwsA5Zas0Tr0mJSL4j2g7m
         WZWucYizqAw3ixgj3wYhT1l72eemMOvkNDJW7a2az4KQefhqWygk0fDZO/+ek6PQ6Fd+
         VNLNVFlcxG9e3gUGQxWX5aAq+8+Ae+y/gYZ4E5XKwFUSXZEgrzCXi3IHxaaUr3GNFCIM
         rfm0ALZzCanQrvPAkWGnar8+HnDRhClMvI9ow7hTH+eA0bOczfHbnpNXB+QYgL7D4bgP
         76QCCZx2xXDpEMtaZSwmY1rMYSagJNZIMVlLo9tuCQt4cx1Szzrap3MnLa4644LkDAQc
         8S9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789163897; x=1789768697; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2zrFuqGTkiZ5qz2Y7kPNFm1Y8SC3lneHezTz8rKrps=;
        b=dB9WZalzScxy5dlAswAvCBflc6uRO6OIBed6W5AESmyF3UPBKlVxEdO/SeX2AIiAyF
         /a1s9skjkUSsrqsYDNi4p8J52PZCbfyCHMphFze48YZEi/uXW/Zd2Z7kAwshOiJrWvVv
         qG4j6G971Hldm79aY2wujeDFhvyjiXDMnzzRr2CMSOOTq2H1InNvS1mu8RrTikCwqaZr
         2suKYjN2Q1+Ns7v9V13aaO66Qvk8O8GjRKUXeZlGx5UUcwnF9cZ3xxi7Vm/g3WyDJudr
         ptPvyiX81e27JGtKxWjedMooLvOKZAuG9eqa0wm5r7EQw0lcYXT6sNAjqR8FqKaNuLYy
         wO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789163897; x=1789768697;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V2zrFuqGTkiZ5qz2Y7kPNFm1Y8SC3lneHezTz8rKrps=;
        b=D+wRLzZhbjG3Ke7DeUn83EjQFlFkLNfVNuXtiZOgpTkK7caEhCo9ip8monaLxobwl1
         ehSh0afo/IRCVYr/Xnj4YhxLs87JwtdaniOV1uqIi0YEt6GYUf0OxcJ8sHc8PUPOdPhS
         DyIyelFlcDN8RzYlEdtfCL1XE1ELyNLCJpfbhHUtNqrOdFac70oLE/sreEjJ3elqjK0g
         k1xMbkEx5PAczlpQyVYjLFTZi2bNClEF83UBKcKOQqOS3uwcVUsp8fpU21gXjqNbVitR
         dCrVTjDQoreCCYo9MqD/gQGG9CctkkDfhXBtKxkCT51eZZSaLXeuMXDHGnPCYjysNQI3
         YGHA==
X-Gm-Message-State: AFuF++mJwTQfXbE/c9ue282+bax2ZzhWX//QwcakwezErV7Kz2vUmr4u
	wR0cAG8a0EQ9UN7QqsNxXgDojV7QFFTLUjwZ5li7uVAkcZTsPJgE32vQwJBkFWtSpeJnrq8KjVV
	rgqCAk85oT8r2EJy6TrFgiNA1/teR4x4=
X-Gm-Gg: AYBFou1JYsI34lejtD8e0DTf983OF7HmMSpZZ9+6FSn2khst14IKlpevcWznCm9l3aH
	fkEQoRyeuk5gLTinHYLiA7wH9YUQ2DYujAL0uYnLdHURPLI5w4oF9bmmLSeiSLe+Ma87IYU8auE
	XuS5hUzaOtKQiwm4jsC1wnkDghabW35ctuRBYng8VP4WRv5fRhHlCd+9ZGXuYDQj61WtKuEjYJz
	9SjEW9ZIO1OHgBWhTBb5/+UGU0eJ83Fj7VozSqdHbY2PhPZySblA+6dDIPuJozvcU8JK5nJGMbJ
	KVTeb0uAAAHqm0dAanJdrRDfzl01d1CRcY1Zp6JSxzREPiVxoSI1T04FVoNfS6qfClHvZabD4y6
	aqVTFVt36McHF4neFUuJCIe1wMsWO8IZf8y012aGEU+odUA==
X-Received: by 2002:a05:6102:5493:b0:784:b9ec:9144 with SMTP id
 ada2fe7eead31-792abb23c2cmr7514112137.8.1789163896961; Fri, 11 Sep 2026
 14:58:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 14:58:15 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 14:58:15 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq33vfa2ny.fsf@gitster.g>
References: <20260910-758-introduce-hook-v10-0-06f9c506631c@gmail.com>
 <20260910-758-introduce-hook-v10-4-06f9c506631c@gmail.com> <xmqq33vfa2ny.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 14:58:15 -0700
X-Gm-Features: AcwNN1Wa6r0t_MioLL1jktDvlQZfAHBb-dO3b0CACIz1gWuqlY0gjAxRylx4zkU
Message-ID: <CAOLa=ZS0PT4bb+k3HR4F_aOoJ5uUuMFx+Dnte4LpPEekFxs9uA@mail.gmail.com>
Subject: Re: [PATCH v10 4/4] hook: introduce the receive-report hook
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="000000000000863c55065b3c2e18"

--000000000000863c55065b3c2e18
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static void override_cmds_error(struct command *commands, const char *err)
>> +{
>> +	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
>> +		if (cmd->error_string_owned)
>> +			FREE_AND_NULL(cmd->error_string_owned);
>> +		cmd->error_string = err;
>> +	}
>> +}
>
> This is my fault, but like free(), FREE_AND_NULL() can safely be
> called on a variable that already is NULL so we may want to fix up
> after the dust settles, perhaps?
>

I didn't really think too much about the change. I'll avoid a re-roll
for this.

>  builtin/receive-pack.c      | 3 +--
>  tools/coccinelle/free.cocci | 6 ++++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git c/builtin/receive-pack.c w/builtin/receive-pack.c
> index 9ac7717096..1d5b050beb 100644
> --- c/builtin/receive-pack.c
> +++ w/builtin/receive-pack.c
> @@ -2452,8 +2452,7 @@ static void update_shallow_info(struct command *commands,
>  static void override_cmds_error(struct command *commands, const char *err)
>  {
>  	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
> -		if (cmd->error_string_owned)
> -			FREE_AND_NULL(cmd->error_string_owned);
> +		FREE_AND_NULL(cmd->error_string_owned);
>  		cmd->error_string = err;
>  	}
>  }
> diff --git c/tools/coccinelle/free.cocci w/tools/coccinelle/free.cocci
> index 03799e1908..c95ffa2a07 100644
> --- c/tools/coccinelle/free.cocci
> +++ w/tools/coccinelle/free.cocci
> @@ -43,3 +43,9 @@ statement S;
>    S
>    commit_list_free(E);
>  - }
> +@@
> +expression E;
> +@@
> +- if (E)
> +-  FREE_AND_NULL(E);
> ++ FREE_AND_NULL(E);

I could send in this patch for coccinelle with the fixup if that's okay
with you.

--000000000000863c55065b3c2e18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3d87beac19be3994_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xa2VYVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM0lhREFDaGNuSC9JMHhDNkIwdnRZRHRpM3hFVzhidgp2UW11cXl0Wi9O
VnZsRm1KWXBYRk1HQnh6Sk94L20wTzFsdWpoNThBNWtFSmdDdjV4YnZ1R0o2Z1gxRkN5WG1uCjA2
bGVkL3QvMWJGWXMraEgzQjk0Y3pqUThvSDF6Uk9OVGdFT21CTmRobWVqMW9USlEwZzErNzhjeHgw
QkZ3M2UKVXVrekgvVmVYcWs3eFBUL2JYNjRwVXZaaU9UelhMWjdrSmp2WlZWM0xhVGRaU1B0L1l4
OWRZQS9vNjgrUkhTSgoyVTExbXRaUnVDU0s0RFIxb0pCR3hGRHlValk4QnBtYzl4NE55VFlEcmVl
blZ2bC9LemhNUVF1VWoyd3RVbTE0CkNDNklvVGpZQTRycGdrcjlPY2hZSUh6eUVkRExSQnhwbjYy
WXFjRkNyZHdTVFBnSVZ5UlYyWU91ajVPN1pPdjAKNHJLbG0yaStQbHJYSnl6S3J1ZDBXcHdNVHVM
UXJkaytCTi9LczBUb0JNbmlCdzJjL3RhU01sWFQ5VlZNTDhPKwpsdkEreXIvVWluNDdMb0Z5V0xV
YzJJeFVVWG5nUkZ2UXo3QnEvZXZwdTNXUzZKTVhzVEQ3UzIzWU5xc0d3NExMCkxmSnNiL1ZyTC91
Tk05R3F5M0hMSzN6Z2FJUVdxUWdKVURvVFcraz0KPUUvQjIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000863c55065b3c2e18--
