Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FF2C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 17:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C510E206D8
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 17:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLURpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 12:45:53 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:24629 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLURpx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 12:45:53 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Dec 2019 12:45:52 EST
Received: from [192.168.1.22] ([92.30.123.115])
        by smtp.talktalk.net with SMTP
        id iihEio1iVWIpciihEiJSCX; Sat, 21 Dec 2019 17:37:44 +0000
X-Originating-IP: [92.30.123.115]
X-Spam: 0
X-OAuthority: v=2.3 cv=W6NGqiek c=1 sm=1 tr=0 a=hVszgMKWGqZ4UxhHtVHAlQ==:117
 a=hVszgMKWGqZ4UxhHtVHAlQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10
 a=ZZnuYtJkoWoA:10 a=nN7BH9HXAAAA:8 a=PKzvZo6CAAAA:8 a=TZnpnLnYFW_EV6eNzKsA:9
 a=QEXdDO2ut3YA:10 a=hc-nBCV64OwA:10 a=q92HNjYiIAC_jH7JDaYf:22
Subject: Re: Propose promoting 'contrib/rerere-train.sh' to command
From:   Philip Oakley <philipoakley@iee.email>
To:     Tom Miller <jackerran@gmail.com>, git@vger.kernel.org
References: <BZAQIE4YND2I.Z7BFCW7BLH3K@penguin>
 <7b60ce55-700e-0c67-76ac-a983991e49f2@iee.email>
Message-ID: <8a84be21-e512-ac42-3426-524afb92ba9b@iee.email>
Date:   Sat, 21 Dec 2019 17:37:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <7b60ce55-700e-0c67-76ac-a983991e49f2@iee.email>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfFzInrMOhWhjd3fGnI2N8HfUGlZgCPi4IxloUAq9NhqzjgDGjKvzzhB5nsZqWHjq4kRgXPmZGflrpPvYR2ppkiuL1AEl2K+nJ78hdGd0rPOgrwsbfi7M
 OfvyH8RbHjj2BGRWdIiShY+opVUC8WDw8FdTwVL2O7U5xBCXSADzGlpjbp8aJ8q1k5Zaf0q6DMQhKrXcatG464K7TAp+eE1klZM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/12/2019 17:00, Philip Oakley wrote:
> Hi Tom,
>
> On 21/12/2019 02:17, Tom Miller wrote:
>> I would like to propose promoting 'contrib/rerere-train.sh' to one of the
>> following:
>>
>>     1. A builtin c command 'builtin/rerere-train.c'
>>     2. To the top level directory as a built in script 'git-rerere-train.sh'
>>
>> I have recently found myself writing scripts using 'contrib/rerere-train.sh'
>> and I wish it was built into the command. This would make it easier to use
>> rather than having to find it on different platforms. I think it could also
>> benefit from some documentation.
>>
>> I am trying to gauge the interest in this change before spending some time on
>> working on it. I would also appreciate feedback or alternative approaches to
>> what I have suggested. Thank you for your time.
>>
>> Thanks,
>> Tom Miller
> This sounds like a useful capability (especially the documentation!).
>
> I also had aspirations that there should also be a way of exchanging the
> essence of the rerere data when conflicts (e.g. feature vs master branch
> merges) are known locally and ought to be communicable with the patch sets.
>
> see messages:
> <37ccaad0-40b4-ca63-e057-791119d7fa69@talktalk.net>
> <nycvar.QRO.7.76.6.1909261253400.15067@tvgsbejvaqbjf.bet>
>
> Philip
There is also audio of the section of the Virtual Conf in a personal
email <20190914165929.GA22300@sigill.intra.peff.net> (~30MB) if needed.
