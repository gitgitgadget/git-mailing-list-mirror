Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF10C3321C2
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327574; cv=pass; b=Mi2Vp7vP/XJlrIgbLnRwlhfypj2lE0pfDgIB1tV82bTPxQFoCMei/L1y8iZjzjv0hyVcOvcAYhCt7zMDfz78DsEFnlrBdHgB0u4XwJPqqxse96d/rZ/HRYFKYr6Wh7rkyjOWiSgab14NS+XpcMs5PozLe2wJTqlUzO/DFuPr1k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327574; c=relaxed/simple;
	bh=OArSl34fWoPdihLrMX+YAFlkRQGwqynTL7eYEtCJVP0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQftL1xXKTxSHQORUbZ4JPkF0OJmuVUVpmdn5d9LfT3qae6SQDHQNQHjBfG6JVhuDeiM/u1YpDRI4JJ7KlICSMuquYcUu1Ypwcw9m3oHM6jlLf6qdXcrxqRfEUNSOmM2C3AB4HqjKwswOGi6UfnXATZcXbNOCQTHs2j37ewriQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft+n5Iaz; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft+n5Iaz"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-948ba5ccf54so2290687241.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 03:26:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771327572; cv=none;
        d=google.com; s=arc-20240605;
        b=IwIFDluCYJ/CSoNXwc7O6j/fTNs3t5WgrGEumX9vUaP1RS13pts6LMnO2xY9ssWtDd
         VNS/fpsfmigDrv+c8uneLannSRFbDkcAGgKmHuohbs5qbLeasGR5Id6cZbHkhUSb9z1Z
         QY64DPdVG4qX9QaG/Gy/N0B+FKXKckXiIOsc/NkFkHa8C9TEncYCPvumznIJPi4eo3yQ
         tlBOCi2+XmBZUQHlTP7IWYn6QaT05fA0TclZWCM7JNHbYmYRH0MKVKieGVUcB+bk7dzf
         VaovFz9CuIy9021DUVlZAZs3zBXdPZRXufQB+YpRCZT/7rJynyFwBCQMa0pquhuuUeGY
         RUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Ca6HlU3HxbNjykkKnMccnzgyCDOSJVdm9K1ZKDwRpg4=;
        fh=WllNHTLFQQ2pcPPPYSAqqDjBuCcMHTO04DuBE7MN1nE=;
        b=hMgM/nIqRafFF87gT6oEJ2MnaNHlgLo1dnRMmuCBNEERgGrwesd2EIv/URP2fbNWNQ
         1sR1P+bsAX0g4RSA+CJ3pagCq5UkVzglLGtuhKzVgFmnTO3imyDWiZZag0T8b3hd7S5f
         lvaUqkT1LrXj59lqfHg8qspeyDiRdO43mZdP5zEMVBB0Wlp87IMAdKCuJkurPKjB0zxO
         iUnXx5905nYVkxRsyK04HiMe+WGPZIA2JZokGqZgoqAfa6r/fjajIi+fHFy12nlPu+OF
         Mdvl8+6azTUnubETax9ITtgEzzHm4lNd6yEhqC1uB38qu/IE6jeGskPlIao6sM8KSLHF
         RaNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771327572; x=1771932372; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca6HlU3HxbNjykkKnMccnzgyCDOSJVdm9K1ZKDwRpg4=;
        b=ft+n5Iaz5ylxjjXvE8HxRX5VsvGBxwGvDCXu6m0Klft8o8EtLuVFN+vfFZwL2kZ+uB
         f5OL9nTme89RUrsqGLLGDH8UXqATeRj45sJPgMO7L75CUon8zTESb9XEzsck2Dh6QG9t
         VKESdkNsZC/o3uhJa52cBbdHBJ+5timSb99M1VBYJpIOBGlvOTmx7/kShFDp2ji5rjZh
         e6PRP8VJnICvQlko/0sqgmqmFfe4HRKilBZby4N7xrsifUnU8DqDBJ4hqvVARJL29c0Q
         gX9MwcwNRgkbwB4Gvnm4bt7FA2vFOUKe9adqI+QgghN9TPHZyGlrB18SMsMJ3+6jjWN1
         4KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771327572; x=1771932372;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ca6HlU3HxbNjykkKnMccnzgyCDOSJVdm9K1ZKDwRpg4=;
        b=ebJn6GIW+GXYo3RHFqibOrCK6iO71w3CcEaXJ/J6TsT8XlNalCZ1h2cFL6IYwKy99F
         30NnZDcO2VmmxLIl1Z62TYBtmimnYDR9WT/3nreQDeIySNJ0yvLj4d0musAOOpzi876d
         fd9Gn6BBNdXY/EgBQHPARah6zJ6qrS0go6JhRWDttrJ+0KdzHg0XWED7wwKdY9K/Hooi
         J+5iTZbkVc2Ji58ce77o1gcQbg7BvqTGoCSVrrBFY+01VLjdVnW87Doq4GARjwPv34fd
         fvsf/VxodbZsnpSuwM+nsOU6+c1xI2pLXtrCe9JvfdKqiTtVwOxovl1CtP+jiSfOoY4b
         slUA==
X-Forwarded-Encrypted: i=1; AJvYcCW7EF2Qee2EV7evzSvPo5MgNyLAD0S0Up/OQ6vzt3bC8L+RiF77vbr6xDqk99TcR/4JxEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YweVUuat54pEblp+lRQ0E+ldF3GkpNJCQHHYvheQSVt2e6jcY1/
	ztkzmUKDuVCmk3G+vj/0sfrUJS/+vhbWl0f+/PPGXW+gPNmiw9Yl2XFWAycPMlmI1co9Fdv6+7c
	DA5x9PfIbFJIKev4E3QyjOLxjXAbvq/G14VqS
X-Gm-Gg: AZuq6aInoUIqfKnYklmRRmKGV6obCipIKtUHePZWDT3rDNeJ1muerbHV92gGFuOxvjm
	Q3Rc8hX1GkB2cHXpC3pGMBliJhUZzHD/GilbLUudlaOo2AGNhk3TAObKK2jKp4e/oi9FDi7unr9
	1RW4ZDzViMaY9aSPJOXEwEATaXreSjA1hJqv617MjLdeP/SjoXume8Eueg4z8uhWJkjo7m2JqSi
	PWwMDrhs6qVAbcnBrccdjQMkyAmvAfVoD7e6xnX9bhjECWAZvPEt/6uWU4u+r9o9DBJ1wzO4m5M
	k1tTqllQzAFoouX1q/lrl6lJCWrE3r6bViBqYo6oOg==
X-Received: by 2002:a05:6102:41a6:b0:5f5:2501:6d2b with SMTP id
 ada2fe7eead31-5fe1ae60da8mr5628537137.35.1771327571494; Tue, 17 Feb 2026
 03:26:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 06:26:10 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 06:26:10 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260217084124.150366-1-a3205153416@gmail.com>
References: <5b29218a-8d18-41f0-8a03-eac707151945@gmail.com> <20260217084124.150366-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Feb 2026 06:26:10 -0500
X-Gm-Features: AaiRm52_pOPCPANUAk9ulBMEsJ87z12I1zb6lf4SDPchywfuHV5JLltQ32IPqds
Message-ID: <CAOLa=ZTeTWhb0Yc8rPEv8vONTHtSg3bSvW6FBC-AWrZzi12oCA@mail.gmail.com>
Subject: Re: [PATCH v4] setup: allow cwd/.git to be a symlink to a directory
To: Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000ae286c064b0356fc"

--000000000000ae286c064b0356fc
Content-Type: text/plain; charset="UTF-8"

Tian Yuchen <a3205153416@gmail.com> writes:

> Strictly enforcing 'lstat()' and 'S_ISREG()' on '.git' prevents valid
> workflows where '.git' is a symbolic link pointing to a real git
> directory (e.g. created via 'ln -s').
>
> Refactor 'setup_git_directory_gently_1()' to use 'stat()' instead of
> 'lstat()'. This allows the filesystem to automatically resolve symbolic
> links.
>
> To ensure safety and correctness, the logic flow is updated to:
>
> 1. Ignore 'ENOENT' (file missing).
> 2. Check 'IS_A_DIR' cases via 'is_git_directory()'.
> 3. Explicitly reject 'NOT_A_FILE' cases (FIFOs or sockets).
>

Small nit, it would have been a bit nicer to separate these out into
individual commits with tests added per commit.

> Add a new test script t/t0009-setup-security.sh which verifies:
>

Wouldn't something like 't0009-git-dir-validation.sh' be a better name?

> - Valid .git symlinks to real directories are accepted.
> - .git as a named pipe (FIFO) is rejected.
> - .git as a symlink to a named pipe is rejected.
> - .git with garbage content is rejected.
> - Empty .git directories are ignored.
>
> Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
> ---
>  setup.c                   | 39 ++++++++++++++-------
>  setup.h                   |  2 ++
>  t/t0009-setup-security.sh | 72 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 101 insertions(+), 12 deletions(-)
>  create mode 100755 t/t0009-setup-security.sh
>
> diff --git a/setup.c b/setup.c
> index 3a6a048620..269aa9faaa 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -939,8 +939,14 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
>  	static struct strbuf realpath = STRBUF_INIT;
>
>  	if (stat(path, &st)) {
> -		/* NEEDSWORK: discern between ENOENT vs other errors */
> -		error_code = READ_GITFILE_ERR_STAT_FAILED;
> +		if (errno == ENOENT)
> +			error_code = READ_GITFILE_ERR_STAT_ENOENT;
> +		else
> +			error_code = READ_GITFILE_ERR_STAT_FAILED;
> +		goto cleanup_return;

So this differentiates between 'stat()' failing and the path not
existing. Ok.

> +	}
> +	if (S_ISDIR(st.st_mode)) {
> +		error_code = READ_GITFILE_ERR_IS_A_DIR;
>  		goto cleanup_return;
>  	}

Okay so if the '.git' file is a directory, we set the appropriate error.
So this error code is new and we introduce it in this patch.


>  	if (!S_ISREG(st.st_mode)) {
> @@ -994,7 +1000,9 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
>  cleanup_return:
>  	if (return_error_code)
>  		*return_error_code = error_code;
> -	else if (error_code)
> +	else if (error_code &&
> +		error_code != READ_GITFILE_ERR_STAT_ENOENT &&
> +		error_code != READ_GITFILE_ERR_IS_A_DIR)
>  		read_gitfile_error_die(error_code, path, dir);
>

I understand the exclusion here (they are non-fatal flows), but wouldn't
it more make sense to add these two exclusions within
`read_gitfile_error_die()` which already has two such exclusions? By
separating this out, it gets really confusing.

>  	free(buf);
> @@ -1576,20 +1584,27 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  		if (offset > min_offset)
>  			strbuf_addch(dir, '/');
>  		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
> -		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
> -						NULL : &error_code);
> +		gitdirenv = read_gitfile_gently(dir->buf, &error_code);

Okay so we unconditionally read the error into errorcode, quick question
that comes to mind: Wouldn't this break the previous flow for when
`die_on_error = 1`? Where `read_gitfile_error_die()` would've been
called?

>  		if (!gitdirenv) {
> -			if (die_on_error ||
> -			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
> -				/* NEEDSWORK: fail if .git is not file nor dir */
> +			if (error_code == READ_GITFILE_ERR_STAT_ENOENT) {
> +				;
> +			} else if (error_code == READ_GITFILE_ERR_IS_A_DIR) {
>  				if (is_git_directory(dir->buf)) {
>  					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
>  					gitdir_path = xstrdup(dir->buf);
>  				}
> -			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
> -				return GIT_DIR_INVALID_GITFILE;
> -		} else
> -			gitfile = xstrdup(dir->buf);
> +			} else if (error_code == READ_GITFILE_ERR_NOT_A_FILE) {
> +				if (die_on_error)
> +					die(_("Invalid %s: not a regular file or directory"), dir->buf);
> +				else
> +					return GIT_DIR_INVALID_GITFILE;
> +			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED) {
> +				if (die_on_error)
> +					read_gitfile_error_die(error_code, dir->buf, NULL);

Well seems a bit convoluted as we explicitly skip this in our call to
`read_gitfile_gently()` to then call it ourselves.

> +				else
> +					return GIT_DIR_INVALID_GITFILE;
> +			}
> +		}
>  		/*
>  		 * Earlier, we tentatively added DEFAULT_GIT_DIR_ENVIRONMENT
>  		 * to check that directory for a repository.

[snip]

--000000000000ae286c064b0356fc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c94d1434c2a9378a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVVVGRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnpOQy85ODlOQXdwZy9QMEtJTmhHZHIrM0twMmdTUwplbXBVSGRLYkRa
VGtWczJlMGp1WTZOSFpxdHJpMHNxOXlpUlFSVkpnamFQeERqV0FHVWd5dFNHU1Fvd1RnbktBCi9X
ODFRd3hEQ1RJai81Nml5MUk3ZkdianlkOHdWNGVnZWJIWSsxZTJOQjJWQXFBcmlmMVhUZEhUQ2M5
VEFDd3oKZWFyVTVUQ1FKbUM1cVdNY0w3a01tOTc1UjV3VTlKbFRFRk90ODJYdll6bzdUTUJyRUJ4
THhNYWc3RjN1YVNZSwpIU25TQkhNTFdKN0Z2bGIyb0RZRmFqSllNQTZLQWV6WU1RYzNhSmc2N1FH
c1l5dTJXaWROQlVjbTB3OGw4ckFiCitGampIMHg3a1FrdUZyTDVOSkFJOC9CSVVPZjlJQlUrNkFp
NGxYZVltb3F2ZGttN0EzQmhlbWhhS0NNSUtJQVEKQTgxNUQ5enhPa2lWVmNCMzE0TFBDcGluTVhk
bWtMN3lJM2Qxa2NBOHNjZCtIQzF1R3F2eHN3QlRMaGpibEl0QgpRVllwMGZmYVY1V1NlZWNybFhT
QVRjdzhNRTNJemNFZVJNdEI0TjE1VTV4Qi9VYzJtb01WUW9PVHRiUEpyUzJkCi9selQ1dWcySFFB
RHpud1NKeDl1bThDd295RlhlWUs5WTBWa05qST0KPXBBOFgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ae286c064b0356fc--
