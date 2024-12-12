Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2E72153EA
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012251; cv=none; b=l8374V0ySdq0HGBfxZUANW9BxJ6cesqFYOxGOHUtoEsBmAkPiTPyKCVQcJ3WTrNMFy6xrA0Z6JtSXLmR/XEftVWY36kMaZaLv58FObIx77pFKapEvbbCXSn0dP8eXu79v1j9WRVVuzIvUn+ewTLegTHxz9Y6PqZ3cRhn+274PBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012251; c=relaxed/simple;
	bh=XOekCaEz6CQusXKraz1XpvhkkRRnObzTm4/W8/7jvFE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKi+y5rzblmQleAkjHu4RGXZFGCaO77dHjvGLpV5uPY/20ZevVFMXBZFMmFi0JVaYtBdX2ac5+UKFCAijv0UPGxvxhYCg710jal9qYMlKAjkNaEeekQd+myqbWtK53gnOmB1UDjtqyitG4eSkNJNKvQzPzD79+5svv+a7R9PVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFtV3k0g; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFtV3k0g"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-51878d9511bso176628e0c.0
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 06:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734012248; x=1734617048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BPMUYoKxPRTkECgnWh65TrPb+5eWXqKJ1ZogArRskKc=;
        b=TFtV3k0gax4NXNkjIi9DV580y4+NWotbMrFAN4lIQC4Q0zAdlpJUk+R5315V08x9wb
         uUrRQApliG/D/UZxShPY0gQo1ATBJWMDrck1fIWheUtKxjxaSA43aCYPN02RTn1Y1If2
         8Cd/jAcK5EC//FIzP6YHKEU37x4B1GjASDAxuRyST77wNiaCDOGeDpgZleiu8rGoyKSX
         gwlKkJGJPiGzdgA7uJnUK8lElz+qBbnTr20yFmJWr2supUWuIMHhlFtuFikeusnZCoZc
         wEvJuG2/ocmYDGbwXN89OfaschpQnkSoK5DRLtzaadx/2RzNMSgYRGViJOMIIVfPAy4E
         luog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734012248; x=1734617048;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPMUYoKxPRTkECgnWh65TrPb+5eWXqKJ1ZogArRskKc=;
        b=hTTYWRq1NBcnghsfB4KKfze682tj0BRAF941U0VWMKwtdsphTO6U3mZ5roCloUI/RU
         WoqphkrcxI5f1Sd9jPPU6glOoATH4C2HA3nopR+G9etT6Rg71WGXTc/4W/ZAGg3JYvdu
         VzfO3Ebf6W7vNqrNe1VxzoKlNx3qrLm1mL8LTlic4jM3/mK46MWiEokNSN/5SUX4mgR4
         QRuLB0frfVO2WGVH55pvdAZeKh761cdC7HCEurha/ENp0yRMDBcb9JHp4SlWqmnpnps9
         etWJWhv1uXf5TmayLrwc/zgel6OfSbRMFrRWV3ytpxkQp8QsXju5W2EACAWM7LBOwo8c
         0hkQ==
X-Gm-Message-State: AOJu0YwKcOwJy+hscOfaH9hTS8lFPVGiL8GQYaCwL58TV/TKkUxaFGXq
	JB5S/iNvPZ4hdSFY+XjY9s8DavXLQQvs9kc1tUhi8ZYWOsMWAYrGkmaIZzlH/iL0P2L0nraji1V
	q5Pj5ubJ0zooqyRd3ZVIJdR/j4C6dwyeG
X-Gm-Gg: ASbGnculUlXu+S5g5dSYltYtn7UU3Cg+lMFCXIK1h4RD92tELQwwjF25H20NwT9kFlC
	PzX0LLj6juwCWa73hdHyB4PM20jMny6HpFX3u
X-Google-Smtp-Source: AGHT+IF2TWa4rUjJ8ia5zDxnPMcIemAmKh6Tisk4UdUC4QGVsyirlghyngMxekS6pWPQqU+HflgNiou0/uBS2RQx2no=
X-Received: by 2002:a05:6122:7c6:b0:515:3bb5:5736 with SMTP id
 71dfb90a1353d-518c588190cmr768063e0c.11.1734012247919; Thu, 12 Dec 2024
 06:04:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Dec 2024 06:04:06 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Z1mhFqmznVxObmAn@pks.im>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-7-d4bc37ee860f@gmail.com> <Z1mhFqmznVxObmAn@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Dec 2024 06:04:06 -0800
Message-ID: <CAOLa=ZROACAy2_jDSUxZ9rAZ0o7eKugtuqZLh_aWkHH6NRjdcQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] refs: add support for migrating reflogs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000013196a0629133003"

--00000000000013196a0629133003
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Dec 09, 2024 at 12:07:21PM +0100, Karthik Nayak wrote:
>> @@ -2687,6 +2688,7 @@ int ref_update_check_old_target(const char *referent, struct ref_update *update,
>>  }
>>
>>  struct migration_data {
>> +	unsigned int index;
>>  	struct ref_store *old_refs;
>>  	struct ref_transaction *transaction;
>>  	struct strbuf *errbuf;
>
> Calling this `reflog_index` might be a bit easier for context.
>

Makes sense, will amend.

>> @@ -2868,8 +2894,8 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>>  	 *   1. Set up a new temporary directory and initialize it with the new
>>  	 *      format. This is where all refs will be migrated into.
>>  	 *
>> -	 *   2. Enumerate all refs and write them into the new ref storage.
>> -	 *      This operation is safe as we do not yet modify the main
>> +	 *   2. Enumerate all refs and reflogs and write them into the new ref
>> +	 *      storage. This operation is safe as we do not yet modify the main
>
> I'd rather move this into a third step, as it is separate from the ref
> enumeration.
>
> Patrick
>

I added it together since it is a single transaction, but I'm okay with
making this change, will amend in. Thanks

--00000000000013196a0629133003
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: eeca5588eefd829e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kYTdWVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3YxREFDaU83MEp6N1YwcHc1bXREUmQ1dDVzblN4cQpQYncyVWZMK2Fj
VkxSOTc0ekpMakU0U0VacHlZQ28zWFgyMStoejVScDJpeWZmT3grb0UxVGFNMFIycUwyQksrCm13
TCtjc2dZMld5N1NuWU9iYkZwV1dZcWhVcnRtc1A3M25GeUxWeVB0RU5qTUJVL1FwQzNRNWxkUHU0
bDFwVmYKWlkvcVB0WU9lZ0ZucUpqSHM4OHBLSWhKbDc5V0h5a2hZbVk2MnR0a0RMZzViS2tuMFNI
VTBILy9PR1NkQ2xqRgo1TlVoOEh6YTlUc1cvOGdzaVM0dGVuRzVENGN0UzcwTzF3M2g5OGx0Tk53
cDUzalgxVk1Na2VFV2Y2WjFEajJ0CjNVSXFvakVHbWF5eTl1WWJRM0lOUy9oTVNlRWRiVGVKT09n
d04wRkNMQVI1M1FhVEpyelBEOEFLeENIZkFsSzYKVkpoWFpablBUNjIzYnlCaDZQNkpHMDkxcm1C
bE4vcTQ0OURZTFo2UG9kYk9tTmo2Z3IvSEQ1LzBiakk5MFV4Ugovd3NKUGZEd0lqQTN1aFlCZzM3
UlNNSDBHZ29VV1lFc1pvbWJOMU8xMndPUzgvaU8xb2xiRGNjbmRhcXB1em5HCndrMVo5K0c2WUtJ
U084Y1FPaFE1RmdodldUY0ZtalhxWFV4NVE1Zz0KPXhucVkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000013196a0629133003--
