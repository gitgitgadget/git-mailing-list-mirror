Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1E6F1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 02:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeFDC0x (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 22:26:53 -0400
Received: from avasout04.plus.net ([212.159.14.19]:56978 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbeFDC0w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 22:26:52 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id PfCrfFPqDI9T1PfCsfPYam; Mon, 04 Jun 2018 03:26:51 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Z6vC4kZA c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=3DGsdw6vgYpv_-unVCoA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC PATCH 4/7] merge-recursive: fix assumption that head tree
 being merged is HEAD
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        jrnieder@gmail.com
References: <20180603065810.23841-1-newren@gmail.com>
 <20180603065810.23841-5-newren@gmail.com>
 <d8f9f7a4-16c7-8258-1210-ad3d32f3d57b@ramsayjones.plus.com>
 <20180603233747.GB288937@genre.crustytoothpaste.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <00bc05ba-da77-716f-94f5-c414d6020608@ramsayjones.plus.com>
Date:   Mon, 4 Jun 2018 03:26:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180603233747.GB288937@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDqiDFXum1n3V/T/fe3xJ/wHHWcR8mggMmj6XNJocu501o/a9SVOCefdlui9LIxqrFv7TfA0aIpCreomfsU13YiwwjFiwpWzi2g6Bf0gpTxZPS5kaR9s
 ytq4jvGubbugJu03nMU1zN7N1O/O6Mp4zZAw54vcuWNC8jPAgH0JBYw9S45ax16z7C6CQFgFJT5IoA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/06/18 00:37, brian m. carlson wrote:
> On Sun, Jun 03, 2018 at 02:52:12PM +0100, Ramsay Jones wrote:
>> On 03/06/18 07:58, Elijah Newren wrote:
>>> I'm really unsure where the index_has_changes() declaration should go;
>>> I stuck it in tree.h, but is there a better spot?
>>
>> Err, leave it where it is and '#include "tree.h"' ? :-D
> 
> Or leave it where it is and use a forward structure declaration?

Indeed, I had intended to mention that possibility as well.

[Note: the "merge-recursive.h" header file references several
'struct tree *' parameters, but does not itself include a
declaration/definition from any source. So, in all of the six
files that #include it, it relies on a previous #include to
provide such a declaration/definition. I haven't checked, but
I think that it is usually provided by the "commit.h" header (even
on the single occasion that "tree.h" was included!).]


ATB,
Ramsay Jones



