Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14769C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 20:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E683D207D8
	for <git@archiver.kernel.org>; Wed, 20 May 2020 20:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C4YpUv33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgETUC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 16:02:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55822 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgETUC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 16:02:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5E0A60233;
        Wed, 20 May 2020 16:02:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GNEMXWUJjY+FjrgaGZ2Nxbc6ddo=; b=C4YpUv
        33nYYwaTq4v7t5/g0OMs82CqpDtY0mpnuTYGXPflCXO4LilaurMNQsFNdbRV4iXo
        WHYi553IZvNG20HOuIISDS4xsaoCKyaBMU3ykvDaPR1CygnY19QEA/AMSkfOjv7L
        566nMutwq5dsMtmM02f74AvAv34v0CrCCzhZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RyXwnEionwZQyYQHKbM5t5vxIMpo8awO
        3J4/4y5Z25azS9Nbneg9FycILaGRSr2LfxU7B/EeboT9uhUZ8/slojkbVqyzouDf
        OV8r0O7T/HJszB5ajEabrG4gKrqvQocWF2MkcWwU2cmslcfQcVSrxIGsBkttxWUZ
        f4jLPIrsf3Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9596E60232;
        Wed, 20 May 2020 16:02:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 13F6360231;
        Wed, 20 May 2020 16:02:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.27.0-rc1
References: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
        <20200520193156.GA4700@coredump.intra.peff.net>
Date:   Wed, 20 May 2020 13:02:24 -0700
In-Reply-To: <20200520193156.GA4700@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 20 May 2020 15:31:56 -0400")
Message-ID: <xmqqmu62v0hb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2F15FB2-9AD4-11EA-8B7C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, May 20, 2020 at 12:17:11PM -0700, Junio C Hamano wrote:
>
>> Git 2.27 Release Notes (draft)
>> ==============================
>> 
>> Updates since v2.26
>> -------------------
>> 
>> Backward compatibility notes
>
> Is it worth mentioning here the reversion of v2 as the default protocol?

Yeah, that is a good suggestion.  The fix inside v2 is not worth
reporting, but the change of the default is noteworthy enough to be
at the top.


