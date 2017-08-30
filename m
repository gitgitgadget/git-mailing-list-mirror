Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4828208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbdH3HH6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:07:58 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45353 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750757AbdH3HH5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Aug 2017 03:07:57 -0400
X-AuditID: 12074414-0ebff70000006ddf-d5-59a6644cfab0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 9C.86.28127.C4466A95; Wed, 30 Aug 2017 03:07:56 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC970.dip0.t-ipconnect.de [87.188.201.112])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7U77sju007754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 30 Aug 2017 03:07:55 -0400
Subject: Re: [PATCH] config: use a static lock_file struct
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
 <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
 <20170829190928.GD131745@google.com>
 <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
 <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
 <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
 <20170830045555.27xczwo3ql7q4bg3@sigill.intra.peff.net>
 <20170830055539.xpgxeu3flmxs55av@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8e09e4e1-984c-78d1-7b87-0bafe5346621@alum.mit.edu>
Date:   Wed, 30 Aug 2017 09:07:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170830055539.xpgxeu3flmxs55av@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqOuTsizSYN97eYvn60+wW3Rd6Way
        ePxwCavF3zddjBY/WnqYHVg9ds66y+6xYFOpx7PePYwenzfJBbBEcdmkpOZklqUW6dslcGV0
        dU1lK7gkVPH85WTGBsbffF2MnBwSAiYSd0/OZO1i5OIQEtjBJLHj7ysmCOcCk8SP5ZPZQKqE
        BawkbrzdyA5iiwjISnw/vJERpIhZ4DijxPpdzxghOr6xSLz5exGsik1AV2JRTzMTiM0rYC9x
        dtcxsEksAqoSR3ZtZgSxRQUiJPreXmaHqBGUODnzCQuIzSngIjFp8iVWEJtZQF3iz7xLzBC2
        uMStJ/OZIGx5ie1v5zBPYBSYhaR9FpKWWUhaZiFpWcDIsopRLjGnNFc3NzEzpzg1Wbc4OTEv
        L7VI10IvN7NELzWldBMjJOhFdjAeOSl3iFGAg1GJh3cH97JIIdbEsuLK3EOMkhxMSqK8lglA
        Ib6k/JTKjMTijPii0pzU4kOMEhzMSiK8zoFAOd6UxMqq1KJ8mJQ0B4uSOO+3xep+QgLpiSWp
        2ampBalFMFkZDg4lCd4pyUCNgkWp6akVaZk5JQhpJg5OkOE8QMO3JYEMLy5IzC3OTIfIn2JU
        lBLnPQaSEABJZJTmwfXCktIrRnGgV4R5r4Ks4AEmNLjuV0CDmYAGx3otBRlckoiQkmpgzE5m
        aZ60yvyny1uxCUu5pmxnuP/8K8+MBzNn3j8pbnhv2uVWzqrzB7bN0RMuWLb5t6It45tePQ7e
        irUfHXIMGSerctl2NS7tn+F4UKjy0QbRTQpV3l9LXn03PvXRQlLsjHX0gTqDpf8dUnlDruyV
        Cdxy8MzM5Mz89G/2xR+meGqWCj/gyD70UImlOCPRUIu5qDgRALhDiV4lAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/30/2017 07:55 AM, Jeff King wrote:
> On Wed, Aug 30, 2017 at 12:55:55AM -0400, Jeff King wrote:
> [...]
> The patch below demonstrates how this could be used to turn some
> "xcalloc" lock_files into stack variables that are allowed to go out of
> scope after we commit or rollback. This solves the three lock-related
> leaks reported by valgrind when running t0000.
> 
> _But_ it also demonstrates an interesting downside of this approach.
> Some functions are lazy in their error paths. For instance, look at
> write_index_as_tree(). We take the lock early in the function, but may
> return before a commit or rollback if we hit an error.  With the current
> code this "leaks" the tempfile, which is wrong. But nobody notices
> because in practice the program exits soon after and we clean up the
> tempfile then.
> 
> But with a stack variable lock_file, that minor problem becomes a major
> one: our stack variable got added to a global linked list and the
> atexit() handler will try to read it. But now of course it will contain
> garbage, since the variable went out of scope.
> 
> So it's probably safer to just let tempfile.c handle the whole lifetime,
> and have it put all live tempfiles on the heap, and free them when
> they're deactivated. That means our creation signature becomes more
> like:
> 
>   struct tempfile *create_tempfile(const char *path);
> 
> and delete_tempfile() actually calls free() on it (though we'd probably
> want to skip the free() from a signal handler for the usual reasons).

I agree that the latter would be a nice, and relatively safe, design. It
would involve some fairly intrusive changes to client code, though.

I think it would be possible to implement the new API while leaving the
old one intact, to avoid having to rewrite all clients at once, and
potentially to allow clients to avoid a malloc if they already have a
convenient place to embed a `struct tempfile` (except that now they'd be
able to free it when done). For example, `create_tempfile(tempfile,
path)` and its friends could accept NULL as the first argument, in which
case it would malloc a `struct tempfile` itself, and mark it as being
owned by the tempfile module. Such objects would be freed when
deactivated. But if the caller passes in a non-NULL `tempfile` argument,
the old behavior would be retained.

Michael
