Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D59AC48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 04:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D017060FEE
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 04:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhFNEMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 00:12:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50830 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhFNEMq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 00:12:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EADCBE07D;
        Mon, 14 Jun 2021 00:10:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Sqn5iQA1dlq6VsHfoDBlOpBmfQW/YnDm0oXPU
        cyicQ=; b=wIOv3Eeak4DYezhjX3VwlEHj8UOufdmC4Xkmq0hgBFuadiidkZpTcw
        aUFMwziH5l1U66l4c0qoO1jMzreXq65QipOLWWUgPFElzCi0klR0a+VEKC8CaT5i
        QYNJYbFeNu3yzgApfOhN79Llj5v8bfR8s/HkXU8pFA665sPXvnuUU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36C2ABE07A;
        Mon, 14 Jun 2021 00:10:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B83C8BE079;
        Mon, 14 Jun 2021 00:10:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/4] Fixed t6020 bash compatible issue and fixed
 wrong sideband suffix issue
References: <87im2s5jjm.fsf@evledraar.gmail.com>
        <20210612050711.4057-1-worldhello.net@gmail.com>
Date:   Mon, 14 Jun 2021 13:10:43 +0900
In-Reply-To: <20210612050711.4057-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sat, 12 Jun 2021 13:07:07 +0800")
Message-ID: <xmqqa6ntytks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D0096C0-CCC6-11EB-BC3D-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> In addition to fix the bash incompatible issue of t6020, find another
> issue when try to rewrite t5411 to compare raw command output.

Do the three later patches depend on the t6020 fix, or is this made
a 4-patch series only for the convenience of sending them out?

It's not like get_abbrev_oid() used in t6020 is defined in a common
part of the test library and later used by other tests (instead, the
patches duplicate this helper function into yet two more files).

