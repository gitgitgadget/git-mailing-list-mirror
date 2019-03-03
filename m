Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A0720248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCCBWb (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:22:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46660 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCCBWa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:22:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so1688228wrs.13
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=gkakzaOatHOQ1XZtOiG1hcGdKBDkZ6wXMkUJjD0G/58=;
        b=HisqzgqyANG6rg8KKVkPhxoPcc4Xp1WKWilCBiOfTbn6loIF/fWjdcsKXZksLAtBOq
         2azkj8YfP6sYAkFy5iaYlSpv/KqV+853O5/9hW5bTPNfky25ZEWv+6VpRPt4uauPGwFV
         79lYVGnjmnTshBmTT20Qq7ncBmhYn8bMeQxLxHSRqf85cK8H51X3ErEw8e9R9cXk65FX
         fxc1O0saifWRse5JnZC/1qu+JzMc2beVLYczrI4lBESzLB2cu2npsPNlL1WNzX7QVP8D
         GFfjKHxUQJoIYQvixfA9Yu73C+qH0lE9cbYFxDXma8IWpxwbi1r3zlwFxtO1kEYHX969
         x5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=gkakzaOatHOQ1XZtOiG1hcGdKBDkZ6wXMkUJjD0G/58=;
        b=kw8MmdNqR9pwMG0zRLR2YiS0pewIXOhCSGCgdJpYIIGWKSBGYxbLZ8AktRaqhu7Ft1
         KYJSRo4A+8dTtamnK6WeeRC+s99RNRHGXgpMu7bnQ4yvLu5RLVPoLKeqb2o4NG7ZGpLm
         5bUwJkvun8Ae+RbcGr6BfQcpgNDLOEm4rQcnDTHE0FIlNuViXI8eIAteby0igm05Firz
         Btr+RgAZTkuqmxkqCFnN1l1C6IGh2yqFxVmA0oFWUgSbhZrbTbOiiV5kxXOZmzWlkKeo
         Dbmf0iYBfF+0bjV2O8fYLzZDXl94pdMWAkLAv/YreNkU5MXwYsdebgu5EDV3z4y1NrkZ
         1MQQ==
X-Gm-Message-State: APjAAAXwWk1dAxXqZF3Q1U35pKhmW7Kg62YvqyIDDHeB78PZ8FqWvn/+
        FIundhJqcyFqp4z+m6T7lyyodZe+va0=
X-Google-Smtp-Source: APXvYqxf0kt04adlEOPawrPOgBcMgL6dCTNNSyivPIFXHg0kwvnksgPdDu0I1FlQjtghPBW30M6IFA==
X-Received: by 2002:adf:face:: with SMTP id a14mr8650585wrs.320.1551576148393;
        Sat, 02 Mar 2019 17:22:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c2sm1833230wrt.93.2019.03.02.17.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:22:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rusty Russell <rusty@rustcorp.com.au>, git@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
Subject: Re: `git status -u no` suppresses modified files too.
References: <87y36rcanq.fsf@rustcorp.com.au>
        <20190208024800.GA11392@sigill.intra.peff.net>
Date:   Sun, 03 Mar 2019 10:22:27 +0900
Message-ID: <xmqqfts44ur0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is a pretty horrible UI trap. Most of the time with pathspecs we
> require them to be on the right-hand side of a "--" unless the paths
> actually exist in the filesystem. But then, in most of those cases we're
> making sure they're not ambiguous between revisions and paths. So maybe
> it's overkill here. I dunno. But the patch below certainly makes what's
> going on in your case less subtle:
>
>   $ git status -u no
>   fatal: no: no such path in the working tree.
>   Use 'git <command> -- <path>...' to specify paths that do not exist locally.

Yeah.  It was a mistake that we gave a short-and-sweet "-u" too
hastily to a relatively useless form that does not take any argument
and ended up needing to resort to the optional-arg trick.

> You do still have to figure out why it wasn't stuck to "-u", though.

Sorry, but I am not sure what you mean by this comment.

Your illustration patch lets you say "no, 'no' is not a pathspec"
with

	git status -u no --

and "I want the unadorned -u and am asking about stuff in the 'no'
subdirectory" with

	git status -u -- no

but in the former, it would not make 'no' an arg to '-u' by saying
"'no' is not a pathspec", would it?

> ---
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 2986553d5f..7177d7d82f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1300,6 +1300,16 @@ static int git_status_config(const char *k, const char *v, void *cb)
>  	return git_diff_ui_config(k, v, NULL);
>  }
>  
> +static void verify_pathspec(const char *prefix, const char **argv)
> +{
> +	while (*argv) {
> +		const char *arg = *argv++;
> +		if (!strcmp(arg, "--"))
> +			return;
> +		verify_filename(prefix, arg, 0);
> +	}
> +}
> +
>  int cmd_status(int argc, const char **argv, const char *prefix)
>  {
>  	static int no_renames = -1;
> @@ -1351,7 +1361,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  	status_init_config(&s, git_status_config);
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_status_options,
> -			     builtin_status_usage, 0);
> +			     builtin_status_usage, PARSE_OPT_KEEP_DASHDASH);
>  	finalize_colopts(&s.colopts, -1);
>  	finalize_deferred_config(&s);
>  
> @@ -1362,6 +1372,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  	    s.show_untracked_files == SHOW_NO_UNTRACKED_FILES)
>  		die(_("Unsupported combination of ignored and untracked-files arguments"));
>  
> +	verify_pathspec(prefix, argv);
>  	parse_pathspec(&s.pathspec, 0,
>  		       PATHSPEC_PREFER_FULL,
>  		       prefix, argv);
