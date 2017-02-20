Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C5E0201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 12:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbdBTMkH (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 07:40:07 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:56828 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753193AbdBTMkF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Feb 2017 07:40:05 -0500
X-AuditID: 1207440c-abdff70000002e8f-41-58aae31ba19c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 34.A3.11919.B13EAA85; Mon, 20 Feb 2017 07:37:47 -0500 (EST)
Received: from [192.168.69.190] (p579060C0.dip0.t-ipconnect.de [87.144.96.192])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1KCbijd029343
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 20 Feb 2017 07:37:45 -0500
Subject: Re: [PATCH v4 11/15] refs.c: make get_main_ref_store() public and use
 it
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
 <20170218133303.3682-12-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8f0c7355-008e-8435-b6a7-1d3b4c2ae06a@alum.mit.edu>
Date:   Mon, 20 Feb 2017 13:37:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170218133303.3682-12-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqCv9eFWEwfPJkhZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgymhc8Za14AJbxc3ddQ2Mm1i7GDk5JARMJHZd+MnWxcjF
        ISSwg0li/vUGJgjnPJPE/xPrmEGqhAWCJWasu8AEYosIpEksnvyeGaKon1Hi1Pe77CAOs8AN
        RolLEz+CVbEJ6Eos6mkGs3kF7CX2vHnLBmKzCKhKtN+fDrZbVCBEYs7CB4wQNYISJ2c+YQGx
        OQXMJTa1fmIHsZkF1CX+zLvEDGHLSzRvnc08gZF/FpKWWUjKZiEpW8DIvIpRLjGnNFc3NzEz
        pzg1Wbc4OTEvL7VI11AvN7NELzWldBMjJNx5djB+WydziFGAg1GJh1dj5soIIdbEsuLK3EOM
        khxMSqK8d5asihDiS8pPqcxILM6ILyrNSS0+xCjBwawkwvvmMlCONyWxsiq1KB8mJc3BoiTO
        q7pE3U9IID2xJDU7NbUgtQgmK8PBoSTB+/whUKNgUWp6akVaZk4JQpqJgxNkOA/Q8L8gNbzF
        BYm5xZnpEPlTjLocpz5deMkkxJKXn5cqJc77BKRIAKQoozQPbg4sTb1iFAd6S5jX6xFQFQ8w
        xcFNegW0hAloyU2PlSBLShIRUlINjI3b1p//e2LV/dW2a2Z8muia1v9/zo89HYV9569rZtfX
        N3+Wu/B7lfasjpd3ZD17Q5afXHTzzsZll9ef3TptgVf+wx2+L1lWN+Q3v5VdoMo/VZdHLEjr
        BkP9y23HXhln5l3tD/x64E/djUc+21wVnvgvWdq/qe1Yd5VnXMnRUr+qqKM7xL+6ducrsRRn
        JBpqMRcVJwIAzJpxNy4DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/18/2017 02:32 PM, Nguyễn Thái Ngọc Duy wrote:
> get_ref_store() will soon be renamed to get_submodule_ref_store().
> Together with future get_worktree_ref_store(), the three functions
> provide an appropriate ref store for different operation modes. New APIs
> will be added to operate directly on ref stores.

I see where you're going with this, but as of the end of this patch
series, there is still nothing that a caller outside of the refs module
can do with a `struct ref_store *`. This means that it would be enough
to put this declaration (and that of `get_submodule_ref_store()`, added
in a later patch) in refs/refs-internal.h for now.

If you want to move the declarations straight to `refs.h` now to avoid
code churn in some later patch series, then please mention that fact in
the commit message.

Michael

