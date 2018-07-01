Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86D0F1F516
	for <e@80x24.org>; Sun,  1 Jul 2018 15:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbeGAP5k (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 11:57:40 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:58296 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752391AbeGAP5j (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Jul 2018 11:57:39 -0400
X-AuditID: 1207440d-64dff70000003441-65-5b38f9f24014
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id CE.A5.13377.3F9F83B5; Sun,  1 Jul 2018 11:57:39 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC52B.dip0.t-ipconnect.de [87.188.197.43])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w61FvaRm004490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 1 Jul 2018 11:57:37 -0400
Subject: Re: [PATCH] xdiff: reduce indent heuristic overhead
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jamill@microsoft.com, mh@glandium.org
References: <CAGZ79kb0FOafEsuXU7c_BTwPtcujFeyWVhzSuzFHRFtQHp9weQ@mail.gmail.com>
 <20180629202811.131265-1-sbeller@google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <72ac1ac2-f567-f241-41d6-d0f83072e0b3@alum.mit.edu>
Date:   Sun, 1 Jul 2018 17:57:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629202811.131265-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixO6iqPv5p0W0wacJ3BZdV7qZLOZ1HmW0
        6J3cy2qxeXM7iwOLx9PtU5g9Fmwq9Wjd8Zfd4/MmuQCWKC6blNSczLLUIn27BK6Myb2T2Au2
        K1R0Pf3K1MB4TLKLkYNDQsBE4uhT/y5GLg4hgR1MEhu/r2WDcM4xSTy9/oCxi5GTQ1jARmLi
        oQ9gtoiAmsTMVbPZQGxmATuJl81LweJCAvUSaxe1gcXZBHQlFvU0M4HYvAL2Eht3vmEHsVkE
        VCSObloCViMqECHRNG8NO0SNoMTJmU9YQGxOAUuJowcbmSDmq0v8mXeJGcIWl7j1ZD5UXF6i
        eets5gmMArOQtM9C0jILScssJC0LGFlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6eVmluil
        ppRuYoQEOe8Oxv/rZA4xCnAwKvHwHthtHi3EmlhWXJl7iFGSg0lJlPewmFm0EF9SfkplRmJx
        RnxRaU5q8SFGCQ5mJRFe0Y9A5bwpiZVVqUX5MClpDhYlcV42k71RQgLpiSWp2ampBalFMFkZ
        Dg4lCd4LPyyihQSLUtNTK9Iyc0oQ0kwcnCDDeYCGcwOTghBvcUFibnFmOkT+FKMux5/3Uycx
        C7Hk5eelSonzHgIZJABSlFGaBzcHlpxeMYoDvSXM+wqkigeY2OAmvQJawgS0pPq4KciSkkSE
        lFQDo+OZb1PC5U4zJ4fdvLdIrO2homEqwx32tkedmvPvfA5flrm4b1lruMq872ueHjV2/HM9
        scHEkiX5IO/O/WHzX7n0/aozzJW/EB11NOjlBiEu5x1/sz7WWpxcv3/eT3PZJ5Y8UUue2h3N
        yrlTKDj5gK250/bzfuLfy25v1et35v1ay+8vsUpzshJLcUaioRZzUXEiAHi9VkMpAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/29/2018 10:28 PM, Stefan Beller wrote:
> [...]
>     Adds some threshold to avoid expensive cases, like:
> 
>     ```
>     #!python
>     open('a', 'w').write(" \n" * 1000000)
>     open('b', 'w').write(" \n" * 1000001)
>     ```
> 
>     The indent heuristic is O(N * 20) (N = 1000000) for the above case, and
>     makes diff much slower.
> [...]
> +/*
> + * For indentation heuristic, skip searching for better slide position after
> + * checking MAX_BORING lines without finding an improvement. This defends the
> + * indentation heuristic logic against pathological cases. The value is not
> + * picked scientifically but should be good enough.
> + */
> +#define MAX_BORING 100

This is an interesting case, and a speed difference of almost a factor
of five seems impressive. But this is a pretty pathological case, isn't
it? And I'm pretty sure that the algorithm is `O(N)` both before and
after this change. Remember that to find `earliest_end` and `g.end`,
there has already been a scan through all 1000000 lines. In other words,
you're not improving how the overall algorithm scales with `N`; you're
only changing the constant factor in front. So it's a little bit
questionable whether it is worth complicating the code for this unusual
case.

But *if* we want to improve this case, I think that we could be smarter
about it.

By the time we get to this point in the code, we already know that there
is a "slider" hunk of length `M` (`groupsize`) that can be slid up or
down within a range of `N` (`g.end - earliest_end + 1`) possible
positions. The interesting case here is `N ≫ M`, because then naively
the number of positions to try out is a lot bigger than the size of the
hunk itself. (In the case described above, `N` is 1000000 and `M` is 1.)

But how can that situation even arise? Remember, a hunk can only be slid
down by a line if the first line *after* the hunk is identical to the
first line *of* the hunk. It follows that if you shift a hunk down `M`
lines, then it has the same contents as when you started—you've just
rotated all of the hunk lines around once.

So if `N ≫ M`, there is necessarily a lot of repetition among the `N +
M` lines that the hunk could possibly overlay. Specifically, it must
consist of `floor((N + M)/M)` identical copies of the hunk, plus
possibly a few leftover lines constituting the start of another repetition.

Given this large amount of repetition, it seems to me that there is
never a need to scan more than the bottom `M + 1` possible positions [1]
plus the highest possible position [2] to be sure of finding the very
best one. In the pathological case that you described above, where `M`
is 1, only three positions have to be evaluated, not 100.

In fact, it *could* be that there is even more repetition, namely if the
hunk itself contains multiple copies of an even shorter block of `K`
lines. In that case, you would only have to scan `K + 1` positions at
the bottom plus one at the top to be sure to find the best hunk
position. This would be an interesting optimization for a case like

>     open('a', 'w').write(" \n" * 1000000)
>     open('b', 'w').write(" \n" * 1100000)

(`N = 1000000`, `M = 100000`, `K = 1`) or

>     open('a', 'w').write("<item>\nMISSING\n</item>\n" * 1000000)
>     open('b', 'w').write("<item>\nMISSING\n</item>\n" * 1100000)

(`N = 3000000`, `M = 300000`, `K = 3`). On the other hand, it's not
entirely trivial to find periodicity in a group of lines (i.e., to find
`K`), and I don't know offhand how that task scales with `M`.

Michael

[1] Actually, to be rigorously correct it might be necessary to check
even a bit more than `M + 1` positions at the bottom because the
heuristic looks a bit beyond the lines of the hunk.

[2] The position at the top has different predecessor lines than the
other positions, so it could have a lower score than all of the others.
It's worth checking it. Here too, to be rigorously correct it might be
necessary to check more than one position at the top because the
heuristic looks a bit beyond the lines of the hunk.
