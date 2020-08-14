Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE375C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 04:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C1920855
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 04:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="chTO+992"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgHNErY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 00:47:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64356 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgHNErX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 00:47:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0A107A78C;
        Fri, 14 Aug 2020 00:47:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cZ2wiQexWC6vL9mWCTRqLHYdoec=; b=chTO+9
        92ijSXeRLf5enZveTNx2LU6pjshk2cpdk3F0gWYI0JhxG75LQT+5bQOjdvLutwvF
        aabmpXfZ5XBiQ0qHRvR4S54fqJ0jqt/HBtAByBjoyM2pFoKdJPraBxURr7mUmdc9
        Hb7yhzDh3Q0TCEeOvnKCoqupka5cNs3cvY/eg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QlYap3teKF/u4aHkCeFW/maH2s0D5178
        sTeC9jQ8sP93HiyArvgCaWCmBuJAeRQZaF4fQw4s0nwlyqLYVIQ5LjvfQMtiJmJB
        CTZJ7SesnAvWdA7++me2wBb/a4nQnKLSmFioIZ3iHvAPBnxPxX44SLafEmpyMl40
        6LoFrx08Ulw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E121E7A78B;
        Fri, 14 Aug 2020 00:47:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 694E17A78A;
        Fri, 14 Aug 2020 00:47:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH 0/2] Documentation updates for SHA-256
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
        <da077fb0-14bb-b84f-c526-d759ebc9f5eb@gmail.com>
Date:   Thu, 13 Aug 2020 21:47:19 -0700
In-Reply-To: <da077fb0-14bb-b84f-c526-d759ebc9f5eb@gmail.com> (Derrick
        Stolee's message of "Thu, 13 Aug 2020 22:33:20 -0400")
Message-ID: <xmqqh7t5zve0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CBEC176-DDE9-11EA-8A19-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Is that really a concern? Maybe, but also Git will never move data like
> that.

I would say that we can safely say that this year ;-) as dumb HTTP
would be mostly dead.

> The main thing is to focus on compatibility of the .git directory
> as a whole (and the protocol, as we move into inter-operability mode).
>
> [1] https://lore.kernel.org/git/CAN0heSptiJL9d86ZeNPMUaZeTA68juwTyf3K-uWR=K-vt=1Hrg@mail.gmail.com/
>
>>  This series updates the pack and
>> index documentation to reflect that these formats can handle SHA-256,
>> and updates the transition plan to reflect what we've implemented and
>> what the next steps are.
>
> These patches are good to help clarify these formats in the new world.

Yup.
