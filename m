Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B022C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7CA61CA5
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhF2BpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:45:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62315 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhF2BpI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:45:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CE799132A35;
        Mon, 28 Jun 2021 21:42:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=oZcnSnTzXRLmijXUXcdZ4E6+v
        RFGJlpVKxocfEeqWCg=; b=aRGHQvEIK+xpWhhA+SyPJsPWPWOAlO5DU7GmwrL8W
        AGhiJDKVZbhU/3NfofqhPTvmaeWljMORyLPd2yL2Hhy13zbwBT0nDTJ7t7qVDGKH
        iIr36+1YJCRF05jRhf+YqO/nSWKb6ozMPAOvAoUNKegexNzBhIB3jbPntgP2022+
        eI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7113132A34;
        Mon, 28 Jun 2021 21:42:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1D301132A32;
        Mon, 28 Jun 2021 21:42:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib.sh: set COLUMNS=80 for --verbose repeatability
References: <patch-1.1-cba5d88ca35-20210621T070114Z-avarab@gmail.com>
        <patch-1.1-765c2793122-20210624T101839Z-avarab@gmail.com>
        <20210627074419.GH6312@szeder.dev>
Date:   Mon, 28 Jun 2021 18:42:37 -0700
Message-ID: <xmqqczs530qa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 498A6B5C-D87B-11EB-B26D-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> This issue is not progress-specific.

As discussed elsewhere with Dscho on a Windows specific workaround,
progress is not the only consumer of term_columns() and the code
being "fixed" here would affect other things like "diff --stat" and
hunk header title (aka funcname).

Together with a typo Peff pointed out, the patch deserves an updated
log message before it becomes ready.  The patch text looks good.

Thanks.


