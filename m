Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC7AE1F466
	for <e@80x24.org>; Thu, 26 Sep 2019 13:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfIZNCF (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 09:02:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37908 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZNCF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 09:02:05 -0400
Received: by mail-qk1-f194.google.com with SMTP id u186so1659077qkc.5
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 06:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XT2DKl2eHMNR4xMQS2Zkaa/5V5T2TblAfwh5s/z/Dy8=;
        b=P2QqR7opuXienQ/cMuOWLZGEoTYKjNu2mHEvlC78S727r9kkBVkn3VCxN9vuuvm8bK
         rB5zBR5QghwdTzwjDAOF9H20NDvnRNrraenb9Zrjz6oUh1i451gjbYeDSzV1P2jfHRNg
         vsi/WmxEfLf6PxIuR/Lu2e5X3+l0P3GsEOoGmyAktJgCbMYwBJUNGnVVQnzSr5RvYaeo
         k1PXyd3tffiCkYxRqH8MFdYIwRfSt5rak+5QMgEjCHYc0EeEH2euXxBT0vt918LI/qo1
         dBjTHF8JEA6ZSwu/L2eHs8j8QiNVhKV8JP6od0x2kF0cUH3AHGuxSghrJ+FkEcIf8/+p
         kogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XT2DKl2eHMNR4xMQS2Zkaa/5V5T2TblAfwh5s/z/Dy8=;
        b=HLaPvutc4AM9twnIVshC0S7uptBcGLPnnoe39fWxPuHW/Hp61hZvihStXPf9Gz3NZx
         GQsKGMmSzZUr8pe2OYipS+VA9SlLaf+hKQXHBpKuhNcwhx8xBHJTT8/W6CXr7qbhD8b+
         3BPWWjY/6sd7b+KSYpxqdhKwMtpWXdmtAYcqXm2637Y07Fhjc7ERku9VsezRlFTU70/Q
         RyiDiuBRlUPAG9dUY4P+dU4zy0BEfdRB/yAAoRcRyGdYmgFSGBfPQNtQwn2f396UY3jB
         FKc/OxXPe7qAKw3/JUkgsUl3KfAQHRTPdiL9jyB5e5fVLAZz6wRf5DBXVzHH0VKM7V+m
         Cl7w==
X-Gm-Message-State: APjAAAV8P4/V8YsQZtmuiGOYomX7emlNY22yyX8n456y0+xLn6Q8bSwB
        WgyZhKxrZBcstH6Qn0qfWPU=
X-Google-Smtp-Source: APXvYqy4YO4l7U/Bo+S3N+fAejztaoI+hG1HruV9Z0szi9MlOpNM5LmujYfir7v6LuWa9DjcLguDYg==
X-Received: by 2002:a37:4bd8:: with SMTP id y207mr3030208qka.271.1569502923072;
        Thu, 26 Sep 2019 06:02:03 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:b594:20f6:c10f:d45d? ([2001:4898:a800:1010:66ca:20f6:c10f:d45d])
        by smtp.gmail.com with ESMTPSA id 64sm921505qkk.63.2019.09.26.06.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 06:02:02 -0700 (PDT)
Subject: Re: [PATCH 1/3] commit-graph: remove a duplicate assignment
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, davvid@gmail.com
References: <20190925020158.751492-1-alexhenrie24@gmail.com>
 <20190925020158.751492-2-alexhenrie24@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8307cccf-e115-c720-6670-2ab537066a01@gmail.com>
Date:   Thu, 26 Sep 2019 09:02:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190925020158.751492-2-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/24/2019 10:01 PM, Alex Henrie wrote:
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  commit-graph.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 9b02d2c426..659f4bb4f4 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1534,7 +1534,6 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
>  		size_mult = ctx->split_opts->size_multiple;
>  	}
>  
> -	g = ctx->r->objects->commit_graph;
>  	ctx->num_commit_graphs_after = ctx->num_commit_graphs_before + 1;
>  
>  	while (g && (g->num_commits <= size_mult * num_commits ||

Could we instead remove the assignment during the declaration? It is
easier to know the while loop will work if the assignment is closer
to the loop.

Thanks,
-Stolee
 

