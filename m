Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40E3C433FE
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7237610A1
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhJTOpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:45:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59487 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhJTOpY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 10:45:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3891E014E;
        Wed, 20 Oct 2021 10:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=p4v9lVey13N0
        OxksqwUWW/k/vndH16v1MHLCp3gjETo=; b=OKD6LgMok7b5tqiOg//3WdyBxzo6
        vT389W6hZK85U5bS9Rf1ZKty2WW7tYT8BkBkeyW1AwJyezsejAn83e36eTsC/4jk
        6wT9+UcFW5jQ+67ZNtJrHs4TDRng2bj42x8WtJHR8qaP+KokIDxPibZx07CQXvtY
        AnbM1VXS5555H9s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2828E014C;
        Wed, 20 Oct 2021 10:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D6A4E014B;
        Wed, 20 Oct 2021 10:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v2 0/4] for-each-ref: delay parsing of --sort=<atom>
 options + linux-leaks fixes
References: <211020.864k9boo0f.gmgdl@evledraar.gmail.com>
        <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
Date:   Wed, 20 Oct 2021 07:43:07 -0700
In-Reply-To: <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 20 Oct
 2021 15:24:32
        +0200")
Message-ID: <xmqqlf2nrc3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0AB7781A-31B4-11EC-8015-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> I tried to structure this as somethnig that could be merged or queued
> up separately, but the semantic conflict in "branch.c" was difficult,
> as Junio's patch changes how those variables are managed.

I tend to agree that it would have been simpler if you did 1, 2 and
4 first and then rebased 3 on top, possibly as an "after the dust
settles" separate topic.

The releasing of these allocated pieces of memory does make sense.

Thanks.

