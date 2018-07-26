Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4BA31F597
	for <e@80x24.org>; Thu, 26 Jul 2018 15:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbeGZQyk (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 12:54:40 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35396 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbeGZQyk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 12:54:40 -0400
Received: by mail-yb0-f194.google.com with SMTP id x15-v6so807886ybm.2
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=htsyxGvMzTJJTTKr233LU1zYYwFjPiVBbT+BJyZ5hnA=;
        b=E4sF5lYzPuK6MsDZ5+2E1IkVNQeTDvtfsnVhDmojR/YTpEL6QFkyro56vgD0vA8RBr
         xZdwvIbH4iuyKqYlWverSwwH3F3tHKreyWM6xucizHk6Jz+yATeWLm3fMUFKJV5Zpcii
         2WCLimkee52iGTsaDJBA/PXaoa3pCkmtohBa9oHnBtonPtjNuRPF+pe37DKxmYu0c2R5
         ig698kLXSW709rjsQTJ5lg8EMOYouKJzb6m6Dirxlr+RtpF8ctfzAxXsMzXAkzLh3fTg
         LQ/fR7TxZOBQ1sf9PKMV7ehOBXmFPtmTwd/PW6Dq1mAWRjGcbp59rrHOuKd/l2rAFJCT
         dMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=htsyxGvMzTJJTTKr233LU1zYYwFjPiVBbT+BJyZ5hnA=;
        b=EzohkZ55jxIe/ihLKJ4q0x8tYGv/OCj/N2Yu7MTVOu/U6FXTkyHVYORi0/OzALdJbW
         6DWg5zswnbznvoRHiZBfQiOXpuA8RoBeEqwgA56MKsH6jJ9vkiZrxtQt4ePzau8cV7XM
         FSdZseIaNdvyiTjbViVfkf28YLd7pn61RBusAE+N1iBgtaz1HDUnTWm1FaabWWGNvTre
         qtfCLJUE0jnVy8cjhkbecT++bnXxmclOHuuEVmP4RxrFY+8UAgYDfe+cAlxoJkOOgY/W
         KnVbm3ztIVvPr7GYy3sJuzjEqRmJJd7DyN1xJ8Kexq8Pcs/kWps/87c/w5JRoUVwDjto
         7m8g==
X-Gm-Message-State: AOUpUlHluuVJ/+oXX4NHWOY9nORQtdJUgmwKOHRybQzeflbfcTjoNZ80
        ugcj1kbh20xpvYm0OlYKazg=
X-Google-Smtp-Source: AAOMgpemQNiQoR/BNNf4ZHZxnZE6K8yWnqrUKwTxM98NhK2+Elb/2sa0/Db0Pc1im2yypKfSJudogw==
X-Received: by 2002:a25:6216:: with SMTP id w22-v6mr1322937ybb.511.1532619436947;
        Thu, 26 Jul 2018 08:37:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::d338])
        by smtp.gmail.com with ESMTPSA id h9-v6sm637390ywa.63.2018.07.26.08.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 08:37:16 -0700 (PDT)
Date:   Thu, 26 Jul 2018 08:37:14 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] name_rev: add support for --cherry-picks
Message-ID: <20180726153714.GX1934745@devbig577.frc2.facebook.com>
References: <20180726121346.GT1934745@devbig577.frc2.facebook.com>
 <20180726143930.GW1934745@devbig577.frc2.facebook.com>
 <xmqqa7qerpxu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7qerpxu.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Junio.

On Thu, Jul 26, 2018 at 08:12:45AM -0700, Junio C Hamano wrote:
> Tejun Heo <tj@kernel.org> writes:
> 
> > From a6a88c3da252d69547ac8b463098fc4f4c03f322 Mon Sep 17 00:00:00 2001
> > From: Tejun Heo <tj@kernel.org>
> > Date: Thu, 26 Jul 2018 04:14:52 -0700
> > Subject: [PATCH] name_rev: add support for --cherry-picks
> 
> The above belongs to the mail header, not the body.

Ah, right, sorry about that.

> >   $ git name-rev --cherry-picks 10f7ce0a0e524279f022
> >   10f7ce0a0e524279f022 master~1
> >     d433e3b4d5a19b3d29e2c8349fe88ceade5f6190 branch1
> >       82cddd79f962de0bb1e7cdd95d48b48633335816 branch2
> >     58a8d36b2532feb0a14b4fc2a50d587e64f38324 branch3
> >     fa8b79edc5dfff21753c2ccfc1a1828336c4c070 branch4~1
> 
> "git name-rev X" asks "I want to know about X".  And the first line
> of the above tells us that 10f7ce is the first parent of the master
> branch.  What does the second line tell us?  10f7ce was created by
> cherry picking d433e3b4 which sits at the tip of branch1?
> 
> It appears that you are showing the reverse (d433e3, 58a8d3 and
> fa8b79 sit next to each other, but it cannot be that 10f7ce was
> created by cherry-picking these three).  I do not mean to say that

So, it means that d433e, 58a8d and fa8b7 are created by cherry picking
10f7c and 72cdd is created by cherry picking d433e.

> the reverse information is not useful thing to learn about the
> commit (i.e. "X got cherry-picked to all these places") but I am
> having a hard time convincing myself that the feature sits well in
> "describe" and "name-rev".

I should have explained the use case better.  Let's say I'm forking
off and maintaining prod releases.  We branch it off of a major
upstream version and keeps developing / backporting on that branch
reguarly cutting releases.  A lot of commits get cherry-picked back
from master tracking upstream but some are also cherry picked to
sub-release branches for quick-fix releases.  e.g.

      v4.16
 o----o----o----A----o----o..........................................o master
       \.----o----o....A'----o----o.................o v4.16-prod
              \          \.----o----o v4.16-prod-r2
               \ .----o----A'' v4.16-prod-r1

Given a commit, it's useful to find out through which version that got
released, which is where "git-describe --contains" helps.  However,
when commits are backported through cherry-picks to prod branches as
in above, that commit is released through multiple versions and it's a
bit painful to hunt them down.  This is what --cherry-picks helps
with, so if now I do "git describe --contains --cherry-picks A", it'll
tell me that...

  Upstream, it's v4.17-rc1
    Backported and released through v4.16-prod-r2
      Also backported to v4.16-prod-r1 (cuz the fix happened while r1 was going through rc's)

So, it extends the description of how the original commit is released
(or given name) so that releases through cherry-picks are also
included.

Thanks.

-- 
tejun
