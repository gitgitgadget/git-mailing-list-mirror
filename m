Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C19D1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 15:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbfHFPTz (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 11:19:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33706 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbfHFPTy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 11:19:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so88425157wru.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eIzkVBpe0srvP6Zey/C8cLA7T+1NhmRiR2MlSI3KTWY=;
        b=r00KaxfqWvpBmbHDliTog3nlzgmfT9nNa8pjgghlWaEyIsYjhe+FVvDvbqNHyffP+v
         yqBuO4NneXAPgFlS8ScQymPsY3WyvMxIRzcxaKmBh5pJqOHzhSWrn2qvvIhkdRGXm1bW
         4xuBPv7Mh6PBgM7TANj85inGqHXneviBlWnMAXF1UzMh7ebNK0EyS5gY5DrbihCMx2Dv
         1Ey9Hq3kFnn/dxsOS6S0fBl/aY8uTkl35x/l5JU8CsAfHBnFhs0GsGeVZlEWrmtKayx5
         giMNmro+j2raeVUClXkc7V2QFLfc6cTPxjd65zdGpW4uVJiQN9/pFXYnAlk55cKxl19g
         v8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eIzkVBpe0srvP6Zey/C8cLA7T+1NhmRiR2MlSI3KTWY=;
        b=rso5spa2BEneciCo4TYy3lDcBhIYdXAzJAxzDzaHfCZ9ohylrZUaTOj/EsjEQsnz9n
         qB1GTTy4YWxF+/9M2TMskqV25lRG9owfGM5fBvnOIOsokok7YL4gNPmWj2Uzaev1iN8v
         AregWqwtCuM4C6YhCiFPaEgsTHUDeuW+8Xnq3Ifz7xfLzsm5Kd6u2aCdqZ7AOmkh772U
         7lr9Mj5Zq5/NjA74BwTN3ciRwQOpJcdn2GpZFFQAPsydBd5dHE20HxfzkOANbY9O4bw5
         pOvDd5u1R0jYedjn7ceD15zP8MzGw6j4WKpTbGxT3Z6X+MsnC2MNL0hGu7zBIkNUrvQs
         kgVw==
X-Gm-Message-State: APjAAAVBmZKyVTu7qifElqC6+7WXv8zCvCaXmHmscdaREfoXnYbh7ZZp
        JA02ytWdtxdAErWESE4d2h4=
X-Google-Smtp-Source: APXvYqw1JusfcnNtJMNLD+BOU57uApiM+NpMrdH8AjzlW5Xuq43dVCYisNeqZyFPPe7HwuPqqCkmNA==
X-Received: by 2002:a5d:4fc9:: with SMTP id h9mr5524254wrw.349.1565104792766;
        Tue, 06 Aug 2019 08:19:52 -0700 (PDT)
Received: from szeder.dev (x4dbe4c2a.dyn.telefonica.de. [77.190.76.42])
        by smtp.gmail.com with ESMTPSA id p10sm16891326wmk.2.2019.08.06.08.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:19:51 -0700 (PDT)
Date:   Tue, 6 Aug 2019 17:19:49 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] commit-graph: fix bug around octopus merges
Message-ID: <20190806151949.GF20404@szeder.dev>
References: <pull.308.git.gitgitgadget@gmail.com>
 <6e913ac2b6ddc080c7796e93f019243bbdce1dff.1565023420.git.gitgitgadget@gmail.com>
 <20190806092159.GE20404@szeder.dev>
 <ec14865f-98cb-5e1a-b580-8b6fddaa6217@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec14865f-98cb-5e1a-b580-8b6fddaa6217@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 08:03:07AM -0400, Derrick Stolee wrote:
> > On the other hand, one of my fun side-projects is to run some
> > semi-automated and souped-up CI builds of currently cooking topics,
> > which include a custom GETTEXT_POISON mode [1], where the poisoned
> > translated progress output in this new test looks like this [2]:
> > 
> >   V.e.r.i.f.y.i.n.g. .c.o.m.m.i.t.s. .i.n. .c.o.m.m.i.t. .g.r.a.p.h.: 100% (1/1),  d.o.n.e..
> >   V.e.r.i.f.y.i.n.g. .c.o.m.m.i.t.s. .i.n. .c.o.m.m.i.t. .g.r.a.p.h.: 100% (5/5),  d.o.n.e..
> >   V.e.r.i.f.y.i.n.g. .c.o.m.m.i.t.s. .i.n. .c.o.m.m.i.t. .g.r.a.p.h.:
> >     100% (12/12),  d.o.n.e..
> > 
> > So this makes the progress lines almost twice as long, and as the last
> > commit-graph file contains double-digit commits, the length of the
> > progress line just happens to exceed the width of a 80 character
> > terminal, and gets line wrapped.  This throws off the line count
> > check, as there are now 4 lines on standard error instead of the
> > expected 3.
> 
> Thanks for pointing out that the poison runs can change the number of lines.

Hm, I'm afraid I was not clear enough, so let me clarify.

A "regular" GIT_TEST_GETTEXT_POISON=1 test run does not change the
number of lines.  After it replaces the translated string with the '#
GETTEXT POISON #' magic, the progress output will look like this:

  # GETTEXT POISON #:  41% (5/12)

This will never grow long enough to trigger a line break.

It's just one of my fun experiments [1] that makes translated strings
twice as long, and thus triggers that line break.


[1] https://github.com/szeder/git gettext-poison-scrambled-msg


