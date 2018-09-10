Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 087371F404
	for <e@80x24.org>; Mon, 10 Sep 2018 18:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeIJXZ7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 19:25:59 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:39399 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeIJXZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 19:25:58 -0400
Received: by mail-wr1-f54.google.com with SMTP id s14-v6so14017065wrw.6
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 11:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4gN/qMf6eZzf+4ITly8LUzKa7CctWdq5WYSGnoC/A54=;
        b=R9tL3jpwRP8UjI3pr7Qdjfhc9nG7RUEj1Ytz1bp6MwGjBKNaNk1G/CRlIGse9nNFxW
         DVbBYzr40sqq6ZZwOubxQd7vzyz61CQI7zw1LSyyGdMbFwovOloRAlQParpZ7L9GGJx1
         V5RVVUhtMw32eBfF13Q01Jf46FngL9wGQnmJa9puw0Gc1iTVuOJXzhTiV3pfeNS7mvH5
         xxm8JDWHLU+nOigfqiqFl38JJT+v7rE6DdljXds/oOicqLR+y70Md/GT0P2bgE0bs38X
         tj4xBkZ0TwBOcOn+1OGWhC7PmtzhtT9Zw23/tsVyHrY/uWwZnGAddHeDod9tuW0wkC69
         56sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4gN/qMf6eZzf+4ITly8LUzKa7CctWdq5WYSGnoC/A54=;
        b=NXK/0KyFjCyKuKtKlPaIXOlcfY4wk/NAbCDlCe9OCLpQt6AAy0agEtC+y63VvtlWgx
         3Nahb43U1eAZ2hZWBfwJtZYB7gjf92KeiAPV47qy5UhR8PwyaCGAu7mhihdngAERo/I+
         DZCgoS/vQTh3sr3TMd5Q6fKhepl+qiw/zFDj8f/896UML+cE9IEhRe7eKJSxRCWCpAlc
         vGloXy3eUW6kypvMkgWXJkHkkPJEGXRU5XAXVxy6RNMtX/GTudyMh9yhl+HySripOBxh
         PseiWkAEUFC932T8eVSX2GpARTE3Tj3o55CZLdsEVpQjIjzCpQ/zT7fZwIK8sNTJs7dS
         rlfw==
X-Gm-Message-State: APzg51ByZlLhz4ruzamYfsUY3BCb+drPP1OQ8fMLWQ7+Zlp/eNyGxNBa
        lhDK7TKlHETybDEGMTNbp3oMNubF
X-Google-Smtp-Source: ANB0Vdb5sAjWukCqFy8preVnF8MvqjBRBUvIx1p5eJFnx6gzOGvyxYEx5BJO75dZKbIUihA+S46WGw==
X-Received: by 2002:a5d:4a87:: with SMTP id o7-v6mr14675550wrq.132.1536604233045;
        Mon, 10 Sep 2018 11:30:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j6-v6sm12159634wru.64.2018.09.10.11.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 11:30:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Stas Bekman <stas@stason.org>,
        git@vger.kernel.org
Subject: Re: git silently ignores include directive with single quotes
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
        <20180908212256.GB31560@sigill.intra.peff.net>
        <xmqqr2i1thbs.fsf@gitster-ct.c.googlers.com>
        <20180910171422.GA26356@aiede.svl.corp.google.com>
Date:   Mon, 10 Sep 2018 11:30:31 -0700
In-Reply-To: <20180910171422.GA26356@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 10 Sep 2018 10:14:22 -0700")
Message-ID: <xmqqa7optdbs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>  1. Treat single-quote as worth quoting in config.c::write_pair (line
>     2516).  This would already help with the original issue, since the
>     config would say
>
> 	[foo]
> 		bar = \'baz\'
>
>     allowing a quick diagnosis.

I am mildly against this, as long as you feel that all the remaining
steps need to be marked with "(optional)", because this will give
readers an impression that somehow single-quote is special.  If we
do not intend to make it special at all, we shouldn't.

If we do commit to make it special, then this is a very sensible
first step that is backward compatible, of course, and I find that
the following steps form a reasonable transition plan, if we intend
to follow all the way through.

>  2. (optional) Warn if a value is surrounded in single-quotes,
>     encouraging using backslash to disambiguate.
>
>  3. (optional) Error out if a value is surrounded in single-quotes,
>     encouraging using double-quote or backslash, depending on the
>     user's intention.
>
>  4. (optional) Start treating wrapping single-quotes specially
>     somehow.
>
> I think step 1 is a good idea, but I'm not convinced about any of the
> later steps.
>
> I also agree with the comments upthread about wanting a way to do a
> '[include] path' that errors out if the file doesn't exist, and maybe
> even starting a transition to repurpose standard [include] path to do
> that.
