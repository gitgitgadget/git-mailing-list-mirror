Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54A48202A4
	for <e@80x24.org>; Sat,  9 Sep 2017 06:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbdIIGp6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 02:45:58 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:48380 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750817AbdIIGp5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Sep 2017 02:45:57 -0400
X-AuditID: 12074413-3a3ff70000007929-81-59b38e2431f9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 73.35.31017.42E83B95; Sat,  9 Sep 2017 02:45:56 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC859.dip0.t-ipconnect.de [87.188.200.89])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v896js1e020943
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 9 Sep 2017 02:45:55 -0400
Subject: Re: [PATCH v4 00/16] Fix git-gc losing objects in multi worktree
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c627a63e-bb70-9533-f638-e2b9d7ba3d8b@alum.mit.edu>
Date:   Sat, 9 Sep 2017 08:45:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsUixO6iqKvStznSYN0VfYuuK91MFg29V5gt
        uqe8ZbTYvLmdxYHFY+esu+weCzaVely8pOzxeZNcAEsUl01Kak5mWWqRvl0CV8aK7wuYCjrZ
        KtZt28TYwPiepYuRk0NCwERiact21i5GLg4hgR1MEs/eLGQCSQgJnGOSaPjgDGILC3hKTG4+
        xgxiiwikSSye/B7I5uBgFvCSmPexHKLcTGL2prtgM9kEdCUW9TSDjeEVsJdYfPA4mM0ioCKx
        ZkITmC0qECHR9/YyO0SNoMTJmU/AejkFzCVmvlrMCmIzC6hL/Jl3iRnCFpe49WQ+E4QtL9G8
        dTbzBEaBWUjaZyFpmYWkZRaSlgWMLKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM31cjNL9FJT
        SjcxQgJceAfjrpNyhxgFOBiVeHgrtm+KFGJNLCuuzD3EKMnBpCTKe6F2c6QQX1J+SmVGYnFG
        fFFpTmrxIUYJDmYlEd6qLqAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaD
        Q0mC90MPUKNgUWp6akVaZk4JQpqJgxNkOA/Q8M8gNbzFBYm5xZnpEPlTjLocNx5e/8MkxJKX
        n5cqJc6bDFIkAFKUUZoHNweWmF4xigO9Jczr1gtUxQNManCTXgEtYQJaUvJ8A8iSkkSElFQD
        o8qm0v1ZdXXC0pMMuiWLZ79YvVh2ephF22F1EZnvMkrCHeomCjzuDUufbv5+85Hlo8kv557e
        eSbpdQjf0kydj7frjs9mT72xR2L3DOnuz4vVfAv4WFa7P3zXsbT6xblVrTlfLbiZC61jJsq4
        exhuizU6/e9z6RSXifxNe/L2bZvGJm5hWuOyVomlOCPRUIu5qDgRAI/6wVYnAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/23/2017 02:36 PM, Nguyễn Thái Ngọc Duy wrote:
> "git gc" when used in multiple worktrees ignore some per-worktree
> references: object references in the index, HEAD and reflog. This
> series fixes it by making the revision walker include these from all
> worktrees by default (and the series is basically split in three parts
> in the same order). There's a couple more cleanups in refs.c. Luckily
> it does not conflict with anything in 'pu'.
> 
> Compared to v3 [1], the largest change is supporting multi worktree in
> the reflog iterator. The merge iterator is now used (Micheal was right
> all along).

I read over all of the refs-related changes in this patch series. Aside
from the comments that I left, they look good to me. Thanks!

Michael
