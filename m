Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1131E1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 18:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751942AbeDIS0I (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 14:26:08 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:41092 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbeDIS0H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 14:26:07 -0400
Received: by mail-yb0-f169.google.com with SMTP id p126-v6so3359584ybg.8
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pVpyk2I75wn5olaUrSNxa1BY2WQbCw91JpgPnpB4HGs=;
        b=C5LwAJBoAxQMC9o2wikv0huMAvjjKo5baKkfFDD96dIKBcds2TVwBM9B2xTk0NWVp5
         dFDoGle5kDcFDLcs+md2f3gKL+eQbGJr2N45NvTzKJai4emvMIy6yhcpiYuwF1jHDe90
         7mKUmKhHs5pjvWXlQD2O4xgo6q1DgD5mHnbzPvlwKPHz4YozVeo7h4voxZgaulxOz0ON
         /CyuwkFum7WWUN2jsIR+o9oQzolFqNITD7VoMJUOyxi6hn5XMEDSm9Q9IJgUhJdjuPLX
         0o+Il7NYQVG/f8bL+vZAzScU9xM07yWa6mIj6gvFCmGNloyMxWyfGwCwQq4gyUiQkwuG
         p2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=pVpyk2I75wn5olaUrSNxa1BY2WQbCw91JpgPnpB4HGs=;
        b=QTX4AJAoqKqz1P5sWj+EzeLbEVfcuh16kDMkWlxePo/a0zq4cvgzs0/AzS9OjnUdqu
         ixULXmczQGnpORIzAwA/qKNVxt1QtRlkAokMkuqa+vI7K94d7fcvFUzbKFwzjDthDh13
         KVf9L4aMTXZ082R1GnDOPdBxuc7MKqbaEtdHgEiVpMWDKzR7YMSDtjfPYz4cq+vA3MfJ
         PoBNqcTgORb1M+tr58uPsuiLSeSLlVxXO9hqWGOWZ4/cYnra++maMnNEAVl7bBmAnl6E
         foRPoaRwTFV0Okkx+R0pMYSuUrS7PCUxwzhPzk4EqHuiXlubJTDD8sT7J0eDQ0PvxdUD
         JGxA==
X-Gm-Message-State: ALQs6tDLvX6ojysutkDKYq1/aij7mNPrFAq2Bqv29COvHifT3kNemcAA
        0jZF5pCt5ZEP+P1zcAuvCgnsXAC01E2Xf6M9PMKPTVVA
X-Google-Smtp-Source: AIpwx48BXTxPHV0piV0V4J8IM7R/J7hq+JmMJVskyCPjjooxdu+LCvSZdoPqdylIWSDeQL9WTqH5UWieupZ/ckhY5mw=
X-Received: by 2002:a25:2704:: with SMTP id n4-v6mr20254985ybn.167.1523298365918;
 Mon, 09 Apr 2018 11:26:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 9 Apr 2018 11:26:05 -0700 (PDT)
In-Reply-To: <20180408182552.26289-2-mail@floga.de>
References: <20180408182552.26289-1-mail@floga.de> <20180408182552.26289-2-mail@floga.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Apr 2018 11:26:05 -0700
Message-ID: <CAGZ79kZzMDjKzuHn5ph+zMkh_9Zt_at37MssOjHvzJndUjt9yQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] completion: Load completion file for external subcommand
To:     git <git@vger.kernel.org>,
        =?UTF-8?Q?Szeder_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 8, 2018 at 11:26 AM, Florian Gamb=C3=B6ck <mail@floga.de> wrote=
:
> Adding external subcommands to Git is as easy as to put an executable
> file git-foo into PATH. Packaging such subcommands for a Linux
> distribution can be achieved by unpacking the executable into /usr/bin
> of the user's system. Adding system-wide completion scripts for new
> subcommands, however, can be a bit tricky.
>
> Since bash-completion started to use dynamical loading of completion
> scripts somewhere around v2.0, it is no longer sufficient to drop a
> completion script of a subcommand into the standard completions path,
> /usr/share/bash-completion/completions, since this script will not be
> loaded if called as a git subcommand.

Also v1.90 here? (hint from the cover letter, please be exact)

If Gits own completion script would be broken up by subcommand,
would that also deliver an improvement in performance?

Thanks,
Stefan
