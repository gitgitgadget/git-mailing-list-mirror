Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05631C298
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769170; cv=none; b=X/xhIWFAzukIpR+kb/5TQz2o0N3fv9H8Uz69UNMKKBQ1BOgYs597cx/j8pyJYei3qWt+xCecy1PWEBzXLrC6gs7COIM3g/w+UQ2x7F0gaIl1DtFic2sW9Bqh539yBnOqR2DpnDAFiyXEq5i8jYYliMcJRrbnGlnyVKN0yjEbZy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769170; c=relaxed/simple;
	bh=eERwIfJsUVKj2Jr4P5aPWUp0GgFfNorZH58VfiTCFSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1VpOBJza8i8MBov300blplfHkIYFFjkwA7Ol36GsSBo/YG1DeIfK9OC5ytJxYA9Oz4lJW3uRMVr5jf6j0KL2IticmU2bj+hPy1FSucagzGvwen6pB33H407qX7/ixW4AhHH/hq54DHEkxvDy8w5wZ/fNeo9E8La7BQX1KPN3Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mItVbmJR; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mItVbmJR"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78843ca0aaaso28190985a.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 15:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1709769167; x=1710373967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jPEGwr+mJwZhbhkZFxDYaNVyxjY+25mZUuZ6nwWeIW4=;
        b=mItVbmJRUeB21BVx6ppzprVkGaPFhMtG9nzawyClrwDv9Wq+lgq1qoykJcG26a5JTv
         RLWi9OlG92/14qDkW3B7se52YTsRbgMv1xRtxNgAZX5P3f4Fu3GdFVpRkwc7QwCRIc6K
         cUjc62Q4h+TfCPOshoxrPM5yjhmnKHCMxyLn+GLW9me4QTKr6eE8Dx2X6doKqVgDCW/6
         PVnLzshLowvqIiXO5uUp9cQvc7UGJeLryzqsDeQBNXEBZBzMCCI0hiEuSbgQSIYZqeOo
         o8070ImZXjq3A53iDBq+zkhVU0dUOHTJRRa+MwhoHOpRs8UcPFiHeYzCmYXjgRqsRnti
         bYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709769167; x=1710373967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPEGwr+mJwZhbhkZFxDYaNVyxjY+25mZUuZ6nwWeIW4=;
        b=hAytkugmLhpmq6MsfvLAGbsi/5UoyiVJRvGQ9FEq+wLpWhU7NPenAIAMa3lVBjW5MS
         f/51C2qJ5955G57c2z/QyUromlAQbc7mTrrXCOxHoREmbwwwQkrIZ0eFzpyESY3DSMtl
         rUN5Q1HoZzDpEyDT6hJS3rQQpAYEkY8CGlMWHbKhjlv1dzNA9g0A455szAiTpSqQmOtK
         vkt80FZ18tgBANwygqL94xHvBsyrBQ9uyw8AKASO1oTZ1ZFS0gZdoKdGSjuVQIOer8cO
         EF4sA/gne0dUT4zYtcXOpOZn5ZNmMNMdlZRhXRNIw3SIlFg5CoX85Gn4on1hb2wmv/Iv
         I+yA==
X-Gm-Message-State: AOJu0YxQyfTXYXoLq3ZG9GmKSqB3jQOaYntHPAT6lqhSEFw+SicvHBdR
	OA4k3OsoIBgA5qzSbcBfmhn9qlGuCZI5IaiJE2GXrtTLO/KWIsSc5o3of669IllcHkOcSaJGc5c
	YlJc=
X-Google-Smtp-Source: AGHT+IHEVtJHFLdem5NemvO9Xt4mPEIhTG1JQKqtQwgiGPWZpHf2LCCvMzXgnUes6VMjWTLc+KO6CQ==
X-Received: by 2002:a05:620a:200c:b0:787:ad28:7eea with SMTP id c12-20020a05620a200c00b00787ad287eeamr6450761qka.16.1709769167482;
        Wed, 06 Mar 2024 15:52:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j10-20020ae9c20a000000b007871bac855fsm7142459qkg.47.2024.03.06.15.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:52:47 -0800 (PST)
Date: Wed, 6 Mar 2024 18:52:46 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/8] builtin/config: use `OPT_CMDMODE()` to specify modes
Message-ID: <ZekBznq74P3QVsSC@nand.local>
References: <cover.1709724089.git.ps@pks.im>
 <41e5bf1d6aa35a32f961b7f9d82a70781674eed0.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41e5bf1d6aa35a32f961b7f9d82a70781674eed0.1709724089.git.ps@pks.im>

On Wed, Mar 06, 2024 at 12:31:42PM +0100, Patrick Steinhardt wrote:
> The git-config(1) command has various different modes which are
> accessible via e.g. `--get-urlmatch` or `--unset-all`. These modes are
> declared with `OPT_BIT()`, which causes two minor issues:
>
>   - The respective modes also have a negated form `--no-get-urlmatch`,
>     which is unintended.
>
>   - We have to manually handle exclusiveness of the modes.
>
> Switch these options to instead use `OPT_CMDMODE()`, which is made
> exactly for this usecase. Remove the now-unneeded check that only a
> single mode is given, which is now handled by the parse-options
> interface.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

> +	OPT_CMDMODE(0, "get", &actions, N_("get value: name [value-pattern]"), ACTION_GET),
> +	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [value-pattern]"), ACTION_GET_ALL),
> +	OPT_CMDMODE(0, "get-regexp", &actions, N_("get values for regexp: name-regex [value-pattern]"), ACTION_GET_REGEXP),
> +	OPT_CMDMODE(0, "get-urlmatch", &actions, N_("get value specific for the URL: section[.var] URL"), ACTION_GET_URLMATCH),

Expanding a little on my reply to Junio later on in the thread, I
suspect that these would translate into "get", "get --all", "get
--regexp", and "get --urlmatch", respectively.

> +	OPT_CMDMODE(0, "replace-all", &actions, N_("replace all matching variables: name value [value-pattern]"), ACTION_REPLACE_ALL),
> +	OPT_CMDMODE(0, "add", &actions, N_("add a new variable: name value"), ACTION_ADD),
> +	OPT_CMDMODE(0, "unset", &actions, N_("remove a variable: name [value-pattern]"), ACTION_UNSET),
> +	OPT_CMDMODE(0, "unset-all", &actions, N_("remove all matches: name [value-pattern]"), ACTION_UNSET_ALL),

Same with this one turning into "unset --all".

> +	OPT_CMDMODE(0, "rename-section", &actions, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
> +	OPT_CMDMODE(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
> +	OPT_CMDMODE('l', "list", &actions, N_("list all"), ACTION_LIST),
> +	OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
> +	OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
> +	OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),

These two could probably join the other "get-xyz" modes, and similarly
become "get --color", and "get --colorbool", respectively. It looks like
that's where they lived originally... perhaps I'm missing something as
to why they were moved.

>  	OPT_GROUP(N_("Type")),
>  	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type),
>  	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
> @@ -767,10 +767,6 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		usage_builtin_config();
>  	}
>
> -	if (HAS_MULTI_BITS(actions)) {
> -		error(_("only one action at a time"));
> -		usage_builtin_config();
> -	}

If you apply just this hunk, I would have expected it to break t1300,
but it doesn't appear to. In fact, it looks like the test suite doesn't
seem to mind, either, which indicates a gap in our test coverage...

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 31c3878687..2d1bc1e27e 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -2612,4 +2612,17 @@ test_expect_success 'includeIf.hasconfig:remote.*.url forbids remote url in such
>  	grep "fatal: remote URLs cannot be configured in file directly or indirectly included by includeIf.hasconfig:remote.*.url" err
>  '
>
> +test_expect_success 'negated mode causes failure' '
> +	test_must_fail git config --no-get 2>err &&
> +	grep "unknown option \`no-get${SQ}" err
> +'
> +
> +test_expect_success 'specifying multiple modes causes failure' '
> +	cat >expect <<-EOF &&
> +	error: options ${SQ}--get-all${SQ} and ${SQ}--get${SQ} cannot be used together
> +	EOF
> +	test_must_fail git config --get --get-all 2>err &&
> +	test_cmp expect err
> +'

But this gap is rectified by this hunk here. Thank you!

Thanks,
Taylor
