Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1F7E20229
	for <e@80x24.org>; Tue,  1 Nov 2016 20:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753695AbcKAUhr (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 16:37:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56940 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751469AbcKAUhr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 16:37:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0D2849A8D;
        Tue,  1 Nov 2016 16:37:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZTU6pRq/pOGgmD2Rn/nBNI31ggs=; b=i4I3Od
        7Y1PztN70bsP8WD7BWKNY92hMIstMv2qlM5fa4/M+GKknzOAapO9wYO3iWtMCkek
        6e9T1KZV6RxlPIWHOlTCxymsrXsFktOa1Q7h9omuULBAKgYA3YeZd+2jILjnADQ3
        z+PHVEuEUuR4HFTwL3/jCn4DwqOVmF0a2K1o0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MuLfAp9mtkSVXJXGYzYmZr0nbQzPhS7U
        g+peksCNS87JGe12iSBgW0esJZSPsuobebdBK8LmU8SApk7w7uLZWwpHcTQUcQeJ
        jInAyUY0fWibtCltfWA7tS6t/A8rU04mocakJpHw2fDHulyzkyhj0yuvClwekM9g
        wkIVDZqYDkM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8BFC49A8B;
        Tue,  1 Nov 2016 16:37:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BACD49A89;
        Tue,  1 Nov 2016 16:37:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH v2 1/5] trailer: be stricter in parsing separators
References: <cover.1478028700.git.jonathantanmy@google.com>
        <cover.1477698917.git.jonathantanmy@google.com>
        <cover.1478028700.git.jonathantanmy@google.com>
        <c7db0aafb543845382e1835e3704273d3596e6bb.1478028700.git.jonathantanmy@google.com>
        <xmqqvaw7ndow.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 01 Nov 2016 13:37:44 -0700
In-Reply-To: <xmqqvaw7ndow.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 01 Nov 2016 13:32:47 -0700")
Message-ID: <xmqqr36vndgn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B4237E8-A073-11E6-87CF-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> Currently, a line is interpreted to be a trailer line if it contains a
>> separator. Make parsing stricter by requiring the text on the left of
>> the separator, if not the empty string, to be of the "<token><optional
>> whitespace>" form.
>
> Hmph.  The optional whitespace is to allow for what kind of line?
>
> It is not for "Signed off by:" that is a misspelt "Signed-off-by:";
> it may not hurt but I do not think of a case that would be useful
> offhand.

Other than this "Hmph" (which is not an objection---just something
that the reviewer did not understand), the rest looked good to me.

Will re-queue.

Thanks.
