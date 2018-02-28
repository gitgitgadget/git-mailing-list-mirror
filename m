Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE2E71F404
	for <e@80x24.org>; Wed, 28 Feb 2018 02:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeB1Cff (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 21:35:35 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43076 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbeB1Cfe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 21:35:34 -0500
Received: by mail-wr0-f194.google.com with SMTP id u49so780263wrc.10
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 18:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cj0pZMCI/gl5ocm8RenrZNMF+lgSa2rxISszZ5IsHA4=;
        b=anCFPeBsEq+FZELJ0ZDbL/oR2HhWN3gS1Thfq0Zoh+6U0Og3C8soJHsMkeHXXk08PN
         bO4iTFOYws0lGb2VYuWxv3PccN9p1kEu/9IlEalBxCF+Xon82+vmoUNK1/tZAUhhrbdf
         tbhbdKn9bsRnQn0KrgpIZ6G67ooZOf5C3hm6FUQmzRiQs6DYA+KWdSh0DU+C9OD/6ePB
         BDpakvzSRBSaAzLWfcH3c3QdoylWCLuUGR3cKJQjvFTuZ4qCsuZOlIdvF079sq+i1j7N
         RCmfzWZ1hk9HWU/YXkKW14WfqmqeMipleRt9dOQNiwXeu+zKLd8Vm/TASlqEuKz0vNra
         cBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cj0pZMCI/gl5ocm8RenrZNMF+lgSa2rxISszZ5IsHA4=;
        b=cAhjx/fUHavIi5/X1s9MQ41rT54Kq7hVMyOGPKOBSaajWjcuci0Q3WnqZNTGp+sZtF
         q1GhEeMBlMCw672EPl27x3ywR3P/UO7Kg16P6p6ODs2NjhT+E+fKXZYd4eBcYD33mHI2
         Q2WqkslJAKvABj7IUq/YqnsT+mkwJSkmoYYCm7F7Q38I7+Z0KTfU46RRddylxXwOFn6+
         mdlrtun6dUvAfsup1ugTZGE9Ca51JE5GGAu+iSaF1ytGi9Fg6TX0RzrSBUmI+LdwjbFb
         tdFkUDKIzj3BWvJvwFmlU+Hqx+aRcp3dftJ875VQ3mv7YYD/Hhikj9p/GXNq1lfAfnFs
         ldFQ==
X-Gm-Message-State: APf1xPAenm+niPZJx7ujP8nvdbl+hmECS1Vdk+0DuEZytTqS1xzftudm
        grGLLxeUoKf+ndl1s7S39P0=
X-Google-Smtp-Source: AH8x224dbhGX1sba0nlIXOjTpdU+Wg51FfrziLvyYnRp2VjfKLeip0VHJkHlACeW+3T4rCWzzLEuUQ==
X-Received: by 10.223.136.164 with SMTP id f33mr14085580wrf.77.1519785332907;
        Tue, 27 Feb 2018 18:35:32 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 7sm1704729wry.18.2018.02.27.18.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 18:35:32 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
 <xmqqwoyym0ry.fsf@gitster-ct.c.googlers.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <40fcf205-104e-b1e7-02af-0429866d0342@gmail.com>
Date:   Wed, 28 Feb 2018 03:35:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqwoyym0ry.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 28/02/2018 01:10, Junio C Hamano wrote:
> 
> > > (3) ---X1---o---o---o---o---o---X2
> > >        |\                       |\
> > >        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
> > >        |             \          |
> > >        |              M         |
> > >        |             /          |
> > >        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
> > >
> >
> > Meh, I hope I`m rushing it now, but for example, if we had decided to 
> > drop commit A2 during an interactive rebase (so losing A2' from 
> > diagram above), wouldn`t U2' still introduce those changes back, once 
> > U1' and U2' are merged, being incorrect/unwanted behavior...? :/
> 
> As long as we are talking about rebase that allows us users to
> adjust and make changes ("rebase -i" being the prime and most
> flexible example), it is easy to imagine that A1'--A3' and B1'--B3'
> have almost no relation to their original counterparts.  After all,
> mechanical merge won't be able to guess the intention of the change
> humans make, so depending on what happend during X1 and X2 that
> happend outside of these two topics, what's required to bring series
> A and B to series A' and B' can be unlimited.  So from that alone,
> it should be clear that replaying difference between M and A3 (and M
> and B3) on top of U1' and U2' is hopeless as a general solution.

Yeah, I`ve encountered it in my (trivial) test case :(

> It is acceptable as long as a solution fails loudly when it does the
> wrong thing, but I do not think the apporach can produce incorrect
> result silently, as your example shows above.

Hmm, I think my example doesn`t even try to prevent failing, but it 
should otherwise be perfectly capable of doing so (and doing it 
loudly) - for example, it`s enough to diff U1' and U2' - if not the 
same, user might want to confirm the "rebased" merge outcome, as 
either something went wrong, or interactive rebase happened... or 
both :) (it`s what Sergey originally explained, seeming to be a solid 
safety net, though more testing would be good)

> What you _COULD_ learn from an old merge is to compute:
> 
>     - a trial and mechanical merge between A3 and B3; call that pre-M
> 
>     - diff to bring pre-M to M (call that patch evil-M); which is
>       what the person who made M did to resolve the textual and
>       semantic conflicts necessary to merge these two topics.
> 
> Then when merging A3' and B3', you could try to mechanically merge
> them (call that pre-M'), and apply evil-M, which may apply cleanly
> on top of pre-M', or it may not.  When there aren't so huge a
> difference between series A and A' (and series B and B'), the result
> would probably be a moral equivalent of Sergay's "replay" (so this
> approach will also silently produce a wrong result without human
> supervision).  One edge the evil-M approach has over Sergey's "dual
> cherry pick" is that it separates and highlights non-mechanical
> conflict resolution out of mechanical merges in a human readable
> form (i.e. the patch evil-M).

This seems to be what Johannes wrote about[1], too, but also 
something I think would be good to avoid, if possible, not 
complicating it too much :P

Maybe something like that latest thought[2] could help, using 
additional R1 and R2 commits to handle interactive rebase 
additions/amendments/drops, on top of U1' and U2'? Yeah, and 
that`s not complicating it... ;) :D

Regards, Buga

[1] https://public-inbox.org/git/nycvar.QRO.7.76.6.1802272330290.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/
[2] https://public-inbox.org/git/8829c395-fb84-2db0-9288-f7b28fa0d0d1@gmail.com/
