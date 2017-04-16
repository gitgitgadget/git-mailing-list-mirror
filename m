Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126E81FA14
	for <e@80x24.org>; Sun, 16 Apr 2017 04:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbdDPEwy (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 00:52:54 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43575 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750928AbdDPEwx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 00:52:53 -0400
X-AuditID: 1207440d-029ff70000003721-b6-58f2f8a2ee76
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D2.D2.14113.2A8F2F85; Sun, 16 Apr 2017 00:52:52 -0400 (EDT)
Received: from [192.168.69.190] (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G4qlPr021406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 00:52:48 -0400
Subject: Re: [PATCH v2 10/20] ref-cache: introduce a new type, ref_cache
To:     Duy Nguyen <pclouds@gmail.com>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
 <e90f9afd20cbfc07f8844ba4f81e7369b4b9bb00.1490966385.git.mhagger@alum.mit.edu>
 <CACsJy8Careik7fCtXo_Luu40G8YPXAgZomFKDkCOuuOfEYm7nA@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <8208a712-e6ea-a2e6-f206-9796f056f1af@alum.mit.edu>
Date:   Sun, 16 Apr 2017 06:52:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8Careik7fCtXo_Luu40G8YPXAgZomFKDkCOuuOfEYm7nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqLvkx6cIg9kvBCzWPrvDZNF1pZvJ
        oqH3CrPFkoevmS26p7xltPjR0sNssXlzO4sDu8fOWXfZPRZsKvXoaj/C5vGsdw+jx8VLyh6f
        N8kFsEVx2aSk5mSWpRbp2yVwZaz7+om94DFLxaT+T+wNjA+Yuxg5OSQETCQerlsNZHNxCAns
        YJJoef2ZFcI5xyTxc/paVpAqYQEPiS3XnrGA2CICShJvOrZBdZxnlLh89hsLiMMsMJFJ4sSX
        h0wgVWwCuhKLeprBbF4Be4nNP66BTWIRUJX4/X0JO4gtKhAiMWfhA0aIGkGJkzOfgG3gFAiU
        eD/3KBuIzSygLvFn3iVmCFteYvvbOcwTGPlnIWmZhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOT
        dYuTE/PyUot0jfRyM0v0UlNKNzFCQp13B+P/dTKHGAU4GJV4eC38P0UIsSaWFVfmHmKU5GBS
        EuV1jfkYIcSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE98dpoHLelMTKqtSifJiUNAeLkjiv2hJ1
        PyGB9MSS1OzU1ILUIpisDAeHkgRvzHegRsGi1PTUirTMnBKENBMHJ8hwHqDhciA1vMUFibnF
        mekQ+VOMuhxz7n19zyTEkpeflyolzmvyDahIAKQoozQPbg4sRb1iFAd6S5j3GcgoHmB6g5v0
        CmgJE9AShskfQJaUJCKkpBoY6z5bON2p2BKwdXIOm96HhW+X3flkKMoy78e+oJyXwRveKhjt
        fSCxTfC2wtPHk72VAnvXrmR9IfKp4MGkPO9j50wF3twSCvHgWKO7TevSTHezu4ViEsvmtLtN
        nZMskHxP6BffXAbGigllbOF3G9qW2dkuOdT60/KRrtWRw2f/fF3Imc+1fGX3UiWW4oxEQy3m
        ouJEAAhvfFIsAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/07/2017 01:32 PM, Duy Nguyen wrote:
> On Fri, Mar 31, 2017 at 9:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> +void free_ref_cache(struct ref_cache *cache)
>> +{
>> +       free_ref_entry(cache->root);
>> +       free(cache);
>> +}
> 
> free(NULL) is no-op (and safe). Maybe we should follow the same
> pattern for free_ref_cache(). It's really up to you.

If I look at other `free_*()` functions in our codebase, it doesn't seem
that many of them handle NULL, and that feature wouldn't help the
callers of this function. So I think I'll leave it the way that it is.

Michael

