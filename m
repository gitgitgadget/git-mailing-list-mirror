Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A788202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 22:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933685AbdKAWxZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:53:25 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:45545 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933336AbdKAWxY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:53:24 -0400
Received: by mail-qt0-f178.google.com with SMTP id p1so4662589qtg.2
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JFuslRQcsN8ZHYxokPuNjk9ZoJ//FSq6QBIMbf523l8=;
        b=uszEo72sXADQAcW8kFa4Z/BQqpwy7JF8f2GHj+3wG0oTRZBcI+bgZvVQC58ZTVrJAl
         jcCFWJXO36r4p5ma95VDpOOVzGP/YigkIwQok6QU16KSWbTFkMutTW+fc2WP55f3+eqW
         VUpORZzMwb1/kI5mMqjo5pgCh4EJu/OoGypnsNxGKI8SuWU6TcvxjnDBekilD6vsygBe
         CAQNyCfUnc9ifXCWhwwipXZZjfj+sCq1sZ7guTwrJnT7oeG5dtkx0/8uSGDUqaMdqzu2
         wIOoa+J5DzJi8kooJFKG2GunCeukIb0lTobYvDn7UvR18n8elwsAAo9awUg6JxlHh5n3
         spoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JFuslRQcsN8ZHYxokPuNjk9ZoJ//FSq6QBIMbf523l8=;
        b=XGLs/Fz+ITiGb2VVwT6RvAWI8L200rYwAi36UAY3rYJ98LyUeILhk95WfoKndojDTh
         yyX79AMPMSI+B+fjSMgxElS1xDAYgydkUXxPOxrMDc9bOJXKoJLY7Xh7qrirafPXkh/A
         DmbjfywhQjHmrrjww27vvqJ0aVbZsqdREzySD7kHcXcrtbPY2QxP5OktQ6fH3Qd757nw
         btSihPM29H5r3z7Mar9c0qvAIgTduXjyTEXSikPuXzPpyRSCD+IIAJ+ZA3XXsPp01zp1
         2umy9PYXatn4AClDK/V6pObtwlLUnWDZjhTa/bXmY+5TCM3C/KGj1vonx4MozQRs0gxn
         JPeA==
X-Gm-Message-State: AMCzsaVTIxuGT16VpPgqcOoIWN3BIaOoAdQHbQpufvcKkheY6oyZ3lWN
        vpwk1ElHjQ4kON7Kzt2cyr1YjeJ82qsNvN8kyCA30eQG
X-Google-Smtp-Source: ABhQp+STXtbaXk1qN4aY/12LkHGYBUU7TtkSIuhWux3sKq4a85OVINUpz5QB93/KMYS/zdNQ+xchqtsGBcjnOzOo7eQ=
X-Received: by 10.200.40.146 with SMTP id i18mr2349539qti.79.1509576803400;
 Wed, 01 Nov 2017 15:53:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 15:53:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1711012340290.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-7-sbeller@google.com> <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711011329300.6482@virtualbox> <CAGZ79kZPNiNnSJd6CNYb7XkTVsT2ONLQLhwAQxt6_SPFTSwMcw@mail.gmail.com>
 <EF573E5E-EA72-4DEE-822C-B44265FD581B@gmail.com> <alpine.DEB.2.21.1.1711012310250.6482@virtualbox>
 <CAGZ79kbOEM_W65Rym4yiDNHpFGTNWMYdh=aVPjThNWjEHPQong@mail.gmail.com> <alpine.DEB.2.21.1.1711012340290.6482@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 15:53:22 -0700
Message-ID: <CAGZ79ka2Taie+SVjw6poi=ejFMRV5MSBUGBUnCtn+KTdXRzGbg@mail.gmail.com>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 1, 2017 at 3:41 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>> The current implementation gives C, though.
>> (assuming C is HEAD, and A is ancient)
>>
>> With the --reverse flag one of B or D is given (not sure which,
>> depends on the exact order).
>
> Sure, but it is still a tricky thing. Imagine
>
> - A1 - B1 - A2 - B2 - B3
>
> where all the B* commits have the blob. Do you really want to report B1
> rather than B2 as the commit introducing the blob? (I would prefer B2...)

You are correct, that B2 is also important to find.

Ideally you want a list of all adjacent commit groups, but that is too
tricky to implement for now, deferring it to another contribution in the future.

The current proposal would give you B3, such that `git log B3 -- path` will find
you B2.
