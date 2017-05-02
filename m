Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D992207D6
	for <e@80x24.org>; Tue,  2 May 2017 00:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750876AbdEBAJA (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 20:09:00 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35321 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbdEBAJA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 20:09:00 -0400
Received: by mail-pg0-f42.google.com with SMTP id o3so46488031pgn.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 17:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N18JKYSl/HjQa3cnie18AwJ0Sizvip0l/02M+WNdbyg=;
        b=C9EunMKQMeoDNwzGVa0CYPoixnOoLNe9NOZShccX7v7OBKRvtxQmViG0gN6T2A4rR+
         w3sjcjt5cZTWv4qnfYWTErCbihmNO54EwwIauKnKsFZNC66XJO/Os/UJl8m52L1Lgufx
         94g7Dor9JIp7w2rLtVCAwQPbwxKXtt9Uc53+tevitdeZBB2cXqCRotN8sbgWYD4FcIHF
         f6MB0ZTr/hxawgF55HKJDl96pLIyxmwLDkpK+qqKUqq/cvKUkKcBsUREoyndICL2ryXY
         G+ApuGVkygs729q7GW9eqTlYlZSJ3j7i7QAzpoDd5NtOUJ6J4g30/wkspbGUzWabdzHy
         wpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N18JKYSl/HjQa3cnie18AwJ0Sizvip0l/02M+WNdbyg=;
        b=qOj2wraVrMdRnCiFciIWugfedvSrz/ZMjs7qgCb78z393tuSFV0IZyMS6xMuwQGBkx
         6YbVFS1QQsNE+EiwNu2H6G39UhwdxjK90cWwW5KH7hHMAY45p3jhcmhz1DUZ73ajcCNZ
         ukQZpaGER+ztWuGeEoK6ze1dVKzK6e/fyg4IC+ne0DqNrofQJ7fDBZuaZ6b3zqTKVJyw
         mbSLYVf5VeO0t+MJB/wFF6jrjOQ8uHXo6niwEAYILlNFkUKt7qposun6fqoDwDhE4l5N
         1I/YHh3Hq/FbVAojoesh9gTh6JSA8AA4MXxKEeV9HmE/GQMx1c98jliNBzUQXbL5HwCo
         165Q==
X-Gm-Message-State: AN3rC/45X5G3cSTCLbNMj58aAg5EQaD5q+d+LgrhrjLWRjWyNr15RzJ7
        e/PyZpn7xjEhUMvsv0vZPQ==
X-Received: by 10.99.167.3 with SMTP id d3mr29308548pgf.70.1493683739306;
        Mon, 01 May 2017 17:08:59 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:61ee:b5d7:71fe:5285])
        by smtp.gmail.com with ESMTPSA id t2sm24381774pfl.34.2017.05.01.17.08.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 17:08:57 -0700 (PDT)
Date:   Mon, 1 May 2017 17:08:56 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: handle empty config values in -c
Message-ID: <20170502000856.GI39135@google.com>
References: <20170502000515.GU28740@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502000515.GU28740@aiede.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01, Jonathan Nieder wrote:
> "git clone --config" uses the following incantation to add an item to
> a config file, instead of replacing an existing value:
> 
> 	git_config_set_multivar_gently(key, value, "^$", 0)
> 
> As long as no existing value matches the regex ^$, that works as
> intended and adds to the config.  When a value is empty, though, it
> replaces the existing value.
> 
> Noticed while trying to set credential.helper during a clone to use a
> specific helper without inheriting from ~/.gitconfig and
> /etc/gitconfig.  That is, I ran
> 
> 	git clone -c credential.helper= \
> 		-c credential.helper=myhelper \
> 		https://example.com/repo
> 
> intending to produce the configuration
> 
> 	[credential]
> 		helper =
> 		helper = myhelper
> 
> Without this patch, the 'helper =' line is not included and the
> credential helper from /etc/gitconfig gets used.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Thoughts?

After reading this I'm still a little fuzzy on why the empty helper line
is needed to avoid using the credential helper from /etc/gitconfig.

> 
> Thanks,
> Jonathan
> 
>  builtin/clone.c         | 4 +++-
>  t/t5611-clone-config.sh | 8 ++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index de85b85254..a6ae7d6180 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -773,7 +773,9 @@ static int checkout(int submodule_progress)
>  
>  static int write_one_config(const char *key, const char *value, void *data)
>  {
> -	return git_config_set_multivar_gently(key, value ? value : "true", "^$", 0);
> +	return git_config_set_multivar_gently(key,
> +					      value ? value : "true",
> +					      CONFIG_REGEX_NONE, 0);
>  }
>  
>  static void write_config(struct string_list *config)
> diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
> index e4850b778c..39329eb7a8 100755
> --- a/t/t5611-clone-config.sh
> +++ b/t/t5611-clone-config.sh
> @@ -19,6 +19,14 @@ test_expect_success 'clone -c can set multi-keys' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'clone -c can set multi-keys, including some empty' '
> +	rm -rf child &&
> +	git clone -c credential.helper= -c credential.helper=hi . child &&
> +	printf "%s\n" "" hi >expect &&
> +	git --git-dir=child/.git config --get-all credential.helper >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'clone -c without a value is boolean true' '
>  	rm -rf child &&
>  	git clone -c core.foo . child &&
> -- 
> 2.13.0.rc1.294.g07d810a77f
> 

-- 
Brandon Williams
