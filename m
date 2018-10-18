Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 401CB1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 18:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeJSC31 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 22:29:27 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53952 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSC31 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 22:29:27 -0400
Received: by mail-it1-f195.google.com with SMTP id q70-v6so1495432itb.3
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWCwS12g3JHBxwJc++3iwtgtRhIzYbmZFLcwDWzEgWE=;
        b=TKyZ5c9TAHFf2+mCgLrCXjzkmTozN691J66ZtzvxbHEvz8mddrJt2DUyfs+6A9x8GC
         LDCE9Nm7hF7dbaOaixWL4ESWwae2J7YM6jDZM1cg5WYdoU2X6wsF3cFfOeXf8ZEUtJwH
         DP1RcSdQ5QmC8KZgYfMI1DblK6ccpuNM6q1Z9LR0FMa/eYa43zzHa6xmAK7xSjX91Jyl
         yvSzslm3CITh/P46hFJTI5oKZgNE+sXiaNZOXly4/hIPFrY7pc/ur3YGvNVsA4qamODn
         DyITL6h0U732WsJvuVMyY4+nSEpxi4EoHneLE8UNiSxwPMqt4wH1DEPRrq6RPLd6VLYu
         fQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWCwS12g3JHBxwJc++3iwtgtRhIzYbmZFLcwDWzEgWE=;
        b=KWiLbz/aAVxSBFBo8pqmHB/hD44mbd5dCrtLOPUaBtdPmUv+S9kJ3DfSoWWefevZHw
         s8CPzTHRhkPI2YeMaY/qBg1AayAUjmuRBLDjAGYAoYFiJgXviuW+qiZKclLnuiVAU5E4
         HL4rJFK+wetikBOPAPS9g1LsUIKYXCMn8XlTv985d0aYORspFAtgrkQsQL1eTzaQxnpu
         Shge8BcViF4idwL2JLndULqnl1LEpMUycNpxgRs8oTdOldHbzBvvEUTq9f0PN3kyLlnl
         nKk9fHUqsi0gHrlOnZxcAtE+s2Mi1Z/SoU8neA0Dsf9/VoXK8X5ZqXHYGoHt/BrGbneZ
         joNA==
X-Gm-Message-State: ABuFfogork4pZgOCbMiIuEvyhZTB7IiW0uisGnuD9r9NY4Tp+Bxh93jr
        rWMnNQaGPtuwWDD9WSoUbxaQ3nkf+i5KUbXQZfU=
X-Google-Smtp-Source: ACcGV60H3HjMUII2AXSw9vwI1Mu8f4XTxGvk3zFOAm4tuEkbeCHHPCE2NJJKZ7QV9CSW5vuQmCZm+6ZLUXQX3LpxH5I=
X-Received: by 2002:a24:a343:: with SMTP id p64-v6mr977299ite.10.1539887232059;
 Thu, 18 Oct 2018 11:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181017164021.15204-1-peartben@gmail.com> <20181017164021.15204-2-peartben@gmail.com>
 <CAPig+cSiE-M9QMch4WE7y4cib1FBUNiaR2pGGtbDuqiz6juhaw@mail.gmail.com>
 <20181017182255.GC28326@sigill.intra.peff.net> <xmqqpnw7vs5b.fsf@gitster-ct.c.googlers.com>
 <20181018063628.GA23537@sigill.intra.peff.net> <5b4d46c2-ac0b-8a44-5e99-b0926ea764d3@gmail.com>
In-Reply-To: <5b4d46c2-ac0b-8a44-5e99-b0926ea764d3@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 18 Oct 2018 20:26:45 +0200
Message-ID: <CACsJy8CvvZcQdxnZbu-FZmVm7wtMDLocjiMVURhvJ=NtuYgi9w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] reset: don't compute unstaged changes after reset
 when --quiet
To:     Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 8:18 PM Ben Peart <peartben@gmail.com> wrote:
> I actually started my effort to speed up reset by attempting to
> multi-thread refresh_index().  You can see a work in progress at:
>
> https://github.com/benpeart/git/pull/new/refresh-index-multithread-gvfs
>
> The patch doesn't always work as it is still not thread safe.  When it
> works, it's great but I ran into to many difficulties trying to debug
> the remaining threading issues (even adding print statements would
> change the timing and the repro would disappear).  It will take a lot of
> code review to discover and fix the remaining non-thread safe code paths.
>
> In addition, the optimized code path that takes advantage of fsmonitor,
> uses multiple threads, fscache, etc _already exists_ in preload_index().
>   Trying to recreate all those optimizations in refresh_index() is (as I
> discovered) a daunting task.

Why not make refresh_index() run preload_index() first (or the
parallel lstat part to be precise), and only do the heavy
content-based refresh in single thread mode?
-- 
Duy
