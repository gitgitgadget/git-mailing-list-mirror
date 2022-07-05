Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FA4C433EF
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 17:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiGERtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGERtx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 13:49:53 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773E19C0C
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 10:49:52 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AEB4F1AC371;
        Tue,  5 Jul 2022 13:49:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sWKV9I7pl5Pze4RKqMIqHQPAZWj0Yscjf4R/d2
        thbds=; b=d9W+twdWM9oN0zqKLq8KfAR5WXt2efYBghCwWoWvkyf/voHLpIloEp
        nCjn0OX2K/9vCsQIMJTEF+gWWQUkCphM9YyyRcwCz+m5u/umdZNC8bRKn7py76+b
        4MZYOe9JLCerueMGmtrsQk8wB8/PDv9nEJqZo0e1ZSr8FSrvzMdiQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A76E81AC370;
        Tue,  5 Jul 2022 13:49:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3FD071AC36F;
        Tue,  5 Jul 2022 13:49:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias Beyer <mail@beyermatthias.de>
Cc:     git@vger.kernel.org
Subject: Re: cherry-pick with --no-rerere-autoupdate does still rerere?
References: <1656746869.11nc2qu6dn.astroid@takeshi.none>
        <xmqqwncv49qm.fsf@gitster.g>
        <1656831907.rjf3s99jhj.astroid@takeshi.none>
Date:   Tue, 05 Jul 2022 10:49:46 -0700
In-Reply-To: <1656831907.rjf3s99jhj.astroid@takeshi.none> (Matthias Beyer's
        message of "Sun, 03 Jul 2022 09:08:01 +0200")
Message-ID: <xmqq4jzvla9x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC43978C-FC8A-11EC-AF91-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias Beyer <mail@beyermatthias.de> writes:

> Excerpts from Junio C Hamano's message of Juli 2, 2022 9:04 pm:
>> Matthias Beyer <mail@beyermatthias.de> writes:
>> 
>>> I just experienced a `git cherry-pick <commit> --no-rerere-autoupdate` where the
>>> conflict still got automatically resolved from rerere.
>> 
>> If I am not mistaken, this is totally expected.  You told the
>> command "use rerere but do not blindly accept the replayed
>> resolution into the index".
>
> Ah! After over 10 years of using git, I still missed that ("update the index" in
> the manpage). I was thinking about "cherry pick this, but don't use rerere at
> all".
>
> Thanks for clearing up my confusion!

It is highly appreciated that you gave us an opportunity to
improving the documentation (or possibly something else) to avoid
getting other users into a similar misunderstanding.

A discussion, proposal, or a patch to improve docs and helps is
certainly welcome.
