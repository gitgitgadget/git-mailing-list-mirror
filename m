Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7697E1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 18:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeHWVd1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 17:33:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38941 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeHWVd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 17:33:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so4179957edi.6
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=cJuKI0qNehBfgHuaHS8LpI32RAPZgz41QT4IsVSH7AQ=;
        b=CrmapMJsz08OYNwszA76Qpe4IS4W5k+Wk3aQIsctzY8HHNDUlMDFepVPiS6gkV9zws
         yPvItUDMLBnh0dwbT3WKQKQcjk+sZHu0AQTSD1QmiltX6WICc2cQwpqWrXv9qcy9eOH6
         cte6/v90Y2G4CNxVhpEMQ5hJtAxUVt3+Dd+Fw+V0hBIUZhYh65AHAEqqRqQWZ1HOTl5G
         AAlIJqbfq+5IfgI9OPt5P286XU223qllFcndsZdPAuL0j6NNSy+n/zrXIxBUydK3kx0h
         oSCqVs8U8LrxkgdS8HaWB38GqV9MSH3wDSDwTTyHNKKpNNWFvMZGdc26Is0fLG6oeCC+
         5psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=cJuKI0qNehBfgHuaHS8LpI32RAPZgz41QT4IsVSH7AQ=;
        b=kYPN0fh5W4rCRlT9FTD2TboqSOWXDrKKRJUc76ygJuFegUURrk1zNUte5noBaNmUQM
         kQBWIuvQar5x06aMK17F36/u8XUXu+0EVL5vGn0whXEZ6UsB3QPN6D2/6zDb9gi+Hs18
         5+6BQj+qOOYTOIvKyLT1o7gmmG0dtkJcTGkihdiqjO0UUZ40rk+6qK1Z0RTbg2YMmnaj
         pG4URyR/IGlOu5TiyUmqlpZw/InO3bseJ0YHhoAEJAIXQ/zHQAW1FkNrkbrqAXx5+398
         zvhynKjKuOBtWdFGWSOcQtZ+yLFd/5MbfOwWCavDgthzlGctq4ohfTSEs4TyoST7VI1o
         9cEQ==
X-Gm-Message-State: AOUpUlHkxFPVw7ji34hEIBxqzkrNoR8geyYQ8a2nxTDzfHROgPbpm2M7
        Wcfqp8axAVGuNMBNkX54Weo=
X-Google-Smtp-Source: AA+uWPzUZr0aHkQENA5FqFZzb5rDoKND5DpfOwPXGKQ/rN/oWd2IABDYQrfdYIXNC6pbRZjZFJN1Ag==
X-Received: by 2002:a50:afa3:: with SMTP id h32-v6mr72145182edd.129.1535047354961;
        Thu, 23 Aug 2018 11:02:34 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id q17-v6sm1980852eds.78.2018.08.23.11.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 11:02:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken &&-chains in subshells
References: <20180626073001.6555-1-sunshine@sunshineco.com> <20180711064642.6933-1-sunshine@sunshineco.com> <20180711064642.6933-2-sunshine@sunshineco.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180711064642.6933-2-sunshine@sunshineco.com>
Date:   Thu, 23 Aug 2018 20:02:33 +0200
Message-ID: <871sapezba.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 11 2018, Eric Sunshine wrote:

Found in some 2.19 testing on AIX:

> +# here-doc -- swallow it to avoid false hits within its body (but keep the
> +# command to which it was attached)
> +/<<[ 	]*[-\\]*EOF[ 	]*/ {
> +	s/[ 	]*<<[ 	]*[-\\]*EOF//
> +	h
> +	:hereslurp
> +	N
> +	s/.*\n//
> +	/^[ 	]*EOF[ 	]*$/!bhereslurp
> +	x
> +}

AIX sed doesn't like this, and will yell:

    :hereslurp is greater than eight characters

This on top fixes it:

    diff --git a/t/chainlint.sed b/t/chainlint.sed
    index 8544df38df..2333705b27 100644
    --- a/t/chainlint.sed
    +++ b/t/chainlint.sed
    @@ -100 +100 @@
    -       :hereslurp
    +       :hered
    @@ -104 +104 @@
    -               bhereslurp
    +               bhered
    @@ -286 +286 @@ s/[     ]*<<//
    -:hereslurpsub
    +:heredsub
    @@ -290 +290 @@ N
    -       bhereslurpsub
    +       bheredsub

> +:subshell
> +# bare "(" line?
> +/^[ 	]*([	]*$/ {
> +	# stash for later printing
> +	h
> +	bnextline
> +}
> +# "(..." line -- split off and stash "(", then process "..." as its own line

AIX sed doesn't like this either, and prints:

    sed:    # stash for later printing is not a recognized function.

I have no idea what the fix is for that one.
