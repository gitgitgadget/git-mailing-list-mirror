Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04438BF81
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490993; cv=pass; b=fM4owIo5jFKIgNqebuydMXYHMYgrXYkYoHN/2sNVjmmDo2G8YT0JEfYxDoNuLcYvXy+EUai/3fU1klTdHXYjTeccrKAaJgIULRN9cGPvD5ZHvsKH72Uo0Sbf2JYPgBT6LXl55enEF26xjCO4S1O11aK1nP5lN9iL2xreHnUjUOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490993; c=relaxed/simple;
	bh=lcCYIP2GMVcw8kRw8YGh0HVrybRzxsz7C4XCWFAHvg0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2Eq5OjZYhozGryn65nRPsL0014aRHcSSmVwHlLo49pnaC9DyjmEnN3OiT+8u3mqAE3JSTmkpA1ShSGIoJuFcaAehzP4RwYwq/s857zEU/Z86UKDgfHU5TUjzJX7KpdTEOJ426YRO8vgZbwJv3UFtsXMh11RW0g7IcTdzZf///k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4BHYgPD; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4BHYgPD"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-59f8a140a51so2475842e0c.3
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 05:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780490991; cv=none;
        d=google.com; s=arc-20240605;
        b=ZnsKpElXrhKnyKJ59if2NvUiYrQDNBV1wJXyLDhAwc0QAkmNk4lJo7KZsJQWtJ+u5S
         QCiyNMpIgf1FTobHEbzfiEmfmWuG3T9FQjgJkNTIzPXEk3VBM0mL0yNOkTf6veNiW5kI
         zjEz9Eog3oO4yWoAx5udM3fSYzFrQoqlSkGDRfNtoVINi3HomFIQUqaMmHKozPBPHDEc
         mc66wEP4KWnQ/A/vnq1RnBbz3WDpel0d0+0c6fXbS8YymR14SbnuIT6ZM2UWvfginyJP
         oC/Ua0wjokYRzffUb3E3tclIAPCiu7eou1tdtC0hMFpvuDZ8ZmGKKq9uwGLM/czyx0Yw
         Ad9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=G/IGzEYiasWtNbWCzqzYW3S0N3MdswFC2EvPXIhVcBA=;
        fh=49VGfZHVLfTuku8qiFXjqs7RcisoAHlA80cEkO7jflw=;
        b=MKNZ1J0JMcQ33CzWrMkn/vzyyUBrUqszC0fSFqM7YD0r3IIyjl/+quSTr215HZEFCN
         6E2hy72PnQQRDU7WulwOLNwmm/4HHsMpDjlyopvzn08dUZC6UTCJCuzglXR9hV2cVRbq
         gdrN0bxHIIGfYl7v4A3CpCEZk+FQENcjZa2JszWzSoH4lZnBeY0QvoxknNjXpsI/7Bn4
         ID5B6cxYEOPJ7kTQzobb9zfVpi2fjl/MH8i0pnyTaey9ggIpQDc4Gd91fVr1reU6Q3F7
         0OZKIB60JEi1/Ddf4NqErvRvDv9jI6Ey9sOxInc/0nbG8TTMGPhYz27yn9ic+ThaHJSp
         6XBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780490991; x=1781095791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/IGzEYiasWtNbWCzqzYW3S0N3MdswFC2EvPXIhVcBA=;
        b=P4BHYgPDWovQ/k3g5ckb/2BQv7w3CVkTdoyvtCJB/jrdu1IcJJTgbNWVTlP71Ord64
         MeF+aVOIOrC8IzaVB9JTee0DEbsAHKZTdmOm9vIqC3KSEbSqjkkq0u94dzB+xvqyWIuh
         uYKk47cVz1cvpsddL6OiMCO9nUquGW6PiHCRJvWOFd3bppwdRa5R6kDALpLgCXooiUPt
         Wfi0nxjvkIba1BL3+RJ8cEAFKQXnDw1+Tl9O24k+s9rAH0W2DsMmXz45z/qEqoqg6OZk
         7ejwR5e51JoZG5fXMgmRMPov6HPnunDuvjIe7VK7H55NgSHkRRTeEWNCAR4XITnv/PmO
         r7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780490991; x=1781095791;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/IGzEYiasWtNbWCzqzYW3S0N3MdswFC2EvPXIhVcBA=;
        b=fGQ9ppNK0yfpFXtfTWJUUIuMxSyQfaO8Tl/RO+uQzTz3Cm1SE4QciwswrOzkIIVL9D
         ny4ZC4YDVjSfoWoeaegduU+X3QmU95KD7xImgHbqnAS7UvIVpzsnd7VzfUuLgCNrE4VV
         U9amYU8nn1Om0oomicbe/oHKdiaQabU+AV2e0vvzGdA3eXEvPkvEeSMmw+vTbiy7tUzy
         tv9C4kdEda6y3VW9j+1h0OCyKUpNmfOukAuEU5TkCTrZa56s/L4qpne/wQgmnXHvtWVH
         BLhk/4bUis4sq+k2ZLC4s45Bw1kFgYowOVB+HJaOiW6qTLFrniz10E9PuVu4VIKd7AdI
         YtOw==
X-Forwarded-Encrypted: i=1; AFNElJ+Yym5PawC5utrjFowVksVgwdBgmdozUgqwotr0g2FOFpJM6m4HMsxqGgsLti0f919GBlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNaNHcWhcn95Rz7vSUUXDdxKDqFXSkvDOUusAgqGdjjVfOazNT
	lryfxH/l+YBK/6EpYuSV/1lyRdDXpUhVSsr8TkCEhG7f3SbuELMt66YBvwuaRgNCibSFl278B/J
	bxpv15vw48Scv33g2gQ+hpoM7XwY2G4k=
X-Gm-Gg: Acq92OE7FXpsswAKpNFgx/nyBQ6raSVL9HuS0HCe80eTyNr75vNeUCFY8U4jmcttv8S
	GZaUgGCEwhMK/tB2jjPJjZWwypag9cROolyvC5xDg0onq936JrH+/k/T9Z/m3FJVjlR/V32+con
	GTBFsN3NBwGHzC8wOnlQL+L8FzKJ9Ihg8tEGMXZDmkB9UvagkhjvwFDgJaw7EWLb54uT+YPvfCj
	rqmhLLqreunt7OMZkYlDbq7xtBX1JIBCxVK676IBQ0KL3pMBbafl39eN9LO5Lai1ieQN+NMMSLX
	vgasqhMP5nYsDaOfKbZp9IRvirq3Gu+39q1O2wLxd8MjI3Bxma2ypSBN9b2zT+soncpMz/jztoP
	0DzAGP8BT
X-Received: by 2002:a05:6123:110:b0:575:178f:62d2 with SMTP id
 71dfb90a1353d-5a6e97b1706mr1784519e0c.14.1780490990705; Wed, 03 Jun 2026
 05:49:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 05:49:50 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 05:49:50 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260526-b4-pks-setup-centralize-odb-creation-v2-4-2fa5b385c13e@pks.im>
References: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
 <20260526-b4-pks-setup-centralize-odb-creation-v2-4-2fa5b385c13e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jun 2026 05:49:50 -0700
X-Gm-Features: AVHnY4Kk71-Nu_7ARItDutxDDhiihUB6ANY05vxCwTiPqq1oXEu6T3NqBEMVE5Q
Message-ID: <CAOLa=ZQ5u+J-f=xS7RDym0cwt+=R2dzMFo5P34cp-CBbza7NRg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] repository: stop initializing the object database
 in `repo_set_gitdir()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000072134065358dddb"

--000000000000072134065358dddb
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/repository.c b/repository.c
> index 58a13f7c4f..2c2395105f 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -181,12 +181,6 @@ void repo_set_gitdir(struct repository *repo,
>  	free(old_gitdir);
>
>  	repo_set_commondir(repo, o->commondir);
> -
> -	if (!repo->objects)
> -		repo->objects = odb_new(repo, o->object_dir, o->alternate_db);
> -	else if (!o->skip_initializing_odb)
> -		BUG("cannot reinitialize an already-initialized object directory");
> -

This always confuses me, so we were creating the odb even if
`o->skip_initializing_odb` was set to true, if `repo->objects` didn't
exist. Weird.

>  	repo->disable_ref_updates = o->disable_ref_updates;
>
>  	expand_base_dir(&repo->graft_file, o->graft_file,
> @@ -302,6 +296,8 @@ int repo_init(struct repository *repo,
>  		goto error;
>  	}
>
> +	repo->objects = odb_new(repo, NULL, NULL);
> +
>  	if (worktree)
>  		repo_set_worktree(repo, worktree);
>
> diff --git a/repository.h b/repository.h
> index c3ec0f4b79..36e2db2633 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -221,12 +221,9 @@ const char *repo_get_work_tree(struct repository *repo);
>   */
>  struct set_gitdir_args {
>  	const char *commondir;
> -	const char *object_dir;
>  	const char *graft_file;
>  	const char *index_file;
> -	const char *alternate_db;
>  	bool disable_ref_updates;
> -	bool skip_initializing_odb;
>  };
>
>  void repo_set_gitdir(struct repository *repo, const char *root,
> diff --git a/setup.c b/setup.c
> index c5015923f1..3bd3f6c592 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1045,17 +1045,18 @@ static void setup_git_env_internal(struct repository *repo,
>  	struct strvec to_free = STRVEC_INIT;
>
>  	args.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
> -	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
>  	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
>  	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
> -	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
>  	if (getenv(GIT_QUARANTINE_ENVIRONMENT))
>  		args.disable_ref_updates = true;
> -	args.skip_initializing_odb = skip_initializing_odb;
>
>  	repo_set_gitdir(repo, git_dir, &args);
>  	strvec_clear(&to_free);
>
> +	if (!skip_initializing_odb)
> +		repo->objects = odb_new(repo, getenv_safe(&to_free, DB_ENVIRONMENT),
> +					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
> +

Now this makes a lot more sense.

>  	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
>  		disable_replace_refs();
>  	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
>
> --
> 2.54.0.926.g75ba10bac6.dirty

--000000000000072134065358dddb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e3482d4bad5b8d83_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vZ0l1d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHVlQy80eU92TmJrVUdiaTRnN1pOdlYxbTJ1QzQwWAo0ZjZHV1RyNHc2
QjY2YjkvaEp1QlZzY0VieWZpVjdDNzBpa2IwMnVVdG9ablZVajQwRlpBeCtQWGdqaGJXNlZNCld5
UWdEK3R1TTRrMklYY3F5Sk9wRS8yM3pXekFTa3E2d3MydHJBVTQzRFRHS01YeFY4VFVmS0lZZHJH
dnBrV08KUW1GSmMzSE9aanl4b3V3QjZGVlE3cDF3ZkNveGFOS1RYSFNQcmM5WnZIbkRHTTN2V2ZJ
Mmk3a0czbkFlVm52agpiVEFTTHlQdE5sQjVScUNDRmd5SHhlcVRUYUMxaStUKytsMy9JVmtUdUpx
b3lYdjI1WnQyeTVFdEw0UUxjN3kyCkN0TzF1eFNEMEZOMU9vRDVhSkdiSnFQWndoUDBzUExSMTRM
Zzl3b3NvQWg4U25MeUtFU2RpY21NN2Z0WWQ0Qy8KQ2tERjQxY0JkcVk4WXB1UC8zWEFnUU5SMEh4
VWVlUmh3V3BaUFEycmhoRDFWNmhMSU1iQkdqYzY0Q2NiRGZWTwpwMlQvMUFTbEQ3ZWd4dFhzeUk5
RFIvbjFEeUNoWm4vUHVvWUkrRCtnaURTN3pZRExlVitEZE9qUnhpaVV1cjZ0CktHQ1N1T21oUVli
MjIzT1dMYUFRY3l1cSt6aVI3TElhNmZTWFVDcz0KPWx5MkcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000072134065358dddb--
