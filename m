Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90D9B20286
	for <e@80x24.org>; Tue, 12 Sep 2017 06:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbdILGrV (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 02:47:21 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:54628 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750987AbdILGrU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Sep 2017 02:47:20 -0400
X-AuditID: 12074414-0ebff70000006ddf-4c-59b782f4c560
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id F4.1E.28127.4F287B95; Tue, 12 Sep 2017 02:47:19 -0400 (EDT)
Received: from mail-it0-f52.google.com (mail-it0-f52.google.com [209.85.214.52])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8C6lF6c025070
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 02:47:16 -0400
Received: by mail-it0-f52.google.com with SMTP id o200so25859187itg.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 23:47:16 -0700 (PDT)
X-Gm-Message-State: AHPjjUj4DpMsXPVOLmC4GHG4klE8rdIcMxe+vrkuFEMPuIAWP5a3U5Oe
        DLX2/KGoWU39BJ7scLQNvG7RfTPmoI3HomuXByE=
X-Google-Smtp-Source: AOwi7QA1NfiAouial8A8CGWDHP65nrA8j2zUuPTVk5VJXJI8mPYRBzyn+HS8QNFelSOgkppwEZp2ow5lfG9jxa6juqw=
X-Received: by 10.36.26.129 with SMTP id 123mr16679896iti.38.1505198835489;
 Mon, 11 Sep 2017 23:47:15 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.79.13.17 with HTTP; Mon, 11 Sep 2017 23:47:14 -0700 (PDT)
In-Reply-To: <20170910073928.ys4nbap76tmiurjh@sigill.intra.peff.net>
References: <cover.1503734566.git.mhagger@alum.mit.edu> <20170909103131.pppm346qbj2cdxuo@sigill.intra.peff.net>
 <2b7c0053-bf7a-fbdd-3cf9-39b5d9a962c3@alum.mit.edu> <20170910073928.ys4nbap76tmiurjh@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Tue, 12 Sep 2017 08:47:14 +0200
X-Gmail-Original-Message-ID: <CAMy9T_GGrb3+9n2nMT78mk8_4SGdf=EbS4gDYtvM1CA-i3+xXQ@mail.gmail.com>
Message-ID: <CAMy9T_GGrb3+9n2nMT78mk8_4SGdf=EbS4gDYtvM1CA-i3+xXQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] Clean up notes-related code around `load_subtree()`
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsUixO6iqPu9aXukwff/GhZdV7qZHBg9Pm+S
        C2CM4rJJSc3JLEst0rdL4Mr4cn4LW8EtzorPJ74xNzBeZO9i5OSQEDCRuLH/EGMXIxeHkMAO
        JolZ7xqYIJxHTBLXl3xnh3D6GSWetX5jhGgpl7hx5gwLhF0kseLtVKA4B5BdLLH+VBVImFdA
        UOLkzCdgJUICchKvNtxghLA9Jc4vuQNmcwq4SBw6voMJIn6XUeL8hFAQm01AV2JRTzNYnEVA
        VeL1/VNMEOMTJVb3KEGMD5CY/HgZG4gtLOAn0bDnMFi5iICsxPfDG8GeYRaYxiRxY+seVpAE
        s4CmROv23+wTGEVmITlvFpLUAkamVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Fnq5mSV6qSml
        mxghwS2yg/HISblDjAIcjEo8vA292yKFWBPLiitzDzFKcjApifL+Ft4eKcSXlJ9SmZFYnBFf
        VJqTWnyIUYKDWUmEd1cBUI43JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxWhoND
        SYI3ARjFQoJFqempFWmZOSUIaSYOTpDhPEDD/zWCDC8uSMwtzkyHyJ9iNOa4cOfSHyaOA3tu
        /WESYsnLz0uVEuf1AhknAFKaUZoHNw2WoF4xigM9J8x7EWQgDzC5wc17BbSKCWgVz6UtIKtK
        EhFSUg2MdTal4Q/+bz+5b03crVfSnX2J3JEqDiVyTHvMYqpi+49bbeir2LDVv5Nbgm3Bpfdu
        bIKx+ufWfW28LLWgyGqn1W9Wznz9tclMj69VR91YsyMp6sWGW5pGXDd6TMoML79eFS557mDA
        hOtF6WFHly0v+Wg+Qz9Bxfx9atTqmGnpW8NYj55Zx7ZNiaU4I9FQi7moOBEAd5HnACsDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2017 at 9:39 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Sep 10, 2017 at 06:45:08AM +0200, Michael Haggerty wrote:
>
>> > So nothing to see here, but since I spent 20 minutes scratching my head
>> > (and I know others look at Coverity output and may scratch their heads
>> > too), I thought it was worth writing up. And also if I'm wrong, it would
>> > be good to know. ;)
>>
>> Thanks for looking into this. I agree with your analysis.
>>
>> I wonder whether it is the factor of two between path lengths and byte
>> lengths that is confusing Coverity. Perhaps the patch below would help.
>> It requires an extra, superfluous, check, but perhaps makes the code a
>> tad more readable. I'm neutral on whether we would want to make the change.
>
> Yeah, I do agree that it makes the code's assumptions a bit easier to
> follow.
>
>> Is there a way to ask Coverity whether a hypothetical change would
>> remove the warning, short of merging the change to master?
>
> You can download and run the build portion of the coverity tools
> yourself. [...]

Thanks for the info.

My suggested tweak doesn't appease Coverity. Given that, I don't think
I'll bother adding it to the patch series.

Michael
