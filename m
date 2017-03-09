Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6216D202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753925AbdCIWT3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:19:29 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35543 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753033AbdCIWT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:19:28 -0500
Received: by mail-pf0-f172.google.com with SMTP id j5so33737749pfb.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=cSv/txb4Vyy76qMw34vTuURKv30pwIrMlN3xFbhvpnE=;
        b=gokMMiViY35IPNeNXnoN51JCMYH4OOjLv6uHeNTj2bO7dYQ3O8TU3xBteopHOkVYQn
         ueHwdkEWmaGM+j/UnWGLZvTkRiTt6LKEpSEBALSie7so2Pw/c6j15yQOlvxAC8+D5oZ5
         TTeWCoWmZwVkjs1SUGIX2Z5LRyQhfoIoBoBM8wj8qFIB8VPvilYfYBsyx8E4biH0QhHR
         hfCMaoStxnCz5mVQOblkYtiEsCVxn48RoFYtxOiyko6vFdFUktCzO1IZo6qkOgaZc5PF
         s/dqSaIznL5P7M9MhV5QP3YO5wMzMLRegveJvtjg/SslPs7wiFte9oZXc8pAcdRTFS5l
         /zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cSv/txb4Vyy76qMw34vTuURKv30pwIrMlN3xFbhvpnE=;
        b=DUl+yYgO3D9CgysrTWeXz+dbz/nJoMaU1XCDzTs9EHJMIE9FjKu3KOfa33r/Ia0Aio
         GU1RKP7Qud0sGLlVid4soUqPZXSweDTSRXCpBgIUehnSG0GojSCPfYWyeEiFwvkilWSD
         E8KlFX3yYIXtjxVxcDdBbVx3Kv3TgsOullLX9SuwsgbBVn/hxzNSJujh7+HsaGalK578
         /MTk/7nFfCKWxPa0/ctStBCM1790qUK13uGkilR6F2K28HEg2vJhLgTRPk6bwNklLn8o
         Sjj+upjJgRgZFpy6J+63Z07D7QlnyNb0vQv/v9TuIu5g5l8imUb+vPVTDGcWvG1KmD6u
         2LvQ==
X-Gm-Message-State: AMke39mkOHL79GuM33fCiuvnni2P1/LDnSN5iEQMUq2fEDHMm5n9ywFcM8kcl9Y8hdnHxhvm
X-Received: by 10.99.43.216 with SMTP id r207mr16322414pgr.214.1489097967011;
        Thu, 09 Mar 2017 14:19:27 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:bdfe:9271:5e21:646a])
        by smtp.gmail.com with ESMTPSA id x15sm14472504pgc.16.2017.03.09.14.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Mar 2017 14:19:26 -0800 (PST)
Subject: Re: [PATCH 1/2] pathspec: allow querying for attributes
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <20170309210756.105566-1-bmwill@google.com>
 <20170309210756.105566-2-bmwill@google.com>
Cc:     sbeller@google.com, pclouds@gmail.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <e8ef511f-563b-8b22-d8c6-daec2291f2aa@google.com>
Date:   Thu, 9 Mar 2017 14:19:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170309210756.105566-2-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09/2017 01:07 PM, Brandon Williams wrote:
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index fc9320e59..5c32d1905 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -384,6 +384,26 @@ full pathname may have special meaning:
>  +
>  Glob magic is incompatible with literal magic.
>
> +attr;;
> +After `attr:` comes a space separated list of "attribute
> +requirements", all of which must be met in order for the
> +path to be considered a match; this is in addition to the
> +usual non-magic pathspec pattern matching.
> ++
> +Each of the attribute requirements for the path takes one of
> +these forms:
> +
> +- "`ATTR`" requires that the attribute `ATTR` must be set.

As a relative newcomer to attributes, I was confused by the fact that 
"set" and "set to a value" is different (and likewise "unset" and 
"unspecified"). Maybe it's worthwhile including a link to 
"gitattributes" to explain the different (exclusive) states that an 
attribute can be in.

> +
> +- "`-ATTR`" requires that the attribute `ATTR` must be unset.
> +
> +- "`ATTR=VALUE`" requires that the attribute `ATTR` must be
> +  set to the string `VALUE`.
> +
> +- "`!ATTR`" requires that the attribute `ATTR` must be
> +  unspecified.

It would read better to me if you omitted "must" in all 4 bullet points 
(and it is redundant anyway with "requires"), but I don't feel too 
strongly about this.

> diff --git a/pathspec.c b/pathspec.c
> index b961f00c8..583ed5208 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -87,6 +89,72 @@ static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
>  	strbuf_addf(sb, ",prefix:%d)", prefixlen);
>  }
>
> +static void parse_pathspec_attr_match(struct pathspec_item *item, const char *value)
> +{
> +	struct string_list_item *si;
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +
> +	if (item->attr_check)
> +		die(_("Only one 'attr:' specification is allowed."));
> +
> +	if (!value || !strlen(value))

You can write `!*value` instead of `!strlen(value)`.

> +		die(_("attr spec must not be empty"));
> +
> +	string_list_split(&list, value, ' ', -1);

You could avoid some allocations by using the in-place variant (since 
value is a newly allocated string not used elsewhere) but it is probably 
not that important in this argument parsing case.

> +	string_list_remove_empty_items(&list, 0);
> +
> +	item->attr_check = attr_check_alloc();
> +	ALLOC_GROW(item->attr_match,
> +		   item->attr_match_nr + list.nr,
> +		   item->attr_match_alloc);

Is there a time when this function is called while item->attr_match_nr 
is not zero?

> +
> +	for_each_string_list_item(si, &list) {
> +		size_t attr_len;
> +		char *attr_name;
> +		const struct git_attr *a;
> +
> +		int j = item->attr_match_nr++;
> +		const char *attr = si->string;
> +		struct attr_match *am = &item->attr_match[j];
> +
> +		switch (*attr) {
> +		case '!':
> +			am->match_mode = MATCH_UNSPECIFIED;
> +			attr++;
> +			attr_len = strlen(attr);
> +			break;
> +		case '-':
> +			am->match_mode = MATCH_UNSET;
> +			attr++;
> +			attr_len = strlen(attr);
> +			break;
> +		default:
> +			attr_len = strcspn(attr, "=");
> +			if (attr[attr_len] != '=')
> +				am->match_mode = MATCH_SET;
> +			else {
> +				am->match_mode = MATCH_VALUE;
> +				am->value = xstrdup(&attr[attr_len + 1]);
> +				if (strchr(am->value, '\\'))
> +					die(_("attr spec values must not contain backslashes"));
> +			}
> +			break;
> +		}
> +
> +		attr_name = xmemdupz(attr, attr_len);
> +		a = git_attr(attr_name);
> +		if (!a)
> +			die(_("invalid attribute name %s"), attr_name);
> +
> +		attr_check_append(item->attr_check, a);
> +
> +		free(attr_name);
> +	}
> +
> +	string_list_clear(&list, 0);
> +	return;

Redundant return?

> @@ -544,6 +628,10 @@ void parse_pathspec(struct pathspec *pathspec,
>  		if (item[i].nowildcard_len < item[i].len)
>  			pathspec->has_wildcard = 1;
>  		pathspec->magic |= item[i].magic;
> +
> +		if (item[i].attr_check &&
> +		    item[i].attr_check->nr != item[i].attr_match_nr)
> +			die("BUG: should have same number of entries");

I'm not sure if this check is giving us any benefit - I would expect 
this type of code before some other code that assumed that the numbers 
matched, and that will potentially segfault if not.
