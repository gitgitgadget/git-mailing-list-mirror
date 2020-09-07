Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2120BC43461
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 05:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29D221582
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 05:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIGFg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 01:36:56 -0400
Received: from mail-gateway-shared10.cyon.net ([194.126.200.61]:44134 "EHLO
        mail-gateway-shared10.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbgIGFgx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Sep 2020 01:36:53 -0400
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared10.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1kF9ph-0002Np-HQ
        for git@vger.kernel.org; Mon, 07 Sep 2020 07:36:51 +0200
Received: from [10.20.10.232] (port=55134 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.93)
        (envelope-from <dev+git@drbeat.li>)
        id 1kF9pg-002rkf-CH; Mon, 07 Sep 2020 07:36:48 +0200
Subject: Re: [PATCH] pretty: allow to override the built-in formats
To:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
References: <20200905192406.74411-1-dev+git@drbeat.li>
 <20200905195218.GA892287@generichostname>
 <xmqqeene36t7.fsf@gitster.c.googlers.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <8bb68268-8e4c-749e-b2e0-21b38b70c8bf@drbeat.li>
Date:   Mon, 7 Sep 2020 07:36:47 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqeene36t7.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-OutGoing-Spam-Status: No, score=-3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.09.20 23:59, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
>> Hmm, I'm not sure how I feel about being able to override formats other
>> than "reference".
> 
> Is the idea to introduce a parallel namespace to pretty.<name>?  I
> am not sure why that is a good idea than, say a single variable that
> says "to me, pretty.<name> would override even the built-in names".
> 
> I am not sure how I feel about being able to override built-in
> formats in the first place, though.
> 
> After all, pretty.<name> were introduced so that user-defined ones
> can be invoked with an equal ease as the built-in ones, but
> overriding common understanding among the users of the tool is a
> different story.

I gave a reason for the reference format, at least.

Would you be fine with a patch that just allows to override the
reference format (for the stated reasons)?
