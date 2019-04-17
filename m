Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAB1120305
	for <e@80x24.org>; Wed, 17 Apr 2019 17:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfDQRCv (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 13:02:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34317 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfDQRCv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 13:02:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so12345106plt.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dw+pQMyTKbidlCZ/EiF522fHc5OsBccHPf/ERakhj38=;
        b=cvH12048T91FzvesHqwZsM1053O18ekzhlgO20/VP47NxYq2XVGmm64xgrjYwlFaf7
         1SX847BdSXO//xQloQaaxS5SnR3i0JO7PX5o3naKmBrTt1lBzfh/CnIqyx1iGkq9xtVw
         fAeQvqtR6upH/6Y4rE6pKPppUbUdOD9uEq9/uo/QQ4+X4+hQ7iDL2DQ6GnlIyh3/0kzO
         EWTPvcTlhEuBhSD8Um0zXL7iT9KiSiX5Cq7NBKquSiGn76MSNWs4C7+q/eogadxLbsbx
         v5cSeE1wbdoLGqx20N1uECXnn9l7dQ16AFKkw7XeWUoUB6q77cvFMlgc7/p6zTJq6Tio
         D4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dw+pQMyTKbidlCZ/EiF522fHc5OsBccHPf/ERakhj38=;
        b=flrgMXKcl4JT4rHGP2XQKhe0QPaDzBZOQf14O7g6z6CkvgMcudIVSeIsBIHiIjsOEt
         Ij+txbrWU87SrLkBgZIuIxVFoT1ma+td0ZiJQKoZGl/FsAm99eKwy2iwyzlP2ys661zZ
         6SUSWvO9NhN4glwX1T/p2vOeB+d/PrhfAOC+VHLHJDKF1TULzT8n9edazkMiUB6YWBP4
         T9g1URWQGv/algBeGYbsRk9P7pgMbydXvuwLO0EXQ/o/E6+N2KfcmnXiImjNVqy1C6RE
         t8F3iE0FxBBDTUp5OTphhOZPiDPyYgt8hamcWANP2gaqH/c/xU3yiRi0PMYOGK/5BcT6
         /16w==
X-Gm-Message-State: APjAAAW95zeCZ3Ohf05vXvxDY36JEYxqnYxSVcxzF5EzCj+aPZV9Fn/J
        m0P2lxskWMAbxIEiRfjU32Q=
X-Google-Smtp-Source: APXvYqyrUryUnH+VViNgXn4Zt63qfYhOyIdnNdNjHIp9wB1gkJwi2n19HbL63fExeWv6ffp/am7X6w==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr87956301pla.306.1555520570440;
        Wed, 17 Apr 2019 10:02:50 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id u5sm41489424pfa.169.2019.04.17.10.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:02:49 -0700 (PDT)
Date:   Wed, 17 Apr 2019 10:02:47 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v10 09/10] sequencer.c: save and restore cleanup mode
Message-ID: <20190417170247.GA9636@dev-l>
References: <cover.1553150827.git.liu.denton@gmail.com>
 <20190417102330.24434-1-phillip.wood123@gmail.com>
 <20190417102330.24434-10-phillip.wood123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417102330.24434-10-phillip.wood123@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 17, 2019 at 11:23:29AM +0100, Phillip Wood wrote:
> From: Denton Liu <liu.denton@gmail.com>

We should drop this line before applying the patch since Phillip did all
of the hard work for this patch and he's the primary author.

> 
> If the user specifies an explicit cleanup mode then save and restore it
> so that it is preserved by 'git cherry-pick --continue'.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index b049951c34..3f4b0896e3 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -535,6 +535,24 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
>  		die(_("Invalid cleanup mode %s"), cleanup_arg);
>  }
>  
> +/*
> + * NB using int rather than enum cleanup_mode to stop clang's
> + * -Wtautological-constant-out-of-range-compare complaining that the comparison
> + * is always true.
> + */
> +static const char *describe_cleanup_mode(int cleanup_mode)
> +{
> +	static const char *modes[] = { "whitespace",
> +				       "verbatim",
> +				       "scissors",
> +				       "strip" };
> +
> +	if (cleanup_mode < ARRAY_SIZE(modes))
> +		return modes[cleanup_mode];
> +
> +	BUG("invalid cleanup_mode provided (%d)", cleanup_mode);
> +}
> +
>  void append_conflicts_hint(struct index_state *istate,
>  			   struct strbuf *msgbuf)
>  {
> @@ -2366,7 +2384,10 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>  		opts->allow_rerere_auto =
>  			git_config_bool_or_int(key, value, &error_flag) ?
>  				RERERE_AUTOUPDATE : RERERE_NOAUTOUPDATE;
> -	else
> +	else if (!strcmp(key, "options.default-msg-cleanup")) {
> +		opts->explicit_cleanup = 1;
> +		opts->default_msg_cleanup = get_cleanup_mode(value, 1);
> +	} else
>  		return error(_("invalid key: %s"), key);
>  
>  	if (!error_flag)
> @@ -2770,6 +2791,11 @@ static int save_opts(struct replay_opts *opts)
>  		res |= git_config_set_in_file_gently(opts_file, "options.allow-rerere-auto",
>  						     opts->allow_rerere_auto == RERERE_AUTOUPDATE ?
>  						     "true" : "false");
> +
> +	if (opts->explicit_cleanup)
> +		res |= git_config_set_in_file_gently(opts_file,
> +				"options.default-msg-cleanup",
> +				describe_cleanup_mode(opts->default_msg_cleanup));
>  	return res;
>  }
>  
> -- 
> 2.21.0
> 
