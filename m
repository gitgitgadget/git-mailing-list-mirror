Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52CDC7EE23
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 20:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCAUX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 15:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCAUXy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 15:23:54 -0500
X-Greylist: delayed 139 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Mar 2023 12:23:52 PST
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6194214E8D
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 12:23:52 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D445C1E0906;
        Wed,  1 Mar 2023 15:21:30 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=eKKzl5ZRsgagcKHZZZQM/iQh5BbWRqTJ+NSQ2/z
        hcZA=; b=TTgNkx4dVlcIfTRDYAbbeiPpB0/kea7jnk7OeD+CZ+hpkfndAhiIJBE
        Q9ENBbSa/2RnCJgBm+PARnKx7Pq2ioapDAKDnOdvHL+0MnkwAft2VgFgH8bQXxnY
        ZpjIJAbXo7Zh8RlxddhCY1abdRUn3esHDiVcdXiMYot9A1uxjaz0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AAAD51E0905;
        Wed,  1 Mar 2023 15:21:30 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 059B61E0904;
        Wed,  1 Mar 2023 15:21:25 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Wed, 1 Mar 2023 15:21:22 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: t3206-range-diff failures on non x86 arches
Message-ID: <Y/+zwrMBvoggqaL5@pobox.com>
References: <xmqqilfknzen.fsf@gitster.g>
 <Y/+paI8WGSmEbv/w@pobox.com>
 <xmqqv8jkmea1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv8jkmea1.fsf@gitster.g>
X-Pobox-Relay-ID: A46F03F0-B86E-11ED-98ED-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
>> Junio C Hamano wrote:
>>> A release candidate Git v2.40.0-rc1 is now available for testing at
>>> the usual places.  It is comprised of 458 non-merge commits since
>>> v2.39.0, contributed by 78 people, 30 of which are new faces [*].
>>
>> On Fedora, rc1 fails most tests in t3206-range-diff.sh on 3
>> of the 5 supported architectures: aarch64, ppc64le, and
>> s390x.  These tests succeed on i686 and x86_64.  They passed
>> on all arches with rc0.
> 
> Sounds like something d9165bef (range-diff: avoid compiler warning
> when char is unsigned, 2023-02-28) may fix.  Can you try merging it
> to rc1 yourself and see how the result does?

Oh, indeed it does.  Thanks for the pointer.  I'm running
a build with that now.

Sorry for incorrectly suggesting your patch series Peff.  I
should have looked closer. :)

-- 
Todd
