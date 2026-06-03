Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6997E37C90A
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491467; cv=pass; b=RUlytxb/WYqlW4pKtcltmDb61eF26+mhXrHxGDrIP1qUS4tY6DZcGwNs+aTpXZyGOiUVKwHzMiILEpxLm91XBJAHEX/PjZolhY5OfBqtP2Jg+1IsFzzXQMeRCPmWqxCOyGCgb6Y+Or1vAS+s3/P0igCyEgSMmA/rXf88yJRTsd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491467; c=relaxed/simple;
	bh=SDdOiiJ8fq88jP8oSpwyn96pyI96heVgsV+N+G0NtaM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKcTBVsiIzsjTgZKRM71zOHEs37T5ZbZHmb1qifIbk7Ne9zfYnmS3m56ZRfWD3jJMVg5UhjzFvIAR5Oz31h562/kNQ07v7fN6NkUpj2crk/rC3mH5pfHPlnJXv75rhmvYDiYJycgoLkSezbiX8AxbH4UyGIhk1HutMSU0iDRCCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7orBsYR; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7orBsYR"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9638d15f871so2331222241.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 05:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780491465; cv=none;
        d=google.com; s=arc-20240605;
        b=DmP7g/f5/Qg/gRdFPrHm+mGwh9iPcYYjF9G7OISWQhRacBnBZjCPMnp2ijThH+jq5Z
         jTaUxphueAa4hGfXIezutI5BOVvIavyfQ6CvRscrHMNqbyTxmmFKOVvVjX0wKs0UrZ2h
         KJLD6hX1LJpyf8CsjCX5gtY8zhtzYvEnqPt7SrgLi+IpPH6gLuEEQ5CLyehAZAiic3AG
         EXRt6M8/yMC2r5eLqCIb1NSc8ReRl2k8iM+ntMSbh4Kvo9sb7jgq5HC8hPkLkhBExEef
         9J1cgiMubJuainFC3vIRZtkx+rTDFaXZKht7uDwLs4shJwjMR88T8A5Uc390bOi4EiHn
         pdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=2sR7i23pbb4UCQsoTFFi8MZsW1xVPE/x9I1KwUafR2I=;
        fh=lxrhHzhkwrKLlCQxsUu/go4FCdwxAqN2eUUfPY9lne0=;
        b=Qkb1XcfGmFlk2Nbui8T8UWVRaKEc2Ro7B9MwoBlycrmFw2veH4rYNIy0kQ6ma3YG0V
         oELZ5EqCV5iez3chfTPMry8KluJh9raAQTA82vCSXlXbmOiHxF8FaBiTKUF/V7OQw+MM
         THn7UTL3KjAW2gp9ub8RIXwMO7mdBQPMm1zOJ+iRQwh/HAVLXw/JjD7rtif2i8wlKKmN
         obU0Woo/W8lljww/bFBTWGI6QCX5oYCJKf2Yl/c3vZRt3MsHG1tzoIF5D6IfhhMbevAT
         2G6XObxtx9CSn4KYLXsa85d7k91zNAzti9J0evlYDmIrkZ/9Byf7Wm57id0/Kjxv4+Eu
         ElKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780491465; x=1781096265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2sR7i23pbb4UCQsoTFFi8MZsW1xVPE/x9I1KwUafR2I=;
        b=P7orBsYRSft0+kURjT+v1seCUdkkJEl7sfQKT3BZs9u/l1r3mGaLK1Z4aW4TYcmFlY
         5YRYTa0ZKdFsoN++irGmcgD95Yv0KYqD2wTKqKkPIV8AYezVYdT3Sas2Jm94WlqKpdz0
         BVIv7n/eDbCBk9axoi0v/7nxLscqY3il4oNsG5HIX5MUE1vOhG3NSVyPi+ZOYILq9pYq
         NEHSc+6X82YBAP8Hq4HefCTXjV9iDxoSWqvAdB29Gz+bRS9Bc3uqqKUwSVKMCcB9Cnoq
         CqQsLyLywnz6AAK+KBMaL+jRHzOXBl/b5syNsrlZDXwlsKA2sWstj9gF1ikc7uT/usgW
         qiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780491465; x=1781096265;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sR7i23pbb4UCQsoTFFi8MZsW1xVPE/x9I1KwUafR2I=;
        b=KEV/pnstCRzYZN58CxFbe8x1r2vQmfbFPnzx1FRbqGS6IUZb0Qj2xq5+55wXPbK7+k
         SdD9KfYh+pCF4r2w0wHCAJvlhOwntZIxae9rc9HL2Z5enTTulQy3h1sbwXi3O2ZRkeUN
         wzR7Me2sLWODxjazGlsqkOr72tAzmXr6JAXM57Y3jzaBB+Gv/Nb2DZ94u/X0s1vSfk8Q
         lhl6OvC1OZtfRhXfhwdCyy7iRlTb83OmLGjExxWkKJUZOJadyHpTR6/3cck1fSVNitB0
         qb1TJSPcxrYQdL+l1Ei5SMtEfhbX8GuhQaKHTGH5PYs4rQ3vNvmZk5Ou8zY0Z0EV9CwH
         k+5w==
X-Forwarded-Encrypted: i=1; AFNElJ/N5/MKOoTxgXI654pbDnQIZk26Db7O1nhzB0TW6bAv9fZ/wlXwxzLtBovuCvhz4uIik7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNi6cB7C8jQIyyfY1yoCP83QBhn4FU6qHjpMKX8x5VC+RFloW3
	FHS0aIC+HL2Lm2DxvVTS1ptrBMODUivbyf+FR91cf+Kl94fgqF2KXE/5bhpzY0eVeqAmxIDKySE
	DsW4+5wDJ5ntysYSj22ZAjSucOTFz4uHBQg==
X-Gm-Gg: Acq92OGA1nBDQzBl9sFfR7ft6AWXLo/FFukM6R8tdJVmsHJiuaApqmLuo1KPo5ztz+b
	x3I+4MYp459AMtxamoRpp3NY7uGwcQYNE57xTGwhPJBCaMdV+Ix9yUFa96LOr/9DJkLt5nPOrmG
	0TtCG/Y6h8glTRWR6psJqFxgw1eEm0ovbHU52cUaUTWAP46TO6ImXJ2unagxPI4vL+/kcY9yCRQ
	JOkk4J/zPVLljngUcC+4X3jVVqGofns6Smob+gnGn8h5bKo98f/FN6U/7qKPrN2TyKP1kRTztx6
	xgIWqVDRlX9aJaUtM1tQOJQV2n3OOKhTuLVHE25mazlLCmsPjCzxsdlh2BBpedgzhUnSccgHI8Y
	9irQiyLxP
X-Received: by 2002:a05:6102:5486:b0:635:1bc8:3563 with SMTP id
 ada2fe7eead31-6ec460bc6famr1112513137.20.1780491465048; Wed, 03 Jun 2026
 05:57:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 05:57:43 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 05:57:43 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260526-b4-pks-setup-centralize-odb-creation-v2-5-2fa5b385c13e@pks.im>
References: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
 <20260526-b4-pks-setup-centralize-odb-creation-v2-5-2fa5b385c13e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jun 2026 05:57:43 -0700
X-Gm-Features: AVHnY4K-z-uiJA_hrkEyT0AeknKKLVNRrZUcaxgnDqt0sfbNJGx70YOyqrfwiKM
Message-ID: <CAOLa=ZTpnG9-ApMMyUquODtTcx9jyiJtcCTZ5rqUrAmR6oWB7w@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] setup: stop creating the object database in `setup_git_env()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000004ce861065358f90a"

--0000000000004ce861065358f90a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In the preceding commit we have stopped creating the object database in
> `repo_set_gitdir()`. But the logic is still somewhat confusing as we
> still end up creating it conditionally in `setup_git_dir()`, which is
> called multiple times.
>
> Drop the conditional logic and instead create the object database in all
> places where we have discovered and configured a repository.
>
> This leads to even more duplication than we already had in the preceding
> commit, but an alert reader may notice that we now (almost) always call
> `odb_new()` directly before having called `apply_repository_format()`.
> The only exception to this is `setup_git_directory_gently()`, where we
> also call the function when _not_ applying the repository format. This
> will be fixed in the next commit, and once that's done we can then unify
> creation of the object database into `apply_repository_format()`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  setup.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 3bd3f6c592..0dc9fe4565 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1035,8 +1035,7 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
>  }
>
>  static void setup_git_env_internal(struct repository *repo,
> -				   const char *git_dir,
> -				   bool skip_initializing_odb)
> +				   const char *git_dir)
>  {
>  	char *git_replace_ref_base;
>  	const char *shallow_file;
> @@ -1053,10 +1052,6 @@ static void setup_git_env_internal(struct repository *repo,
>  	repo_set_gitdir(repo, git_dir, &args);
>  	strvec_clear(&to_free);
>
> -	if (!skip_initializing_odb)
> -		repo->objects = odb_new(repo, getenv_safe(&to_free, DB_ENVIRONMENT),
> -					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
> -
>  	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
>  		disable_replace_refs();
>  	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
> @@ -1072,10 +1067,10 @@ static void setup_git_env_internal(struct repository *repo,
>  		fetch_if_missing = 0;
>  }
>
> -static void set_git_dir_1(struct repository *repo, const char *path, bool skip_initializing_odb)
> +static void set_git_dir_1(struct repository *repo, const char *path)
>  {
>  	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
> -	setup_git_env_internal(repo, path, skip_initializing_odb);
> +	setup_git_env_internal(repo, path);
>  }
>
>  static void update_relative_gitdir(const char *name UNUSED,
> @@ -1089,7 +1084,7 @@ static void update_relative_gitdir(const char *name UNUSED,
>  	trace_printf_key(&trace_setup_key,
>  			 "setup: move $GIT_DIR to '%s'",
>  			 path);
> -	set_git_dir_1(repo, path, true);
> +	set_git_dir_1(repo, path);

Since we were providing `true`, we didn't have to initialize the odb
here. Makes sense.

>  	free(path);
>  }
>
> @@ -1102,7 +1097,7 @@ static void set_git_dir(struct repository *repo, const char *path, int make_real
>  		path = realpath.buf;
>  	}
>
> -	set_git_dir_1(repo, path, false);
> +	set_git_dir_1(repo, path);
>

Huh. I was expecting the odb to be setup here.

>  	if (!is_absolute_path(path))
>  		chdir_notify_register(NULL, update_relative_gitdir, repo);
>
> @@ -1879,8 +1874,15 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
>  	}
>
>  	if (is_git_directory(".")) {
> +		struct strvec to_free = STRVEC_INIT;
> +
>  		set_git_dir(repo, ".", 0);
> +		repo->objects = odb_new(repo,
> +					getenv_safe(&to_free, DB_ENVIRONMENT),
> +					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
>  		check_and_apply_repository_format(repo, NULL);
> +
> +		strvec_clear(&to_free);
>  		return path;
>  	}
>
> @@ -2032,13 +2034,19 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
>  	    startup_info->have_repository ||
>  	    /* GIT_DIR_EXPLICIT */
>  	    getenv(GIT_DIR_ENVIRONMENT)) {
> +		struct strvec to_free = STRVEC_INIT;
> +
>  		if (!repo->gitdir) {
>  			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
>  			if (!gitdir)
>  				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
> -			setup_git_env_internal(repo, gitdir, false);
> +			setup_git_env_internal(repo, gitdir);
>  		}
>
> +		repo->objects = odb_new(repo,
> +					getenv_safe(&to_free, DB_ENVIRONMENT),
> +					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
> +
>

Okay, now it makes sense. we move the ODB creations to layers above.

>  		if (startup_info->have_repository) {
>  			struct strbuf err = STRBUF_INIT;
>
> @@ -2048,6 +2056,8 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
>  			clear_repository_format(&repo_fmt);
>  			strbuf_release(&err);
>  		}
> +
> +		strvec_clear(&to_free);
>  	}
>  	/*
>  	 * Since precompose_string_if_needed() needs to look at
> @@ -2796,6 +2806,7 @@ int init_db(struct repository *repo,
>  	int exist_ok = flags & INIT_DB_EXIST_OK;
>  	char *original_git_dir = real_pathdup(git_dir, 1);
>  	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
> +	struct strvec to_free = STRVEC_INIT;
>
>  	if (real_git_dir) {
>  		struct stat st;
> @@ -2816,6 +2827,9 @@ int init_db(struct repository *repo,
>  	}
>  	startup_info->have_repository = 1;
>
> +	repo->objects = odb_new(repo, getenv_safe(&to_free, DB_ENVIRONMENT),
> +				getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
> +
>  	/*
>  	 * Check to see if the repository version is right.
>  	 * Note that a newly created repository does not have
> @@ -2879,6 +2893,7 @@ int init_db(struct repository *repo,
>  	}
>
>  	clear_repository_format(&repo_fmt);
> +	strvec_clear(&to_free);
>  	free(original_git_dir);
>  	return 0;
>  }
>
> --
> 2.54.0.926.g75ba10bac6.dirty

--0000000000004ce861065358f90a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d350dfb7d495e9bf_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vZ0pNVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekhWQy8wUnE1c1UzNUFqdnFIV3hoYk1VelAzem5hSQp5Z0ZLSUFJbWp3
SXNaUnlnSE9IMGpmQUtaejltbGxEcm9ObWFJVVdNT0tHQnF1NFFDRjhoNUNTZ2Jjb0ZVN0xLCldO
czNTOGoxQllKUExuYkNuNkF5djNjVnVSazRYdXJVZGxuTU1qdXdFaVRWUk4zdDFLOUVXNTUxVjRL
Z21LdGEKeW9iaVJKQmo1aCs0QXU3T2hYSDIrRGVvdmwzTlZaMGhTa2JVK2VDM1lxbWRBYVd6Mm9H
RmhOZDhCVDl3eW5CagpyZlhSTTlqQTZjSFN5TnpGRnBUNXZpYTErL3FJMmFJbCtqVmdocWNHR2M4
QnIwOGNMN0IzRHdVZm5Tb21EMVZUCmxNeUpyb3haalFDQWZGRjQwK0x4N2hod2N5dm85R1lob1Zz
T2pZY3VCWWhuc3k4VnhGVXFBTktvY0N3WWY3eWIKdmt3c2ViZTVYbm51RFZMVWtHQnZRREpFeDRQ
VFh2YnAyVDZUUC9UZkV4RUdkNnhyMmhrWWkxdlBRcUFQejFFKwozSkp6K28ySkQ3a1JPR2lnRjc0
L2lCVUNYSUF0SHJ1a0dFTzBTand5d3o0d2tkRzdMeUhnTExLWkQ5N05wWVlSCkxnY3RaZ0hQK2R1
dndYRUgwRlZraE95UUxJMHZnOHFmWm1pOThJdz0KPW50MWMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004ce861065358f90a--
