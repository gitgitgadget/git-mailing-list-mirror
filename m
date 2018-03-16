Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2779A1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 23:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeCPXFJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 19:05:09 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:38193 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752714AbeCPXFH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 19:05:07 -0400
Received: by mail-wr0-f172.google.com with SMTP id l8so13089187wrg.5
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=k7TAXbZ1F4Apcab+4fKKwy8EU+VH3Vj6n2YbFL5O7WY=;
        b=jyxqOXquQhzIN0cd2otIBHGTZgxbClp3ND9ghKa0HPtkPq2lim0kCH5PwtRE7jBa0a
         vWdk6y2a3XNDm8+69pi2dSr9G1n9zZGf/+wM5wxXgTfh/4TY88oE1Z1NQ7zyMBiA0IO1
         l2QF6c3gnvXd1TweX0MWdmLjoydvDMvDAHs9iBYZEMxOjFYIrtwMx5ecJxLF+63iJndz
         xRsay3hC4bB3dCzQ6qjIQxBFx3WhGDv+wCqMXJC1/4UCMBUESJz7yERKW5EuZArJGMJT
         Mkiv3lziJ1FHB147E9RE6wbCubTcfXzX/WEN0Fg8NU/9f0PdxO0QvaWaubza4WoPKKt2
         abQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=k7TAXbZ1F4Apcab+4fKKwy8EU+VH3Vj6n2YbFL5O7WY=;
        b=I/kJ9r49PEUlySRSRsWqIr6LM2eZkxCADnI+qDqy5iX+KYMUkoDTyBxNyoXSj+nEjZ
         2t1VvzZJ1Q+VCg8YyExo76Dk9AmZOk1ONC/lubnWDC4eTzFu84ivAH5zoeIIJIRoebP9
         F9cKED35nJZ1UX88ltAdmmfIxnR//08PR5QCORUUhDLmkuaNlNzY84/iVGEq57sFrPtw
         sHDIjAD/AMVpNRjX6NVocG9Pno+kI63c0TTslJtinRfilRz2q9V5PbYQJnhOFxhWhEdr
         aRHVOkVLrQGOOjeFI+Mq5RMsZvS8iYNjy4Vh9hiFvlIU3CvyuGSikI5JuZCoD8RulCwB
         22tw==
X-Gm-Message-State: AElRT7GI/kNZQHFPTnq7dO7xuxFztm/kEcWxGvF8ElMRDpDvrrgNQye+
        u/f7Z6fO7vfBvUt0mf5q3kE=
X-Google-Smtp-Source: AG47ELse4pvjzIY42Cz+aICyKvYPgztWRH7e7BrdbNEj6ONbz+YIPiBRmu5y+EOSZzL3bDScVsgkTw==
X-Received: by 10.223.152.141 with SMTP id w13mr3112157wrb.12.1521241505325;
        Fri, 16 Mar 2018 16:05:05 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u89sm7431791wma.10.2018.03.16.16.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 16:05:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Roger Solano <sroger.git@gmail.com>
Cc:     git@vger.kernel.org, Roger Solano <sc_rogeralberto@hotmail.com>
Subject: Re: [GSoC] parse: not show usage help when invalid id
References: <20180316223345.7799-1-sc_rogeralberto@hotmail.com>
Date:   Fri, 16 Mar 2018 16:05:04 -0700
In-Reply-To: <20180316223345.7799-1-sc_rogeralberto@hotmail.com> (Roger
        Solano's message of "Fri, 16 Mar 2018 18:33:45 -0400")
Message-ID: <xmqq605vzknz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Roger Solano <sroger.git@gmail.com> writes:

> patch for too chatty command when <id> is invalid
> ex. git tag --contains <id>
>
> It is possible to skip 'goto show_usage_error' when
> parse_long_opt fails? and return directly from there.

Can you explain how this relates to and/or compares with a recent
update [1]?

Thanks.

[1] https://public-inbox.org/git/20180306193116.23876-1-ungureanupaulsebastian@gmail.com

>
> Signed-off-by: Roger Solano <sc_rogeralberto@hotmail.com>
> ---
>  parse-options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 125e84f98..074915eb3 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -550,7 +550,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>  			goto show_usage;
>  		switch (parse_long_opt(ctx, arg + 2, options)) {
>  		case -1:
> -			goto show_usage_error;
> +			return -1; 
>  		case -2:
>  			goto unknown;
>  		}
