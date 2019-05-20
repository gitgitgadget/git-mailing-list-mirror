Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9EB1F461
	for <e@80x24.org>; Mon, 20 May 2019 13:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfETN4S (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 09:56:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40649 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfETN4S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 09:56:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id j12so24019277eds.7
        for <git@vger.kernel.org>; Mon, 20 May 2019 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=hVtvALA2LndXtirSos/F/Rvx59mJql12qi7yCEZWimg=;
        b=srhcafY3Y4M3eIj/DA5O8VWjVXWUDPgGOuq1d/nZn5AOOU6GFOQU8TYlhZOnA3ImfQ
         rlyFTaS+ekLXy9tWqVqFDm2GobmGxS4Gt/MFyYEeq43ELdKaYl2UKF45irH7yMCGu17O
         c4nHtLuL/Mht1saGcnpVF3g3fJE8KXItqxb7GP1TJ0BVjDHOQV5Ku7Fq+oKL+AsQv1Wp
         lsuvXqKUpSt3PvRK3SQDPyFMKAcvHwbfVvf4UcbxIc8Xtdvp++JbmTE59gUhLQb+rEFl
         HVSQR6K0xGZ/zsTcn1SL5TbJGXAe2CO/dekysQuP8+Y9EjVTTWmktbRuF2vQRgS6R1+M
         ea9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=hVtvALA2LndXtirSos/F/Rvx59mJql12qi7yCEZWimg=;
        b=YiDq/Mgxzq9UdWD2hGY2TNUjzHq12wV/4F12fLvGiJEVUiHfUas7NFBzE9NXzSiYnq
         xTI4ONSNHDVX/jgd9rBtjSHA8XduVIKgrkEFQDskSf0/YBTLG4PpgcVyX2Wibpizh7/M
         sWto6+4nd7RUlR73V81pSqaa7oi0twOcvLGjvtjXt1JT1cw8S2d/3As2vu8s1ZcDxOuw
         fdI9IbEH6Khat/F6AV+Jl+XjrZKnnnl79fxngDLdpMlfSuh65ILGKedbyOKeV3ebHttZ
         c+Hab+t5RZdGTyVpeqnapF06BbZAuKdg1obdOOW1Yi2jmgS+LWUcjcG6L/6ZjEqHs1WI
         b1mw==
X-Gm-Message-State: APjAAAUBJ+Ll1aAu8AwR0eP2rU9EXp6HE2FpYxVySfyGRgDSk5+Xpte4
        tPjE5d46OTF4BykMqCsE4cc=
X-Google-Smtp-Source: APXvYqw9jkT5YENETczWEFqfvcyEjmg8vfg8u0KkzoPhpV1213XxbqNMHvgUhqYSywyXEe9tdX+WAA==
X-Received: by 2002:a50:911a:: with SMTP id e26mr22368673eda.25.1558360576351;
        Mon, 20 May 2019 06:56:16 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id 1sm3126640eju.9.2019.05.20.06.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 06:56:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] clone: auto-enable git-credential-store when necessary
References: <20190519050724.GA26179@sigill.intra.peff.net> <20190519051604.GC19434@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190519051604.GC19434@sigill.intra.peff.net>
Date:   Mon, 20 May 2019 15:56:14 +0200
Message-ID: <87imu5ut4x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 19 2019, Jeff King wrote:

> If the user clones with a URL containing a password and has no
> credential helper configured, we're stuck. We don't want to write the
> password into .git/config because that risks accidentally disclosing it.
> But if we don't record it somewhere, subsequent fetches will fail unless
> the user is there to input the password.
>
> The best advice we can give the user is to set up a credential helper.
> But we can actually go a step further and enable the "store" helper for
> them. This still records the password in plaintext, but:
>
>   1. It's not inside the repo directory, which makes it slightly less
>      likely to be disclosed.
>
>   2. The permissions on the storage file are tighter than what would be
>      on .git/config.
>
> So this is generally a security win over the old behavior of writing it
> into .git/config. And it's a usability win over the more recent behavior
> of just forgetting the password entirely.
>
> The biggest downside is that it's a bit magical from the user's
> perspective, because now the password is off in some other file (usually
> ~/.git-credentials, but sometimes in $XDG_CONFIG_HOME). Which
> complicates things if they want to purge the repo and password, for
> example, because now they can't just delete the repository directory.
>
> The file location is documented, though, and we point people to the
> documentation. So perhaps it will be enough (and better still, may lead
> to them configuring a more secure helper).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> If we do decide this is too magical, I think the best alternate path is
> to advise them on credential helpers, and how to seed the password into
> the helper (basically configure the helper and then "git fetch"
> should work).
>
> One other thing I wondered: if they do have a helper configured this
> patch will omit the advice entirely, but we'll still print the warning.
> Is that useful (to remind them that passwords in URLs are a bad thing),
> or is it just annoying?
>
>  builtin/clone.c            | 19 ++++++++++++++++---
>  credential.c               | 13 +++++++++++++
>  credential.h               |  6 ++++++
>  t/t5550-http-fetch-dumb.sh |  2 +-
>  4 files changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 15fffc3268..94d2659154 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -31,6 +31,7 @@
>  #include "packfile.h"
>  #include "list-objects-filter-options.h"
>  #include "object-store.h"
> +#include "credential.h"
>
>  /*
>   * Overall FIXMEs:
> @@ -894,8 +895,14 @@ static int dir_exists(const char *path)
>  static const char sanitized_url_advice[] = N_(
>  "The URL you provided to Git contains a password. It will be\n"
>  "used to clone the repository, but to avoid accidental disclosure\n"
> -"the password will not be recorded. Further fetches from the remote\n"
> -"may require you to provide the password interactively.\n"
> +"the password will not be recorded in the repository config.\n"
> +"Since you have no credential helper configured, the \"store\" helper\n"
> +"has been enabled for this repository, and will provide the password\n"
> +"for further fetches.\n"
> +"\n"
> +"Note that the password is still stored in plaintext in the filesystem;\n"
> +"consider configuring a more secure helper. See \"git help gitcredentials\"\n"
> +"and \"git help git-credential-store\" for details.\n"
>  );
>
>  int cmd_clone(int argc, const char **argv, const char *prefix)
> @@ -1090,7 +1097,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	sanitized_repo = transport_strip_url(repo, 0);
>  	if (strcmp(repo, sanitized_repo)) {
>  		warning(_("omitting password while storing URL in on-disk config"));
> -		advise(_(sanitized_url_advice));
> +		if (!url_has_credential_helper(sanitized_repo)) {
> +			strbuf_addf(&key, "credential.%s.helper",
> +				    sanitized_repo);
> +			git_config_set(key.buf, "store");
> +			strbuf_reset(&key);
> +			advise(_(sanitized_url_advice));
> +		}
>  	}
>  	strbuf_addf(&key, "remote.%s.url", option_origin);
>  	git_config_set(key.buf, sanitized_repo);
> diff --git a/credential.c b/credential.c
> index 62be651b03..0a70edcee5 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -372,3 +372,16 @@ void credential_from_url(struct credential *c, const char *url)
>  			*p-- = '\0';
>  	}
>  }
> +
> +int url_has_credential_helper(const char *url)
> +{
> +	struct credential c = CREDENTIAL_INIT;
> +	int ret;
> +
> +	credential_from_url(&c, url);
> +	credential_apply_config(&c);
> +	ret = c.helpers.nr > 0;
> +
> +	credential_clear(&c);
> +	return ret;
> +}
> diff --git a/credential.h b/credential.h
> index 6b0cd16be2..e6d6d6fa40 100644
> --- a/credential.h
> +++ b/credential.h
> @@ -32,4 +32,10 @@ void credential_from_url(struct credential *, const char *url);
>  int credential_match(const struct credential *have,
>  		     const struct credential *want);
>
> +/*
> + * Return true if feeding "url" to the credential system would trigger one
> + * or more helpers.
> + */
> +int url_has_credential_helper(const char *url);
> +
>  #endif /* CREDENTIAL_H */
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index d8c85f3126..2723e91ae0 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -70,7 +70,7 @@ test_expect_success 'username is retained in URL, password is not' '
>  	! grep pass url
>  '
>
> -test_expect_failure 'fetch of password-URL clone uses stored auth' '
> +test_expect_success 'fetch of password-URL clone uses stored auth' '
>  	set_askpass wrong &&
>  	git -C clone-auth-none fetch &&
>  	expect_askpass none

I've only looked at this very briefly, there's a regression here where
you're assuming that having a configured credential helper means it
works.

I.e. I have a ~/.gitconfig where I point to some-gnome-thing-or-other
what doesn't exist on my VPS in my ~/.gitconfig, cloning just warns
about it being missing, but will store the password in the repo.

With this you detect that I have the helper, don't store it, but then my
helper doesn't work, whereas this worked before.

That's an X-Y problem of config includes being rather limited (now I'm
just putting up with the error), but I expect this'll apply to others.
