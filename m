Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AB3C433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C2D2253D
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbhADXoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:44:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51607 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbhADXoj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:44:39 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30D23A40F3;
        Mon,  4 Jan 2021 18:43:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=NG/LMkPDGYIlF+ZWYqzD3OHIt
        6w=; b=BfLvxs1cMoLwbnLhlxce1b0otokvWuPt76Y/Vkk47D8YT3UQKQ0Somkxs
        8/WHGst8hmIVsn+wp/lngqQsu7AYBkNmS6m6D3GkKUC5m1znVnQTQnSJDZAGIcWm
        xdkm/zBc7u4LfHDeb0QVr5o9tj5EB+7T2zDCpuyNnE+BqW70Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=jtT1wzZgvO/z8VSyd4X
        1bBI09hya2MPYSZ/qmxaotiCryAFPeGC3zYKDXw64tnKc727KYcz72LnhSHHpFfI
        jTFETIo8Ag9hKWHIgFmdDhfSB6UBmMpJ0p9appIwi8lFhKd9SPvHlFxihBGSrmC3
        NCr2coq38+8y5vesdE37oHqQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29184A40F2;
        Mon,  4 Jan 2021 18:43:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD37EA40F1;
        Mon,  4 Jan 2021 18:43:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] CoC: Update word-wrapping to match upstream
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
        <20201228171734.30038-2-avarab@gmail.com>
Date:   Mon, 04 Jan 2021 15:43:56 -0800
Message-ID: <xmqqzh1o5kub.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B5F70E0E-4EE6-11EB-8D33-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> When the CoC document was added in 5cdf2301d4a (add a Code of Conduct
> document, 2019-09-24) it was added from some 1.4 version of the
> document whose word wrapping doesn't match what's currently at [1],
> which matches content/version/1/4/code-of-conduct.md in the CoC
> repository[2].
>
> Let's update our version to match that, to make reading subsequent
> diffs easier.

... because a patch going straight to upstream's 2.0 would have to
include the three hunks we see here, that would be a noise because
the diff between upstream's 1.4 and 2.0 does not touch these places?

If so, then this step makes sense to me.

> There are no non-whitespace changes here.

Not a comment about this patch, but "git show --word-diff" would
still show three hunks with no change highlighted as expected.

I wonder if the word-diff (or color-words) logic should be further
taught to squelch out the hunks that do not change anything other
than line wrapping and whitespace fuzz.

Thanks.
