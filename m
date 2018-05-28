Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 039A81F42D
	for <e@80x24.org>; Mon, 28 May 2018 15:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034413AbeE1PcC (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 11:32:02 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:41972 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032271AbeE1Pb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 11:31:57 -0400
Received: by mail-wr0-f173.google.com with SMTP id u12-v6so20871061wrn.8
        for <git@vger.kernel.org>; Mon, 28 May 2018 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+iLaby14dnGHB/vewWEkMwExJuOd7g/zJkO4sYRBV/I=;
        b=TiKiDmoPHaMFULb9sZpnhVBmJ0hDJXI7AechGonFqWlZPU9r0N7wvAYW7bDUxrTYJY
         e86pQb3hlW+8s/3G7CzO2DQJzcKiVEpyDKPBLTmgjPGl/ghdJvlDDCA/Yda/ZcuSPR6v
         sQBO7i5Cjc+jWGWaV8eYajQkOZoUHW4Xmnkf3+aYbKvSMWS2/mrbdrzp2E2EKIO2gM8d
         hI9SvJ7wIqoAhODgc0bUixqjRCRPwqR3Tyg/fO20vme8FXta8ooBaqp1c59Jm3xAtB5S
         rKJ6vUFBCjD1eplCqfXBZKiSumz77aE/DNieVJ/9yTWUl4qjt/HJIHQI8YlSW1CB/VG7
         SM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+iLaby14dnGHB/vewWEkMwExJuOd7g/zJkO4sYRBV/I=;
        b=QRP+JGgl436nulVj/rqdF1tiQEFuKiNDniVa+smB5RdfJt8+PXu+NIhO0DT8T/U0O4
         mVM9JZ+sy2dK7ENX75af+W40ialUs2isp9JQVJSBQImv1ascprgMI2WfK62uvig5jEpT
         5nX4jt0vi9zMrX7FIGHfpJc58+0N1oYBqvgD479Iv5cq5LBWKZVRh4CPJn7cMChjktnb
         y5qn18R+L6UBpe/ejDAof/AMGlivS3lSum+p/iP5RIS4xxt4+QIkjVj2vmzBLPUZH1af
         OiXRhCQYNPbV2rjMG+zIolcFEv9dKeHuG23tBYrtn55dmNOdAj5MV8Xk6B70EG1CaQtr
         3tKQ==
X-Gm-Message-State: ALKqPwdzmL+2ZR0Ow186g4ajMx3Sj2OB/XVyxK0pVEoo9gDlXH9jhBwX
        MGioAmOVKe0dx5rfxHR1XS0=
X-Google-Smtp-Source: ADUXVKJYLuosSdwsYircskKDoF/4+hn/0WXQjjCvw4txPjhBvsGWEcmLW2FbtTweh8qWdBgmrc07cQ==
X-Received: by 2002:adf:8e89:: with SMTP id q9-v6mr2561046wrb.269.1527521516542;
        Mon, 28 May 2018 08:31:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b74-v6sm18686745wmi.13.2018.05.28.08.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 08:31:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] make show-index a builtin
References: <20180528093740.GA6902@sigill.intra.peff.net>
        <20180528093853.GA20229@sigill.intra.peff.net>
Date:   Tue, 29 May 2018 00:31:53 +0900
In-Reply-To: <20180528093853.GA20229@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 28 May 2018 05:38:53 -0400")
Message-ID: <xmqqlgc3iyom.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/show-index.c b/builtin/show-index.c
> similarity index 96%
> rename from show-index.c
> rename to builtin/show-index.c
> index 1ead41e211..65fa86dd08 100644
> --- a/show-index.c
> +++ b/builtin/show-index.c
> @@ -4,7 +4,7 @@

I squashed

#include "builtin.h"

near the beginning of this file to squelch -DDEVELOPER extra
warnings.  Otherwise looks obviously good.

>  static const char show_index_usage[] =
>  "git show-index";
>  
> -int cmd_main(int argc, const char **argv)
> +int cmd_show_index(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
>  	unsigned nr;
> diff --git a/git.c b/git.c
> index 5771d62a32..c91e144d9a 100644
> --- a/git.c
> +++ b/git.c
> @@ -470,6 +470,7 @@ static struct cmd_struct commands[] = {
>  	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
>  	{ "show", cmd_show, RUN_SETUP },
>  	{ "show-branch", cmd_show_branch, RUN_SETUP },
> +	{ "show-index", cmd_show_index },

Hmph, this does not need SETUP?  Ah, of course, because its
subcommand body used to do everything itself, and this patch just
turns cmd_main() to cmd_show_index().



>  	{ "show-ref", cmd_show_ref, RUN_SETUP },
>  	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>  	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
