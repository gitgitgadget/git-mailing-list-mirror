Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7E5B1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 14:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeIQUZ2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 16:25:28 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:53635 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeIQUZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 16:25:27 -0400
Received: by mail-wm1-f49.google.com with SMTP id b19-v6so10018113wme.3
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=t7lIIlm/gjvK/P5+wuiG6F+rxC41l1MoN3yfa3rJ2J0=;
        b=bH3PlUmdky9Q82jVzEhy17hpmrv4AKD7U0Ed72VEAW/p9pa5ZRI3R49QJJGrNoITvw
         B3c3TYUXLPHeaVb4d/vI+yxBeAYbQ2jNypa30YKiQZYGUpR4iuNPvuny22SqfLqJXiIO
         aXDqr7ffhj3A0+BvdTd6LfM0DXKI0iRnmeW3fuHvdqoeLvceDYw8JrLWVZTxqvCt6PEd
         CSLIOI6vZiwhdnzCdXpu6t1uwTSsKvVv3lP7IiqzHXMocyA0CSsK6DkTYzikCFMyXsVP
         TPVV8kB4JbetgQMUi+z+sf6BM8GJ9USLGuptXG4DzR3kmd8CZG2TF8RyHqw8M9WlK+lJ
         qHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=t7lIIlm/gjvK/P5+wuiG6F+rxC41l1MoN3yfa3rJ2J0=;
        b=Sc0MbngqZl5ZyamWkQpOkuBmzeUaVjfs2eDcp1gbH6SRRfP8jT5oyFLvPUuqwK+JL+
         jW0UeoxB3g5RFzlExZR7/5B+7BhIIhoUXgiKKacCKKjcwACq/7vaEltE4OAdIHDntIXa
         /k32frIZ6oWLTLcmE0hXxn9dHpC3SqvSqsdJ3CL8mt+Vz7ZvszJg4ImAVmo/XGTWF+pU
         JauXWKSYl7dj1YBUfaut5TeXXdt0ivzPD9TXs5/Evv9gkiP/NLuMGe59Q6MVahbytp9g
         sqCXjhSfjdZ8gD4oPcef6P3A1Fb+ph9TJgIb4Wrnj+RAYfA22Y1kEB1fGHJAD/kvACyp
         l4eg==
X-Gm-Message-State: APzg51AUG2/il4jfNV4hRjRrZla3S8FOHmSjz22t31mAk7yqMHCNXcN5
        3Sso3vyCqApxopHBDUDA2xWrHEEa
X-Google-Smtp-Source: ANB0VdYCO2Or9GL4C3gdzauIukBTXf/YEYJ2g6XGfjCTidGGpSqnfqLa7IPmeFeymYrogsJeAoiccg==
X-Received: by 2002:a1c:5c4:: with SMTP id 187-v6mr12122440wmf.10.1537196263555;
        Mon, 17 Sep 2018 07:57:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f132-v6sm7349532wme.24.2018.09.17.07.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 07:57:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: diff between "--no-local" and "--no-hardlinks" for local clone?
References: <alpine.LFD.2.21.1809170429140.8299@localhost.localdomain>
Date:   Mon, 17 Sep 2018 07:57:42 -0700
In-Reply-To: <alpine.LFD.2.21.1809170429140.8299@localhost.localdomain>
        (Robert P. J. Day's message of "Mon, 17 Sep 2018 04:31:40 -0700
        (PDT)")
Message-ID: <xmqq8t409no9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   perusing "man git-clone" and, from the first part of the OPTIONS
> section, it's not immediately obvious what the difference is between
> using --no-local versus --no-hardlinks when cloning a local repo. both
> seem to suggest that the local git transport mechanism will be used,
> so what is the difference?

The "local" optimization is designed to use hardlinks to share as
many object and pack files as possible to avoid copies.  You can
optionally disable the use of hardlinks to always copy, without
disabling the "local" optimization.

If you say --no-local, --[no-]hardlinks has no relevance.
