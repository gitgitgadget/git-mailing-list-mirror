Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF791F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 16:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbdBCQBo (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 11:01:44 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:37364 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdBCQBn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 11:01:43 -0500
Received: by mail-it0-f50.google.com with SMTP id r185so14951817ita.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 08:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=genarts-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2EiSw4qUvuUpQ4jt072o4Q4ZuKRWmhW1YmD2xwDpts4=;
        b=YTraDxw28Nt8eYgWckYQQGAMZXs/nD4xMKRabwH7Ge6ruIjUhS+32zFRE597aMnp2J
         K5f8MMpqukUGpZdnHhVgcje7E1U5LawTiRCzqqAkTqnx80W62dC7T9WcUDPC5Ypn/nkK
         SUelX0bCTLQEVVuYbWQsePMSAs1hfsdFPgM7We/ABF3NzsyvkwI0UbWJ4+jkQVtW5ZP4
         tQh8wG9LK1B2gCbyhFeBN/ob5Q6UTEAfygbv82YtWrcQ1USrDOHJdwFQGTuDp7GBc0fg
         xE76qGyuA2/O5sfCeuccqEOvCk5H1K5SJYkGgGDKRUCkJUi8NHxgFyCjSp4TNjRbkqwc
         xm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2EiSw4qUvuUpQ4jt072o4Q4ZuKRWmhW1YmD2xwDpts4=;
        b=XTCDNxPJy5z3ytXZgCWy7/n0VvVNrLNZ3htG6Pru1fmpU6PU7lJvSnwZ3fQDZglk0y
         CwPijtW/UcAsec/GqzQ4ICukUMctB7zexu/Gr46s5K8ZgMcqDQuHXRDf8ZuaIIVg3Ktp
         l0muwGBNYjVoC3BwASqdhQrCoUYEg4S5nCskGr9AyQYx3sp96H8yfSjnyxVfSnpt2aO0
         9L77cqQnDaFHOzK8FIk+epE/8xgO4Hge55TQWRb7hhojf0+Cz5yHKC6IF1TIa+0HbQQm
         bxokhhh7tPcIPalPL0qQ3xzGlszdnHMZkBTsC9/fVYph7gOHxrPA4O/PCUqcnf5R8cS7
         fc1Q==
X-Gm-Message-State: AIkVDXK2kgqpHQq0i/RwDL0TQBNA3tFN03quM4qTMnaHv2wGYTnV3qArXLbwRPVZGHAy0yRqTw0d5lBCXe76bzCu
X-Received: by 10.36.73.211 with SMTP id e80mr1522361itd.88.1486137670802;
 Fri, 03 Feb 2017 08:01:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.34.159 with HTTP; Fri, 3 Feb 2017 08:01:10 -0800 (PST)
From:   Stephen Bash <bash@genarts.com>
Date:   Fri, 3 Feb 2017 11:01:10 -0500
Message-ID: <CAAyCa8k4zfv7thRsX+5M8TGQ+2U3nfj_tTN_pZPe8jQb6mPJrQ@mail.gmail.com>
Subject: Fail git pull --rebase when local merges present? (was: [ANNOUNCE]
 Git v2.11.1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2017 at 6:05 PM, Junio C Hamano <gitster@pobox.com> wrote:

>  * "git pull --rebase", when there is no new commits on our side since
>    we forked from the upstream, should be able to fast-forward without
>    invoking "git rebase", but it didn't.

As someone who has to mentor new developers to Git at my $dayjob, this
is really nice!  Thanks!

Slightly related (in that it's a pitfall of *always* using pull
--rebase), does anyone know if there is a way to make git pull
--rebase fail if there's a local merge?  For our workflow I'd like to
tell new people to just default to pull --rebase, but having to add
(and explain) the "don't rebase a merge" caveat tends to lose them...
(yes we mix merge and rebase; it works for us... most of the time)

Thanks,
Stephen
