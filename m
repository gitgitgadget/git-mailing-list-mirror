Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D5BC2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A1A20704
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KQH3tWzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgDXAyg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:54:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60652 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgDXAyg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:54:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C360CEE7E;
        Thu, 23 Apr 2020 20:54:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Csmsy7S+WAaNUP3z+snf2igE6Vo=; b=KQH3tW
        zYZMRTp8GLDY8Wti6S+opzyDdcVClnunBAKGwcfJ/k6fk+n/N3boih7gBBQNQT/Z
        lrsBMYoab3rCdDTw7xgcuV9Mw6NhXUyymhWUGlkILIA5pcmB2QA8TLXgFxqwmNPV
        3G9JumSLTTkn7Iywj773ifWkH1oSZrYL1lO0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KEueBY8WUYVwNsy4lQX38NfAcVZOWwAV
        URTNZbxdPAajhJK9Hu7yuR8XEVQ4W1ajZ3JTCHBHI99dKDum7u/Adoe+3ZXyHn3n
        DuSJGhtxUaN17AzuCxrZXx+wAt7u2Rh2OabGBkPnKiW6Bf9M4/+BuNZgWVqqURK0
        XWSBbR6L3M0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84671CEE7C;
        Thu, 23 Apr 2020 20:54:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9395CEE7B;
        Thu, 23 Apr 2020 20:54:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/4] C: s/0/NULL/ for pointer type
References: <cover.1587648870.git.congdanhqx@gmail.com>
        <c4fac2ae9d10bc426cb26e4a102b808549696763.1587648870.git.congdanhqx@gmail.com>
        <1df91aa4-dda5-64da-6ae3-5d65e50a55c5@ramsayjones.plus.com>
Date:   Thu, 23 Apr 2020 17:54:30 -0700
In-Reply-To: <1df91aa4-dda5-64da-6ae3-5d65e50a55c5@ramsayjones.plus.com>
        (Ramsay Jones's message of "Fri, 24 Apr 2020 01:39:42 +0100")
Message-ID: <xmqqd07xem9l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 288A8B8E-85C6-11EA-940A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Actually, I have a patch somewhere which suppressed the sparse warning
> for the '= { 0 }' token sequence used in these initializations. However,
> I don't seem to be able to find them at the moment! :(

AHHHHHhhhhhhhh.  

Thanks for reminding.  Yeah, I recall that the concensus of those
who were vocal in that old discussion [*1*] was that "= { 0 }"
should be taken as an idiom and should not be subject to s/0/NULL/
conversion.

> [Luc, this topic came up on the sparse and kernel mailing-lists at one
> point, but I didn't get around to posting my patch to the list - something
> came up. Hopefully, I will find some time to find it and post it soon.]


[References]

*1*

https://lore.kernel.org/git/e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com/
