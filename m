Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2678B3E49E2
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216998; cv=pass; b=GtozDO+e9/d3Njz3YcXALT4P8Io5t8IbweKGJuJyEUJFMCw6zr7ocNRIABGswCJ5i3zKMd02sNhX2Waf/aCqkIo6htz/BJfchyymzELn2YCWfd0VmyxhRTH8Jwq5AvlHxa4FVFopAbaDC14aoBGkpDpijYGdneRrcqEN+EDCTQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216998; c=relaxed/simple;
	bh=KXFdnZCJ4M5QarcRtRkJJrkRGL5TL261WMxU9XtR+BA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3n6fZLGkbqdVdK/rei4zhbYHlaaWVBwh/YFuTccYs6/26rKJEbHm0Sg/aqqSo1Bq6uN8IYnrnqBSrVVViDmEeNaAoGSAxnfVYZl3yUZ/wvCMkzDc+DzTSAI2haaeL9AQIFnvHFjFYnpphWBMYuUbEbiLP/3DE7LkMOsQAVqvbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTc95jD6; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTc95jD6"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-738bcf9a573so779633137.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 02:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787216989; cv=none;
        d=google.com; s=arc-20260327;
        b=B1ioMUDOMT2CNTuG9wGNsA6BvJSN1rkmyODyNUbiGMfevjSvhVzlQzoZ2yZHZcha0y
         Ufd8ZGrrwUFkNKJOOhey1RpTqTCt35JTKz6BKnXAtbBrHf8rq0rpsyf4NuR4bUDmHasW
         +aWHmwa2cjlQdEzQWMoJ3RM+Fv05ncmDVIRT/GVBcm0bHr6HZeapkrb8XPcNaJm7eUtB
         iIT9iaAE6gXNV/aARznD6z1keMNeL7RHwXKTDZvzg/Uj4VbeffWg0CmVBq4oBlcPWDAs
         90dgc9yHjQ4q2E/SrULok5XbINAaHDwZJtxCLff4tlO3XQhuEtQyKKiOriwchU7BqO88
         uReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=XNzQB/kkH/v67coDIua1OLWw3MhO7HN4Xc2T2eBeXrg=;
        fh=kThQeMxMDZ0qhIzhbkzyB1Ui9jm9/A2XAUvrPU7sLo0=;
        b=AuOuCBUzodTOnlNb4KMJws09MNe2pGq77jOkDiAVi4c8k//z06D0O91Nr8ETGToWeJ
         mGQWUCgfC0i2dpdmlCu3sj7fD293DgcnPPzkUVLaIGdh2sYuUOWmzW0BqfS0+Hnz3Jeq
         umNj7tgP4OAHqzcwMWGwoZEFr/S/eBUPb36RuFoABiGvUhMc/WAGNvdRX9NAZCoZjHSK
         u/IjJBZwQZrOXvaZDMEPAdcEsG5KRZuL59YvyDt+cQYMpT1FUOBKnL9YUAhaJz2HkyrE
         6E+q2ggvN+hFBTvBefSKebePqicCNkh1UMllT2JYsIO+9yh3QQFlQuGBsvs8ZQYC/aDI
         61pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787216989; x=1787821789; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XNzQB/kkH/v67coDIua1OLWw3MhO7HN4Xc2T2eBeXrg=;
        b=VTc95jD6M8RG3i2ZiH7UaHaC7v/r3HtcmXw+iXvK4z797Gz6+/YJ4gkBIwv4AiWoRl
         +pxX4+J10upBn8ss2U6gxZ6j2cE7sauzx6PsMdre8w/q6KN6sZMnTJkR621zQ598Ao/b
         YdV4Is3n5dqFVMqEGy3fF23XwPIdxPX0SusF+bbMTT4YbVmJupjWTQaXc5xdUCNPw0mo
         948wkmmcBA3j7Dw896frVil4bFqxQictws7achBSynrPx4nLX+wCDgENuKcXc/nk+KvQ
         IUnCpJ8jF8kBQsIZDsWyButyAYOx1xU/CtsI3WcdPlK5GMVTs05XIPn0q3wkIqxx9d0u
         LBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787216989; x=1787821789;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XNzQB/kkH/v67coDIua1OLWw3MhO7HN4Xc2T2eBeXrg=;
        b=GrEm7MuG+BhF7MbFKk1Ic4rrYmyv5feUCDvK0DFxDZ8zv+dJwjot0lEf4X5du5n2eS
         8jppw3i7QWn719vxeDWs2hJnYLz9fZDbQTXBe+LBPITi2hT94e8BDqoKNxCO3ysmcrxY
         rCF9Bz6Z3u8KUiVT/byjF3e6Afa48ES7Y/spcg3lW+4YoT7gkSYOmyhLzcYyLpWqm0UB
         cnuV6CbDB5eYAiNe4PUIVrHz2W+dMw1e9B/ueBf43LnzH4jsu9vDK5hKxu7CHwpCB4F5
         mzL9k2EMs5e7l8iNiwLJUUcnmzypwVtyE1oIyORfg2c41D46hj4y5QbSZj0yZQtkdcqw
         CdPg==
X-Forwarded-Encrypted: i=1; AHgh+Rp8umPMi1NLKL1ftODV/+WklIhcKo++MxbCmdidaoJKQuB2c/+reG8am7WIrjLgLxmxASc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwweC1CHNmKeEBz2sDqvQGXELJe9rzqsb9KwzuEUWFaJawoDvjz
	7xCcWjL5KCgW2CkZkMI2q2rHp+yoIl9v3KBsAWsMulZ1+schh9rP9Nzwua8xqjSnF0JOXwzm/re
	gPx78tMCtDhOaT50sU9E19qYZ/sdQUVE=
X-Gm-Gg: AR+sD13N5OTMsYMrg7bjUz0FdKsRLRSjRCMXs8chTJotz+ApdeoZnYJbHE/ndq7IyEW
	DFjv9kFzXSoI0YqFNH8iR2edpZ8q9jM2LynrnqYIpZndWFpQuKI1Hsy1iY3V++6OsMyEXKBIByE
	zYXxfM6tsXkBYtXiAkRtmYv6czCrH+zgykjvlYdHDxg3QRUxs0fkF9XXhCGdL7ONRcCFNuD8qgu
	KRFSXg7WqsRunAOz3aixx/QsCQXXeS6SxhwsHCf/0iH5WGTk4JavFyJ9V8yjDbNbp1FU+Hu3Bln
	Trd8ZgZok24KrueZeDpNxc07p0wY0HOGohxu9ogzHyP4tEDm3ByYM32c6Kiq/UsTNNDiXEdaXEP
	4XsIch+vsvKRW/lfhbG5ieHDK8lT3vi/9
X-Received: by 2002:a05:6102:1611:b0:76b:12e9:a442 with SMTP id
 ada2fe7eead31-777f897e746mr3455485137.1.1787216989567; Thu, 20 Aug 2026
 02:09:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 05:09:48 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 05:09:48 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260817-pks-odb-eagerly-prepare-alternates-v3-1-1115a7e02467@pks.im>
References: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
 <20260817-pks-odb-eagerly-prepare-alternates-v3-1-1115a7e02467@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 05:09:48 -0400
X-Gm-Features: AcwNN1UHVnz4uBNczlAr1yOTTZs9xZYWvXMRieCOKqbmSQjaGwL9SAHzMIzBCfs
Message-ID: <CAOLa=ZT-ObRJ3t0XYAkL33CPDZ2ULu_5M7c477rr0pZBqTBi9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] setup: create ref and object databases after
 config is written
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000ccef58065976e1b5"

--000000000000ccef58065976e1b5
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When creating a new repository we create both the reference and object
> databases after we have finalized the repository. This ensures that
> those subsystems find a fully-configured repository at the time where
> they are asked to create their own on-disk data structures.
>
> There is one exception though: while we have already fully configured
> the repository at this point, we haven't yet written both
> "core.sharedRepository" and "receive.denyNonFastforwards". The latter
> configuration doesn't really matter to us, but the first one does as the
> "files" object database source reads it.
>
> This doesn't cause any problems right now, but it will in a subsequent
> patch where we will start to read "core.ignoreCase" when creating the
> object database. Move the initialization of both of these data
> structures towards the end of `init_db()`. The only thing that now comes
> after is status reporting, but that's it.
>

Okay so this is the new patch in this version. So since we now read
config as part of object database creation, that means we would need to
know the value of 'core.sharedRepository' and that can't happen if the
odb is initialized before that. Alright makes sense.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  setup.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 20d29f31f4..d90654f584 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2880,12 +2880,6 @@ int init_db(struct repository *repo,
>  	reinit = create_default_files(repo, template_dir, original_git_dir,
>  				      &repo_fmt, init_shared_repository);
>
> -	if (!(flags & INIT_DB_SKIP_REFDB))
> -		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
> -	create_object_database(repo);
> -
> -	startup_info->have_repository = 1;
> -
>  	if (repo_settings_get_shared_repository(repo)) {
>  		char buf[10];
>  		/* We do not spell "group" and such, so that
> @@ -2907,6 +2901,12 @@ int init_db(struct repository *repo,
>  		repo_config_set(repo, "receive.denyNonFastforwards", "true");
>  	}
>
> +	if (!(flags & INIT_DB_SKIP_REFDB))
> +		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
> +	create_object_database(repo);
> +
> +	startup_info->have_repository = 1;
> +
>  	if (!(flags & INIT_DB_QUIET)) {
>  		int len = strlen(git_dir);
>
>
> --
> 2.55.0.822.g20453c30eb.dirty

--000000000000ccef58065976e1b5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 553c0bdce7d4b9ac_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xR3hGa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzlPQy80L3puaGlRZ1draFdudU43M0VRNDlTb25sbApvTzFBQ09YR1JZ
dTRkVCtQb2MybXcvN25jWmc5K1E4RWVPQjI4c0tNWkF4UW1FdGc3eW5qSno1bEJaekRsTDlhClVY
eUc4N29NbHpiQjlmejZ2OE1jbHp5S1kwMFBaWXU0MzlnbitCdGNnbU8vTUQ0cC85VVdnTFFGZ2lE
amhsUlkKVy85aytuVTBYR0xjWFd3Sk5iVmc1azIrbWdoQTN3Q2o1Tm4rVmdnVWFUZGd1NnA3NFMy
QTVVbkRVMXFZQ25UZgpadmJXRkdDaERaZUR2d1RNZjRqYWtqb3ZnRUE0eW1DeE81L1FqRHNlaWNw
SW9FaE9FRFFCenVmRWVHTTExNnZvCmFxV0g4VjA2aXdqdnc3WG1JdmM1SGtYZ1ZWSU10YjhiaStC
YkppN2dBZ2N4MXgvOGxmZEdzSU9KZDFZR0hpWXIKaXhPNFBXZ0lLb3dHa1dXYzJISDZPaTFuaUxM
WVd6KzJqbTgwT1FTdGpwdUZacjI5SHUwQktXYk1jNENucFlOZgpoZGJqa0VRbWpjS2x0Wjd1bG1Q
YmIwdkZGRy9kbS9BakhONkNENVpoR0lzUnZKcG5qNEEzU0dMOXFuQWJ5dEZ3CkZ4Rk9kUnBON1Z6
OEhMRTU2aDZLWlh0ckZTWGJoMmhLRjVCQWtqTT0KPXZQN1gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ccef58065976e1b5--
