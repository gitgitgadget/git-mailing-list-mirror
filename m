Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89FC91F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965864AbeF0SfF (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:35:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33993 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965823AbeF0SfE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:35:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id l15-v6so18740949wmc.1
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5fxKY7Wx3DejbSumeQjtpZmS72KbHe7tD2JgGbmeiM=;
        b=raV0O74Owbq2qBsG7UHJcTRMC9+v5tDOYssBs8OLshIJAsnyOP3Nz5efnZHFmVHqQ0
         jMukXTwiFslx+hGa88RhFNIMA9yE+Z73bOtsxMEXajFXFh1EgAuOrl+TtRyBr/7nKRWP
         NBHFtDwiflgnRL/eDeBEp9rEcUHJv4LapRDG198yWjx+MeeWCpmn2cbOv++2BTVDLLd1
         nuxRJS+2GSu7uiKkBSc0DZ6XBzBlVhn4UIJojH//7b8EqibFyjEXitrXAuVxOxq6j1b9
         GtilomFW5pyuHxqQWlsLjr4vywZn4ORFF0X5QyOmjFn9NLMnmK6g9fiBQ4g7kx+PLe4P
         gVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5fxKY7Wx3DejbSumeQjtpZmS72KbHe7tD2JgGbmeiM=;
        b=Fl+zVL6+wH6hlsl8XgHjQ6IZMPIKF+BT9PlF6v3xD+ub/9GdLsAqHSypx/aFwU2cKJ
         tfCFnuaU0WPFho39wGoSxKZld2IbIl0pIgz+tOYxXDMKaAAAqSIFYQ7p2HEVxdqPGnN6
         6kKLelhsEHbulZHduTxPJgx63ASr58Ptkj+HjB5FUMERibKmmxj+mJuJEcuu7kZ83eWB
         lIl4/KmMEnoEUreZ4AcgirIUCnERh6I8zBn/PyvuWdxXnlutE90j0S8pT6v9oEh5CgNB
         VMDVJDsl44iPGoiU7uVMNG8QR4znsEB+iaW8x+N9Yct+6qyGFpWpAicDxitBl0QF4hAE
         oL6w==
X-Gm-Message-State: APt69E05XbVmYQz1p05FMWVIUw9fU/LUwWF6Q6QaXl5s4shPxtP1ffZM
        U3YY8wWWRiGxVz0iSptIpK8=
X-Google-Smtp-Source: AAOMgpf8wjNfx+qWmnWYdEQB+swJMQy2gx6I38BTMqbe3qGCFNOUF/L+A/cl3jwij10FgrplNP1c2g==
X-Received: by 2002:a1c:7141:: with SMTP id m62-v6mr5702179wmc.157.1530124503684;
        Wed, 27 Jun 2018 11:35:03 -0700 (PDT)
Received: from localhost.localdomain (x590e4475.dyn.telefonica.de. [89.14.68.117])
        by smtp.gmail.com with ESMTPSA id s2-v6sm6153111wro.42.2018.06.27.11.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 11:35:02 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] t3418: add testcase showing problems with rebase
Date:   Wed, 27 Jun 2018 20:34:45 +0200
Message-Id: <20180627183445.28625-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <eb66b6da-a306-3f65-abf3-9b845fba32cd@kdbg.org>
References: <20180607050845.19779-1-newren@gmail.com> <20180627073623.31725-1-newren@gmail.com> <20180627073623.31725-2-newren@gmail.com> <CAPig+cTwwuqPgF2NtGRgpcdjFqJK22+FFDV2c-20oQXFLEPaWQ@mail.gmail.com> <CABPp-BFkjF5z6axqW-v=zPq9U9sOQGpUKK+WvLknkkGzX-F4rA@mail.gmail.com> <xmqqh8logofg.fsf@gitster-ct.c.googlers.com> <CABPp-BEYbC0C+bczQuNTcC_jxVM59czh7HTpqi9dv09fvCjMrA@mail.gmail.com> <eb66b6da-a306-3f65-abf3-9b845fba32cd@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Am 27.06.2018 um 19:27 schrieb Elijah Newren:
> > On Wed, Jun 27, 2018 at 9:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Having said that, it would be simpler for at least the latter to
> >> write it using a single-shot environment assignment, perhaps?  I.e.
> >>
> >>          PATH=./test-bin:$PATH git rebase --continue &&
> >>
> >> without running in a subshell?
> > 
> > Seems reasonable.  Since these tests were essentially copies of other
> > tests within the same file, just for rebase -i instead of -m, should I
> > also add another patch to the series fixing up the rebase -m testcase
> > to also replace the subshell with a single-shot environment
> > assignment?
> 
> Pitfalls ahead!
> 
> 	PATH=... git rebase ...
> 
> is OK, but
> 
> 	PATH=... test_must_fail git rebase ...
> 
> is not; the latter requires the subshell, otherwise the modified PATH 
> variable survives the command because test_must_fail is a shell 
> function. Yes, it's silly, but that's how it is.

We have the 'test_env' helper function for this case:

  test_env PATH=./test-bin:$PATH test_must_fail git rebase --opts

