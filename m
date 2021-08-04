Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E67DC432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61DFE60F8F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 00:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhHDAdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 20:33:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62241 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhHDAdv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 20:33:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0B45148F38;
        Tue,  3 Aug 2021 20:33:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yTIQMIBd58ilwB4MHUXysoO3Co3s2Kx3iRX/QO
        H+Vn0=; b=awZqNFV7IpPPTX2xhEKSfMvYtu09QoV9uPlT2tvskjcMyfuX635B7b
        fYFWgWDt0XWOHm+kwrdZLzeLFDUCa5s1cQvNSyqUlGoxtgJbz01Rjuo77PGl5Zbt
        sxL3/jI8L/FNA2IwzWuryAoAvC333edIaFYmtEtiKO4ovqohz1cLo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 867C9148F36;
        Tue,  3 Aug 2021 20:33:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D1AA3148F35;
        Tue,  3 Aug 2021 20:33:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 09/10] Documentation: add coverage of the `ort` merge
 strategy
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <37a69fd2e0bdb7fba6b6c47c3edec0964165cb61.1628004920.git.gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 17:33:34 -0700
In-Reply-To: <37a69fd2e0bdb7fba6b6c47c3edec0964165cb61.1628004920.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 03 Aug 2021
        15:35:19 +0000")
Message-ID: <xmqq8s1irqu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B6F3144-F4BB-11EB-9A35-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  --merge::
> -	Use merging strategies to rebase.  When the recursive (default) merge
> -	strategy is used, this allows rebase to be aware of renames on the
> -	upstream side.  This is the default.
> +	Use merging strategies to rebase.  When either the `recursive`
> +	(default) or `ort` merge strategy is used, this allows rebase
> +	to be aware of renames on the upstream side.  This is the
> +	default.

The "this is the default" at the end is about --merge vs format-patch|am,
so it should come near "Use merging strategies to rebase".

    Use merging strategies to rebase (default).  Renames on the
    upstream side is taken into account when the `recursive`
    (default) or `ort` merge strategy is used.
