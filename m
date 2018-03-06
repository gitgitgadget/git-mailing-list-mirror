Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863DA1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeCFKZo (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:25:44 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:8239 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbeCFKZn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:25:43 -0500
Received: from [192.168.2.201] ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id t9mvelxuClYtpt9mvexF8j; Tue, 06 Mar 2018 10:25:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520331942;
        bh=iLeOt28ErkQeOZLW3CTIIXeevnecGBzfeRTHG4AueiU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZwZCAWkzygH5AbBKg9ZOuYgkQFHn+0Y7x2r3zEhzkdnYoUaoRcgx96hPEnkN21P91
         IBNY4tpECMOvAKHeqnjUcb98FW1n2qYK63veIUvoP6dkUuYGoak3HJatvRXI0tIQ/Y
         49ovY3ZMMdFRIxbFSnAD2UFo6DDlwYyjRDnCRF5g=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=JZeSU3CV c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=J7TzoW_yyM0skqmSNbMA:9 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/9] Correct offsets of hunks when one is skipped
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180305105630.14407-1-phillip.wood@talktalk.net>
 <xmqqbmg29x1n.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <4744ba34-1bfb-4162-dd80-bae92bdd40e1@talktalk.net>
Date:   Tue, 6 Mar 2018 10:25:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmg29x1n.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAhYTy267ya987lkspnWX2vcqbKHDLW5AifEvSvrBU5ieClEJqLl0qKdyZ4bIR87qDS4ybSJeQn7oK+eRFca9BiZ3Uez0v7fDwtI/+a3xsBLoTdMtMWi
 lkaoDELAJ30i/8TChGP06mF4h4Dw2F48/cMbK0gdtlbW/hcL+UFtpw+IMGGD6/3g5omATrNO0Z3eBS/K0Lk960aGVDN4buj6IL+m3XxvtbajUaBTKh8wAlM7
 je/r5Dlq9mU1LVMgDeJgMLAyU6OTgsp82RdPMXni6ucYrTywvcI8Sxt8C/I0mGIVOxk1Q+Y2x14jh/fZ1gBrqTq1rKJJbX/8CyXkArITeno=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/03/18 18:50, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> I've updated these to clean up the perl style in response to Junio's
>> comments on v4.
> 
> I've considered the use of "apply --recount" in this script (eh,
> rather, the existence of that option in "apply" command itself ;-))
> a bug that need to be eventually fixed for a long time, so the copy
> of earlier rounds I've been carrying in my tree were forked from
> 'maint'.

Oh I've been basing this on master, I hope that wasn't a problem.

> I'll queue this round on the same base commit as before to replace;
> I _think_ this is ready for 'next'.

Yes I think so (I've not come up with any new ways to break it, lets see
if someone else can)

> Thanks for working on this.
> 
Thanks, I use add -p quite a lot so it's nice to be able to contribute
something back.

Best Wishes

Phillip
