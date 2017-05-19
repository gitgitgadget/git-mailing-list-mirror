Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7EC3201A7
	for <e@80x24.org>; Fri, 19 May 2017 10:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbdESKN5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 06:13:57 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:23525 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbdESKN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 06:13:57 -0400
Received: from [192.168.2.201] ([92.22.40.87])
        by smtp.talktalk.net with SMTP
        id BeuwdX2Q8gKstBeuwdqebS; Fri, 19 May 2017 11:13:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1495188835; bh=QG7u9NB9vWYjwXApTw3p//F+VllLGhEcNPWPqxHQMOs=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aq4LDkdZT83vb8RU9gsw6yS1ALbQHdPi+ZjO27rspIsE+yT6eaJcI0Dv3u7sKtRuM
         9JQzbsogV105q+vxJYGJNri1mDNpeTwkPKVK/9FUdxNMz9LmcKxeOYbrCufN0Ji5ID
         No+v3+Kcdkd7/LLzI9aXCFXDElJqaAhMKfauBeHc=
X-Originating-IP: [92.22.40.87]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=Uk7VDCfhaeB8IHNEy8al/Q==:117
 a=Uk7VDCfhaeB8IHNEy8al/Q==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=GwuWsYX1Cd_M_qns_d8A:9 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: Add missing newline to end of message
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org
References: <20170518134154.12771-1-phillip.wood@talktalk.net>
 <alpine.DEB.2.21.1.1705182321030.3610@virtualbox>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <406d017b-b138-72db-d5ad-14ccf5d1f3d4@talktalk.net>
Date:   Fri, 19 May 2017 11:13:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1705182321030.3610@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD3YdDycjU6DtvTh9XQiWJ/iyHc3/9idO4VUmp/D4rMP4T/SxLJYxvGLwkqIfoceCg1JBCMUa251h8ocwPraN9R2PxjboMJlftHoaNzw15y91Gtf+N47
 9mFTM4Ezv0OlvtOQw3emzv3pf7W17mhvDPoAWhdRe84QUW4A/f6qK5puATjsE6PEyJ2qtplRhSVKenmMorx/yVL+Ok7VPJkjN0lx+VIBNc/GeX7Gf9mrqxca
 QOcTl4Es2wrLkIKZnZikGA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/05/17 22:21, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Thu, 18 May 2017, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The message that's printed when auto-stashed changes are successfully
>> restored was missing '\n' at the end.
>> ---
> 
> Please add your Signed-off-by:, and my Acked-by:

Will do (I forgot to add --signoff to git commit). Do I need to resend
the other patches with your Acked-by: or will that happen when Junio
applies them?

I was thinking about this last night and wonder if it would be better to do

-		printf(_("Applied autostash."));
+		printf("%s\n", _("Applied autostash."));

rather than

-		printf(_("Applied autostash."));
+		printf(_("Applied autostash.\n"));

as it would avoid changing the translated string and also mean that the
newline couldn't be accidentally removed any typos in the translation.

Best Wishes

Phillip
