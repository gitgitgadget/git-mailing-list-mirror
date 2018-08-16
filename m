Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FBAF1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 18:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeHPVQ5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 17:16:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33598 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeHPVQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 17:16:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id v90-v6so1787616wrc.0
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Tra9ntr9NJFpviASqIDJ+pO9mQx9RepeZgA34gk1Hoc=;
        b=tR7XBD6NUoFooWt5M5YYpt587Z7h0lu0Hubpn3S1vDcpPL0Lit3ig+I8+XKwnhXriO
         nPfXTTeKRN7X32fkX4IEpwdebkPVxQXjb11NMDyV9MibSEiGhdhmUT5cbEGERNHsFrGX
         MbWqBNw6cvKzFG2v0kCmdN7WQdF56ZGe0+b84s0Tu2D4NF8dnPKIBrkZPtvWmaqeDYI/
         UnrmozUO36HtrN9vLhmoC3oqmptmmIMS8Bx5KKy/kb1f+rlAUHt0zgg3XH8x3vH6QCC5
         DaT1iYFtNVOt24gKggEj3p2dSi1t27f2J7ZTxEy1zsJ5hzJuQ1obA83BVMWKyq4P6IzB
         zhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Tra9ntr9NJFpviASqIDJ+pO9mQx9RepeZgA34gk1Hoc=;
        b=Guzcifrk+ODmJ1/19Y82QHcMQcpQ8E97ER7jXcO21VPaSDrd9yxjR9q5WVZUFcOMNA
         lfjvVxIO4XPk4pS9leBpTwiZyyDf+Gv2p/GrUrfQlM01OhRuWlrpLk0noT3/jQcmiw0v
         ITHJYXtenxnNQuhlzqjIHcvVnUts8o9dEkJsv7EghdbU/NCLDnx6pSAIssqwVPMQlwDM
         XS/6T8+dvFesLewzJGO1ae+j89t3y7kYBC8l879plAMxTIMepu0Uox9ELtnwrD5WNgUh
         b1HJKKea4jpfNCwM2vzGkeO2gHA/Z75uTQxg4qZqt2bIYgafPzqPUZ7Z7hllEq842NRE
         lcbg==
X-Gm-Message-State: AOUpUlHF3hbB3UHNzQz4eSFSLHQFNLFUufnpmJZt9OlliX+ZRkR5khC8
        K5vJE3oXm24CDpyGGx7ziPI=
X-Google-Smtp-Source: AA+uWPwzJLYJjzULjCLpXLGl4wNe/C2/MpDWeL3X6Sn7HH8bMYZj246Z/3qZRWyk0nnoZDVnMb1U0A==
X-Received: by 2002:adf:db11:: with SMTP id s17-v6mr20934866wri.221.1534443410808;
        Thu, 16 Aug 2018 11:16:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 187-v6sm3273755wmr.40.2018.08.16.11.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 11:16:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     samuel.maftoul@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com
Subject: Re: [PATCH] branch: support configuring --sort via .gitconfig
References: <CAPig+cR5cu3cxtpdHsbSSK7xWRpMQh_sv5nvunZrojAOkFeedg@mail.gmail.com>
        <20180816093508.37193-1-samuel.maftoul@gmail.com>
Date:   Thu, 16 Aug 2018 11:16:49 -0700
In-Reply-To: <20180816093508.37193-1-samuel.maftoul@gmail.com> (samuel
        maftoul's message of "Thu, 16 Aug 2018 11:35:08 +0200")
Message-ID: <xmqqva8advn2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

samuel.maftoul@gmail.com writes:

> From: Samuel Maftoul <samuel.maftoul@gmail.com>
>
> Add support for configuring default sort ordering for git branches. Command
> line option will override this configured value, using the exact same
> syntax.

Using the exact same syntax as ...?

> Signed-off-by: Samuel Maftoul <samuel.maftoul@gmail.com>
> ---
>  Documentation/config.txt     |  6 +++++
>  Documentation/git-branch.txt |  5 ++--
>  builtin/branch.c             | 10 +++++++-
>  t/t3200-branch.sh            | 46 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index fd8d27e76..7f7a50123 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1039,6 +1039,12 @@ branch.autoSetupRebase::
>  	branch to track another branch.
>  	This option defaults to never.
>  
> +branch.sort::
> +	This variable controls the sort ordering of branches when displayed by
> +	linkgit:git-branch[1]. Without the "--sort=<value>" option provided, the
> +	value of this variable will be used as the default.
> +	See linkgit:git-for-each-ref[1] field names for valid values.

OK, the answer to the above question is "same syntax as used for the
value of the `branch.sort` configuration variable".

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 1072ca0eb..9767b2b48 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -268,10 +268,11 @@ start-point is either a local or remote-tracking branch.
>  	order of the value. You may use the --sort=<key> option
>  	multiple times, in which case the last key becomes the primary
>  	key. The keys supported are the same as those in `git
> -	for-each-ref`. Sort order defaults to sorting based on the
> +	for-each-ref`. Sort order defaults to the value configured for the
> +	`branch.sort` variable if exists, or to sorting based on the
>  	full refname (including `refs/...` prefix). This lists
>  	detached HEAD (if present) first, then local branches and
> -	finally remote-tracking branches.
> +	finally remote-tracking branches. See linkgit:git-config[1].

OK.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 4fc55c350..bbd006aab 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -74,6 +74,14 @@ define_list_config_array(color_branch_slots);
>  static int git_branch_config(const char *var, const char *value, void *cb)
>  {
>  	const char *slot_name;
> +	struct ref_sorting **sorting_tail = (struct ref_sorting **)cb;
> +
> +	if (!strcmp(var, "branch.sort")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		parse_ref_sorting(sorting_tail, value);
> +		return 0;
> +	}

Hmph.  It is unfortunate that "don't feed me NULL" check is not in
parse_ref_sorting() but is in parse_opt_ref_sorting().  But that is
a separate low-hanging fruit.  The code we see here is correct.

Will queue.  Thanks.
