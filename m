Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0803A1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 18:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbdLKScx (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 13:32:53 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:39637 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdLKScv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 13:32:51 -0500
Received: by mail-it0-f53.google.com with SMTP id 68so18076133ite.4
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 10:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmKyTYC1HxwBTTFZEyEucCd5vXA5deFJQI2OChknuvU=;
        b=EizcBQaEA89goedS5aw2NAPEwaQbN58CLq2yBekWRuLQD0Fi860rh8M10MksoV2I2b
         G63OwYBFNcOjcBSieQpx46sTRp14CWxLF9OJytDeqY5+sv/albqbiMkLIvrkE57v1Imp
         E3+gnj0YkWI5wuxTTmu5Gr6D1KeJlQvVcbOsQWlSFWinuZnBEZCY+k5047u4lwvo/6y7
         l7ndtv7Audeld13iDcrC3usVkVn00xZ6ywKFRp/z4wrL37zSSH/zUc1Y/TV4fyaUZGIc
         3vo/wxBaGAKxx59Dvij1W9TdTe8O6JnF4rjiEYG1NelvX11Z/Spsb6Pw4CxLYPtWDqnT
         IVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmKyTYC1HxwBTTFZEyEucCd5vXA5deFJQI2OChknuvU=;
        b=oKOpK978sfLHrIbyBE7X4XKFNEutc7rGHDDOcC9FGnc6/mu4g4R3LFqMNaIgHJziyf
         sbhRK1sEgsRIy9VQ/mWjIHjzquADmodghbvXSRfYOl/7jgTsJfxYVuVL++bApmVlAknU
         oBYjG/91fl0c8B0KwJhmptNd0Eoxd9GV4f4+/6NIfFBBOymkL8nwZ8ukuIaR2tbLus0h
         JgaN3SYtMKSZwx9STIdoqrZeq/xbaYmlTnLiy3rciDrNV+AxTqQBU/Ic6nmSAgDeNNKN
         3KNBWUac8qCTgU+UWu8Xle3eh8ns4ibWO5xCL20VYaiIxFAvWr/BeW7oaspfzc/mlDmr
         Pq0Q==
X-Gm-Message-State: AKGB3mLKAw6Q3l2gFzOsor0paHQaIkwV38oqqOMSviJu2bR+KIFsgfAO
        yWlulRD8a8idI5xSeBa6OT73uQ==
X-Google-Smtp-Source: ACJfBov055vQ7AnIil6brfAK8YBGisjT6gLn/GFTBRW+yRBqucEijkfthVxISsQVrT1SuTRWVXYv1g==
X-Received: by 10.107.142.140 with SMTP id q134mr1926823iod.259.1513017170587;
        Mon, 11 Dec 2017 10:32:50 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:909e:f3a:a55a:80a])
        by smtp.gmail.com with ESMTPSA id m21sm4130393itb.43.2017.12.11.10.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Dec 2017 10:32:50 -0800 (PST)
Date:   Mon, 11 Dec 2017 10:32:49 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        sbeller@google.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH] decorate: clean up and document API
Message-Id: <20171211103249.e34385be4688734442659e71@google.com>
In-Reply-To: <20171208095510.GA29626@sigill.intra.peff.net>
References: <20171208001424.81712-1-jonathantanmy@google.com>
        <20171208095510.GA29626@sigill.intra.peff.net>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 8 Dec 2017 04:55:11 -0500
Jeff King <peff@peff.net> wrote:

> I have mixed feelings. On the one hand, compiling and running the code
> ensures that those things actually work. On the other hand, I expect you
> can make a much clearer example if instead of having running code, you
> show snippets of almost-code.
> 
> E.g.:
> 
>   struct decoration d = { NULL };
> 
>   add_decoration(&d, obj, "foo");
>   ...
>   str = lookup_decoration(obj);
> 
> pretty much gives the relevant overview, with very little boilerplate.
> Yes, it omits things like the return value of add_decoration(), but
> those sorts of details are probably better left to the function
> docstrings.

The part about iterating over all entries should probably also be shown
too. Besides that, I'm OK with having a simplified example in
documentation too, but I'll wait and see if others have any opinions
before making any changes.

> Other than that philosophical point, the documentation you added looks
> pretty good to me. Two possible improvements to the API we could do on
> top:
> 
>   1. Should there be a DECORATION_INIT macro (possibly taking the "name"
>      as an argument)? (Actually, the whole name thing seems like a
>      confusing and bad API design in the first place).

Agreed about the "name" thing. I'll add a DECORATION_INIT when I make
the next reroll, but I think that having it with no argument is best
(and instantiating "name" with NULL).

>   2. This is really just an oidmap to a void pointer. I wonder if we
>      ought to be wrapping that code (I think we still want some
>      interface so that the caller doesn't have to declare their own
>      structs).

It is slightly different from oidmap in that this uses "struct object *"
as a key whereas oidmap uses "struct object_id", meaning that a user of
"decorate" must already have objects allocated or be willing to allocate
them, whereas a user of "oidmap" doesn't.

Having said that, it is true that perhaps we have too many data
structures doing similar things.
