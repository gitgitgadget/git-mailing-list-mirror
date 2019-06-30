Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6291F461
	for <e@80x24.org>; Sun, 30 Jun 2019 15:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfF3PJn (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 11:09:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34412 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3PJn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 11:09:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so5953221plt.1
        for <git@vger.kernel.org>; Sun, 30 Jun 2019 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWJQlCwHKI92aMjKEn8XmZjal9fD4I7W1RSU2bm20so=;
        b=jIrTH61osvfzQ6t9NDV8Zdf7Uf5EKTy0doUo1Jk4YLOfqH8ISxYBlPjPtFlY1hznNu
         K734e9G1YXyUqECy8UQjYm06izIPt4jGEnVzUIwPVUEx2MFKqj/x1XmAd/yO3dLArZpq
         YIqqH8hwvE3zZY0/EMcXSx1568mgdL9/xEw4NPktfGtwK/GdQXvfc6hRPBRrvZl+fllm
         GtzUfmd/GCgApuWegmXo4Lr0+/PKjtr1LcdEPttjfYV1DQeirDEw0n9llSPRVp/kQtMY
         Yx+z057KPO3qqh1eYO0MqCaUheMr6aeL+MAWccCk9Ce5j4KPdTtS4+v+cYkiZ1RDnk7e
         om4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWJQlCwHKI92aMjKEn8XmZjal9fD4I7W1RSU2bm20so=;
        b=V3tVyGU61z+z8AWZkAURKx/xRne4GrEqb0WkUndR7AI9fqMVJyoiNlY3PRJhFh3Cql
         uF6X6g53RSYzSQAao2lhxCHqCVRo2aANhT5tFR1JBlAlsLo15aKa9t/0KDBGSlAOm7xH
         u/6AGgeLdJOtcgK8Q4A9eFUsO+rfoO6I0WTrwtIcgcLVi32NZK/ZmsspkuLA98L4JxvU
         OKGLRF1VY0VWsrnHo22iYyPCXY81xxAknTPThtZlWaznDlGYEyA+wYamGrbn+cpzFIsa
         JaqBPqBQv8vjQHdfKLVAB8jekIN90H+MwRdjRncPI8U8C8jTnmAO6mzJzTQdaiRVJVoZ
         GwqQ==
X-Gm-Message-State: APjAAAWAN+x42mQ/l2DV3PUqXGW2KCpk22UTJ4+WOOk6STY9CFsOcQCn
        AF1AtYWlJfBQR1JgH/rZB8tq19ZMr5zg1RmqFOthSCcC
X-Google-Smtp-Source: APXvYqzHIfquvAgsHpuerEwDYO47dywkY2N8om95kmtPtHMyiNikonY8vNiqKgQzLbcPtXm6KoY7wGxFhp0KFgJd4NI=
X-Received: by 2002:a17:902:2889:: with SMTP id f9mr22333422plb.230.1561907382325;
 Sun, 30 Jun 2019 08:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190630051816.8814-1-eantoranz@gmail.com> <20190630065358.GB31264@sigill.intra.peff.net>
In-Reply-To: <20190630065358.GB31264@sigill.intra.peff.net>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sun, 30 Jun 2019 09:09:31 -0600
Message-ID: <CAOc6etYMzOpEDs1GpLChAEhp2SbZcKjO82S=qm4P-t6SkUEWcw@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/2] rebuash - squash/rebase in a single step
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 30, 2019 at 12:54 AM Jeff King <peff@peff.net> wrote:
>
>
> and then do:
>
>   git merge --squash feature
>
> I get the same merge that rebuash is doing (with R6 as the merge base,
> so we see F5 and R7 conflicting with each other). And then when I finish
> it with "git commit", the result is a linear strand with M3 at the tip
> (and its commit message is even auto-populated with information from the
> squashed commits).
>
> -Peff

From the point of view of the revisions that you produce in the end,
it's the same thing, but you are not rebasing/squashing your feature
branch, you are moving your upstream branch to where you want the
squashed/rebased branch to be. So, in fact you would need more steps,
something like (starting from your feature branch being checked out):

git checkout --detach $( git rev-parse --abbrev-ref --symbolic-full-name @{u} )
git merge --squash my-feature-branch
git branch -f my-feature-branch
git checkout my-feature-branch

Yes, it works. Only that with rebuash you would do (starting from the
feature branch being checked out branch):

git rebuash

as long as the upstream branch is set, of course.

I think it makes more sense in terms of development flow of feature
branches, if you know in the end you will give up a squashed branch:

modify
commit
modify
commit
git pull # no need to use pull --rebase, merges will be fine
modify
commit
modify
commit
git pull
git modify
# now I'm ready to rebase/squash
git fetch
git rebuash

adding history could be done with an additional option (--hist
(default) and --no-hist?)

But, as you said, it's not like it's not possible to do it (with a
little more effort) with available tools like merge --squash
