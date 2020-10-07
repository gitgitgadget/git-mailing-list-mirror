Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095B8C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 20:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82EB2076B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 20:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uNL4TMxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgJGUq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 16:46:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53538 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbgJGUq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 16:46:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C62C5EEDD9;
        Wed,  7 Oct 2020 16:46:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QLSe27TbEmsWRoZU23hFyQ1fw+0=; b=uNL4TM
        xaNbLnrEyZ+055eTpivo67vvotn2Aw2RtLMq5+ZWlvSnOWR5nMo8JPYNHQV+btlW
        2bx4USeJfNabAsnSvhxZsyMk+0/ssLmcuV9fHGN05T9SK2BayyWTFvD9l849qkF4
        6s8d1ciy/vOqPucjUFnEXZ/oy5aSjQGHHHL3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mcx7nLHqngGSSXiZuf/CcM4Jggij0avp
        6C4r1oOaofHcWzmXeRVoiCVVqrgCYOaoR9g6yHqfWhS9LQbGKzh1tqs/DcGrBqUl
        +Y/djlJPbsEBHvkmUOmjuwzhO37Xjd9xB/RaLuYraw43nI6sglSjTg8Rnhs9xF+r
        5hauefbmgCY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C04ABEEDD8;
        Wed,  7 Oct 2020 16:46:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0F583EEDD7;
        Wed,  7 Oct 2020 16:46:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] index-pack: make get_base_data() comment clearer
References: <20201007184852.GB222564@coredump.intra.peff.net>
        <20201007201658.1322116-1-jonathantanmy@google.com>
Date:   Wed, 07 Oct 2020 13:46:20 -0700
In-Reply-To: <20201007201658.1322116-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 7 Oct 2020 13:16:58 -0700")
Message-ID: <xmqq7ds1228z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 288926AE-08DE-11EB-9364-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> A comment mentions that we may free cached delta bases via
> find_unresolved_deltas(), but that function went away in f08cbf60fe
> (index-pack: make quantum of work smaller, 2020-09-08). Since we need to
> rewrite that comment anyway, make the entire comment clearer.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> OK - here it is, with "reconstruct" instead of "uncompress". This
> replaces patch 3 of Peff's patch set.

Thanks.  Will replace.
