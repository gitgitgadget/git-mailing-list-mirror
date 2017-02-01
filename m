Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D336820A78
	for <e@80x24.org>; Wed,  1 Feb 2017 23:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751050AbdBAXy0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 18:54:26 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33260 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdBAXyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 18:54:25 -0500
Received: by mail-pg0-f65.google.com with SMTP id 194so9867pgd.0
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 15:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NzXsckgKz4NxUXbBH6/29O8bgZfAC0eHdrPwOGVsJjE=;
        b=r5RZX7E8O7RT46B/SKtltxqdJwRBdu39nqN3GE5q2W7AFEgoNkNfOot9Uc/mm7iY/4
         LiVba1Y2A67Xsg7+Mhsap4XzCU9o0MpYWufbBMY1QIRzggBiSjS5XlsqCRYS/eY3ij9a
         uQ3QKNG9eab/OJfmX8zZrR1JkcmBjtK+/uHWwmCK6DbKBlrbRGHMbh3FbnHPzBcXvBje
         oEJvuRjhL6kslyh9iImwXviEeweUyAxvjKMrQLiin9rxmADGc39CCv56dsXLK+vTv+ap
         udF6t+7689I1mRHyFJ5sW+Cs+toHlR3KzlDhoppRcVwFeY+WGmN0qTdSp/5W+OMtKBwZ
         mMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NzXsckgKz4NxUXbBH6/29O8bgZfAC0eHdrPwOGVsJjE=;
        b=K6qdgIVheGtDtyldphevXWbxCAmsi9mQwjgqnRpZd5dTWBff/nMsQBZD9V2uWqDWfI
         OqqW2oKyJ2L452KA+t37jy0ymBNb/eqAXjsmO2GxU9xt84pQElelIk8vg8k4GKwundYk
         dsMT+R6AEdjY6kzmgAJqUtGGzmGOUqW5+QDZmW60t/bR4pcxC+7eAd063yRbSHaNXNmS
         jP92x7LTAsjZMDWF6FyDJJEc6ofyLwbIexDQjFKmb1PT91tPVNwj0zslal/KaRl7FgtO
         vCoWb1K5TlFFEMP3isz1hBgKfGXA39khSAlOGYf6My+YNenDZGJ9AaLNFUpg5NmQtIte
         GzKw==
X-Gm-Message-State: AIkVDXKp7EhntgqzgMIeJPFF3uZ3rlejHGaR2YBezeHJHLhQApu0jxP6KWm23WR8MnO9QQ==
X-Received: by 10.84.236.76 with SMTP id h12mr8160401pln.173.1485993264638;
        Wed, 01 Feb 2017 15:54:24 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id t6sm53019920pgt.8.2017.02.01.15.54.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 15:54:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     cornelius.weig@tngtech.com, git@vger.kernel.org
Subject: Re: [PATCH] doc: add note about ignoring --no-create-reflog
References: <20170201220727.18070-1-cornelius.weig@tngtech.com>
        <xmqq4m0do86p.fsf@gitster.mtv.corp.google.com>
        <20170201223520.b4er3av67ev5m3ls@sigill.intra.peff.net>
        <xmqqmve5mrpe.fsf@gitster.mtv.corp.google.com>
        <20170201231939.hxhhujpzyb2cqq7a@sigill.intra.peff.net>
        <xmqqefzhmr02.fsf@gitster.mtv.corp.google.com>
        <20170201233202.p462dggidiiyx6s6@sigill.intra.peff.net>
Date:   Wed, 01 Feb 2017 15:54:23 -0800
In-Reply-To: <20170201233202.p462dggidiiyx6s6@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 2 Feb 2017 00:32:03 +0100")
Message-ID: <xmqq1svhmpqo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Feb 01, 2017 at 03:27:09PM -0800, Junio C Hamano wrote:
>
>> I had the same trouble wording.  Another thing I noticed was that I
>> deliberately left it vague what "default" this does not override,
>> because it appears to me that those who do not set logallrefupdates
>> will get the compiled-in default and that is also not overriden.
>> 
>> IOW, "does not negate the setting of core.logallrefupdates" will
>> open us to reports "I do not have the configuration set, but I still
>> get reflog even when --no-create-reflog is given".
>> 
>>    The negated form `--no-create-reflog` currently does not negate
>>    the default; it overrides an earlier `--create-reflog`, though.
>> 
>> perhaps?
>
> True. I thought the default was "off", and that we merely set the config
> when initializing a repo. But looking again, it really is checking
> is_bare_repository() at runtime.
>
> I still think it is OK to mention, as the description of
> core.logallrefupdates is where we document the behavior and the
> defaults. So even with "I do not have it set", that is still the key to
> find more information.

OK, let's take yours as the final and merge it down to 'next'
soonish.
