Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77D2D1F858
	for <e@80x24.org>; Fri, 29 Jul 2016 00:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbcG2Acm (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:32:42 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:36485 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbcG2Ack (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:32:40 -0400
Received: by mail-it0-f41.google.com with SMTP id f6so181258564ith.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 17:32:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GymMfHLySkUek+ZDXprXldogk/AINW97IhdibJubpkA=;
        b=bsh6+bx6/UdaaqihS3vQ9pfrr39wjMZmAqQr83qtK2l3NM4vlUwdjRdxToqrNnH9dx
         VzVyeTY4rG+AUAvlMfolAXUBqXy+cWo/znayfaJ+g73/mriZ31z3dMFwBBcg25aPd50N
         4DPjAyovd0CxINcgFt7FXxl1LKJtLKBQ5LJX/JqkVWwujHLx4oTz9coagYkZvErsWmCL
         IFUe5Irlc4jLj8jQWjRDB/8YZkS4bEP0yZnQgBYXcHvqD9rXeqaSkOLkquAHSkqMw0fM
         ZzGM0obZHYnG2hpCl+7skLWAV58+qjKWy5V4eAVTMX3xJUPEcK2xABHzKGM7JAMWZyh1
         lBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GymMfHLySkUek+ZDXprXldogk/AINW97IhdibJubpkA=;
        b=RW8sLWACQMY7SMhFXOGIfJPVtCyB5P28MrCBUEECGXhSafgA0DpQT6mDXo/TfRP24P
         YPtCJmGxdjlxONA/UTKEV5HgWMQ8clwUaJbxycHKnn3WdbXTYTo9YWCtfj1csjU9tVhj
         L6HvH9yv4pVG1OrDW3UJs86DyQTt1mrfrgDW/9MCEv/QSsrYyYV6E1KX+Xu3xInRVZsx
         wVLmUOATg6bSc+BgHd3wPiYLKvUCbMMuCbUXrwpP4qjuy8Rg7RAmWqEcNoT/Uz1SCiNf
         8v55l5IsQzEuRRBCjkXPo24k3DaTGUe5Y8C6EbLvZRPioDDbsXxDzaKY/lLSy0Zaz286
         c0yw==
X-Gm-Message-State: AEkooutbtPACrDygoQt5hW5ROvZL3pRtP7mUAhlXJCUHPBV8y/2PJuoAyz6dkpVbJOAslE8kfpW8yjzYozAaCA==
X-Received: by 10.36.127.7 with SMTP id r7mr41680319itc.49.1469752359682; Thu,
 28 Jul 2016 17:32:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.230.134 with HTTP; Thu, 28 Jul 2016 17:32:39 -0700 (PDT)
In-Reply-To: <20160729002140.GC9646@sigill.intra.peff.net>
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
 <20160729002140.GC9646@sigill.intra.peff.net>
From:	Linus Torvalds <torvalds@linux-foundation.org>
Date:	Thu, 28 Jul 2016 17:32:39 -0700
X-Google-Sender-Auth: bkQMt_FbSm54BcBaPTWmc8s7nb4
Message-ID: <CA+55aFxMZAuY7NY6rSfrMVyEdLuZDHBTs97UUdfk9=yJL1iLjA@mail.gmail.com>
Subject: Re: Small trivial annoyance with the nice new builtin "git am"
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 5:21 PM, Jeff King <peff@peff.net> wrote:
>
> I do wonder if you would be happier giving each commit a "fake"
> monotonically increasing time, so they are correctly ordered by commit
> date.

No, that would be nasty, partly for the corner case you mention, but
partly because I just think it's wrong to try to lie about reality.

The reason I noticed this in the first place was actually that I just
wanted to take a look whether things had gotten slower or faster over
time, and see how many patches per second I get from the patch-bombs
Andrew sends me.

So getting real time was what I was looking for.

Also, before somebody asks: the reason git has always cached the
"default time" string is because there's a reverse annoying thing,
which is looking up time twice, and getting a difference of a second
between author times and committer times just because of bad luck.
That makes no sense either, and is actually why we have that
"ident_default_date()" cache thing going on.

So we do want to cache things for a single commit, it's just that for
things like "git am" (or, like Junio wondered, "git rebase" - I didn't
check) we probabyl just just flush the cache in between commits.

            Linus
