Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD98634
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709770213; cv=none; b=WeJqwn4/hXhAcAG0wliG3O2BKDH1gX3ubsrG+jjo09wmepUZ/irU2K47gB92fUZrTUcqoejoqg7LueQt61obu/D+hVUR4KFpct+fM3xThUmgsFdTYVJ5VJEDkb04vy+BvEp9O5DSOexHomL67sOOTeJYnikipBZf/KD3tdJKEvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709770213; c=relaxed/simple;
	bh=xdBJJeXL0/6oiLnDPmD2e7AjIys3ZsDZSAwu7+eAbPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UF2P484KBsk6xHR3f42+Zl2vEm/ueoO4nmVtrMnrbYXd9yulN9SAjHqGtgHV9PeB7siXCsMLEhy/Pietw4dwHyukxBZ1VyIIbJTDtUuZliu3LoNpH58xaaGIF/OzVWyDcaQlPoDg7NW5nXGmetGEgy4bORUwbeREb7WGrJEMPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cjxSOnS6; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cjxSOnS6"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-783045e88a6so30380985a.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 16:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1709770211; x=1710375011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntxz7UuUDT6g6XMIxD1iskt6m5P7etQc6QH9j9KgP4c=;
        b=cjxSOnS6RKVNaruqP5UIIvm1X+YmoWi+fPiLx6kHYUDV/59tOH9ssFbrCGBHF2PFzq
         6ewOHswSPHXSdr7WLncmymvPibESruXjM5PYlEdzoApJbKM+kJLbEP9JDHvca9t6S5r/
         9jCwLA+vgUaJa/egS4mYUsYuoiIVNHs4GLvwf7VesDPD7L31tPoqQIIHCfnTZoR/6UWm
         axd7ykr9CW6dcpPmGqLYHKhjD6eUFDBedk1Rw8JRoE9oFmJrzc+zWvdglAEFwUuqvAjO
         ee4AjtdI7wXRlc1tgHGH/HQauOKiWNZp22Vpoc/wsO6ymuMKTzA3EKFWouIVGvE3cHVJ
         X/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709770211; x=1710375011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntxz7UuUDT6g6XMIxD1iskt6m5P7etQc6QH9j9KgP4c=;
        b=wujXqf6kRv8GNGurp9TzYb2YdJiLL5YZbL/hjjkm8yP58zWSkSiLN8ebhrwcIhv5hr
         Fdys1VpVQcfSnT90DapQf1blH5x+VLAXYdJOjOuaMbPgeYC3tLFNxF8PTY4SUxUul6Cz
         +V9gBcyu9EZzvRApKO8ovG7ZtkUqKKMQGzAQnkfEjxiDjnpepc382hYzxupK2CzaY897
         Xt5irjt71Eca5HlvRrl7uP6HM0AW60kbRMin6x8Yp8UDJ5fPNz5u81FVU+8NQXSTZYcc
         IWIdnTl/1CeCwkjmJalTGfoxx6sUJ1RdtVUk06P3C3CVs+yNjDrjpfLxDjRG4RyOhD9H
         +mYw==
X-Gm-Message-State: AOJu0YzYNO5OYGmvYhtN1bPsSFwKsyBtZEC2ZnfWwnA7qDfJKk6u5Aju
	45BNat/cl8Cr59ov84uDjLsoiG9/JRoFiiylsZfdcAwmuAi99yTiOt6TiG78l8tBiczGG2AyOI3
	moJI=
X-Google-Smtp-Source: AGHT+IHKHWjSZoqw+6lmLn10jh0zFfNHCsMEd3WF51qiDoU98oWpORkN7oT1st8u3uoNkp2ofByp1g==
X-Received: by 2002:a05:620a:1242:b0:786:9b73:3a0b with SMTP id a2-20020a05620a124200b007869b733a0bmr7008671qkl.41.1709770210853;
        Wed, 06 Mar 2024 16:10:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i22-20020a05620a405600b00785da717d64sm7139464qko.111.2024.03.06.16.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 16:10:10 -0800 (PST)
Date: Wed, 6 Mar 2024 19:10:09 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/8] builtin/config: track subcommands by action
Message-ID: <ZekF4aqq+NUf52go@nand.local>
References: <cover.1709724089.git.ps@pks.im>
 <e39774d6495767c6505999bdc33110678139e347.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e39774d6495767c6505999bdc33110678139e347.1709724089.git.ps@pks.im>

On Wed, Mar 06, 2024 at 12:31:50PM +0100, Patrick Steinhardt wrote:
> ---
>  builtin/config.c | 207 +++++++++++++++++++++++------------------------
>  1 file changed, 99 insertions(+), 108 deletions(-)

This is definitely easier (for me, at least) to view with:

    $ git show --color-moved --color-moved-ws=ignore-all-space

which makes clearer that this change does not introduce or change any
existing behavior.

>  static struct option builtin_config_options[] = {
>  	OPT_GROUP(N_("Config file location")),
>  	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
> @@ -851,20 +868,20 @@ static struct option builtin_config_options[] = {
>  	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
>  	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
>  	OPT_GROUP(N_("Action")),
> -	OPT_CMDMODE(0, "get", &actions, N_("get value: name [value-pattern]"), ACTION_GET),
> -	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [value-pattern]"), ACTION_GET_ALL),
> -	OPT_CMDMODE(0, "get-regexp", &actions, N_("get values for regexp: name-regex [value-pattern]"), ACTION_GET_REGEXP),
> [...]

Got it, this whole hunk is changing "&actions" to "&action", and nothing
else.

> @@ -976,33 +993,43 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		key_delim = '\n';
>  	}
>
> -	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
> -		error(_("--get-color and variable type are incoherent"));
> -		usage_builtin_config();
> -	}
> -
> -	if (actions == 0)
> +	if (action == ACTION_NONE) {
>  		switch (argc) {
> -		case 1: actions = ACTION_GET; break;
> -		case 2: actions = ACTION_SET; break;
> -		case 3: actions = ACTION_SET_ALL; break;
> +		case 1: action = ACTION_GET; break;
> +		case 2: action = ACTION_SET; break;
> +		case 3: action = ACTION_SET_ALL; break;

Wondering aloud a little bit... is it safe to set us to "ACTION_SET",
for example, if we have exactly two arguments? On the one hand, it seems
like the answer is yes. But on the other hand, if we were invoked as:

    $ git config ste foo

We would get something like:

    $ git config ste foo
    error: key does not contain a section: ste

which is sensible. It would be nice to say something more along the
lines of "oops, you probably meant 'set' instead of 'ste'". I think you
could claim that the error on the user's part is one of:

  - (using the new style 'git config') misspelling "set" as "ste", and
    thus trying to invoke a non-existent sub-command

  - (using the old style) trying to set the key "ste", which does not
    contain a section name, and thus is not a valid configuration key

I have no idea which is more likely, and I think that there isn't a good
way to distinguish between the two at all. So I think the error message
is OK as-is, but let me know if you have other thoughts.

>  		default:
>  			usage_builtin_config();
>  		}
> +	}
> +	if (action <= ACTION_NONE || action >= ARRAY_SIZE(subcommands_by_action))
> +		BUG("invalid action %d", action);
> +	subcommand = subcommands_by_action[action];
> +
> +	if (type && (subcommand == cmd_config_get_color ||
> +		     subcommand == cmd_config_get_colorbool)) {
I don't think there's anything wrong with using the function-pointer
equality here to figure out which subcommand we're in, but I wonder if
it might be cleaner to write this as:

    if (type && (action == ACTION_GET_COLOR ||
                 action == ACTION_GET_COLORBOOL)) {
        ...

> -	if (actions == ACTION_LIST) {
> -		return cmd_config_list(argc, argv, prefix);
> -	} else if (actions == ACTION_EDIT) {
> -		return cmd_config_edit(argc, argv, prefix);
> -	} else if (actions == ACTION_SET) {
> -		return cmd_config_set(argc, argv, prefix);
> -	} else if (actions == ACTION_SET_ALL) {
> -		return cmd_config_set_all(argc, argv, prefix);
> -	} else if (actions == ACTION_ADD) {
> -		return cmd_config_add(argc, argv, prefix);
> -	} else if (actions == ACTION_REPLACE_ALL) {
> -		return cmd_config_replace_all(argc, argv, prefix);
> -	} else if (actions == ACTION_GET) {
> -		return cmd_config_get(argc, argv, prefix);
> -	} else if (actions == ACTION_GET_ALL) {
> -		return cmd_config_get_all(argc, argv, prefix);
> -	} else if (actions == ACTION_GET_REGEXP) {
> -		return cmd_config_get_regexp(argc, argv, prefix);
> -	} else if (actions == ACTION_GET_URLMATCH) {
> -		return cmd_config_get_urlmatch(argc, argv, prefix);
> -	} else if (actions == ACTION_UNSET) {
> -		return cmd_config_unset(argc, argv, prefix);
> -	} else if (actions == ACTION_UNSET_ALL) {
> -		return cmd_config_unset_all(argc, argv, prefix);
> -	} else if (actions == ACTION_RENAME_SECTION) {
> -		return cmd_config_rename_section(argc, argv, prefix);
> -	} else if (actions == ACTION_REMOVE_SECTION) {
> -		return cmd_config_remove_section(argc, argv, prefix);
> -	} else if (actions == ACTION_GET_COLOR) {
> -		return cmd_config_get_color(argc, argv, prefix);
> -	} else if (actions == ACTION_GET_COLORBOOL) {
> -		return cmd_config_get_colorbool(argc, argv, prefix);
> -	}
> -
> -	BUG("invalid action");
> +	return subcommand(argc, argv, prefix);

Very nice.

Thanks,
Taylor
