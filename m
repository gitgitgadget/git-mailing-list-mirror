Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC18208E3
	for <e@80x24.org>; Thu, 31 Aug 2017 03:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750895AbdHaDmW (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 23:42:22 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58203 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750814AbdHaDmV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Aug 2017 23:42:21 -0400
X-AuditID: 1207440c-7fdff7000000143e-e8-59a7859cf33b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 99.71.05182.C9587A95; Wed, 30 Aug 2017 23:42:20 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC9FB.dip0.t-ipconnect.de [87.188.201.251])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7V3gHxF007031
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 30 Aug 2017 23:42:18 -0400
Subject: Re: [PATCH 07/10] t1404: demonstrate two problems with reference
 transactions
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <caaa44126f18869158872e5473e53478db780ba9.1503993268.git.mhagger@alum.mit.edu>
 <CAGZ79ka+uaBD_1xk6sx9J83KuP4A_mUWVqtyniNusbDeQiUZyQ@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <810bbfa2-4486-e3dd-8243-ea6116f21b2c@alum.mit.edu>
Date:   Thu, 31 Aug 2017 05:42:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79ka+uaBD_1xk6sx9J83KuP4A_mUWVqtyniNusbDeQiUZyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqDundXmkQV+rrMXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs0X3lLeMFj9aepgtNm9uZ3Fg99g56y67x4JNpR7Pevcwely8pOzxeZNcAGsU
        l01Kak5mWWqRvl0CV8bW49dYCjarVRy/9o+pgfG3ZBcjJ4eEgInE1783mbsYuTiEBHYwSTx4
        2sQO4VxgkpjYNpMRpEpYIEKisfcKC4gtIqAmMXPVbDYQm1ngHJPE1APZEA3nGSUe/mpgBkmw
        CehKLOppZgKxeQXsJXrXXQAaxMHBIqAqsXieDkhYFGhm39vL7BAlghInZz4Bm88pECjxub2X
        CWK+usSfeZeYIWxxiVtP5kPF5SW2v53DPIFRYBaS9llIWmYhaZmFpGUBI8sqRrnEnNJc3dzE
        zJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJNjJBo4NnB+G2dzCFGAQ5GJR7eii3LIoVYE8uKK3MP
        MUpyMCmJ8kanLo8U4kvKT6nMSCzOiC8qzUktPsQowcGsJMJrXQaU401JrKxKLcqHSUlzsCiJ
        86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8B5sAWoULEpNT61Iy8wpQUgzcXCCDOcBGu4LUsNb
        XJCYW5yZDpE/xagoJc67GCQhAJLIKM2D64Ulq1eM4kCvCPO+BaniASY6uO5XQIOZgAbHei0F
        GVySiJCSamAMcdgnxLl6y6e53eE2r66Frr9fd6In5JTWvn+tv5cnb9Z7uzkjwfbt44mTRc1+
        TK1NjE8yNvT+tfKY0KtVi9/Mq0z4GSOg7sfzoUeCzevw1pMRSuVXvsp/1b4sPsfs3ovkE89j
        LiamW69XidHu0HM4PZl5crlF78PgK4XyydXL7rIK+Bz1TYxQYinOSDTUYi4qTgQApaROqTED
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/30/2017 07:21 PM, Stefan Beller wrote:
> On Tue, Aug 29, 2017 at 1:20 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> [...]
>> +test_expect_failure 'no bogus intermediate values during delete' '
>> +       prefix=refs/slow-transaction &&
>> +       # Set up a reference with differing loose and packed versions:
>> +       git update-ref $prefix/foo $C &&
>> +       git pack-refs --all &&
>> +       git update-ref $prefix/foo $D &&
>> +       git for-each-ref $prefix >unchanged &&
>> +       # Now try to update the reference, but hold the `packed-refs` lock
>> +       # for a while to see what happens while the process is blocked:
>> +       : >.git/packed-refs.lock &&
>> +       test_when_finished "rm -f .git/packed-refs.lock" &&
>> +       {
>> +               sleep 1 &&
>> +               rm -f .git/packed-refs.lock &
>> +       } &&
>> +       pid1=$! &&
>> +       {
>> +               # Note: the following command is intentionally run in the
>> +               # background. We extend the timeout so that `update-ref`
>> +               # tries to acquire the `packed-refs` lock longer than it
>> +               # takes the background process above to delete it:
>> +               git -c core.packedrefstimeout=2000 update-ref -d $prefix/foo &
>> +       } &&
>> +       pid2=$! &&
>> +       ok=true &&
>> +       while kill -0 $pid2 2>/dev/null
> 
>     If sig is 0, then no signal is sent, but error checking is still
>     performed; this can be used to check for the existence of a
>     process ID or process group ID.
> 
> So the kill -0 is the idiomatic form of "while $pid2 is still alive"?
> ignoring errors due to the dev/null redirection?
> 
> And due to the nature of this test we have to have a busy
> loop, we cannot rate limit the cpu usage inside the loop
> via some shorter sleeps, as ideally we want to observe
> the ref at any time.

Correct on both counts.

I just noticed that there is a stray line `ok=true &&` from an earlier
draft. I'll remove that in v2.

>     In an ideal world this test would instruct the kernel to interrupt
>     the executing program (update-ref) at certain events such as
>     touching/writing/deleting files and in each interrupt we could
>     inspect the file system in a read only fashion.

A tool like `strace` could be used for tests like this, but it would be
terribly non-portable. (But I often use strace manually to check that
the ordering of filesystem events is correct.)

>> +       do
>> +               sha1=$(git rev-parse --verify --quiet $prefix/foo || echo undefined) &&
>> +               case "$sha1" in
>> +               $D)
>> +                       # This is OK; it just means that nothing has happened yet.
>> +                       : ;;
>> +               undefined)
>> +                       # This is OK; it means the deletion was successful.
>> +                       : ;;
>> +               $C)
>> +                       # This value should never be seen. Probably the loose
>> +                       # reference has been deleted but the packed reference
>> +                       # is still there:
>> +                       echo "$prefix/foo incorrectly observed to be C" &&
>> +                       break
>> +                       ;;
>> +               *)
>> +                       # WTF?
>> +                       echo "$prefix/foo unexpected value observed: $sha1" &&
>> +                       break
>> +                       ;;
>> +               esac
>> +       done >out &&
>> +       wait $pid1 &&
>> +       wait $pid2 &&
> 
> oh, you use explicit pids here to check each exit code.
> 
>> If anybody has suggestions for better ways to test these things,
>> please speak up :-)
> 
> I don't think I'd have a satisfactory answer to that, as the timing is inherent
> to the things we test. In other software projects that are less low level, I
> would have suggested to use a time/clock mock, which can be stopped
> and then inspection can be performed at defined states.

I just realized that, given that the main goal here is to check the
value of the reference while `update-ref` is waiting on the
`packed-refs` lock, we can do the test without a busy loop. Instead, we
roughly

	: >.git/packed-refs.lock &&
	{
		git -c core.packedrefstimeout=2000 update-ref -d $prefix/foo &
	} &&
	pid2=$! &&
	sleep 1 &&
	# Verify that update-ref is still running:
	kill -0 $pid2 &&
	# ...verify that the reference still has its old value...
	rm -f .git/packed-refs.lock &&
	wait $pid2 &&
	# ...verify that the reference is now gone...

It's true that this version wouldn't discover incorrect transitional
values of the reference that happen at other times, but that was very
unlikely anyway given the speed disparity between C and shell. I'll make
this change in v2.

Michael
