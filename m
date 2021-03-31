Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D09C43461
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 23:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA406108C
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 23:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhCaXHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 19:07:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62156 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhCaXHm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 19:07:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C68D11FDF0;
        Wed, 31 Mar 2021 19:07:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SkAJicBdm1qJ
        iy5hIH6XSz92C3w=; b=fx00eUTFINYWHea4qH9A8rDHwS5wK8rY7wNe3gLyyW0c
        f5ivKBjqhdPGGHuzbpYiY6I2GTe43JY5ggM5WqIsM1tljQKGZt478OlDnRhQ4lnO
        kosixDAasOiUjTg7Bz8GuzDQm0RnIPrSbRA5Bn9vRNV9y8o3w2w9sh2ZF5RL09M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Yzpwy0
        i+/5htckxmCx6TZct03fJeBHEKa4uPQwpSUMCrMYWAslZalXOhoQ/u7nCwsmCdoT
        Ox65hjXgg0qE21AZwpCzaiQcuqW5yXk4as+kh0ZEq7SWDVWJhzSyC1sYhhfKuoGL
        toJmzAfsdpEj8sUQ8CWkbDSO7Jw8sD3+gogd4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 365C511FDEF;
        Wed, 31 Mar 2021 19:07:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6D6D611FDEE;
        Wed, 31 Mar 2021 19:07:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 06/18] diff tests: test that "mode" is passed when
 sorting
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
        <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
        <patch-06.19-0be013e47c4-20210331T190531Z-avarab@gmail.com>
Date:   Wed, 31 Mar 2021 16:07:37 -0700
In-Reply-To: <patch-06.19-0be013e47c4-20210331T190531Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 Mar
 2021 21:09:34
        +0200")
Message-ID: <xmqq5z166hxi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3BDFD16-9275-11EB-9ACF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Piggy-back on the recently added fsck tests for mode comparisons in
> mktree and assert that diff-tree also does the right thing in this
> implausible scenario.

The same comment applies.  Just testing the order of "foo" (blob),
"foo." (blob), "foo/" (tree), and "foo0" (blob) in two comparisons
would be a more realistic test that has more practical value.

