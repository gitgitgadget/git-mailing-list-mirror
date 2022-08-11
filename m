Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419F1C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 21:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiHKVfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 17:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiHKVfH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 17:35:07 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340089F0FA
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 14:35:07 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E067142031;
        Thu, 11 Aug 2022 17:35:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Wp/jLNWUeb2O
        mF975Z1ja78RobYe+P5dt1e/C9B+8sk=; b=BnyX3y8q/jmK/vEpR0pfzVjjzYyL
        RXjnA3Nyr/fL2wT1RicZ1mri6AheR6TZ1I8YdUbfjWvCpDhzPtHReqJJgxA+SUJb
        gwvfGE52pR4rOt668WgMJeK3QkDhadaKg2TuCuWGecSAM4DZm5/8ItDlUGCIBULT
        BwiD6g5EliUwcO8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F273214202F;
        Thu, 11 Aug 2022 17:35:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B004114202E;
        Thu, 11 Aug 2022 17:35:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 01/20] git.c: update NO_PARSEOPT markings
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
        <20220725123857.2773963-2-szeder.dev@gmail.com>
        <220725.86mtcxp8ib.gmgdl@evledraar.gmail.com>
        <20220802173754.GA10040@szeder.dev> <xmqqsfmefjja.fsf@gitster.g>
        <20220803213430.GB10040@szeder.dev>
Date:   Thu, 11 Aug 2022 14:35:03 -0700
In-Reply-To: <20220803213430.GB10040@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Wed, 3 Aug 2022 23:34:30 +0200")
Message-ID: <xmqq8rnuea60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 76A2FD64-19BD-11ED-AD1F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

[elided here is a good discussion on how to (re)do command line
completion without NO_PARSEOPT markings]

> ...
> However, I'll definitely need to think more about corner cases, e.g.
> hitting 'git cmd --<TAB>' while outside a repository doesn't even
> reaches parse_options() if that command requires a repository.  But
> let's leave that for later and get this series in shape first.

Yes.  I thought this series was mostly ready, except for a minor
nits in the way things are explained in the proposed log message
in [09/20].  How would we want to proceed from here?

Thanks.

