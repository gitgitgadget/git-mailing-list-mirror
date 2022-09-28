Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8F3C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 07:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbiI1Hvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 03:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiI1HvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 03:51:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A944D1893AE
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 00:50:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q17so13400858lji.11
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 00:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+cCy5xdHN1hhZGfwI6ABX9yd+Himq/uZPdYfM5ly8JM=;
        b=WMPXNZtwOijgCN1oirUlM3oU9rrqHoYS2Q9uVmbrx25REmdpWXDPOyMHHzjb1822/J
         FXEvQ0AqJA9AooB9o1vSOGJoEoTdJazdSKg106tYW08nyz+y6PN1IwOY4p22ZldT2qi7
         Elu3m2v1m5eGlhhwSV37Kp/5yFD35EXu8SkYVD4autnb4lk4BtWUifNcpZ5+tyoUu6Ws
         ehLPhUSpKkrikwz7eSxBiDK1nZaYthdSlpCzKzKmkfiY+S6wWJH84okcxhpC3a8NhHk2
         sKOHNgo2fs3USVGVUb/Hj/5CNyqLHh6HtUfz1zdjNrTEx7JTGYZBGCoiNBHMIlTacaEl
         iIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+cCy5xdHN1hhZGfwI6ABX9yd+Himq/uZPdYfM5ly8JM=;
        b=DOS0eB3luDgp619L4MBsQqz+2u4oMtEA0TPLXH3hYHvVpae2xwJbRgilL6ioCSjuG2
         vhsJPv8B833SKABHdl4uuXVlP0vmEIBrxYgtfzyzaqVRVkrh9Ioen4D9Bi/oWyRBWQiu
         GMJydNuu5Xp8AOVkTLzUR/Nu4d0gh3QqS35f6Cyxp4Xl/JCoCES7Els/bHpsca/AtPoD
         UNJuQ99x/wB+arLhDdk8ofNi5n38XTafARoTYdaURS0tduVfLTVBz1hOC/aCRawueL6p
         pMBxC9cQcGRvQCfHfDhQZw7cGBHrRVOq25fFPfUZX0BHIKu6pK5EOb2RCUbwQw6Oii1w
         VPeA==
X-Gm-Message-State: ACrzQf1dCxNEMEklybN36oLeqqDbSSKwM1LXGeWuP9W4aMH5PnfDGd3T
        s8he4eM/hZn0HKCECnLjqRPrmrFNrZKjU+LD7r4=
X-Google-Smtp-Source: AMsMyM5djLCqwDIK3KoAL0yLbH5Z1w5JwRnX1+EeH8xdJYPA70t8WyYdHwOVRfGuSDVIp1PNr9gNrtvWH6deJP0dAFI=
X-Received: by 2002:a2e:7804:0:b0:26c:463c:493c with SMTP id
 t4-20020a2e7804000000b0026c463c493cmr11735075ljc.521.1664351405159; Wed, 28
 Sep 2022 00:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com> <xmqqczbg9613.fsf@gitster.g>
In-Reply-To: <xmqqczbg9613.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 28 Sep 2022 00:49:53 -0700
Message-ID: <CABPp-BF1+3Ze46H6DpnYv5eHLFSnB7Scszu0HdqFj1VRYBarWQ@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout directions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2022 at 8:44 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +  * Does the name --[no-]restrict sound good to others?  Are there better options?
>
> Everybody in this thread are interested in sparse checkout, which
> unfortunately blinds them from the fact that "restrict to", "limit
> to", "focus on", etc. need not to be limited to the sparse checkout
> feature.  We must have something that hints that the option is about
> the sparse checkout feature.
>
> As to the verbs, I do not mind "restrict to".  Other good ones I do
> not mind choosing are "limit to" and "focus on".  They would equally
> convey the same thing in this context.  And the object for these
> verb phrases are the area of interest, those paths without the
> skip-worktree bit, the paths outside the sparse cone(s).
>
> Or we could go the other way.  We are excluding those paths with the
> skip-worktree bit, so "exclude" and "ignore" are natural candidates.

If you're thinking about plain "exclude", that's already a flag in
'apply', 'am', 'clean', and 'ls-files'.

Also, if you want these words alone, then they also seem to lack hints
that the option is about the sparse checkout feature.  Expand them a
bit, perhaps?  "--ignore-sparsity"?
"--exclude-sparse-checkout-restrictions"?

Assuming we are worried about needing "--no-" variants, wouldn't the
risk of a "--no-ignore-sparsity" be worse than a "--no-restrict" in
terms of awkwardness, given the double negative?

> These two classes are good if the "restrict" behaviour will never be
> the default.  When it is the default, the option often used will
> become "--no-restrict", which is awkward.
>
>         Personally I am slightly in favor of "focus on" (i.e.
>         "--focus" vs "--unfocus") as that meshes well with the
>         concept of "the areas of the working tree paths that I am
>         interested in right now", which may already hint that the
>         option is about the sparse checkout feature (i.e. "I am
>         focusing on these areas right now") and can stay short.  But
>         this is just one person's opinion.

I'll add --focus/--unfocus to the list.  --unfocus seems a bit more
awkward to me than --no-restrict, but that might just be me.  If
others really liked it, I'd be fine with it.

Right now, I'm leaning a bit more towards Stolee's
--scope={sparse,all} (or maybe --scope={sparse,dense}?)
