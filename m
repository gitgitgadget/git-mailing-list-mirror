Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C02251F453
	for <e@80x24.org>; Thu, 27 Sep 2018 21:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeI1DnI (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 23:43:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39484 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DnI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 23:43:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id q8-v6so217549wmq.4
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 14:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1oiIc7TYga7udRbPY4UHe3Wj4HX7FjMltZdG6nf7ZxM=;
        b=EKJDcMSB8kYtqwMTzaKXc3hptILfC/fTbl/GHKAohsdKTj+Hyv+UEgIiqp3RDglbyC
         zZWIvpf/VF/k/S5DhP5/ax33xpwkha3OPRWBkKl0oJQRtaqcii+vY5U+8ivBs8hC9lgr
         qwzJEtW7pP4S6+dPKnMYQXWICyWub+MwXEhW5Ezpl+foc3af6M5gSzkYhE3+HQopMeZK
         iQj28Q+dFnAs8KHRp1B4xmQp8RpyEUHJNiOs0GIRU6XRG1gLPaLtHvTD7m0WQ8MmQ/sW
         6yRI90cQLhvd94fAuh8Ru/YvAG9yplpnNtLJOPitrOrM5RiTFj7kPkns2dOw/sYnY9QJ
         ptRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1oiIc7TYga7udRbPY4UHe3Wj4HX7FjMltZdG6nf7ZxM=;
        b=mQv1sD2X5AIuzv3zbW8abCrYN2ZG28QzKyBNHzoi3wkNeD7c4yFARp5VgIqsWg0q5S
         CjxLgn6m2XZfx0+dz668oUqdzaLirGyqR2QLE6yg3uJdv52QttI+UJYJvTDH8dnjHtez
         rAPTP6Zmb2xuyPx0Z1Q42Zd8SJVefFAWim64k4KXhsl65ElRrOjkOav4AMhKDZHMmStX
         BL1n64WKMfIKFr0jFuh4nKAQ0CwYhh9oIg7d7d8fkuAxcaaTlfapBfPVfTdRv8pBujCH
         NjgO0jXQ8dIE6UwBIbWY6X3eK8fn9DBD1c5sLD3JADfGiLWd/uTlAYTZ/5WKDilKGDsY
         sQ7Q==
X-Gm-Message-State: ABuFfogv4aksxzK2VvmAKUSlgp6e/eui08q9z5I6WUNq7H42WQjB/3qg
        4ETTJha5a8Z/1aMgL8bpp1Y=
X-Google-Smtp-Source: ACcGV60xCDCPz0ZoxsIx9yT3/6BxjVwESt+3r5p0IzvsoMgkdAey6ohNQPx3DXbkw9pGQ+XgwgNUZw==
X-Received: by 2002:a1c:a9ce:: with SMTP id s197-v6mr268686wme.77.1538083370619;
        Thu, 27 Sep 2018 14:22:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v192-v6sm106168wmf.40.2018.09.27.14.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 14:22:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Nickolai Belakovski <nbelakovski@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] branch: colorize branches checked out in a linked working tree the same way as the current branch is colorized
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20180927181708.GA2468@sigill.intra.peff.net>
        <20180927192804.GA27163@rigel>
        <20180927193559.GB6950@sigill.intra.peff.net>
        <20180927194150.GA7452@sigill.intra.peff.net>
Date:   Thu, 27 Sep 2018 14:22:49 -0700
In-Reply-To: <20180927194150.GA7452@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 27 Sep 2018 15:41:50 -0400")
Message-ID: <xmqqo9cifxee.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 27, 2018 at 03:35:59PM -0400, Jeff King wrote:
>
>> now, we could do:
>> 
>>   %(if)%(HEAD)%(then)* %(color:bold green)
>>   %(else)%(if)%(worktree)%(then)+ %(color:green)
>>   %(else)  %(end)%(end)
>> 
>> (respecting the user's color config, of course, rather than hard-coded
>> colors).
>> 
>> Trying that out, though, I'm not sure if we properly support nested
>> if's. That might be a bug we have to fix first.
>
> Sorry, false alarm. I just had a typo in my format.
>
> This seems to work with the patch I posted earlier:
>
>   git for-each-ref \
>     --format='%(if)%(HEAD)%(then)* %(color:bold green)%(else)%(if)%(worktree)%(then)+ %(color:green)%(else) %(end)%(end)%(refname)' \
>   refs/heads
>
> It sure would be nice if there was a way to insert line breaks without
> impacting the output. ;)
>
> -Peff

I envy all of you who seem to have had a lot of fun while I was
doing something else (which were rather boring but still needed
precision--my least favorite kind of task X-<).

The only comment I have is that I strongly suspect we will regret if
we used an overly bland "worktree" to a rather narrrow "is this ref
checked out in any worktree?" when we notice we want to learn other
things that are related to "worktree".  Other than that, very nicely
done.
