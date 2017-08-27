Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69FD3208DB
	for <e@80x24.org>; Sun, 27 Aug 2017 06:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750838AbdH0Ghw (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 02:37:52 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61756 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750797AbdH0Ghv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Aug 2017 02:37:51 -0400
X-AuditID: 12074413-3a3ff70000007929-6c-59a268bd3de9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B0.B8.31017.DB862A95; Sun, 27 Aug 2017 02:37:50 -0400 (EDT)
Received: from mail-it0-f42.google.com (mail-it0-f42.google.com [209.85.214.42])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7R6bmpI029486
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sun, 27 Aug 2017 02:37:49 -0400
Received: by mail-it0-f42.google.com with SMTP id o132so8296996itc.1
        for <git@vger.kernel.org>; Sat, 26 Aug 2017 23:37:49 -0700 (PDT)
X-Gm-Message-State: AHYfb5h82hreeGzzKhmAKnS/LVzWBAvs9cZdx8VwXRK52oWkgKAlc+jq
        1d3lQUdpTwJyk21p/eGwyl/Faw2v3g==
X-Received: by 10.36.167.1 with SMTP id a1mr3202542itf.102.1503815868797; Sat,
 26 Aug 2017 23:37:48 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.15.204 with HTTP; Sat, 26 Aug 2017 23:37:47 -0700 (PDT)
In-Reply-To: <xmqqh8wuqo6e.fsf@gitster.mtv.corp.google.com>
References: <cover.1503734566.git.mhagger@alum.mit.edu> <c21bedbee9487792f4a336a417aa9874578aaac2.1503734566.git.mhagger@alum.mit.edu>
 <xmqqh8wuqo6e.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Sun, 27 Aug 2017 08:37:47 +0200
X-Gmail-Original-Message-ID: <CAMy9T_HYV9=HvrAnAxHgzRvUy__3o99PxQSOe2iCE_swtk_8VQ@mail.gmail.com>
Message-ID: <CAMy9T_HYV9=HvrAnAxHgzRvUy__3o99PxQSOe2iCE_swtk_8VQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] load_subtree(): remove unnecessary conditional
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsUixO6iqLsvY1GkQcNleYuuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGXsXrqNtWAza8WsY4tYGhhXs3QxcnJICJhIHN14jq2LkYtDSGAH
        k8Spmw8ZIZxHTBKv7rZBOX2MEjOO/mKFaMmX+L1oK5RdKHGv9RcTiM0rIChxcuYTsLFCAnIS
        rzbcYISwvSXap8wAi3MKWEvs6mxlg4hvZ5R4eJ0fxGYT0JVY1NMMNodFQFViy555TBDzEyWm
        75nBDjE/QOLAumtgc4QFPCUeNa8BmyMioCYxse0QC8ihzAITGSUaOveBNTMLaEq0bv/NPoFR
        eBaS+2YhSS1gZFrFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuul5tZopeaUrqJERLIwjsYd52U
        O8QowMGoxMNrcHRhpBBrYllxZe4hRkkOJiVRXgcNoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR
        3pPGiyKFeFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvJ7AiBUSLEpN
        T61Iy8wpQUgzcXCCDOcBGm4HUsNbXJCYW5yZDpE/xWjJceXKui9MHE0ftgDJKQe2f2ESYsnL
        z0uVEuetTQdqEABpyCjNg5sJS0yvGMWBXhTmPQRSxQNManBTXwEtZAJaqCi4EGRhSSJCSqqB
        USzmt7u46oEsZ6YOVnHDB80bO3jzFE0WKVV//FVRutlg6STjUxpHLrJV597btZ73p+2JSR0G
        HrpWCycfXHPDMmjDzKUXlPYdvq/TVjavQNRR/eeDO0X7nhyaEDf5xYbaqPi6bRcD/er5jT2j
        sx0u7tn34Uxc8UZOrzvqakYqJ17Kahd9CWQ4rMRSnJFoqMVcVJwIANcTkMsnAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 26, 2017 at 6:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> At this point in the code, len is *always* <= 20.
>
> This is the kind of log message that makes me unconfortable, as it
> lacks "because", and the readers would need to find out themselves
> by following the same codepath the patch author already followed.
> [...]

That's a valid complaint. I've adjusted the patch series to add the
assertion and explain the reasoning better in the commit message. I've
pushed the revised series to GitHub, but I'll wait a couple of days to
see if there's more feedback before resubmitting.

Thanks,
Michael
