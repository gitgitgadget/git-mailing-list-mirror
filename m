Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A204D2023D
	for <e@80x24.org>; Thu,  2 Mar 2017 06:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbdCBGNz (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 01:13:55 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35378 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbdCBGNz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 01:13:55 -0500
Received: by mail-oi0-f47.google.com with SMTP id 62so34361358oih.2
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 22:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iAoXQq8jmuzv2OsmDAPrPVn9p3E1pw92J3FnP83Zz+k=;
        b=HkE8GESQlsCzH5LaRXSaM48gTgv65d3ytPxX19WFbMeNC3J0BY7zjaw06vkALprJ3B
         3Z7J1Dx1Z9z8Cvxb/xyoJbp2PiBxluxzK5J2/OhGZAqF9pgqN3UCdfBwdA+2x7zECwDD
         brCdf6nViRLdJKSENbj2Nx30eAtqYy5xV/YUCniyISX5zMlH6fYNMmHCgeILBUkaHsAB
         tAogTu9f3ODAR3ZNIIMOY1+9iyPvGDz/8i1d79EvEDgWoRYBScw5T6SKeLgqqdBxeago
         YqB760LSB6UExtNNUjndUMMD8GvcF0VWQEP1wiWlOXOTbAepNyGMlBZ0dgcz+HlgiU+I
         u7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iAoXQq8jmuzv2OsmDAPrPVn9p3E1pw92J3FnP83Zz+k=;
        b=JF0rJlYjXRnL1SBVcALjHdAXGFrtOv3jFVCdqlHVyJ1BMMLVxov6ft42xd2nwFC7GH
         BL1h8eIok6wZMA09eHV9ky6ILZlKqJmVRf2T9hAoKQwH16M3VLg5I3kslLSvP6Q+Pq1W
         117Kn+mtAIzkx0Cv0jrO8prJH672bOXbVpV2WWVF8xB+ehzIQXmvCZ5cing458QoY0KY
         Aa4GRNYpqVz1/OFiwoqOo+b9gu/S2mqWqDlQRDchHF+ftfAE2UFtr/u5mT7+TuhO0ncX
         iMNsRyh2KLepjzNY61cSYoyDw1mmi+upQFpU7JXeuA0o1vsu5ywIwGVC0H3xr2dI7d5o
         qPfg==
X-Gm-Message-State: AMke39ku9JgJbeyvotFUW46lrFiygTq4bTtAiaZzekiTB2orXhsdJoyo3OZZpVii9cTDz4PtnT2p0iCAUahdFQ==
X-Received: by 10.202.72.10 with SMTP id v10mr5483965oia.169.1488435233870;
 Wed, 01 Mar 2017 22:13:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Wed, 1 Mar 2017 22:13:23 -0800 (PST)
In-Reply-To: <8f4ec174-9060-0896-5135-bb50229fe149@alum.mit.edu>
References: <20170218133303.3682-1-pclouds@gmail.com> <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-25-pclouds@gmail.com> <7e5ef9e7-bd90-1917-d8eb-c6310c2744ab@alum.mit.edu>
 <CACsJy8BOY8jsCrDYESJ6Gwy_p=J=c8m1qe64w18HX1Cv2AaYnA@mail.gmail.com> <8f4ec174-9060-0896-5135-bb50229fe149@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Mar 2017 13:13:23 +0700
Message-ID: <CACsJy8DyjWC5WUE7=dWK-mi_piGZJf7L1B0t5RUROvqDS+aP5g@mail.gmail.com>
Subject: Re: [PATCH v5 24/24] t1406: new tests for submodule ref store
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 10:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> By trial and error, I found that the test succeeds if I comment out the
> "for_each_reflog()" test. By having that test write its results to
> `/tmp` where they won't be deleted, I found that the problem is that the
> `actual` results are not sorted correctly:
>
>     refs/heads/new-master 0x0
>     refs/heads/master 0x0
>     HEAD 0x1
>
> I don't know why it's so Heisenbergish.

It happens consistently on my other laptop. And yes it looks like
sorting order problem, probably because of the underlying file system.
I did wonder about that at some point but never asked. We do not
guarantee any sorting order in the for-each api, do we?
-- 
Duy
