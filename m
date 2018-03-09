Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189C01F404
	for <e@80x24.org>; Fri,  9 Mar 2018 19:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932087AbeCITK2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 14:10:28 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43504 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeCITK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 14:10:27 -0500
Received: by mail-wr0-f196.google.com with SMTP id a63so6382225wrc.10
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 11:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GVFH6mhklts6huUbUADoqlTmvP9gAzYzBcJ8rlGn57w=;
        b=qddVFlH11jPJiPH6jtrWzDz4+fmasKKsN81+j5SocmzuTYAL1pj439ml9xGnufTbzt
         ZY/twlmHjGWzYDcRKqCUxyrJ6EXlGc1d/KYLnD86k2ZEJeBGeQebHCPUsqwY1tc7Ak7O
         MiPx7DaRmd5tU1IhxkK+dzEIiv0h9lF2yciQOocr3CBhmqGBw5f74nKu8LKJz19GfhvM
         vY1Ut1PeNCkQdFkaIbV2/twGhtutz1NHSKEzEMbRavTbiiegUwLUip9B0kOPtmXTUOau
         Z+4w09Vfag+dLWXvvMBsjcHsC5sdkHvi2Sag/nl7X+RWbFGSzS5+gRKB3w0RMsVFvR2/
         yx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GVFH6mhklts6huUbUADoqlTmvP9gAzYzBcJ8rlGn57w=;
        b=nLbNRTbCjp3+eecnjgYFWuLwi22/5LTL7qpmh3Izecs5i/EFnMEQlPEWsn97FUfyyT
         vsAvXNfTb4hPzWJ0FWJUd46wBG/YZacN2OXYxYulqlIvIVQSU0HrNb3HSJVBgKMOJDnM
         VScRuGaLG+HRJKZSDUHb3wT1bRKcFqkP/J7jwyEXYu9xWoC47vnF0o/Xaos+wr7QNyou
         ahR9AYW8QCzgUFgJDzQ5kxrbaQ7CBbDxjQLaHmWLUwjJRSXO6GWw0OvIl2x5WIfjs0S+
         W8U1n2uYCftrGd8Jkt2O7IrzvSeQ1cTCNkmuoUxoyDS+tBcc5x3bhCfLGFTAOltWLQN7
         StlA==
X-Gm-Message-State: APf1xPC1gFQamKA3eby28VTAgWU+DBEphtZ5tPjcW8QrKJ91KowlDJ/l
        aBSW/QiYeDph5YHX5zNRcLA=
X-Google-Smtp-Source: AG47ELvgs0kzGxYCVoLOYDXe52x/zj/IUermKFQOCHQRi8lFIgeBbd2WEVxaDo+iNB4ci3W0YLQNCw==
X-Received: by 10.223.151.101 with SMTP id r92mr27217837wrb.120.1520622625499;
        Fri, 09 Mar 2018 11:10:25 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 56sm1995798wrx.39.2018.03.09.11.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 11:10:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v11 06/10] convert: add 'working-tree-encoding' attribute
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
        <20180309173536.62012-7-lars.schneider@autodesk.com>
Date:   Fri, 09 Mar 2018 11:10:24 -0800
In-Reply-To: <20180309173536.62012-7-lars.schneider@autodesk.com> (lars
        schneider's message of "Fri, 9 Mar 2018 18:35:32 +0100")
Message-ID: <xmqqmuzh5alb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> +static const char *default_encoding = "UTF-8";
> +
> ...
> +static const char *git_path_check_encoding(struct attr_check_item *check)
> +{
> +	const char *value = check->value;
> +
> +	if (ATTR_UNSET(value) || !strlen(value))
> +		return NULL;
> +
> +	if (ATTR_TRUE(value) || ATTR_FALSE(value)) {
> +		error(_("working-tree-encoding attribute requires a value"));
> +		return NULL;
> +	}

Hmph, so we decide to be loud but otherwise ignore an undefined
configuration?  Shouldn't we rather die instead to avoid touching
the user data in unexpected ways?

> +
> +	/* Don't encode to the default encoding */
> +	if (!strcasecmp(value, default_encoding))
> +		return NULL;

Is this an optimization to avoid "recode one encoding to the same
encoding" no-op overhead?  We already have the optimization in the
same spirit in may existing codepaths that has nothing to do with
w-t-e, and I think we should share the code.  Two pieces of thought
comes to mind.

One is a lot smaller in scale: Is same_encoding() sufficient for
this callsite instead of strcasecmp()?

The other one is a lot bigger: Looking at all the existing callers
of same_encoding() that call reencode_string() when it returns false,
would it make sense to drop same_encoding() and move the optimization
to reencode_string() instead?

I suspect that the answer to the smaller one is "yes, and even if
not, it should be easy to enhance/extend same_encoding() to make it
do what we want it to, and such a change will benefit even existing
callers."  The answer to the larger one is likely "the optimization
is not about skipping only reencode_string() call but other things
are subtly different among callers of same_encoding(), so such a
refactoring would not be all that useful."

The above still holds for the code after 10/10 touches this part.
