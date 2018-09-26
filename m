Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 547751F453
	for <e@80x24.org>; Wed, 26 Sep 2018 15:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeIZViI (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 17:38:08 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:37441 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeIZViI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 17:38:08 -0400
Received: by mail-io1-f44.google.com with SMTP id v14-v6so23613235iob.4
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PhN2hiyV+Loht8R7v8wMU8ne1HUlZeNAFNSQdj/0hVI=;
        b=UdIx4WWa6Ox9jK7Np5O7/smGmvQ2PpGSnUisHC8R6IvU4PXK9eRXaE4BQvGW7jrq6W
         ISpfHCgTV01VGA7NQamzlP9QbSRDIrSS2WNQ6DZEAlMv+ZnHsaBKejSSlP0A6wJ4uhGp
         X94LmRXCIcHivcSMj6/NZw1RwTXYW3zPaBIwVLHSZG3523B5Y6vpI67pJkrzcViRgiKI
         FGIaNOTRk4zW+flPqeC1biZ8xRc2qu+8nxVFYDyAlGDMB6pj5LDFygkPDeh0HBr87EGZ
         7iZPoi2KzahOt68G0pDoGfHy5El8U9HjFYMkIh8FhusBXvp6Y8L8fCd9u6TZYQd66fl4
         Mq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PhN2hiyV+Loht8R7v8wMU8ne1HUlZeNAFNSQdj/0hVI=;
        b=C0QCOljZCtnSZo+WYF0LKHD1wnHZVWgdif+deDCNJSwAaZazlD57sLpRMn2ljf+rdJ
         xYoudHbaAh0TnElvLkmF+8tljsqNb/skgRMCK6OQFwaw2Rko85zRcT0BSXJY1Gf26kFc
         JMDaFtGsb8OYmLMClxkuXaZLAkTQ8yMPSKpvW5/C237Mnqye22/EY4bWv/hC5HpgEVNZ
         llVgHzEGvB43XKGmMEd85S0Smtxbat6TfT2w30DFEUoR2jo1s1sbLQdVRtgqMPhfLmbQ
         +IpYOf0iKTUdi0L3dFUGyyxCV2/xNJGsNyk52dvF61nbgL+fK7YECID0VwKER2GJSkQx
         HRbQ==
X-Gm-Message-State: ABuFfoi7Z+ZgFzVNMy3eTcnIipl/rCzLnZ4W+HrX6OjHyRZZoo9K4gfd
        xzotypfyAVkZR/aW3a6bDtiQm6O1rF2kY+3KKFs=
X-Google-Smtp-Source: ACcGV63sSrLLsHki+xkj4C1NvLbVVlHnMErmuCVrzk9ndR48PgQgYwGMslyNj9bVhDdHzVJCjKdXFZb3r5nDD+x454s=
X-Received: by 2002:a6b:8f93:: with SMTP id r141-v6mr5059125iod.118.1537975480985;
 Wed, 26 Sep 2018 08:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <90301874969f7b11f33e504500c150a25d722ff8.camel@gmail.com> <39F9931A-B297-4525-A131-736B900F37AF@gmail.com>
In-Reply-To: <39F9931A-B297-4525-A131-736B900F37AF@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 26 Sep 2018 17:24:14 +0200
Message-ID: <CACsJy8AScp1v+R62vXWuP-45LLLYwfSBNaZJfR02=d+2CzDqhg@mail.gmail.com>
Subject: Re: git fetch <remote> <branch> behaves weirdely when run in a worktree
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 6:46 AM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> This is the most interesting part of the issue. I **did not** run 'git fe=
tch ...' in between those cat commands. I was surprised by how the contents=
 of FETCH_HEAD are changing without me spawning any git processes that migh=
t change it. Am I missing something here? As far as i could remember, there=
 wasn't any IDE running that might automatically spawn git commands especia=
lly in that work tree. Weird.

Another possibility is FETCH_HEAD is somehow a symlink (or the whole
worktrees/$BUILD_WORKTREE is a symlink) and is accidentally shared
with some other repos/worktrees.
--=20
Duy
