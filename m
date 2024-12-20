Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963801A4E98
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689350; cv=none; b=sDlzeUCmFUj8+XGZqsH2Qk+rBXKVnsog4GNgIS0Jct7zgfJKVd5zz8Z1h1GpFyJjxx7RVw/TGLtUT335JKlqV59ms24mOHCuYRY/4EnzEnREtiW2fQ4t+ujQU7eU4O+ZzBQVQE1yj22d1Dns8faw9Nw/ai0rw7V/jVx+g18z7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689350; c=relaxed/simple;
	bh=pr66l0T79SwW4J5Hq+rc8NAqzoEQPsKSp43gSgiiW50=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8qEptGPwAC7Z0JAMcKnalvbsXTIY1aE3/L3LB5Jo/ox/TaytHlV+eivrPyfrBDh9JkKJwfcsVXflrJrfiPk4g56VQfe2b30R6au6roM9fqL7P06T0vGhWyucPB8zt0g4WAAA5k9XOrBfitREDTINyl9jGpyWagjnODIQ1BpPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WydxgCg3; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WydxgCg3"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5188311e61cso567848e0c.2
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 02:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734689347; x=1735294147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qOnOvIcBZ/Q9fzW+6Re/4vt7FkJqT9iGYONc20tQ8A=;
        b=WydxgCg3yUDydl4xQk7itOQiXZP3lWVWwofAlflMPwGU2Fv+Oa6knDsyDHf2B8RjAn
         i7MfDBqfO5xi0u4wGJbL1uJ5ULI+yvnEoPZ0HkJcjvoFP5bQnAByWm4gSJBtLNaxVFyz
         czzk/zSc8KB4IaUf8l5No1C+LKTY+jNilwwiAPbl+qCgx0t+GNDhWxKXRkEHk6r0XJ/m
         KTUSnnWB2uz7VPtaBrP8zwHcw8DUSkDyey1A+fFQU4f45vFYlWmMQd7VsMo1t2UK/9lR
         AtqmK1m80Xjw1eFKn7Tba8rfH9UTVn+I7KsUQx9P7AW4jI5r6BhcyVtL6nHBZTdZWxvn
         LnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734689347; x=1735294147;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qOnOvIcBZ/Q9fzW+6Re/4vt7FkJqT9iGYONc20tQ8A=;
        b=iDg8DkeFWg2ZYhN9jZTFY1VqJLSj20Xu6rENKSJsg0IbO6mbFYqBCZmOaPxkVzCp8a
         h/Q9WRwhOj0X4P8rkte8OwjfBwCQVaSkToKF2I85ODddHfoxvCmOSJ2sL9ZTjsMycP/8
         ErWFYum0xbXQqEIA5ApOj80OKbF1+HeZ4gGc3oXx5jh7UDvGsnHBUItYerIJwGYZ3sz7
         pUcGd+bNVZFU8F6ZP+f3/1/guOhV661QJDX+5RhO3eTMhZP1L5WYJgYwRMYPzkBKLJKk
         2WrIf9iKQMC5hneUCEqP8vb9n6BZwLQARXj/NkWz4fET9GOVCgU4lh8qB0c/O5N+ss5M
         uyRg==
X-Forwarded-Encrypted: i=1; AJvYcCVjKGN0b5r0JxEdnHNkbPsmuVa3Nf5K8M6N1KVBZniTrFyVNoPn2OLK3y//GHjXrTezQYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxaKtPb92NpgzCudFDciBucVPMWrHtCGvar021f/WE0n+NJtyi
	GOaoeIgQj8TDF9BOQ5yzvpXjIkconMpJAAhBOInfSpBb7YDG+s1mEWNt7qjRdvMeoH53J5/tJZE
	Vaa35kSrqExH09u2lygJsRFMd5+E2BJXA
X-Gm-Gg: ASbGncvv+alGOopNZDsuMBmvGxPMaSAHZ7pm/SHQ0rr4nZhEzF50ooVtQiHwUyyALql
	8CKfAYVD2sorvSlBGolFnQ/0zxuXHhg85rvC8
X-Google-Smtp-Source: AGHT+IGDKTGSSWIsM9aOLWEjShPDpQaIOABWoWI2pXs5Su4FG6Uti5nEHIQ/3pJS9j9teKEQUJraU2im7p9uI2xYHoU=
X-Received: by 2002:a05:6122:370d:b0:516:2209:9032 with SMTP id
 71dfb90a1353d-51b75c31269mr2161571e0c.2.1734689347454; Fri, 20 Dec 2024
 02:09:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 04:09:06 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <87bjx7h3q9.fsf@iotcl.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
 <20241216-320-git-refs-migrate-reflogs-v4-2-d7cd3f197453@gmail.com> <87bjx7h3q9.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Dec 2024 04:09:06 -0600
Message-ID: <CAOLa=ZRs3uy6ZyMeHCJUGgcDC3u9KXAymoK5SWD8_KJk3jxygw@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] refs: add `index` field to `struct ref_udpate`
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: ps@pks.im, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000059eaf30629b0d689"

--00000000000059eaf30629b0d689
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index e882602487c66261d586a94101bb1b4e9a2ed60e..c008f20be719fec3af6a8f81c821cb9c263764d7 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -1279,8 +1279,17 @@ static int reftable_be_transaction_abort(struct ref_store *ref_store UNUSED,
>>
>>  static int transaction_update_cmp(const void *a, const void *b)
>>  {
>> -	return strcmp(((struct reftable_transaction_update *)a)->update->refname,
>> -		      ((struct reftable_transaction_update *)b)->update->refname);
>> +	struct reftable_transaction_update *update_a = (struct reftable_transaction_update *)a;
>> +	struct reftable_transaction_update *update_b = (struct reftable_transaction_update *)b;
>> +
>> +	/*
>> +	 * If there is an index set, it should take preference (default is 0).
>> +	 * This ensures that updates with indexes are sorted amongst themselves.
>> +	 */
>> +	if (update_a->update->index || update_b->update->index)
>
> What if one of both simply isn't set, and the other one is? Then we
> compare an unset with one that is set? Or am I being too paranoid?
>
> --
> Toon

Those are expected scenarios, if one of them contains an index value,
then it'll be sorted before the other. At the end, we need:
1. Values with index to be sorted amongst themselves by index value.
2. Values without index to be sorted amongst themselves by the refname.

Karthik

--00000000000059eaf30629b0d689
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7cd3b9ba6eda6b63_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kbFFqNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meU4yREFDZTFJQ3lkVjBoTmVQcm5VcmwxM3lGYXY0egpHV0ZJTEE4dnBW
TW10R2UvUW9uWi9Wc0lKMkQ2SGlzMzFjMWgwbkFZanpDalpCdTJKN2ZxZXFCSGZqaFpza2FrCkJr
N0o4ZmxLVGt5N2tBKzI4UzhUQjIwL210S1FabWJMYVc2KzFnTGIzdjJVbjRoeVg1bFVZUTU0OURZ
bTJWRk8KdDZjd3k0VWZHN1ZJV3huc3ZYNms3ME8zVGVrSmNJcmU0dlBYMHlBaEppVXc4aHZ1N1l3
RHByRWFJQmI1NnBwSApxN1Y4M0l1eFJGekFjeTFwek9JM3hoUlNHcUMyZGlKblF5Y1k4amY4cHhG
c2RFenFabU1yaWdOZUlvdE1ZcXpqClBYQ1gwOEN6N0E5V2Y4NjVhcHVoaXBaMUp5NWc1Qzc5WkMx
b0JFNzBkcnp0WUQvL1ltYmJ5SWNLQ2c4RDJTcXQKSTkySHNIcTJMTEhzdWhWL04wUG9iYmo1UTVk
dHVseEhpMkRTUGUxZ3BDdVF2a0NqN1dnbzBEaTNQZksyZWpVSApYMVVLVVdEQk1ManV1V1RJL3B3
SXBzTUNHZ2NGa1czV055ZHNuZkZuTGJnUFUzOGNyUmRwUE1wWXlzbzh4MFNSClFJUnVpTitPUVM5
WVFmYzloazRlODdwd0VrT1Z5alEzdXVhU25nST0KPWVUaHkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000059eaf30629b0d689--
