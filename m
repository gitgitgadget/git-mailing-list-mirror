Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DD3D201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 22:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753740AbdKOWKy (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 17:10:54 -0500
Received: from cp-27.webhostbox.net ([208.91.198.76]:38936 "EHLO
        cp-27.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752585AbdKOWKt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 17:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=unimetic.com; s=default; h=Message-ID:References:In-Reply-To:Subject:Cc:To:
        From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iUhKrDkvoJ7Qj/2Kz6XGcQF/IutziMiNfhOvSxNGq0k=; b=gMa3V6OvEqnFoeQUl/XuL9gRnT
        JO40x35CBnD64QUkaU39AAzd0cNo+Pn+PZez+6p98yYDu2T1OwIKUkyS2QlVu/qwk0lgiFDR2BUc2
        HwTPzFG7cnNwUu08wZxCUNcri0rmQwnSP2biGxmSZke4gOMTf6sD6pV/LxMQU1/r+hcdu6C0XCbtR
        4fyToi2jWbceslov+lHOYXp21pcnGR+ohm2QPjZihlVcLdZUqYtlXu+ZfVMTL0RUCqVt3EgvlFkez
        xeA5r8919i0/6nlEeZJ5Rtzh3zxBhSDsJFoQgHW6DEgftkUPQ6nngFqeSZ0pMoKKZXbYrX02qKfL1
        xnYDTtHw==;
Received: from [127.0.0.1] (port=36610 helo=unimetic.com)
        by cp-27.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <hsed@unimetic.com>)
        id 1eF5tQ-001tyO-OL; Wed, 15 Nov 2017 22:10:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 15 Nov 2017 22:10:48 +0000
From:   hsed@unimetic.com
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: [PATCH V2] config: add --expiry-date
In-Reply-To: <xmqqshdh2wln.fsf@gitster.mtv.corp.google.com>
References: <20171112145535.gb4nafdhhdslknex@sigill.intra.peff.net>
 <1510625073-8842-1-git-send-email-hsed@unimetic.com>
 <xmqqshdh2wln.fsf@gitster.mtv.corp.google.com>
Message-ID: <d1c0558cd56b4509c3e34daa48fd528d@unimetic.com>
X-Sender: hsed@unimetic.com
User-Agent: Roundcube Webmail/1.2.3
X-Authenticated_sender: hsed@unimetic.com
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp-27.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - unimetic.com
X-Get-Message-Sender-Via: cp-27.webhostbox.net: authenticated_id: hsed@unimetic.com
X-Authenticated-Sender: cp-27.webhostbox.net: hsed@unimetic.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-14 06:38, Junio C Hamano wrote:
> hsed@unimetic.com writes:
> 
>> From: Haaris <hsed@unimetic.com>
>> 
>> Description:
>> This patch adds a new option to the config command.
>> 
>> ...
>> 
>> Motivation:
>> A parse_expiry_date() function already existed for api calls,
>> this patch simply allows the function to be used from the command 
>> line.
>> 
>> Signed-off-by: Haaris <hsed@unimetic.com>
>> ---
> 
> Please drop all these section headers; they are irritating.  Learn
> from "git log --no-merges" how the log messages in this project is
> written and imitate them.  Documentation/SubmittingPatches would be
> helpful.
> 
> 	Add --expiry-date as a new type 'git config --get' takes,
> 	similar to existing --int, --bool, etc. types, so that
> 	scripts can learn values of configuration variables like
> 	gc.reflogexpire (e.g. "2.weeks") in a more useful way
> 	(e.g. the timesamp as of two weeks ago, expressed in number
> 	of seconds since epoch).
> 
> 	As a helper function necessary to do this already exists in
> 	the implementation of builtin/reflog.c, the implementation
> 	is just the matter of moving it to config.c and using it
> 	from bultin/config.c, but shuffle the order of the parameter
> 	so that the pointer to the output variable comes first.
> 	This is to match the convention used by git_config_pathname()
> 	and other helper functions.
> 
> or something like that?

Hi,
I am sorry for not following the format properly. I will change this for
next patch update.

> 
>> +		} else if (types == TYPE_EXPIRY_DATE) {
>> +			timestamp_t t;
>> +			if(git_config_expiry_date(&t, key_, value_) < 0)
> 
> Style.

Sure.

> 
> 	if (git_config_expiry_date(&t, key_, value_) < 0)
> 
>> +				return -1;
>> +			strbuf_addf(buf, "%"PRItime, t);
>> ...
> 
> Thanks.


Kind Regards,
Haaris
