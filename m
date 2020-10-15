Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84AAC433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A71420674
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AtOmFiDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389872AbgJOTQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:16:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63415 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731043AbgJOTQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:16:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12E43F7A8E;
        Thu, 15 Oct 2020 15:16:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TaljsibJuLGmY1CpPx+pg2JH8ig=; b=AtOmFi
        DDZNzLmJzVq+tkLiBr0m6I4jRc6s9KQEG4Apbgre3xnRg3HnHEt7Ok5rVL324B4i
        IzyX0lBbrBTRlPtpcEHRfsisEY+frIx+UqbPQgbEqiFEPErY+ndDdxncfdwfgvUv
        qxt+jqBiZSwXQSCMP2vUmxf35XQtlKbZJxQXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WMf1QXury8zTmOWMt/RKd2TTqZdRx4Jd
        Iodnqlj8ifN01mzG4cnA6Kdk/e3mAlLI6Tityim9EVXJhnw5hnaaPN7fbqbRELDE
        vZeqPI1luFsTIcmuZ69s0PusXzQBdra+SodjfXna2PajTvVokyG0LW+jPBGXIzbx
        LbA7RLTyqAM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BCF4F7A8D;
        Thu, 15 Oct 2020 15:16:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2AA77F7A8B;
        Thu, 15 Oct 2020 15:16:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, phillip.wood123@gmail.com
Subject: Re: [Outreachy] Introduction
References: <CAPSFM5eK1RFTbdTbF8dHMzcRh1SnSfzqh_5re22qS=KFoVRNJg@mail.gmail.com>
        <CAP8UFD1m2zXUm1PXmJKW2MxA9XZVUOkBFA62jLP7jx6_DCYZGw@mail.gmail.com>
        <CAPSFM5cXN57z56Cvq-NX1H4raS7d8=qXEFDQqpypJfoYzbxcyA@mail.gmail.com>
        <CAPSFM5dxuEsGkFNTjCF4tLE611n1zLt2z+2JU03dORHxSK1i6w@mail.gmail.com>
Date:   Thu, 15 Oct 2020 12:16:09 -0700
In-Reply-To: <CAPSFM5dxuEsGkFNTjCF4tLE611n1zLt2z+2JU03dORHxSK1i6w@mail.gmail.com>
        (Charvi Mendiratta's message of "Fri, 16 Oct 2020 00:26:11 +0530")
Message-ID: <xmqqblh3fgg6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2B3577E-0F1A-11EB-98F2-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> Thank you Christian and also I apologise, since I forgot to cc the
> mailing list on last reply .
>
> I have submitted the patch[1] for the microproject "modernizing the
> test scripts" and would be glad to have reviews from the community and
> will work on updates required .

Welcome.

If "Charvi Mendiratta" is the name you go by, please correct the
author names and sign-offs on your patches to match it.

> While working on the same , I got familiar with the mailing list ,
> guidelines , workflow and also learned more about the git commands.
> Next , I would also like to know how to proceed further and learn more
> about code base.

Nice.
