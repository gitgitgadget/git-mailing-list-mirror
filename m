Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F921377
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwwF9nGY"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B1BFD
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:52:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8486b5e780so4465001276.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698087130; x=1698691930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/EJFoVLM5/cgthj8C+mFTs/6Ovn8oavaOeAIAaULdUw=;
        b=YwwF9nGYCWnOdpvMw0MNvV1hRsYKQXB4JSfhXpL/xBgSEu3c8UdJIQAGUvIfbg3i0+
         6AldML4tGEvxKH8AkXyGCUs7em8hDVshlZdNcFmmuFPULrxcx0iEDkz1MYoGNL+6IJN5
         oDnjeShq1UPtJF6ObDcjAlJqHgfP85VRiHT7LAynDT19/hUZFuki/BWa4HmGbCU5WiTE
         qgoSEAe3hI/OXd/0f8+7bQh7dWCcFdI0LX4F7xdsRM+b+C6XqbUex370On13iBp1h906
         5wNPy5fxC0CguAp6dnRL+iMi/aLdBp09Q/Jteqgez0tuZiJh1Z6uHd+5fdw5zgyORAjv
         YxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698087130; x=1698691930;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EJFoVLM5/cgthj8C+mFTs/6Ovn8oavaOeAIAaULdUw=;
        b=S0CRbX6XDhIj8r4ZuVnXro4D6baPsA4OH+o1JfYXJDWbq3eMlr3LS1bY8tQ5hX9WOv
         InkrgWPdGTxx6uXPtEPGR2xGNknXBYWlfKx5LQwJJzPy25KtmCCX1vBu1r4BiSkLu9hW
         Cdz+Tn1+qt7CnL9yYbnF1YdQ0uRd+lG/LbNQez9M9BYSfWnWEmwS4H3rknfjktg5Ndk4
         tXo6qmQO2832Ix2Tm+4Q9J23mRB/j9lmIgm2L00u0kSH1x+vGN8QPHaQKyanrxYoy3Ep
         SyLzDFFZ3KYJoZeldzK+Y/KFKMapbjH/RnxuxAXYgks998urECyPo/+F7syBVg8S3n59
         qbLQ==
X-Gm-Message-State: AOJu0Yw/x5tNxt/P6Jndm9xGhiAxYLO2iA/8kZld5Pw96np5Bi8RwloT
	90ytKSQrKwf6aGIjfA7TteqrHFKrX7nYxFOhCODR
X-Google-Smtp-Source: AGHT+IGLhQhqS25gs8CAp3OUhAKdqPH/nONhUmiiM/ikIyiC+ayKrQw9lBG72Qe0S+WIWKZfBll97GKup1+Z4+KfCwlo
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:29f6:5cb7:f652:5c5e])
 (user=jonathantanmy job=sendgmr) by 2002:a25:374e:0:b0:d9a:425c:f5c with SMTP
 id e75-20020a25374e000000b00d9a425c0f5cmr184234yba.1.1698087130522; Mon, 23
 Oct 2023 11:52:10 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:52:08 -0700
In-Reply-To: <49d4b649919e5661daa2113c2f5d674c5cd8dd0e.1695330852.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023185208.996434-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 4/5] config.c: accept config_parse_options in git_config_from_stdin
From: Jonathan Tan <jonathantanmy@google.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, calvinwan@google.com, 
	glencbz@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Josh Steadmon <steadmon@google.com> writes:
> diff --git a/config.c b/config.c
> index 0c4f1a2874..50188f469a 100644
> --- a/config.c
> +++ b/config.c
> @@ -2063,12 +2063,11 @@ static int do_config_from_file(config_fn_t fn,
>  }
>  
>  static int git_config_from_stdin(config_fn_t fn, void *data,
> -				 enum config_scope scope)
> +				 enum config_scope scope,
> +				 const struct config_parse_options *config_opts)
>  {
> -	struct config_parse_options config_opts = CP_OPTS_INIT(CONFIG_ERROR_DIE);
> -
>  	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
> -				   data, scope, &config_opts);
> +				   data, scope, config_opts);
>  }
>  
>  int git_config_from_file_with_options(config_fn_t fn, const char *filename,
> @@ -2303,7 +2302,8 @@ int config_with_options(config_fn_t fn, void *data,
>  	 * regular lookup sequence.
>  	 */
>  	if (config_source && config_source->use_stdin) {
> -		ret = git_config_from_stdin(fn, data, config_source->scope);
> +		ret = git_config_from_stdin(fn, data, config_source->scope,
> +					    &opts->parse_options);
>  	} else if (config_source && config_source->file) {
>  		ret = git_config_from_file_with_options(fn, config_source->file,
>  							data, config_source->scope,

Does this change the behavior of stdin config parsing from "die" to
"silent" (since there is no event emitting callback)? The only user of
stdin parsing seems to be builtin/config.c, so maybe a corresponding
change needs to be made there.

