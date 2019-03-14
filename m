Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D330F20248
	for <e@80x24.org>; Thu, 14 Mar 2019 14:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfCNObX (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 10:31:23 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54450 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfCNObX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 10:31:23 -0400
Received: by mail-it1-f196.google.com with SMTP id w18so4963666itj.4
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouXMyYgb0AbUXKCYpE4gZNSagIsCy4OFDlIgrWAIyxo=;
        b=RpWlhGREEUpaWTmr1Vy8L5NmQzrEldLZbesx6rSr2hSdWhqXT8Z0/IdWuHFvnicjPq
         87sW5muZqFBUpe9Mq/YIKVSLD7q1sGKeDq57D/vt3Zqei4iUa2Fqbuxse6APo6SfjKWr
         LSyZXG03QUHci2jLXmAj+fqWr0op+0ecOivDeHVs0y6bFTi47pr6EigqBk82EovVXQVY
         yOou963mvZ/QyW9pWSkYnmwTyNCoeRfnpvRBS2Gig3HexxOPNMnNz8vqUvDp0AwrOYm6
         va/GI3U8yUC0FrEbZ+EM/gCaHoQmbhUABaEFPzpSHne8qk/s/G2GtI1MM/rqC4zaYUQd
         h1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouXMyYgb0AbUXKCYpE4gZNSagIsCy4OFDlIgrWAIyxo=;
        b=VXPRjHGHVdMOGXQkkdNy5ZfG1oyRgoKV6jRgGlFloZrkb6Djnv8mj52tmEJu8uCNlo
         51y+adFyi+aGsu/a5+nNhiH+YM/B1A6GM7ZPoG98c8nlKC6S09Zh63tMkpKi5Tf5ZOdc
         Os8VJQ6hFErwg0J+YFJagcDIiP6Tmdb6qThAGVbNemLtlRwW5GAaztI4eNrckNwEJ2IO
         FlxW6T5PdTvTGM2lN+2cTHSlLT8dsEWL0iUhzc7TpmVAWRvkU79ibKD2XCCgvbBDdXfs
         KWIyb0i/cC46MB8Yun2dQnZ8w7Vn0EeSlTvbLcA5ESpLSAj2SDcgGMYg1L1pq7MSn/mo
         SeBQ==
X-Gm-Message-State: APjAAAVgy2VaJubWcI2XmxJcRBGFe2QWoc8wXVqlN7rcUE2PiEClcL1O
        YVYuqZ54M+b2OMJ2N5TZ49T7CqdJZlLpiK79yvY=
X-Google-Smtp-Source: APXvYqwqswMjq6onHWJnZlUAuSCbFyusPCnVtKQAdwYTJSTVZK7lZCUgcz/kRGYNb/n5aJMDcQbysL4YybasiRh1jmw=
X-Received: by 2002:a24:7542:: with SMTP id y63mr2214012itc.70.1552573879399;
 Thu, 14 Mar 2019 07:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190313182615.7351-1-phillip.wood123@gmail.com>
 <20190313182615.7351-3-phillip.wood123@gmail.com> <nycvar.QRO.7.76.6.1903132344350.41@tvgsbejvaqbjf.bet>
 <xmqqimwm9hh5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1903141432000.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1903141432000.41@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 14 Mar 2019 21:30:53 +0700
Message-ID: <CACsJy8DCZLNNa9zFj04kPx=f1S_5VJqqP_qTK6QYJ0fFmusymg@mail.gmail.com>
Subject: Re: separating regression test patches from fixes, was Re: [PATCH
 3/3] cherry-pick --continue: remember options
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 9:10 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> In any case, before we get better tooling to work around these issues, I
> still think it makes a ton of sense to encourage proper separation of
> concerns: to keep patches that introduce regression tests demonstrating a
> breakage separate from patches that fix the breakage. It would certainly
> help me (e.g. when staring at a range diff).

Then perhaps improve the tools now because these separate patches
enter 'master' and stay in the history forever. One of the problems I
have with separating tests from the actual code change is the
description of the problem often stays on the test commit, which I
can't see in git-log if I'm searching for the code change. And no
sometimes I can't just look at the parent commit if I filter code by
path (and with --full-diff)
-- 
Duy
