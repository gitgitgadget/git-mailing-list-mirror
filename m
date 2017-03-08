Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DFB2202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 20:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754520AbdCHUde (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 15:33:34 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:32973 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754502AbdCHUdb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 15:33:31 -0500
Received: by mail-pg0-f47.google.com with SMTP id 25so17199325pgy.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 12:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9Lo4bEH0PQIGLDY7Q8IvXml+LooNh6eGSXJnYpzB8L8=;
        b=dgGyQZcIdJJ5f9lkWDo67E1xPnzZgeR+YXL4+unniEyLCv8a/k/bQ/glOgbKPiAf8S
         7Ebp3I88TOXSjaEWqt6ZSEukPhGoB16RmgQdBE1g0XI/AmTs/dH4gHGeBWJ2N4qolx5M
         d5xoN6/3buKK/Y58ix2wxz6d/TLCG+S+6S+K9nAX3ucqxI/rdpP0/tJ7CzOJsXMo3kr0
         Mn89PKjKD0LPp2xM1Em9KXvg1c5KBYh8idqm8yyQgRArFOpAycWUPvmRT0epoI3G7U6l
         Z5jOuy4oWQm/mAHHOBdrmKGVpthyDUTgtyNbQQTDu1xyZvheR6GIVtp+blJOJG5JroNz
         BSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9Lo4bEH0PQIGLDY7Q8IvXml+LooNh6eGSXJnYpzB8L8=;
        b=KPhTz/egzS1iV7GHTWF2hMvwzIjqI26xo4mf1F/VleOcjqI1GipZ9SQONNtkFJkKeb
         /hCGa63We+GRHxDdWpy+Yqj39yMT+kvO5in5lZK1ga5RjKoSEWI8uqWeTiW65UD8RXiM
         ogqrS3vJyXaRKXLpvDumStEufloWBv/vfu9u9YjXMhpXNKcPSsG5Xqu2rC5TAJqku2+B
         15utEBUkoleRR4u96mlMX2Fi/ayBKViNSH+6CxdtNCbJ8yyHxDbbGJUudFUWvA7gtYOR
         GNxcv3NfSS6eEeJg9SmG8egedPwzO0EpxLgrKfpgYYOzOzEiWRFIjRdP4ULvB2lXHHun
         IsZw==
X-Gm-Message-State: AMke39mJuaKbSmw5p1dkaj3nUQGWUGntmDJ+xAzOOZ1VClZqNG8uPLMrIZUezLqH3rvuVuuNLKzt1B6ACZ6ef6fT
X-Received: by 10.84.128.74 with SMTP id 68mr11582661pla.111.1489004721703;
 Wed, 08 Mar 2017 12:25:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 8 Mar 2017 12:25:21 -0800 (PST)
In-Reply-To: <20170308195916.7349-1-me@vtolstov.org>
References: <CAGZ79kYJ9he-jhnA35m6az-T5Z58efmKsUaBw--_KzdGJPZb-Q@mail.gmail.com>
 <20170308195916.7349-1-me@vtolstov.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Mar 2017 12:25:21 -0800
Message-ID: <CAGZ79kbnpUtrKdjQdQ-r6rRuVvnawooLFk1bO8jOSgxNkx2Dbg@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper.c: remove duplicate code
To:     Valery Tolstov <me@vtolstov.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 11:59 AM, Valery Tolstov <me@vtolstov.org> wrote:
>> Maybe we need to have 2293f77a081
>> (connect_work_tree_and_git_dir: safely create leading directories,
>> part of origin/sb/checkout-recurse-submodules, also found at
>> https://public-inbox.org/git/20170306205919.9713-8-sbeller@google.com/ )
>> first before we can apply this patch.
>
> Thank you for your detailed responses. Yes, we difenitely need this
> patch first. All tests passed when I applied it.
>

Thanks for testing!

Then the next step (as outlined by Documentation/SubmittingPatches)
is to figure out how to best present this to the mailing list; I think the best
way is to send out a patch series consisting of both of these 2 patches,
the "connect_work_tree_and_git_dir: safely create leading directories,"
first and then your deduplication patch.

When applied in that order, then git passes the test suite  at all commits
(which is very nice when using e.g. git-bisect on git).

Thanks,
Stefan
