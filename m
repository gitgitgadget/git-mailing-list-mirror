Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089E29AB02
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771358475; cv=none; b=ssCLd82/zxzkH6BYYMJI7eRvWeXNe2Rj2HQoUgofqCtHXvi3bqEON1ZZOq3wX3M880vgULNi2NkFBqs/+GY3jF7GAJEQ7nLfyvEqdonAjXaXQsvm+L8L4ZIW+TA3OqJqHjyDWrf7LxHS7QuXXRqtRn4m/9nQV8oe1aikjfH7nT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771358475; c=relaxed/simple;
	bh=DJA8XA4ceetsXXprmxVOXicn/q5tfHQRi0WUsQ9BZTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fLRin5R0Y9q3qhK/WCKVbp7htJRTcFb+E+F/DARXtkdE52793l4MxYnw0iXpZ92gnPhOKMhVGBfUFRpPT7cYzJ0bvJaIvSu54JL+A6rtYkVPxEMK5ot3Ht9GMGSGDl8pnuYeMzXiDa/ir3hylj28VFgN5bzGOo8rMMmWYH8m4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gjtTjKLY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w8a1mys2; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gjtTjKLY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w8a1mys2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 160421D00185;
	Tue, 17 Feb 2026 15:01:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 17 Feb 2026 15:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771358472; x=1771444872; bh=P+a117H8ij
	j8uzuvXsm2TN39P44LWzpa0FHYLuYJGoY=; b=gjtTjKLYUHND+7NjS09T8yxc5F
	c1Rr2N3yBOtUDX9fVoBo2XcJXecACEiyMR27QM8ZGufYhAeQXR/0Gf5v20vy8SGA
	2JvDLFvLPSWpSj2w+tEkA2Lh8IzP6uK4lj8dspsk+jTuJjRAeXUEbAkIEUZ94hKE
	gLX8o+evfgu+WQcGnGSmCQQQ8s8q/2b0vxU6URy3RJLwXY5dtUGG2q+apmO4HZ4Q
	rM6Dq31bG3mzbCNW1ck8/CXxwNdsmqMiTO3BRJR9HCQgJQ/JUoNweWVFviOWp3LT
	bqPPkRHTz3KGsgj061fn0DbtvSwjxLNB6FcHWztu8oW9Nmy+0hy20vvP/y2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771358472; x=1771444872; bh=P+a117H8ijj8uzuvXsm2TN39P44LWzpa0FH
	YLuYJGoY=; b=w8a1mys27QX3wjGx/syggPphkYevW7n2Cvt5l/S8u4JQCXYlg9O
	VIwwRNymosG/+sMlywsnIX/Y6oLjyQCmlSB9x5/QiXe5PxSCFHTPhnoSeHmM4swp
	VaFCPAlJVDc86XSdmCw+81G1RssvyqcYkPJoPHkETSzZWXRo/M5JOioi3KzbxzCJ
	GLmFfV1u5Aq0aanwkDmFlN2rbTxVWCY+vwKTTa3XcbS/KLwVFaYC59yuWqizaX1O
	ZzAUBu1q5gzHqBNbDTD5dYNcBQkPl2+ILhfhXVBATYe4xFIRf/tFjLAI21v+0I5b
	ybyAGAnWfvyy4lVLEEYUJx1h3CQvazLvAmQ==
X-ME-Sender: <xms:CMmUaXaIoo6jLOGeJwimWQdTm7f5HN9gB6bEjNCIGSe-xnylN44UjA>
    <xme:CMmUaaFfB9rbhwZn4cMp_mS3lG0ByoxF7YGBCQ6UzjUBFYBtUj7Q9DP0Q9m2eP2qh
    1jxKgjdaQzXqIZqa3N5yn3fHJgSmrWAu4IF1G-0JbUWZXgowBO_lQ>
X-ME-Received: <xmr:CMmUaTy4PYSMe81G57A5RP4IlPW4WVCogkxT8F6NQ0G1o37kKGV9o1qF4AAldUZnzgSuz5MYKtBlrJ6VMsXRkF2E_38J4tBK6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CMmUaUnJCoV9hEVoANMZuzdElcLYBFNlrHSGUAOaR5A-5I7a59u7bw>
    <xmx:CMmUaUkZMZqmVx9Plca1_HJaXpHkTuMRW0wNaJF9OHSJzMnUfcefwA>
    <xmx:CMmUaex4G_BP8bwYxIt2n5ebV1bVTgOXxzNmnsV8QiYs0K-RuuntsA>
    <xmx:CMmUaRr77hkKIedIi8MTcHHNyNfsf5L513IM4JDupxUyeHn6sy3z3w>
    <xmx:CMmUaWXt0Ti6Im5RLVHNo1aWAF1l4_ATPv-vrwZxU8ruTatLNEVmogNh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 15:01:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org,  peff@peff.net,  "D . Ben Knoble"
 <benknoble@gmail.com>,  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5 4/4] completion: fix zsh alias listing for subsection
 aliases
In-Reply-To: <20260216161513.2533141-5-jonatan@jontes.page> (Jonatan
	Holmgren's message of "Mon, 16 Feb 2026 17:15:13 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260216161513.2533141-1-jonatan@jontes.page>
	<20260216161513.2533141-5-jonatan@jontes.page>
Date: Tue, 17 Feb 2026 12:01:10 -0800
Message-ID: <xmqqecmjb0mx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonatan Holmgren <jonatan@jontes.page> writes:

> The zsh completion function __git_zsh_cmd_alias() uses 'git config
> --get-regexp' to enumerate aliases and then strips the "alias." prefix
> from each key. For subsection-style aliases (alias.name.command), this
> leaves "name.command" as the completion candidate instead of just
> "name".
>
> The bash completion does not have this problem because it goes through
> 'git --list-cmds=alias', which calls list_aliases() in C and already
> handles both alias syntaxes correctly. However, zsh needs both the
> alias name and its value for descriptive completion, which
> --list-cmds=alias does not provide.

OK.  It is a natural question to ask why it is insufficient to use
what bash side happily uses, and the above gives a good explanation.

> Add a hidden --aliases-for-completion option to 'git help', following
> the existing --config-for-completion pattern. It outputs NUL-separated
> "name\nvalue" pairs using list_aliases(), which correctly resolves both
> the traditional (alias.name) and subsection (alias.name.command)
> formats. Update __git_zsh_cmd_alias() to use it.

Seeing that "--config-for-completion" is used for bash, I wonder if
it would be a good follow-up topic to rewrite the bash completion to
also use "--aliases-for-completion" (and possibly drop the need to
support "git --list-cmds=alias" command).  But that is clearly
outside the scope of this topic.

> ---

Missing sign-off.

>  builtin/help.c                        | 15 +++++++++++++++
>  contrib/completion/git-completion.zsh |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index c09cbc8912..f02308a391 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -54,6 +54,7 @@ static enum help_action {
>  	HELP_ACTION_DEVELOPER_INTERFACES,
>  	HELP_ACTION_CONFIG_FOR_COMPLETION,
>  	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
> +	HELP_ACTION_ALIASES_FOR_COMPLETION,
>  } cmd_mode;
>  
>  static char *html_path;
> @@ -90,6 +91,8 @@ static struct option builtin_help_options[] = {
>  		    HELP_ACTION_CONFIG_FOR_COMPLETION, PARSE_OPT_HIDDEN),
>  	OPT_CMDMODE_F(0, "config-sections-for-completion", &cmd_mode, "",
>  		    HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION, PARSE_OPT_HIDDEN),
> +	OPT_CMDMODE_F(0, "aliases-for-completion", &cmd_mode, "",
> +		    HELP_ACTION_ALIASES_FOR_COMPLETION, PARSE_OPT_HIDDEN),
>  
>  	OPT_END(),
>  };
> @@ -691,6 +694,18 @@ int cmd_help(int argc,
>  			       help_format);
>  		list_config_help(SHOW_CONFIG_SECTIONS);
>  		return 0;
> +	case HELP_ACTION_ALIASES_FOR_COMPLETION: {
> +		struct string_list alias_list = STRING_LIST_INIT_DUP;
> +		opt_mode_usage(argc, "--aliases-for-completion",
> +			       help_format);
> +		list_aliases(&alias_list);
> +		string_list_sort(&alias_list);
> +		for (size_t i = 0; i < alias_list.nr; i++)
> +			printf("%s%c%s%c", alias_list.items[i].string, '\n',
> +			       (char *)alias_list.items[i].util, '\0');
> +		string_list_clear(&alias_list, 1);
> +		return 0;
> +	}
>  	case HELP_ACTION_CONFIG:
>  		opt_mode_usage(argc, "--config", help_format);
>  		setup_pager(the_repository);
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
> index f5877bd7a1..c32186a977 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -202,7 +202,7 @@ __git_zsh_cmd_common ()
>  __git_zsh_cmd_alias ()
>  {
>  	local -a list
> -	list=(${${(0)"$(git config -z --get-regexp '^alias\.*')"}#alias.})
> +	list=(${(0)"$(git help --aliases-for-completion)"})
>  	list=(${(f)"$(printf "%s:alias for '%s'\n" ${(f@)list})"})
>  	_describe -t alias-commands 'aliases' list && _ret=0
>  }
