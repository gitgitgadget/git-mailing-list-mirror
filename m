Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE133C482
	for <git@vger.kernel.org>; Sat, 15 Jun 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718463740; cv=none; b=ESAVg8caI93KIpAp6P+nqtjf63LAjwQ03msB2cYWD7HpDqN01FidOpUPnAExclIXJMX5bTfaKteCC3gRIHqG6bLpqL4/CayI4Oh7KaKELyiCUBCmMoSUiex8/hRGPRQG/7iJUMZF5lHZ+PkUKq+EEO1mMLT7bCfwug7MeTtuC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718463740; c=relaxed/simple;
	bh=lKFeRols7KBqWbXCnhDJ6ZWdhetCuxlAi2g2TvBL+nQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sI5V9oEBAAk9I4admrWXEFZ5cGOsF4b76uV1lIYQhWyOqJINn/JXtq4ENU88ENfEI7bRRlU/fHteBWnSN2dg04mMc/vqGwOF8gh3f1Yye2eKxCJLNWN6GRx2i/BQrCauIAiC1QoBHcQvAo58HtC3ZMaMgPx1leoOvK8FMyikBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFYMifCE; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFYMifCE"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebd95f136bso33575791fa.0
        for <git@vger.kernel.org>; Sat, 15 Jun 2024 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718463736; x=1719068536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0F05udSx9mlfbMkxgod9UQpQUzrrz5HPJB3N3W6bsUs=;
        b=DFYMifCEmc5xulR/0JB0JWmZSkkV4dLWO/L8kPMLwj+c5GqdZBsElKvgA8sZVc9+7f
         JSGEgX3W5HOtzPPM25yIvrbUoCsy3t1u2YlgSYwKpZTaBILhG0gVXkKOvghvQn1Gbn86
         QOol10FCQxyxi6WLIcsgsd4r/xBDzsimvg4QkxdrIklzbVkhKGFFbXWrYejXLraIiyV+
         o3LQSodKbA5zYpVh3sCV6VtadUU+pTnEpCLezGG3iY5qO6TZ6lQZzDmYMiUjiBUGIz3p
         4d/oNvT6Zzg0fMo+iRnHieFk3ce98+kcyqa5OzEwwB/x+K9DUlaEccQV1xd2DCdTth2k
         K84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718463736; x=1719068536;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0F05udSx9mlfbMkxgod9UQpQUzrrz5HPJB3N3W6bsUs=;
        b=gp8eisiVsPZ/Jkku9fRbN7mGUxnnLRLYYZlPACd/suoc1+GyDLJRnz/jJm2sYOeC8x
         NYrP/hH3v6eehD/cF31vg+zo1n/5l6eKEtHODe3LH3Z4HaTLmyPsc2k4jmdwS5fk+KMq
         p5g0UbUgIGN1Ur5TfY/MEfJ7RN3Ji1b1jfTuYiNGpFn4rPvtLi4P6CGlCa9ec7lKCH1q
         XTb6X9tATC6ULN1FFVvUKrq5O8oNdVaOz+lbUuh2fFysQ0AAq+6ojfiNwG4X2XrKNJn/
         leu7cXIye4Ns03aumiEiyMRn417Yo5AMqFiAYOFsjb/g1S2OD+I/ZVNQUG3Y9YFYNk+O
         yqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnq9KV1OacWgM4eXuXQRBm8+CNYa8dhyjTL5XnY87ngCFyErWVGO9ebXYB+PH7aAn6NehblDHKGVGTmI8AtTEnXiRl
X-Gm-Message-State: AOJu0YymCnJfPiBTKiBRP079JB/PdWwbDzdamJmT7TMSkdsZdL6GXqpW
	npM63wZkSynxElSuXF4LekJgThGCas4fDaNiKeZLjkDzzAlCMi/z0EI4Uqja210edgCzjk9xcv1
	/Dt2wO40og8ZoRN+5SW36Knx1/QE=
X-Google-Smtp-Source: AGHT+IFelZxzms7/VT+qVBCs6yOjIprv1PzT5ukf4zdX1XY8ATaP57wh6zUEaa+fNeD0nLmpX2uwYAv11fmSfWcjzBU=
X-Received: by 2002:a2e:b052:0:b0:2ec:174b:75bf with SMTP id
 38308e7fff4ca-2ec174b77ccmr30655281fa.4.1718463736334; Sat, 15 Jun 2024
 08:02:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 15 Jun 2024 08:02:12 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240612085349.710785-5-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com> <20240612085349.710785-1-shejialuo@gmail.com>
 <20240612085349.710785-5-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 15 Jun 2024 08:02:12 -0700
Message-ID: <CAOLa=ZRQX+7gYrrPZXQtTy=yq+oBGvyWGYXtwMZatpm+VSaUyw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 4/7] builtin/fsck: add `git-refs verify` child process
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="000000000000906a37061aef04e7"

--000000000000906a37061aef04e7
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> Introduce a new function "fsck_refs" that initializes and runs a child
> process to execute the "git-refs verify" command.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  builtin/fsck.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index d13a226c2e..10d73f534f 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -896,6 +896,21 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
>  	return res;
>  }
>
> +static void fsck_refs(void)
> +{
> +	struct child_process refs_verify = CHILD_PROCESS_INIT;
> +	child_process_init(&refs_verify);
> +	refs_verify.git_cmd = 1;
> +	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
> +	if (verbose)
> +		strvec_push(&refs_verify.args, "--verbose");
> +	if (check_strict)
> +		strvec_push(&refs_verify.args, "--strict");
> +
> +	if (run_command(&refs_verify))
> +		errors_found |= ERROR_REFS;
> +}
> +

At first I thought we need to call `child_process_clear()` here, but
seems like `run_command` does that internally.

>  static char const * const fsck_usage[] = {
>  	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
>  	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
> @@ -1065,6 +1080,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>
>  	check_connectivity();
>
> +	fsck_refs();
> +
>  	if (the_repository->settings.core_commit_graph) {
>  		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
>
> --
> 2.45.2

--000000000000906a37061aef04e7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5cee8997cf0edfdd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1adHJQSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3dxREFDV294NGNQWWVmdXhSUWtqOThzWHBFQ2pPSApwem5jUjdZSko4
eEJsTlVlaWhMVUJPaFlXelplS2Q4WGJLTW96Y05Mbyt3TjFHTi9PRmdtaUhvamplS1crSFFBClFh
NEdrWkVzbWExbEpVRlNNbkdYNm84ME9UbHNjeW9Vd242U2JPTjZpNmU4UnoxSkMzOERUNmxOMDdh
NEdFWG0KV0NFOGRtOVdZeHlJNXJCUWNTZ2ZkNi9XeWkrNHFiMGxGck50NHpmSzd0VHNrMzZyVm1S
UTdOOHNBS2dlejZGSQpzZ1lRaGpGektaZXBkdUJKc3h3YStmVzZxTVNpVXRUdE1ab2k4MVNvVHdL
ZXFSdG4xT0tEZ3g3NFJGYjEyU0hYCnBEL2g4aHRPYWRxQmpDSUpGQVB0WUVydFhBeXRBamp0bm5C
amlXMVFiVk1lMHBpM28yMm9pRVVWMUVHMHZpdHcKanYzODZLMURNMUp6dmxXTjdLVENqdmtrdURD
bnFQUTdBWEFiUmk2cU5HMU44TEpZY1Z6RE9DYjFFNjMwOFlEQQoxeW9Fc0d3SzVqeHVQZW4zQmd3
VTd6bTh6cTQ4UElZd0J2R1J6M1lqZ2VKWHpaWHIzRGdTSHpLM1ErMGpzS3IzClhYVko5UkJPOXdx
UXY3SjkwOENmcHZKZGVRSzNPTTVvdmhha2trTT0KPW5XSEkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000906a37061aef04e7--
