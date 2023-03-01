Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152D0C7EE23
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 21:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCAVF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 16:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCAVF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 16:05:57 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8560B4ECE2
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 13:05:56 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 757611EF5EE;
        Wed,  1 Mar 2023 16:05:53 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=uAX9qheomF2IVGb1AasU8JES8zlICRmS/ILr4fu
        Al+k=; b=ye9jEpzWu89UEXIFFkzyX0SlAiGInhOepVuFYuHsULDWEiEZ4jZKR36
        /sFTJKYP02f0u2rxlF1Mi2VT0z6lktqiqNWdHCPgDexu5ymJ99z5remVG+OOeqPW
        cbdLajDntgQenT8Pssu2JROJk5P3kv3h7p/P6PmUDRD90HPkHVHI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E5EB1EF5ED;
        Wed,  1 Mar 2023 16:05:53 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7174C1EF5EB;
        Wed,  1 Mar 2023 16:05:49 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Wed, 1 Mar 2023 16:05:46 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: t3206-range-diff failures on non x86 arches
Message-ID: <Y/++KovrW+08XRQc@pobox.com>
References: <xmqqilfknzen.fsf@gitster.g>
 <Y/+paI8WGSmEbv/w@pobox.com>
 <xmqqv8jkmea1.fsf@gitster.g>
 <Y/+zwrMBvoggqaL5@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/+zwrMBvoggqaL5@pobox.com>
X-Pobox-Relay-ID: D7F264B4-B874-11ED-9F42-B31D44D1D7AA-09356542!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wrote:
> Junio C Hamano wrote:
>>> On Fedora, rc1 fails most tests in t3206-range-diff.sh on 3
>>> of the 5 supported architectures: aarch64, ppc64le, and
>>> s390x.  These tests succeed on i686 and x86_64.  They passed
>>> on all arches with rc0.
>> 
>> Sounds like something d9165bef (range-diff: avoid compiler warning
>> when char is unsigned, 2023-02-28) may fix.  Can you try merging it
>> to rc1 yourself and see how the result does?
> 
> Oh, indeed it does.  Thanks for the pointer.  I'm running
> a build with that now.

Confirmed.  That fixes the tests.  Thanks!

-- 
Todd
