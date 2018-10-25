Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6ED1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 09:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeJYR6r (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 13:58:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37053 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeJYR6r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 13:58:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id g9-v6so8515880wrq.4
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aTKUeoOoXHCQmGqkUOeTRTlWQQe8V9R09h8patCamsA=;
        b=elf+WRUIG5Z6qvIO6oVhfnybQlGqkh0zkVpnBwG910Mw/XLZusl84S318q6kuVQBrX
         XPwwESwTe65OvSQixHy5Gh+41AqqfE8XaTKot+8EhiVxcT3FWIZeSJj40Dhmf8ivI5yQ
         fU8WQkcLx7DFEwcMk24owwMdHDi5s5Yf9BFacuCrztzJXyknEhVagGqBPOPfauqejqgd
         aFymwFkSDNPrXiXaeNyEoSdYgRnK0Z3d1N3xAbURF39KWJg/Ag3pTtl4Z+dTf4wAxNrQ
         lgBugaE9SzfJTp37OhL74Cy99H5NasAluxvYUOM1jbxn8Z1S/JZFre/A0kRTUPw5CLqO
         axdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aTKUeoOoXHCQmGqkUOeTRTlWQQe8V9R09h8patCamsA=;
        b=c82f02sYyE5X11iA2y0CiTR/Ms/uaoo3tLKHrxYhz2YfmRp/r/tpU2VgJJjbXUgryh
         GETfcaTHJyHomFxspOoXDL+gkzTtUTLzErTX//dDVZxO52ADd25UwJ5EL3WMIsmJZGfy
         fLjwuOzdl5n8SbdZILvFd4hpnplwXt1Z94JYRquxtWLl43SD96akGC4h6rURBiqlCv2Q
         Ec5cdvfUNdm1acG5xVSaTeGQDWQ+GoVXF9UkKyySEJai6BAeSM+5ZnwMl7ibreZknFBB
         GJ9wrVJMCihbihcH0LmOrVzLw6HKB/M3yx9zbb8c2wxXxjmabYlJg+xY22rF8Aj6xgFY
         134A==
X-Gm-Message-State: AGRZ1gKA1ttKJH6+yLSm51gu01pdRbP6DRGNVMH9yaXlJG5cdqKWjzEJ
        yt34jKQOyl/n0BZ2+Lmps2s=
X-Google-Smtp-Source: AJdET5e1zXryNtHdDVYujsDoAaYwv2/XWv8WR0/EyFF5xSAJKOZfnq4JZUwAPVt12QAUoj1dZAc75g==
X-Received: by 2002:adf:f8cd:: with SMTP id f13-v6mr1043368wrq.265.1540459610917;
        Thu, 25 Oct 2018 02:26:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m16-v6sm856081wmd.35.2018.10.25.02.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 02:26:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        benpeart@microsoft.com, peff@peff.net, sunshine@sunshineco.com
Subject: Re: [PATCH v4 2/3] reset: add new reset.quiet config setting
References: <20181017164021.15204-1-peartben@gmail.com>
        <20181023190423.5772-1-peartben@gmail.com>
        <20181023190423.5772-3-peartben@gmail.com>
        <3c31d5c3-df46-69e3-c138-30a93d9b3ce4@ramsayjones.plus.com>
        <xmqqpnvyk4jc.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 25 Oct 2018 18:26:49 +0900
In-Reply-To: <xmqqpnvyk4jc.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 25 Oct 2018 13:56:39 +0900")
Message-ID: <xmqqbm7igyw6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> To be honest, I find the second sentence in your rewrite even more
> confusing.  It reads as if `reset.quiet` configuration variable 
> can be used to restore the "show what is yet to be added"
> behaviour, due to the parenthetical mention of the default behaviour
> without any configuration.
>
> 	The command reports what is yet to be added to the index
> 	after `reset` by default.  It can be made to only report
> 	errors with the `--quiet` option, or setting `reset.quiet`
> 	configuration variable to `true` (the latter can be
> 	overriden with `--no-quiet`).
>
> That may not be much better, though X-<.

In any case, the comments are getting closer to the bikeshedding
territory, that can be easily addressed incrementally.  I am getting
the impression that everbody agrees that the change is desirable,
sufficiently documented and properly implemented.  

Shall we mark it for "Will merge to 'next'" in the what's cooking
report and leave further refinements to incremental updates as
needed?
