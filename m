Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7167A1FCA5
	for <e@80x24.org>; Sat, 31 Dec 2016 07:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbcLaHma (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 02:42:30 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53485 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752817AbcLaHma (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 31 Dec 2016 02:42:30 -0500
X-AuditID: 1207440c-e53ff700000009a1-57-58676161203c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 07.86.02465.16167685; Sat, 31 Dec 2016 02:42:26 -0500 (EST)
Received: from [192.168.69.190] (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV7gNVw021734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 31 Dec 2016 02:42:24 -0500
Subject: Re: [PATCH v3 05/23] raceproof_create_file(): new function
To:     Jeff King <peff@peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <f933f9d3c4c53b42ecc75b7a743ed4bfd390b4c5.1483153436.git.mhagger@alum.mit.edu>
 <20161231061146.gxlbma6w7odho4c7@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <241de54c-63ee-d13c-c9fe-8b420871ac51@alum.mit.edu>
Date:   Sat, 31 Dec 2016 08:42:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161231061146.gxlbma6w7odho4c7@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqJuUmB5h8HORuUXXlW4mi4beK8wW
        Sx6+Zrb40dLD7MDi0dV+hM3jWe8eRo+Ll5Q9Pm+SC2CJ4rJJSc3JLEst0rdL4Mp4feEGc8Ej
        gYob786xNDC+5Oli5OSQEDCR6H71l72LkYtDSOAyo0Tz5nssEM5ZJom5tw8xglQJCzhLHJpw
        kQ3EFhGQlfh+eCNYXEjgEKPEx5X5IDazQIZEz53frCA2m4CuxKKeZiYQm1fAXuLErXVg9SwC
        qhLv+j+DxUUFQiQuzznKBlEjKHFy5hMWEJtTwEVib8d7RoiZ6hJ/5l1ihrDlJba/ncM8gZF/
        FpKWWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11AvN7NELzWldBMjJGx5djB+
        WydziFGAg1GJh7fjWlqEEGtiWXFl7iFGSQ4mJVFeS8vUCCG+pPyUyozE4oz4otKc1GKgzzmY
        lUR4oxPSI4R4UxIrq1KL8mFS0hwsSuK8qkvU/YQE0hNLUrNTUwtSi2CyMhwcShK8TvFAjYJF
        qempFWmZOSUIaSYOTpDhPEDDU8GGFxck5hZnpkPkTzEqSonzTgBpFgBJZJTmwfXC0sorRnGg
        V4R5D4FU8QBTElz3K6DBTECDv8aBDS5JREhJNTCabN/jce/Hz0MP9WdVzLsjerTL1OG90Vv2
        hB3qhTXTJrfVmVpfn7ZI/GnL0+fvpbZ1XfFSnXmMIeLqp0v/5mZLbU0pm9m+fY3u7CkvJuV+
        Dn5itLjJvMPn1rnDLBuLVBSuNTvoXRd44PzqTPG0b5OYa112e1+acLb11PnoKAb1Ii/l16rt
        l56bKLEUZyQaajEXFScCAHfGFsEGAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/31/2016 07:11 AM, Jeff King wrote:
> On Sat, Dec 31, 2016 at 04:12:45AM +0100, Michael Haggerty wrote:
>> [...]
>> +/*
>> + * Callback function for raceproof_create_file(). This function is
>> + * expected to do something that makes dirname(path) permanent despite
>> + * the fact that other processes might be cleaning up empty
>> + * directories at the same time. Usually it will create a file named
>> + * path, but alternatively it could create another file in that
>> + * directory, or even chdir() into that directory. The function should
>> + * return 0 if the action was completed successfully. On error, it
>> + * should return a nonzero result and set errno.
>> + * raceproof_create_file() treats two errno values specially:
>> + *
>> + * - ENOENT -- dirname(path) does not exist. In this case,
>> + *             raceproof_create_file() tries creating dirname(path)
>> + *             (and any parent directories, if necessary) and calls
>> + *             the function again.
>> + *
>> + * - EISDIR -- the file already exists and is a directory. In this
>> + *             case, raceproof_create_file() deletes the directory
>> + *             (recursively) if it is empty and calls the function
>> + *             again.
> 
> It took me a minute to figure out why EISDIR is recursive.
> 
> If we are trying to create "foo/bar/baz", we can only get EISDIR when
> "baz" exists and is a directory. I at first took your recursive to me
> that we delete it and "foo/bar" and "foo". Which is just silly and
> counterproductive.
> 
> But presumably you mean that we delete "foo/bar/baz/xyzzy", etc, up to
> "foo/bar/baz", provided they are all empty directories. I think your
> comment is probably OK and I was just being thick, but maybe stating it
> like:
> 
>   ...removes the directory if it is empty (and recursively any empty
>   directories it contains) and calls the function again.
> 
> would be more clear. That is still leaving the definition of "empty"
> implied, but it's hopefully obvious from the context.

Yes, that's clearer. I'll change it. Thanks!

> [...]

Michael

