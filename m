Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E842AA4
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302530; cv=none; b=c5IEdjhB9aCgEq6ViEpBLALgcOd4R75u+D9PqCn5INOzyzhRJGLfEA5reusdYgOtwV68E4dQwB3/Z4xzi/KKleCePjIXdLQdg0R1m7EjunV/iURqMCHYELn3FwV+Fo3l8OU2KddfIEogIvE+6JiWRL5Ep5lbXGZVIyqwjP94wA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302530; c=relaxed/simple;
	bh=2VbJ6A5IxU5UquOqLj1fIfz+XPQXRfiPO+Vo4TEm1+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tK8msMenCZlgVfv2HgeA4Og4nxMCtaJLJWH51lVGk498BprmlpWADUlB3SXoxtpNYTBITMROOSrRW0pnqZHSri71NIhY2Acvb/jrAcMYK6q96pp9gtZ1Fbil2t4uugwfPjKQxrOOyGktX5CQ0sb0zVgnUV8IwCR1zZMXIoxPx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFPtXUQB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFPtXUQB"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3121aed2435so4316837a91.2
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 09:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751302528; x=1751907328; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=033mulMKBRlqvAv6z58Qi86VXuy4gAHY16DxWW8kA6w=;
        b=SFPtXUQBsKuJUV6MEexv+vUH6drcVsY/qdJGZBgiNVqa+KVPSP7YvF3wMYYSyOt41u
         tp3JGZxUjue+gYd0G4/8GZGhJAeypXrwPijDBw/nguMAXgilBnYuqGC7fCn1eWzY55K1
         yH7VUcfgg+49JkcAhfPZBAfJZBo6DaZ8HkL945BngFa7Z+yZNvBCafFkvGtqXe666mOe
         YanTZ3OaYgCP29HNFBh8zbjRTEWCT4zvdx8JMUd0ptpXkzh2lvNvg1uKoO6pM73sy1we
         j6xaX/I7gPCraLMK5Qr1hshBs1x6uwpzAaoRL84Ga0MRbJI0dp1gwJs0mfk6vDMgwUVl
         jPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751302528; x=1751907328;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=033mulMKBRlqvAv6z58Qi86VXuy4gAHY16DxWW8kA6w=;
        b=X9RcY977hBPm9/mzQbiRwk8z4tu1yK8UH9gAwkDzcb/8lrTauAAtWVANzF5JWGfXtn
         baFwCsODRn06a+/TZ0NwlbGa3HI4rXkf8nsRddpZk/vN4Q8SwVCchZwCW74Rxa4S6IXK
         ybjIkq53HMT0I0q9kgy9F2wmxwgHYdF48lTGPJA7X/eUMkvCkeDFfP5TsKhcfMQQEMNs
         gOkN/ykzFrIPUWS3UF88BWvXPNIaWybV0o0nW3/D51JfqB6PVKZPxAxzuyhhbfP81T6j
         I99A3gjEpYbIdiORPX1bqH6DKuVhzjeuSHatv2MrVQNU+HZbwzm7a0kzNXVDrMGNtnUF
         tPWQ==
X-Gm-Message-State: AOJu0Yz+prcUa1Br4PiUvpUPILGpbX2Q1VKjCuchzxai9S76sjK4/Ug0
	xz/YoWfvDWMaznlA1vZYW5zZXIlWW+bqiP6QliMXyHuiHrhAMCx11rWt
X-Gm-Gg: ASbGncuIpa06PFB4vEBBCT6zEr3W2C3E6fnT/HdEG0UrOvLO6jf8GPjw7USJEsmN8D7
	GeQA/DyD0tBylt1GEJCbbtXW85O4iuJF0LMCXEN0cF7d0u5s38MYfNXPFGUr1kUQT07p4I5oz5S
	2udTX+FQK6rsCo/bQnEwzc3oGTSwzr5S1+JGM2lUmSrem2GCtghvqkrZYGKMzEbyOesFVIKUQUO
	LzM/jEltsv95uJwvty3Eq3Pg/bO2cjtrMdrKbmIqbH7qEAHCKe7sYWI+TAMI6LaQEVqhK+nQuFu
	wkvpAy5HKgb9a3v9o67AkvbOR87cEI6YXIiLpQouRv/odZO4/TrMgwth/wI+D8JdVk5CCNbXpNt
	YEZsMorahkfLMbHdSgQCioFkfwvo=
X-Google-Smtp-Source: AGHT+IFDeNy7zBUs8HvUpfnWqR8vXGZQGz2/x8kqxQMs6njmyhRdP5ht/gM3IzrizsaDJsARutyHIA==
X-Received: by 2002:a17:90b:2252:b0:312:959:dc3f with SMTP id 98e67ed59e1d1-318c8ee5339mr20310626a91.3.1751302527737;
        Mon, 30 Jun 2025 09:55:27 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-318c1392174sm9706741a91.4.2025.06.30.09.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:55:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Leon Michalak
 <leonmichalak6@gmail.com>
Subject: Re: [PATCH v3 3/4] add-patch: respect diff.context configuration
In-Reply-To: <1ec8a1384862765795f17e2d0fcb7b601ef2b25f.1751128487.git.gitgitgadget@gmail.com>
	(Leon Michalak via GitGitGadget's message of "Sat, 28 Jun 2025
	16:34:45 +0000")
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
	<1ec8a1384862765795f17e2d0fcb7b601ef2b25f.1751128487.git.gitgitgadget@gmail.com>
Date: Mon, 30 Jun 2025 09:55:26 -0700
Message-ID: <xmqqtt3x185d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Leon Michalak <leonmichalak6@gmail.com>
>
> Various builtins that use add-patch infrastructure do not respect
> the user's diff.context and diff.interHunkContext file configurations.

Great.  "add-patch.c" invokes "diff-files", "diff-index" plumbing
commands to do its thing, and these plumbing commands deliberately
ignore such configuration variables, unlike "diff" Porcelain command
that is meant for end-user consumption.

> This patch fixes this inconsistency.

If we were spelling it out, we would say "Fix this inconsistency" in
imperative.  But you never talked about "this inconsistency" so far,
so it is not just confusing.  It hints an incorrect conclusion that
the difference between plumbing diff-{files,index,tree} and
Porcelain diff is an inconsistency that needs to be "fixed", which
is not true.

Follow the first paragraph with an explanation why it is a bad
thing.  For example:

    The user may be used to seeing their diffs with customized
    context size, but not in the patches "git add -p" shows them to
    pick from.

That would implicitly tell readers that we would want the patch
shown by "add -p" generated with diff.context given by the user.
So we can outline the solution next.

    Teach add-patch infrastructure to read these configuration
    variables and pass their values when spawning the underlying
    plumbing commands as their command line option.

or something.

> @@ -39,8 +39,12 @@ static void init_color(struct repository *r, struct add_i_state *s,
>  void init_add_i_state(struct add_i_state *s, struct repository *r)
>  {
>  	const char *value;
> +	int context;
> +	int interhunkcontext;
>  
>  	s->r = r;
> +	s->context = -1;
> +	s->interhunkcontext = -1;

Hmph, context/interhunkcontext variables serve no purpose other than
peeking into the value before assigning it to s->{context,interhunkcontext}
members.  In a sense, they may be confusing than they are worth.

>  	if (repo_config_get_value(r, "color.interactive", &value))
>  		s->use_color = -1;
> @@ -78,6 +82,19 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
>  	repo_config_get_string(r, "diff.algorithm",
>  			       &s->interactive_diff_algorithm);
>  
> +	if (!repo_config_get_int(r, "diff.context", &context)) {
> +		if (context < 0)
> +			die(_("%s cannot be negative"), "diff.context");
> +		else
> +			s->context = context;
> +	}

Would the code be easier to understand if it is written more like

	if (!repo_config_get_int(r, "diff.context", &s->context)) {
		if (s->context < 0)
			die(...);
	}

with or without {braces} around the (technically) single statement block?

> +	if (!repo_config_get_int(r, "diff.interHunkContext", &interhunkcontext)) {
> +		if (interhunkcontext < 0)
> +			die(_("%s cannot be negative"), "diff.interHunkContext");
> +		else
> +			s->interhunkcontext = interhunkcontext;
> +	}

Ditto.

> diff --git a/add-interactive.h b/add-interactive.h
> index 693f125e8e4b..c63f35b14be8 100644
> --- a/add-interactive.h
> +++ b/add-interactive.h
> @@ -18,6 +18,7 @@ struct add_i_state {
>  
>  	int use_single_key;
>  	char *interactive_diff_filter, *interactive_diff_algorithm;
> +	int context, interhunkcontext;
>  };
>  
>  void init_add_i_state(struct add_i_state *s, struct repository *r);
> diff --git a/add-patch.c b/add-patch.c
> index 95c67d8c80c4..b43ca1600738 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -415,6 +415,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  {
>  	struct strvec args = STRVEC_INIT;
>  	const char *diff_algorithm = s->s.interactive_diff_algorithm;
> +	int diff_context = s->s.context;
> +	int diff_interhunkcontext = s->s.interhunkcontext;
>  	struct strbuf *plain = &s->plain, *colored = NULL;
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
> @@ -424,6 +426,10 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  	int res;
>  
>  	strvec_pushv(&args, s->mode->diff_cmd);
> +	if (diff_context != -1)
> +		strvec_pushf(&args, "--unified=%i", diff_context);
> +	if (diff_interhunkcontext != -1)
> +		strvec_pushf(&args, "--inter-hunk-context=%i", diff_interhunkcontext);

Ditto.  What does it buy us to have these two local variables?  We
have the state object 's' available to us here, right?

Thanks.
