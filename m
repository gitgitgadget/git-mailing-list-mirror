Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF19B1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 17:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeIKWrX (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 18:47:23 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:36728 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbeIKWrX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 18:47:23 -0400
Received: by mail-wr1-f54.google.com with SMTP id e1-v6so17888755wrt.3
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XHncXUWtX5BThgJHuBBKIGWZpQCH2j8akcDptuDBHps=;
        b=dz7xlDP6tmsORaXSkQSj8Nak2CjD8TNurEigd7r9VtsJQQ5fHQ6Q6z3Wtcnr5asO31
         /BVTlm8S5Zg/LR+rJ/6kwbVqIP614KQtbS4FsRdqJEc0MMyP0UkL6onfU6IZNFzkxifd
         peIWTtTrC1SFfbm1PXBVxbwcx7wB0xro/XbshFiMjPibX97NKirBF9OV5q9lGJpDr4qY
         qA00xWinR4Yc4F6JqSArqrJJbo6zZpGl1Bs+Bn4j6tQBvbfI/jZnnWzbQfdr7lUaSS5W
         XG0+oolMY+4i5JwG1X247Y8UyFl96pCol7xiiQnNMm7iR8s+tJhN4eE4FN4LJcz1Rs72
         Qx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XHncXUWtX5BThgJHuBBKIGWZpQCH2j8akcDptuDBHps=;
        b=tV/FHWHcG4WQZQv8A2YqlvmJhYsequYOipZJ/Vn/K04OgFIpWe+3yPMTXiKvjoZBFa
         FsE6fyO1c7WFUOfvPjs08pX3lDXX3MKVRFcNpUMwVuc/UXpwi7xGpg7O5WQmwGR8IZi4
         RdK00i8NY2CV9GOOaFADzf2StH/iOr3Vee842H+G8NFmfgonPOS+3lfqZRtkGBvG7WXr
         7JPnGAEpfk7nshnJkVjljJ7uKJr8ug2ukMVY4IPg7blqhdOJotVbzgemOtDMSxFKKCqw
         kUeh3Lb5KhNVOGOKeAzDR+/f3do0C2dqKHEbmgybR71BB5z1iTnoMS7vtRJ5wNisjBmM
         4ggA==
X-Gm-Message-State: APzg51C0CkipLF3FK4uDcVlY/DBHcwW+8br0deFyMW3BVUYCFfRYKmmm
        I+I5Rl2jZgRVkpraIxEflXA=
X-Google-Smtp-Source: ANB0VdbxZ5E1mMW0nwLUmfaoEYQIvvR2lgypjy291S6rghl8NjR8bEK8NDSDlmGV0zMuscGj001mhQ==
X-Received: by 2002:adf:fd12:: with SMTP id e18-v6mr20430984wrr.280.1536688019145;
        Tue, 11 Sep 2018 10:46:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y17-v6sm22471888wrh.49.2018.09.11.10.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 10:46:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Ciro Santilli <ciro.santilli@gmail.com>,
        Matthew DeVore <matvore@google.com>, git <git@vger.kernel.org>
Subject: Re: Is it possible to git clone --filter= without any objects?
References: <CAFXrp_fLwL5=K3B5rWjY+imoqtskT8LG-UH8ec3CPwM0iiSzFg@mail.gmail.com>
        <CAGZ79kYK7ish4_DaZN2bCfZz7LNAjxogQH1k6T=hFcxxkXzJQw@mail.gmail.com>
        <CAGf8dgKLz14ijnXwV0Y=M48Rij-scA19E_uXk3pBc0T02oE_0Q@mail.gmail.com>
Date:   Tue, 11 Sep 2018 10:46:57 -0700
In-Reply-To: <CAGf8dgKLz14ijnXwV0Y=M48Rij-scA19E_uXk3pBc0T02oE_0Q@mail.gmail.com>
        (Jonathan Tan's message of "Tue, 11 Sep 2018 10:19:03 -0700")
Message-ID: <xmqqo9d4orji.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> By "without any objects" in your email subject, do you mean "without
> blob and tree objects"? If yes, there is some code in the
> md/filter-trees branch that can do that with a "--filter=tree:0"
> option.

I too was wondering what the "without any objects" thing meant
myself.

What would it take on top of the following sequence to create such
an ultra-lazy clone?

	$ mkdir very-sparse && cd very-sparse
	$ git init
	$ git remote add origin $URL

At this point, the repository does not have any object, but it
already knows whom to talk to to get the objects in the project.
The remote must be configured so that it is willing to feed you any
object you name, but would it be just some "git config" magic after
the above three steps to make it as if it was prepared with "git
clone --filter="?  If so, what does that magic look like?

Thanks.
