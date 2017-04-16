Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDE931FA14
	for <e@80x24.org>; Sun, 16 Apr 2017 06:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbdDPGOH (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:14:07 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:44034 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752201AbdDPGOF (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:14:05 -0400
X-AuditID: 1207440d-029ff70000003721-4f-58f30baad186
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.33.14113.AAB03F85; Sun, 16 Apr 2017 02:14:04 -0400 (EDT)
Received: from [192.168.69.190] (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6Dwq7024701
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:14:00 -0400
Subject: Re: [PATCH v2 19/20] files_pack_refs(): use reference iteration
To:     Duy Nguyen <pclouds@gmail.com>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
 <1d131a33fd155f14908ee1d41e98be8a1309c6b9.1490966385.git.mhagger@alum.mit.edu>
 <CACsJy8DAFUQnjkLnaXD0aM_97_E_7F_=fMeJb2Azigt2Pv0gTw@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c29c0e5f-e0eb-2be3-3ebf-0a8f838fc5b1@alum.mit.edu>
Date:   Sun, 16 Apr 2017 08:13:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8DAFUQnjkLnaXD0aM_97_E_7F_=fMeJb2Azigt2Pv0gTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42IRYndR1F3D/TnC4G+vkMXaZ3eYLLqudDNZ
        NPReYbZY8vA1s0X3lLeMFj9aepgtNm9uZ3Fg99g56y67x4JNpR5d7UfYPJ717mH0uHhJ2ePz
        JrkAtigum5TUnMyy1CJ9uwSujEvXvzIVbOSomN3extrA+Juti5GTQ0LARKL98EomEFtIYAeT
        RO+HqC5GLiD7HJPEzRkv2EESwgIeErP+XQArEhFQknjTsY0ZouE8o8SJz1IgDcwCE5kkTnx5
        CFbEJqArsainGcjm4OAVsJc40+gAEmYRUJWYd2IuC4gtKhAiMWfhA0YQm1dAUOLkzCdgcU6B
        QIlJ27eAxZkF1CX+zLvEDGHLS2x/O4d5AiP/LCQts5CUzUJStoCReRWjXGJOaa5ubmJmTnFq
        sm5xcmJeXmqRrpFebmaJXmpK6SZGSJDz7mD8v07mEKMAB6MSD6+F/6cIIdbEsuLK3EOMkhxM
        SqK8Mv+BQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4k1k+RwjxpiRWVqUW5cOkpDlYlMR51Zao
        +wkJpCeWpGanphakFsFkZTg4lCR4+7mAGgWLUtNTK9Iyc0oQ0kwcnCDDeYCGXwOp4S0uSMwt
        zkyHyJ9iVJQS5/3OCZQQAElklObB9cKS0CtGcaBXhHk3gLTzABMYXPcroMFMQIMZJn8AGVyS
        iJCSamC0uNwbaVvK4N5a/Vih6YWq5JPdfKLXbfqWu3ie22yi/Dmx4sX1M7t3nPltsHe63cPm
        md4drWn7LqV21O/7GLPQe231tU9bLp5fVaijd16kf+OZL69Mr7KqfYr4fblS6HRO5pzKrus/
        J257GeMrsOXKEadVb44+j9v7jD/l8toF2mI3171ujK40VWIpzkg01GIuKk4EAFFgs1odAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/07/2017 01:51 PM, Duy Nguyen wrote:
> On Fri, Mar 31, 2017 at 9:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Use reference iteration rather than do_for_each_entry_in_dir() in the
>> definition of files_pack_refs().
> 
> A "why" is missing here. My guess is readability/maintainability
> because it's easier to follow the code with iterator design, than the
> callback one? No maintaining data in struct pack_refs_cb_data is also
> very nice.

You're right. I'll improve the commit message to something like

files_pack_refs(): use reference iteration

Use reference iteration rather than `do_for_each_entry_in_dir()` in the
definition of `files_pack_refs()`. This makes the code shorter and
easier to follow, because the logic can be inline rather than spread
between the main function and a callback function, and it removes the
need to use `pack_refs_cb_data` to preserve intermediate state.

This removes the last callers of `entry_resolves_to_object()` and
`get_loose_ref_dir()`, so delete those functions.

Thanks,
Michael

