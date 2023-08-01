Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3720C00528
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 20:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjHAUSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 16:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjHAUR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 16:17:57 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657821BD
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 13:17:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B914225F9;
        Tue,  1 Aug 2023 16:17:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5VW3to1xV2g5MBmO2P2oCfhqwogcKWI3N9LP27
        5RMsw=; b=tPaEbLnjLS14icbAl/nwFI9RhkkeyacX2lQBYTO7i2K15byx4KJoet
        ISa07C9ghUSGoEJxMA5KsgmHLQ8OJlg2YQ8U7L8cTcw3N0L7gzGlagPtppHjh+wm
        x1VR3HqLuLRzKgNORF815xazoOOlLv012eBAQZPB1hUHvr6l1/6E0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 04209225F8;
        Tue,  1 Aug 2023 16:17:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A6565225F6;
        Tue,  1 Aug 2023 16:17:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] avoid SHA-1 functions deprecated in OpenSSL 3+
References: <20230801025454.1137802-1-e@80x24.org>
        <20230801025454.1137802-3-e@80x24.org> <xmqqsf92eomq.fsf@gitster.g>
        <20230801195325.M746978@dcvr>
Date:   Tue, 01 Aug 2023 13:17:51 -0700
In-Reply-To: <20230801195325.M746978@dcvr> (Eric Wong's message of "Tue, 1 Aug
        2023 19:53:25 +0000")
Message-ID: <xmqq3512bjps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E518E1A-30A8-11EE-AC8E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> I just copied the existing SHA256 stuff and mostly did a
> s/SHA256/SHA1/ in patch 2/2.  I'm not sure why
> SHA256_NEEDS_CLONE_HELPER was needed, either, but I decided
> to keep the SHA1 and SHA256 code as similar as possible for
> consistency.
>
> We could probably drop both *_NEEDS_CLONE_HELPER macros,
> but that's a separate patch.

Fair enough.  Thanks.
