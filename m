Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89BE72089D
	for <e@80x24.org>; Sat, 29 Jul 2017 02:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbdG2CSU (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 22:18:20 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:59099 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752996AbdG2CST (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jul 2017 22:18:19 -0400
X-AuditID: 1207440d-a07ff70000000c0c-81-597bf06a9579
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 97.CB.03084.A60FB795; Fri, 28 Jul 2017 22:18:18 -0400 (EDT)
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com [209.85.214.53])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v6T2IH9G031757
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 22:18:18 -0400
Received: by mail-it0-f53.google.com with SMTP id v205so88423347itf.1
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 19:18:17 -0700 (PDT)
X-Gm-Message-State: AIVw113Pko+MlTl3NxsHfirhAgF7SdyUQSk7gqUd48ItRzZFir7SK7HZ
        pGwDVrk//odX/XJwas8ZSGf0slc8rA==
X-Received: by 10.36.117.204 with SMTP id y195mr11870603itc.34.1501294697293;
 Fri, 28 Jul 2017 19:18:17 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.129.91 with HTTP; Fri, 28 Jul 2017 19:18:16 -0700 (PDT)
In-Reply-To: <CAJo=hJvR_rV356Mna0cMoTY2mrVnG9MH39wDS1tLCRT1h_f65Q@mail.gmail.com>
References: <CAJo=hJvxWg2J-yRiCK3szux=eYM2ThjT0KWo-SFFOOc1RkxXzg@mail.gmail.com>
 <CAMy9T_GeE5Xh7HJ7VZPX5B5SGUmjUbELER07-u0se5Y0ZJ5YtQ@mail.gmail.com> <CAJo=hJvR_rV356Mna0cMoTY2mrVnG9MH39wDS1tLCRT1h_f65Q@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Fri, 28 Jul 2017 19:18:16 -0700
X-Gmail-Original-Message-ID: <CAMy9T_F9oH926ShUGpFqJz4bMrJofvbsfb0_oME2NhsYvObq9Q@mail.gmail.com>
Message-ID: <CAMy9T_F9oH926ShUGpFqJz4bMrJofvbsfb0_oME2NhsYvObq9Q@mail.gmail.com>
Subject: Re: reftable [v3]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqJv1oTrS4MASaYuuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGU8uj+HseA1W0Xn66PMDYz7WbsYOTkkBEwkJnyYzdjFyMUhJLCD
        SeLcknOMIAkhgUdMEu+XykMk+hklJr//wQTRkS/R2byJGcIulZhzfBIbiM0rIChxcuYTFohm
        OYlXG25ADfKWuNHaD2ZzCgRKnOw4ygQx9A6jxK4rEA1sAroSi3qawRawCKhKPGvuY4RYkCjx
        oOc8I8SCAIm+bQ/AzhYWMJLoONsP1isioCax/UIPK8hQZoGpjBLHZhwDu4hZQFOidftv9gmM
        wrOQHDgLSWoBI9MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJBA5t3B+H+d
        zCFGAQ5GJR5ej8rqSCHWxLLiytxDjJIcTEqivP9XAYX4kvJTKjMSizPii0pzUosPMUpwMCuJ
        8F5/D5TjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwHnwH1ChYlJqe
        WpGWmVOCkGbi4AQZzgM0fB9IDW9xQWJucWY6RP4Uoz3HlSvrvjBxNH3YAiSnHNgOYn//+J1J
        iCUvPy9VSpxXEeQmAZC2jNI8uMmwJPWKURzoUWFedZAqHmCCg5v9CmgtE9DaiU2VIGtLEhFS
        Ug2MYR+tFtwr4W2KbjS4FqDJKV5WovDEaOoTJiE5G2PvxcLxf71uPl9g8GzD4mf3twqbfD75
        QNYx1s5/29m04hhJpXWdJSYbxb/Oz9pSY/CmS9LqNnNhnx/LzMTslRW3FeT0NpUzOH/2d2DL
        959jeHpSpIH1lwkbtJZeXl/7ztowdfMc19oX89OVWIozEg21mIuKEwG8Y8TZLQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 28, 2017 at 3:12 PM, Shawn Pearce <spearce@spearce.org> wrote:
> I'm with you this far, and like the {min,max}_update_index in the
> header. I'm concerned about update_index in 32 bits. At some point you
> need to reset the counter, or the repository is broken. 4b updates is
> enough for anyone? I'd feel better about this being a 64 bit field.

Yes, I was a little bit nervous about 32 bits, too. But that's a *lot*
of updates: one per second for 136 years. If that limit were ever
reached, there could be a compaction step, where any update indices
that don't have associated reflog entries are "compacted out" of the
numerical sequence and the remaining indices are renumbered
contiguously.

But it's ok with me to make it 64 bits. Usually those extra bytes
would be appear as FFFFFFFF and so should prefix- and zlib-compress
well.

Michael
