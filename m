Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28515C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03ACF603E8
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhJUWhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:37:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63676 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJUWhL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 18:37:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4BBA3150B6D;
        Thu, 21 Oct 2021 18:34:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=o9s2hnhOkh4oRM4zpyDPpwHeXfOgMjjWSO+SdATfGps=; b=SIxm
        caPRPqCuHIF+DTtLtx9n79Wf6sBSU41GeVFqaMAfZvMuIL9gIdRpSm2xrAk+ePa9
        /4zZZ0N9Zl/9tHhx/mbVYLin3GzyaDCttKxUerbZdxkgdmEV3rVuj1W288lAMye9
        v+7iDbkzeRm6LSaEb7IjTmo9dfHnksjnFUIAZe0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43D27150B6C;
        Thu, 21 Oct 2021 18:34:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A634150B6B;
        Thu, 21 Oct 2021 18:34:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 0/8] Makefile: make command-list.h 2-5x as fast with -jN
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
        <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
        <YXB9moNHRj+nrnX9@coredump.intra.peff.net>
        <YXCKqAEwtwFozWk6@nand.local>
        <211021.86v91rmftn.gmgdl@evledraar.gmail.com>
        <YXCqO7WFET6J7gGf@coredump.intra.peff.net>
        <211021.86ilxrmbb9.gmgdl@evledraar.gmail.com>
        <YXF6Wwcvc0vq5ADZ@coredump.intra.peff.net>
Date:   Thu, 21 Oct 2021 15:34:50 -0700
Message-ID: <xmqqh7dahur9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B104D7A-32BF-11EC-96D5-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Now performance isn't everything, and it's possible these partial
> snippets will be useful in other places. But I'm not sure I see any real
> advantage in this series, and it seems like we're taking a hit in both
> performance and complexity in the meantime.

Let's not forget about a hit we are taking in reviewer bandwidth.
And added complexity will cost more over time.  I am not sure if
these 8-patches deserved this much attention, compared to other
neglected topics.
