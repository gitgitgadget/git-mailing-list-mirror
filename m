Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88E561F453
	for <e@80x24.org>; Wed, 24 Oct 2018 11:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeJXUTS (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 16:19:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36442 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeJXUTS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 16:19:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id p125-v6so3815839oic.3
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 04:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sc+IZZhnMUpSXsZNzkFwP6CTe/OUaXzY3o5YW+NHV6I=;
        b=f9aTLZx7tu7KDQMa32flYMrsNMk3xOIW6of6JAp7hSLv1x/wpdmRdd+zO4zhr34Ejz
         ntzSgEXpw2yz096kKPaLlvNis8aMm571ses32qzdf9byLPuYq+AgVxqhss1UdB9LF2FC
         gNzk+IFyZtfdyKKzJDFwWqTkudEwjM8NQmiiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sc+IZZhnMUpSXsZNzkFwP6CTe/OUaXzY3o5YW+NHV6I=;
        b=R3UMfhfWmdUeCa76zlV8ZIS8UT42uxXx2uQ1/KXu2awEYe1wBC2E2uSJINwNFN6i1N
         PTnA1F1K3LM4qjFfTpL2neMy3fZ9bdMvgX7timiPXGxn1ApF0JqIi+rknRZJI5Jer9ek
         dVI5t8bx7emg9zdYkdGoTw2XhG9UL6ekKGjLDLITsFLb8XonjCJ8DIRZ3jcXr4IFSbzU
         JyuwI1uauZ6tTeV5fhUC5jyRRp2mvmHz36yuHM/5qyqSydM2nDXUSAz1V86p/9vh4q8z
         CKfd5BC33qQ4rH7KVlREgGBV/MopKeE0nXADykUm+i/c9BRIxhRv9bTq1nrVZCnIGlAi
         4nMA==
X-Gm-Message-State: AGRZ1gKhvGAMH+3Gp/o3kHNnxh9F5rgJKMHtoqD9jBKCXFg7Ip29tlK0
        je5oBsOMXVqr9geiaWPWgrz8kEGsiFwyJ1mfznarpA==
X-Google-Smtp-Source: AJdET5cXdsjqBLhpHB9fX4vkzTZaOoOlQJEV9kVfohkdtiM4I2WQSMRCx5PstfUNPsWnjGQ2Yy+6POUows+gCogFbsA=
X-Received: by 2002:aca:b157:: with SMTP id a84-v6mr1273233oif.289.1540381888670;
 Wed, 24 Oct 2018 04:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181015111408.17618-1-luke@diamand.org> <xmqqtvlm1pon.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvlm1pon.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 24 Oct 2018 12:51:17 +0100
Message-ID: <CAE5ih7867GCao1NWDvmcaVnui5QUYf-uMfFNhH6Zh0zztMBhuA@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] git-p4: improved unshelving - small fixes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chen Bin <chenbin.sh@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Merland Romain <merlorom@yahoo.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 16 Oct 2018 at 05:27, Junio C Hamano <gitster@pobox.com> wrote:
>
> Luke Diamand <luke@diamand.org> writes:
>
> > This is the same as my earlier patch other than fixing the
> > documentation to reflect the change to the destination branch,
> > as noticed by Junio.
>
> Also you set up when-finished driver for clean-up before running
> clone, which I think is a good change, too.
>
> Will replace.  Thanks.

At the moment the parent commit file revisions are constructed by
p4-printing the relevant files at the required version. That's because
it's easy to do - I can just make use of the existing infrastructure
for grabbing P4 changes.

However, in most cases we will already have these files present in the
git repo - it's just that we don't know where. I think it ought to be
possible to look at the revisions of each file, and then search
through the git revision history for that file to find the magic
comment marker that git-p4 inserts (which has the P4 changelist
embedded in it) and then use that - rather than going back to the
Perforce depot.

In most cases that ought to be quite a bit faster, especially for large files.

For now I'm not proposing to do this as it's quite a bit more work
(this isn't really my day job!) and for the typical use case (at least
the ones I encounter) the performance of unshelving isn't really that
important - the fact that it does it at all is quite amazing.

But anyway, if someone somewhere finds that git-p4 unshelve
performance is too slow, then that's the change to make.

Luke
