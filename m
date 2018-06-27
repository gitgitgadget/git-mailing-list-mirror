Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA941F516
	for <e@80x24.org>; Wed, 27 Jun 2018 20:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965649AbeF0U6r (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 16:58:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62564 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965026AbeF0U6q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 16:58:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D656F3B49;
        Wed, 27 Jun 2018 16:58:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=+l9R6Dlnp8LVrisM3AQ7iVs0Mgw=; b=SaVWYdA
        EYJ3XLCUY1paEhJvdF/usyZW7wFlNVPIy++1lWaC6OFkt764a5y9/QtSC/vF6AB/
        pg5afQsv0aNKJI2prwUyFWAHbf0t88YhKZT9oxOdJ0S5oQbLbyvSJI0ru72MhPsV
        tFfPf16SASeiLabVUcS55azhoZK+Fm5+lo0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=Cs+VZQm/td9zHwmHEG+65vkjhvLlfoPPq
        hJ9nC4VWdKyD+PEC93vAPpt95MDDYYSfPqXp+5GTVquxuHS8fiw2bUhY+GaiMyIs
        UCw7cCHYaZZD93BtBQEt6GmyaLgkmsC82iUw+fxBW2qjYSmy9Y4RSrwd/sQXtFeZ
        1W3YOXhCC0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75D92F3B47;
        Wed, 27 Jun 2018 16:58:45 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED124F3B45;
        Wed, 27 Jun 2018 16:58:44 -0400 (EDT)
Date:   Wed, 27 Jun 2018 16:58:43 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] doc: substitute ETC_GIT(CONFIG|ATTRIBUTES) in generated
 docs
Message-ID: <20180627205843.GM20217@zaya.teonanacatl.net>
References: <20180627045637.13818-1-tmz@pobox.com>
 <20180627141430.GA13904@sigill.intra.peff.net>
 <xmqqlgb0goui.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgb0goui.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: E143D66C-7A4C-11E8-A8C0-40570C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> Specifically, I'm thinking of:
>>
>>   1. The pre-built documentation that Junio builds for
>>      quick-install-doc. This _could_ be customized during the "quick"
>>      step, but it's probably not worth the effort. However, we'd want
>>      some kind of generic fill-in then, and hopefully not
>>      "/home/jch/etc" or something.
> 
> That is very likely to happen, actually X-<.

Obviously, we don't want the end result to cause regressions
in the common case or any burden on you.  Would setting the
ETC_GIT(CONFIG|ATTRIBUTES) variables in the dist-doc target
alleviate that concern?

Alternately, we can make the default use generic paths and
require some other knob to enable substituting the actual
paths when building documentation.

I tend to think that the default should be to build
documentation that is accurate for that build, but since
it's something I'll set once for my package builds it's not
a big deal either way to me.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Einstein argued that there must be simplified explanations of nature,
because God is not capricious or arbitrary. No such faith comforts the
software engineer.
    -- Fred Brooks

