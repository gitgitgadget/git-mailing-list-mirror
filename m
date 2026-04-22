Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C1C3D1711
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863600; cv=pass; b=L5V/C84G+xs4Fj2W0BNKB24wivtRfVsMk+c8uNA74dQ8BUs0lRvKi9DxUESbZtI/QN8XYhFnEJyIWkfvG5ayFZJskicNOGSI9fAv+Y4iVARBbmTYGjtyBWNOS3jMpbhP0FN/A/cEfzHsr4sOB4a7nTGE2WEfZFEUwE9Jb6saC3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863600; c=relaxed/simple;
	bh=02gnpT0gJwGfQkpyPwOW86EuljTjkkHJzEY1+wQkRhA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuereVVhpJyn0PVSzEAMPHwxDxBsS3JMps+0Zr+sEXOkqJgj+HmFcx6nGLdwDNE9M7UtbCxmIC/RoDLELbilG9Qn+I3YEL5KBY6E5SmRVSd/FY6Rgn6XuZQICDDnNMib7GEDjGAucmNvDZH+QkmtJGmJgS3VXndEws9yoOSYEXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/w4SKh+; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/w4SKh+"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-60fbeeeaa7aso3130244137.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 06:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776863597; cv=none;
        d=google.com; s=arc-20240605;
        b=HrZj2oq7FPzkWj1i+8Jc3MvZ0Wzi2evyknWe5Kg6qA7xOAtBFghKmsv/M3eS6enlIu
         lmpn+8RJLiHOkpA6QK6/UZYuVUCF30zjMVrLbQjPvRQjjjLQJDvREfTbE1+tAG3gd5P8
         OzxL1s0an07x0+AV7bSPFiZWdeCRb38G8CTslsrYrJt0Q8rDd7pNW2f9iHDDtX47SggD
         Z5XjEBB72X8wDa6ncNtKLvrPqPrnNkPZhPGpKOzdKErq6+lx3I6e+Fi4D24NucxpNeCe
         5ywqCXBHAM2NXsVn4EUfAqLnBncE1ZQteDFGQbE5f8bZFpNadiHQmtoZ3SBaiSxezy/Z
         HIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=NCxzUirgBNrH2khmxprBDuf7PMFWZteeiLxZmgNUUzY=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=f6UqLvC5FRsSgqtEC0n/5lHtaV7YvdScm8YrFGrtxjbxz5xib/9ycesI2GDG2ovag/
         Y0ViydiJ2PxniKhclI23IFTYNN18CbKpN0gfod99YWETGSPJJ5R7lWoOXlkLzySBGIMW
         QHKCeYarzGi82lo5Y1pSldkryVLy3nJ6+jtPQJ6o4T7CV+QSfoqU6J6lazMqFuhwtVbc
         e8uFy1lIRcbCdUg+oOrmxb7Us4RU7lSmy6zlVimzhjvGcUxxqBgW6pKpfFptCnOYnwma
         uNOpEoHroQWqVoVfSss2UYqota6wUVECCPKnM4KRLNPA77Bqn5h5kWu7aIO2mhHGLnUF
         E0NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776863597; x=1777468397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NCxzUirgBNrH2khmxprBDuf7PMFWZteeiLxZmgNUUzY=;
        b=i/w4SKh+IclyuyHbDQ7Uow9XifCWPciz2x8Fwtf2IRRAoZ0CPyNhAjola4cHDWd0Pw
         JxSvtpTeuVHVoORWY9vCmUxHKxUTttZ/23p+AwyWsFr2AhAPVlxK9fXnkGdhVhsWedo2
         BTeUo0OyDTIwZoS4QhL2OsTaXyLvJ0AK4trYC9D/TaGGPW4cuaDJTIu7XzuYzVkfnSJq
         29qV29jGsBmjXSg033ApAeC8QUkyvLdsm1eFEqRBzRcdXKXrxboururPjxUCSAv2l6bb
         qa77D2NuHdI5zA31ExIw98G5NrJiQXOdXYhwX3ruNfigJ3WOiEH2Gf91RqNQMNGsTDaX
         jtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863597; x=1777468397;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCxzUirgBNrH2khmxprBDuf7PMFWZteeiLxZmgNUUzY=;
        b=S11rM5aR/7+q3dzCgrqeajNonXS7qbiSuShgqLrp8UHjS7U/JiwSaU6ZS1asI0Iqwj
         XM46DdCLb2cFEd5xHWwnTLCFjrJvzoz/9MJ3TC4QG3lvM3H17n9eY6BOCavR5zCB/mc0
         tjW3E9pmIxU2EwzAcn4ynK5m38psRK3kXODoChtsQc3/cWPDsEGP7gGzNDq3t98cxEbq
         poXe3EemoAUt7WhWVw5HKekvUj1oLhLMOHUEjQl9/3ehVFFKPG9a+pRdrc6S300qV99I
         /+7fykTx3FrxFdJwgTQ4bhThlEGUmE3QWRG8H9EFjaKGwF7C9BIQOJdNPTAO0HLLk8zt
         d8Rw==
X-Gm-Message-State: AOJu0YwY/lgTgNgFoOT7KgtchXWOTy834uwlxIHj6yhpY6aagTMeaWEi
	DN6nMizCFZVl9Bo8dgJa2ih9WGy6pYx9SW3Xceu1OP6jgHBx2d6uJzfHMb0pKEKz6RjnhsHggEg
	8XxIvIuWWAiWJjqL9kmB6eZp/HyDwXB4pUQ==
X-Gm-Gg: AeBDies2JRgdD6FUp9637RvqVWgxNcL9B+ekRbXluraHJ6PTuRl8kPeJv5Dwjh8bhp0
	n+x2DzrAthsMLOQQaw/+hZv50I162VEilmrWRko2ULX97BpiUySnZGRNOzJlIr0JGJA7WQHZaPy
	ayKYJdTRKFA+3RCKwwmDjhf6Kxj6q4/eiGautWWwojC2oC4pruxXcY+Gw3xn91vaar+ExLBGisV
	XUTpg7KXbiRvf6LzjT8EJv7XMnu+R4zyaCgDjzj9QD/V6o1dRwLMX7WXC3CKXHsxhAADmAjXhAD
	7wm4KqLBbwXbA/DB0+9EaUHRb2zODoQXjC/rk6QLOp4VN5NEo74P
X-Received: by 2002:a05:6102:5110:b0:605:42a8:940f with SMTP id
 ada2fe7eead31-616f7c4b535mr12112904137.31.1776863597496; Wed, 22 Apr 2026
 06:13:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 15:13:16 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 15:13:16 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aeit0pw44IxBfc2J@pks.im>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
 <20260420-refs-move-to-generic-layer-v1-2-513e354f376b@gmail.com> <aeit0pw44IxBfc2J@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Apr 2026 15:13:16 +0200
X-Gm-Features: AQROBzBNNu4SdsWz9lY7Tqgw4oWwLKesFpZxzmZoiOAnSSzW33KdkHkzns7gYzM
Message-ID: <CAOLa=ZTvYEzFrLCgJm6hVXUppHKCwPBws9eZeiBYbx2o8EaT_w@mail.gmail.com>
Subject: Re: [PATCH 2/8] refs: extract out reflog config to generic layer
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008b5e2e06500c4b01"

--0000000000008b5e2e06500c4b01
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 20, 2026 at 12:12:00PM +0200, Karthik Nayak wrote:
>> The reference backends need to know when to create reflog entries, this
>
> s/this/which/
>

Better.

>> is dictated by the 'core.logallrefupdates' config. Instead of relying on
>
> s/dictated/controlled/
>

Both of those mean the same. I guess there is a negative connotation to
using the word 'dictated', but that's present with 'controlled' too.
Perhaps 'determined'?

>> the backends to call `repo_settings_get_log_all_ref_updates()` to obtain
>> this config value, let's do this in the generic layer and pass down the
>> value to the backends.
>>
>> Instead of passing this in as a new argument, let's create a new
>> `ref_init_options` structure which will house information required to
>> initialize a reference backend. Move the access flags here as well.
>
> I agree with this direction. It's also something that I'm doing for many
> callbacks in the ODB layer, and I'm moving more and more into that
> direction.
>
>> diff --git a/refs.c b/refs.c
>> index bfcb9c7ac3..aa66c6b28e 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2295,6 +2295,10 @@ static struct ref_store *ref_store_init(struct repository *repo,
>>  {
>>  	const struct ref_storage_be *be;
>>  	struct ref_store *refs;
>> +	struct ref_store_init_options options = {
>> +		.access_flags = flags,
>> +		.log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo),
>> +	};
>>
>>  	be = find_ref_storage_backend(format);
>>  	if (!be)
>
> Tiniest nit, please feel free to ignore: we often call the structure
> itself `_options`, but the variables just `opts`. May just be my own
> preference though.
>

Let's make it consistent, I'll also start using `opts`.

>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index 2d963cc4f4..eed13af4eb 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -385,6 +385,21 @@ struct ref_store;
>>  				 REF_STORE_ODB | \
>>  				 REF_STORE_MAIN)
>>
>> +/*
>> + * Options for initializing the ref backend. All backend-agnostic information
>> + * which backends required will be held here.
>> + */
>> +struct ref_store_init_options {
>> +	/* The kind of operations that the ref_store is allowed to perform. */
>> +	unsigned int access_flags;
>> +
>> +	/*
>> +	 * Denotes under what conditions reflogs should be created when updating
>> +	 * references.
>> +	 */
>> +	enum log_refs_config log_all_ref_updates;
>> +};
>
> Nit: it might've made sense to split this up into two steps: the
> introduction of the struct, and then moving the config in there.
>
> Patrick

Yeah that might be better. I'll go ahead and do that.

--0000000000008b5e2e06500c4b01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b5e906d3b09b3512_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ub3lXb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOUNlQy85UUFieFdsS3JoM25tbGJtR05weU85bEM2VgpueHdTUE5aWUFJ
UjBHMVc2QklkWWt1UUdnTkdZVmplaDA1aXRoSHZ3STdIVlBEVFIxQmszYlE2Q2lHYjI0MnpXCjZj
Sjc5ZmRPcHpVSmhBTS9vdUVyU0NvaTJXT2x0eUxLQ01xakdYSHRmWDc5eHZra2JXUjBiaHh4MmtH
enlabDEKeDZUcXYyQ2dJRDNpOWVQejdTTitXSzhNTzhYeUcrWk1hRlJmWXdKU05BVEJVNk51aE1Q
UjdvYlNKN3FwVFNGYQpZS0lXOGVKV3V2OUYxdVBGT3Z4WU9HZ0lrc3loVldFa0gzamlnL1AyeGE4
eVByUkRzRDlpNjFpcURQaVV1TnhECmlGa0psRDErUDd0WjJtYTlacHZpUUxDdkxjWFhiRFdUMXdp
d3FKRmEyelJpNTFMV0NoUHczN3g3bjBpak5tdzQKTHRMNUpZRGNCbEJMbm5BRmtvMWx6MDBWcEJm
cmxLeW9WOHQ2eVk0a2NKcnNIL0Y2bk9HbDhTaEdhU29zSUkxcAo4cVlUOVNPSmlVdk4vMUhTa0F1
MklBaVNsMHJ4Q0ZHcitWZTQ1WVg3VzdhMGVzaFJGbTE5eHZacXRsZHY2b3JrCklFTGd2clVGMnFk
M0tiZ0RsMS9SOTB6N0lTZm1BZUdqbHRUMVRIbz0KPWhKUEwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008b5e2e06500c4b01--
