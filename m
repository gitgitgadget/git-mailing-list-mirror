Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ACBC433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 06:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBB960EBD
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 06:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhJWGSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 02:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhJWGS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 02:18:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6114BC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 23:16:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id om14so4380604pjb.5
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 23:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=caSjDE/nhKnRSPjquUEG6JEI5auKU2BKGChRgDIdujI=;
        b=FZ8iMVTjSP2oi2mCll9n7vlRwgKhYIDVTHJ/35VE7MlA1XgBPENaJC1M/3cxMhtVIe
         9Xx3XFrM428kHWBbbkOJ4zsIax+tdECrix/C/iNMIeWUaEgIoBwmMXvjtiGtT6k0jGOl
         89woa4kr0D/SJ52uNe8TlWh+TsuRcLy7ArDxWyAaxCkHn3+XKkMa+0BSRh1Usq0HweyJ
         t2et3+MZOFJJlsbVvCAAAvkoYoEasRmU0pR44oomP8vVmKPL3TkDZIXZD2qWg6jYgw1l
         L8g+GIUcjoovaECsItSRvD/yBpPPRBfp0rob3sd7pFAvXRcgsUGSFN590mzHz8DOqrf/
         epPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=caSjDE/nhKnRSPjquUEG6JEI5auKU2BKGChRgDIdujI=;
        b=vzKMtseWc9tJnN7XYM5fXv7wtiDT5PsnPBaRGofNJW3XBbdLjRX0I+o14YmdE7Xs7m
         aIqCi4L03VI5Zda+s0htrm08c6TtJ1S2+sqKZAgDQFPUzxi0N4N9lV3Y4uUlVpUp8eId
         WFieIB6gGr3t/v/5pVQlKVMBy/4y0/YNscO77fKok6MqlMgLdhfavVqdm3t+RpK0V0j+
         0W701EthUEzPXqK4YI5ZZwcd0ezJYMW8t7tR9rpij1o/g3Rwj97AZiLr3K/y7Ed9Xc2s
         zGofnWvRngtRNzFGudDFzB3cNmH3lIj5XIcutqrK3Lf6VMOQ76txlHIF0xQ4C/545GgK
         Vzvw==
X-Gm-Message-State: AOAM530djfhajmtqV5hQHwWQcIzklPyXa2YwwXO682a9JhFG2xuNqNNq
        twzJaSMfJZFpFDLvCWgxjh4=
X-Google-Smtp-Source: ABdhPJziKS5/PQ1F2jZckB2DuZdCSvVhP8byB8Qf1dEOYKaeCMTnroc/vWyJerUHujxYj8dAaHF9Gw==
X-Received: by 2002:a17:90b:38c7:: with SMTP id nn7mr19663163pjb.214.1634969768619;
        Fri, 22 Oct 2021 23:16:08 -0700 (PDT)
Received: from localhost ([2402:800:63b8:ad19:e8ab:8562:ceff:cd6f])
        by smtp.gmail.com with ESMTPSA id l6sm1058288pfc.126.2021.10.22.23.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 23:16:08 -0700 (PDT)
Date:   Sat, 23 Oct 2021 13:16:06 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     "Schanzenbach, Martin" <mschanzenbach@posteo.de>
Cc:     git@vger.kernel.org
Subject: Re: git log displaying wrong account information
Message-ID: <YXOopkKXrluffiuX@danh.dev>
References: <9826C830-3680-4AC4-9ADB-5FA45222A15B@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9826C830-3680-4AC4-9ADB-5FA45222A15B@posteo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-10-23 05:58:37+0000, "Schanzenbach, Martin" <mschanzenbach@posteo.de> wrote:
> Hello,
> 
> there is some odd behaviour in "git log" which affects me in various ways:
> For some reason, it "canonicalizes" the author/commiter information in our repository: https://git.gnunet.org/git/gnunet.git
> 5 years ago or so I was using another email address for commits. I have been using a different email address since that.
> 
> But if you clone this repo, and take a look at a recent commit such
> as be9b998b3369056c7c8fb0ae84fb4e2a064b496c using "git log", you
> will see that my email address is actually the old one and different
> from the _real_ information.

By old one, do you mean:

	Martin Schanzenbach <martin.schanzenbach@aisec.fraunhofer.de>

It's because you have those entries in .mailmap:

---- 8< ----
Martin Schanzenbach <martin.schanzenbach@aisec.fraunhofer.de> Schanzenbach, Martin <martin.schanzenbach@aisec.fraunhofer.de>
Martin Schanzenbach <martin.schanzenbach@aisec.fraunhofer.de> Schanzenbach, Martin <mschanzenbach@posteo.de>
Martin Schanzenbach <martin.schanzenbach@aisec.fraunhofer.de> Martin Schanzenbach <mschanzenbach@posteo.de>
---- >8 -----

Which will map your:

	Martin Schanzenbach <mschanzenbach@posteo.de>

into it.


> You can see that I correctly set the author/commiter email here
> using either cgit
> (https://git.gnunet.org/gnunet.git/commit/?id=be9b998b3369056c7c8fb0ae84fb4e2a064b496c)
> or a specific format such as
> 
> $ git log --pretty=format:"[%h] %cd - Committer: %cn (%ce), Author: %an (%ae)
> 
> This is driving me crazy as the information is just plain wrong and
> when our CI tries to collect a blamelist when sending out
> notifications, it also uses the info from "git log" instead of the
> actual author/commiter emails, promptly sending the reports to the
> wrong account.

The original value is recorded in the commit. You can retrieve raw
value with git-cat-file

> 
> Any idea what to do?

Change your mailmap entries to:

---- 8< ---
Martin Schanzenbach <mschanzenbach@posteo.de> Schanzenbach, Martin <martin.schanzenbach@aisec.fraunhofer.de>
Martin Schanzenbach <mschanzenbach@posteo.de> Schanzenbach, Martin <mschanzenbach@posteo.de>
Martin Schanzenbach <mschanzenbach@posteo.de> Martin Schanzenbach <martin.schanzenbach@aisec.fraunhofer.de>
---- >8 ----


> I really do not want to rebase and rewrite
> thousands of commits with questionable success.
> Doing that locally also does not change the output from "git log", in case you are wondering.
> This problem will reemerge eventually whenever an author wants to
> change to another email address it seems so is this a bug?
> 
> Any help/pointers appreciated.
> 
> Martin



-- 
Danh
