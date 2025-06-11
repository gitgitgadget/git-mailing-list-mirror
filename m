Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA6425F96F
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634222; cv=none; b=Rtgt0Rlts9R/HJU69gzqi06dOyi5SNOgfsPHXn+UZCorNzNrPFCiX7FMKafVOHkidL6Zg6axy6aNnGMJLHQV6JYCrVYjJeVZxMqQGJtIIvhEdAKe/njlV7VegzIgB06RRIVjH4Fx1sQKJO1zAlJi1YNDBUhHMoVyVysPfATO+Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634222; c=relaxed/simple;
	bh=ok1hMxBx2R+192FSdtrlUrIGwVoxhlVFrDdrff4hVdM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqsf2Dxa5R6kELiqUF0buI3DY3Zs8j0PY4TDLT4c5oVaOweMiWWqaeB69yAZv0iD4g6VI9d+PH1JFcUsVcXdUQIUDmmFN4WT9Hk6Zg4RM6d1cIJuA9yRwybUXNOV/Fo4i/WNljwrkpOoN+YONwnxLMhJxgFlL4E9SXQuiUgkt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8gKTUf+; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8gKTUf+"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87ed1fa8b19so1961849241.2
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 02:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749634219; x=1750239019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9dvdBMMS7w+PCmMCJjliSXUdc88s4uO4PJwxH822TM=;
        b=W8gKTUf+1rVHcUScNWEjeV5Pv8Crr0VU5xQiL/2vSGmHMj1aql4skaF/aInxMTFb98
         oxB2itYLrpPXgQ6DyBxs1VIYb5SDiDTMP77dlusvOsz1UD3jMglMlQPf0KpU9zSo3h6a
         GiQxvnA8GLyB6kTODvHDZwZcZuoWZR3BlaLRWD/ORypTQ3UJHlokv/ztwSQDmI3itPuO
         BP5PNeS2Ovs5WDY4mxMfmdFiyUNB3p6g53HSk+Y+ypzo3Q05dnTgpypCpTyeR1ic/mO8
         u2p59/CHJ2aeDP6cD4XmQ9hSJVUWhp/bc/a0HvlpKL1iCd5JmSSRvoPxQozP49a2Hr5q
         dbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749634219; x=1750239019;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9dvdBMMS7w+PCmMCJjliSXUdc88s4uO4PJwxH822TM=;
        b=leJI7bDglOY9UVJVSa14v4+d0roMLPgPwUuv1nEP9PM1eYLtQT4sdkrJPbmX4nn1ej
         qYkNHSNFvYWhgnw4IHe6ojTvI/JNEYKZlAPoPXl9l4to159+rCxJ/iRfxpTCqenPGCnF
         6Ph7LTJSeHCDe4OYDu5+mYHJgWRE6mETXgp8kHtB+u3JVTLGQfcAmdxkV8Og+44GKUKL
         1rb7MRiLjre5Rh7MPyvrW1MoVvV5yCrzmi3NIO6h1EfkEe2chZjY/b61bgM3WqWFy4ss
         u8s2gpvMfPAWA8MeEEIaQKirI7hdYubPh1KJGlCLA5/GfwKhhDHbHxuHRmZ55w5+hQb+
         +keg==
X-Forwarded-Encrypted: i=1; AJvYcCVILGc9+zCx2ZVar8Qv9VmwPB3vnRIoZMVXtXL0xxIfEPZqqiS2myM78HBN5+QYDQHJZvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHbhSk9MwFHMmnqG6KLz6+46+CMeNrKO5kI02vQpxxQdOmIpaY
	ER8H7UTuXkDZLPqzsGxPNBGLGWL3hLIPWhMQHGUXARoOnnL9BQ5Z0nZxqOrjk4qTGHMMseXUQ0r
	LcmQL066puJweBg4nnowkizF0G26UKOw=
X-Gm-Gg: ASbGncsa6Ai2F+PKtk+Eg+sjmBDGYaJpXKCMiGStjfyjY6ucci5/tOszLMB4chHsJxg
	txpJsJa6ZdUsU30Awi6X67y1wlSejyXhICtugSz5OnaPlDSqNbfYVkAk7eRqb7Gjj4zu0PbpXAq
	f0ga5mcU09SwVtCu1+W0/hWcumb7bzaK+wHNQ4V0Cz8Q==
X-Google-Smtp-Source: AGHT+IEuhEye3PEOJprL3EXikkXlKnEtgkaCldK//A0Ibi3ONVIAqxw4T7CgmjIc0aQBlD+KCcdOx+S9g6r+DYblMAI=
X-Received: by 2002:a05:6102:b14:b0:4e5:9c40:824d with SMTP id
 ada2fe7eead31-4e7baf38da9mr1961903137.16.1749634219153; Wed, 11 Jun 2025
 02:30:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Jun 2025 04:30:17 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250610152117.14826-3-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com> <20250610152117.14826-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Jun 2025 04:30:17 -0500
X-Gm-Features: AX0GCFvAaeYIq7b0782SZSzM95eU3mKEe1RfZDN6rNsUxeD2NXjyFAM4oYCTKNI
Message-ID: <CAOLa=ZRFM5ZVyBfbpYjePN1c+cVBTfU-nk+hsQOGt5e1CJ3EXA@mail.gmail.com>
Subject: Re: [GSoC RFC PATCH 2/5] repo-info: add the --format flag
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000001ebb260637487654"

--0000000000001ebb260637487654
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add the --format flag to the repo-info command, allowing the user to
> choose betwen the 'json' and 'plaintext' formats as output.
>

s/betwen/between

> Also add a flag --allow-empty, which will force the output data to be
> empty when no field is requested.
>

Why do you suppose we need this, I'm not against it, but it would be
nice to state why this is necessary. The idea is to have a default
output when a user runs `git repo-info`, so I'm missing why this would
be useful.

> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  builtin/repo-info.c  | 79 ++++++++++++++++++++++++++++++++++++++++++--
>  t/meson.build        |  1 +
>  t/t1518-repo-info.sh | 49 +++++++++++++++++++++++++++
>  3 files changed, 127 insertions(+), 2 deletions(-)
>  create mode 100755 t/t1518-repo-info.sh
>
> diff --git a/builtin/repo-info.c b/builtin/repo-info.c
> index 4615b988d8..4d539a17fb 100644
> --- a/builtin/repo-info.c
> +++ b/builtin/repo-info.c
> @@ -1,22 +1,97 @@
>  #include "builtin.h"
> +#include "hash.h"

This header doesn't seem to be required for compiling this patch.

> +#include "json-writer.h"
>  #include "parse-options.h"
> +#include "refs.h"

Similar, this header too doesn't seem to be required.

> +
> +enum output_format {
> +	FORMAT_PLAINTEXT,
> +	FORMAT_JSON
> +};
> +
> +struct repo_info {
> +	struct repository *repo;
> +	enum output_format format;
> +};
> +
> +static void repo_info_init(struct repo_info *repo_info,
> +			   struct repository *repo,
> +			   char *format,
> +			   int allow_empty UNUSED,

So allow_empty isn't even used in this patch, let's separate it out to a
patch of itself then.

> +			   int argc UNUSED,
> +			   const char **argv UNUSED
> +			   ) {
> +	repo_info->repo = repo;
> +
> +	if (format == NULL || !strcmp(format, "json"))
> +		repo_info->format = FORMAT_JSON;
> +	else if (!strcmp(format, "plaintext"))
> +		repo_info->format = FORMAT_PLAINTEXT;
> +	else
> +		die("invalid format %s", format);
> +}
> +
> +static void repo_info_print_plaintext(struct repo_info *repo_info UNUSED) {
> +}

Since we don't implement this in this patch, perhaps we can only
introduce the json formatting in this patch? That also allows us to
completely skip the 'plaintext' formatting for now and implement it in
the future.

> +static void repo_info_print_json(struct repo_info *repo_info UNUSED)
> +{
> +	struct json_writer jw;
> +
> +	jw_init(&jw);
> +
> +	jw_object_begin(&jw, 1);
> +	jw_end(&jw);
> +
> +	puts(jw.json.buf);
> +	jw_release(&jw);
> +}
> +
> +static void repo_info_print(struct repo_info *repo_info)
> +{
> +	enum output_format format = repo_info->format;
> +
> +	switch (format) {
> +	case FORMAT_PLAINTEXT:
> +		repo_info_print_plaintext(repo_info);
> +		break;
> +	case FORMAT_JSON:
> +		repo_info_print_json(repo_info);
> +		break;
> +	}
> +}
>
>  int cmd_repo_info(
>  	int argc,
>  	const char **argv,
>  	const char *prefix,
> -	struct repository *repo UNUSED
> +	struct repository *repo
>  	)
>  {
>  	const char *const repo_info_usage[] = {
>  		"git repo-info",
>  		NULL
>  	};
> +	struct repo_info repo_info;
> +	char *format = NULL;
> +	int allow_empty = 0;
>  	struct option options[] = {
> +		OPT_STRING(0,
> +			     "format",
> +			     &format,
> +			     N_("format"),
> +			     N_("output format")),
> +		OPT_BOOL(0,
> +			 "allow-empty",
> +			 &allow_empty,
> +			 "when set, it will use an empty set of fields if no field is requested"),
>  		OPT_END()
>  	};
>
> -	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);
> +	argc = parse_options(argc, argv, prefix, options, repo_info_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN_OPT);

I think I understand why we use 'PARSE_OPT_KEEP_UNKNOWN_OPT', this is to
allow users to provide custom fields to print. But this doesn't seem to
be mentioned in the commit message or used in this patch, could we do
either?

[snip]

> diff --git a/t/t1518-repo-info.sh b/t/t1518-repo-info.sh
> new file mode 100755
> index 0000000000..2e1a6f0c34
> --- /dev/null
> +++ b/t/t1518-repo-info.sh
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +
> +test_description='test git repo-info'
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +parse_json () {
> +	tr '\n' ' ' | "$PERL_PATH" "$TEST_DIRECTORY/t0019/parse_json.perl"
> +}
> +

If I recall correctly, in our previous internal review, it was mentioned
that since we use perl here, we should add a PERL pre-requisite. Similar
to the one in 't/t0019-json-writer.sh'.

> +test_repo_info () {

Nit: would be nice to have some documentation on this function,
regarding:
1. Its purpose and use case
2. The fields and what they mean

You can take some hints from 'test_migration' in
't/t1460-refs-migrate.sh'.

> +	label=$1
> +	init_args=$2
> +	key=$3
> +	expected_value=$4
> +
> +	test_expect_success "json: $label" "
> +		test_when_finished 'rm -rf repo' &&
> +		git init $init_args repo &&
> +		cd repo &&
> +		echo '$expected_value' >expect &&
> +		git repo-info '$key'| parse_json >output &&
> +		grep -F 'row[0].$key' output | cut -d ' ' -f 2 >actual &&
> +		test_cmp expect actual
> +	"
> +
> +	test_expect_success "plaintext: $label" "
> +		test_when_finished 'rm -rf repo' &&
> +		git init $init_args repo &&
> +		cd repo &&
> +		echo '$expected_value' >expect &&
> +		git repo-info --format=plaintext '$key' >actual &&
> +		test_cmp expect actual
> +	"
> +}
> +
> +test_expect_success 'json: returns empty output with allow-empty' '
> +	git repo-info --allow-empty --format=json >output &&
> +	test_line_count = 2 output
> +'
> +

As of this patch,

  $ ~/code/git/build/bin-wrappers/git repo-info
  {
  }

  $ ~/code/git/build/bin-wrappers/git repo-info --allow-empty
  {
  }

So what differentiates the former from the latter?

> +test_expect_success 'plaintext: returns empty output with allow-empty' '
> +	git repo-info --allow-empty --format=plaintext >output &&
> +	test_line_count = 0 output
> +'
>

This is because we didn't implement plainttext no?

> +
> +test_done
> --
> 2.39.5 (Apple Git-154)

Overall, I think the changes here make sense to me. But the commit
can be broken up and divided into individual bits:
1. Commit to introduce the --format=json flag
2. Commit to introduce the --format=plaintext flag (can be done later as
   needed)
3. Commit to add '--allow-empty' flag (is this needed?).

This way the tests and code can also be split as per these commits, this
would make reviews much easier since the current patch has some dead
code which presumably will be used in upcoming patches.

- Karthik

--0000000000001ebb260637487654
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ae53488688e6c985_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oSlRLZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzRhQy85dDRTZzFoangzY3Q0TmdFNW5xTFRnVXlxKwo3OC9HMDlYako3
T0RVcFQzemhJaElqZUo4Q0tuS01zS0dMRWNCTy9QNXNhZzFrSjY5RGVzanJSOUtPVEdCSit6CklF
WmMzelNnYllpL3JmY1hCckpXL3M5anpvbjNVVmtibldHWW13Y0FHbitiMU9oNTR4Q21JK1BkVEtB
c2MrT2sKZndCbU05V2VkUzBNdnpUbEV6ZVBIVFlQL2lDVEM5NVRON0ZRTi9IUGxVYXRmZlp0amky
azlwQ0N4QWpkZzMrcQo4VWJ2MC9lL0owYTNYM2FVZjNqTUFRNFFnS3pIVVYva1IvRGxCOGsveW1q
Z3U2S25SNzNqRG5iMFU1eXBWRnUyCkNMZ3BvN1VZZ0czU3RjN3hoMHQ4QXZnTGdpREtyb3FKMnNW
SzFycUJzTS9hcVZpSFVyV09COWNvOWFoV2M4YVIKRk5NTXYzdkJDVnBYemhObGErV1VwUnN2ektM
R2h4ck42RFVpSUw4N3FuWkUxbU9XNE5GTCtIV3F4OEh2SjRsSApoZUpCVkNvMnAzeU1LODA5Z3M5
NGw0U2pyd1kraytlZVNQbVdhTVhqYlJEVXMrNHNkbjNkZktYZXdMN2ZvdXMzCmVBR0c4Z3VtSXpz
UVJmSkVGQ3FWaVMxRnJIU3EyeE5sdXFhV1gzaz0KPVFJWE4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001ebb260637487654--
