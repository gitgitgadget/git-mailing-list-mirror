Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E9BA1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 22:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760029AbcLAWh7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 17:37:59 -0500
Received: from mout.web.de ([217.72.192.78]:59607 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757940AbcLAWh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 17:37:57 -0500
Received: from [192.168.178.36] ([79.197.214.90]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyDlZ-1cif3n2JqX-015cVn; Thu, 01
 Dec 2016 23:30:50 +0100
Subject: Re: [PATCH 1/3] compat: add qsort_s()
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
 <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
 <20161201193556.j2odwy3sepaxxq5a@sigill.intra.peff.net>
 <xmqq7f7j9zkd.fsf@gitster.mtv.corp.google.com>
 <20161201201917.nqx3v5fl2ptl3bhr@sigill.intra.peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <955e9bf4-d1cd-f01a-13f1-7a335dea011a@web.de>
Date:   Thu, 1 Dec 2016 23:30:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161201201917.nqx3v5fl2ptl3bhr@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:P/Jqog5eA77p/Ows8RQZOSSRrAUdyh5ZBcRcFxyYywUwcZvVXGD
 vQHnLo+4t944hhfytJ6M6guoywd2rzl3h7013J0uyU9/owakyl7Xt085PngcteF/ULFBXxS
 A7AwUptUwNnMm+nk+L36z03MR+IA1NCO9Lvj/rHBPgdcUTJ/H5Jn3/Y3p9917zyPnLHk2pf
 LOblkfe0ovB+sKRR/JLHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:athA4jd2lTM=:E+G7FQfg/7jxsAPCw7dIY1
 nsmSsj+JEiLpUufjj2WXzQY81yLhYfhQ/PyXmLg/CztQJNaD0gkivTAmolDkuQt1rzfVUrUHQ
 Nx60+Io2tlqf87YdlF95FAJMYeM+feWawUld6JpBnWVLgngrllFGbisMVyoHQtukfqQC/j4SH
 CUoeWgBO9Y4MI830nc3GM5ZNWO3nD7NWUjoZXflUkToL1tyZsCoV5EI66RrKs4g0s55DWfAdW
 qPRHyLBxJXSPSO4jeO3e3/Hqmx7eC104TxDM3QZDOAVjlNzDmlFAwHh+eBuIe8Y4sGFhfjgnH
 LCgcb+PJW6Du6m0ukIt6Nz5jxMBriLcUCwcSv5iWJp3mPO2b0xTqXlfS1Cjnss+gGDA3otPsZ
 KuJa3a9zp/+gxSblQRPrlLr5KxnCAMKIOU0mv2RHKSm/9EyKNUJJesHZrTs1dIBZyPXT4WrsW
 EbXjUfMgHoNfiyKcD3S5nfuBWBWD4Y3swLwdmtTjkiOYZ5YqNfTrn+A7dpmeBSLq2pODsqAEO
 YCp72NpfdgCaPI+FpNakUBvk75RLYisb64sT8ihEyrAbjy+g00896iV7CzmKDk1KjCMHZQJA6
 rH+TMHOZJHLDbuvFBJZ1d2bSXASml5ACKZ3ovl+oXMOo2oTJ1LRSQJ38B0SaAECcvoXcyNaDR
 yw0VQ8UUcET8CO9Eq48MwrOywWz7BxYKVgeQkc8JszOwcMSO3CSeXO7MnRBsGg3xeVedhCPvD
 d2a4qH+khZ0PCaG36TZ96M1XP7bIt82CEBWYo063VWrMcMCjVB4m0b0Dxjo9LfjyE6tQsUYUs
 V81Lk4x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.12.2016 um 21:19 schrieb Jeff King:
> On Thu, Dec 01, 2016 at 12:14:42PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> To make matters more fun, apparently[1] there are multiple variants of
>>> qsort_r with different argument orders. _And_ apparently Microsoft
>>> defines qsort_s, but it's not quite the same thing. But all of that can
>>> be dealt with by having more specific flags (HAVE_GNU_QSORT_R, etc).

AFAIU it went like this:

// FreeBSD 5.0 (2003)
void qsort_r(void *base, size_t nmemb, size_t size,
	void *context,
	int (*compar)(void *context, const void *x, const void *y));

// Microsoft Visual Studio 2005
void qsort_s(void *base, size_t nmemb, size_t size,
	int (*compar)(void *context, const void *x, const void *y),
	void *context);

// glibc 2.8 (2008)
void qsort_r(void *base, size_t nmemb, size_t size,
	int (*compar)(const void *x, const void *y, void *context),
	void *context);

// C11 Annex K (2011)
errno_t qsort_s(void *base, rsize_t nmemb, rsize_t size,
	int (*compar)(const void *x, const void *y, void *context),
	void *context);

>>> It just seems like we should be able to do a better job of using the
>>> system qsort in many cases.

Sure, platform-specific implementations can be shorter.

>> If we were to go that route, perhaps we shouldn't have HAVE_QSORT_S
>> so that Microsoft folks won't define it by mistake (instead perhaps
>> call it HAVE_ISO_QSORT_S or something).

OK.

>> I like your suggestion in general.  The body of git_qsort_s() on
>> systems without ISO_QSORT_S can do
>>
>>  - GNU qsort_r() without any change in the parameters,
>>
>>  - Microsoft qsort_s() with parameter reordered, or
>>
>>  - Apple/BSD qsort_r() with parameter reordered.
>>
>> and that would cover the major platforms.

Yes.

However, for MSys INTERNAL_QSORT is defined for some reason, so the 
platform's qsort(3) is not used there; I guess the same reason applies 
to qsort_s().  If it doesn't then an implementation may want to convert 
a call to the invalid parameter handler (which may show a dialog 
offering to Retry, Continue or Abort) into a non-zero return value.

>> Eh, wait.  BSD and Microsoft have paramters reordered in the
>> callback comparison function.  I suspect that would not fly very
>> well.
>
> You can hack around it by passing a wrapper callback that flips the
> arguments. Since we have a "void *" data pointer, that would point to a
> struct holding the "real" callback and chaining to the original data
> pointer.
>
> It does incur the cost of an extra level of indirection for each
> comparison, though (not just for each qsort call).

Indeed.  We'd need a perf test to measure that overhead before we could 
determine if that's a problem, though.

> You could do it as zero-cost if you were willing to turn the comparison
> function definition into a macro.

Ugh.  That either requires changing the signature of qsort_s() based on 
the underlying native function as well, or using a void pointer to pass 
the comparison function, no?  Let's not do that, at least not without a 
good reason.

René
