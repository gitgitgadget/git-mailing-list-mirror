Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE85C433F5
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 17:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE69611CA
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 17:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhJCRfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 13:35:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52034 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhJCRfC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 13:35:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79131160E83;
        Sun,  3 Oct 2021 13:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zTPtWUBxXCeJ
        xHC3lWqj2F6tx3oZDDBaDijxcgk3IS8=; b=Q5R2fGStvtSYqQrHEa0upMey9P4C
        v6pYlPnKbiruLR6iqrdYwgYVt3L+K7Z0/bxxBDa7zaf9jsv2FE+VpZ3GfmSVYk2Y
        GR2g65LBUxIyHXdJtnT7P/N7sW5wSmZ8sX3iE2kwq7RDugC5oYyyoI5EZgXyZ45l
        px1hdKmEXDlmdAY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CED1160E82;
        Sun,  3 Oct 2021 13:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A893B160E80;
        Sun,  3 Oct 2021 13:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/9] test-mergesort: add test subcommand
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
        <522fba5e-1048-3377-45c1-7107b55dc6e1@web.de>
        <xmqq7dew7aqd.fsf@gitster.g> <87o887q0s9.fsf@evledraar.gmail.com>
        <850aa059-61d9-0eba-5809-e0c27a19dfb4@web.de>
Date:   Sun, 03 Oct 2021 10:33:10 -0700
In-Reply-To: <850aa059-61d9-0eba-5809-e0c27a19dfb4@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 3 Oct 2021 12:15:21 +0200")
Message-ID: <xmqqee9210a1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FB4270C0-246F-11EC-8DF4-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Repeatable tests are not essential (the original paper didn't mention
> seeding), but shouldn't be much trouble to implement and would simplify
> comparisons across versions, systems and among testers.
>
> The only downside I can think of is that it may perhaps also simplify
> over-fitting, i.e. I might find micro-tweaks that only work for our
> specific rand() sequence and then misinterpret them as general
> improvements..

Yup, I think you summarized the pros-and-cons nicely.
