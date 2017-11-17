Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 570B1202A0
	for <e@80x24.org>; Fri, 17 Nov 2017 02:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755541AbdKQCOi (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 21:14:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55345 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754930AbdKQCOh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 21:14:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FD7F9F3F8;
        Thu, 16 Nov 2017 21:14:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QEj1/DSCJHW5hsPGZg6YyY296ck=; b=sy39z8
        4KhccnnHJ7vGtLQfFoJEQ8wL72hxcx0FNrRnVh+mffvAkKCaWR8OExCGksMKHmI/
        OgpmxektbGCB+UCjakXiS00jr65Y8d4jhpIVt07WT9rK3gOxhYWHZw86OFPRdW1i
        sZVoqrVKpfrAiROUAcUW/sD9QZO3sl+niWoeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mzDWlXrvwTeq9MRsKHrtFA++COqSsk/v
        QhcXWDX5B2vShT7cSF6j5DUhiVK2P+3ftH8Wgdqiru+s74B3r1ENoCP5AdPNEiFC
        0Xcr/tgnlwKWv/2T1FcfxRN0qH5IK1Gfku1MzPODS9xGBVuCeNuhzZOZJZw3+NH8
        bKCIERAf4ig=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 775C99F3F7;
        Thu, 16 Nov 2017 21:14:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB6D89F3F6;
        Thu, 16 Nov 2017 21:14:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        peff@peff.net, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 5/6] rev-list: add list-objects filtering support
References: <20171116180743.61353-1-git@jeffhostetler.com>
        <20171116180743.61353-6-git@jeffhostetler.com>
        <20171116124354.3d800cc27dbe3ea668c64519@google.com>
Date:   Fri, 17 Nov 2017 11:14:34 +0900
In-Reply-To: <20171116124354.3d800cc27dbe3ea668c64519@google.com> (Jonathan
        Tan's message of "Thu, 16 Nov 2017 12:43:54 -0800")
Message-ID: <xmqqd14htzw5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EC1FB4C-CB3D-11E7-958D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> If it were up to me, I would remove all existing mentions of "partial
> clone" and explain the presence of the "--missing" argument as follows:
>
>     In the future, we will introduce a "partial clone" mechanism wherein
>     an object in a repo, obtained from a remote, may reference a missing
>     object that can be dynamically fetched from that remote once needed.
>     This "partial clone" mechanism will have a way, sometimes slow, of
>     determining if a missing link is one of the links expected to be
>     produced by this mechanism.
>
>     This patch introduces handling of missing objects to help debugging
>     and development of the "partial clone" mechanism, and once the
>     mechanism is implemented, for a power user to perform operations
>     that are missing-object-aware without incurring the cost of checking
>     if a missing link is expected.

That sounds quite sensible.
