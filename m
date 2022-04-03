Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA23C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 05:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbiDCF6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 01:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiDCF6x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 01:58:53 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7792C66B
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 22:57:00 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id c11so5683481pgu.11
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 22:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I8zI+bHOPeIuUYw1wo1rbWemO59XjYNsVspoK/PsK2I=;
        b=UhjYTDAJZGtc0U5yEjko98SGl6yZ+VE69v4Kt7WDwkFLYWxYacW0tcMKqy1FrJ8+1X
         Me9+t3yMp02pap4OpqeIP3tEG16kAb1M1ghMAsmXcajXM7lFCKg0VmRXcpG7DZlxpVJZ
         cS0ETzjW16awouOi9h5pxcaTJB5hXMp2S9NVZ/mxqA8VaIkdrQ6JfvnCVXpX0dNntSy1
         xNH0MmEhUfaeb8/Jy1DUfQhuFzkvCN5N1gLQXQzEupWf72RblfSizLdwvCWI+DEz4Ltz
         lRC4Zuz5uW1KiT3oz9W6kHk6xPZ7Cu+ruZ5XJUP2WJCbcHhZ0ZBA9VYC3oLQd7PcZrUc
         ILHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I8zI+bHOPeIuUYw1wo1rbWemO59XjYNsVspoK/PsK2I=;
        b=8Kp0bcryft7EkmdkFYZP4xJvz49ghleYrz7S98zkzAVumhZJ3h4dBnJi8WW0FLaDOk
         FclCiayHSm1cCIv1Q7ZGG2192ySKPaM8YCac2W133YSB6hb3cOCICLcVHmWZzq/DqNcI
         qKjgTr78YjzyXrNKed6pVemF8qcZGyHImYmefQAxR9Z5asLJK438jQuI/Q7m5/RiheTg
         3dgAlEkkzwSCifXjbeLabr2FNlPRtvY8lEzzcEvJzPrcugnltf9eFSYs3sP/P5Z20YXu
         fx9PlwHmiDOGgyYk5V8SunwXn7lSFaonpw/3wuklANZTtiYrZ9L5o81BMMRzcTqFXjiZ
         io4A==
X-Gm-Message-State: AOAM533lSL0O3TUNMvLefodLvdHgHnehY+ihPIBUEad6j6M1hDQ3JQTv
        IZVj2oYGD9Usqlj14fxvPvKvVpbgPgxHBA==
X-Google-Smtp-Source: ABdhPJzBiTppS9PvMz839lWUB3S44mSMAfBebQxxUF7adt3FMk5x9+7PhfRRky6nuoUzUh/3no8NvA==
X-Received: by 2002:a05:6a00:cc5:b0:4fb:4969:3eb with SMTP id b5-20020a056a000cc500b004fb496903ebmr18254479pfv.59.1648965419693;
        Sat, 02 Apr 2022 22:56:59 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id p12-20020a63ab0c000000b00381f7577a5csm6589379pgf.17.2022.04.02.22.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 22:56:59 -0700 (PDT)
Message-ID: <4b46ba19-3a39-7317-42fb-4fd4bba09b36@gmail.com>
Date:   Sun, 3 Apr 2022 12:56:55 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/6] i18n: factorize generic failure messages
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
 <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
 <4bba3e1f6cb9cdc35b0dc8da440e38de256b4d2b.1648915853.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <4bba3e1f6cb9cdc35b0dc8da440e38de256b4d2b.1648915853.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/04/22 23.10, Jean-Noël Avila via GitGitGadget wrote:
> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> 
> In these message the command or the function that failed should not be
> translated. So it is simpler to just remove these parts from the
> message.
> 
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>   add-patch.c                     | 4 ++--
>   builtin/am.c                    | 2 +-
>   builtin/gc.c                    | 4 ++--
>   builtin/merge.c                 | 6 +++---
>   builtin/revert.c                | 4 ++--
>   fetch-pack.c                    | 2 +-
>   remote-curl.c                   | 2 +-
>   setup.c                         | 4 ++--
>   t/t3510-cherry-pick-sequence.sh | 8 ++++----
>   t/t6436-merge-overwrite.sh      | 2 +-
>   10 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 55d719f7845..8c9e81ec78e 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1181,7 +1181,7 @@ static int run_apply_check(struct add_p_state *s,
>   			    "apply", "--check", NULL);
>   	strvec_pushv(&cp.args, s->mode->apply_check_args);
>   	if (pipe_command(&cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0))
> -		return error(_("'git apply --cached' failed"));
> +		return error(_("the command '%s' failed"), "git apply --cached");
>   
>   	return 0;
>   }
> @@ -1683,7 +1683,7 @@ soft_increment:
>   			strvec_pushv(&cp.args, s->mode->apply_args);
>   			if (pipe_command(&cp, s->buf.buf, s->buf.len,
>   					 NULL, 0, NULL, 0))
> -				error(_("'git apply' failed"));
> +				error(_("the command '%s' failed"), "git apply");
>   		}
>   		if (repo_read_index(s->s.r) >= 0)
>   			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
> diff --git a/builtin/am.c b/builtin/am.c
> index 0f4111bafa0..a0a57049510 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -586,7 +586,7 @@ static int is_mail(FILE *fp)
>   	int ret = 1;
>   
>   	if (fseek(fp, 0L, SEEK_SET))
> -		die_errno(_("fseek failed"));
> +		die_errno(_("the function '%s' failed"), "fseek");
>   
>   	if (regcomp(&regex, header_regex, REG_NOSUB | REG_EXTENDED))
>   		die("invalid pattern: %s", header_regex);
> diff --git a/builtin/gc.c b/builtin/gc.c
> index ffaf0daf5d9..c062d7bceeb 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1104,7 +1104,7 @@ static int multi_pack_index_expire(struct maintenance_run_opts *opts)
>   		strvec_push(&child.args, "--no-progress");
>   
>   	if (run_command(&child))
> -		return error(_("'git multi-pack-index expire' failed"));
> +		return error(_("the command '%s' failed"), "git multi-pack-index expire");
>   
>   	return 0;
>   }
> @@ -1163,7 +1163,7 @@ static int multi_pack_index_repack(struct maintenance_run_opts *opts)
>   				  (uintmax_t)get_auto_pack_size());
>   
>   	if (run_command(&child))
> -		return error(_("'git multi-pack-index repack' failed"));
> +		return error(_("the command '%s' failed"), "git multi-pack-index repack");
>   
>   	return 0;
>   }
> diff --git a/builtin/merge.c b/builtin/merge.c
> index f178f5a3ee1..78468ff43a4 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -325,7 +325,7 @@ static int save_state(struct object_id *stash)
>   	close(cp.out);
>   
>   	if (finish_command(&cp) || len < 0)
> -		die(_("stash failed"));
> +		die(_("the command '%s' failed"), "stash");
>   	else if (!len)		/* no changes */
>   		goto out;
>   	strbuf_setlen(&buffer, buffer.len-1);
> @@ -352,7 +352,7 @@ static void read_empty(const struct object_id *oid, int verbose)
>   	args[i] = NULL;
>   
>   	if (run_command_v_opt(args, RUN_GIT_CMD))
> -		die(_("read-tree failed"));
> +		die(_("the command '%s' failed"), "read-tree");
>   }
>   
>   static void reset_hard(const struct object_id *oid, int verbose)
> @@ -369,7 +369,7 @@ static void reset_hard(const struct object_id *oid, int verbose)
>   	args[i] = NULL;
>   
>   	if (run_command_v_opt(args, RUN_GIT_CMD))
> -		die(_("read-tree failed"));
> +		die(_("the command '%s' failed"), "read-tree");
>   }
>   
>   static void restore_state(const struct object_id *head,
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 51776abea63..d293036e790 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -238,7 +238,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
>   	sequencer_init_config(&opts);
>   	res = run_sequencer(argc, argv, &opts);
>   	if (res < 0)
> -		die(_("revert failed"));
> +		die(_("the command '%s' failed"), "revert");
>   	return res;
>   }
>   
> @@ -251,6 +251,6 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>   	sequencer_init_config(&opts);
>   	res = run_sequencer(argc, argv, &opts);
>   	if (res < 0)
> -		die(_("cherry-pick failed"));
> +		die(_("the command '%s' failed"), "cherry-pick");
>   	return res;
>   }
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 87657907e78..2e6795cd439 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -989,7 +989,7 @@ static int get_pack(struct fetch_pack_args *args,
>   			args->check_self_contained_and_connected &&
>   			ret == 0;
>   	else
> -		die(_("%s failed"), cmd_name);
> +		die(_("the command '%s' failed"), cmd_name);
>   	if (use_sideband && finish_async(&demux))
>   		die(_("error in sideband demultiplexer"));
>   
> diff --git a/remote-curl.c b/remote-curl.c
> index ff44f41011e..8393f56652b 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1287,7 +1287,7 @@ static int push_dav(int nr_spec, const char **specs)
>   		strvec_push(&child.args, specs[i]);
>   
>   	if (run_command(&child))
> -		die(_("git-http-push failed"));
> +		die(_("the command '%s' failed"), "git-http-push");
>   	return 0;
>   }
>   
> diff --git a/setup.c b/setup.c
> index 04ce33cdcd4..30a4b81257d 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1506,12 +1506,12 @@ int daemonize(void)
>   		case 0:
>   			break;
>   		case -1:
> -			die_errno(_("fork failed"));
> +			die_errno(_("the function '%s' failed"), "fork");
>   		default:
>   			exit(0);
>   	}
>   	if (setsid() == -1)
> -		die_errno(_("setsid failed"));
> +		die_errno(_("the function '%s' failed"), "setsid");
>   	close(0);
>   	close(1);
>   	close(2);

Why not simply "'%s' failed"?

-- 
An old man doll... just what I always wanted! - Clara
