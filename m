Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8062E1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 21:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753046AbdBIVYW (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 16:24:22 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58328 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752664AbdBIVYV (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 16:24:21 -0500
X-AuditID: 12074412-5f5ff700000009b5-2b-589cdddb50ee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 3E.20.02485.BDDDC985; Thu,  9 Feb 2017 16:23:39 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v19LNZ4P016876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 16:23:36 -0500
Subject: Re: [PATCH 0/5] Store submodules in a hash, not a linked list
To:     Jeff King <peff@peff.net>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
 <20170209195812.dbbmko4sas3wtdy5@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <9ba16176-b388-4c70-a479-fda4c9244e67@alum.mit.edu>
Date:   Thu, 9 Feb 2017 22:23:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170209195812.dbbmko4sas3wtdy5@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqHv77pwIg1e3JCy6rnQzWTT0XmG2
        6F/exWax5OFrZovuKW8ZLX609DBbbN7czuLA7rFz1l12jw8f4zwWbCr16Go/wubxrHcPo8fF
        S8oenzfJBbBHcdmkpOZklqUW6dslcGWsP9DDVNAjUHH40XfmBsYO3i5GTg4JAROJbX+nM3Yx
        cnEICVxmlJh5Zw47hHOeSWL2pj0sIFXCAm4Sa1YsYwSxRQRkJb4f3ghmCwkUSmxpfcYK0sAs
        MJ9Jov/BGyaQBJuArsSinmYwm1fAXuLK4bdgg1gEVCSef73ACmKLCoRIzFn4gBGiRlDi5Mwn
        YDWcAi4SPU3vmEFsZgF1iT/zLkHZ8hLb385hnsDIPwtJyywkZbOQlC1gZF7FKJeYU5qrm5uY
        mVOcmqxbnJyYl5dapGuml5tZopeaUrqJERLwQjsY15+UO8QowMGoxMP7omZOhBBrYllxZe4h
        RkkOJiVRXtkCoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3gMXgXK8KYmVValF+TApaQ4WJXHe
        n4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8NsDIFhIsSk1PrUjLzClBSDNxcIIM5wEargFSw1tc
        kJhbnJkOkT/FqCglzvv6DlBCACSRUZoH1wtLSK8YxYFeEeZdDFLFA0xmcN2vgAYzAQ2+fnoW
        yOCSRISUVAOj4iqBlMdaieclTFNtSxJmJgnUvCibcikvKFP96LODjxfMkz1vv3X7robZfOZb
        9VlMw7QP7Ak61HMqZy/n5DlPA5f9CAt4cW63b3SAhofDSYVL3NYcjSoLrX7kHjjYxss0fdfu
        L8uFztQv+L/n9+U/5o/qTDXMPbzX7HLeHC+j+UdEa879q4cllViKMxINtZiLihMBYFIMoyMD
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/2017 08:58 PM, Jeff King wrote:
> On Thu, Feb 09, 2017 at 02:26:57PM +0100, Michael Haggerty wrote:
> [...]
>> A `files_ref_store` would be perfectly happy to represent, say, the
>> references *physically* stored in a linked worktree (e.g., `HEAD`,
>> `refs/bisect/*`, etc) even though that is not the complete collection
>> of refs that are *logically* visible from that worktree (which
>> includes references from the main repository, too). But the old code
>> was confusing the two things by storing "submodule" in every
>> `ref_store` instance.
>>
>> So push the submodule attribute down to the `files_ref_store` class
>> (but continue to let the `ref_store`s be looked up by submodule).
> 
> I'm not sure I understand all of the ramifications here. It _sounds_ like
> pushing this down into the files-backend code would make it harder to
> have mixed ref-backends for different submodules. Or is this just
> pushing down an implementation detail of the files backend, and future
> code is free to have as many different ref_stores as it likes?

I don't understand how this would make it harder, aside from the fact
that a new backend class might also need a path member and have to
maintain its own copy rather than using one that the base class provides.

I consider it an implementation detail of the files backend that it
needs to keep a permanent record of its submodule path in
files_ref_store. Some hypothetical future backend might instead need,
say, an IP number and port to connect to a MySQL server. A hypothetical
pure packed-refs backend might just store the path of the packed-refs file.

A more likely imminent change is that backends need a path, but that the
path needn't correspond to the git_dir of the repository that contains
the corresponding objects, for example in the case of a linked worktree.
You might ask for the ref_store for a worktree-submodule, and end up
getting a compound object that delegates to one ref_store pointing at
its git_dir and one at its common_dir.

Michael

