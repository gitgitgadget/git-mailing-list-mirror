Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3867AC79DB7
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF1E2470A
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pMK7qlwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfLMREc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:04:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53977 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfLMREc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:04:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F36BA6A19;
        Fri, 13 Dec 2019 12:04:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lfZBp+/apR3+E3wx1kzHFgOOTaQ=; b=pMK7ql
        wA3uEcaGfecmNgw+XEKjGn1QGLsMAn8z3X8cH1VRIbpLxrpXcO45qddfE7m3F0i6
        L1/gjGagPV98D6Jw91MbybSqoDIjwLutEAsfTuWzLYFzzrCs+hWX2nlIjHYMhmRq
        ArlJjs1mldvKaweNnG5Tl/c0hZY5uoVYM8HaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S87zvXY9a6SLLlvoI/8yCbZ0cu2g0hXu
        gINUZ5+Iiyek4UU5LpV6RS11bqZFC+IXgJOa2koJMKr3mNKKxKYZwaufkye9y86r
        PlAp/MPSdsWBij4lMF9ArUW5sIPQlZyNXfAkUUncwoDYis/qWZkqM9lr/bCdrn4X
        CpRuEii4/dU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 06AE1A6A18;
        Fri, 13 Dec 2019 12:04:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1E226A6A17;
        Fri, 13 Dec 2019 12:04:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 0/2] gitk: match Git's 'reference' pretty format
References: <da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com>
        <cover.1576197846.git.liu.denton@gmail.com>
Date:   Fri, 13 Dec 2019 09:04:24 -0800
In-Reply-To: <cover.1576197846.git.liu.denton@gmail.com> (Denton Liu's message
        of "Thu, 12 Dec 2019 16:44:48 -0800")
Message-ID: <xmqqk170ma1z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EB3B9FC-1DCA-11EA-B300-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Recently, the 'reference' pretty format was implemented in Git, which
> has the same function as the 'Copy commit summary' feature in gitk.
> Since Git now has a canonical way of doing this, update gitk to match
> this.

As you no longer use "--pretty=reference", the above has become a
stale description.

I think the two patches do make sense, though.

Thanks.


>
> Beat Bolli (1):
>   gitk: rename "commit summary" to "commit reference"
>
> Denton Liu (1):
>   gitk: drop quotes in copysummary format
>
>  gitk | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
