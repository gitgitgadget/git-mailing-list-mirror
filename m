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
	by dcvr.yhbt.net (Postfix) with ESMTP id CC83A1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 15:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeJOWwi (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 18:52:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33132 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeJOWwi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 18:52:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id e4-v6so21774123wrs.0
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=AS1prScI6bOYb1kmWNU9WWAdePsDu94m965T4upOTwM=;
        b=GcnKDbrZayhz1U2iY3WNEfBFKkKa1giOrXS6LEEOsp0wuDIJQanFelKQeDi67jRIGZ
         DA2/3omHlf041Y2a4xfUZbo5n9s3wPm+UweYNghedorLpBhMJnnD2C0ogf49s24laqYK
         f2LGxKh6DxmzHs0leP5FF7D9VCZ0F7AX/bI2q4U/igAkWfy8zI+oA4/Kbl0frOH5N0vN
         ee3RXwYl1djy7jiMV9gpmUKdP+1ZIf8BXqO3Or31JgdxAiyCD1gRRY0Z7qxgXy2VJMZq
         9biAMoFaLtm4drhaG3zydNHCvblZc7x8xKWgyirjK/35IhY61TUqoe5frUXCVo5Ip/p2
         sgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=AS1prScI6bOYb1kmWNU9WWAdePsDu94m965T4upOTwM=;
        b=j3wq4srnjay6v02B0SV5rXXZlZeFZPfROY+QhSoBFPZw5RsUmhyK2zV3sUa+bOkTdD
         UTEqhp8K05Omi/ggJsTyahWio9Q8P5X+pvIBQelqM1Fm2Ekmal+NxvfRZEWeonxhSY34
         dzurCpllCOfssQS82eIwmLt0PtI4JzL06bK6NDwWmUhQs8/AhHHfr5xnzTwCoad1ppey
         jaVl0uvXgvfzqPROWI6c76SiPKjYWznMEXmib9xOovSYhYy3aHpaz5gdZWxPy5g24cVU
         ikogsXU99yU1aOzVSmTbT7RbqGXOia5dhhGDkL6PwzdzpbhWLHwhapmgAD1YXH7Jsfub
         B0LA==
X-Gm-Message-State: ABuFfogFhUlTelndVMkfAOL5A5YS7wiIJY0+IMzZsFZ9/e32smBUWhmj
        48RHiKAHJ8c+Y76QW7EQmro=
X-Google-Smtp-Source: ACcGV60F/SmWkGzHg1bgq0fM2aeWMjDmMdT8wa0gbSQqHDHHRragDNba00+rhvYYfKpkQYeihXFBJw==
X-Received: by 2002:adf:9564:: with SMTP id 91-v6mr15566853wrs.60.1539616018360;
        Mon, 15 Oct 2018 08:06:58 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id o4-v6sm7134798wrj.45.2018.10.15.08.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 08:06:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] Offer to run CI/PR builds in Visual Studio Team Services
References: <pull.31.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <pull.31.git.gitgitgadget@gmail.com>
Date:   Mon, 15 Oct 2018 17:06:56 +0200
Message-ID: <8736t7dzan.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 03 2018, Johannes Schindelin via GitGitGadget wrote:

> As a special treat, this patch series adds the ability to present the
> outcome of Git's test suite as JUnit-style .xml files. This allows the VSTS
> build to present fun diagrams, trends, and makes it a lot easier to drill
> down to test failures than before. See for example
> https://git.visualstudio.com/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details
> [https://git.visualstudio.com/git/_build/results?buildId=113&view=ms.vss-test-web.test-result-details]
> (you can click on the label of the failed test, and then see the detailed
> output in the right pane).
>
> This patch series took way more time than I had originally planned, but I
> think that in particular the advanced display of the test results was worth
> it. Please let me know what you think about this.

I have not reviewed this in any detail, but incorporating this in some
form or other seems like a no-brainer to me.

If we have "free" (from the perspective of the project) CPU being
offered by various CI setups let's use it.

If people don't like it they don't have to look at those CI runs, and
the burden of carrying another CI in git.git is minimal, and actually
this patch series makes it much easier to incorporate other CI's later,
since you took care of moving the Travis-specific bits out.

As an aside I poked Junio via private mail in late August to see if he'd
be interested in pushing to gitlab.com/git/git.git too as part of his
normal push-outs. One neat thing that would buy us is the ability to
have a .gitlab-ci.yml in git.git and use their CI implementation.
