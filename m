Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E048F1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbfA3TfN (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:35:13 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:41520 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbfA3TfN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 14:35:13 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0UJR1bA010745;
        Wed, 30 Jan 2019 11:35:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : subject : from : in-reply-to :
 date : cc : message-id : references : to; s=20180706;
 bh=VzZmyr+0qg7EqqRfiRvds0thkqMtgaK4Ey91MQccqyM=;
 b=EFE6+87c10dc6VeDgU/FCtv7j2qef7o7TTRqJkjwQKAhXwoBLR3fUboCmBIFivc5FqE8
 kCPgEh1WelkKYrl/UUy/ROU/OGmClr/FkGo2Ljcr2o2hUimMtavUTLqnPV+OSA5QjcVn
 EuagdRKbvA+w30yc+JwXI9MjcKR7OmPGKQa4Z243US8Sg2CCjmd7d6+qX/5PAS6Y5T56
 IJi4Ot96ymFBdRJbH5TJf9cC7gYt4TjyzAdk84eXKMM0QUehF0kczr3s1X50rl7xyG7r
 LTjiFmV389SijBYA+Hx7Q+qWq5Y7B6U9BgB4thvfmowebkWhI7WUBc7EtKkhKSYcvkKD sw== 
Received: from mr2-mtap-s01.rno.apple.com (mr2-mtap-s01.rno.apple.com [17.179.226.133])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2q8n0ssmrw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 30 Jan 2019 11:35:08 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; CHARSET=US-ASCII
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by mr2-mtap-s01.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM500043T2IMB60@mr2-mtap-s01.rno.apple.com>; Wed,
 30 Jan 2019 11:35:07 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500600SWF7R00@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 11:35:06 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 482fa0d912b72e62f127af554db2d44f
X-Va-E-CD: 47e682a811142687ef91d9d4a103111f
X-Va-R-CD: cd7fc10371c080fa97bb71ddd56ad951
X-Va-CD: 0
X-Va-ID: e55909d3-cf8f-4f57-8940-1f85a7e9d220
X-V-A:  
X-V-T-CD: 482fa0d912b72e62f127af554db2d44f
X-V-E-CD: 47e682a811142687ef91d9d4a103111f
X-V-R-CD: cd7fc10371c080fa97bb71ddd56ad951
X-V-CD: 0
X-V-ID: 469032b1-d3b9-47dd-9bc8-30d86f72c679
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM500500SVEOF00@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 11:35:06 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-30_14:,, signatures=0
Received: from [17.234.17.81] (unknown [17.234.17.81])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM500KLBT2H8GA0@nwk-relayp-sz03.apple.com>; Wed,
 30 Jan 2019 11:35:05 -0800 (PST)
Subject: Re: [PATCH (Apple Git) 05/13] t5701: git --version can have SP in it
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
In-reply-to: <nycvar.QRO.7.76.6.1901301431110.41@tvgsbejvaqbjf.bet>
Date:   Wed, 30 Jan 2019 11:35:05 -0800
Cc:     git@vger.kernel.org, peff@peff.net
Message-id: <9FC095C3-5AC7-4420-887E-24782563A48C@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-6-jeremyhu@apple.com>
 <nycvar.QRO.7.76.6.1901301431110.41@tvgsbejvaqbjf.bet>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3445.104.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_14:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jan 30, 2019, at 05:36, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Hi Jeremy,
> 
> On Tue, 29 Jan 2019, Jeremy Huddleston Sequoia wrote:
> 
>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> 
> 
> That commit message is again very short. Only because I remember the
> previous patch's commit message do I have a clue what this is about.

Yeah, I became lax with commit messages when I was under the impression that the git community was not interested engaging with Apple.  I should have taken a pass through these commits before sending, but I half expected these patches to be ignored.  I am delighted to see that I was wrong and will go back and provide more details in the ones that I feel are upstreamable like this one.

> You definitely need to write something here about customized forks of Git
> adding suffixes including spaces to the Git version.
> 
> And you will need to state where those spaces are converted to dots in
> Git's capability advertisement. The reason for this requirement: should
> that logic change at any stage in the future, your patch will fail,
> somebody will investigate and find this commit and *needs* a helpful
> commit message.

Thanks, I'll add you to the CC of this patch, so you can critique my wording in the updated message.

> 
>> ---
>> t/t5701-git-serve.sh | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
>> index ae79c6bbc0..7bc25700fa 100755
>> --- a/t/t5701-git-serve.sh
>> +++ b/t/t5701-git-serve.sh
>> @@ -7,7 +7,7 @@ test_description='test git-serve and server commands'
>> test_expect_success 'test capability advertisement' '
>> 	cat >expect <<-EOF &&
>> 	version 2
>> -	agent=git/$(git version | cut -d" " -f3)
>> +	agent=git/$(git --version | sed -e "s/git version //" -e "s/ /\./g")
> 
> This `git version` needs to be anchored,

Good catch, thanks.

> and it would be much conciser to
> use `-e "y/ /./"`, which even BSD sed understands according to
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html

Also done, thanks.

> 
> Ciao,
> Johannes
> 
>> 	ls-refs
>> 	fetch=shallow
>> 	server-option
>> -- 
>> 2.20.0 (Apple Git-115)
>> 
>> 

