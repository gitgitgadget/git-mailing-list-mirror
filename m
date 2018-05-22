Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1581D1F51C
	for <e@80x24.org>; Tue, 22 May 2018 05:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbeEVFj1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 01:39:27 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:52763 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751002AbeEVFj0 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 22 May 2018 01:39:26 -0400
X-AuditID: 12074411-a87ff70000001186-10-5b03ad0d4de4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id C3.A6.04486.D0DA30B5; Tue, 22 May 2018 01:39:25 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCA18.dip0.t-ipconnect.de [87.188.202.24])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w4M5dM0p014618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 22 May 2018 01:39:23 -0400
Subject: Re: commit-graph: change in "best" merge-base when ambiguous
To:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
References: <e78a115a-a5ea-3c0a-5437-51ba0bcc56e1@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <3705af00-00b7-b620-cc77-eef8f0a73bc1@alum.mit.edu>
Date:   Tue, 22 May 2018 07:39:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e78a115a-a5ea-3c0a-5437-51ba0bcc56e1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1OVdyxxt0D9Rw+LF/susFl1Xupks
        GnqvMFusuDqH2eJHSw+zxdELaxgd2Dx2zrrL7nH32XZGj2e9exg9Ll5S9vi8SS6ANYrLJiU1
        J7MstUjfLoErY/GHZ+wF10UrenZfYGtg3CLYxcjJISFgIrG5q4uti5GLQ0hgB5PE5Wn7mCGc
        80wSzdePMoJUCQu4Skyc8g0sISLwnVHi/JM7YAkhARuJJY2fmUFsNgFdiUU9zUwgNq+AvcSm
        7RA1LAKqErd2dbOA2KICERL3zn9ig6gRlDg58wlYnFPAVmLbgTlgcWYBdYk/8y4xQ9jiEree
        zGeCsOUlmrfOZp7AyD8LSfssJC2zkLTMQtKygJFlFaNcYk5prm5uYmZOcWqybnFyYl5eapGu
        qV5uZoleakrpJkZIuAvuYJxxUu4QowAHoxIP74MLTNFCrIllxZW5hxglOZiURHlLipijhfiS
        8lMqMxKLM+KLSnNSiw8xSnAwK4nwfroEVM6bklhZlVqUD5OS5mBREudlNtkbJSSQnliSmp2a
        WpBaBJOV4eBQkuBduxpoqGBRanpqRVpmTglCmomDE2Q4D9DwnBVANbzFBYm5xZnpEPlTjIpS
        4rzGa4ASAiCJjNI8uF5YOnrFKA70ijAvH0gVDzCVwXW/AhrMBDT44nKwwSWJCCmpBkb596vv
        nj935SZ70eUp1/sK57IrMdzxurJo/41zs/NEPXb92Ft/mFfZYfubtfGcE+c+imrSerplbdT5
        NN6KPXNm/FcJ7y/5kXu5WS/iyfX5QqvPlmy6aNxhfD9GpuZN5McdNbxB1pcN5hfaHd/ssdDv
        MHOddtqMCqPST4UL9kSxdomFlLL1LFyqxFKckWioxVxUnAgAwxiicCIDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/21/2018 08:10 PM, Derrick Stolee wrote:
> [...]
> In the Discussion section of the `git merge-base` docs [1], we have the
> following:
> 
>     When the history involves criss-cross merges, there can be more than
> one best common ancestor for two commits. For example, with this topology:
> 
>     ---1---o---A
>         \ /
>          X
>         / \
>     ---2---o---o---B
> 
>     both 1 and 2 are merge-bases of A and B. Neither one is better than
> the other (both are best merge bases). When the --all option is not
> given,     it is unspecified which best one is output.
> 
> This means our official documentation mentions that we do not have a
> concrete way to differentiate between these choices. This makes me think
> that this change in behavior is not a bug, but it _is_ a change in
> behavior. It's worth mentioning, but I don't think there is any value in
> making sure `git merge-base` returns the same output.
> 
> Does anyone disagree? Is this something we should solidify so we always
> have a "definitive" merge-base?
> [...]

This may be beyond the scope of what you are working on, but there are
significant advantages to selecting a "best" merge base from among the
candidates. Long ago [1] I proposed that the "best" merge base is the
merge base candidate that minimizes the number of non-merge commits that
are in

    git rev-list $candidate..$branch

that are already in master:

    git rev-list $master

(assuming merging branch into master), which is equivalent to choosing
the merge base that minimizes

    git rev-list --count $candidate..$branch

In fact, this criterion is symmetric if you exchange branch ↔ master,
which is a nice property, and indeed generalizes pretty simply to
computing the merge base of more than two commits.

In that email I also included some data showing that the "best" merge
base almost always results in either the same or a shorter diff than the
more or less arbitrary algorithm that we currently use. Sometimes the
difference in diff length is dramatic.

To me it feels like the best *deterministic* merge base would be based
on the above criterion, maybe with first-parent reachability, commit
times, and SHA-1s used (in that order) to break ties.

I don't plan to work on the implementation of this idea myself (though
we've long used a script-based implementation of this algorithm
internally at GitHub).

Michael

[1] https://public-inbox.org/git/539A25BF.4060501@alum.mit.edu/
    See the rest of the thread for more interesting discussion.
[2]
https://public-inbox.org/git/8a9b3f20-eed2-c59b-f7ea-3c68b3c30bf5@alum.mit.edu/
    Higher in this thread, Junio proposes a different criterion.
