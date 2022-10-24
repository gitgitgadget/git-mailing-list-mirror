Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5BFC67871
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiJXUiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiJXUh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:37:28 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E713711C01
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:48:58 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 957DD14FDE1;
        Mon, 24 Oct 2022 12:39:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l7Kz42FVJFMf2VR01i3Of75qEDfNKPfkPdTjs1
        EGRw8=; b=xCmq39lgHf+8ecGGewSKweLMQTmW2yot1cfz69g58WYy3LzaBjVimm
        st9KxlnpVWhBazdybnXkn7K9DRYy/gdzmBikcPkebYsgC66igerRPowQXLJZ7VCP
        tljg441SsWBs8aYO9YtsGcgt+lFvdFx6WKU7gDFUZMfit1tjgWJao=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C10C14FDE0;
        Mon, 24 Oct 2022 12:39:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E59D914FDDF;
        Mon, 24 Oct 2022 12:39:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        GitList <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/3] glossary: add reachability bitmap description
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
        <20221022222539.2333-1-philipoakley@iee.email>
        <20221022222539.2333-4-philipoakley@iee.email>
        <CAPOJW5zmYC9q8+aXh9-kZnvT28GQ1ud3LenFi9qxV4DVdCWKxg@mail.gmail.com>
Date:   Mon, 24 Oct 2022 09:39:31 -0700
In-Reply-To: <CAPOJW5zmYC9q8+aXh9-kZnvT28GQ1ud3LenFi9qxV4DVdCWKxg@mail.gmail.com>
        (Abhradeep Chakraborty's message of "Mon, 24 Oct 2022 13:13:46 +0530")
Message-ID: <xmqq1qqxuqf0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 703063B8-53BA-11ED-9786-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

> Small correction here - A repository may have multiple bitmaps (one
> for each selected commit from the preferred packfile or a
> multi-pack-index) but it can have only one ".bitmap" file (as of now).
> Bitmaps for the selected commits are stored in that ".bitmap" file.
> So I think the below lines (or similar) will work  -
>
>     The bitmaps are stored in a ".bitmap" file. A repository may have
>     at most one ".bitmap" file. The file may belong to either one pack, or the
>     repository's multi-pack-index (if it exists).
>
> Feel free to rephrase it accordingly.

Sounds good to me.  Or Philip's original can be tweaked minimally to
say "... may have at most one bitmap file (which stores multiple
bitmaps)".

Thanks.
