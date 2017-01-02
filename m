Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C52205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 16:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbdABQ2G (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 11:28:06 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55760 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751536AbdABQ2F (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jan 2017 11:28:05 -0500
X-AuditID: 12074414-773ff70000004a85-e7-586a7f91eda9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id A8.F4.19077.19F7A685; Mon,  2 Jan 2017 11:28:03 -0500 (EST)
Received: from [192.168.69.190] (p5B10411C.dip0.t-ipconnect.de [91.16.65.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v02GRxq4001636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 2 Jan 2017 11:28:00 -0500
Subject: Re: [PATCH v3 20/23] try_remove_empty_parents(): don't trash argument
 contents
To:     Jeff King <peff@peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <6164af2d1f9eeb5bd339b3913e8046c1ea0b02be.1483153436.git.mhagger@alum.mit.edu>
 <20161231064053.prvlw6x6qprzkmw7@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <9215973c-8db1-8f5a-2dc7-3a0137dd5c62@alum.mit.edu>
Date:   Mon, 2 Jan 2017 17:27:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161231064053.prvlw6x6qprzkmw7@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqDulPivCYHWKRdeVbiaLht4rzBZL
        Hr5mtvjR0sPswOLR1X6EzeNZ7x5Gj4uXlD0+b5ILYInisklJzcksSy3St0vgyljdcpm94Lxg
        RevMdUwNjM94uxg5OSQETCTe7m9n7WLk4hASuMwo8bxjJxOEc4ZJorlxFhNIlbBApMSWA3cZ
        QWwRAVmJ74c3MkIUHWKUuL/+IQtIglkgQ6Lnzm9WEJtNQFdiUU8zWDOvgL3Ep2mnwGwWARWJ
        aXtOMYPYogIhEpfnHGWDqBGUODnzCdgcTgEXiWmvP0HNVJf4M+8SM4QtL7H97RzmCYz8s5C0
        zEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkleqkppZsYIWErsoPxyEm5
        Q4wCHIxKPLwdUVkRQqyJZcWVuYcYJTmYlER5n9YBhfiS8lMqMxKLM+KLSnNSi4Fe52BWEuGV
        rAHK8aYkVlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnNTk0tSC2CycpwcChJ8EaBDBUsSk1PrUjL
        zClBSDNxcIIM5wEavgakhre4IDG3ODMdIn+KUVFKnFcDJCEAksgozYPrhaWVV4ziQK8I8z4C
        qeIBpiS47ldAg5mABn+NSwcZXJKIkJJqYMx90/5N9+CqtHd1da96d+VUC3+RvWXXfCrky9UF
        OaKHguWkDrLt4XQKWfoxLPZVt/z1nPqV1yqLzb98vG2nNbdILCUpZvN9ZT5J/5Whhh7Xvld1
        zHAtuHD36qE/L/+v5FwX8cnUVF0qfgkD72T/0hl6krqClhN0+/qEg5V/qUleurP6TmxcoBJL
        cUaioRZzUXEiAKw4c+IGAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/31/2016 07:40 AM, Jeff King wrote:
> On Sat, Dec 31, 2016 at 04:13:00AM +0100, Michael Haggerty wrote:
> 
>> It's bad manners and surprising and therefore error-prone.
> 
> Agreed.
> 
> I wondered while reading your earlier patch whether the
> safe_create_leading_directories() function had the same problem, but it
> carefully replaces the NUL it inserts.
> 
>> -static void try_remove_empty_parents(char *refname)
>> +static void try_remove_empty_parents(const char *refname)
>>  {
>> +	struct strbuf buf = STRBUF_INIT;
>>  	char *p, *q;
>>  	int i;
>> -	p = refname;
>> +
>> +	strbuf_addstr(&buf, refname);
> 
> I see here you just make a copy. I think it would be enough to do:
> 
>> @@ -2305,10 +2306,11 @@ static void try_remove_empty_parents(char *refname)
>>  			q--;
>>  		if (q == p)
>>  			break;
>> -		*q = '\0';
>> -		if (rmdir(git_path("%s", refname)))
>> +		strbuf_setlen(&buf, q - buf.buf);
>> +		if (rmdir(git_path("%s", buf.buf)))
>>  			break;
> 
>   *q = '\0';
>   r = rmdir(git_path("%s", refname));
>   *q = '/';
> 
>   if (r)
>           break;
> 
> or something. But I doubt the single allocation is breaking the bank,
> and it has the nice side effect that callers can pass in a const string
> (I didn't check yet whether that enables further cleanups).

The last patch in the series passes ref_update::refname to this
function, which is `const char *`. With your suggested change, either
that member would have to be made non-const, or it would have to be cast
to const at the `try_remove_empty_parents()` callsite.

Making the member non-const would be easy, though it loses a tiny bit of
documentation and safety against misuse. Also, scribbling even
temporarily over that member would mean that this code is not
thread-safe (though it seems unlikely that we would ever bother making
it multithreaded).

I think I prefer the current version because it loosens the coupling
between this function and its callers. But I don't mind either way if
somebody feels strongly about it.

As an aside, I wonder whether we would be discussing this at all if we
had stack-allocated strbufs that could be used without allocating heap
memory in the usual case.

Michael

