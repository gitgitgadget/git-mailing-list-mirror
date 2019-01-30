Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAA651F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfA3Tpg (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:45:36 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:38684 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727890AbfA3Tpg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 14:45:36 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0UJftpw044628;
        Wed, 30 Jan 2019 11:45:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : subject : from : in-reply-to :
 date : cc : message-id : references : to; s=20180706;
 bh=m0PFMoR2IuTTxfGwtCcmpOA5d3EDG6iwqmnVnFbD7gY=;
 b=MY5wrmUh0i+efU8dO4XuIjNaYSl3XO9PHz0CSpD0TerOzMuk+2wONOa3z6heH7d/VTkV
 48/knRBno43IiRfF7GqXMvkUg302PovsTOL8a3uf8/9HjQHGEWmJ9zAp5kw59jhIYIHV
 RD6asnmnUXayahpByOpSgUq0D452lpqkTewTJcOTXlUwQ+a27LxKnmKBk7agdpdq78dY
 hwDaOrhF1K07dbHvo+V9DvaODVTMsLpnJEHmDPhro6xhbCS8l8gMMF5Uj192XKmAagew
 IHifXkRoDM5oU4H6NUhhKlSXx4KytN10wNfcshRgjNDRpbPorWuOxYIk1WgnJJ1JMaZU gg== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com [17.40.76.7])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2q8n0ssst5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 30 Jan 2019 11:45:30 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; CHARSET=US-ASCII
Received: from nwk-relayp-sz02.apple.com
 (nwk-relayp-sz02.apple.com [17.128.113.117]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM500KZ2TJS09L0@ma1-mtap-s03.corp.apple.com>; Wed,
 30 Jan 2019 11:45:29 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz02.apple.com by
 nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500800SWL4T00@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 11:45:28 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 482fa0d912b72e62f127af554db2d44f
X-Va-E-CD: ce0e3a052b21f89c99676fee358db67e
X-Va-R-CD: 81dd340ab47fdc6f6c23e81a0a8a968f
X-Va-CD: 0
X-Va-ID: 649730d3-45cd-4ff1-8a89-171a89b8c187
X-V-A:  
X-V-T-CD: 482fa0d912b72e62f127af554db2d44f
X-V-E-CD: ce0e3a052b21f89c99676fee358db67e
X-V-R-CD: 81dd340ab47fdc6f6c23e81a0a8a968f
X-V-CD: 0
X-V-ID: 4ae0abab-9238-4149-941d-b475931f9306
Received: from process_milters-daemon.nwk-relayp-sz02.apple.com by
 nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500700SVVN400@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 11:45:28 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-30_15:,, signatures=0
Received: from [17.234.17.81] (unknown [17.234.17.81])
 by nwk-relayp-sz02.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM5007JJTJR6700@nwk-relayp-sz02.apple.com>; Wed,
 30 Jan 2019 11:45:27 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 06/13] Set Apple Git version during build
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
In-reply-to: <nycvar.QRO.7.76.6.1901301439440.41@tvgsbejvaqbjf.bet>
Date:   Wed, 30 Jan 2019 11:45:27 -0800
Cc:     git@vger.kernel.org, peff@peff.net
Message-id: <B19F0115-A78B-4CF4-AE58-7FE5E2FFFB6C@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-7-jeremyhu@apple.com>
 <nycvar.QRO.7.76.6.1901301439440.41@tvgsbejvaqbjf.bet>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3445.104.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 30, 2019, at 05:43, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Hi Jeremy,
> 
> On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:
> 
>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>> ---
>> GIT-VERSION-GEN | 4 ++++
>> 1 file changed, 4 insertions(+)
>> 
>> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
>> index d1a2814ec7..6fb90854b9 100755
>> --- a/GIT-VERSION-GEN
>> +++ b/GIT-VERSION-GEN
>> @@ -3,6 +3,10 @@
>> GVF=GIT-VERSION-FILE
>> DEF_VER=v2.20.1
>> 
>> +if [ -n "$RC_ProjectSourceVersion" ] ; then
>> +	DEF_VER="$DEF_VER (Apple Git-$RC_ProjectSourceVersion)"
>> +fi
> 
> This seems awfully specific to a very specific setup. It won't work when
> building from a Git checkout, either, as `DEF_VER` is not even used then.

Yes.  This one was one of the ones I thought obviously fell into the "this is certainly not upstreamable, but let's discuss a general solution to this problem" category.  Sorry if that wasn't clear.

> And the existing facility is the `version` file. Since you want to build
> this in some sort of automated fashion anyway, you should probably execute
> 
> 	sed -n "s/^DEF_VER=\\(.*\\)/\\1 (Apple Git-$RC_ProjectSourceVersion)/p" \
> 		<GIT-VERSION-GEN >version
> 
> in your automation script. As a bonus, this will work with any unpatched
> Git source code, too!

Oh nice!  Thanks for getting rid of one of our patches.

> 
> Ciao,
> Johannes
> 
>> +
>> LF='
>> '
>> 
>> -- 
>> 2.20.0 (Apple Git-115)
>> 
>> 

