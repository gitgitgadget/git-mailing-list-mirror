Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63401F4DD
	for <e@80x24.org>; Mon, 28 Aug 2017 06:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbdH1Gzq (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 02:55:46 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:64593 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751525AbdH1Gzo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Aug 2017 02:55:44 -0400
X-AuditID: 12074411-f95ff70000007f0a-4e-59a3be6dd2a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 00.F5.32522.D6EB3A95; Mon, 28 Aug 2017 02:55:43 -0400 (EDT)
Received: from mail-it0-f42.google.com (mail-it0-f42.google.com [209.85.214.42])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7S6telr023575
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 02:55:41 -0400
Received: by mail-it0-f42.google.com with SMTP id o132so13161363itc.1
        for <git@vger.kernel.org>; Sun, 27 Aug 2017 23:55:41 -0700 (PDT)
X-Gm-Message-State: AHYfb5hhK8/cQDB9fvKU8ANJtF8KM7X/3fQGi8kPxM1YhzDrPagAcJ2T
        fA53YlqO3eu5S0w5eE84NDG4j93S5Q==
X-Received: by 10.36.181.13 with SMTP id v13mr1692353ite.35.1503903340478;
 Sun, 27 Aug 2017 23:55:40 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.79.15.14 with HTTP; Sun, 27 Aug 2017 23:55:39 -0700 (PDT)
In-Reply-To: <CAMy9T_HYV9=HvrAnAxHgzRvUy__3o99PxQSOe2iCE_swtk_8VQ@mail.gmail.com>
References: <cover.1503734566.git.mhagger@alum.mit.edu> <c21bedbee9487792f4a336a417aa9874578aaac2.1503734566.git.mhagger@alum.mit.edu>
 <xmqqh8wuqo6e.fsf@gitster.mtv.corp.google.com> <CAMy9T_HYV9=HvrAnAxHgzRvUy__3o99PxQSOe2iCE_swtk_8VQ@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Mon, 28 Aug 2017 08:55:39 +0200
X-Gmail-Original-Message-ID: <CAMy9T_Gt=p==jHmx5nf8GeZBULACkjqC2zZqU+F31yx1xVaPBw@mail.gmail.com>
Message-ID: <CAMy9T_Gt=p==jHmx5nf8GeZBULACkjqC2zZqU+F31yx1xVaPBw@mail.gmail.com>
Subject: Re: [PATCH 02/12] load_subtree(): remove unnecessary conditional
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsUixO6iqJu/b3Gkwc+trBZdV7qZHBg9Pm+S
        C2CM4rJJSc3JLEst0rdL4Mq4emIZY8E/5or+WZuZGxhnMncxcnJICJhIrDnYxNbFyMUhJLCD
        SWLuvCdQziMmiV2H17BCOP2MEienv2SEaMmX2LuwEaq9SGJ6+z4mEJtXQFDi5MwnLCC2kICc
        xKsNNxghbE+Js5dXg9VzCgRKbNx+HmroH0aJx7M2gjWwCehKLOppBhvEIqAqMWH2eqhliRK/
        tk5ih1gQILHx2xEwWxho6KPmNWwgtoiAmsTEtkMsIEOZBSYySjR0QlzELKAp0br9N/sERuFZ
        SA6chSS1gJFpFaNcYk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZIKAvuYJxxUu4Q
        owAHoxIPb4P54kgh1sSy4srcQ4ySHExKorw7K4BCfEn5KZUZicUZ8UWlOanFhxglOJiVRHg7
        dgHleFMSK6tSi/JhUtIcLErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvMF7gRoFi1LTUyvS
        MnNKENJMHJwgw3mAhluD1PAWFyTmFmemQ+RPMVpyXLmy7gsTR9OHLUByyoHtX5iEWPLy81Kl
        xHm/7AFqEABpyCjNg5sJS02vGMWBXhTmXQkylgeY1uCmvgJayAS0UFFwIcjCkkSElFQDo+On
        R5OXLiizlL3d03l1JpMT29u7bGqbXrsklBy/wmd57t/p+2t7b/YL7smq0joTubHRruHTsZwV
        F/tmJn36doprapVXxhWLNt0NJrc1+5R2c8xsWMjxW03eYlfP/sctVjfsZfZkLluhvDM5v/zQ
        keKNt9az1Gp4Litymak9WU04r/NTUurXp0osxRmJhlrMRcWJAM9c40IoAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio, I'm surprised that you have merged the `mh/notes-cleanup`
branch into `next` already. Was that intentional? Aside from the fact
that the topic has had very little cooking time, there's the issue of
the assertion that you asked for. I have implemented the assertion in
a new version of the branch that I pushed to GitHub but haven't yet
submitted to the list.

How would you like to proceed? Do you want me to submit a patch
(adding the assertion) that applies on top of this branch?

Michael
