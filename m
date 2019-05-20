Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1E7F1F461
	for <e@80x24.org>; Mon, 20 May 2019 10:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbfETKDo (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 06:03:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44436 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729834AbfETKDo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 06:03:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id b8so22927715edm.11
        for <git@vger.kernel.org>; Mon, 20 May 2019 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=At2usxGR4GQUXIXsCHuThhiPVkb38P38V3WYBksOqJ8=;
        b=J5BKci+PWPUEg6FO7kD/QQz9SlUNXly8BpbSE4YPqujih17jCdJ2qq8Y5BYvspidIB
         rJyB2N0/9JsMnQpu5Rd7udTQW5KUHNZCahQw1L4mASlTgdv1o7WsS//zkJasMxuduiIM
         NqokK/sBpcyInlUiYbQMhO8FET4e/MYbGF+P41oDF1iM0y8vtWEw7Z/RyimD2iJlETHk
         OOh4218BXVRLQeINsr3Ob6LfxTccV4Mn7wNEITGJnUHkKnoUd1iD9S5dJ+AeL3BY98y6
         njEZl9EeqSq+wexxOwQa7wdfbUeO3zLmjaZCCoftRWXpoGjC6nU2/HDFhPaJtZtolCCq
         4ZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=At2usxGR4GQUXIXsCHuThhiPVkb38P38V3WYBksOqJ8=;
        b=HDg9Q2UnB9MVfQohUL5PWG5chfTDu5nsYHPT6wxYDxjlJDFIlgCrBAl142xmPlGPqp
         wkLbC4V687LVNyt4RGa09E4pKEqdnYK4VVU6YGZVrGmzCZsAFLQ+DW9agRoYpf21rS6R
         5L8IyVPxjnBPD3OLEKGaCW6uWS8cFSqd+OVSrl1Eo8vTwIYb+y6U6ksdxHwpOvAg74pV
         PJjpyKZlNhpCXACn2BlXzErlZTozpJcYF7AK/pCcfO08iADWypI9AjPBtLDa24PqkHpB
         tGnqkwxeYegmw85peg1nvRuMLWyF8a/TZXsoGWJbUaehmY5LWaJXdQDvQKB5oyFNIkfx
         sUpw==
X-Gm-Message-State: APjAAAXPVZwN7xUrsnE5xx0ObIgU+gi4/ZbAmkWDfrOTbYFHyQ91zX+w
        /DVCXp1H5Zg5oge8+tsybWu0PHN8YT8w+VByD1/aXY81fAg=
X-Google-Smtp-Source: APXvYqyyD97dDq5dTTXGmfPZxp+mHLnc3JgSwAlBtXnUZAS8njWZ9j5a6GEwPOo5YWEEOXRwF8zQ9hHA3Zd4DWoJwlA=
X-Received: by 2002:a50:94ed:: with SMTP id t42mr75160740eda.288.1558346622696;
 Mon, 20 May 2019 03:03:42 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 May 2019 12:03:31 +0200
Message-ID: <CAP8UFD0qay_nSXyq=-vFqfxuJ-Q6+Cr+woMHMT3tnPvAfxrRGQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 51
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        David Pursehouse <dpursehouse@collab.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-51.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/376

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday May 22nd.

Thanks,
Christian.
