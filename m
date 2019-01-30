Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761A91F453
	for <e@80x24.org>; Wed, 30 Jan 2019 11:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfA3Lh0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 06:37:26 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:45114 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727500AbfA3Lh0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 06:37:26 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0UBafn8032247;
        Wed, 30 Jan 2019 03:37:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : subject : from : in-reply-to :
 date : cc : message-id : references : to; s=20180706;
 bh=ckOZXIFAWLnON3DQxUPAQ5RRGTyrGth2yNDVkXo20mA=;
 b=n/1qC+MNVDrtjyG2tFKfpGPSxJc4BXm7fMz9WY+OB+igZOOeq7PtWWJdGkVD1foQkyWk
 UVIn0SSsjLG3wPgxyOpTl5y5Sea5Fp/MNvDf/GGdTGftOE4lCvE4ch/QpDCnkpe0ggi6
 YCi7xvFs9cEs9Y+SbAECH5stAdBsT1cgOG/JfLykJzqKLJK8JUt076ux6WD5/3u6goIm
 8Ng4BuqCJOi5XR1RekgUOtsNz4AU/lmywBv14wfoUYCPSANOvXJeA+lizOVc6liKyMOD
 5PXSKv6IzCuMZPTK1uLC2zIE+UyLO5wwmweJY4iBNmZWu4h3z7SR1F7OSNqmVswKz3eh NA== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com [17.40.76.7])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2q8n0shgax-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 30 Jan 2019 03:37:20 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; CHARSET=US-ASCII
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM500BRA6Y59H60@ma1-mtap-s03.corp.apple.com>; Wed,
 30 Jan 2019 03:37:20 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM5000006UNDD00@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 03:37:19 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 20246c69c8d4ef0427755ee72490d497
X-Va-E-CD: 9770a944a70acd20bbc6bfe75bee6297
X-Va-R-CD: 0fda362c301ac4a128966086672e69af
X-Va-CD: 0
X-Va-ID: 3fd2fcf7-5cdf-4539-9b42-2d02c6f4f290
X-V-A:  
X-V-T-CD: 20246c69c8d4ef0427755ee72490d497
X-V-E-CD: 9770a944a70acd20bbc6bfe75bee6297
X-V-R-CD: 0fda362c301ac4a128966086672e69af
X-V-CD: 0
X-V-ID: 52829284-a8b6-4601-86dc-3b7b8e1faf3c
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM5000006ULD200@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 03:37:19 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-30_09:,, signatures=0
Received: from [17.234.17.81] (unknown [17.234.17.81])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM500EAS6XGIU70@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 03:37:19 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 01/13] .gitignore: Remove *.s as it matches *.S
 on case insensitive filesystem
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
In-reply-to: <CAPig+cSkm-M7fP=KLOCO5J8OSYCEyjy950AM=VzTnP9C6AcKxw@mail.gmail.com>
Date:   Wed, 30 Jan 2019 03:37:18 -0800
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Message-id: <534F20EC-2B29-46C3-BAD9-3CBE7312257F@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-2-jeremyhu@apple.com>
 <CAPig+cSkm-M7fP=KLOCO5J8OSYCEyjy950AM=VzTnP9C6AcKxw@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3445.104.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_09:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 30, 2019, at 03:33, Eric Sunshine <sunshine@sunshineco.com> wrote:
> 
> On Tue, Jan 29, 2019 at 3:11 PM Jeremy Huddleston Sequoia
> <jeremyhu@apple.com> wrote:
>> This was causing problems with ppc/sha1ppc.S
> 
> What problems, exactly?

The file is ignored, but it shouldn't be.

> 
>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>> ---
>> diff --git a/.gitignore b/.gitignore
>> @@ -195,7 +195,7 @@
>> -*.[aos]
>> +*.[ao]

