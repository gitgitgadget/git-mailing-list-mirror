Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852AD12DD94
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348155; cv=none; b=aQyuizMevA+Da/sbP4TjrLhnxWdyxyqDObSWBWBK6L9kw8pZVF5L7PfR4JTzydca/VcyX9nJ3x1vQ1C+6dBHIC8Se83Lf53Zwo86CDeTIRMMr3HRMxqs9r4YyJeNt08TiCkoKvxu5WF8tCNJ+thT8EafISN7LeWXRHk3uDHlBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348155; c=relaxed/simple;
	bh=rMGqqR0zYhF/Q/EUe0+ClGSDX+1+vm7tl02BNBXmjh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KAFaH7+E/Odphv4opFIelgMSStde4MusxANjkv3r1iS9vL2bseaL8gEo6j9yaT8jcMDzWvub3bYxCivFp1sDhcYPr5hYYHPDQo4EhkGkB5inxXyYegSRgLBytsGJJVBifsSMX6+yIC8lTqwReY3SvY4puJ62sQQ41fXGlkD7W80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcWURDW6; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcWURDW6"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516dc51bb72so6244650e87.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 03:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713348149; x=1713952949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CKy0j0BD0+ySmr/rg9wGcle7zASIT9Qah0T9iQxe2dw=;
        b=JcWURDW60WAjdp8Mqu00rv7xJzqZ3oZSlqe8p2RAx/nZJTQka4tdG8j7JkIAjsV1fD
         5gTBLu0EgqoWqY6yqGWQwL5exQFFFJYJ4Q/V9vx/ePL/V8o5dAR7kB2u1Vv5GU8G4Q3p
         XtLsBGF1wGIGCrEREv6j4Dw9mY/3Piqs/0Qpw89K9a7KCv0eCE3mYilPeAa2XCOhbsqR
         DbxWRdU7Jb5O6/R90rJBPnd2QzS06Jdc9unyJE2ymVLrNTao2vYQVtP8g4ULJpdoKN0I
         ZlluTTahAxD7rrrWy318AQxinyXC36Y0mUXs91SOifAudUqln42svY0eNGrjSPWrAmlp
         nqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713348149; x=1713952949;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKy0j0BD0+ySmr/rg9wGcle7zASIT9Qah0T9iQxe2dw=;
        b=NqU2qAOmUBQZHswYVnz2Ageb+orYsT5TZ93Hg2BUdw/sLdpn47XXXqRw1rn4r0gj7L
         VqmTWWdUBpjbuIUheEsuw0QcKspFPh+VyS2wGP/ow4clZJDpPXgiy6SP8pN+SExDkAD0
         hiUpgzoIgPEd1Mn87JCJijeVQemaJUkb9VwTSww97pXx9665m+03uxMR5cYYuEJ0cmDP
         v+qWqdSgo48gVIISCc1lt6u4soP92nt3Oze/KTJiCnHTEmVgSGKwC/hXqpoePiavCdh3
         D17r2Fpwr1tgYQcejF0G+iGkSe95pgABySrTozFSOCBGgLFHk38sZJrmp7nUo+/7bB3U
         q6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVmV8d40s7DaCo9MjyBtTjY+zRuvBamGej0zY59ldXfP/8Lo/eFAddv+Y9bvwNVy+ls0tbaQWEWrY+rsTLUDZbuFzJh
X-Gm-Message-State: AOJu0Yyp3+uMNuERWDI4Vjcmrl/TXBLmb9D7YKJzwVH6RY73bGHfoAgk
	9N+hTczWa68zafFqbnLcSzcrRORV3oWWNZRnAXf2XhG8OFLvVfQZCDA2AQ==
X-Google-Smtp-Source: AGHT+IH6G162GRjBO1dxN6uBPwe8b1yGxR0HVxsvnGRupM28MWOmF8iYbhxXePk4/aXp/D7YmUzA8A==
X-Received: by 2002:a05:6512:4ce:b0:518:9eca:bf6 with SMTP id w14-20020a05651204ce00b005189eca0bf6mr7177055lfq.69.1713348149233;
        Wed, 17 Apr 2024 03:02:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id t7-20020adfe447000000b00343eac2acc4sm17156542wrm.111.2024.04.17.03.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 03:02:28 -0700 (PDT)
Message-ID: <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
Date: Wed, 17 Apr 2024 11:02:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
To: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dragan

On 17/04/2024 04:32, Dragan Simic wrote:
> Add --resend as the new command-line option for "git format-patch" that adds
> "RESEND" as a (sub)suffix to the patch subject prefix, eventually producing
> "[PATCH RESEND]" as the default patch subject prefix.
> 
> "[PATCH RESEND]" is a patch subject prefix commonly used on mailing lists
> for patches resent to a mailing list after they had attracted no attention
> for some time, usually for a couple of weeks.  As such, this subject prefix
> deserves adding --resend as a new shorthand option to "git format-patch".

Playing devil's advocate for a minute, is this really common enough to 
justify a new option when the user can use "--subject-prefix='PATCH 
RESEND'" instead?

Best Wishes

Phillip

> Of course, add the description of the new --resend command-line option to
> the documentation for "git format-patch".
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>   Documentation/git-format-patch.txt |  5 +++++
>   builtin/log.c                      | 11 +++++++++--
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index a5019ab46926..8e63b62620ed 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -243,6 +243,11 @@ the patches (with a value of e.g. "PATCH my-project").
>   	default.  RFC means "Request For Comments"; use this when sending
>   	an experimental patch for discussion rather than application.
>   
> +--resend::
> +	Appends "RESEND" to the subject prefix, producing "PATCH RESEND"
> +	by default.  Use this when sending again a patch that had resulted
> +	in attracting no discussion for a while.
> +
>   -v <n>::
>   --reroll-count=<n>::
>   	Mark the series as the <n>-th iteration of the topic. The
> diff --git a/builtin/log.c b/builtin/log.c
> index e5a238f1cf2c..28f31659bcde 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1908,7 +1908,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   	struct strbuf rdiff_title = STRBUF_INIT;
>   	struct strbuf sprefix = STRBUF_INIT;
>   	int creation_factor = -1;
> -	int rfc = 0;
> +	int rfc = 0, resend = 0;
>   
>   	const struct option builtin_format_patch_options[] = {
>   		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
> @@ -1933,6 +1933,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
>   			    N_("max length of output filename")),
>   		OPT_BOOL(0, "rfc", &rfc, N_("use [RFC PATCH] instead of [PATCH]")),
> +		OPT_BOOL(0, "resend", &resend, N_("use [PATCH RESEND] instead of [PATCH]")),
>   		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
>   			    N_("cover-from-description-mode"),
>   			    N_("generate parts of a cover letter based on a branch's description")),
> @@ -2055,6 +2056,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   		strbuf_insertstr(&sprefix, 0, "RFC ");
>   		subject_prefix = 1;
>   	}
> +	if (resend) {
> +		strbuf_addstr(&sprefix, " RESEND");
> +		subject_prefix = 1;
> +	}
>   
>   	if (reroll_count) {
>   		strbuf_addf(&sprefix, " v%s", reroll_count);
> @@ -2111,7 +2116,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   	if (numbered && keep_subject)
>   		die(_("options '%s' and '%s' cannot be used together"), "-n", "-k");
>   	if (keep_subject && subject_prefix)
> -		die(_("options '%s' and '%s' cannot be used together"), "--subject-prefix/--rfc", "-k");
> +		die(_("options '%s' and '%s' cannot be used together"), "--subject-prefix/--rfc/--resend", "-k");
> +	if (rfc && resend)
> +		die(_("options '%s' and '%s' cannot be used together"), "--rfc", "--resend");
>   	rev.preserve_subject = keep_subject;
>   
>   	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
> 
