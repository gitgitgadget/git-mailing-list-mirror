Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31834C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 05:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiI1FmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 01:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiI1FmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 01:42:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A90FE671
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 22:42:15 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a10so13231687ljq.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 22:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Zs9+hbGUW96eERlzcuPafzXgvREqWAEevqiugLi0UI8=;
        b=ojCMLvjzK+l7E4X8hrwNp/kbSHubCGVeu0kFJzXg3YUS1XJBMNGgzs5gagVYiij5iO
         dg9nD+yecmTM1/Yjsq8lVssQBExF4+TW3QLFyKzBGlkpFboa2tjG4R+04vL6/codW6jM
         aeZF6xFQGEBWTSlHPrwRQdi7xGEPhMD4nuqQ7MUNYng9uvyeU6PE4TSewOuAExNPXi9u
         DtUvMCoA7mEUhFHJi++G1qkAD9hIREGRRn6R5qSUPQHSAyNiqbNTeuxJUmhG6mByns95
         KZT1qWJMvL4+ZLnjONEEUURf6Vr72WpEZ1RvApOlIPpQah2v5GnjORj+VkkCBCljm06E
         Gqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Zs9+hbGUW96eERlzcuPafzXgvREqWAEevqiugLi0UI8=;
        b=pIu3FGpBDWsVmC+iPZDOo/0sUu8TuTVG9B9cFFAzXBZMMtH9tQ0A+eS7DjyDqAW94i
         9AcuUb5E7BLN7s+EHt+mNr0D6y/WEFeqMOM5xQ5y2J7kWYkXCBe77Jrmg11HQ6OW9+Ff
         WhvCTrJmeSc2f6UdCzihklkNhpkEZfOf9xNVl6Iesw8q5fjfEoSpYq9tvdRRHgaTUmgk
         aJJ0X3lIkKXlR/GhrzzsjDTE0ZgNtOopJxaGIFXMHaQlelV+WP8TPZY/5ziTJYbeUT9S
         v9l5yuvvzujnpA3zdQQZ2pBOSxTcfyYvGeBfmqfPF/NaHSvyXxBH9cvGj4191RvtQhnj
         dgPw==
X-Gm-Message-State: ACrzQf2gFIEdN0dLBcuJa1IURUvHXX7wEq59/NJbeIxuFKIpg+1bDVVb
        54Sw9J/zCBDVY8u4ldG8xqlwE8siLozpFwH/aIzrhh1j
X-Google-Smtp-Source: AMsMyM4Ngzb+0wxi/dSot+ka8tvsem9g0qYA6LX1rtL+KGC6fSBAWMqGU/wySc+iU2qDBZ3jhVQCHv8NxTRmXEGFUII=
X-Received: by 2002:a2e:921a:0:b0:26c:1166:6666 with SMTP id
 k26-20020a2e921a000000b0026c11666666mr11266679ljg.128.1664343733569; Tue, 27
 Sep 2022 22:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
 <a89413b5-464b-2d54-5b8c-4502392afde8@github.com> <ea32aef1-2899-abae-0192-75d672b69302@github.com>
In-Reply-To: <ea32aef1-2899-abae-0192-75d672b69302@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 27 Sep 2022 22:42:02 -0700
Message-ID: <CABPp-BHSPp6sMaxh5ZAxCn+FpLQtcc=9HDtbint1J4VkX2U-iA@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout directions
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye <vdye@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2022 at 9:42 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 9/26/2022 4:08 PM, Victoria Dye wrote:
[...]
> > 1. This could be a "me" problem, but I regularly struggle with "sparse"
> >    having different meanings in similar contexts. For example, a "sparse
> >    directory" is one *with* 'SKIP_WORKTREE' applied vs. "the sparse portion
> >    of the repo"  here refers to the files *without* 'SKIP_WORKTREE' applied.
> >    A quick note/section outlining some standard terminology would be
> >    immensely helpful.
>
> This difference is absolutely my fault, and maybe we should consider
> fixing this problem by renaming sparse directories something else.

Hey now, don't reviewers also get some of the "credit"?  ;-)

> Perhaps "skipped directory" would be a better name?

Sounds reasonable to me.
