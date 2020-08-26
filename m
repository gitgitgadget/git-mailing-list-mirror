Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A8EC433E5
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025E12074A
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ai4sXJxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgHZQrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:47:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58528 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgHZQrd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 12:47:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AE47E6B31;
        Wed, 26 Aug 2020 12:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YXAQ55yUO3eiEcXNASf3MBZApDM=; b=ai4sXJ
        xHn4zpXeXAVMfaTIzXqE8TjHN2TsA4WwDouB5uPGxIu3CATE/zsGQwkWvbPtrQ5T
        AJ89utMrkeu/9XerQ3yhBATzihEskTVpf1eUxoNwG7HnAHtCGYrmf++66juwcV/M
        2WZCgUTZzRmLBfihaOWBWw0U6+h/Au7zAx/fA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GrZyn3vVzA9YPrDZ8zgppS9v0QdkH61G
        xXKR7Vkt8QMpYOpLaAzIMJ43DYaRiK+1BVmr0795Td8IhvQlNh9JigkpgnJp1AoD
        1rZcO8g2ThS3Gl84S/H1CU4CCWFFXqpBZAV4SseYs3vuiG7SuoTh0im/bwfsYVF7
        qY9l4BTTFd4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62DBEE6B2E;
        Wed, 26 Aug 2020 12:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE8C0E6B2D;
        Wed, 26 Aug 2020 12:47:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, git@vger.kernel.org,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com, peff@peff.net
Subject: Re: [PATCH 2/3] submodule: fix style in function definition
References: <20200826094506.GA311769@konoha>
Date:   Wed, 26 Aug 2020 09:47:25 -0700
In-Reply-To: <20200826094506.GA311769@konoha> (Shourya Shukla's message of
        "Wed, 26 Aug 2020 15:15:27 +0530")
Message-ID: <xmqq8se1we02.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3D896AA-E7BB-11EA-9D9F-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

>>> The definitions of 'verify_submodule_committish()' and
>>> 'print_submodule_summary()' had wrong styling in terms of the asterisk
>>> placement. Amend them.
>
>> I pointed out only these two, but that does not necessarily mean
>> they are the only ones.  Have you checked all the new code added by
>> the series?
>
> There is one more. It is not related to my patch series though.

Cleaning up the existing breakage is outside the scope your series,
but of course fixes as an independent patch is welcomed.

Thanks for checking.
