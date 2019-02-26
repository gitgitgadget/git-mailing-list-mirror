Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBD15202AA
	for <e@80x24.org>; Tue, 26 Feb 2019 22:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfBZWiG (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 17:38:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45153 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbfBZWiG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 17:38:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id h10so10902034lfc.12
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 14:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0Hvi7MXOproZNw3mv4FUkK4gRhx6jcFxaYrRDl6j9yY=;
        b=KBwFjVHhdx3lGVZKBJp8zlDwAPuMxHSxD3BZLNurC+Xjd7ph1cMCC4MckO0O8r79RU
         /qEpm3I+z+1Uo+/HlCRWaUDDjEHc7OY00uIfe0shDxA+7Hb0Mztemj4uzc1EaoawNsKs
         /V5tutVJ7fr5MdV2LCZ68GKOd3Ssw9SqtDaTCokFnK6UaxhJ1fgHqRb7FF8Pa5pYA2Do
         xC/imO5Jbx6syjTTwm7f7XfX4uMCeGBr0jAdWqis13iiU8pP2GKlmMEAT+0JAvbMaSjk
         ZqlmTTLdYc5bdfvumppisbRDbmEdLr3StFHxgcJ96k6868zCFDD55wWeP/zr+qoOySU9
         q7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Hvi7MXOproZNw3mv4FUkK4gRhx6jcFxaYrRDl6j9yY=;
        b=OFuD5+5CVd+uQa79h2tvccH5ywvm4O8fxohZ+qpPQWtR78L0EgpabF83pGqKpMNxLC
         44D7HM0mAYEvyT0GZGzw+73gnj/hiUGcJP4E+MmJXZ6wOtmGLhKpIaMQ5+im+QTFFVx2
         qlGJ+2IyYB9ghxIyDn/I97MtR3cg666pHptEeS33QvwUKqojma9SjslIJM8hZMNJFvwk
         uI53lcsHXIlFm0OqMYMD54q1zwTPYVoj1+k7487FwWWFcouPGVIjoQ9y+xCw/QhJ13yN
         1is3CpWsELkqWWIUA4dg3MNxbgoGoJXqo0mgL6BnzI1guyEFaRnDjfDGRC+ccnIXf7yl
         T3bw==
X-Gm-Message-State: AHQUAuacZZGd/GB/4Yk4V1eNzOLY+whJxOGK2inXglkZkj+nPzkxhOd6
        KN0L9j11Un9x+m+990xEqO48HWVlX5s=
X-Google-Smtp-Source: AHgI3IbvE2XMnPHQNXC6pCpnql3gtPVNKXLCbalVrE91R5U1RuRzZzcqtfqEVMSuuwPHgjxbvlZjow==
X-Received: by 2002:ac2:560a:: with SMTP id v10mr14398543lfd.29.1551220683695;
        Tue, 26 Feb 2019 14:38:03 -0800 (PST)
Received: from [10.32.1.18] ([46.246.123.2])
        by smtp.gmail.com with ESMTPSA id e29sm1461334lfj.59.2019.02.26.14.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 14:38:02 -0800 (PST)
Subject: Re: [PATCH] commit-tree: utilize parse-options api
To:     Brandon <brandon1024.br@gmail.com>, git@vger.kernel.org
References: <20190226200952.33950-1-brandon1024.br@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <33efa988-ea80-d9b4-f4aa-3876331a1dfb@gmail.com>
Date:   Tue, 26 Feb 2019 23:38:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226200952.33950-1-brandon1024.br@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of code style issues:

On 2/26/19 9:09 PM, Brandon wrote:
> From: Brandon Richardson <brandon1024.br@gmail.com>
> 
> Rather than parse options manually, which is both difficult to
> read and error prone, parse options supplied to commit-tree
> using the parse-options api.
> 
> It was discovered that the --no-gpg-sign option was documented
> but not implemented in 55ca3f99, and the existing implementation
> would attempt to translate the option as a tree oid.It was also

Missing space after period.

[snip]

> +
>  int cmd_commit_tree(int argc, const char **argv, const char *prefix)
>  {
> -	int i, got_tree = 0;
> +	static struct strbuf buffer = STRBUF_INIT;
>  	struct commit_list *parents = NULL;
>  	struct object_id tree_oid;
>  	struct object_id commit_oid;
> -	struct strbuf buffer = STRBUF_INIT;
> +
> +    struct option builtin_commit_tree_options[] = {

Style: tab should be used instead of four spaces.

> +		{ OPTION_CALLBACK, 'p', NULL, &parents, "parent",
> +		  N_("id of a parent commit object"), PARSE_OPT_NONEG,

Comparing to other similar places, a single tab should be used to
align "N_" instead of two spaces.

> +		  parse_parent_arg_callback },
> +		{ OPTION_CALLBACK, 'm', NULL, &buffer, N_("message"),
> +		  N_("commit message"), PARSE_OPT_NONEG,
> +		  parse_message_arg_callback },
> +		{ OPTION_CALLBACK, 'F', NULL, &buffer, N_("file"),
> +		  N_("read commit log message from file"), PARSE_OPT_NONEG,
> +		  parse_file_arg_callback },
> +		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
> +		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> +		OPT_END()
> +    };

[snip]

> -
> -		if (!strcmp(arg, "--no-gpg-sign")) {
> -			sign_commit = NULL;
> -			continue;
> -		}
> +	argc = parse_options(argc, argv, prefix, builtin_commit_tree_options,
> +			builtin_commit_tree_usage, 0);

here "builtin_commit_tree_usage" should be aligned with "argc" in
previous line.

