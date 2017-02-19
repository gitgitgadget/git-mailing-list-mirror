Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E36201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 22:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbdBSWdE (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 17:33:04 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33987 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbdBSWdD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 17:33:03 -0500
Received: by mail-ot0-f193.google.com with SMTP id 45so6350768otd.1
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 14:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=l8oaX+19Qsyicdi/kOWXqW4VEgExWDm2JEMx1+gTLn0=;
        b=DXIq3vOzXQLAtAVMwd2EF/30vCvo6vq5BE78O5uEABOlOMdgmEveBzBcK1GM/4RxmG
         nJ6HDeBGgKoNUToxDNPLA/fYJbHvA51o2vi6lOf7fnb0TiLFcRVk1lg2T7srn0GfDYNo
         tjKuxmDjkLi7qkNxo/2AepYueirDzp7GqVpC/y4yoEjIQWWIXRmFNB30YEQx4D6pEt6k
         xar1Mdzt/krk2V4vpV8RonTd9kFtTWdilOQuDFbZmcuvQI9yXnXuyGd2E6TcdHgmovmc
         nPkAx0wuxDhQ00XJViDqkCV+Yr/lctjR6NOut3beMXcmfjW5x/lwC9LUesC6klJT3YDq
         T4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=l8oaX+19Qsyicdi/kOWXqW4VEgExWDm2JEMx1+gTLn0=;
        b=AcatS+uG6ZKhqI5FqllJeYi9czVdskNn8R0uh1GdavMxrQx1f6k+QpnrL/SyfUctLB
         wZygdaQJ83GLoST8BRGVnE5jIDpfmZWkxQNXtPZy+huT9trc10hZ7QyxefJYOfhdOmNJ
         K+V+cxff/6OikcLKNbS/ao1PpPdAfmYGkYYEe0mAuFVGKkTc1PM8XpEla5Qf4kS+IKgN
         QaX95uvWpxeazkun+rlv/027cfYMT7e6aJMj8uUSph46GQ4xpWqh2hMAfkx0IPxnZ/12
         KohcSk/Bw1Q/QwUGCm8DqaVH+dqClkvYOBBPD92uEkKJKA4tLqSzKBnwR5LR3/pzNOAX
         h8Kw==
X-Gm-Message-State: AMke39lFbKARpuNckg1e1N/iyH0aAhJIspcEg7bHH7m3UBDsc3fGju+fKzKjGlLxrLXrA0Wkfg1h6QYE1gXUEw==
X-Received: by 10.157.4.36 with SMTP id 33mr9248223otc.221.1487543582803; Sun,
 19 Feb 2017 14:33:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Sun, 19 Feb 2017 14:33:02 -0800 (PST)
In-Reply-To: <xmqqefywnk5a.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan> <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
 <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com> <CA+55aFy-vvOBu5Y4KDeteUyK-7U7yTa1HoqHo+hME1=8bq7Xhw@mail.gmail.com>
 <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com> <xmqqr330779h.fsf@gitster.mtv.corp.google.com>
 <20170215002901.gtzegvhyy7d6cvrb@sigill.intra.peff.net> <xmqqefywnk5a.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Feb 2017 14:33:02 -0800
X-Google-Sender-Auth: U4RY_GDYQTz8HSrdMfWRBkIDPkE
Message-ID: <CA+55aFw3ZRtgsLGW-TFqpq-3uCw55L42p7cF=Q-73qM_VPuYsQ@mail.gmail.com>
Subject: Re: [RFC PATCH] show decorations at the end of the line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 9:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I just got bitten by a fallout.  I have
>
>     $ git recent --help
>     `git recent' is aliased to `log --oneline --branches --no-merges \
>          --source --since=3.weeks'
>
> but now the branch names are shown at the end, which defeats the
> whole point of the alias.

Yes, your situation actually wants those decorations as primary
things, so having them at the end is indeed pointless.

So I think we should just discard that patch of mine.

                 Linus
