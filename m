Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84709C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 21:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiITVX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 17:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiITVXy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 17:23:54 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDD872875
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 14:23:53 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id l14so3039237qvq.8
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 14:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=IDsUvwv8Q7/YsnHCfZIUe0DNgmEqCiIRidX5+j/yMdI=;
        b=WclvSEc4SRm5ncJ5VPAqMAIkvej47aIWHiA/mA3YofDQBY1K55SMQcFH5WC8js59He
         CsjcZySg3hwxZxlMmuBenQ/Xbw4by3xDPIWZsSD7Tn9wqFaGIBIbkeaqyIrTEA+ZoufK
         uIMGacmhT4esewBWR6JJ5NnSzSx5U8NrNraXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IDsUvwv8Q7/YsnHCfZIUe0DNgmEqCiIRidX5+j/yMdI=;
        b=JoNbGh2ZG0CCO2O7LES12w3pnrObZ+JMUK049blAeCR8yAN1N0kVqf3RK+wz1QEmWN
         uymOhr+h1Qrj4HY1dhVNLh/Mij/J7aiE9sJXzOj6JTsgAyGkG082xOQ9T+vjwHixqXwE
         DBPdU0WrVSwxk75qahSyYjd5U+tH5gX3rMhwL6KPJZ+2Zisd9zDL+v18TOsBhzRi8xEx
         lJK1QfyvS4G141bOMMB15kxDfB9FvnKdD01K/vZUuaXedqtFcf2HmCE5WxHfg7GxWH7V
         a0I8eTg6QZ0Hwu01LrbLHUJ5CVmlt3s/JnF2o2IODqxNdYLiTWyAXqyZ9o2pnodxZXoD
         HzLQ==
X-Gm-Message-State: ACrzQf3SG+INjzYGdHe3d0PArCbsjJRegymwigT/KXfTs2Re4SYcFz1t
        U2mk6hnu30pzxsM4dlnduyV+SA==
X-Google-Smtp-Source: AMsMyM5MbFnhY0J1NWN6Ao/7ybm6MhUjSRa1PoxjJmSTfWaJzV3Tv7EKULw0URbaNWSHYQThYS1IJQ==
X-Received: by 2002:ad4:5ec5:0:b0:49c:cf39:d4d2 with SMTP id jm5-20020ad45ec5000000b0049ccf39d4d2mr20660666qvb.6.1663709032876;
        Tue, 20 Sep 2022 14:23:52 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id dt10-20020a05620a478a00b006ce3cffa2c8sm652384qkb.43.2022.09.20.14.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 14:23:52 -0700 (PDT)
Date:   Tue, 20 Sep 2022 17:23:50 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Elijah Newren <newren@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] Documentation: add ReviewingGuidelines
Message-ID: <20220920212350.f5do44qqduhyp46u@meerkat.local>
References: <pull.1348.git.1662747205235.gitgitgadget@gmail.com>
 <pull.1348.v2.git.1663614767058.gitgitgadget@gmail.com>
 <CABPp-BEB_+YoKZ=U6NPc8J+KZyMSYRsom34CeqjxUCyw0=LEyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BEB_+YoKZ=U6NPc8J+KZyMSYRsom34CeqjxUCyw0=LEyg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2022 at 05:43:15PM -0700, Elijah Newren wrote:
> > +- You may find that the limited context provided in the patch diff is sometimes
> > +  insufficient for a thorough review. In such cases, you can review patches in
> > +  your local tree by either applying patches with linkgit:git-am[1] or checking
> > +  out the associated branch from https://github.com/gitster/git once the series
> > +  is tracked there.
> 
> Lots of reviews also come with "Fetch-It-Via" instructions in the
> cover letter, making it really easy to grab.  Might be worth
> mentioning?
> 
> Also, would it make sense for us to replace "applying" with
> "downloading and applying", perhaps mentioning `b4 am` for the
> downloading half?

B4 can also "convert" a patch series into a pull request using "shazam".
E.g.:

    b4 shazam -H <msgid>

This will do some behind-the-scenes magic and give you a FETCH_HEAD that you
can review, check out into a new branch, merge, etc.

You can try this with this very thread, if you are inside the git's own repo:

	$ b4 shazam -H pull.1348.git.1662747205235.gitgitgadget@gmail.com
	Grabbing thread from lore.kernel.org/all/pull.1348.git.1662747205235.gitgitgadget%40gmail.com/t.mbox.gz
	Checking for newer revisions on https://lore.kernel.org/all/
	Analyzing 12 messages in the thread
	Will use the latest revision: v2
	You can pick other revisions using the -vN flag
	Checking attestation on all messages, may take a moment...
	---
	  ✓ [PATCH v2] Documentation: add ReviewingGuidelines
		+ Reviewed-by: Josh Steadmon <steadmon@google.com> (✓ DKIM/google.com)
	  ---
	  ✓ Signed: DKIM/gmail.com
	---
	Total patches: 1
	---
	Magic: Preparing a sparse worktree
	---
	Applying: Documentation: add ReviewingGuidelines
	---
	Fetching into FETCH_HEAD
	You can now merge or checkout FETCH_HEAD
	  e.g.: git merge --no-ff -F /home/user/work/git/git/.git/b4-cover --edit FETCH_HEAD --signoff

> (I tend to use the Fetch-It-Via or wait for it to show up in
> gitster/git, but b4 is really nice for the other cases.)

Great to hear! :)

-Konstantin
