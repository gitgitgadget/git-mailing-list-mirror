Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE87FC433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 11:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbiAXLJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 06:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiAXLJt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 06:09:49 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D88C06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 03:09:48 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso32487160wma.1
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 03:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ga8oytzI+MiNGOvejNso8sc59SMHZsPhd8A7+OY3dQI=;
        b=h4pnwxUP1ZJJd3e/PLDv37/tL6qgb/itrHCrTbtlNvuIKZ8mHUo1EIYKZu9rGcaNyk
         GteT4TwGSbC4l06saGI5oZ27n1n401hkHeXl8ZjuDQPiPqvYzZV9nEFuNQ1zjK4FEk50
         E1E1RgOZyNVZzIdNahIKFA5DEDX1cqWfr3x+nS1gSg79W/5WC1yMvEnr047etlVMr7s0
         YEScgV517gudzXRkBY7HdDzz7Imw10THnTm9xIlniwvFiVZNUzQqZX4sB+Vz0shQtJ6N
         gyWE1ejTPD/W9her6zxRx0cC1lqGqukJWBpxkLEhG3KZEEog3H8k9D0vE2XDnR/uuqMy
         Tc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ga8oytzI+MiNGOvejNso8sc59SMHZsPhd8A7+OY3dQI=;
        b=o3C6qRx6oZNBsktUrTL9eGPU2fQ2wvjLh8u5pPqikhDJrX8mBNj8i+1AAkOpTcluUj
         xG2rLElW7snguFqa+Qx1S7P6koeiiM6usaFqFhNDOnsiNQXtfqF2TsOex8igoyiRDqLo
         4biuLgigmYgoObo/KjXzZkyQg/nuOGoKM/cjNYolw6ukQqN9GDzcyzP3Mkz46yiw65WB
         rH21FLH0Bh1UB/tkBTwYsnYk2wni+SVEZ+aYwOEe6nVejY0wCS66JKuVNEuAm3l0/niF
         6J/AuhfPvDWQR3PEfAwOgzm0QUolD9fKl409jBwgCwNkek67A/czm8GWX6noXz7U5ifX
         UjkA==
X-Gm-Message-State: AOAM531PBnaoe+pN+/sh8r2l6tzPfVnKoNkqxootwORcUb+Ej7k/SpJL
        ns8TksaE8bY9LNIPvPyoeRY=
X-Google-Smtp-Source: ABdhPJyDP1lWc1oItPgSEZ8gq17PxqBPFlUxUamoRRteaWeChT2h3udARCs1cV+0vkBdTcd9h3YWdA==
X-Received: by 2002:a05:600c:1e01:: with SMTP id ay1mr1389433wmb.65.1643022587140;
        Mon, 24 Jan 2022 03:09:47 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id m8sm4859654wrn.106.2022.01.24.03.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 03:09:46 -0800 (PST)
Message-ID: <b072a986-aeb5-ca10-0888-33f26c9e4b17@gmail.com>
Date:   Mon, 24 Jan 2022 11:09:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/4] i18n: factorize "invalid value" messages
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
 <ca48e82a6b4a2581c815f796a303d411c27a0283.1642876553.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ca48e82a6b4a2581c815f796a303d411c27a0283.1642876553.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jean-Noël

On 22/01/2022 18:35, Jean-Noël Avila via GitGitGadget wrote:
> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> 
> Use the same message when an invalid value is passed to a command line
> option or a configuration variable.

I think the factorization works well here. I think in the previous 
series you mentioned the possibility of creating macros for standard 
messages, reading this patch that or some standard functions like 
error_invalid_value() seem like a good idea to keep the messages 
consistent in the future.

Best Wishes

Phillip

> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>   builtin/am.c           | 7 ++++---
>   builtin/blame.c        | 6 +++---
>   builtin/fetch.c        | 4 ++--
>   builtin/pack-objects.c | 2 +-
>   builtin/pull.c         | 6 +++---
>   builtin/push.c         | 2 +-
>   builtin/send-pack.c    | 2 +-
>   diff-merges.c          | 2 +-
>   gpg-interface.c        | 4 ++--
>   ls-refs.c              | 2 +-
>   parallel-checkout.c    | 3 ++-
>   sequencer.c            | 2 +-
>   setup.c                | 2 +-
>   submodule-config.c     | 2 +-
>   t/t4150-am.sh          | 2 +-
>   15 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/builtin/am.c b/builtin/am.c
> index b6be1f1cb11..ba1dacbc034 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -199,7 +199,7 @@ static int am_option_parse_empty(const struct option *opt,
>   	else if (!strcmp(arg, "keep"))
>   		*opt_value = KEEP_EMPTY_COMMIT;
>   	else
> -		return error(_("Invalid value for --empty: %s"), arg);
> +		return error(_("invalid value for '%s': '%s'"), "--empty", arg);
>   
>   	return 0;
>   }
> @@ -2239,7 +2239,7 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
>   	 * when you add new options
>   	 */
>   	else
> -		return error(_("Invalid value for --patch-format: %s"), arg);
> +		return error(_("invalid value for '%s': '%s'"), "--patch-format", arg);
>   	return 0;
>   }
>   
> @@ -2282,7 +2282,8 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
>   				break;
>   		}
>   		if (new_value >= ARRAY_SIZE(valid_modes))
> -			return error(_("Invalid value for --show-current-patch: %s"), arg);
> +			return error(_("invalid value for '%s': '%s'"),
> +						 "--show-current-patch", arg);
>   	}
>   
>   	if (resume->mode == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 7fafeac4081..ca821420d68 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -721,8 +721,8 @@ static int git_blame_config(const char *var, const char *value, void *cb)
>   	}
>   	if (!strcmp(var, "color.blame.repeatedlines")) {
>   		if (color_parse_mem(value, strlen(value), repeated_meta_color))
> -			warning(_("invalid color '%s' in color.blame.repeatedLines"),
> -				value);
> +			warning(_("invalid value for '%s': '%s'"),
> +					"color.blame.repeatedLines", value);
>   		return 0;
>   	}
>   	if (!strcmp(var, "color.blame.highlightrecent")) {
> @@ -739,7 +739,7 @@ static int git_blame_config(const char *var, const char *value, void *cb)
>   			coloring_mode &= ~(OUTPUT_COLOR_LINE |
>   					    OUTPUT_SHOW_AGE_WITH_COLOR);
>   		} else {
> -			warning(_("invalid value for blame.coloring"));
> +			warning(_("invalid value for '%s': '%s'"), "blame.coloring", value);
>   			return 0;
>   		}
>   	}
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index eaab8056bf9..19ec48f3330 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -758,8 +758,8 @@ static void prepare_format_display(struct ref *ref_map)
>   	else if (!strcasecmp(format, "compact"))
>   		compact_format = 1;
>   	else
> -		die(_("configuration fetch.output contains invalid value %s"),
> -		    format);
> +		die(_("invalid value for '%s': '%s'"),
> +			  "fetch.output", format);
>   
>   	for (rm = ref_map; rm; rm = rm->next) {
>   		if (rm->status == REF_STATUS_REJECT_SHALLOW ||
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index ba2006f2212..192c3ca305e 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3504,7 +3504,7 @@ static int option_parse_missing_action(const struct option *opt,
>   		return 0;
>   	}
>   
> -	die(_("invalid value for --missing"));
> +	die(_("invalid value for '%s': '%s'"), "--missing", arg);
>   	return 0;
>   }
>   
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 100cbf9fb85..e54a0ccadc6 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -42,9 +42,9 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
>   		return v;
>   
>   	if (fatal)
> -		die(_("Invalid value for %s: %s"), key, value);
> +		die(_("invalid value for '%s': '%s'"), key, value);
>   	else
> -		error(_("Invalid value for %s: %s"), key, value);
> +		error(_("invalid value for '%s': '%s'"), key, value);
>   
>   	return REBASE_INVALID;
>   }
> @@ -318,7 +318,7 @@ static const char *config_get_ff(void)
>   	if (!strcmp(value, "only"))
>   		return "--ff-only";
>   
> -	die(_("Invalid value for pull.ff: %s"), value);
> +	die(_("invalid value for '%s': '%s'"), "pull.ff", value);
>   }
>   
>   /**
> diff --git a/builtin/push.c b/builtin/push.c
> index 359db90321c..cad997965a7 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -486,7 +486,7 @@ static int git_push_config(const char *k, const char *v, void *cb)
>   				if (value && !strcasecmp(value, "if-asked"))
>   					set_push_cert_flags(flags, SEND_PACK_PUSH_CERT_IF_ASKED);
>   				else
> -					return error("Invalid value for '%s'", k);
> +					return error(_("invalid value for '%s'"), k);
>   			}
>   		}
>   	} else if (!strcmp(k, "push.recursesubmodules")) {
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 69c432ef1a6..64962be0168 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -145,7 +145,7 @@ static int send_pack_config(const char *k, const char *v, void *cb)
>   				if (value && !strcasecmp(value, "if-asked"))
>   					args.push_cert = SEND_PACK_PUSH_CERT_IF_ASKED;
>   				else
> -					return error("Invalid value for '%s'", k);
> +					return error(_("invalid value for '%s'"), k);
>   			}
>   		}
>   	}
> diff --git a/diff-merges.c b/diff-merges.c
> index 5060ccd890b..cd6c102a0d5 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -67,7 +67,7 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
>   	diff_merges_setup_func_t func = func_by_opt(optarg);
>   
>   	if (!func)
> -		die(_("unknown value for --diff-merges: %s"), optarg);
> +		die(_("invalid value for '%s': '%s'"), "--diff-merges", optarg);
>   
>   	func(revs);
>   
> diff --git a/gpg-interface.c b/gpg-interface.c
> index b52eb0e2e04..04d751a16a8 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -702,7 +702,7 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>   			return config_error_nonbool(var);
>   		fmt = get_format_by_name(value);
>   		if (!fmt)
> -			return error("unsupported value for %s: %s",
> +			return error("invalid value for '%s': '%s'",
>   				     var, value);
>   		use_format = fmt;
>   		return 0;
> @@ -717,7 +717,7 @@ int git_gpg_config(const char *var, const char *value, void *cb)
>   		free(trust);
>   
>   		if (ret)
> -			return error("unsupported value for %s: %s", var,
> +			return error("invalid value for '%s': '%s'", var,
>   				     value);
>   		return 0;
>   	}
> diff --git a/ls-refs.c b/ls-refs.c
> index 54078323dcb..ae09dd59478 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -34,7 +34,7 @@ static void ensure_config_read(void)
>   		} else if (!strcmp(str, "ignore")) {
>   			/* do nothing */
>   		} else {
> -			die(_("invalid value '%s' for lsrefs.unborn"), str);
> +			die(_("invalid value for '%s': '%s'"), "lsrefs.unborn", str);
>   		}
>   	}
>   	config_read = 1;
> diff --git a/parallel-checkout.c b/parallel-checkout.c
> index 8dd7e7bad40..237c02f1d81 100644
> --- a/parallel-checkout.c
> +++ b/parallel-checkout.c
> @@ -39,7 +39,8 @@ void get_parallel_checkout_configs(int *num_workers, int *threshold)
>   
>   	if (env_workers && *env_workers) {
>   		if (strtol_i(env_workers, 10, num_workers)) {
> -			die("invalid value for GIT_TEST_CHECKOUT_WORKERS: '%s'",
> +			die(_("invalid value for '%s': '%s'"),
> +				"GIT_TEST_CHECKOUT_WORKERS",
>   			    env_workers);
>   		}
>   		if (*num_workers < 1)
> diff --git a/sequencer.c b/sequencer.c
> index 6abd72160cc..9b985e8648d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2806,7 +2806,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>   		return error(_("invalid key: %s"), key);
>   
>   	if (!error_flag)
> -		return error(_("invalid value for %s: %s"), key, value);
> +		return error(_("invalid value for '%s': '%s'"), key, value);
>   
>   	return 0;
>   }
> diff --git a/setup.c b/setup.c
> index af3b8c09abe..fe74092a022 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -559,7 +559,7 @@ static enum extension_result handle_extension(const char *var,
>   			return config_error_nonbool(var);
>   		format = hash_algo_by_name(value);
>   		if (format == GIT_HASH_UNKNOWN)
> -			return error("invalid value for 'extensions.objectformat'");
> +			return error(_("invalid value for '%s': '%s'"), "extensions.objectformat", value);
>   		data->hash_algo = format;
>   		return EXTENSION_OK;
>   	}
> diff --git a/submodule-config.c b/submodule-config.c
> index f95344028b5..fb95a026f48 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -496,7 +496,7 @@ static int parse_config(const char *var, const char *value, void *data)
>   		else if (parse_submodule_update_strategy(value,
>   			 &submodule->update_strategy) < 0 ||
>   			 submodule->update_strategy.type == SM_UPDATE_COMMAND)
> -			die(_("invalid value for %s"), var);
> +			die(_("invalid value for '%s'"), var);
>   	} else if (!strcmp(item.buf, "shallow")) {
>   		if (!me->overwrite && submodule->recommend_shallow != -1)
>   			warn_multiple_config(me->treeish_name, submodule->name,
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 6caff0ca397..159fae8d016 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -1169,7 +1169,7 @@ test_expect_success 'invalid when passing the --empty option alone' '
>   	test_when_finished "git am --abort || :" &&
>   	git checkout empty-commit^ &&
>   	test_must_fail git am --empty empty-commit.patch 2>err &&
> -	echo "error: Invalid value for --empty: empty-commit.patch" >expected &&
> +	echo "error: invalid value for '\''--empty'\'': '\''empty-commit.patch'\''" >expected &&
>   	test_cmp expected err
>   '
>   

