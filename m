Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2D31F597
	for <e@80x24.org>; Tue, 24 Jul 2018 18:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbeGXTPb (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 15:15:31 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41439 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388427AbeGXTPb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 15:15:31 -0400
Received: by mail-wr1-f52.google.com with SMTP id j5-v6so5014944wrr.8
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z+6BcyT5uSqC/wFUatp/E4a7NdpW3rwp91DUC4T9rrA=;
        b=M15QOsQLr+l+B/97KlsozbLNgPyp1RrDpGS4LGp0B0igD8NFP1pDRUbhXkV82koTKU
         BpeDwNJkbpjyrzKdn/6Ib81V21Fdh3LsIOtOl819ofuj7eeoydTFSCVAMQnV3hAFeQoa
         CAsXbcZQZE3FuyIR+EGwpy/237JmEq06oiIPcBxBosJETmktanNtMLk66QDV4hHx6zd7
         Z2L+3/0J1drCEBSodtJY78sQqOlLWpgm1i81Iwbwr4yZ1m2y1khC7M2MsyP6T7cJHMj8
         Ev2nm7jVKWJGeE+hf+IVrfjjSmhr8rgJliFaacPSM9ziVWZk6hk4qMHArDyeqgGnQZci
         6e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z+6BcyT5uSqC/wFUatp/E4a7NdpW3rwp91DUC4T9rrA=;
        b=fRCKlvyOyd/hGcs4qEtbki4q5EkZRkslohMoQsDjfsn1jtxEjMpTKbQMeR3yxRsQld
         eEddkUPBhddeRc4m9z8vSsxkT+f37mqDbpcY7vIgIdujxlnsPUzCmPKRQVoInvPwqfQG
         DldM3yfbPjRS7P+dhEy9peUfRZlQ1aSuf3bRAiW3vQLhiVwu3WZce9aAeo3+iOUyqlQW
         RHBPJ3UgUoML54jCcdvk6d+OiiTrbg8Z6Mm7D+74tf/qllnzzRZUr9ueM06gYH/lcG7O
         yv7L9iJDD0fiurYn29L3ypcpiO4IocIkoiBtJLdS3dI6nW5m95zb4SGXU9RQ0bVI3Krm
         2tIA==
X-Gm-Message-State: AOUpUlEIRgrhIt1VgZh0erYXLkOaUsGHz9WP2O2rDkoB/vNRcAVuanm3
        /3xlwfoRdGziej4AkFiZok8=
X-Google-Smtp-Source: AAOMgpf7/ZIa2WEpkTzRQDv5BDcDtTi7Tl1egoBpITtK3+jtksjC+zC+25JyTYfMdirxS0lQ/MVJng==
X-Received: by 2002:adf:9f13:: with SMTP id l19-v6mr12452012wrf.206.1532455669262;
        Tue, 24 Jul 2018 11:07:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x124-v6sm1997255wmg.38.2018.07.24.11.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 11:07:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] config.c: fix msvc compile error
References: <20180724153010.6693-1-git@jeffhostetler.com>
Date:   Tue, 24 Jul 2018 11:07:48 -0700
In-Reply-To: <20180724153010.6693-1-git@jeffhostetler.com> (git's message of
        "Tue, 24 Jul 2018 15:30:10 +0000")
Message-ID: <xmqq1sbszevf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> In commit fb0dc3bac135e9f6243bd6d293e8c9293c73b9cd code was added
> to builtin/config.c to define a new function and a forward declaration
> for an array of unknown size.  This causes a compile error under MSVC.
>
> Reorder the code to forward declare the function instead of the array.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---

Somebody please tell me why I have a feeling that I've seen this
patch, even though it is labeled as v1...  The problem and the
solution seem pretty obvious and I recall somebody saying that a
single pass compiler wouldn't be able to grok the forward decl.



>  builtin/config.c | 79 ++++++++++++++++++++++++++++----------------------------
>  1 file changed, 40 insertions(+), 39 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index b29d26d..564f18f 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -67,7 +67,46 @@ static int show_origin;
>  	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
>  	PARSE_OPT_NONEG, option_parse_type, (i) }
>  
> -static struct option builtin_config_options[];
> +static int option_parse_type(const struct option *opt, const char *arg,
> +			     int unset);
> +
> +static struct option builtin_config_options[] = {
> +	OPT_GROUP(N_("Config file location")),
> +	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
> +	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
> +	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
> +	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
> +	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
> +	OPT_GROUP(N_("Action")),
> +	OPT_BIT(0, "get", &actions, N_("get value: name [value-regex]"), ACTION_GET),
> +	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-regex]"), ACTION_GET_ALL),
> +	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-regex [value-regex]"), ACTION_GET_REGEXP),
> +	OPT_BIT(0, "get-urlmatch", &actions, N_("get value specific for the URL: section[.var] URL"), ACTION_GET_URLMATCH),
> +	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variables: name value [value_regex]"), ACTION_REPLACE_ALL),
> +	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACTION_ADD),
> +	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-regex]"), ACTION_UNSET),
> +	OPT_BIT(0, "unset-all", &actions, N_("remove all matches: name [value-regex]"), ACTION_UNSET_ALL),
> +	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
> +	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
> +	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
> +	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
> +	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
> +	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
> +	OPT_GROUP(N_("Type")),
> +	OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), option_parse_type),
> +	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
> +	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_INT),
> +	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
> +	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
> +	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
> +	OPT_GROUP(N_("Other")),
> +	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
> +	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
> +	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
> +	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
> +	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
> +	OPT_END(),
> +};
>  
>  static int option_parse_type(const struct option *opt, const char *arg,
>  			     int unset)
> @@ -119,44 +158,6 @@ static int option_parse_type(const struct option *opt, const char *arg,
>  	return 0;
>  }
>  
> -static struct option builtin_config_options[] = {
> -	OPT_GROUP(N_("Config file location")),
> -	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
> -	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
> -	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
> -	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
> -	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
> -	OPT_GROUP(N_("Action")),
> -	OPT_BIT(0, "get", &actions, N_("get value: name [value-regex]"), ACTION_GET),
> -	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-regex]"), ACTION_GET_ALL),
> -	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-regex [value-regex]"), ACTION_GET_REGEXP),
> -	OPT_BIT(0, "get-urlmatch", &actions, N_("get value specific for the URL: section[.var] URL"), ACTION_GET_URLMATCH),
> -	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variables: name value [value_regex]"), ACTION_REPLACE_ALL),
> -	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACTION_ADD),
> -	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-regex]"), ACTION_UNSET),
> -	OPT_BIT(0, "unset-all", &actions, N_("remove all matches: name [value-regex]"), ACTION_UNSET_ALL),
> -	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
> -	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
> -	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
> -	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
> -	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
> -	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
> -	OPT_GROUP(N_("Type")),
> -	OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), option_parse_type),
> -	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
> -	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_INT),
> -	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
> -	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
> -	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
> -	OPT_GROUP(N_("Other")),
> -	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
> -	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
> -	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
> -	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
> -	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
> -	OPT_END(),
> -};
> -
>  static void check_argc(int argc, int min, int max) {
>  	if (argc >= min && argc <= max)
>  		return;
