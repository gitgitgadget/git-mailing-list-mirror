Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349791F453
	for <e@80x24.org>; Fri,  9 Nov 2018 03:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeKIMyC (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 07:54:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38034 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeKIMyC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 07:54:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id e3-v6so357954wrs.5
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 19:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=Q+IFAPVHYQf/rgei1UG17u4PA1Cm13+zUAEHGBNicec=;
        b=mAV5nTMZo2Lti0xF8RswF5hcRV6Z1t0HfGpPmpGD1xNIpM0OHQPCf1wdipt+FDNvKU
         ylim+EEw0HV30QdtfIcngcgS9zHz0Pgy4soL4s0icRmZZ+LNfJRwgfpp6dLQ+p9rCCOr
         ZI01lFAzXfkYOQMkdOadyqZzUwh/cCSHGeblSO8EhBAvCGKK0ki//gMghNAdJ1XFs4kF
         Njym3Gk4ozVK2z3gFFwwMXM+QblwGGNFXBKOU8L4Vv8uVSUzjGx/tVDdjI0+8zcu5dH5
         Ll9EFmNsV7thOKl4Av26xheGygoqwNpjHLQSmSfdIG2zEGDnxmfw67NB1TMtVa3estln
         o9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=Q+IFAPVHYQf/rgei1UG17u4PA1Cm13+zUAEHGBNicec=;
        b=ah2Jel7Nhsf7oNNV6VpMltM8T7vgODp1m1HFuH+vcx8TBoU0dkPv9GRZYsYUDX7y+7
         ciOTk14VMSqhpQR4UhCuNCdjp+sKLOlRkOPzFSyQ63awUjN9KKLWMuvxjqa6ZUooJ229
         rGR3DEPxSONfsPHIWNXtj0bq4QUhxwXBl7YithQ5Jc6W5LCcLt+IAUD7ba2Fh/tg3Dm8
         cF/XnUgQxpAgeHWvYkmNEi+8w4gcesPHzF9efkFI2ks25cVjZ4DPav4xNcjMP5k0+yAP
         q3LBmVt2YHOz6tv2VSEG21/WTKf1CT1irkYcCELHZbF0rAahZ9g0tPtUWKM68gVI1wLg
         4hKA==
X-Gm-Message-State: AGRZ1gI16FgCKbRiK75y3JYvLUXEkesX0nyq/2fwTGp3QUrf/Yo8NQ6A
        1dhupaTCrH/Shoqi8kiYVIw=
X-Google-Smtp-Source: AJdET5dsiWdX1HjgV4QpgqpyoVQ+8ItlGCCrz2RYtDafQb6w6l/ccZ44rb99X/5DQ5AWxSkJ8u8ztg==
X-Received: by 2002:adf:b315:: with SMTP id j21-v6mr6261114wrd.46.1541733324388;
        Thu, 08 Nov 2018 19:15:24 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r1-v6sm4968465wrt.59.2018.11.08.19.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 19:15:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com
Subject: Re: [RFC PATCH v2] remote: add --save-push option to git remote set-url
In-Reply-To: <b910987d3aa778b39b6e27a75fe685a4797b8422.1541730538.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 8 Nov 2018 21:37:45 -0500")
References: <xmqq8t2f218l.fsf@gitster-ct.c.googlers.com>
        <b910987d3aa778b39b6e27a75fe685a4797b8422.1541730538.git.liu.denton@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 09 Nov 2018 12:15:22 +0900
Message-ID: <xmqqin1754c5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This adds the --save-push option to `git remote set-url` such that when
> executed, we move the remote.*.url to remote.*.pushurl and set
> remote.*.url to the given url argument.
>
> For example, if we have the following config:
>
> 	[remote "origin"]
> 		url = git@github.com:git/git.git
>
> `git remote set-url --save-push origin https://github.com/git/git.git`
> would change the config to the following:
>
> 	[remote "origin"]
> 		url = https://github.com/git/git.git
> 		pushurl = git@github.com:git/git.git

This sounds more like "saving to push" (i.e. what you are saving is
the existing "url" and the "push" is a shorthand for "pushURL",
which is the location the old value of "url" is aved to), not "save
(the) push(URL)".  So if adding this option makes sense, I would say
"--save-to-push" (or even "--save-to-pushURL") may be a more
appropriate name for it.

> +With `--save-push`, the current URL is saved into the push URL before setting
> +the URL to <url>. Note that this command will not work if more than one URL is
> +defined or if any push URLs are defined because behavior would be ambiguous.

Ambigous in what way?  You asked the current URL to be saved as a
pushURL, so existing pushURL destinations should not come into play,
I would think.  If there are more than one URL (not pushURL), on the
other hand, I think you have a bigger problem (where would "git fetch"
fetch from, and how would these multiple URLs are prevented from
trashing refs/remotes/$remote/* with each other's refs?), so
stopping the operation before "set-url" makes the problem worse is
probably a good idea, but I think that is true with or without this
new option.

> diff --git a/builtin/remote.c b/builtin/remote.c
> index f7edf7f2cb..0eaec7ef38 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -24,8 +24,9 @@ static const char * const builtin_remote_usage[] = {
>  	N_("git remote set-branches [--add] <name> <branch>..."),
>  	N_("git remote get-url [--push] [--all] <name>"),
>  	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
> -	N_("git remote set-url --add <name> <newurl>"),
> -	N_("git remote set-url --delete <name> <url>"),
> +	N_("git remote set-url --add [--push] <name> <newurl>"),
> +	N_("git remote set-url --delete [--push] <name> <url>"),
> +	N_("git remote set-url --save-push <name> <url>"),
>  	NULL
>  };

Needs update?

> @@ -77,8 +78,9 @@ static const char * const builtin_remote_geturl_usage[] = {
>  
>  static const char * const builtin_remote_seturl_usage[] = {
>  	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
> -	N_("git remote set-url --add <name> <newurl>"),
> -	N_("git remote set-url --delete <name> <url>"),
> +	N_("git remote set-url --add [--push] <name> <newurl>"),
> +	N_("git remote set-url --delete [--push] <name> <url>"),
> +	N_("git remote set-url --save-push <name> <url>"),
>  	NULL
>  };

Needs update?

> +		if (save_push) {
> +			if (remote->url_nr != 1 || remote->pushurl_nr != 0)
> +				die(_("--save-push can only be used when one url and no pushurl is defined"), remotename);

I _think_ in the future (if this option turns out to be widely used)
people may ask for this condition to be loosened somewhat, but it is
relatively easy to start restrictive and then to loosen later, so I
think this is OK for now.

