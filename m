Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E112A1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 20:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754063AbeBLU64 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 15:58:56 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46019 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbeBLU6y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 15:58:54 -0500
Received: by mail-wr0-f196.google.com with SMTP id h9so16586601wre.12
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 12:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vOvt08gm/ae63a0x0R5BKcbDl5kjiErmWmaF8c/Dh/U=;
        b=TjGNhmrzisnLTWwWW+pqwQbCUwOsctCNrshipAUKogdVmwV1SPfnh8Ss106ll3HjqT
         FOQxivcTtbvICUU2GdYDt9XWtez/8eRDFvYLvlq5xjQ4L9BTasbuWX7qOGFyACtlytL9
         zSWhY1//rn14FDyKRNW5uVq1dDbh3sL+D/xq1gIagFMDXN2K17t4qzTK+J77f0LAzOy9
         kk0DMUzvzvkp6ARw9BWYgcBF2/EaZ0EmXJoAGYlZyT0C72hdxmedb5HGGKy5bYki8af9
         BMp71FY1ZWu50I6xD9mkRJHMEi1oOqH4U+bod4rhu184LEyj9gcGQX6NtB0+XwLOgM1d
         KG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vOvt08gm/ae63a0x0R5BKcbDl5kjiErmWmaF8c/Dh/U=;
        b=A/RUzL2cHivecwaBxKVcgl0GWB8ymuL4NW5w12vvnGGi1zIV+Ulicb6yzkHxavaYzN
         8WrP4wFN/iPK/qa8oUkgjxDVYmuwnOq2Of+qyKPDw0C7hnIWVdNxEou940ZdhCLtJsU+
         JXkvU6+Mmt5Y/+CfZdE1U3ooAVcSgs+9WQZReBp80hItpNdjhqfLQb5u/aXNaxiO8fEA
         bmkw9XDBVKZFpQ6TEcGEoOeuuhuXlZDp51rZZA9zpLk6gNzGJAFuPuWCowjbq5mvPBes
         00VyUdO+b9yTxtl3DQjdWJyQKchu3WSyfUt2GjedtF6Rk7vwuiQfG1pfj/aYFqwwnHkY
         Ii7Q==
X-Gm-Message-State: APf1xPC36z23XACTBkiAEUjdtSHUlcd2YKx3kQrkGeoOQgMg50prG96q
        ZvUrEsUgYHsA5udkroJp7HI=
X-Google-Smtp-Source: AH8x225wiZraooM1fPaPegnJg1HJhiIWPmrWJVvKCoNpRqfiVjFyY6vzcP7rH/8pTit/Szk4FfAtrQ==
X-Received: by 10.223.157.6 with SMTP id k6mr11367295wre.273.1518469132962;
        Mon, 12 Feb 2018 12:58:52 -0800 (PST)
Received: from neuczc13113nr.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id v13sm13288761wrf.71.2018.02.12.12.58.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Feb 2018 12:58:52 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/2] run-command: teach 'run_hook' about alternate worktrees
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180212031526.40039-2-sunshine@sunshineco.com>
Date:   Mon, 12 Feb 2018 21:58:50 +0100
Cc:     git@vger.kernel.org, matthew.k.gumbel@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <42C41062-D27D-4BB8-8D8D-9272D37FAE88@gmail.com>
References: <20180210010132.33629-1-lars.schneider@autodesk.com> <20180212031526.40039-1-sunshine@sunshineco.com> <20180212031526.40039-2-sunshine@sunshineco.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 12 Feb 2018, at 04:15, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> Git commands which run hooks do so at the top level of the worktree in
> which the command itself was invoked. However, the 'git worktree'
> command may need to run hooks within some other directory. For
> instance, when "git worktree add" runs the 'post-checkout' hook, the
> hook must be run within the newly-created worktree, not within the
> worktree from which "git worktree add" was invoked.
>=20
> To support this case, add 'run-hook' overloads which allow the
> worktree directory to be specified.
>=20
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> run-command.c | 23 +++++++++++++++++++++--
> run-command.h |  4 ++++
> 2 files changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/run-command.c b/run-command.c
> index 31fc5ea86e..0e3995bbf9 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1197,7 +1197,8 @@ const char *find_hook(const char *name)
> 	return path.buf;
> }
>=20
> -int run_hook_ve(const char *const *env, const char *name, va_list =
args)
> +int run_hook_cd_ve(const char *dir, const char *const *env, const =
char *name,
> +		   va_list args)
> {
> 	struct child_process hook =3D CHILD_PROCESS_INIT;
> 	const char *p;
> @@ -1206,9 +1207,10 @@ int run_hook_ve(const char *const *env, const =
char *name, va_list args)
> 	if (!p)
> 		return 0;
>=20
> -	argv_array_push(&hook.args, p);
> +	argv_array_push(&hook.args, absolute_path(p));
> 	while ((p =3D va_arg(args, const char *)))
> 		argv_array_push(&hook.args, p);
> +	hook.dir =3D dir;
> 	hook.env =3D env;
> 	hook.no_stdin =3D 1;
> 	hook.stdout_to_stderr =3D 1;
> @@ -1216,6 +1218,23 @@ int run_hook_ve(const char *const *env, const =
char *name, va_list args)
> 	return run_command(&hook);
> }
>=20
> +int run_hook_ve(const char *const *env, const char *name, va_list =
args)
> +{
> +	return run_hook_cd_ve(NULL, env, name, args);
> +}

I think we have only one more user for this function:
	builtin/commit.c:       ret =3D run_hook_ve(hook_env.argv,name, =
args);

The other function 'run_hook_le' is used in a few places:
	builtin/am.c:   ret =3D run_hook_le(NULL, "applypatch-msg", =
am_path(state, "final-commit"), NULL);
	builtin/am.c:   if (run_hook_le(NULL, "pre-applypatch", NULL))
	builtin/am.c:   run_hook_le(NULL, "post-applypatch", NULL);
	builtin/checkout.c:     return run_hook_le(NULL, =
"post-checkout",
	builtin/clone.c:        err |=3D run_hook_le(NULL, =
"post-checkout", sha1_to_hex(null_sha1),
	builtin/gc.c:   if (run_hook_le(NULL, "pre-auto-gc", NULL))
	builtin/merge.c:        run_hook_le(NULL, "post-merge", squash ? =
"1" : "0", NULL);
	builtin/receive-pack.c: if (run_hook_le(env->argv, =
push_to_checkout_hook,

Would it be an option to just use the new function signature
everywhere and remove the wrapper? Or do we value the old interface?

- Lars



> +
> +int run_hook_cd_le(const char *dir, const char *const *env, const =
char *name, ...)
> +{
> +	va_list args;
> +	int ret;
> +
> +	va_start(args, name);
> +	ret =3D run_hook_cd_ve(dir, env, name, args);
> +	va_end(args);
> +
> +	return ret;
> +}
> +
> int run_hook_le(const char *const *env, const char *name, ...)
> {
> 	va_list args;
> diff --git a/run-command.h b/run-command.h
> index 3932420ec8..8beddffea8 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -66,7 +66,11 @@ int run_command(struct child_process *);
> extern const char *find_hook(const char *name);
> LAST_ARG_MUST_BE_NULL
> extern int run_hook_le(const char *const *env, const char *name, ...);
> +extern int run_hook_cd_le(const char *dir, const char *const *env,
> +			  const char *name, ...);
> extern int run_hook_ve(const char *const *env, const char *name, =
va_list args);
> +extern int run_hook_cd_ve(const char *dir, const char *const *env,
> +			  const char *name, va_list args);
>=20
> #define RUN_COMMAND_NO_STDIN 1
> #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
> --=20
> 2.16.1.291.g4437f3f132
>=20

