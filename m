Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FE1C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 00:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C059561CF9
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 00:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhF2AzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 20:55:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56019 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhF2AzK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 20:55:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19641132475;
        Mon, 28 Jun 2021 20:52:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=FBtJG4D305jtYbsEMipTrO55aiVt1gl+W1bdmJrmel8=; b=S97t
        3V3ta4FkobfTn1vPHo5w+xqjGHcYLOezwaE8y5V+Cta3LCod1Bax6TiSoRdsoKqj
        iLkRTJP5cYLs0sfvsqm5mDflWaH7NOsiCaH411xbvqXVvXaEpFwkQ8UdmcHwQWzt
        tgt8bMzWcnBjjmCCyf4QAPgy7ypNpTxln0vDAn0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 114A9132474;
        Mon, 28 Jun 2021 20:52:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 47FB4132473;
        Mon, 28 Jun 2021 20:52:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Simon Hausmann <simon@lst.de>,
        dorgon chang via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, dorgon chang <dorgonman@hotmail.com>
Subject: Re: [PATCH] git-p4: fix failed submit by skip non-text data files
References: <pull.977.git.git.1615535270135.gitgitgadget@gmail.com>
        <YMsveynHB8MNiz+S@bagger.lan>
        <nycvar.QRO.7.76.6.2106181523090.57@tvgsbejvaqbjf.bet>
Date:   Mon, 28 Jun 2021 17:52:37 -0700
Message-ID: <xmqqmtr94hm2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D81F0C4-D874-11EB-83F4-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> ... IIRC the diff there is solely for
>> the submit template, so it should only include text. That your patch
>> ensures in what seems an idiomatic way.

This is a crucial piece of information lacking in the proposed
commit log message that would help readers understand why this is a
safe change.  An updated patch with a better log message would be
appreciated.

> Thank you for reviewing and chiming in.
>
>> Signed-off-by: Simon Hausmann <simon@lst.de>
>
> The typical way to record your review is to say `Reviewed-by:`. The
> `Signed-off-by:` footer is usually used to indicate that you wrote the
> patch, or that you shepherd it onto the Git mailing list.

Yes to both.

It is unusual to see "reviewed-by" from those whose names do not
appear even once in output of "git shortlog --no-merges git-p4.py"
on a patch that touches "git-p4.py", but this is a fringe area
(compared to the more core-ish part of the system) where people
touch to scratch their own itch without staying around for a long
haul, so it is understandable that we do not always have resident
experts in the area.  A review like this is highly appreciated.

Thanks, all.


