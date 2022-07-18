Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00E8CCA485
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 16:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiGRQYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiGRQYd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 12:24:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F9A29821
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:24:32 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8132A1B2D4E;
        Mon, 18 Jul 2022 12:24:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UU24OfS3BRMu
        SJ4ZW7wPlVSO7MvarkyztqXeXS5bCJo=; b=M/6FWbizZdc+We1K5FD7hagCV0mQ
        YJIv3yGWu43bLuM1DgJmBITBWX9pIHjJ5Rd0zuS52JC1aHcmSPxf2A8VzdaqGKPI
        btJOyoUkRrkQLxMiw95SjSFSdgwaD9xzrn3eOFxf1A8BRQZ2Ie6vkOoFQ48dvfw4
        EUldSrM292IZ53M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79FB31B2D4D;
        Mon, 18 Jul 2022 12:24:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 19ACE1B2D4C;
        Mon, 18 Jul 2022 12:24:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] index-format.txt: remove outdated list of supported
 extensions
References: <20220718085640.7395-1-szeder.dev@gmail.com>
Date:   Mon, 18 Jul 2022 09:24:24 -0700
In-Reply-To: <20220718085640.7395-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 18 Jul 2022 10:56:40 +0200")
Message-ID: <xmqqmtd6s81z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 172FB26A-06B6-11ED-B08F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> The first section of 'Documentation/technical/index-format.txt'
> mentions that "Git currently supports cache tree and resolve undo
> extensions", but then goes on, and in the "Extensions" section
> describes not only these two, but six other extensions [1].
>
> Remove this sentence, as it's misleading about the status of all those
> other extensions.
>
> Alternatively we could keep that sentence and update the list of
> extensions, but that might well lead to a recurring issue, because
> apparently this list is never updated when a new index extension is
> added.

Yup, I tend to agree that the sentence does not add much being here
and insisting that the list must be kept up to date creates more
work of dubious value.  If we didn't support any extensions, we
wouldn't be talking about them in this section, so saying that we
support some and we will list them later does not add much value,
either.

> [1] Split index, untracked cache, FS monitor cache, end of index
>     entry, index entry offset table and sparse directory entries.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  Documentation/technical/index-format.txt | 2 --
>  1 file changed, 2 deletions(-)

Thanks, will queue.
