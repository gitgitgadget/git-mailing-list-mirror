Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C85C433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 19:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E51022268
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 19:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QPm495Gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgJRTIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:08:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56247 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgJRTIT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 15:08:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 080C57140A;
        Sun, 18 Oct 2020 15:08:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5PBNjcaATmwmxYxrJK0jp4KXgAg=; b=QPm495
        Gv3FsXPQd3wdy/4hMA8X+XiNMg+rhx2mlQeM3KbwaupXX+HiJTjJiYp6MzLusnWJ
        8FWiM8oVsL/tGahkWWuEqLws6mNnIAq/NhxALw7Ix1+8lU+eiFy6Jd3wJT8szQcj
        BvJ32r6WdVfPb5OuXP58j+9ZSkCapsHmy21wk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ulpzJPb3Gjom4tJVP2qpcYBtycAPOOSy
        97AJXEpeH59aX06vEGp1qmsyO8zl0oPbITdc3EVhIy/yAZkxgvYv1CFSYh/R5xU7
        YwLMwGSgRQJ6oDwx4dhKXz4z/DABn1OFhuzynPPj7WUmwoih3pih8lM/MLVh0BQd
        MIsND5wirVk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3A1571409;
        Sun, 18 Oct 2020 15:08:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 79C1971407;
        Sun, 18 Oct 2020 15:08:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] Clarify and expand description of --signoff
References: <20201015215933.96425-1-bkuhn@sfconservancy.org>
        <59E3B060-63E3-41C2-A7C4-5B2C888F8D68@gmail.com>
        <CAPc5daWenXds=0BW0CXa=4MOF2UxDeQ8DF2+7V9-WkKwCFCDBw@mail.gmail.com>
        <20201016015937.GA3335046@coredump.intra.peff.net>
        <xmqqft6eewc5.fsf@gitster.c.googlers.com>
        <xmqqh7quaqwb.fsf@gitster.c.googlers.com>
        <20201016201119.GA3356073@coredump.intra.peff.net>
Date:   Sun, 18 Oct 2020 12:08:15 -0700
In-Reply-To: <20201016201119.GA3356073@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 16 Oct 2020 16:11:19 -0400")
Message-ID: <xmqqwnzn73og.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47031B4A-1175-11EB-8204-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 16, 2020 at 12:53:56PM -0700, Junio C Hamano wrote:
>
>> > Jeff King <peff@peff.net> writes:
>> >
>> >> What should we change there? We could perhaps bring up signoffs earlier
>> >> or more prominently. Or tie it in to the git-commit docs by saying
>> >> explicitly: these are _our_ project rules for signoffs.
>> 
>> Let's tie this loose end.  How about squashing in something like
>> this?
>
> Thanks for writing this up. I agree it makes the text much better (not
> only in emphasizing the point we've been discussing, but also in general
> clarity).
>
> You said "squashing", but I'd suggest keeping it as its own patch on top
> of Bradley's.

OK, let's do so.

I recall I read that Bradley's patch needs a bit of word/grammo
polishing?

Thanks.
