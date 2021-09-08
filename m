Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D98EC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC5761108
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347222AbhIHATZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:19:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53670 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbhIHATY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 20:19:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A1EEE0FE9;
        Tue,  7 Sep 2021 20:18:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/Ks9dx2f9aSrnOwsIw77X2IsEbvmWTif8RRGjO
        FHmYA=; b=NHe7VpNY1S3B5JBphiM3dKH7M1owdgOrkOQnuFieYhj4SIDBq07G8d
        vVBHObEXmKT4elt+PYqD2RDauYLLrriSu8jBjVea8XfhmerdjpAHPnNR5cKMOqLr
        7VJ0xTXBJPB2nB4S9gy2NCAwndTvkye7gxiT5yvGg1aBSSQueAYts=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F4150E0FE7;
        Tue,  7 Sep 2021 20:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D641E0FE6;
        Tue,  7 Sep 2021 20:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Azeem Bande-Ali via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, David Barr <b@rr-dav.id.au>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Azeem Bande-Ali <me@azeemba.com>,
        Azeem Bande-Ali <A.BandeAli@gmail.com>
Subject: Re: [PATCH v3] help.c: help.autocorrect=prompt waits for user action
References: <pull.1012.v2.git.1628917872724.gitgitgadget@gmail.com>
        <pull.1012.v3.git.1628992226139.gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 17:18:16 -0700
In-Reply-To: <pull.1012.v3.git.1628992226139.gitgitgadget@gmail.com> (Azeem
        Bande-Ali via GitGitGadget's message of "Sun, 15 Aug 2021 01:50:26
        +0000")
Message-ID: <xmqqee9z9ayf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4352F6FE-103A-11EC-AB3B-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Azeem Bande-Ali via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Azeem Bande-Ali <me@azeemba.com>
>
> If help.autocorrect is set to 'prompt', the user is prompted
> before the suggested action is executed.
>
> Based on original patch by David Barr
> https://lore.kernel.org/git/1283758030-13345-1-git-send-email-david.barr@cordelta.com/
>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Azeem Bande-Ali <me@azeemba.com>
> ---
>     New config for help.autocorrect to prompt user before action
>     
>     Only minor style changes have been made since v2:
>     
>      * Moved * to variable name instead of the type name
>      * Keep code in the same line for readability

I didn't see anybody comment on this round (and do not think I saw
anything glaringly wrong).

Is everybody happy with this version?  I am about to mark it for
'next' in the next issue of "What's cooking" report, so please
holler if I should wait.

Thanks.
