Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB167C64E90
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 04:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3875020705
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 04:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LWkY8Atk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgLAEqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 23:46:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50501 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387406AbgLAEqx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 23:46:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0B36880DC;
        Mon, 30 Nov 2020 23:46:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Jb9oao9rxO4MxEg1cMxZLhria
        Qs=; b=LWkY8AtkT0n5vfpTWdXoh2WeBdS3hPGgfm8Zpd4L848GNegzcIu27QVTd
        G8+G5MUxaE/7bkLWjbDwCIBe/mhgMYSELJgi3r7ICyiUptuJiyeyN5uSTH5LoFqY
        i0JidZBW8Z0NQfJkPTTzmHaWt2SEA/4C1ooQmJWzSe4f4mQpXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=tqzztaj5bS+Z2J7iQUG
        3w9s1BHwRpFJUCR1IJbyj3xDnjd1qBCh9GMSSpBBSJxRd+Y0P4t8fT+FM9Tit9kr
        ZNbNQ3RN376VlsBlycgbqWzI7q/tLbv80KE8jIghkZ0qeAHLyFyEtdsEf2qCcXU7
        80YEfbPz/9EqMrsoiK8KEKLo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8206880DB;
        Mon, 30 Nov 2020 23:46:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7690F880DA;
        Mon, 30 Nov 2020 23:46:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] grep: simplify "grep defaults" handling
References: <cover.1606251357.git.martin.agren@gmail.com>
        <cover.1606679312.git.martin.agren@gmail.com>
Date:   Mon, 30 Nov 2020 20:46:09 -0800
Message-ID: <xmqqk0u2rv5a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2214F88E-3390-11EB-BCFC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> This is v3 of my series [1] [2] to simplify the setup and use of the
> `struct grep_opt grep_defaults`. The only difference compared to v2 is
> an added comment in the third patch.

Thanks, will queue.
