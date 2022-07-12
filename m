Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2307C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 15:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiGLPum (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 11:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbiGLPuj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 11:50:39 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DABB6DB6
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 08:50:39 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C6E5132679;
        Tue, 12 Jul 2022 11:50:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IH/daq5m/rLmJKcGxfGUXpms3F3AuE+iYbAVcN
        ABW7I=; b=ObzeYYb1try8SqkoYXs2xJnu8I9C1eqhrvJR2smQyR6p7biqX+tO7u
        vrmsg0zPlAJ61NZVa/fyl8N4fxwt9/wGWnIu7X4DgswZnzXosb90x9JlqgqpYiih
        sc0/6zxXbezewRnHwNf8hOkpJnod3lxdHT+BU9rwVVeYnynBFVIEE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12AD6132678;
        Tue, 12 Jul 2022 11:50:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7536A132677;
        Tue, 12 Jul 2022 11:50:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Thomas Guyot <tguyot@gmail.com>, Jeff King <peff@peff.net>,
        Gerriko io <gerriko.iot@gmail.com>, git@vger.kernel.org
Subject: Re: Why is reflog so obscure?
References: <CALF=2ANoq1eL-RqK_dLaVThoxbvfhzgPJXFHyD1kX8CFCPx3XA@mail.gmail.com>
        <f0bb8ee8-9b38-45a7-a54b-24cf245bb3c8@gmail.com>
        <Ys0e9MxIWQj/pVXx@coredump.intra.peff.net>
        <a8d2a61d-b86f-9b89-6391-36c58c390a12@gmail.com>
        <xmqqo7xuif46.fsf@gitster.g> <87ilo2we9o.fsf@osv.gnss.ru>
Date:   Tue, 12 Jul 2022 08:50:36 -0700
In-Reply-To: <87ilo2we9o.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        12 Jul 2022 18:18:27 +0300")
Message-ID: <xmqq4jzmib3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F8E60B2-01FA-11ED-A62E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Very handy, thanks! Would be nice to have this in EXAMPLES section of
> corresponding manual page.
>
> Honestly, I tried (admittedly not very hard) to figure how to get dates
> from "git reflog" a few times, but every time I gave up, so this (along
> with the --dates option turning dates output on) is not very
> discoverable.

Heh, I wouldn't have bothered writing the message you are responding
to if it were documented already ;-)

Patches welcome.
