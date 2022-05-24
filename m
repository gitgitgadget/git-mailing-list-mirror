Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A2BC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbiEXTwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiEXTwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:52:09 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D1B36E01
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:52:08 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7650A1809CE;
        Tue, 24 May 2022 15:52:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NoLSnFraw1ydy52onAuh4WxEhysCpH3B4PU8zW
        NjVyg=; b=Alwab2dCOxV71pYHsXqMVRAWMHfoTjxxGtzh9mEPVIZXSK0UiVwt2v
        ufzZ2yT+7V0Oxrapo12YHnfAJnFFBpvX7jDU0N9vs7gniAK6LpEdhj4Myf+MzjOP
        b2O3wSPqerEOxdQhRXq1ZxMNOOtpXBmE+Vk3XkqvYwzpQIAVWQAM0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DD7C1809CD;
        Tue, 24 May 2022 15:52:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 192771809CC;
        Tue, 24 May 2022 15:52:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v7 26/30] t/helper/hexdump: add helper to print hexdump
 of stdin
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <6f2e935f148e826609153378751c04807858e76c.1653336765.git.gitgitgadget@gmail.com>
        <xmqqk0acosks.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205241415040.352@tvgsbejvaqbjf.bet>
Date:   Tue, 24 May 2022 12:52:03 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205241415040.352@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 24 May 2022 14:16:07 +0200 (CEST)")
Message-ID: <xmqqbkvmhfoc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC9CD8C4-DB9A-11EC-B582-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Do you know of any `grep` implementation that has problems with text
> missing the usual trailing newlines?

I recall that we had reports on BSD variants, but please do not
quote me on that.  Perhaps all the BSD variants are good now, or
perhaps some aren't.

In any case, I do not take the "if it works on Windows and Linux, we
do not care about the rest of the world" world view, so finding the
answer to that question unfortunately does not give much input to
the issue in either way.

And in this particular case, it is much simpler to mak sure that the
file does not end in an incomplete line than us exchanging e-mails
back and forth, so that would be the most economical solution I
would prefer.

Thanks.

