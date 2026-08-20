Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C824441D652
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224658; cv=pass; b=O/c2FcwHWVaEWIm4OWQ6cmaee0RX5t33Mjt2VvxUgrm8baKBixDL6ovoor/PhcnA+DeKjsdiJ79mMsMvzn0pP78LgtkNK/9oR6wbVkceu1TOk7e3w4YyM5P6bszZlJioKXMyeLbjOrQab1/2kw9W+LjS6FID8fNYhdlw0irF4Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224658; c=relaxed/simple;
	bh=8ME7hFe76bzmFxYQFlL/B/hmHJPbmf2ZI5bH0kCdDH4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hW6498ZVocCkimAyuLNQB4hQAXMJ1CEtW6O/qn/KPptLUOOfxhREyIrd2XbU5FGQhDwAY4aoTanb/O/j+7VL1Fu9XmsngPzwO6qEPogTkP7C7CqMIyyVUzJnM5d/qPdyxomjTPRUylHFjMqybPutXJ8kCcYBn2mWN3nGbbQK/+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqcoUZE5; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqcoUZE5"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-97bf910aa70so603384241.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 04:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787224652; cv=none;
        d=google.com; s=arc-20260327;
        b=N37Jnc1+NnOtvlj5NhgtArPwIQv9iUG1MoH9BxjUWlf69dH6no5miMqiDGC8S6zleL
         316hjStZ5uRx9TucKZOcmup5vDn9RCjWJlYeOt5C+B9QExCbgO7eRANy5/9Y/3cHd8me
         7uGrr1nIu36GSMPIUCJ3OVWlWqxHHcPGGhS1tA7RdTHJQzyR9HBjg9qO0TlWSoi77KCF
         rGoirMUAmR6mss4zSemBX7piDcw5/IszQCkA4GGTz7gTe4+o4bX1k2j+7oguexv8RjgA
         u9c52HKArQZvEJHyFp4cPLZxthOH6OdmgTURZu2r/QQ98Ppb14GhDHF29oVloaUuKL2q
         YClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=I0hlXU4AVZjMknw+ln7kQHDpqnoEIjIcrQcKWU7xfow=;
        fh=w4+qF5gsWn1M022jRx1K3oJNq7GE7E8n0Kzgv9QVkeU=;
        b=OCHi1Be4rWsQtpUoQfPSy2VvDFJ62ina1g9GRzb3eKWyYBPuI0vhuTk1RTl0zQIDKI
         BrAaKXGUhWGtmVJ0IJ0CgowTYf8orSUl28eXVPSvDQq/Nk/fs9VJSBYoah3uHmWvGHdf
         yeULW4J0VLh5YR+41C4Z0wfDBf9tsNCszWK7NVcJxm9KjjpQ3CpboQSdqQG5qlMcpzJL
         FdoEuoMrp4SgSLkcTkwdWFk+yRIQRWTMH4epbYPIUJ+pD2WI/zChuK8MtPolNGUZUzqZ
         LNoJqtv1dEJvLM34k/GZLp919kyaCppA3zi0pcXe2yPw2xCrLh7GhlXXQRMn1C1eBB69
         lodQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224652; x=1787829452; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I0hlXU4AVZjMknw+ln7kQHDpqnoEIjIcrQcKWU7xfow=;
        b=dqcoUZE5/yRhK8q6+lg64T6f1HPEr+g/U0w0e3k+kM7gb0gtjU5wsOVu/tPB7jGEY1
         YP3ddJpqA/A5r5M2RFgj1TZozq/Up3nsRjl3TNC9JZsEyBlRNHLW+mbw/rZX6585eCNJ
         nst/Q7G99JLrmGoOEkivd76wuCNT7HmfLdIthy/3CLVaa9Ha/71OFV/wZNs0JM6GDc/o
         Fswr9N3GO+cxZOIeP+T1J2+5yaLeECcG4SYcQlXVmuLzEWLQkJBjYafN3TO5Dbb+KNSC
         ul2XkD4l0PtSUsuDBaxgv3huvlcQBNR9FVGKKdxNhn05eSeLWbqzwJtYZ357TI9yk68u
         Bo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224652; x=1787829452;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I0hlXU4AVZjMknw+ln7kQHDpqnoEIjIcrQcKWU7xfow=;
        b=PYwMR9oG2YzCdvS8asQOR76NTr/R/RkpFfA6eireWIuDDmKqkx4VY7PC9DUgvTDsoC
         6SlGAvQ4PTBES0e0eVi7pGDLKkEfwpONLLAjeQHuJwpTOUTYIWB2NKHAsQ7y0KhpBHMd
         M7V2Z0aXjG5F3KXNlDcCto4XUcDLghusqW60J0psDOGzFEBUDIf49Mdt8oQ2I5e1oCm5
         AcIXVnX89hq7pOcq3A9LY/hq+40+9oVU/co/qH0amif1GeKRdUw8VvaExcEiqDSpDW+w
         ELSuZjBA37kzmYAu5Z1IpBNLXhNkI0HomzN1HJgxc04F/YYuRHdYoMV0bcce3z9Y+CWW
         5thQ==
X-Forwarded-Encrypted: i=1; AHgh+RrzOzP1rkR2qYQdg1DN9HQDyvlpEDccReap1Rciepp6jINgSaNUnYIJU0E6dDaW/t/s7kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsfOPbCUyCo4r/4sngpAyFIGuy6goF8xB+PwztxUL6bpKedCLM
	P3jredkI0Q4eFS63QlXPqf4LMiH3/nubvUhCzTUU+8ziXuEKG6LumDv+SrnuMgDkBff3Pl2OjGz
	gvX3jql2bMKZHuWStSutV25pM3GUlJi0=
X-Gm-Gg: AR+sD12l85oQVr7e2r4cHPm7nMY7IPjQSPpIRSIgi5qANav3Nca0httqq6vJ+lxn4eO
	5XcsgeQKr5XcwfgKM5sKA2jcxN6Kig+tHpYb/Yia3+DvAiia67LPROzRX2YeLIupTX8MdHl91MO
	jnZ7U/0suiCXB7sJz+Up8iqFtLF5H7abp4yN08+OiCXxR6s+s52ZJ1qvhTxO8Mv3ziIqEF7Qx+d
	NPgH/6dPLYLdqWCF0eAWEKpBFk0rkPbwBhGgHYXUCUU+ptkUBu5wYV/hcF0fCKGMqESttA2Cr0v
	USZOSemqQTbvSZsG0apAp1tfa7Xca5RASt6I1ssqch7Fwb4CkEPzMWUlVzOLv+cekh6vujWnf3S
	1+YPUBxf3N2MpmytdET/17+MBfNzqs3E5OHw=
X-Received: by 2002:a05:6102:8086:b0:738:d6c:7104 with SMTP id
 ada2fe7eead31-777f5a51c97mr3900701137.0.1787224651837; Thu, 20 Aug 2026
 04:17:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 07:17:30 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 07:17:30 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260820-b4-pks-odb-generate-pack-v3-4-bc42252f6169@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im> <20260820-b4-pks-odb-generate-pack-v3-4-bc42252f6169@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 07:17:30 -0400
X-Gm-Features: AcwNN1WdWhoCmXyJzz2cvGwQRSTVjHp8lt42pDUxOAUfiTiGHvpTFqQfQJECDHU
Message-ID: <CAOLa=ZT-Tw2gMVCBS7b62VSkSJAHyVwO7dffsFW3Q4QzQe1JZg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] builtin/bundle: refactor option handling for
 progress meter
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000081caef065978aa4b"

--00000000000081caef065978aa4b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The git-bundle(1) command has a couple of command line options that
> relate to whether or not progress should be reported. These options
> match the options that git-pack-objects(1) expects, and consequently
> they mostly get passed through to it directly.
>
> This results in somewhat of a confusing interface: there are four
> different options that relate to whether or not progress should be
> displayed and how verbose it should be. But in reality, there's really
> only two modes:
>
>   - "--progress" and "--all-progress" result in the same outcome, which
>     is also documented as such.
>
>   - "--all-progress-implied" does nothing as we pass that argument to
>     git-pack-objects(1) unconditionally anyway.
>
> So in the end, the options only control whether or not progress should
> be displayed at all, nothing else.
>
> Refactor the interface to instead use a simple `progress` boolean. This
> makes argument handling a lot more straight-forward and it prepares us
> for the next commit, where we're migrating git-bundle(1) to the generic
> interface for generating a packfile.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/bundle.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index 1e170e9278..bfafadc984 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -70,35 +70,34 @@ static int parse_options_cmd_bundle(int argc,
>  static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
>  			     struct repository *repo UNUSED) {
>  	struct strvec pack_opts = STRVEC_INIT;
> +	int progress = isatty(STDERR_FILENO);
>  	int version = -1;
> -	int ret;
>  	struct option options[] = {
> -		OPT_PASSTHRU_ARGV('q', "quiet", &pack_opts, NULL,
> -				  N_("do not show progress meter"),
> -				  PARSE_OPT_NOARG),
> -		OPT_PASSTHRU_ARGV(0, "progress", &pack_opts, NULL,
> -				  N_("show progress meter"),
> -				  PARSE_OPT_NOARG),
> -		OPT_PASSTHRU_ARGV(0, "all-progress", &pack_opts, NULL,
> -				  N_("historical; same as --progress"),
> -				  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN),
> -		OPT_PASSTHRU_ARGV(0, "all-progress-implied", &pack_opts, NULL,
> -				  N_("historical; does nothing"),
> -				  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN),
> +		OPT_NEGBIT('q', "quiet", &progress,
> +			   N_("do not show progress meter"), 1),
> +		OPT_BIT(0, "progress", &progress,
> +			N_("show progress meter"), 1),
> +		OPT_BIT_F(0, "all-progress", &progress,
> +			  N_("historical; same as --progress"), 1,
> +			  PARSE_OPT_HIDDEN),
> +		OPT_NOOP_NOARG(0, "all-progress-implied"),
>  		OPT_INTEGER(0, "version", &version,
>  			    N_("specify bundle format version")),
>  		OPT_END()
>  	};
>

This is much nicer to read.

>  	char *bundle_file;
> -
> -	if (isatty(STDERR_FILENO))
> -		strvec_push(&pack_opts, "--progress");
> -	strvec_push(&pack_opts, "--all-progress-implied");
> +	int ret;
>
>  	argc = parse_options_cmd_bundle(argc, argv, prefix,
>  			builtin_bundle_create_usage, options, &bundle_file);
>  	/* bundle internals use argv[1] as further parameters */
>
> +	if (progress)
> +		strvec_push(&pack_opts, "--progress");
> +	else
> +		strvec_push(&pack_opts, "--quiet");
> +	strvec_push(&pack_opts, "--all-progress-implied");
> +
>

Tangent: While trying to understand this patch, I noticed that we only
list the '-q' shortform for '--quiet' in the 'git-pack-objects(1)'
documentation.

>  	if (!startup_info->have_repository)
>  		die(_("Need a repository to create a bundle."));
>  	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
>
> --
> 2.55.0.822.g20453c30eb.dirty

--00000000000081caef065978aa4b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8f5c4f85cac0b133_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xRzRra1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlN3Qy85blFiUVlrTG00RWwxYUtsbEI3bGJVaGdmbAp4N00zM0o2UHNG
WXA3Zm8vd0R3S25iWWZCMjhRV3Y3dmVwZkYzK2RLRXFHWDYyNXlYTG9WZUdDUG42Z0RuZkdRCnhh
UGFHM1hlTGFqUTdCZkhubXp6OTZGMFQyTHJEVXNKNENadW1WU1ByNEV0UnlyK2lYWFFWOWxxQ29W
MitKVy8KSmRra0NaK1Q1YzE0YUQrUmZwVXZCNC9CeDluZlVMZzBCbTZzci9zM1hENXFEdjljRFdi
U2swN1prdkNUSzZkbgpreGtDbU9wZ2pPc21SdTh4QmVDUnp3UE8xZWV4UyszQmZXRmttcVliS01Q
U0hzS1FwejBndWgvakF5Y2lKa3UzCjRmVWdqLzZNSFdVeHN6UjlRV09XVWM3SmIrUXAvYVpXOEF6
YnR0TDkzKy9IMXBjT2ZXRXlMcnFOamZCL1U1cjkKM21rV1NxL2lOYnBpeUNING9jNkFYSTBVMndF
MEw3SHd1Nzg1RUR0ZElIdkl4WVIrbTFHS215WVN6emQwRllYRQpJVzV5a0cyZDNyUHZjWm9aN0t6
ZGs4clpRYzBPRjBNNUdwWTRmZzViM01YbFZxZ1ZuaVBTWHY4YTZwS1pSalYyClg1SGErakMzRGFI
U01DRjlhejN2MytuZ0cxWkI1cVJaOHhpaTNlVT0KPXk5Qm0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000081caef065978aa4b--
