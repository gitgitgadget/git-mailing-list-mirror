Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB75C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 19:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjHITjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbjHITjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 15:39:52 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABD226A5
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 12:39:42 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB71D3540E;
        Wed,  9 Aug 2023 15:39:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hGjNQwkg7iAExavrhsbSjWVBkoVhlAnCepjS1d
        8fnp0=; b=CImRk4Ve/Z9OCTwd6Gzy/4xBnPHPoKf0m1HRpIboxXwLIomRFnJdTL
        aEDOd8Ndz5q6mtcUvkFgSgAeo9YGhUfBUHEYW5ilhP8EAr87xi1nRxZ1iwDY/Zhr
        CwQAJQhOa/CqcSckVwhvux4KxVyOwnRZyt006u6L2uieoYGMUz5lU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D53063540D;
        Wed,  9 Aug 2023 15:39:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 75C213540B;
        Wed,  9 Aug 2023 15:39:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] rebase: clarify conditionals in todo_list_to_strbuf()
References: <20230428125601.1719750-1-oswald.buddenhagen@gmx.de>
        <20230807170935.2336745-1-oswald.buddenhagen@gmx.de>
        <xmqqv8dqd2bh.fsf@gitster.g> <ZNO7IVphPf8KOC3Q@ugly>
Date:   Wed, 09 Aug 2023 12:39:37 -0700
In-Reply-To: <ZNO7IVphPf8KOC3Q@ugly> (Oswald Buddenhagen's message of "Wed, 9
        Aug 2023 18:13:21 +0200")
Message-ID: <xmqqbkfgm2di.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A2C5924-36EC-11EE-8C5D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

>>And that leads me to wonder if this is better rewritten with
>>
>>	switch (item->command) {
>>
> as the commit message was meant to imply, my answer to that is no.

Thanks.  Then this patch is still a strict "Meh" to me.

