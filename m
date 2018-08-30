Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D315D1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 16:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeH3Uo2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 16:44:28 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46597 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeH3Uo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 16:44:28 -0400
Received: by mail-ua1-f65.google.com with SMTP id u11-v6so6032104uan.13
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqQBbSLQmX9IO0e+72nM0PbkVAku89FyyCKnmG+OpBk=;
        b=pKsYo7TKu8Qy7g9gErkGyt0soTxPCeuuYUFAzOX0xdgZJkqO4PsEwBZSqCg4r67v3Y
         jArw2Qg/6aYK6c6i6ZOxrOXsNeC2dFM8Zw9Jmng4L/JQy3uR4IkdoGQkwZaiJyclIYq9
         pofmmhO1jZxV0Pnxnl4lXGogV0XjTUKeSg56xgnTYeNEGyoDHTJTzeuBbAwA3o89VvbO
         w5l7TMyQmBGV0eYdcOxfk9wDNR25ZAHHkPRGJIVw/KX/fSAM99Tc0iU7Thwjq9YO0hhS
         6B9JCU8RqTY6gjw5c493KZo6hE2vYEr3LTDekN9dwOceNgcLaCb27b3qpd3zCq78Oy3K
         VVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqQBbSLQmX9IO0e+72nM0PbkVAku89FyyCKnmG+OpBk=;
        b=LqHZW7b6UQ1yOAYWcy1sq7+Q0GKyyCd+304etAWiTRqGWVL97E1Uvx/rzQHsqOgv58
         68Ap7ZaSd5ZUTMjyRfZVHZvxnthham7MA60bAH7k4OE3xhFoo2PQXeC6emuxGf2WOOY4
         8vvg3VeG+xcrzFCmjQIX7z7rpO1rVHgzrOHbeeDikFlUSg6prY1ryIItOrqWpN6ezyaJ
         e4Uo7XVWNsecsn9am3pQJjZ1B1vXFenFSP+pOAuaPMgbkvMs/ZJ8ukhwj+ZheIvdhTiz
         7tnHrWE2j9J5Uh0wLCYg1+AwhDMY4q22H8Vr32m4rhYAu8ysaqDEDMYXuc6Lt3bzoQGB
         045A==
X-Gm-Message-State: APzg51Bzv2q0Tmfol1T7+3S1HKLFQmy3bzu3mHvaW3A2VCNf9RqQ9Czy
        qMQPgMUUyJF9iA5/EFIoWuqS4LMIPWBC4Q3fh2s=
X-Google-Smtp-Source: ANB0VdbRwcnoJGva0Et62/9vfGjCEmmpro9wDNvZEAx2YU13J2M9llEiYbqTphsaDOJKHPMa/sFMlBHlxx9VzpWyH0w=
X-Received: by 2002:a67:cfcc:: with SMTP id h12-v6mr705663vsm.118.1535647287824;
 Thu, 30 Aug 2018 09:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <679370A8-E477-450D-96E5-6B1869D27576@gmail.com>
 <87in3ueiks.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1808281532220.16620@tvgsbejvaqbjf.bet>
 <CABPp-BENB=mqfFU4FGb2OS9VDV=9VdT71HhFLZwtyxD8MpdTMQ@mail.gmail.com> <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Aug 2018 09:41:16 -0700
Message-ID: <CABPp-BH8-1YQ49aaM-dXkT9ukKO92MF-FZ2kLwd=KHe4TVbjqQ@mail.gmail.com>
Subject: Re: A rebase regression in Git 2.18.0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        corrmage@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 9:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >   - Add a flag to turn off directory rename detection, and set the
> > flag for every call from am.c in order to avoid problems like this.
>
> I'd say this is the only practical solution, before you deprecate
> the "pipe format-patch output to am -3" style of "git rebase" (and
> optionally replace with something else).

I posted a patch a while back to add an --am flag to "git rebase",
make "--am" be implied by options which are still am-specific
(--whitespace, --committer-date-is-author-date, and -C), and change
--merge to be the default.

I'll post it as an RFC again after the various rebase-rewrite series
have settled and merged down...along with my other rebase cleanups
that I was waiting on to avoid conflicts with GSoC stuff.

> The whole point of "am -3" is to do _better_ than just "patch" with
> minimum amount of information available on the pre- and post- image
> blobs, without knowing the remainder of the tree that the patch did
> not touch.  It is not surprising that the heuristics that look at
> the unchanging part of the tree to infer renames that may or may not
> exist guesses incorrectly, either with false positive or negative.
> In the context of "rebase", we always have all the trees that are
> involved.  We should be able to do better than "am -3".
