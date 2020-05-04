Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69B4C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938D820721
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LU9pBDfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgEDTrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:47:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53436 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgEDTrY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 15:47:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 013655C13E;
        Mon,  4 May 2020 15:47:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fUY5vmBy2Tzb
        1VHQDGrIOYroPmo=; b=LU9pBDfyBc2Ar73ey1Ayxbc4BVuj5gYMuGBBWCgsoosU
        ZIO3oLuW8QV79vKv8FYzqk+ygJmG8afmW+rF8S69MLzz0mX+/ZL8fhI4ZlwLJ+XZ
        qOzjgjk7XvfhyPgiBEGB3W9XnGj+3fqGsEhFX/5/z7kVvDEGipukBIrkfg95ITg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GueiS2
        skAPxMRsbx2xzox4RyjVcWVoPTuLufkY6bUMpb1KQ9G9jqfuzWnW+5W9LV537xgZ
        bYA3F3Z6nqz142HIRHwqD86SxyO/PnYyrna8uO884y7G+Y5OOOwm9/JbXsEZqg5c
        Lp0crQcSa1pwdQn1e5W6x9Cv1yJByD77fnwtI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB3B65C13D;
        Mon,  4 May 2020 15:47:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76E245C13C;
        Mon,  4 May 2020 15:47:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Danh Doan <congdanhqx@gmail.com>, clime <clime7@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: drop arithmetic expansion advice to use "$x"
References: <20200503090952.GA170768@coredump.intra.peff.net>
        <20200503091157.GA170902@coredump.intra.peff.net>
        <20200503114351.GA28680@danh.dev>
        <20200504151351.GC11373@coredump.intra.peff.net>
        <xmqqh7wviud9.fsf@gitster.c.googlers.com>
        <20200504160709.GB12842@coredump.intra.peff.net>
        <20200504162844.GE86805@Carlos-MBP>
        <20200504163325.GA18103@coredump.intra.peff.net>
Date:   Mon, 04 May 2020 12:47:20 -0700
In-Reply-To: <20200504163325.GA18103@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 4 May 2020 12:33:25 -0400")
Message-ID: <xmqqy2q7fpo7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 11BFFB1E-8E40-11EA-B32D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, May 04, 2020 at 09:28:44AM -0700, Carlo Marcelo Arenas Bel=C3=B3=
n wrote:
>
>> On Mon, May 04, 2020 at 12:07:09PM -0400, Jeff King wrote:
>> > -- >8 --
>> > Subject: CodingGuidelines: drop arithmetic expansion advice to use "=
$x"
>> >=20
>> > The advice to use "$x" rather than "x" in arithmetric expansion was
>> > working around a dash bug fixed in 0.5.4. Even Debian oldstable has
>> > 0.5.7 these days.
>>=20
>> that would be oldoldstable, oldstable is actually in 0.5.8 ;)
>
> Oh, you're right. I forgot they're doing an extra layer these days. It
> will officially become obsolete in less than 2 months. :)

Thanks, both.  I'll just do s/0.5.7/0.5.8/ when I add Carlo's
reviewed-by to queue the patch.
