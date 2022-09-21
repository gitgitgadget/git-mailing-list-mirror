Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1BDECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 19:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiIUTJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 15:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiIUTJj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 15:09:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38541A196
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 12:09:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 251421B2606;
        Wed, 21 Sep 2022 15:09:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wvFKptwPCyaKbJTXHeyyUcgFR6sC1KpXd6bktk
        HIsEs=; b=tIrAs63FKOmG7KwATH49UYPZF7c+zGU2ItrPjJIVmpYGoealEGcYeN
        lk2V9bw7MrYOaf9+nITFx0wBGMt/nQYWBP+HRhRbZ0WGOvlCGP468V7E4xOq8W7s
        na6Llhyu/SEJFT3crpcKNlygkcgQafEfbsNLamt++2hP/zIc3VP7I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DBF01B2605;
        Wed, 21 Sep 2022 15:09:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7FC81B2601;
        Wed, 21 Sep 2022 15:09:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, peff@peff.net
Subject: Re: [PATCH v2 0/3] midx: use `--stdin-packs` to implement `repack`
References: <YyokIf%2FSd7SYztKQ@nand.local>
        <cover.1663706401.git.me@ttaylorr.com>
Date:   Wed, 21 Sep 2022 12:09:31 -0700
In-Reply-To: <cover.1663706401.git.me@ttaylorr.com> (Taylor Blau's message of
        "Tue, 20 Sep 2022 16:40:14 -0400")
Message-ID: <xmqq35ck35p0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECDC6A7C-39E0-11ED-9F79-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here's a few patches that replace the existing "feed each OID
> one-by-one" approach to implement the `repack` sub-command of the
> `multi-pack-index` builtin with one that uses `pack-objects`'s
> `--stdin-packs` option.

One question.  How is this series expected to interact with the
7-patch series about ignoring cruft pack while "midx repack" etc.?

I guess it is not so urgent during the -rc period, so I'll stop at
asking that question without reading further, at least for now.

Thanks.
