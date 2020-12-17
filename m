Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA6CC4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283C022D57
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbgLQBMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:12:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59742 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388920AbgLQBMl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:12:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9254E100EA8;
        Wed, 16 Dec 2020 20:12:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=1MKlhKDpJfEWMY9t2xb339RA0d8=; b=o31EHB8yePMX559JXkHe
        Mdm8kolwz6VTbGExr28Dsfv4QnOLQ1LSoU6zAM+cgu8ltQr6r6dbFRUEgjZ98s9s
        E7HBdjuTllJX5DtNtKthPLyWPnkWf/ajycXwLBCRztbyl40paPJNdZR6eVFbYNS8
        FYvkfPaWTfqMrZ0q6qJc3xs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=JO3YheMvF7qz0lBhYoZp+jV9X8FFxHCBmWB0lrJR7uq4XM
        s3Yc2SK9IsSEJJ1SW5Ey4ZLfB8e/QwMzBX6z+N2QtaCZufOlVie/r3mcnhTWN8ig
        tLYCli88cGyPW478HJlx3z0VXjKkudkdUc2AXBWw6ldlOUIetbpbS6wvuNaM8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E11B100EA7;
        Wed, 16 Dec 2020 20:12:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B25AF100EA6;
        Wed, 16 Dec 2020 20:11:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com, chriscool@tuxfamily.org, peff@peff.net,
        newren@gmail.com, jrnieder@gmail.com, martin.agren@gmail.com
Subject: Re: [PATCH v5 0/9] Parallel Checkout (part I)
References: <cover.1604521275.git.matheus.bernardino@usp.br>
        <cover.1608128666.git.matheus.bernardino@usp.br>
Date:   Wed, 16 Dec 2020 17:11:55 -0800
Message-ID: <xmqqeejp1bj8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBD9FDAC-4004-11EB-A171-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> The previous rounds got many great suggestions about patches 1 to 10,
> but not as many comments on the latter patches. Christian commented that
> patches 10 and 11 are too long/complex, making the overall series harder
> to review. So he suggested that I eject patches 10 to 19, and send them
> later in a separated part. This will hopefully make the series easier to
> review and move forward. (I also hope to include a desing doc in part 2
> to make those two bigger patches more digestible.)
>
> So this part is now composed only of the 9 preparatory patches, which
> mainly focus on: (1) adding the 'struct conv_attrs' parameter to some
> convert.c and entry.c functions (to avoid re-loading the attributes
> during parallel checkout); and (2) making some functions public (for
> parallel-checkout.c's later use).

All of these patches look sensible to me.

Will replace.  Thanks.
