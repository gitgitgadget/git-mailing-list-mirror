Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849C9E8FDB3
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 21:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbjJCVBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 17:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjJCVBP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 17:01:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA48AD
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 14:01:11 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E7B02DD49;
        Tue,  3 Oct 2023 17:01:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=ZKenfPxj0nKtiY7UI3a11Wy4Nv513kO8PfogmJ
        o+G+Y=; b=w5BAP/MsTaWfCJd5L0pRSnCFQ8phyKTXpL2Xz6I0WJOV3ONn+k5mrk
        IjRo/MXwTyAMfwMCV25pQdp3rgs6KfnhrmsNTvX0w5FxuuDNEnRxXxRIDZxeVmkB
        ab+KW+Ru/L2Qg1QTq6PZoqYIIdGzTssjOtvBun2oNLG2YapNuoH9M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 76EA52DD48;
        Tue,  3 Oct 2023 17:01:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 10B302DD47;
        Tue,  3 Oct 2023 17:01:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/5] git-jump: admit to passing merge mode args to ls-files
In-Reply-To: <xmqqjzs3xwm1.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        03 Oct 2023 13:46:30 -0700")
References: <20231003082107.3002173-1-stepnem@smrk.net>
        <20231003082107.3002173-3-stepnem@smrk.net>
        <CAPig+cQHAK2_LEG0-6MTF52t2D8b_SRxzB51B_4N35ujtGeb6Q@mail.gmail.com>
        <xmqqjzs3xwm1.fsf@gitster.g>
Date:   Tue, 03 Oct 2023 14:01:06 -0700
Message-ID: <xmqqfs2rxvxp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F95071A4-622F-11EE-91CC-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Unlike `--stdout` and `jump.grepCmd`, all other things that are not
> quoted, including the one that is added by this patch (i.e.,
> "ls-files -u"), are something the end-user needs to cut and paste in

"are" -> "are NOT".  Sorry for the noise.

> reaction to seeing this error message, so as long as they are
> understandable in the sentences they appear in, I think they are
> fine.
>
> If we wanted to standardize, we may start to encourage consistent
> use of quoting, but I do not think it should be part of this topic.
>
> Thanks for being careful and thoughtful.
