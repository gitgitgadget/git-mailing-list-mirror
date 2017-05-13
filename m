Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3E3201A7
	for <e@80x24.org>; Sat, 13 May 2017 00:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757785AbdEMAEq (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 20:04:46 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34276 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757694AbdEMAEp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 20:04:45 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so8560286pfk.1
        for <git@vger.kernel.org>; Fri, 12 May 2017 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FUR7RMF+nGm1p1JYHrLwoqQ8kjObFaASI6CFuBZwCUs=;
        b=NycPmmasj7UrYkZEVC4kMc5LSurpfm+6y5xF5fM9Ea30DQT5UImjjupLX2L1sG5LEv
         y55OPwGP3NiK3aUtUYVNho9W0nqixQAV3N+bjISd9+bcwwgKSmSZvpGuz9L+WN/Y5WS7
         XecVEfE8d8l4xEX/A88scaTMTqG+PBdtX4qHHCVuwX+dMdP4Zsj+GNLg214WnqIdSk/3
         iUSUo9ePBcB8OoGUeSrl0PG+l/dWmqvicZdLac1FLcKUpheGN5eaAl7Afen4KKehQ8u0
         xC6RWYxdmm+aLvz9g0ZY0PeHqQ5ZFWGRtvrAUSgIQN/riUy+j6FYXYAQqUZ8DTzSafv7
         czTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FUR7RMF+nGm1p1JYHrLwoqQ8kjObFaASI6CFuBZwCUs=;
        b=DkmxgqG0jW6FO/jRKF9vTp/bdAdq7/C82EzxdxEFJQ22fhL8Le7EaZhezqhQLwzLvD
         YtFW8jBIcJLa8kO7STrjb1mKo3iGnDt4dAvZzzCFC7XSo0vlNs3pwUPereZwZyIEhwl6
         oQIP6hBPF3rPz/GxcHjVLH1YZGh8qKBgj2gtRY/JI3a+fErN9g+d6iu61a0tVxGAxFqP
         WUyET2lOLTzoOFk+1w5ZT5vZj61GDO7U/SvzlqniwcM8LnVrmNPOVyjQNpzMuPZCtA8S
         vkTZkTIh+JDmxXuixeCRYtlrv7qHAdAMjZA5MDigW1+qkscFNObtFhx5yhZWdLIeTJev
         Od9A==
X-Gm-Message-State: AODbwcC56WMN80CGau2KkkhdRJX00ZArxfJjvqkEepAg+73ORL/ySODz
        MgtWWE++aIiVhx7K/Pg=
X-Received: by 10.84.233.199 with SMTP id m7mr9168086pln.108.1494633884885;
        Fri, 12 May 2017 17:04:44 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:fcb1:2bc1:55ad:11f1])
        by smtp.gmail.com with ESMTPSA id e16sm7844935pfk.100.2017.05.12.17.04.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 17:04:44 -0700 (PDT)
Date:   Fri, 12 May 2017 17:04:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Josh Hagins <hagins.josh@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] config: complain about --local outside of a git repo
Message-ID: <20170513000442.GH27400@aiede.svl.corp.google.com>
References: <CANuW5x0pBwfQeha50mxN8pVQKm67u_b3UKTCQ8ZbJA6FUGvYbw@mail.gmail.com>
 <20170512203436.fcoqauphzvox2sgv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170512203436.fcoqauphzvox2sgv@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Subject: [PATCH] config: complain about --local outside of a git repo
>
> The "--local" option instructs git-config to read or modify
> the repository-level config. This doesn't make any sense if
> you're not actually in a repository.
>
> Older versions of Git would blindly try to read or write
> ".git/config". For reading, this would result in a quiet
> failure, since there was no config to read (and thus no
> matching config value). Writing would generally fail
> noisily, since ".git" was unlikely to exist. But since
> b1ef400ee (setup_git_env: avoid blind fall-back to ".git",
> 2016-10-20), we catch this in the call to git_pathdup() and
> die("BUG").
>
> Dying is the right thing to do, but we should catch the
> problem early and give a more human-friendly error message.
>
> Note that even without --local, git-config will sometimes
> default to using local repository config. These cases are
> already protected by a similar check.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/config.c | 3 +++
>  1 file changed, 3 insertions(+)

Makes sense.

> diff --git a/builtin/config.c b/builtin/config.c
> index 3a554ad50..ad7c6a19c 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -496,6 +496,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		usage_with_options(builtin_config_usage, builtin_config_options);
>  	}
> 
> +	if (use_local_config && nongit)
> +		die(_("--local only be used inside a git repository"));
> +

The output would be

	fatal: --local only be used inside a git repository

Is that missing a "should" before "only"?

With that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
