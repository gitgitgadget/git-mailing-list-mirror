Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA429E110
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319743; cv=pass; b=ZJKB7New8iEbm8PIArqAd9Ze9FdN9Ks+//pnhoPm9UrE6bYkdxJQYGSEIGmWesYEiqYJe4NB+mVGvwh0ZonHgSXDkPPes05MG0mnfPJNEFs/55nhqnZOYXWbXIObgHWEXRZBfvxdL1l0S00LAqQWi4RQdBG2B27JZpWGUYFfUjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319743; c=relaxed/simple;
	bh=7YZFRhi9/q+Az9MOrjEFy5XnvSKQ3/cfJ4S1LsAgj94=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUiMvGd60VFNe3HLPSWS0i77Ko8Yw3tvRupjNlgCx4YGh5gYumU8O6loB5kMAIFKcjrK41ZxBoLoWrrILJZmGk+ZzXZae5RIwZ/a4cLgPisMbLINg8g6mpagRcJiAnCMdUcZsYF8z+7cASjZpBNS7BeHVsjeyoRKYzfxYw70xXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoGHZihb; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoGHZihb"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5fc456c3742so765189137.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 01:15:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771319741; cv=none;
        d=google.com; s=arc-20240605;
        b=Iu3VviaRdNC/IeI90DJTyWXFg/Kyh+w8JVTngDMkdahNQcGRoE5vtLCKdSdBFv8rma
         ZIhGAksAcYbyUzGcW4PX8kBT28tpqz4gG8bM0W/Yu4kw5DnFzkveRqnTdLrbnN18Q21Z
         zNl97lw+9/L9Oje+7NCuo00W5Ls56F8W6izF6JyipKEWwuwUWbZuWtCRMmnIK7KI8K4r
         AEARuoEZGoEKNFz9oP5937bM9IPFSHajNUA1F886j5rLbt+q4B8M1HoXixyMNB4d+/pt
         dAeUO/KYjpPbJy6vgzLfhFbAOnswSP3vmwoNF97NAe+xWN1s667jLLbXCupKVcp4gv5e
         HrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=kLR0ZEG5a0nTEPKxziz8YXLZWoNI9tW6J8g6qHApPj8=;
        fh=ty73qu/mjp6olkAb0/G4VGZeH6SWOLNBs8YQa03/qaY=;
        b=W7Ag0TJHKViNIBgkrXhAsZnfm24zP6PW3cPxerWf5U9a81Ca0NgKByMRs48f0fp5q+
         225wTtqIH9XuH0lOT7jTQzJc5tJ1imoz8p4T7FttnCwG4QQw2qgWWRmADpDUImCVBpE+
         gJ8yfQ347t7cyLAD69+7aVYPTRLknrAqRtvGuB3U6Tr4lZ7qhKqTA5dqq4s+Gz5bqSVQ
         Ogev9HFBHZDDunfqjukxFiM3Gll21LfbJOxhHJphFkEhPs8DblWgGstj/W7nt0nLzuvz
         SYhFARt0I8sGYHEukhgqt33vXa3fKtotybbnxeOhfqmT5/5u8kJJCV08fQx59fwDuhrf
         VK7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771319741; x=1771924541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLR0ZEG5a0nTEPKxziz8YXLZWoNI9tW6J8g6qHApPj8=;
        b=UoGHZihbMSpimUIiTrOcMu2oIuN2QEVj553CjazIQXUaVtzqRTuNYoHL+aKJyYnwlu
         29GsfdKDYX5hJ4gp2EjCrHRDDDgcszFgL3Nng6aAHtgabOOqVlwgx8QBnUkRDmhsx32Y
         WNNo6paKKrG+CtmgZqL0WCkWmk3XJShX9TU1swkI7lq3SE4YUMdhPr2uPLYqJ3m9y3rE
         dk6WsossPk4/PvjUMI1sXDZEO0jrnzImQz2Q9cEXW9U852u4kLqG/MJG1uI7yHjqVyak
         ysbBw2IP8FrbvOYIDovi9V1aLfMkfN96VHQtUyw9K3EbfT79Vt6mwBo4gP+Iq1q87BB0
         oDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771319741; x=1771924541;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLR0ZEG5a0nTEPKxziz8YXLZWoNI9tW6J8g6qHApPj8=;
        b=Wvzl4TFJ1S83cJQnUy+4VfKCKgzfcYJzvV07Oz8rrZZRtjZ6VtglpcP404NHlpZYLb
         9Z30cvno3un9eEOIxgoRoEN0zm2LVh8M323xZ9/REST7VNEuBdEtaMubNg+MUQ6u/dye
         5EWp0P7EBvmNJMtcPkpzTfPB6VOC7azowvzigzP2rFi9QetsXyxkTq26dUKmOXYAw5XO
         D1Z0s1gloPqyaOHgQINHWxOSvx4VQqoSKfDKOlKCDEY5O43EkH+Il6uJL25RzK7qLAkr
         7KbcjLEAxjlrwq/AfpqLvZr9UNKAgwwsmRcVGYgrgDWEUPvARXAU5WJ3QH0wBRVv9knJ
         3iOw==
X-Gm-Message-State: AOJu0YwKWw74KGUW04VYEhKXcx2bwOhuEi9+WnLevkVY4ua5FCEW9odY
	9Kf4a6Ql9SELdLHVvfPBVMjfCX3+H85QMFGJA/bo00wQ500mD26rppmNkv4tvkeYsIfF/sqaWtZ
	aitAeqdOQafcjaRGmqIHJ28KyA5hkip8=
X-Gm-Gg: AZuq6aJERdTj1S76scCeL1kto36ZWxJ4VzIVMcH7d5+lGPJgNtFDoB3QW6ELIAj0x13
	4ZksAxvhugUFzeTZ2IUTTxTSCeMcYuGWmLzNjGJLYeLage/XbQFQBJJvSH1tFKo8TpOBKYtFzlY
	PqKYgLUuP8y4Yw1JMO8zOMpLRYh+gC03zG9pNHvoiWmeFIc1NctsOTFIAuisWawzQZMCBPAOhBy
	FTb9wnLDFsEgdSiZfuz7rZyEfsIsVOPiPde4VOCrmBdRWJBGSpIV4jNpZaZ36HBkKbiLbyc163z
	Y96hEFixN1UbvP9oBxJhYkY/yc4uCkHylru6G/fpdw==
X-Received: by 2002:a05:6102:26ce:b0:5f5:40e5:24c7 with SMTP id
 ada2fe7eead31-5fe1acaeb26mr4083385137.7.1771319740870; Tue, 17 Feb 2026
 01:15:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 01:15:40 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 01:15:40 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aZQXmvZbVT1eRtSH@pks.im>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
 <20260214-kn-alternate-ref-dir-v6-1-86a82c77cf59@gmail.com> <aZQXmvZbVT1eRtSH@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Feb 2026 01:15:40 -0800
X-Gm-Features: AaiRm50A_tQnJ2n0oiKNk_JmAM8yFyRjtfbC-ZG1P_X_b4ZEGePsWlYzHJ9cYUQ
Message-ID: <CAOLa=ZSo-2uG5dctTJAww9Qg+1a85+PJ_Fx7_AggbjLsTxD6Lw@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] setup: don't modify repo in `create_reference_database()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000f04b36064b0183de"

--000000000000f04b36064b0183de
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Feb 14, 2026 at 11:34:14PM +0100, Karthik Nayak wrote:
>> The `create_reference_database()` function is used to create the
>> reference database during initialization of a repository. The function
>> calls `repo_set_ref_storage_format()` to set the repositories reference
>> format. This is an unexpected side-effect of the function. More so
>> because the function is only called in two locations:
>>
>>   1. During git-init(1) where the value is propagated from the `struct
>>      repository_format repo_fmt` value.
>>
>>   2. During git-clone(1) where the value is propagated from the
>>      `the_repository` value.
>>
>> The former is valid, however the flow already calls
>> `repo_set_ref_storage_format()`, so this effort is simply duplicated.
>> The latter sets the existing value in `the_repository` back to itself.
>> While this is okay for now, introduction of more fields in
>> `repo_set_ref_storage_format()` would cause issues, especially
>> dynamically allocated strings, where we would free/allocate the same
>> string back into `the_repostiory`.
>>
>> To avoid all this confusion, clean up the function to longer take in and
>
> s/longer/no &/, I assume?
>

Yup.

>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index b40cee5968..cd43bb5aa2 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -1442,7 +1442,7 @@ int cmd_clone(int argc,
>>  	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
>>  	initialize_repository_version(hash_algo, the_repository->ref_storage_format, 1);
>>  	repo_set_hash_algo(the_repository, hash_algo);
>> -	create_reference_database(the_repository->ref_storage_format, NULL, 1);
>> +	create_reference_database(NULL, 1);
>>
>>  	/*
>>  	 * Before fetching from the remote, download and install bundle
>
> This is case (2), where we set the ref storage format to itself.
>
>> diff --git a/setup.c b/setup.c
>> index b723f8b339..1fc9ae3872 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -2701,8 +2699,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
>>  				      &repo_fmt, init_shared_repository);
>>
>>  	if (!(flags & INIT_DB_SKIP_REFDB))
>> -		create_reference_database(repo_fmt.ref_storage_format,
>> -					  initial_branch, flags & INIT_DB_QUIET);
>> +		create_reference_database(initial_branch, flags & INIT_DB_QUIET);
>>  	create_object_directory();
>>
>>  	if (repo_settings_get_shared_repository(the_repository)) {
>
> And this is the second case. We call `repository_format_configure()` a
> few lines above, and that function calls `repo_set_ref_storage_format()`
> itself.
>
> Looks good to me, and a nice simplification. Thanks!
>
> Patrick

Thanks!

--000000000000f04b36064b0183de
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 139650faf76d02a9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVU1ib1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOWVZREFDTHpIOTZUdXQxWVFWOXA3R0h3SE5CQmI1aQpBOW5Cankrck9U
Zmk5ZVJkMlZCTHZja0phWVA5Y08yNXo3dlF1NUNxYlZHcEdGSWVTY293Q0RiU3djeTk5QitECm03
RkJ3cTFDMzEwb1F4QTVlRzd0Mzl3L25xV0V6a3k0TkRGN2Rob3JEMXE1U3gva3Y2L3RoSWR6OUdP
Y0xJTjIKMUJmWG8xV2M5bGtBS3dvQWNzUkdzT3ZpOWJUM1RSek4zblhpSUgwNy9wKzZ4NEVabTJw
Qyt3ZnRQQkFTTnJXTgpRalduc01nQTgwQ3hDV056MHFhM3dyWkk5UzRPQXpXcC9SNHA2R2FraGdK
a0dCa0JxZTE5SzFGb3ZWazZiTHRoCjJkcmd3RXlINXU1MmFyamZRMmk0Z2YyTk9oeElCTmFPVXIr
QjB3N1ZjQmw0RXRjRE1LdkhrR0NCYnNYVElrRmUKZVA4eTFYais5ZlV6c3pkZERwTUNOenVNTFN4
bFZLOW91cmM2NkVObUhuSHRhczlOeXV6VXNOaGh3WUZaeTFRKwpWSHVJVTJkVFNWa04zeFlFNmEw
TTBqM04xeHI2aXROaWJ5N3ZnSEwrWWNrODhpcCt3UUlRQXVRY3NYVG5jUWF5CkxUQjNPSEFzd0dy
Q3lVYkwwbjBNU21jcUpvaDdwVGVxYmVrUzFnQT0KPVFaN00KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f04b36064b0183de--
