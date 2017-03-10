Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB801FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933893AbdCJT4J (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:56:09 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36273 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933269AbdCJT4H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 14:56:07 -0500
Received: by mail-pg0-f53.google.com with SMTP id g2so25052065pge.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 11:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=1AHdfC7S39ADB4C5NP1bJvVqtrPP+ym0JiIU5+VDhKw=;
        b=ZPqLZC/q+UVti8YyXqD/8vEsecxZa5lMQEDurMVVU0VqfJlAm9ODz5HBaYWobrYZym
         MnGz66/vjzhdvowdONTYLMXAMoYJHmZfWc3zGpHVIqKgDujr/CBNncGKD+dNcYddO1qF
         l3DAJYePrLKJHk2SsbMpOMXah5W2xocyi3+LoZlVfewkySK5rLMsj/oeBAy3Cc169Plr
         Y7ofL2tic1WRyq2wmQWs6FAo7rxeA4E8dhNY4iwHeK2Bj0Mvq9rHzVuR7ZqdO4JvT16k
         2pBmuo/Smq+psOrXFKqOzGUJtey7vYVmRuOkyGFMvIU9NiEG0no+DSuUFAFcce7io1P6
         aq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1AHdfC7S39ADB4C5NP1bJvVqtrPP+ym0JiIU5+VDhKw=;
        b=cOvZNBThiuLk9PVs8JihvyseCrpm2gRUOLJBxqyPKUGSUwZbtRChJU1Eh/D3vCUMMG
         KDU1H5kXYRkx+/GsS1isWZy9mEWjFqhK5HQcj2Bi5H/lKtjN+/hOp3ReUvHRaWMfEHyg
         0GLvWKZqqUFiG/jUbRMcw9M46+kvqrzNid16Jv1K3T5IVUHkCMORlxqnHNhYlWlWTEXp
         hdu7sDI6LowsnRJWXumMQpxXVcRTNV2fQAFvL8Sb7uJlyqWPkVZ3Rhx1Uq/l47HATN6N
         rEb4VxH++SfhplYh9DbGEkDdpGNv4F+Pa2RZxhNnL6qko/zip4E7JFvie0eGOmd1laPi
         Gphg==
X-Gm-Message-State: AMke39mAaQl3NJc6fD6qJUxNVux9Citqy9r0/5yMqF0v5tkX6HvRBNqk7HuRN7n4UXc4WDhh
X-Received: by 10.84.210.167 with SMTP id a36mr28258303pli.40.1489175766228;
        Fri, 10 Mar 2017 11:56:06 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:8950:f724:684f:dbd])
        by smtp.gmail.com with ESMTPSA id s81sm8008155pgs.18.2017.03.10.11.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Mar 2017 11:56:05 -0800 (PST)
Subject: Re: [PATCH v2 1/2] pathspec: allow querying for attributes
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <20170309210756.105566-1-bmwill@google.com>
 <20170310185908.171589-1-bmwill@google.com>
 <20170310185908.171589-2-bmwill@google.com>
Cc:     sbeller@google.com, pclouds@gmail.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <80fdf152-a4a1-7078-bb86-22f11763a4bb@google.com>
Date:   Fri, 10 Mar 2017 11:56:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170310185908.171589-2-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks - I don't think I have any more comments on this patch set after 
these.

On 03/10/2017 10:59 AM, Brandon Williams wrote:
> diff --git a/pathspec.c b/pathspec.c
> index b961f00c8..7cd5f6e3d 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -87,6 +89,74 @@ static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
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
> +	if (!value || !*value)
> +		die(_("attr spec must not be empty"));
> +
> +	string_list_split(&list, value, ' ', -1);
> +	string_list_remove_empty_items(&list, 0);
> +
> +	item->attr_check = attr_check_alloc();
> +	ALLOC_GROW(item->attr_match,
> +		   list.nr,
> +		   item->attr_match_alloc);

If item->attr_match always starts empty, then I think an xmalloc or 
xcalloc suffices (and we don't need item->attr_match_alloc anymore).

We should probably also check item->attr_match above - that is, `if 
(item->attr_check || item->attr_match)`.

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
> +	if (item->attr_check->nr != item->attr_match_nr)
> +		die("BUG: should have same number of entries");

I think such postcondition checks are usually not worth it, but others 
might differ.

> +
> +	string_list_clear(&list, 0);
> +}
> +
>  static inline int get_literal_global(void)
>  {
>  	static int literal = -1;
