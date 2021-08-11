Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1592C432BE
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 18:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C7C60FE6
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 18:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhHKSLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 14:11:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62655 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhHKSLd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 14:11:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD169D2C9C;
        Wed, 11 Aug 2021 14:11:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=liYDFso53U/m9PIPrR1g3D1hnw/GDYwpIEiLbR
        maq9Y=; b=l6x9rK6QGIbkDUB3i40owhWwwMiRW6Hdp87IdOwH0lr0Tota5F3yqS
        VYNWczS1bMoeVGoPX2QeD2btzgVDLgBTMyE2SKJclWRyNWCSA83QD5M8nCmGTfQ7
        WwA5b96NBAkit4f5Vq7xtCNqJP6LKB3vcWJyhKtfTT3e2nHCD/LQc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4D5FD2C9B;
        Wed, 11 Aug 2021 14:11:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34C7DD2C9A;
        Wed, 11 Aug 2021 14:11:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tassilo Horn <tsdh@gnu.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5] userdiff: improve java hunk header regex
References: <20210811145341.43429-1-tsdh@gnu.org> <xmqqa6lnaola.fsf@gitster.g>
        <87im0b6f92.fsf@gnu.org>
Date:   Wed, 11 Aug 2021 11:11:08 -0700
In-Reply-To: <87im0b6f92.fsf@gnu.org> (Tassilo Horn's message of "Wed, 11 Aug
        2021 19:42:59 +0200")
Message-ID: <xmqqo8a397ib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80E0929A-FACF-11EB-B977-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tassilo Horn <tsdh@gnu.org> writes:

> That leads to the question if you'd welcome a patch adding a
> .dir-locals.el to the repository with the right settings so that it'll
> just work for contributors using the One True Editor.  Would you?

If your one true editor honored what is in .editorconfig, perhaps
there was no need for us to be having this conversation?  I dunno.

Our .gitattributes (the top one and also in subdirectories) try to
give reasonable whitespace rules for files, and specifically, files
in t/t????/ directories that are used as test vectors completely
disable whitespace checking, while everywhere else we insist certain
styles in the top-level .gitattributes file.

Thanks.

