Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B85207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 20:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754212AbdFWUyk (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 16:54:40 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35716 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754144AbdFWUyi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 16:54:38 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so7460224pgc.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8Mq6akeEjtaoK/ZNuEUstikyO22bD6Zt2DPLMw8UFyE=;
        b=KbQWI+p+lXqemGyyRQBNizyWBbmi898d1rYfHzZLQo63EHrDy7DYNLTvAADW/3hG7Y
         jczBcIn3VcQpT8Uvy1h5jCBlzRnJiOxQ+nD5D74PjYX7vMN0Wsvwkgs5jqV988YGsyrV
         R/TCWogz3PMhr192hzLzo5KqoJEK36IfDQt09S8FwJtrS0hK4lXok3lrkc/GC4lCKquD
         dbeH5H6b5Kd0MPf4g6wRLdC93G5JKix5sxm6Ntnt4GhZDb/VgtvEN4r3g14sJJDVeftl
         WC1bFwhP2/pIx2F4iRxYgisrFL0H0SQ5UucPi6l50a+OvKiZBhPpNdZ5SgqX9XTRKiQT
         TSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8Mq6akeEjtaoK/ZNuEUstikyO22bD6Zt2DPLMw8UFyE=;
        b=C/k9osggLCdWt+7aS69AEI/roL3bh17FrPi1CAvEu8Lf1PjTC/uIM6EXhmgHwwV1zn
         65ZODWtoYAiCgF6s4qodyebD0btNKuiEvuE5mvnYnzU/SjFl4lRUgVyv7yNKkFCEUNMc
         2nCX/vMOiLivMh31I2ggJdG7iUwiE42fvYYW/4OHXDBuisjvUqd4uJ81qgq+9TOBi+SS
         734FylD5lpPGCjrEgPtU9eGrA+0ZDNJvrypFmuYUFAn9ARxPA2zEjXJn2WHgcY9j/Zqw
         ck8QElNaQnolfvk1uwuSYquKvgW+mG5TcgxxU02XGMnGzoWxXDf/VZYjwRkBFr0H3blJ
         l7BQ==
X-Gm-Message-State: AKS2vOyk9rzTPumoTdtoFhubzzD9wbXTAELgSM3TajgtGEOwnXyts0Jl
        ZgZ+NkoMrZ0RtA==
X-Received: by 10.84.224.15 with SMTP id r15mr189360plj.78.1498251277831;
        Fri, 23 Jun 2017 13:54:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id k129sm12018082pfc.87.2017.06.23.13.54.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 13:54:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH] proposal for refs/tracking/* hierarchy
References: <20170623135230.10534-1-jacob.e.keller@intel.com>
Date:   Fri, 23 Jun 2017 13:54:36 -0700
In-Reply-To: <20170623135230.10534-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Fri, 23 Jun 2017 06:52:30 -0700")
Message-ID: <xmqqvanmctmb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> Instead, lets add support for a new refs/tracking/* hierarchy which is
> laid out in such a way to avoid this inconsistency. All refs in
> "refs/tracking/<remote>/*" will include the complete ref, such that
> dropping the "tracking/<remote>" part will give the exact ref name as it
> is found in the upstream. Thus, we can track any ref here by simply
> fetching it into refs/tracking/<remote>/*.

I do think this overall is a good goal to aim for wrt "tracking",
i.e.  keeping a pristine copy of what we observed from the outside
world.  In addition to what you listed as "undecided" below,
however, I expect that this will highlight a lot of trouble in
"working together", i.e. reconciling the differences of various
world views and moving the project forward, in two orthogonal axes:

 - Things pointed at by some refs (e.g. notes/, but I think the
   ".gitmodules equivalent that is not tied to any particular commit
   in the superproject" Jonathan Nieder and friends advocate falls
   into the same category) do not correspond to the working tree
   contents, and merging their contents will always pose challenge
   when we need to prepare for conflict resolution.

 - Things pointed at by some other refs (e.g. tags/) do not make
   sense to be merged.  You may locally call a commit with a tag
   "wip", while your friends may use the same "wip" tag to point at
   a different one.  Both are valid, and more importantly, there is
   no point even trying to reconcile what the "wip" tag means in the
   project globally.

For the former, I expect that merging these non-working tree
contents will all have to require some specific tool that is
tailored for the meaning each hierarchy has, just like "git notes
merge" gives a solution that is very specific to the notes refs (I
do not know how well "notes merge" works in practice, though).

For the latter, having a separate tracking hierarchy is a strict
improvement from "tracking" point of view, but I think "working
together" also needs a well designed set of new look-up rules, and a
new convention.  For example, some tags may not want to be shared
(e.g. "wip" example above) even though they should be easy to access
by those who already have them (e.g. "git log ..wip" should work
without having to say "git log ..refs/local-tags/wip", even if we
decide to implement the "some tags may not want to be shared"
segregation by introducing a new hierarchy).  And also a shared tag
that is copied to "refs/tracking/origin/tags/v1.0" would need a way
better than "git log tracking/origin/tags/v1.0" for this mechanism
to be useful in everyday workflow.

Thanks.

