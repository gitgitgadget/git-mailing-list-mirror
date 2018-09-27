Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F0071F453
	for <e@80x24.org>; Thu, 27 Sep 2018 13:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeI0ULv (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 16:11:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53627 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeI0ULv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 16:11:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id b19-v6so6020163wme.3
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oCJtI3hAYjKm3GtuZI5CTQSvshY4Dq9/FlfTeAFkiRY=;
        b=hCJnGeuAxrx7+cuaxzaFV15jN55E4tIGahheSBfRPSDIVCAdR0hU58vj5kM2HQx/MW
         XTUQZIouDO1kXuFwg/rSvFJxZMFIOMDUt2Da4Y2uTOmJGH440Yxw9L+qRX7WdAQudd1n
         nLD7ECDVU+C6pY6GbfdzM0AOVh3X7GIQQdZ+5rA97OWgRmF0BVLq7wUaE187Lfgf5lCl
         0qFn8O8l+rEiqfWcVtZwEUgiwpMZDAes6rX9F4eg0TQybo8ozBKZOlJzrgaWlQs/9YKa
         AlaURR4RuSa9tRr+6g/MDwQkGhGMlRdJVDe7GkbH3k7wMmK/hZpOKjxOTqtTJ6rGG5jh
         el6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oCJtI3hAYjKm3GtuZI5CTQSvshY4Dq9/FlfTeAFkiRY=;
        b=Kp23u7OoVqzf7jYejGQ1pnB5i59SJJCIQvS8x0FH/3CFGYScY+9XyIBLR/FIgq5VTX
         LcSndUq3L6hMiaBGmbbFI7+8RTZnKF/9quz+n/GzYIK9K5MHKVlyQcr1+kXIGYzGmN5v
         LWbLx22qt3vKw0DBI4ZQup+ovjADfeXECW/WM3m9lsWOvsYsEKFJD/ZVclkOZJaTDzEd
         j1EfTFOtS6uhMjCdvdvF3XwOxVNCfRB1zKXCmUOILEoZoi5NUt23iawWZ91K3cwTbAj+
         XuXDL8N/kmqApfbhZ5brJ4EzglksxID9CsPmmPcAYR1ConFs3NqfPlAQz9QJqLGm/IyW
         t1Mw==
X-Gm-Message-State: ABuFfojaqwK3SNB9P3ztBK+PIuTyAsM5gGQDC4TmR2DZny+N0fVLEaEs
        0iYydF0edqErbXAVqdGqts8n621KYLE=
X-Google-Smtp-Source: ACcGV63OPdS08jlIkHWQIIpZ905B48QerAG+ReVufpBEflO/7SccH1lHmd0KVMnClcYB7bI4FmVl/A==
X-Received: by 2002:a1c:a187:: with SMTP id k129-v6mr8180993wme.111.1538056406832;
        Thu, 27 Sep 2018 06:53:26 -0700 (PDT)
Received: from evledraar (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id t13-v6sm1445827wrn.54.2018.09.27.06.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 06:53:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] Fix the racy split index problem
References: <20180927124434.30835-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180927124434.30835-1-szeder.dev@gmail.com>
Date:   Thu, 27 Sep 2018 15:53:24 +0200
Message-ID: <871s9fjbcb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 27 2018, SZEDER Gábor wrote:

> This is the second attempt to fix the racy split index problem, which
> causes occasional failures in several random test scripts when run
> with 'GIT_TEST_SPLIT_INDEX=yes'.  The important details are in patches
> 1 and 5 (corresponding to v1's 3 and 5).

Thanks. I'm running the same sorts of tests I noted in
https://public-inbox.org/git/87va7ireuu.fsf@evledraar.gmail.com/ on
this. The fix Jeff had that you noted in
https://public-inbox.org/git/20180906151439.GA8016@localhost/ is now in
"master".

I take it your
https://github.com/szeder/git/commits/racy-split-index-fix is the same
as this submission? Anyway, I'm testing that cherry-picked on top of the
latest master.

Unfortunate that we couldn't get the isolated test you made in
https://public-inbox.org/git/20180907034942.GA10370@localhost/ but I
don't see how it could be added without some very liberal
getenv("GIT_TEST_blahblah"), so it's probably best to not add it,
particularly with the C rewrite of git-stash in-flight.

I'll report back when I have enough test data to say how these patches
affect the intermittent test failures under GIT_TEST_SPLIT_INDEX=yes.
