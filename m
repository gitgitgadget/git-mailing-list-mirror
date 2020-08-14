Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67881C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5FF20768
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VRhdsNtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgHNUZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:25:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61261 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgHNUZI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:25:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39E0E805C6;
        Fri, 14 Aug 2020 16:25:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IF8Cf9j8BhEIwiU8fJLSbd6AuNo=; b=VRhdsN
        tTo2OX8VMiKNQvUlb0Fb/STkAfCKF1JlY3V+20aeQ0EhfJunBtRsYDWeEekKmqwR
        wvgECS4Bp24i5vIqTYeZCwPX4abZWZ2YmN9RbBszaxCi3c8rQ97XAZYhbDWQOZqj
        p4uv1jfKR83Pxh+X2VTxBIw7teWdl2oDKlnUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iuauT5MuUXMYl8o9zZKvcckuPlYi3MuM
        ncO5Al3VmOlw2D+UaiK9oUR6uptNaDshf2yYkDWaMl4U+C/dmaBXC0HyS7dKQ7oS
        NxndatnxEQfG/YyImf3T+jwSUT8T0/reLrnizLz5zNcor04Yi/nbkC0TJ1gdfPmR
        0LooBt/n7o8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29E20805C5;
        Fri, 14 Aug 2020 16:25:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B598805C4;
        Fri, 14 Aug 2020 16:25:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH 0/2] Documentation updates for SHA-256
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
        <da077fb0-14bb-b84f-c526-d759ebc9f5eb@gmail.com>
        <xmqqh7t5zve0.fsf@gitster.c.googlers.com>
        <20200814202031.GM8085@camp.crustytoothpaste.net>
Date:   Fri, 14 Aug 2020 13:25:02 -0700
In-Reply-To: <20200814202031.GM8085@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 14 Aug 2020 20:20:31 +0000")
Message-ID: <xmqqtux5ug9t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CA5EE84-DE6C-11EA-8CD7-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-08-14 at 04:47:19, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>> 
>> > Is that really a concern? Maybe, but also Git will never move data like
>> > that.
>> 
>> I would say that we can safely say that this year ;-) as dumb HTTP
>> would be mostly dead.
>
> We do fetch the refs first for dumb HTTP so last I checked, we correctly
> detected this case and failed.  I'd personally be happy to let the
> DAV-based protocol die, but there are folks who like it.

I didn't mean DAV.  

The oldest dumb HTTP code grabs all packfiles listed in
objects/info/packs and there is nothing to prevent folks from
running the current client to fetch from SHA-256 repository into a
SHA-1 repository.  The resulting packfiles that do not identify with
the version number what hash it uses would be very hard to use.


