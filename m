Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AE9C4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 19:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiJSTlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 15:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJSTlM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 15:41:12 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44EF18B762
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 12:41:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34C9413E821;
        Wed, 19 Oct 2022 15:41:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VMxNy0Kz5L1f
        NkpJ2HitYF55Um3eBf+GyQA96Yb4i/4=; b=cOqgoV8m1F3H7BYI6L8Ank/TC16q
        /hC4RDj5+w2nYuEFCgQBuQ+lbbKR0hMBqKJCyMTpvK310FfsLKUF66+Yiv+jNWPC
        lcIZiPiOuybfXhfyGXIGyXzWB5rlS16TGLWFbSwrw/YapsXXaqw9PZIxhK8/4+bN
        lEpZkuKLrg7OFAc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AC8913E81F;
        Wed, 19 Oct 2022 15:41:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 75B2313E81E;
        Wed, 19 Oct 2022 15:41:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 00/10] run-command API: add run_command_{l,sv}_opt()
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
        <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
        <xmqq4jw1wl6z.fsf@gitster.g>
        <221018.86a65ti70m.gmgdl@evledraar.gmail.com>
        <Y08P0G1Be+5hCVML@coredump.intra.peff.net>
        <xmqq7d0vu8cw.fsf@gitster.g>
        <Y1AujKKPUJFepph5@coredump.intra.peff.net>
        <xmqq7d0vsngp.fsf@gitster.g>
        <Y1BIfEN5ds2kKjjk@coredump.intra.peff.net>
Date:   Wed, 19 Oct 2022 12:41:08 -0700
In-Reply-To: <Y1BIfEN5ds2kKjjk@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 19 Oct 2022 14:57:00 -0400")
Message-ID: <xmqq5ygfr48b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FAF7DC20-4FE5-11ED-A258-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That said, I am not too sad to have both. I would not have bothered to
> do the work to remove the _v() versions with flags. But since Ren=C3=A9
> already did so...

It makes two of us ;-)
