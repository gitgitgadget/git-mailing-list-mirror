Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA34F20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbdGASP1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:15:27 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:59095 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751851AbdGASP1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:15:27 -0400
X-AuditID: 12074411-d03ff700000033ea-e5-5957e6bb61aa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 2C.7A.13290.BB6E7595; Sat,  1 Jul 2017 14:15:25 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IFKvL009530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:15:22 -0400
Subject: Re: [PATCH v2 29/29] read_packed_refs(): die if `packed-refs`
 contains bogus data
To:     Jeff King <peff@peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <1e08748aa5a6dc05003b08207a9a4bc344758ca2.1498200513.git.mhagger@alum.mit.edu>
 <20170623195845.pz7rdyqocjqu5edp@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <9d988f17-ca61-d855-c950-2b20617ce48d@alum.mit.edu>
Date:   Sat, 1 Jul 2017 20:15:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170623195845.pz7rdyqocjqu5edp@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqLv3WXikwYzLxhZrn91hsni+/gS7
        RdeVbiaLht4rzBZLHr5mtuie8pbR4kdLD7PF5s3tLA4cHjtn3WX3WLCp1KOr/Qibx7PePYwe
        Fy8pe3zeJBfAFsVlk5Kak1mWWqRvl8CV0Xf3DmvBEoGKo9/vsTQwTuLtYuTgkBAwkWj6V9zF
        yMUhJLCDSWLi4XssEM55JokZj84ydzFycggLxEh0rZ3PCmKLCMhKfD+8kRGi6BCjxJmFzewg
        DrPAQyaJq3dfg1WxCehKLOppZgKxeQXsJT5v/Qw2iUVAReLVv16wuKhAhMTDzl3sEDWCEidn
        PmEBsTkFXCSu7f0ONodZQF3iz7xLzBC2vMT2t3OYJzDyz0LSMgtJ2SwkZQsYmVcxyiXmlObq
        5iZm5hSnJusWJyfm5aUW6Zrq5WaW6KWmlG5ihIS84A7GGSflDjEKcDAq8fBuCAmLFGJNLCuu
        zD3EKMnBpCTKu/JaaKQQX1J+SmVGYnFGfFFpTmox0O8czEoivOz3wiOFeFMSK6tSi/JhUtIc
        LErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvJeeAjUKFqWmp1akZeaUIKSZODhBhvMADV94
        F2R4cUFibnFmOkT+FKMuR8eMn9+YhFjy8vNSpcR5PUEGCYAUZZTmwc2BpapXjOJAbwlDVPEA
        0xzcpFdAS5iAlgjPCAFZUpKIkJJqYNRR82N/sasx5oVEUaHWoa9bVfSWhk5d+NGu+1vanoQJ
        fF5r5+wRq7W3Up3zIO+d2HkthnPBoZpcnew7/9d/KN71992U9W6aD8MY3t96a++aZJR1u+3m
        wqinK5b4We2rn/uz4cLTC08yPx/ZWWCtXVh9b8HUzQs4taP+XTKUX/3h1/SpnvdsZ/1SYinO
        SDTUYi4qTgQApW76TDADAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/23/2017 09:58 PM, Jeff King wrote:
> On Fri, Jun 23, 2017 at 09:01:47AM +0200, Michael Haggerty wrote:
> 
>> The old code ignored any lines that it didn't understand. This is
>> dangerous. Instead, `die()` if the `packed-refs` file contains any
>> lines that we don't know how to handle.
> 
> This seems like a big improvement. Is it worth adding a test for a
> corrupted file?

That's a good idea. While I'm at it, I'll distinguish between
unterminated lines and lines that are invalid for other reasons, because
the error message should differ for these cases.

> I assume this isn't something you saw in the wild, but just a deficiency
> you noticed while reading the code.

Correct, I've never seen this problem in the wild. Though, since Git
would have covered up the problem while it existed and obliterated it at
the next `pack-refs`, it's the kind of thing that would be easy to
overlook and hard to prove afterwards.

> I suspect this laxness may have been what allowed us to add the optional
> peeled values long ago. But I think I'd rather see us be more strict and
> notice corruption or nonsense rather than quietly ignoring (especially
> because an operation like "git pack-refs" would then overwrite it,
> dropping whatever entries we didn't understand).

That's an interesting consideration. I suppose we could plan in some way
to extend the `packed-refs` format in a backwards-transparent fashion,
if there is ever an extension that old versions of git would be free to
ignore, while leaving the format strict enough that genuine corruption
would be unlikely to be overlooked. For example, we could reserve one or
more special characters which, when they appear at the beginning of a
line, mean that the line should be ignored.

But such an extension would only be practical if other Git
implementations are similarly lax. But libgit2 is currently strict about
rejecting unrecognized lines, so such an extension couldn't be
backwards-compatible with old versions of libgit2. So it doesn't seem
very useful.

Michael

