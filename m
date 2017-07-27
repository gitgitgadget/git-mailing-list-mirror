Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B196F1F89D
	for <e@80x24.org>; Thu, 27 Jul 2017 11:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbdG0LMr (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 07:12:47 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:55708 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751870AbdG0LMp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Jul 2017 07:12:45 -0400
X-AuditID: 12074411-95fff70000000acb-a4-5979caabc721
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id B7.D2.02763.BAAC9795; Thu, 27 Jul 2017 07:12:43 -0400 (EDT)
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com [209.85.214.50])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v6RBCh2G012849
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 07:12:43 -0400
Received: by mail-it0-f50.google.com with SMTP id v205so64155064itf.1
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 04:12:43 -0700 (PDT)
X-Gm-Message-State: AIVw112wptDma2DH2Nc3SMlPmcdRWLybtmLQFDrBYBzUWZkJLlF591DU
        Ju1GQMMyKYthULcynFe6xv76Pf9wGg==
X-Received: by 10.36.147.66 with SMTP id y63mr4500340itd.72.1501153962959;
 Thu, 27 Jul 2017 04:12:42 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.129.91 with HTTP; Thu, 27 Jul 2017 04:12:42 -0700 (PDT)
In-Reply-To: <20170727001812.GI13924@aiede.mtv.corp.google.com>
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
 <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
 <20170727001812.GI13924@aiede.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Thu, 27 Jul 2017 04:12:42 -0700
X-Gmail-Original-Message-ID: <CAMy9T_HJ9LV2P6DYbdDpYXPjB9dAxG8EYopuMtiKgbu0-ar3Mg@mail.gmail.com>
Message-ID: <CAMy9T_HJ9LV2P6DYbdDpYXPjB9dAxG8EYopuMtiKgbu0-ar3Mg@mail.gmail.com>
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a symlink
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Dave Walker <dawalker@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqLv6VGWkwZbvyhZdV7qZHBg9Pm+S
        C2CM4rJJSc3JLEst0rdL4MroP/qDuWAiY8XE9nVMDYxlXYycHBICJhLz/n1h7mLk4hAS2MEk
        8fL1CkYI5xGTxOLtS9ghnH5GiUWb7rBDtORLPLv4B8oukli8t5UFxOYVEJQ4OfMJmC0kICfx
        asMNRgjbW+Lel2NgNqeAvcSpJXNYIIYeZZT4eeAHWIJNQFdiUU8zE4jNIqAqMW3hUjaIBYkS
        955cAqrhAFoQILFodxiIKSwQJPHlsj5IhYiAj8Tyv81gI5kFFjBL7Lo+B2wks4CmROv23+wT
        GIVnITlvFpLUAkamVYxyiTmlubq5iZk5xanJusXJiXl5qUW6pnq5mSV6qSmlmxghQSy4g3HG
        SblDjAIcjEo8vAzTKyKFWBPLiitzDzFKcjApifJOMgUK8SXlp1RmJBZnxBeV5qQWH2KU4GBW
        EuFtPlkZKcSbklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV4eBQkuB9CtIoWJSa
        nlqRlplTgpBm4uAEGc4DNPw02PDigsTc4sx0iPwpRleOWf/WfGHimAcmr1xZBySbPmwBklMO
        bP/CJMSSl5+XKiXOO/kEULMASHNGaR7cfFiyesUoDvSuMG8GyAoeYKKD2/AKaDkT0PKJTWDL
        SxIRUlINjLOOqifGaIl+FfQWmbRq66bgVdYHZCZlGkhZfP/01Szk3xKTOcXqPnbcL3TO/fOY
        VrTm5Tz9pc/121y8g0xfHjX6dYR5YUbkjykW8dsfhz1qrLoyv951+7ETii/yz1XPXLbqTVDN
        jtO7W340F0a86Z3yJMy/3fuq8IHMfeye0y3+LTv/enaWz38lluKMREMt5qLiRAB33i7XMQMA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan, Jonathan: you're both right, the new test needs the SYMLINKS
prerequisite. Junio, would you mind adding that flag?

Thanks,
Michael
