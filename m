Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DF441F461
	for <e@80x24.org>; Tue, 14 May 2019 18:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfENSzO (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:55:14 -0400
Received: from outmail148106.authsmtp.co.uk ([62.13.148.106]:14720 "EHLO
        outmail148106.authsmtp.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727262AbfENSzN (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 May 2019 14:55:13 -0400
X-Greylist: delayed 970 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 May 2019 14:55:13 EDT
Received: from mail-c237.authsmtp.com (mail-c237.authsmtp.com [62.13.128.237])
        by punt16.authsmtp.com. (8.15.2/8.15.2) with ESMTP id x4EId0uC008518;
        Tue, 14 May 2019 19:39:00 +0100 (BST)
        (envelope-from bavison@riscosopen.org)
Received: from amoe.lan ([37.152.216.162])
        (authenticated bits=0)
        by mail.authsmtp.com (8.15.2/8.15.2) with ESMTPSA id x4EIcwnd008412
        (version=TLSv1.2 cipher=AES128-SHA bits=128 verify=NO);
        Tue, 14 May 2019 19:38:59 +0100 (BST)
        (envelope-from bavison@riscosopen.org)
Subject: Re: [PATCH] clone: add `--remote-submodules` flag
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <20190513175903.126079-1-bavison@riscosopen.org>
 <87sgtivz2m.fsf@evledraar.gmail.com>
From:   Ben Avison <bavison@riscosopen.org>
Organization: RISC OS Open Ltd
Message-ID: <be6f4de9-ee29-f690-3184-1ff7429a0181@riscosopen.org>
Date:   Tue, 14 May 2019 19:38:58 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87sgtivz2m.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Server-Quench: 89c91b6c-7677-11e9-960e-8434971169dc
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd1YggXA1ZfRRob ESQCJDVBUg4iPRpU DBlFKhFVNl8UURhQ KkJXbgASJgRAAnRQ SnkJW1VdQFx4U2B9 YQ9YIwZafEtLXRto UU5XQ1RQCwdtAxke B1BWVmwLJEIYLH5w bUJjXD5YXk14O050 EUdVR2tVeGBmb2cC UUENfh5ddgMfYxdB aVR2U3IMZ2xTNTQC El17DAgYAR5/HWxe RgYLIABaSEoHVjZ5 AgoPGDIzEAgeWi82 KBA7LlMHFA4fNkw9 WX4A
X-Authentic-SMTP: 61633632303230.1024:706
X-AuthFastPath: 0 (Was 255)
X-AuthSMTP-Origin: 37.152.216.162/2525
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/05/2019 22:12, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, May 13 2019, Ben Avison wrote:
> 
>> +		if (option_remote_submodules == 1) {
> 
> I see you copied this from code above the context, but to check a bool
> variable just use "if (var)" not "if (var == 1)".

OK. Would you prefer I edit the line above it as well? I simply assumed 
that was the way it was preferred to perform the test for some reason.

>> +test_expect_success 'check the default is --no-remote-submodules' '
>> +	test_when_finished "rm -rf super_clone" &&
>> +	git clone --recurse-submodules --no-remote-submodules "file://$pwd/." super_clone &&
> 
> This isn't testing the default, it just tests --no-remote-submodules,
> i.e. if you change the "static int" assignment to "1" (to make this new
> option the default) all these tests will still pass.

That was a cut-and-paste error - I meant to omit both new options as you 
suggest! Good spot.

Ben
