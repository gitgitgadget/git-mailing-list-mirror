Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FEFF20248
	for <e@80x24.org>; Fri, 19 Apr 2019 19:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfDSTW7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 15:22:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54205 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfDSTW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 15:22:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so7168506wmj.3
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 12:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Fi1OJPJlNPQVX0KRDz9agXLXb7kDkbimfIym2hrbM3Q=;
        b=aCnq+ILsJpD3AGBX/nCk0WZJH1wmzXl2zQV6ltWA1xTo2UNXTVIybJCmBG/vmrV4mm
         97RwXUp0HKZPS8cGkUpr+IyDGUlgRNPu8BuHQg0uuLPtGz3GUPlsWAY0mh/Ms2m/9Gva
         182cExZ8IKxmmQVybEcljZbExhw1YSsBB4p0QEp5JGoCPNtwhlD3LjmDmr8i7mzyyVvA
         FO7/FCQYKdPnWfhyoQyqrFK/XxAteeUJq5u6jCUlYBNaRT8s7GqS+PUCV+CgM4PdC8sq
         KGijhdYxWdFIxvLpAvU4ZD4J72ex9EcZhZXvuNyGDxMhJOk+ERUaQY8NvjRwQpeWOGNT
         2rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Fi1OJPJlNPQVX0KRDz9agXLXb7kDkbimfIym2hrbM3Q=;
        b=NOr5ZrA8Tqd1axz2U49HZYkaXcuY4q/hCqujQgGGcv2YxdhJvpwgdh5stmAVobkHEo
         CVlaIr4LAkvuoXQEzP8dyXFVeBw45dT34RRd7FydMRnV8nyK7UHuNCeByFZ8lf/a7KJh
         heCEBleDByS91cFmfQcUZQL2fypBKNayqVgzXIqWH3WAPTcJuveX9rra0kYWBAmF5osN
         5+w3Zv2fGMyQuDvVHvTGs3ivkFM0aJrWhzt5LE+Tm+IxNat6Mt/0a8Tj69TKPZBzlinL
         GoOtW4Y/a5QnI9eGpMw2LirdNseAvQvRvG86+Gx6cxBXa9seAaZgedsqqsLgCjDBKown
         rgag==
X-Gm-Message-State: APjAAAW3s0+opj95nv0XRqiB0ltikrXRdzgmI5lphDiH4Bm042YEKvbZ
        8cN+pUlmiX1JZXwYi6+Cp+NKgno1tqE=
X-Google-Smtp-Source: APXvYqwo9po1HZevqQ7Vlj8EdFmrxBAAg+7JVAqglj8O67r1hwN+XGcfpczsyStcqsFEqsBKzzWJfA==
X-Received: by 2002:a1c:5588:: with SMTP id j130mr1397849wmb.72.1555653209678;
        Thu, 18 Apr 2019 22:53:29 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z6sm4525332wrh.45.2019.04.18.22.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 22:53:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v1 02/12] rebase: don't translate trace strings
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
        <20190417143044.17655-1-phillip.wood123@gmail.com>
        <20190417143044.17655-3-phillip.wood123@gmail.com>
Date:   Fri, 19 Apr 2019 14:53:28 +0900
In-Reply-To: <20190417143044.17655-3-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Wed, 17 Apr 2019 15:30:34 +0100")
Message-ID: <xmqqy346czhj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> commit b3a5d5a80c ("trace2:data: add subverb for rebase", 2019-02-22)
> mistakenly marked the subverb names for translation and unnecessarily
> NULL terminated the array.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 52114cbf0d..239a54ecfe 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1027,14 +1027,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		ACTION_EDIT_TODO,
>  		ACTION_SHOW_CURRENT_PATCH,
>  	} action = NO_ACTION;
> -	static const char *action_names[] = { N_("undefined"),
> -					      N_("continue"),
> -					      N_("skip"),
> -					      N_("abort"),
> -					      N_("quit"),
> -					      N_("edit_todo"),
> -					      N_("show_current_patch"),
> -					      NULL };
> +	static const char *action_names[] = { "undefined",
> +					      "continue",
> +					      "skip",
> +					      "abort",
> +					      "quit",
> +					      "edit_todo",
> +					      "show_current_patch" };

That's an improvement independent from the rest of the patches.

Now we've had the C99 designated initialisers weather balloon
changes for some time in our codebase, perhaps we can ensure that
these entries match the intended & corresponding "enum action"
constants?  If we can also ensure that the array is large enough so
that the trace2 call done like so

	trace2_cmd_mode(action_names[action])

is safe, that would be good, but that is secondary.

Thanks.
