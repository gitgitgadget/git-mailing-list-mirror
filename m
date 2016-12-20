Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D77131FF6D
	for <e@80x24.org>; Tue, 20 Dec 2016 06:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758578AbcLTG5k (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 01:57:40 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:47827 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757395AbcLTG5j (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Dec 2016 01:57:39 -0500
X-AuditID: 12074414-773ff70000004a85-2f-5858d65f6abf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 55.F4.19077.F56D8585; Tue, 20 Dec 2016 01:57:37 -0500 (EST)
Received: from [192.168.69.190] (p57907272.dip0.t-ipconnect.de [87.144.114.114])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBK6vYtB022746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 20 Dec 2016 01:57:35 -0500
Subject: Re: [PATCH 1/5] check-ref-format: Refactor out check_one_ref_format
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
References: <20161104191358.28812-1-ijackson@chiark.greenend.org.uk>
 <20161104191358.28812-2-ijackson@chiark.greenend.org.uk>
 <3e277bb8-bd1f-0d8c-47a7-9673ad711bce@alum.mit.edu>
 <22615.56956.698915.2223@chiark.greenend.org.uk>
Cc:     git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <52fb55b4-98ca-0e76-37bb-3536b7495c1b@alum.mit.edu>
Date:   Tue, 20 Dec 2016 07:57:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <22615.56956.698915.2223@chiark.greenend.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqJt4LSLCoO0bj0XXlW4mi9Uti1gc
        mDy+ndrE7PF5k1wAUxSXTUpqTmZZapG+XQJXxrWj/9kK7rNVrD/1mbGB8QhrFyMnh4SAicSq
        nx/Yuxi5OIQELjNK/Du8gxHCucAksXhvMwtIlbCAj8S+k/3MILaIgKHEuXnH2CCKXgB1zOgD
        K2IWEJdYN/c8O4jNJqArsainmQnE5hWwl3i9tBmsmUVAVaJj93Ww1aICIRKX5xxlg6gRlDg5
        8wnYHE4BW4kpW/rYIGbqSey4/osVwpaX2P52DvMERv5ZSFpmISmbhaRsASPzKka5xJzSXN3c
        xMyc4tRk3eLkxLy81CJdC73czBK91JTSTYyQkBTZwXjkpNwhRgEORiUe3o7qiAgh1sSy4src
        Q4ySHExKorz7eYBCfEn5KZUZicUZ8UWlOanFhxglOJiVRHjdTwHleFMSK6tSi/JhUtIcLEri
        vN8Wq/sJCaQnlqRmp6YWpBbBZGU4OJQkeHmvAjUKFqWmp1akZeaUIKSZODhBhvMADU+/AjK8
        uCAxtzgzHSJ/ilGX48D7FU+ZhFjy8vNSpcR5+UAGCYAUZZTmwc2BpZJXjOJAbwnzJoJU8QDT
        ENykV0BLmICWLOwOB1lSkoiQkmpgbH9mZf7okjCHq9zqA0+K31edMslX33FYi7O46e3dSdPm
        RjT8FlOxuFb70yzOyNP8Us7OP0fZdgn7fsp4EBDC16RardB2XnHrtf8v9k6+ynjCWKXn/qo5
        t2Rf3teTt90lvWb2l2mfg6tq1n+QUlu+9NCKBe+8YhIb3q23b9z/wkXszO+LVY6bLimxFGck
        GmoxFxUnAgBVnYOGAAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/19/2016 02:19 PM, Ian Jackson wrote:
> Michael Haggerty writes ("Re: [PATCH 1/5] check-ref-format: Refactor out check_one_ref_format"):
>> On 11/04/2016 08:13 PM, Ian Jackson wrote:
>>> +static int check_one_ref_format(const char *refname)
> ...
>> This function needs to `return 0` if it gets to the end.
> 
> Indeed it does.  I'm kind of surprised my compiler didn't spot that.

Our build system has a `DEVELOPER` option [1] that turns on lots of
errors and warnings, and you should turn it on if you haven't already:

    echo DEVELOPER=1 >>config.mak

What exactly it catches depends on what compiler you are using, but it
definitely helps if you are using gcc, and I think also if you are using
clang.

Michael

[1]
https://github.com/git/git/blob/6610af872f6494a061780ec738c8713a034b848b/Documentation/CodingGuidelines#L174-L177
