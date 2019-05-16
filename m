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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6605B1F461
	for <e@80x24.org>; Thu, 16 May 2019 12:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfEPMoj (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 08:44:39 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:54562 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfEPMoh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 08:44:37 -0400
Received: by mail-it1-f180.google.com with SMTP id a190so5828279ite.4
        for <git@vger.kernel.org>; Thu, 16 May 2019 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QoWMQbXttWpqYELOh5oyOHlSGWn4rh55ULPJ6uIrPpw=;
        b=LQnMev2oNbX+8AyKsPpmP6cohnOhqi7l0ElFeWDlf5GCryZ4Yj2cR8LB4AxXXiHkgh
         qfAjV3gTdA+7fsMDPkR+TRNZ+tFfGe9y38feKtCMfok/mZXUYidZtbBD803DpVbeahXy
         H4LqFrurCXt4FIwY9I8JRepO2xGf2xqvmSMufR8uYKN8pUmiSOd2bgp2kpE0wFYtOonI
         eB621/3DrraUBbdrt4hvHG+WCgUvf11y80y2u7o7D6PGxjTyAwAT51rkUzbOe+W4jci2
         c9ULkxnWXqWzJU946GRwYyG4PBslJYiN4i4Ga3yO4gTJnxHsaVmGbqt4Z6sWXUA0y6OQ
         7eCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoWMQbXttWpqYELOh5oyOHlSGWn4rh55ULPJ6uIrPpw=;
        b=Off4wwEEb06LXHpD+BKf3jV9DqnwHfue7m7qm/fjfRg72P+DY1bGfSlUsRbXhQEQFo
         PMW+3fmn9tVswGOUlLodsZsvNFec33jEj7+xGhPnzDc8JSwdZe9LhA0OalHKMz/CM8gn
         txwtiZwl0Euvk0o7E0LJhmDfCBeGImfmbineywiiERcN7l34y0E0apHhHIScvqv+vq9y
         jr91pS8MtFi0cLw4cym65nRNb5EmBr4i5El05jP7Gp8pYhgM2/qdLyY7ozny9MPfPRTK
         RoFA2zfBuETvvmYXiIaXZHyU2622480Ny5CwR/UrY8PvNGhd24lxVbceyQ9pD7C5H0ql
         VQYA==
X-Gm-Message-State: APjAAAVJy3yMmwRU94vQ9U+iNNeVByugaDsWewW9tQtBeKdxnqQJSZC9
        ZBPg7qjNRf5i1TtVvP94Lp8DoNnLbXr56cqPDto=
X-Google-Smtp-Source: APXvYqzFpwLTMzaqHhzGXE4k6o0+2p3bQo6szvYeILK8R5mY+Swep9gmeFVUC9zrNo3SqMQhz/sEhKEsS3LG0lj0zSI=
X-Received: by 2002:a05:660c:34e:: with SMTP id b14mr10997997itl.10.1558010676351;
 Thu, 16 May 2019 05:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <3E55146A6A81B44A9CB69CAB65908CEA6B91353C@TW-MBX-P01.cnesnet.ad.cnes.fr>
 <20190515103031.GA29149@ash> <xmqq7ear5egz.fsf@gitster-ct.c.googlers.com> <d8fd0d06-ec83-941f-c29f-2fea0efb6fd3@iee.org>
In-Reply-To: <d8fd0d06-ec83-941f-c29f-2fea0efb6fd3@iee.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 16 May 2019 19:44:10 +0700
Message-ID: <CACsJy8D16A3VKdTFfVyENZoH4J7Dv-3iwovEgsUj07KUT8NBKA@mail.gmail.com>
Subject: Re: Feedback on git-restore
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Poughon Victor <Victor.Poughon@cnes.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 7:12 PM Philip Oakley <philipoakley@iee.org> wrote:
> Maybe we need a `git index` command to make it far more visible to
> average users (or `git staging-area --show`, with a --cached option ;-).

Not commenting on the other parts (and also Junio's mail) since I
still need more time to process.

But how about we see the index as a "commit-in-progress" (or "staging
area" which is almost the same, maybe "commit area" is better)?

You can't make a commit visible unless you check it out (and then can
use various tools available to work on filesystem), or you use git
diff/show to examine it. The index is treated pretty much the same
way, except that it does not have a proper SHA-1 yet because it's
still a work in progress.

Short of creating a fuse filesystem to show you the index content (as
read-only files) I don't see any better way that you can actually see
the index without checking it out.

PS. Yes I ignored the role of the index during a merge conflict. Not
relying on the index for conflict handling might be possible, but I'm
not going to touch that topic, way out of my area.
-- 
Duy
