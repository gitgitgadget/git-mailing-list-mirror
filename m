Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738EAC6369E
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 01:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B8B20C56
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 01:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgLCBee (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 20:34:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57597 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgLCBed (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 20:34:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0FE5810004A;
        Wed,  2 Dec 2020 20:33:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lFh9lpMYylLfqyyGwpl8t0KgQ0Y=; b=PAPLs9
        h2ExgG/P5G/+c16HGLCNOrj5YCle6FwofXOughst1X61qyJrJlt8cXYupzTBHtEK
        CdyOMft4wC0WihNgo8oaK0BfphXCgsBsC/OInkePwUYfKgwj9Ov/1uBNEoWkDN96
        SKLn271ppVLHF+Yfrb0H4VKEXeNzSWQHeZOuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UwabrgtHLAeyJutsSlZBu1yk8+3DdKdL
        nnG/FwRPvb+SL/1TP0fl4cXNaAoav5Yd6BCOezgep1KQMLX14Bhyr4QecszSR/Ru
        3BpFKrImBR8rXp4r5nscNmf9W36HrHcj0ZIkNW11XapSA1arZtqzoPwiHmDv+YRj
        0O09iZriqBY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0867D100049;
        Wed,  2 Dec 2020 20:33:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 052D4100048;
        Wed,  2 Dec 2020 20:33:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Todd Zullinger <tmz@pobox.com>, Arnout Engelen <arnout@bzzt.net>,
        git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: make HTML manual reproducible
References: <20201201095037.20715-1-arnout@bzzt.net>
        <20201201154115.GP748@pobox.com>
        <X8bhdyu/OlscI1ME@camp.crustytoothpaste.net>
        <20201202160755.GX748@pobox.com>
        <X8gnItjchqX4wwmt@camp.crustytoothpaste.net>
Date:   Wed, 02 Dec 2020 17:33:46 -0800
In-Reply-To: <X8gnItjchqX4wwmt@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Wed, 2 Dec 2020 23:45:38 +0000")
Message-ID: <xmqqy2ifisg5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 970FDDC0-3507-11EB-8A1B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-12-02 at 16:07:55, Todd Zullinger wrote:
>> brian m. carlson wrote:
>> > If we want this to be effective, then yes, people will need to upgrade.
>> > But if they're happy with the old behavior on ancient systems, that
>> > shouldn't be a problem.
>> 
>> Indeed.  Is it worth mentioning this at all in INSTALL?
>> Something like:
>> 
>>   -   The minimum supported version of docbook-xsl is 1.74.
>>   +   The minimum supported version of docbook-xsl is 1.74.  For consistent
>>   +   IDs in the HTML version of the user-manual, 1.79.1 or newer is
>>   +   necessary.
>> 
>> perhaps?
>
> I don't know that that's even necessary.  Anyone doing reproducible
> builds is already aware of the required versions in order to do a
> reproducible build, and I don't think the average user is going to be
> super interested.
>
> We can if you feel strongly about it, but I don't personally see it as a
> big deal.

I tend to agree.

The tool being lenient and ignoring a parameter from the future
makes things very simple, and the way the patch is structured,
"stable ID" is not even a build option the builder can enable.
For some version of the toolchain, the option means stable ID and
some older version, it does not mean anything, and that is fine.

We ship our Makefile with "CFLAGS = -g -O2 -Wall" and we do not say
things like "Such and such optimizations are only available if you
use GCC newer than version X.Y"; it is fine to treat the "--param"
the same way here.

