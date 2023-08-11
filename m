Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD49FC001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbjHKRxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbjHKRxl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:53:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2BD273E
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:53:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFB7018D82D;
        Fri, 11 Aug 2023 13:53:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9SoifHvfK69brnEW+Rw+Xhw9IRBBBKKBEh0QJQ
        rdWOw=; b=SI2tftZ8wz4HqDO7jXN/TnMFuJF9rP7OfFzx+VZsZ71wyul4hEejx4
        VW+L0w4TkyrbyhaNsppaYw211HKWRSbsAzJjR7P/3VSKSe6+cJ8/otT5cRDFvXAH
        syIGgrhMaResq2XrWsMsVpnrZH4isNqVsV1Dn7qLfyzaKnsgQla0M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6DD218D82C;
        Fri, 11 Aug 2023 13:53:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11EDF18D82B;
        Fri, 11 Aug 2023 13:53:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: Re* [PATCH v3 2/2] doc: revert: add discussion
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
        <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
        <owly8raih8ho.fsf@fine.c.googlers.com> <xmqqsf8ptsqf.fsf@gitster.g>
        <xmqq5y5ltqwd.fsf_-_@gitster.g>
Date:   Fri, 11 Aug 2023 10:53:37 -0700
In-Reply-To: <xmqq5y5ltqwd.fsf_-_@gitster.g> (Junio C. Hamano's message of
        "Fri, 11 Aug 2023 10:44:50 -0700")
Message-ID: <xmqq1qg9tqhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFE726BE-386F-11EE-8F66-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> +
> +		if (starts_with(msg.subject, "Reapply \"Reapply \""))
> +			/* fifth time is too many - force reference format*/
> +			use_reference = 1;

Come to think of it, as the documentation patch in the series cited
double reapply as too unwieldy, we probably should stop before
producing such commit.  We can update "Reapply \"Reapply" above to
"Revert \"Reapply" and then "fifth" -> "fourth".  The test update
below must also be adjusted, if we want to take that route.

