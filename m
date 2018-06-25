Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4B51F516
	for <e@80x24.org>; Mon, 25 Jun 2018 18:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964883AbeFYSTz (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:19:55 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34209 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964852AbeFYSTy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:19:54 -0400
Received: by mail-wm0-f52.google.com with SMTP id l15-v6so13187538wmc.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qikXA0Bt1Ji3Rpbb2stHJMJTJJjl912qUfZdf3gt1Gs=;
        b=YWZWbV0iLWNdGf4mYpT6hyJ5vJkh3KSZx5FEjCTRyrPCEWRPtk3c/6rwWglGrxgFbO
         TXHwOgvordLTBxBqY1IpfPeVDlmuvt7oKX/iCboe1Tkxju5JoaahLA0a4dOmemvy453s
         O8z+y2qHqR0xQQhPe6hhTkjQGMIePCAlUuoOoIpqocKjp0nyOx9XWE2U5NGesRLZDoAi
         k1c64OBVQJfRr0v30DQY20eXz4GH7AXVFRlQ9/hO+iPzFiBjPRMnoPGnNPDrjJ8sq/eS
         wHzBcvPn8m7nijJBLKmrS+BQ2PbNaQz+I0djWlta+qSFQfJfA1AhXs0QIyxmOi9Hfr4P
         H1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qikXA0Bt1Ji3Rpbb2stHJMJTJJjl912qUfZdf3gt1Gs=;
        b=ePrK+0chWtpmrOJwWfqRa9zP0hdEXpTD2OViAoHefBanzQYm2ZAOM1qG26Rrw2QIle
         cQRffCAZm4WbdMph5HOfvaRX37/bhoVko/UG6VtSqNkdccRTGqJ75ByVCisf+PWpX9x2
         MWHuJM4gLN8tyjAazMzTdCqDvlRLNJntVmsJJUFmrYWNmJBH/xE+J28C6zjvUB9enmoy
         LuU8yoFB0bF9iaaesldIC2CjHQyq3qbF8joOvfIq+5kR3ERUpKJBRREOnO46bGHCztgm
         QkzH04d3V+xxwuOcD/XM79yTgvq+JZnK4Mp9IbDHMpOcSDjj33Du9UArGVUQxvDPN3B9
         EUyw==
X-Gm-Message-State: APt69E2IorzHDvsig1jO5GAThEBXQBPRVhOPVmAa4zQwQTxpWbp3Te9Q
        MnmV2IK6giqe97G4nn38Be8=
X-Google-Smtp-Source: AAOMgpeS3wAVxADoHSEZCgAAjTflM4L8LQseY0/rWYZSz5l8OTi6ULuhNB1jL6/EjzuQpgH2ufEbeA==
X-Received: by 2002:a1c:2544:: with SMTP id l65-v6mr1810743wml.131.1529950792810;
        Mon, 25 Jun 2018 11:19:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g88-v6sm12993937wmc.27.2018.06.25.11.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 11:19:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] url schemes should be case-insensitive
References: <20180624085622.GA28575@sigill.intra.peff.net>
Date:   Mon, 25 Jun 2018 11:19:51 -0700
In-Reply-To: <20180624085622.GA28575@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 24 Jun 2018 04:56:23 -0400")
Message-ID: <xmqqvaa6ohiw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We seem to match url schemes case-sensitively:
>
>   $ git clone SSH://example.com/repo.git
>   Cloning into 'repo'...
>   fatal: Unable to find remote helper for 'SSH'
>
> whereas rfc3986 is clear that the scheme portion is case-insensitive.
> We probably ought to match at least our internal ones with strcasecmp.

That may break if somebody at DevToolGroup@$BIGCOMPANY got cute and
named their custom remote helper SSH:// that builds on top of the
normal ssh:// protocol with something extra and gave it to their
developers (and they named the http counterpart that has the same
extra HTTP://, of course).  If we probe for git-remote-SSH first and
then fall back to git-remote-ssh, then we won't break these people,
though.  I agree that it may be a good bite-sized #leftoverbit
material.

> Possibly we should also normalize external helpers (so "FOO://bar" would
> always call git-remote-foo, never git-remote-FOO).

> We could probably also give an advise() message in the above output,
> suggesting that the problem is likely one of:
>
>   1. They misspelled the scheme.
>
>   2. They need to install the appropriate helper.
>
> This may be a good topic for somebody looking for low-hanging fruit to
> get involved in development (I'd maybe call it a #leftoverbits, but
> since I didn't start on it, I'm not sure if it counts as "left over" ;)).

Well, noticing an issue, analysing and discussing potential
improvements and their ramifications is already half the work, so it
does count as left-over, I would say.

It may probably be a good idea to do an advice, but I'd think
"Untable to find remote helper for 'SSH'" may be clear enough.  If
anything, perhaps saying "remote helper for 'SSH' protocol" would
make it even clear?  I dunno.
