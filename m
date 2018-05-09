Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0CD91F424
	for <e@80x24.org>; Wed,  9 May 2018 19:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965265AbeEITUv (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 15:20:51 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:35541 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965363AbeEITUu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 15:20:50 -0400
Received: by mail-yb0-f175.google.com with SMTP id j143-v6so3612349ybg.2
        for <git@vger.kernel.org>; Wed, 09 May 2018 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uBKslJiE9g27dbssAbkXzaXGZRl+kdfN2oVkazobMAA=;
        b=vG8Pju6JfBnUdkAi+qzEgfEApA+Tyo2hEb/qtZBamWHl5A9p7n5cGZe5RKuV8xBTex
         MbrEzNvlCF0xcoEZHaeEyZM/BrqcBhO/bGSVDOLPJYVjdNef59h+lg9EGqd9TeSHLbTR
         2IiF6B69evV5wEKM/yWcWVSvQ4oWTDjTBoz2IdxRpRhif3vLf+rz799TFyKG3tn444d2
         PTu1aNVVNyvKBVp34CEQNqEwSmCnMSlmPqLe6Q6aFen2nqDWHDRmeQl5JjnG2AFfJPsv
         JQbHZkGomakj2DpfHplbSAG7NRP7VkS2RFPC1d95zKXZlPy32gpWkEFa/34/vG50j1gY
         vucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uBKslJiE9g27dbssAbkXzaXGZRl+kdfN2oVkazobMAA=;
        b=PAHrA7lvy3bY+Wm/am6mbaSbEg36lQmYZM1hwmICvRZVew7B/CesQPSKb6XDm4hlFO
         NGBBGfPWg1ZH2uqNgXlcHc+wBcnHzD2dlDy6FdhGuX4AqPtws5THe8HBNjsf/LKNEgdQ
         lckHAv4VWqEcaqJQD/qD8SkGiWM81+1BG6K/jH9fIzDupmgbTHE3N6wLer9dEn7z1Hza
         NaBVhLTRLGCqWZp0SPMZk08hcTW+FWQeUPFtwFTYITyFZdhKHqMW/6qm9PnedBJFdma9
         Z2FIlH04+AvJfHitFnAmYBQmovIwfO7VLjB8RCufXOi+dMUCZ7Avgmfh1J7Mf4HjQDcB
         KMjg==
X-Gm-Message-State: ALQs6tBBapk67kmfieq7WTPZeT9QlIP/BIY9k1OJfGZYKZ2Lgv2XzfN2
        MwyjBgchgG+5AeAmD8gcre3vZ2+FQFNMw189WroDXUZp+Zg=
X-Google-Smtp-Source: AB8JxZoW7lM/PNiOrKPj+nM1PVM+h6glwbYIyfe0XMRmihwaX9mOJoZV5rkdlakgRfhbGrQPMMTry9DB/eZZginK17w=
X-Received: by 2002:a25:a567:: with SMTP id h94-v6mr24777997ybi.515.1525893649006;
 Wed, 09 May 2018 12:20:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Wed, 9 May 2018 12:20:48 -0700 (PDT)
In-Reply-To: <CACsJy8C7N2W821H8YR8VaKdCSOSCDtQi_YT7z8hHNDO-VxJmEA@mail.gmail.com>
References: <20180507225916.155236-1-sbeller@google.com> <20180508193736.14883-1-sbeller@google.com>
 <20180508193736.14883-14-sbeller@google.com> <20180508130431.287a9f273a847c375b3b1e2b@google.com>
 <CACsJy8C7N2W821H8YR8VaKdCSOSCDtQi_YT7z8hHNDO-VxJmEA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 May 2018 12:20:48 -0700
Message-ID: <CAGZ79kbYuodP12Y2WSwmF+EmStv0pHONwfVbqjDS7Kyhvx103Q@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] alloc: allow arbitrary repositories for alloc functions
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 10:18 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> If you want to reproduce, this is what I used to test this with.
>
> https://gist.github.com/pclouds/86a2df6c28043f1b6fa3d4e72e7a1276

This only applied cleanly after I created an empty file at
t/helper/test-abc.c, using git-apply. I'll use it to have no leaks here.

Thanks!
Stefan
