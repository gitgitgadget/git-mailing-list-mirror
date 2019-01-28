Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682B61F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfA1V6n (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:58:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39301 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfA1V6n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:58:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so19840159wra.6
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 13:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=wpZJ4zTU+SW91TiKS1JTfYX99ELW0KV6wEm+o8Z9GEA=;
        b=otP1UrROPckn5OhWlWTvPvjMBd2SgFPiGRFAoUAOpL0md+RCLq57FoJaYHf0r3XMmK
         N3En0zHJwbglA3qC3l9WBllcE9tlcH/fqv+2I39GZEXF1Ma+vrgKODOh7+KQXMXWcPp0
         Mf2AFpV4ADpeD/+FwIYV/qg1ed0fq3gvOhSW5OTsj8a7vvlXu2ARl71S+Em9kwCG8lvC
         UV4Q6hRSwzjAIo1S82rB1Nh+cUMae8bGmDKdU8iHmMF3zRfo5K0UEu1I1SvdoeSBbH8s
         uwcPhCo/6YkQAH6QH+bjr1dhxFdw9nrMt1PN2adQglUepvMHpti+VxKwgFkWCPVPApQ4
         ZGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=wpZJ4zTU+SW91TiKS1JTfYX99ELW0KV6wEm+o8Z9GEA=;
        b=fpRjjSoms+T7iHuBtENaigzcV77h9DZSZAT40k+HrbcVTH9XK7g6i0WtdJFtwVc56W
         TCJ7IaCtc48CJuiRSlvG/qe/VVsxDM8j56ZdjfJEi8pKEaPmXSoP1Qp11mpJjerIU/7a
         KBbDJvZajNJ/xX7XH33T0whs0FYkrEwH3nKOtAxT761388yRze8DAb/Fjg+ioEiTgdrs
         9xZrPPOm9f8Ezb4FubMUmXgayj/jgYcRr9OcdHJr0alE053TaF5i6zYwYBe46/lq3ZxY
         DBEfzMTn3vZmFcEL1+SsgyeoKUavEyYtzlhH/8BQ2dA5kNFgimzFUkoF94TFlQTdTVlO
         ozTg==
X-Gm-Message-State: AJcUukf/p696hDAZnpBVA7xTBwlflz+bygjakpzib5RGFgeRYevWFFnL
        A7fR/yVGr/B7+GcB+cQUB53SUGWX
X-Google-Smtp-Source: ALg8bN6wNhErzcfiR0h2c+tHoEIGxByqldHYTtg/B6UQc5z3L3Up5o+aVqanFJOdJZcckkkgpCXhQw==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11mr23386275wrt.180.1548712720675;
        Mon, 28 Jan 2019 13:58:40 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h131sm1087102wmd.17.2019.01.28.13.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 13:58:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] checkout: print something when checking out paths
References: <20181110133525.17538-1-pclouds@gmail.com>
        <20181113182800.26984-1-pclouds@gmail.com>
Date:   Mon, 28 Jan 2019 13:58:38 -0800
In-Reply-To: <20181113182800.26984-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 13 Nov 2018 19:28:00 +0100")
Message-ID: <xmqqimy8a1gx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> One of the problems with "git checkout" is that it does so many
> different things and could confuse people specially when we fail to
> handle ambiguation correctly.
>
> One way to help with that is tell the user what sort of operation is
> actually carried out. When switching branches, we always print
> something unless --quiet, either
>
>  - "HEAD is now at ..."
>  - "Reset branch ..."
>  - "Already on ..."
>  - "Switched to and reset ..."
>  - "Switched to a new branch ..."
>  - "Switched to branch ..."
>
> Checking out paths however is silent. Print something so that if we
> got the user intention wrong, they won't waste too much time to find
> that out. For the remaining cases of checkout we now print either
>
>  - "Checked out ... paths out of the index"
>  - "Checked out ... paths out of <abbrev hash>"
>
> Since the purpose of printing this is to help disambiguate. Only do it
> when "--" is missing.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  v2 updates the messages a bit but it does not check isatty or add
>  --count-paths, for consistency reason with how messages are printed
>  in the branch switching case.
>  
>  Consistency is not always a good reason to follow. But I haven't
>  seen a strong reason to go against it.

One small bug I saw since this was merged is that the message that
is given when unmerging, i.e.

	git merge other-branch   ;# conflicts
	git checkout --m <path>

is misleading.  It gives the same "checked out ... out of the index",
but it should be made a lot more distinct, perhaps "unmerged N paths".
