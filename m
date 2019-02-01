Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2E81F453
	for <e@80x24.org>; Fri,  1 Feb 2019 23:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfBAXOB (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 18:14:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38763 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfBAXOA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 18:14:00 -0500
Received: by mail-qt1-f195.google.com with SMTP id p17so9621128qtl.5
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 15:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJlGEzkrkBL+Z+nsiYt6tO7i3+QC42tCa2T77G6wV14=;
        b=WYGGVr3GAu4EtQEturxbcjUxAFFsauxtjs0VCv+2GiaP5Adsh26CqXHul/flFdl/7/
         qWYoRLvDPE/oLnXTx8SQVjaFVUkmXy70olpG2ADW2HyzO5/M6117fS5J8MbO5BdKluZ8
         DJXd13Yorn8YbY9mER+kZUKuGFHYz6X+5L/3u3x8oLuQGEnKnSKnJQkx8y1BcBeL3x/Q
         ECkFQUAu1ZAxVfRW4f8re5wlk7hgot9jEMlXxjwshd71yia/kLOAtTQytVwCWcsuriO+
         jnAPPogBQsnJrGi67uIxs3pSKEUSs54FRcS2eiFW76+suhHwgCd6tvIqIOqwA46Qd2Nv
         MoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJlGEzkrkBL+Z+nsiYt6tO7i3+QC42tCa2T77G6wV14=;
        b=MCp+tdz/ih7NPFufpZRMCOvT5PP3Bg+l7ijy/VXOT3e0P8FnL4qzvuVyYHnEWhW5JE
         +PIsyfKT1C+Pe2N/jg8gLNeo2QTKBeulOwZhcgaH0IfYBXsx3fbwd0dPxKMAyqBt7VLx
         hRYtEyZL/xhD/WaNmpjDb7ZQ4eGMsIAyQGMPBPXebUI8xOo6cPM+kVOdm8o1P/zbUnFk
         tDPluyNIDCg63+eYbIKF4f/BC014FaUwgy2UtGlYjDICQR1yu2lmwrYIPSUXJKx/OzF3
         sNFUKML/ga9Krk4lXs4Nt7RqjzTQ0IVWXFiwlnp5AxB23SsbvQr8n1XWBrEZwJVdFesf
         YOpg==
X-Gm-Message-State: AJcUukfEmBLJsxKGnLXo5ERq4Y5VGgwkEfI2P2rPKa3KwPfjefZ/JCfW
        z+6BOw4igHMXr671cu1fz8LKgRecw1X8Hkhyihg=
X-Google-Smtp-Source: ALg8bN7SfbiZfjmjzcxnSsUwriLrUG+2zYNAgaOl2zfm/cX2HxI95JYEZv/WGC8J3Etm1FwudYYPefyo6VtHvUFWSnc=
X-Received: by 2002:ac8:108e:: with SMTP id a14mr38126810qtj.86.1549062419912;
 Fri, 01 Feb 2019 15:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20190201220420.36216-1-nbelakovski@gmail.com> <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190201220420.36216-4-nbelakovski@gmail.com> <xmqqftt7w25q.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftt7w25q.fsf@gitster-ct.c.googlers.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Fri, 1 Feb 2019 15:06:31 -0800
Message-ID: <CAC05386O=9CxkgUNGoYbwEOXiPPcAD7H5Kn97iCqPc1X7kAh6w@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] branch: Add an extra verbose output displaying
 worktree path for refs checked out in a linked worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 2:54 PM Junio C Hamano <gitster@pobox.com> wrote:

>
> If the rule were "a branch that is checked out in one of the
> worktrees connected to the repository is shown with the path to that
> worktree" (i.e. no exception), I would understand it.  If the rule
> were "a branch that is ... (the same sentence), unless it is the
> branch that is checked out in the *current* worktree", then I would
> understand it too.
>

It is the latter, as in, yes, I meant "current". I will update the docs as such.

>
> In any case, please add a test or two to protect this feature from
> unintended future breakages.
>
> Thanks.
>

Will do.
