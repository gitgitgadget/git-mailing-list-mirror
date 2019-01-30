Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA39A1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733280AbfA3TNo (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:13:44 -0500
Received: from ma1-aaemail-dr-lapp02.apple.com ([17.171.2.68]:45870 "EHLO
        ma1-aaemail-dr-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbfA3TNo (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 14:13:44 -0500
Received: from pps.filterd (ma1-aaemail-dr-lapp02.apple.com [127.0.0.1])
        by ma1-aaemail-dr-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0UJBgIJ043723;
        Wed, 30 Jan 2019 11:13:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : subject : from : in-reply-to :
 date : cc : message-id : references : to; s=20180706;
 bh=00sGxW2wmXiyxn692DJjJ+MlOHd8jXKT1712YWRvuoc=;
 b=Bzt+upnoTIRcMpi7glMwM0EYY/ZgG9tQudv7ukCSZ9berFSm2OSw1wIvTCwax73z4qoN
 4v4kFz2MbyoRHrYEiGq3sSt7uzqSlefB0BAPN/HexSJbB1rpgFOd+sMkKd5v345Dk8lt
 dgBkEfi0obkZD6G+b7P6WA05G2Pw7URNjG0Mt7YI++SGZ5TjZ0EzU7W320VcSw7N59qg
 3Hz25ogLddIadsmBIMC6JJrYKYdHjHfxJ4dEvLay+Y9PJVIuuJZMXQkNHVL8wGkc+P8d
 8K7jP6ot2fYtRBQbWSnw7mD73clZal/Z2Z9xNl6Nc8jPlgZB60chrg81mhl4BOFdmuU0 YA== 
Received: from ma1-mtap-s01.corp.apple.com (ma1-mtap-s01.corp.apple.com [17.40.76.5])
        by ma1-aaemail-dr-lapp02.apple.com with ESMTP id 2q8n4386ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 30 Jan 2019 11:13:37 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; CHARSET=US-ASCII
Received: from nwk-relayp-sz02.apple.com
 (nwk-relayp-sz02.apple.com [17.128.113.117]) by ma1-mtap-s01.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM5008FPS2O6NM0@ma1-mtap-s01.corp.apple.com>; Wed,
 30 Jan 2019 11:13:37 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz02.apple.com by
 nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500300RGTE400@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 11:13:37 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 482fa0d912b72e62f127af554db2d44f
X-Va-E-CD: 9770a944a70acd20bbc6bfe75bee6297
X-Va-R-CD: 0fda362c301ac4a128966086672e69af
X-Va-CD: 0
X-Va-ID: 765a6094-648d-4a0e-b78a-7dc1e30436bd
X-V-A:  
X-V-T-CD: 482fa0d912b72e62f127af554db2d44f
X-V-E-CD: 9770a944a70acd20bbc6bfe75bee6297
X-V-R-CD: 0fda362c301ac4a128966086672e69af
X-V-CD: 0
X-V-ID: d124c7ef-83b3-4310-80b3-de8527a6d31a
Received: from process_milters-daemon.nwk-relayp-sz02.apple.com by
 nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500L00S03VB00@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 11:13:37 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-30_14:,, signatures=0
Received: from [17.234.17.81] (unknown [17.234.17.81])
 by nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM5002VNS2PNY90@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 11:13:37 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 01/13] .gitignore: Remove *.s as it matches *.S
 on case insensitive filesystem
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
In-reply-to: <nycvar.QRO.7.76.6.1901301340270.41@tvgsbejvaqbjf.bet>
Date:   Wed, 30 Jan 2019 11:13:36 -0800
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Message-id: <8B5241CB-2E1E-4521-8FE1-A84C4896AE82@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-2-jeremyhu@apple.com>
 <CAPig+cSkm-M7fP=KLOCO5J8OSYCEyjy950AM=VzTnP9C6AcKxw@mail.gmail.com>
 <534F20EC-2B29-46C3-BAD9-3CBE7312257F@apple.com>
 <nycvar.QRO.7.76.6.1901301340270.41@tvgsbejvaqbjf.bet>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3445.104.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_14:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 30, 2019, at 04:42, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Hi Jeremy,
> 
> On Wed, 30 Jan 2019, Jeremy Huddleston Sequoia wrote:
> 
>>> On Jan 30, 2019, at 03:33, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> 
>>> On Tue, Jan 29, 2019 at 3:11 PM Jeremy Huddleston Sequoia
>>> <jeremyhu@apple.com> wrote:
>>>> This was causing problems with ppc/sha1ppc.S
>>> 
>>> What problems, exactly?
>> 
>> The file is ignored, but it shouldn't be.
> 
> As somebody who sometimes (pretty rarely, but definitely more than once a
> year) generates the assembler files to have a deeper look, I really
> understand why *.s is ignored, and I think it should stay ignored.
> 
> What you probably want instead is
> 
> 	# Accommodate for case-insensitive filesystems where *.s would catch
> 	!ppc/sha1ppc.S
> 
> after the `*.[aos]` line.

Thanks for the suggestion.  I didn't know that was possible with .gitignore.  That's a much better solution.  I was expecting this to just stay in our series as upstreamable, but I'm glad you pointed this out.  I got to learn something new and offload a patch.  Thanks!

I'll now be able include this in my followup series of patches that I think can be upstreamed! =)

> Ciao,
> Johannes
> 
>> 
>>> 
>>>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>>>> ---
>>>> diff --git a/.gitignore b/.gitignore
>>>> @@ -195,7 +195,7 @@
>>>> -*.[aos]
>>>> +*.[ao]
>> 
>> 

