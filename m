Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99841F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 18:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbdBCSZd (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 13:25:33 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32993 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbdBCSZb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 13:25:31 -0500
Received: by mail-pg0-f65.google.com with SMTP id 194so2589618pgd.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 10:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+CcstAIHLSX4+wOcCclAbBortA8iP1lA2lCUr5nx1qw=;
        b=JrgYUho2+vONLtVwwOILJ5ShTWZkozwFlY6cadyS006tIaYBkNsJqI+iTMEC62Tak0
         WXTfUf0Ib+ZEdEHNGfyRR9TezV26oFGuHuDFCRZdILRxxOqhiz9eFI2ZQ5ugxSujBQHD
         z2cHPyX2kcOymI5FyAw/cFzuB+VOx4WEuly98btzV+LqkJZU6BhQfRWyejmtRg0WLfTY
         PBCB1KhOH9bAx6czFrQYj8H2yL75E6S8KbrlKovnHMDSiO0kqWR9xXG5W7/tL7dZPpBe
         iPhdDFKAqbyfWXosbuJacF/0jy3HjinekCVfttM6PG3zdveh3hzb57t0a9X/7CZ7Uq0t
         7TFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+CcstAIHLSX4+wOcCclAbBortA8iP1lA2lCUr5nx1qw=;
        b=MJWVLAoPfE0RccvGCUZYrD8gAxNH1muFE3PLAW2PXP0vc3JB69oEYqK3xU9u6MNc3z
         SrkpMoh8J8ilIX4hvTQmDAuftVwlo/9kuujbNpCYUnDts1NqrmrfgjZKDiJbE/zlAHZW
         iTcnLzYKgyWICt5NazYlVt+wirSjlicLch+6ECkzWIugWud9oZ5b10cyABoz19gUKZjg
         RH1fENcuG1mi/bqJ/YttLoc1mHcGDQsnnEB4WaD7UtTF0yDqJRfH63rxfHoBIhuZlWHN
         N5v2vEJ3smCtkn88twvuGFX6To0UxXxsXxKH41sD0m5SftOYPx7BPH3MK42KCcVcPcE5
         SIQw==
X-Gm-Message-State: AIkVDXIvHQX+wXrOo3JvbbXGBs2udGHZVjIorAJzfZ4j3yXVx20AdSbaY46SwAIVo525wA==
X-Received: by 10.99.124.75 with SMTP id l11mr19554200pgn.46.1486146325960;
        Fri, 03 Feb 2017 10:25:25 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd9f:576d:b8fa:253a])
        by smtp.gmail.com with ESMTPSA id n8sm43084311pgc.16.2017.02.03.10.25.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Feb 2017 10:25:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/11] nd/worktree-move update
References: <20170202085007.21418-1-pclouds@gmail.com>
        <alpine.DEB.2.20.1702021015160.3496@virtualbox>
        <CACsJy8B3bdokeYVt6aEyZVSzO50PiQRn+0sid9mSDTZ9q-mnww@mail.gmail.com>
        <alpine.DEB.2.20.1702021043110.3496@virtualbox>
        <CACsJy8A-tuea7W+tj6rNddtM0j_374FODjQqKsT8eHfeZ0qDZg@mail.gmail.com>
        <alpine.DEB.2.20.1702021136210.3496@virtualbox>
        <CACsJy8CBG_a_nX_syXKrdG2-ren=NO9CNxe6tm94FGnEo1HZLQ@mail.gmail.com>
        <alpine.DEB.2.20.1702021223320.3496@virtualbox>
        <alpine.DEB.2.20.1702021330040.3496@virtualbox>
        <xmqqmve4s5r2.fsf@gitster.mtv.corp.google.com>
        <CACsJy8Cq8sY1hL75Xs_MMr9r_+jjr7p+58D+0GhT3mgSgiUEtg@mail.gmail.com>
Date:   Fri, 03 Feb 2017 10:25:24 -0800
In-Reply-To: <CACsJy8Cq8sY1hL75Xs_MMr9r_+jjr7p+58D+0GhT3mgSgiUEtg@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 3 Feb 2017 15:59:25 +0700")
Message-ID: <xmqqtw8bf7xn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Feb 3, 2017 at 3:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> Also, the more important reply was Peff's reply that suggested that the
>>> proposed fix was incomplete, as it misses --unpack-unreachable:
>>> https://public-inbox.org/git/20160601160143.GA9219@sigill.intra.peff.net/
>>
>> While I think that --unpack-unreachable thing is a symptom of the
>> basic approach of patching things up at the wrong level, if you are
>> hinting that fix to the issue that gc does not pay attention to
>> various anchoring point in other worktrees is more important than
>> adding new commands to "worktree", I fully agree with that.
>
> Just to make it clear. It's not like I put new worktree commands on
> higher priority.

Good; we are on the same page.

> "worktree move/remove" was more or less ready for a
> long time and the gc problem was blocked by ref-iterator series (which
> entered master a few moths ago, but then I was busy with other things
> and couldn't get right back to the gc issue).

OK.

> You didn't answer Johannes's rhetoric question though: "It should be
> possible to do that redesign work while having a small workaround in
> place that unbreaks, say, me?"

I do not recall seeing that.  I however deliberately ignored another
statement because I thought it enough to answer, which was:

    Given that
    https://public-inbox.org/git/xmqqy46ntrhk.fsf@gitster.mtv.corp.google.com/
    seems to have expected something to happen within a reasonable time frame,
    and that 8 months is substantially longer than a reasonable time frame, I
    am not sure that that position can still be defended.

In the message xmqqy46ntrhk is a response to, Michael enumerated the
issues need to be solved with priorities, and listed reachability
from the index and per-worktree detached HEAD are more important
than others.  I was hoping that even these "relatively more
important" ones would turn out be of less importance compared to
fixing all on the right foundation as long as it won't take forever,
but I do agree with Dscho that 8 months is way too long.

> I assume "the right way" is still updating refs subsystem so that we
> can have a ref iterator to traverse all refs, or just one worktree,
> etc. Should I keep looking for a middle ground (maybe better than the
> linked series) to "unbreak Johannes"? I ignored all those comments
> (about --unpack-reachable and bisect refs) because I saw no chance of
> an updated series getting in git.git anyway.

So, you may have seen no chance 8 months ago; after we have been
waiting for a better fix, which hadn't materialized for a while, I
am very much open to change the priority.

Even if you think "the right way" is to add to the iterators, I
suspect that we can still do incremental fixes?  I agree with the
order of importance Michael listed in his message (i.e. the index
and the HEAD first, and then other per-worktree hierarchies at lower
priority), and I suspect you do, too.  I am not sure that is what
you called "middle ground", but I think such an incremental approach
is totally fine.

