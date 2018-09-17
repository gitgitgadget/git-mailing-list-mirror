Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732131F404
	for <e@80x24.org>; Mon, 17 Sep 2018 20:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeIRCNH (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 22:13:07 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40844 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbeIRCNH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 22:13:07 -0400
Received: by mail-wr1-f48.google.com with SMTP id n2-v6so18699495wrw.7
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 13:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DpwlZ5SRbaoMEk2+uBWRPwZjYPHXBx7+FWzWcluT+aQ=;
        b=IdjuMaqABG0UOa294/R7o+/s/v7Cv/tATnY4LCQWwJayXunSTamdIFqs+a7Mu0HJVH
         v6ZV3BpVCI6pVnbpk/WRoby/gxW3iBayFJ+NizM5g+FbxVOeAGixmHTuh29DX6PzxZmt
         nBaYu/ugsbTumI49s965o2JIOMxJ3qM/BZZdwRPTb8ANLtnxxezh0s6qIp3p3xeL+COI
         UjKSCTWdLBw9I2dcAjZiP3DkhprwuSByQkn6k2R/U23dJ7RDwKdSr/fTAE8Ccpsd3iAu
         WZQAnMEZVY2KQ1jwfV5hyGo13U4Cl/4WnpZaghOGpgsEpWHRfY5axnWe854/oxyZPWAw
         4kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DpwlZ5SRbaoMEk2+uBWRPwZjYPHXBx7+FWzWcluT+aQ=;
        b=a+S6yKFseIM367/z+CR2cXJZOX7+SHhQneINii6DRLzcioC8XITP53/rsa9wcPLXwV
         d4L1czsZwfWBB+L4o8qd8cBieX0ExIj5Ep2Hx7bKhz2Ceon345MpTO7lVhzaws8iixO9
         d8cyINQu8vDdCI5B8IXuDiLGxDxXZvvmJBlgiu0lBOjRwFeTjsYI5CgFhTeGnWp+l5tb
         BFozPll41ngne9oYk20FJQmY+FnpxrI0mpwbnVlenG9QVtBB1mhURDx+SbI33NMiAdHC
         7n9TNnfQ6OuorO05Qgb8B5I0JwYqLhBUQssVX6gtqRi0ycJXX6z6D/oaWv+fU0kGdSeF
         LLCg==
X-Gm-Message-State: APzg51A2p9ksymlA+ZxC0fFnyH+0jTT6BKzkzUwapT4NQB80IMPGzNqR
        3aNODDlsECoH2bJkUbT2Xws=
X-Google-Smtp-Source: ANB0VdZHtF5veOzS+MmuwFX3feWAqgrAA6GUaX9GpDkzRLuJ//CGQ4VdhzI++03pxpxtqhK0h8pLEg==
X-Received: by 2002:adf:b456:: with SMTP id v22-v6mr19386387wrd.187.1537217046878;
        Mon, 17 Sep 2018 13:44:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a6-v6sm159286wmf.22.2018.09.17.13.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:44:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] midx.c: mark a file-local symbol as static
References: <63d480c7-0312-3b1d-59bc-7b9996facea0@ramsayjones.plus.com>
        <d4b88c9e-9d02-f361-922e-f85caf3994e1@gmail.com>
Date:   Mon, 17 Sep 2018 13:44:05 -0700
In-Reply-To: <d4b88c9e-9d02-f361-922e-f85caf3994e1@gmail.com> (Derrick
        Stolee's message of "Mon, 17 Sep 2018 16:11:59 -0400")
Message-ID: <xmqqpnxb6ei2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> ds/multi-pack-verify is currently queued for 'next', so I wasn't
> planning on sending another version.
>
> Junio, could you add this commit to the tip, or squash it into
> 64cbf3df2 "multi-pack-index: add 'verify' verb"?

I think it makes sense to queue this on top.  Thanks.
