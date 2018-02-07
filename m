Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2EC21F576
	for <e@80x24.org>; Wed,  7 Feb 2018 11:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeBGLJM (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 06:09:12 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:36683 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753454AbeBGLJL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 06:09:11 -0500
Received: by mail-ot0-f180.google.com with SMTP id m20so436878otf.3
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 03:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8+bu7CMaP5gDFKW0r8q7MVzoqhC7xSXFcHi1BQafsvk=;
        b=kZ1tVg7u+8IpzmNKXoisVwISqPmrTooAejnnPgVJ0ckddVNYvdBo0sQGhPowA/IiAO
         UFWWldwu3LiFU6ET6C/8hWDhA3IyA871wmf0OnyCpfXxsRKMDOD2R9H3PGmMsShbW+2X
         KpjMhcJfDlvXKeOrMpmVVQ37OCZwIXuAvBZ2dg1qJpkjCH3qnuLYxSeL8xPng1HBzcf1
         /N37zalS6z4S0wZSp1m0T7zWP0kSJNdOrObBv56gmS8uDzIq7Ioe7uLOWZWQaF+psw65
         sZd/IuM81Aa3OHZJZ0C6UJUhlF3+m0m+elTD1DhdwSJi/pjHjFWSnfsdoA2ZhAPkUTsC
         hmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8+bu7CMaP5gDFKW0r8q7MVzoqhC7xSXFcHi1BQafsvk=;
        b=ijv6q5OoFaf0wzvQkiSgD3p/HwoSPfQcuRkAtiJPNLlEjG3oUPcVWH4RnT1ai2i9tu
         SBK0r9HZ+b4zvwwv/lsrMoXQGcLFEIq/vt/KNqHOvloBiAJdTnUbnfxzkL2KfUOvvxtW
         IJYXy4feLekTRd/9z9oQboMXxUfrAlzENf15X7snVU5tkne7fMWFa4AnjkZWVNeMbxnL
         f3EMcrfaLTsIqAHzqHOSolxA87DLxDzReJjr7iJq7qVTzfVVw6KfVp4NvtnHc9m8HzNG
         NLzNHKzvntSy58P1+2QnVqjHMdYczRBgBUzjHmAGF8laU5r1zsuoS9E2oknkl/dyOE08
         oPiA==
X-Gm-Message-State: APf1xPAxoBvLgJMU0Su+64hyad/TblrkG0PDFFKqTlOHwp/u9s1Ll18k
        BBArpTYSGQzsiy5SYVh4gOGgdJM0n7k9MWXKVko=
X-Google-Smtp-Source: AH8x224Lw3b947eeJ/kLpAw0p55nMBS21ByT8yC477WkA1MyWw70Ctm2gWxEdG30RgH9RtcbneE5PxJHtCkQsX1urCg=
X-Received: by 10.157.14.67 with SMTP id n3mr4190689otd.337.1518001751209;
 Wed, 07 Feb 2018 03:09:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Wed, 7 Feb 2018 03:08:40 -0800 (PST)
In-Reply-To: <CABPp-BHkLLrJDTQwHTYpqC0Cg7Wv_wDr14Fq_LXneg+OzzRngg@mail.gmail.com>
References: <CABPp-BHVD19ZoAmWhQd9aN-v+qB7Ryq9Z-wobLYtJf_b6RWgzQ@mail.gmail.com>
 <CAGZ79kYstN9ATPGKZjnk-hJ6jRsx9Oz0b2hQ5cTiqVqMNDCsyA@mail.gmail.com> <CABPp-BHkLLrJDTQwHTYpqC0Cg7Wv_wDr14Fq_LXneg+OzzRngg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Feb 2018 18:08:40 +0700
Message-ID: <CACsJy8CUgmyw6Ug6wQEFaj9Ze45mZfRoE4J16zVv5usT791Kmw@mail.gmail.com>
Subject: Re: BUG: fetch in certain repo always gives "did not send all
 necessary objects"
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 7:00 AM, Elijah Newren <newren@gmail.com> wrote:
> and knew they had been using it, then I might have guessed that "HEAD"
> meant "not your actual HEAD but the HEAD of the vestige of some other
> worktree").
>
> Does anyone have pointers about what might be doable in terms of
> providing a more useful error message to allow users to recover?

I noticed this too. I was working on improving this message a bit but
got side tracked and since I figured this did not happen often
anymore, this fix got lower priority than others. I'll resume that
work.

> And/or ideas of what steps could cause corruption so I can send out a
> PSA to help users avoid it?

There is another thing we could do. One bad HEAD should not abort the
entire operation (at least if it's not the current worktree's HEAD).
We could still give a warning and move on, or don't warn at all and
let "git worktree prune" collect it (which I see from your message
that it also fails to do).

I guess that's two more items on my todo list :) Sorry for all the
trouble because of this bug of mine.

> If not, I'll try to dig more, but I thought I'd ask others familiar
> with this area.
-- 
Duy
