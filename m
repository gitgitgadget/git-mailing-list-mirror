Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC00FC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 15:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B72860F25
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 15:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbhHaQAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:00:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54502 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhHaQAM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 12:00:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15106ECD66;
        Tue, 31 Aug 2021 11:59:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zX3twbUUm29s
        gsEFzZmYcKE5s8DSnulQLKJcyGyxD/s=; b=T8B+S7dIl7mvowU6qFTHeTs/ORPV
        RKvylBahqMHut1TZMK1N3XPJq9btgNrVKI62cbMszrwdU9uWhe6HHPvpx1n0unoT
        /fHR53/AENIaWx1/r1I+vpKJp342kgvFkWb3ekOgo0H6kVMjgtKJg5GzXWWHjSTj
        lZd9Oi/iJaFefnQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DFC2ECD63;
        Tue, 31 Aug 2021 11:59:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9032EECD60;
        Tue, 31 Aug 2021 11:59:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] t7900: add '--scheduler=launchctl' parameter to fix test
References: <17313607-7ae8-c37a-7931-7712c7bfdb88@ramsayjones.plus.com>
        <xmqqtuj66hu5.fsf@gitster.g>
        <863717af-8500-1779-b278-be7a785ab011@ramsayjones.plus.com>
Date:   Tue, 31 Aug 2021 08:59:14 -0700
In-Reply-To: <863717af-8500-1779-b278-be7a785ab011@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 31 Aug 2021 01:44:06 +0100")
Message-ID: <xmqq7dg1y59p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 64403BAE-0A74-11EC-BB7E-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 30/08/2021 17:02, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>=20
> [snip]
>>=20
>> This test comes from outside L=C3=A9na=C3=AFc's series.  I guess I am =
seeing a
>> botched semantic merge conflict resolution of mine where the two
>> topics met.
>
> Oops! :( My apologies to you both.
>
> My build of 'seen' had two test failures (t5319.19 and this one), and
> I had to be somewhere else in about 30 mins ...
>
> I should know by now not to rush out a patch ... Sorry to have wasted
> your time.

No, the input was very valuable to me.  Neither topic has enough to
solve the issue because the new test got created in the topic that
does not yet have the --scheduler option in the "git maintenance"
command, and the other topic that added the option does not yet have
the test yet.

Unless one topic is made to build on the other, it is a semantic
context for me to resolve.

Hopefully what is near the tip of 'seen' now has the merge fix.

THanks.

