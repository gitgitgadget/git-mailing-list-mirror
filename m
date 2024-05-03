Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1333C153518
	for <git@vger.kernel.org>; Fri,  3 May 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739321; cv=none; b=GaU/25l2qwbuY/2rXxmR768WkcbQgYAl2UEEtMtMACxPO1z1TYsi2+PKwm42gYaQSNatk7esSbL2mQ8TWSt/6TTgGel/ShVSXh3l+CFICmg9Diag/BdPTltfjr7ezzRdo+MrNRjsyc6TrNMMalu08324yA1QC7zCFspCXF6z9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739321; c=relaxed/simple;
	bh=5ux3g5h7aoEFwZNwmGWOuD0UrrvykfdjXn6ARJSgsGI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMN5jYvv4XvIyCErW8XlZqbAKYk3deQp6cGiv0YesS3WpnYWlqWnKp0VgPB1UZXXtN7sx/2H/1AwujhprC5l5G5l1By5OS/cIRkShN+p8TRWuZ+JJ5isrvgIzr4j12bIk4q9F64YQrXSxJtBDpqFuc3DcIVsgKtL+jk+VPIJ4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGASZmKK; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGASZmKK"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-23d1c4c14ceso2160958fac.0
        for <git@vger.kernel.org>; Fri, 03 May 2024 05:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714739319; x=1715344119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+d9zP0w4vl5pT0vDmqCV9HAR9RonDE7O9qnbL4ehwA=;
        b=cGASZmKKQA3ZZnmv8/ag1P1GFS0ecatc3X5s4yNMVLSpmuXwr3r65WgW9L8VAKTF8s
         uqb5Jh/iAMSoJ+sEisBtp+cJkGPr0kUu4vwIsclbiH7KFwBobjX35Yas5/v1N0I1aMuO
         wyofJWd/7ibVbRxnEUYY/mCC4rXAG+3UqgIx24jRtYDTAnKNmQyhs02alehCdtpLLXjx
         x+l7oSPfXvQM3WqQ6Ryn8EbwAG5PY+6Ne6wkm/++Q2z/aq3xC0eFfB8f/DVC6Rku9AH6
         0CDya6GveecImRwoV5ncnuzWGw0zSU9RfLXxeCkiw6hvaDuMZQgRKVafiTomOwOBvV9e
         Hucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714739319; x=1715344119;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+d9zP0w4vl5pT0vDmqCV9HAR9RonDE7O9qnbL4ehwA=;
        b=ODCm7w0fUJ6ErIwdjkKOAFpIMq/zIQw6z7ILiXg1SjaOiIXApm9FuBWmWaiKhomD8P
         5qG+sZznmT/7cNoSFZdR8Ce1vLWPLdJzZLieY3R7sE10R4Kl1or6W3aB8eioCWKihuR9
         V1e1ZsPD/pkMliU+v3xL4wSiWLeSpllhe1x5D9rPv9a2fGYB0C/2kCeMGAq0jHRsAGkK
         s0QwUKGO7v9LSVE8eo4r0Ukd8vguBPbe/kHfUIrhYPwnzQ0KEb6iC7tNncIxEHj28eni
         UvbM9jj8vS2DYLFugD00rApAWtlx/bTraJk/oTfZEVR9UT4rCvqtysNMP8S+Nk8NQRrQ
         qQ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGUhWxSPKje+MkIIgDKbKzPt6iqEfbhZz910dMamVXsOL1jbIs2GFddLi+sMO83IIH9elNegQ6LHuD+BzOQa+3pLH3
X-Gm-Message-State: AOJu0YyFUqnxVjYYOml13/aVh7CVaPIv9fek81tzMNfSeIDwKSfanafb
	/mEtDCHybyYcYHI7iUJ9AMe+JlX3m1QfDWoG/0XXF927nGHwiYHTYjyyhNByXQCi1OuGmhmpkPd
	RMd6Jxq8i0DNEwW62Pii8Vw0qiJw=
X-Google-Smtp-Source: AGHT+IHRdmb4+3pparIFWgPNSV/vkLMp+TS3yEsWz9lBXdAYftOZvyoJ9bZcmC02c+CK5r1S7C1/goRXe3lzRKE5lE0=
X-Received: by 2002:a05:6870:ac0e:b0:23c:5194:e19d with SMTP id
 kw14-20020a056870ac0e00b0023c5194e19dmr2999192oab.24.1714739319000; Fri, 03
 May 2024 05:28:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 May 2024 05:28:38 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ddcd8031d7e399b126344d82d3373a2b2ed7fb8f.1714730169.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im> <cover.1714730169.git.ps@pks.im> <ddcd8031d7e399b126344d82d3373a2b2ed7fb8f.1714730169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 3 May 2024 05:28:38 -0700
Message-ID: <CAOLa=ZR02Jf3-4zT9gMzVmzS1JNR1MCLDHCV+utR3B-N_acK=w@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] builtin/config: move "fixed-value" option to
 correct group
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000fe048006178bdb74"

--000000000000fe048006178bdb74
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `--fixed-value` option can be used to alter how the value-pattern
> parameter is interpreted for the various submodes of git-config(1). But
> while it is an option, it is currently listed as part of the submodes
> group the command, which is wrong.
>

Isn't it currently listed as part of the 'Action' group? Also I'm not
sure if the last sentence needs to be corrected here.

>
> Move the option to the "Other" group, which hosts the various options
> known to git-config(1).
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index 59ae5996eb..054019b70c 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -643,7 +643,6 @@ static struct option builtin_config_options[] = {
>  	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
>  	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
>  	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
> -	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when comparing values to 'value-pattern'")),
>  	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
>  	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
>  	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
> @@ -663,6 +662,7 @@ static struct option builtin_config_options[] = {
>  	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree, local, global, system, command)")),
>  	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
>  	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable comment string (# will be prepended as needed)")),
> +	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when comparing values to 'value-pattern'")),
>  	OPT_END(),
>  };
>
> --
> 2.45.0

--000000000000fe048006178bdb74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8f40bc800f8557b0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZMDJIUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1memRJQy9zRVFhWDF0dm1xVlFETHpreFVFay8rQTRvTApBRHliZ2JBRFhL
STBzckVPYVQxb0RlL0hVZ3hUOHNTc0ZtSzdENTRGMUVubGs4SElocmxvWUlrcW9JU1JJdlFyCkxK
L0lxMlpGSlB4aGdoclB0aUFKTHJEOVJPcC81WlJFVHRKWjVwdXZmZ1pmc2VyR1dpWGE5b0JWbUcz
M3ZDdk4KY3lwTmJTTTRTd0lPTkJJMTdDZ2VDV0lRNXd3eTQwMU1ZY1QrUjFnL0tNRnN6MnA2VTFv
T09GZldTTFdkTXdUbQo0L2lEUXlGZnEyQTJFK1QzMUpaQ2ZJbEdjd3lCSGFmU29kalIySlpRZzR4
YzY0UktKLzZyZWw5MEFRcy9rSGJICmlUbXYrd043V3VtYVBQZEQzOGQzSkY1bTBIY2pvMjBqYThu
ZVpROVZJRlZzSUFaa2xCVzgwRmtaSUNMa3VYVWQKVmxYb0tmc2U5QytCNngwNmRiUWNyeVVuY0lr
bmI0cFpmOXRNekU5M0NvOWVFaUc0dmVNSzJRTldvcm5rTDZyMApYN2loZk1VUGhrVmh5WG0vTDdM
MFlqcVhKSk53amI2dlBnTzNwYmQzTkJPYXQ1aEhDeHFSRy93SHBEUjU4dDVWCi81bEcrdDdYTnJx
ci9CSm1FZ3U1NnRzUUJGVTdKUWhLZXpBRjdVRT0KPVZnNVkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fe048006178bdb74--
