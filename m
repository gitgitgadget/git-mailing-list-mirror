Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86086C388F2
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C98C217A0
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 17:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oR1AUHQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKFRpJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:45:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52338 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgKFRpI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 12:45:08 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A2B4E101249;
        Fri,  6 Nov 2020 12:45:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JSzs63WcahpawIsmQ+54F69X5X8=; b=oR1AUH
        QqzpUV7og0YZ+9dSD7YScswBb46lLToWCvnZA4G1d6Ni8LU/lVFvrPwrRc4l7TlP
        LA/J37vBvp9mglxDAQxchL8OddirYKyVLwWDkgSEFBbneu9wNRxLRg7opaeWx/Zg
        uonD8/1Bp1YDoIFoem4HiFtV+Ydb3WSFRlQKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nALtY4RCBjbFCx7Wtdbg3Ipp4eLrX6/q
        6Zn9EV8WxjB/DKio2tg55xUnguUC/YRTUCDxx7aDJ7NZJTZJIMD+HnTeV9xlPLAg
        3264ORg5KWbBzi2qzoL8MnukNEJMwWCs8CRlPwVkNsYkBSy+PNx+1B6WIWb4TsMG
        QZ+beYroEp8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99C90101248;
        Fri,  6 Nov 2020 12:45:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A721D101247;
        Fri,  6 Nov 2020 12:45:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     hukeping <hukeping@huawei.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Zhengjunling (JRing, Task Force)" <zhengjunling@huawei.com>,
        zhuangbiaowei <zhuangbiaowei@huawei.com>,
        "git@stormcloud9.net" <git@stormcloud9.net>,
        "rafa.almas@gmail.com" <rafa.almas@gmail.com>,
        "l.s.r@web.de" <l.s.r@web.de>
Subject: Re: [PATCH] Lengthening FORMAT_PATCH_NAME_MAX to 80
References: <20201105201548.2333425-1-hukeping@huawei.com>
        <20201105150149.GA107127@coredump.intra.peff.net>
        <xmqqimajijwa.fsf@gitster.c.googlers.com>
        <d5338d5f83584f7caf3ff0f4309f2275@huawei.com>
Date:   Fri, 06 Nov 2020 09:45:01 -0800
In-Reply-To: <d5338d5f83584f7caf3ff0f4309f2275@huawei.com>
        (hukeping@huawei.com's message of "Fri, 6 Nov 2020 08:51:32 +0000")
Message-ID: <xmqqwnyyfkgy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCE93E38-2057-11EB-A5A5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hukeping <hukeping@huawei.com> writes:

>>I do not mind getting rid of the "FORMAT_PATCH_NAME_MAX" constant and
>>replacing it with a variable that defaults to 64 and can be tweaked by a command
>>line option and/or a configuration variable.
>>It does not feel it is worth the effort to replace one hardcoded constant with
>>another hardcoded constant.
>>
>>> Looking at the code which uses the constant, I suspect it could also
>>> be made simpler:
>>>
>>>   - the PATH_MAX check in open_next_file() seems pointless. Once upon a
>>>     time it mattered for fitting into a PATH_MAX buffer, but these days
>>>     we use a dynamic buffer anyway. We are probably better off to just
>>>     feed the result to the filesystem and see if it complains (since
>>>     either way we are aborting; I'd feel differently if we adjusted our
>>>     truncation size)
>>>
>>>   - the logic in fmt_output_subject() could probably be simpler if the
>>>     constant was "here's how long the subject should be", not "here's
>>>     how long the whole thing must be".
>>>
>>> But those are both orthogonal to your patch and can be done separately.
>>
>>Yes, these clean-ups seem worth doing.
>
> Agreed, and I'd like to do it with two separated commits:
> - commit-1,  cleanup the open_next_file() by drop the if (filename.len>=..) statements.
>
> - commit-2,  replace FORMAT_PATCH_NAME_MAX in fmt_output_subject() with a constant
>   in there and make it to 80(or other value?), and drop FORMAT_PATCH_NAME_MAX
>   from log-tree.h.
>
> Is this works for you?

I am not sure what you meant by "Agreed".  I said two things:

 - It is dubious that it is worth the effort to replace a hardcoded
   constant with another.  Making it configurable with command line
   option and/or configuration variable may be worth doing.

 - Two observations Peff made for further clean-up are probably
   worth doing.

If you are agreeing to both of the above and following through, then
yes, it seems like a good plan.  If agreement is only to the former,
it probably still is worth doing.  Anything else, I don't know.
