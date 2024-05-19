Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6DB1870
	for <git@vger.kernel.org>; Sun, 19 May 2024 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716127272; cv=none; b=dotBCVLzifyUDbp9Wgqv8pCS1ZQ3J6oz/yEgwkFoCVCv07GGwCHnux2lyOUv1E3pCgbQ0a0zZgexxMIaXvnWAHq6UutiG+t2EX2b+8jr7tp0ds3YtrB7awzMN/Zk0P6h1x30Nft20bdV51oBjjUfxafh8yBWi6f1jckf2ASiIkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716127272; c=relaxed/simple;
	bh=DoiWibnZj/M4YSto2gMmXYSPkGpwx69mqTqmK4pzMZk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5vj4TG6BzpNOBFAAPluJXx+MFxNMMdltiTZpD5b5ch0tkXg07chhCyHwX+m+kdqaq7eY352vOHIBj6CTxnoa7R/0B55PAcQJRDFRAp+V5EkVeSWgsw3yiowTkWlWecyjb0Uun/4j8madh3c5rhFEr2Hhgmy1h2CmvpZYfLrkg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFO9/L/l; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFO9/L/l"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-23d1c4c14ceso968564fac.0
        for <git@vger.kernel.org>; Sun, 19 May 2024 07:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716127270; x=1716732070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5GvRZwkDYdaINZSqdl+vR8CL3jA+kclyPwrv3vH9TD4=;
        b=nFO9/L/leShRAaVdhTciStsS+oNrtS0AwVpVYc7JrssEJw10njiQOk75OSUjE7JHlw
         fu7VtCLtzdq0yNgt61ewngwnpw5THzVeY9a89fzQQcvmc/6uN/w3ZtvWi+XIvZ1lOHf9
         3YWuOylNMgcJOYqEhoRA9BynJcrrgWXVbGhrzLPHSOw3OlZxh0eR6N9Qkd6kaJaRpypq
         BQ5tqBPIclbjWcZJSoLXdx7f/NLkmck7XKuF7rJpglbu1WOeb1vEapGz/Y9xgda1ZVxY
         cMJM2ogFkNHFiHb8U6VBSUTdU79cc5Vblvt5L8mc+RotoKwtOF5+uoGe/2X6tPXvBEdV
         z4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716127270; x=1716732070;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GvRZwkDYdaINZSqdl+vR8CL3jA+kclyPwrv3vH9TD4=;
        b=CydTLKlIO4uh2+6HPoYiUBpdsusCyR5k8x8OSgmQp0J5HQSXZdbo2vv+wClvbIp/6t
         GHbjWp3Tkql+7dv04GMqbKP6r/GSzgbmF4xORN0ZyPwOecBfGKkY76QyQd2y7JAmgq5C
         mrrf/ccLUFEhfNM41xnfxXrKvoPESLA+EGWMby9CxgrmQyra6yNwOVgVzLAMMdIjnCAY
         iJ6lfeYWe3tZe4JeVNinF3f9uWRpAcZk+xxGDTmiU8Ux0/JeceGQI0oGur1Rjslb/fpZ
         t32R3vWimRdvvzVKQfi8huW0JQ8NAYCoMy8fdvNQdkHIN7JRWzwYXVSuorE6hPvY74kg
         5Z0A==
X-Gm-Message-State: AOJu0Yzlc8ex4Fd2+DFjERnw0r+iYJY/Hu6X4aMeCtHG2PWsPyVMaNN2
	hNkvy15NC77tYg8eUwg4TukzpNokV46MIdteypDM95zvI7VUYDbOHzw3hQGKpDde4ClIIMUsNNC
	rBC6s00zbkZ5OfcOQahJ1twa6Lg4=
X-Google-Smtp-Source: AGHT+IHklUzSN5GAGrfIXhL+7GHpLCqDKxrL42soTrN53W0dJ9GmXZdmciGciFJRKN8uKRshYY7b+CMCTSfunVN6OJQ=
X-Received: by 2002:a05:6871:e491:b0:23b:dd9b:79cc with SMTP id
 586e51a60fabf-24172a43127mr30841717fac.2.1716127270119; Sun, 19 May 2024
 07:01:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 19 May 2024 14:01:09 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZkXpbLPGgdqy6YJk@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com> <20240514124411.1037019-5-knayak@gitlab.com>
 <ZkXpbLPGgdqy6YJk@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 May 2024 14:01:09 +0000
Message-ID: <CAOLa=ZQzxax0GoCKMTNxdwy+0f+nU3HFC_ixp24RXgW0+jeXWQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] update-ref: add support for 'symref-create' command
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000005345120618cf0486"

--0000000000005345120618cf0486
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, May 14, 2024 at 02:44:09PM +0200, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>> diff --git a/refs.c b/refs.c
>> index c2c9889466..6b724343fe 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1302,15 +1302,16 @@ int ref_transaction_update(struct ref_transaction *transaction,
>>  int ref_transaction_create(struct ref_transaction *transaction,
>>  			   const char *refname,
>>  			   const struct object_id *new_oid,
>> +			   const char *new_target,
>>  			   unsigned int flags, const char *msg,
>>  			   struct strbuf *err)
>>  {
>> -	if (!new_oid || is_null_oid(new_oid)) {
>> -		strbuf_addf(err, "'%s' has a null OID", refname);
>> +	if ((!new_oid || is_null_oid(new_oid)) && !new_target) {
>> +		strbuf_addf(err, "'%s' has a null OID or no new target", refname);
>>  		return 1;
>>  	}
>
> Shouldn't this be "'%s' has neither an OID nor a target"?
>

Well it's actually all three. If new_oid is not set, or if new_oid is
NULL or there is no new_target.

I think "'%s' has neither a valid OID nor a target" would be best.

> Also, we again miss `new_oid && new_target`.
>

Will fix for all the commands!

>> diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
>> index a390cffc80..cc7e20431e 100755
>> --- a/t/t0600-reffiles-backend.sh
>> +++ b/t/t0600-reffiles-backend.sh
>> @@ -468,4 +468,36 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
>>  	esac
>>  '
>>
>> +test_expect_success SYMLINKS 'symref transaction supports symlinks' '
>> +	test_when_finished "git symbolic-ref -d TESTSYMREFONE" &&
>> +	git update-ref refs/heads/new @ &&
>> +	test_config core.prefersymlinkrefs true &&
>> +	cat >stdin <<-EOF &&
>> +	start
>> +	symref-create TESTSYMREFONE refs/heads/new
>
> Let's future proof this and create the ref with a name that matches our
> root ref restrictions, like "TEST_SYMREF_HEAD". We do plan to enforce
> those soonish, so these tests would break.
>
> Patrick

Makes sense, will fix. Thanks.

--0000000000005345120618cf0486
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 25c2ab6bad9b83b7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aS0JpSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOWxlQy80bzdtUTE3eFZsOEMvd2h5UWlmUFBYeDh4bApmV1ZLcXlZN0RM
U3NSS3FoRkxTQlQ5bnFWdmlob243OUtRV3F3b0psZmNBM1NPRVlJMjJuekNQa3FYalRyL0xTCjlD
R0llVWdsRnpHT1hqOENIaFhlN1hXaVBmT1lnNWRmZnQ5Y2NrSmdVVFNFenJ0NWxvU084TlJMRERW
MHFPMmUKZTcvc1lzMGRNUjdWZU9hcktpYnUxZ2VJdjFrU0V6UTY5NkMvTnU0L29qWnpUS2U0elR6
UzVNNFJLTDdRQnc3VAp2d0hTNmRGanpYMElCU21VSDhmdnhxOVE4MlVLOWtqN29zWTArM1FWV2N3
ZlAreFRHZU1QMWkveHRzbUNlVHByCi90aHoyWjBXb004S2Q0Z2Q3VmtobDIvbXhCZ3RBWkhJWHBh
WlZPR0YvRTZXa0p5U0p4dFRCdDhCNUhHOE8rZG4KQ2JKWlBDWEdFU0d1Rkg2K25pK0UwVEdKQU91
Rlhaa1lFTW9MOUFVOVA1K0dERkp6eHdpVlhhWWdvcmFmQ3dQNgo0clVXTGNJQk1CY29qM3NJR0xW
NGpFdHlnQU52WnZqLzFqSDN1YjNMNkJYYXNGNGkzbG4wZ1doekNzdHk5T0pmCkN3WGdKR1Qrdk9x
Q2xFYm1mM3NYNFYxVXVCZUlJbVhYTmJRTklJOD0KPUxMZGEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005345120618cf0486--
