Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96749211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 18:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeK3FVJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 00:21:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36100 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeK3FVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 00:21:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so2713803edb.3
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 10:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24yjSv6r6bi11esYZZdbms9o+ZCToxEmkP8dHFsuDu8=;
        b=WA3FgBFA5KkYwoOrEU3zL+9QjwRr/5f/P2ufYIImhva5fkHLTEf1DOLSf2E+Nq3czC
         5NT1Jtq9XZ1LbY9p00lWa0P+GsPuuwPNNd3Uz6kSsuu7QW6SP/qe+aLFSXvh88s46k/H
         /DusjZ3rlyo7GA7wydXYSqnrCUb6K5NVgA2OEQokcjHrTRSZA+Lo6xb4dH0pw+kyhCYo
         wOvCpmmbXVJ8STmO0LNmTtl7VRsWMYWRaNUHAtHvpM1IBV6XIeqGJpICVshGrVHiIWFq
         ZCM+evpPqdVYmkCic68tcta7immRtt0AX/lAeF1Vu/z+cl1aQGkJauboatF5DIf+bDUv
         aZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24yjSv6r6bi11esYZZdbms9o+ZCToxEmkP8dHFsuDu8=;
        b=i3ReLM63eW9GDalJDzABiXrRQ5jCoOkWDzaPki6dX4d06nsWHgxNvFNIY0HLVPde/Y
         8mPrXvcgiuFrl+FyUjEH7Has4IVYd/tF3Z7ZjIUwHq4Ub1S+Apq4H93XzlF5Y2pWI97q
         PS9x2EkYBvMMO4ixMrZf8D/LHTcvMrYw1ipjBkiRF4tCCFDIEn1kwjgU59laxWw3YsAk
         PIcBewG2t3Tu6cnw2hEXBa5adTT6sxzJarvKoc5HzyeAUGazZ1WajV6ySxZhjcZt0QCY
         h2pSATGr/0vqH9CPB2qi4ef6wQa4VwBEu8I/Q24cFbmUMFNzEz+U8brL+mZx9ygnKuwa
         hsbQ==
X-Gm-Message-State: AA+aEWZ3dnAvSots/pvmZRlcr0gc/0pYhUVND0iLrc+y/W8JPPArWbfl
        Fv8WsI9ZvjRd2eWYSxR7EFu4T7pziG2qxg0GT2wnyA==
X-Google-Smtp-Source: AFSGD/UkU5Ld0DJE7356SIFHBQPE5zOkU4v3cRwhGpoxyU1Ob1ChzEmCuZPGQbqWM9G1mxVRdIn9+tE2DBus6L014lw=
X-Received: by 2002:a17:906:f04:: with SMTP id z4-v6mr2433721eji.106.1543515292638;
 Thu, 29 Nov 2018 10:14:52 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-7-pclouds@gmail.com> <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com>
 <CAPL8ZiuaEW5tp8ZMOZtZcb5oi3L-pDF6ajcA7b5wnH3=7Ls7Tg@mail.gmail.com> <CACsJy8An2n5yah1UTCJZoC5ucSpCoM0vrXtEXnjg-di7jQZwLA@mail.gmail.com>
In-Reply-To: <CACsJy8An2n5yah1UTCJZoC5ucSpCoM0vrXtEXnjg-di7jQZwLA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Nov 2018 10:14:40 -0800
Message-ID: <CAGZ79kY2Fu_3b8MnO-yV_JhevZRgx7=6ndX-N_R2HdJGByciHA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] checkout: split into switch-branch and checkout-files
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Xenos <sxenos@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Idea:
> > If git checkout-files modifies the submodules file, it could also
> > auto-update the submodules. (For example, with something like "git
> > submodule update --init --recursive --progress").
>
> This one is tricky because we should deal with submodule autoupdate
> consistently across all porcelain commands (or at least common ones),
> not just checkout-files. I'd prefer to delay this until later. Once we
> figure out what to do with other commands, then we can still change
> defaults for checkout-files.

checkout/reset are respecting the submodule.recurse setting for this
already, and as your patches only change the UX frontend

    git -c submodule.recurse checkout-files <pathsspec>

would also touch submodules. Given that deep down in
the submodules it's all about files again, we could think
checkout-files is still a good name.

I think Stefan X. is asking for making submodule.recurse
to default to true, which is indeed unrelated to this.

Stefan
