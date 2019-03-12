Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A590202BB
	for <e@80x24.org>; Tue, 12 Mar 2019 13:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfCLNrU (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:47:20 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43409 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfCLNrU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:47:20 -0400
Received: by mail-yw1-f67.google.com with SMTP id j66so2084362ywc.10
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kLNUdtRj4b8uf0UVJOPUVHmFghnt2vreOFEh9vAklrs=;
        b=JHZiScylxRhzpe5Ywtc/adrSHbilF8Ih/SAY1sfeWX+Fpdq8Bv6NM4E6Gm/qC00goC
         nVgnmdxQ3FJeAvKhaJU/KqJV48AuXMATGkE8aK2Fok9codToiK96iw93I5uZ4i0y7pWW
         KwDsFUxY+2B6CTYK5S1k3EMjnuelTwaqltOT4JWUHSHEJp2RIQhepw4hvR8XYQHQtCSi
         H3LkiJ2/JT3tLr5vQknNhfgr5ewM9FhChnDIIqADBUX3GJpY4c0I9Y4saXpS9EDxDd10
         4j/Twbsyb5+KRAH53zmAuE85A1Vz/lmWa07d2kNFG/T9tgwZB81g6S8rKHfJtvMABzWL
         ofYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kLNUdtRj4b8uf0UVJOPUVHmFghnt2vreOFEh9vAklrs=;
        b=LlNqnEpS0OAzZ+Jq4Z+QSKqOwndSy02a1CLNvuEPUkfmIKyyo4RP+jyhY9SvBYg43X
         HQFvmwHCST+6qpbcIAIX1T49HULCAuiM8WctHOtjhS9H95iHlxbfCXZrVrumBt1CWa+0
         f0/MAzZTBIyKGMZTW/WWcuXgnClIBdCS6a7sO0h3eiYST9285ryIfU7+tkgQbsIAnpJR
         Fe0m47RIf5/UaWVtLOMARF1LPh6TF0gdmZmXIf92Ke8PwUqCu0lhno+0eqNrrhGNjVkZ
         ThATDrYgj5LgHZYbzJefldJnD4PGkLXaFQj9OrLuaWT4nMNMSQkF7jMP52uUhsAg6ef+
         YMow==
X-Gm-Message-State: APjAAAUk3dsARMTsCTDjz7Hop73Jw7LA3CUgMdiJP+M88LpEOH50xpkc
        9lqopDajVzmn9N/cyDvckD8=
X-Google-Smtp-Source: APXvYqxGE5cZiSl3gFaQtT+fxsYhWxCfCp7siS4ML58+Af92YQCgJ6nLuHTbgCUTDxn+KXbIP6FtEw==
X-Received: by 2002:a81:1690:: with SMTP id 138mr30238052yww.276.1552398439641;
        Tue, 12 Mar 2019 06:47:19 -0700 (PDT)
Received: from [192.168.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id m67sm3200812ywe.56.2019.03.12.06.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:47:19 -0700 (PDT)
Subject: Re: [PATCH 3/4] repack: add --sparse and pass to pack-objects
To:     Nathaniel Filardo <nwf20@cl.cam.ac.uk>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
References: <20190312131858.26115-1-nwf20@cl.cam.ac.uk>
 <20190312131858.26115-4-nwf20@cl.cam.ac.uk>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f26c68df-8895-2a2d-0175-5fa3581ab45a@gmail.com>
Date:   Tue, 12 Mar 2019 09:47:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <20190312131858.26115-4-nwf20@cl.cam.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/12/2019 9:18 AM, Nathaniel Filardo wrote:
> The sparse connectivity algorithm saves a whole lot of time when there
> are UNINTERESTING trees around.

Interesting! Do you have some performance numbers to include with
this statement?
> @@ -48,6 +49,10 @@ static int repack_config(const char *var, const char *value, void *cb)
>  		use_delta_islands = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "pack.usesparse")) {
> +		sparse = git_config_bool(var, value);
> +		return 0;
> +	}

This part is not handled inside of `pack-objects`. Since you are not
sending '--no-sparse' when the variable 'sparse' is zero, the config
setting will automatically be picked up by the pack-objects builtin.

Now, a question of whether you _should_ allow the '--no-sparse' option
in the 'repack' command, and send it along to the inner command (when
it is present) is another question.

> @@ -366,6 +374,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	argv_array_push(&cmd.args, "--all");
>  	argv_array_push(&cmd.args, "--reflog");
>  	argv_array_push(&cmd.args, "--indexed-objects");
> +	if (sparse)
> +		argv_array_push(&cmd.args, "--sparse");
>  	if (repository_format_partial_clone)
>  		argv_array_push(&cmd.args, "--exclude-promisor-objects");
>  	if (write_bitmaps)
> 

How about a test with this new option? You can probably just add to
t5322-pack-objects-sparse.sh.

Thanks,
-Stolee
