Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD91209FD
	for <e@80x24.org>; Thu, 25 May 2017 12:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765732AbdEYMv5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 08:51:57 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33517 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765725AbdEYMvz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 08:51:55 -0400
Received: by mail-oi0-f43.google.com with SMTP id w10so279095953oif.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 05:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NzVq8A0xPBQK0iBWDHNsRwPJ5f744Lpgy7sZcL/HI5Q=;
        b=Tc7cqxuFrp2o/ky5F8Q2HwiYZnw9cPnDTQkFXqQQpYDMb1XeSmSXZDfT0o2wmIkG7o
         t6BnqIs2rQ16dJgN6HrdWzxHJw4JW+7wEglcfjMlGeIsWEzzbrZIw1hyi2odu7q0PPl0
         0l5VELZnqES4WW2dEeECsNpV0LmBinDdep2Jw07AYDH1sgAs7w06pIWI5n45ZixPZAJH
         Nf1KqyI4ycEB9jQO+1H10+A8JetA2zkA+qiaHM9J+k1Bi412I7OubtdXa7aIrW7Z+4kV
         iKxBHgF3y9gG9d1z0s71ztdnlMjVhXgxCHuyJyki6TfRwiK0gZnq0OKVRAK8mUovi3Zx
         nggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NzVq8A0xPBQK0iBWDHNsRwPJ5f744Lpgy7sZcL/HI5Q=;
        b=THe2secuHY5mbdko+/6X4NGr16CTBLmqXa0yQ7V6q9L89lKu/em285HZlJe1RdAu/k
         SP9Pot+ZLnEYeAGr4BqGuJm9+KFXcNuzWPMoL8nJyTXmYxRczO1cT3Dy0S3lJ+miVlyD
         pg4m0FOOLmunGyzBhfOmZ1OxNbX54mwqsAH6wLILbVGmSTpas6n+2nMbFCVIMYIyu85s
         53wKAzgjFNWXQ7QN8E19wYOZQ2SE3raQB+Xh8JH+bRnBm7PQivysRtJJURPtU/rwCkHU
         56e+u7d/q80mLmoLbQcOq12QcNsMUZCnp0lyL8m2/E/D+zXImQity1UcXW4g7GCLbdJw
         3apQ==
X-Gm-Message-State: AODbwcCEtW6RmgIOG+GZ0bEV71r3aia4/tWMStIGlAmNdYAgOz6B0AM8
        qVrUQPtHninauuBO3BoVlYlF8HmlXw==
X-Received: by 10.157.39.98 with SMTP id r89mr8064509ota.11.1495716714811;
 Thu, 25 May 2017 05:51:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.17 with HTTP; Thu, 25 May 2017 05:51:24 -0700 (PDT)
In-Reply-To: <CACpkpxk4X+hvmWR_ohHaKpJiiJe5pdZYcdRYjZqk=Ae0416w2g@mail.gmail.com>
References: <CACpkpxkGWhcALQZ2+2nOCRKgzAa7U7EjZg--S71zocdGY8NYag@mail.gmail.com>
 <20170518014210.94189-1-manishearth@gmail.com> <xmqqy3trstup.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CN0ZvWD6v2vkK3Lbt7xgrMwCjFKT6Nx7HtwZiEzmowpw@mail.gmail.com> <CACpkpxk4X+hvmWR_ohHaKpJiiJe5pdZYcdRYjZqk=Ae0416w2g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 25 May 2017 19:51:24 +0700
Message-ID: <CACsJy8AgAVjCTcvYf_YSiVcZVBr+NNJOomVGy=2Ej4X22=v6eA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] refs: Add for_each_worktree_ref for iterating over
 all worktree HEADs
To:     Manish Goregaokar <manishearth@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 5:52 AM, Manish Goregaokar
<manishearth@gmail.com> wrote:
> What work is remaining for prune-in-worktree? Link to the relevant discussions?
>
> I might be able to take it over the finish line. (No guarantees)

The finish line should be pretty close. I've addressed Michael's other
comments except [1]. I pushed what I have done here [2]. The "wip"
commit was what I proposed to Michael and I believe he had a better
way of doing it  I think I had a look at the merge iterator once
before writing mine, but maybe I didn't look close enough to see it as
reusable in this use case.

[1] http://public-inbox.org/git/%3C00720e90-ed85-e8d8-a2e4-f42f93a33d33@alum.mit.edu%3E/#r
[2] https://github.com/pclouds/git/commits/prune-in-worktrees-2
-- 
Duy
