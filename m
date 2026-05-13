Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24FC3C199A
	for <git@vger.kernel.org>; Wed, 13 May 2026 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708724; cv=none; b=dyaBkVb+v9XYDJx7zqyq4KNq4sE4PTgGqXb5JGHrRRtG1GDwskOwtRihVVWvyPl2OuLbAK6eBWizTCoVI1zeWYBOio20eRbO1IlsCdheorvD9maPknPVdti88gQt9KR27RoB+QiHIMBhRmwbzU1AyU5fUHex/JUuPXTlVrx5k2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708724; c=relaxed/simple;
	bh=QSPSWkhTZlwuVpKcbfGuCNdYP6AQDUHU4fUyWIZ3048=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jr7FKSWxXraAm1bpKWbmXfW2LTbtpMscCgio/Aa6kl1bwEIA2m7JebmFFp2PdVmixO/QlNaXs/y12f7bMVRUEkzCSaQuutMbus2ea3voTLllCDrKn3kG1+Jyl4z/AAYvYn4I3ZsvHa391RwdPrNlS+0QEMwnGeFdqv7mvk1MQYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kj5Vg1/q; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kj5Vg1/q"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48d146705b4so87013885e9.3
        for <git@vger.kernel.org>; Wed, 13 May 2026 14:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778708721; x=1779313521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pvm12l1d1RNCvBGxPsTUQE7+JLdr9dz0KDsSZFRBapE=;
        b=kj5Vg1/qIa/nr3fOcfEa3PXyaOmbmajFXxiL6Jpj6rif+vMI8z36HY61DerHbM42lz
         ZbjQBb625jXTE+ddtia68ni89uWBSlXZqKhiRX9vk4yDoCMLQdzf7J3pAVwhwClOFoO0
         rv7EmduVOUHwXW4zAxMzTJVb8gKsRO1c8KZzMOLK0KJYEc0Qw8ObnlrUWJJS7JHyNL7b
         2hIfBcByrCTLYbcrpnT1nfU8R5NQcyrfVUuf6MYbte7FwQBT8VVGCi7TKd2yitvZeeIx
         O+qLZXw4yha5n/DQPbUJ44kQ/DSQlibVF+U6fzS2+2jpHOgW76LuLgq4DUs0wkxFlC9I
         dx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778708721; x=1779313521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvm12l1d1RNCvBGxPsTUQE7+JLdr9dz0KDsSZFRBapE=;
        b=ENpflykw1tFzUe0I1wD7iykdLAAwz4xDGP5H5s9REkY5PuW+RT2xSovbChKVRGB39B
         tK8OuegNZgYZYHkYk251M1TNi6hcDSiDHAcrU9IL62ByYUqjnKaGwrcyR1wdJVc6Ax2p
         va6UyCqhNjNGlMEghgg5HVGBPthIfVUcrImbIjWu6j8KBYA9yzeDRx8aq13YZziWIueu
         SNRM2SsA31mxYWuafmejq5Q9mzt2kRdDQqo0ahnz/nrQv3ouW14HwwrWHemrpi1BEiK+
         bFEM9TAV8w0IAGRy55QEUHFxK8tdH+ME3Viy+HGui8ljECi7dU1PQJwRV/DrhWqhpYgR
         C7ag==
X-Gm-Message-State: AOJu0YxSRRdL09EvJdgXpLD4l8RjTzo7GtIEP7FGTMlAdfAArmhhMB4h
	kI463p1PcahpqWeDyguHq+rJttMYXtnMcyWjF5Q1c9PhD4E0ya7zWdDA
X-Gm-Gg: Acq92OFPFVRI9Mu7gHw22J/Jh3weJnj+YhjvXtAaNZjplWQcYeCFjxLrevG+Ns6U5Gd
	Q99doJY0VO1nMIJ1YeifYbPRRIOYQPESDeG9NoeXeGYrvP5ZK2ujYl59TV0EeyfHP/rahwTl2RM
	ZxuxFU9gzmspGXNLB8wuz1KEvzD0v07XsfItxc4L+DsFXHOrBSywL/iI/BXvdLxLcNj2GuUt3Tz
	ayxS7n5lCvUyFaCArx/9NJsEfKlgSx4p4pJfQjSbimmmic3pjKvJVWGY21BIv2SyzNUjgMgfI+R
	uCu/ErQrDYvXn/5Xvs4yaXuf/s9lwrQTdUyjddW9UHJk+XMz8YTINqfLA31mDuAvPwqcu3gLFHC
	UvJ/T5xM2CP3N/fj03pGbt6+Un2wzJcBwGv8Rhl+U28ZUyvzoH8t5kV7T/P9bf6nvUmjtcDdZ3d
	6CYkyca2UDf/3rsgQ1PKRfLkidNMP3d9d58W7xc0z+zat5/Y1mjg==
X-Received: by 2002:a05:600c:1d04:b0:48e:707f:cdfd with SMTP id 5b1f17b1804b1-48fc9a02239mr75979395e9.2.1778708720379;
        Wed, 13 May 2026 14:45:20 -0700 (PDT)
Received: from localhost (94-21-37-251.pool.digikabel.hu. [94.21.37.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd64da1absm27226985e9.14.2026.05.13.14.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:45:19 -0700 (PDT)
Date: Wed, 13 May 2026 23:45:11 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 09/16] repack-midx: factor out
 `repack_prepare_midx_command()`
Message-ID: <agTw579yuy4iHoMq@szeder.dev>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1777507303.git.me@ttaylorr.com>
 <1bd2f194c6f7f64f2ff1e7b55a3a69defcb6a344.1777507303.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1bd2f194c6f7f64f2ff1e7b55a3a69defcb6a344.1777507303.git.me@ttaylorr.com>

On Wed, Apr 29, 2026 at 08:13:31PM -0400, Taylor Blau wrote:
> The `write_midx_included_packs()` function assembles and executes a
> `git multi-pack-index write` command, constructing the argument list
> inline.
> 
> Future commits will introduce additional callers that need to construct
> similar `git multi-pack-index` commands (for both `write` and `compact`
> subcommands), so extract the common portions of the command setup into a
> reusable `repack_prepare_midx_command()` helper.
> 
> The extracted helper sets `git_cmd`, pushes the `multi-pack-index`
> subcommand and verb,

We don't have "verbs" in Git, "multi-pack-index" is the name of the
git command, and "write"/"compact"/etc. are the subcommands.

> and handles `--progress`/`--no-progress` and
> `--bitmap` flags. The remaining arguments that are specific to the
> `write` subcommand (such as `--stdin-packs`) are left to the caller.
> 
> No functional changes are included in this patch.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  repack-midx.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/repack-midx.c b/repack-midx.c
> index 0682b80c427..83151d4734a 100644
> --- a/repack-midx.c
> +++ b/repack-midx.c
> @@ -275,6 +275,23 @@ static void remove_redundant_bitmaps(struct string_list *include,
>  	strbuf_release(&path);
>  }
>  
> +static void repack_prepare_midx_command(struct child_process *cmd,
> +					struct repack_write_midx_opts *opts,
> +					const char *verb)
> +{
> +	cmd->git_cmd = 1;
> +
> +	strvec_pushl(&cmd->args, "multi-pack-index", verb, NULL);
> +
> +	if (opts->show_progress)
> +		strvec_push(&cmd->args, "--progress");
> +	else
> +		strvec_push(&cmd->args, "--no-progress");
> +
> +	if (opts->write_bitmaps)
> +		strvec_push(&cmd->args, "--bitmap");
> +}
> +
>  int write_midx_included_packs(struct repack_write_midx_opts *opts)
>  {
>  	struct child_process cmd = CHILD_PROCESS_INIT;
> @@ -289,18 +306,9 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
>  		goto done;
>  
>  	cmd.in = -1;
> -	cmd.git_cmd = 1;
>  
> -	strvec_push(&cmd.args, "multi-pack-index");
> -	strvec_pushl(&cmd.args, "write", "--stdin-packs", NULL);
> -
> -	if (opts->show_progress)
> -		strvec_push(&cmd.args, "--progress");
> -	else
> -		strvec_push(&cmd.args, "--no-progress");
> -
> -	if (opts->write_bitmaps)
> -		strvec_push(&cmd.args, "--bitmap");
> +	repack_prepare_midx_command(&cmd, opts, "write");
> +	strvec_push(&cmd.args, "--stdin-packs");
>  
>  	if (preferred)
>  		strvec_pushf(&cmd.args, "--preferred-pack=%s",
> -- 
> 2.54.0.16.g1c05dfce579
> 
