Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818BCC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 16:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C13760FBF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 16:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhKLQLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 11:11:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52584 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhKLQLL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 11:11:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2181816E431;
        Fri, 12 Nov 2021 11:08:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VfPrYyaBLtHY
        a/Mw+k30II2bWbDCW0ASzxrzyNSzIY0=; b=w3YkutuOcl1F7K5YdRzNO5pBUdvG
        HDrCyM477Vg8sqIxhPfu4fAZfueFOXxFsofO6wnBH1ZF9tp1xV5Sf4qnk6eG3MNL
        YF3zkRpttNpTVxOVkbZK9J+ka53yk+bFsSRQLWUEPeSzDsW3pMZuEq9BkEi0uWIW
        Xcs2Qu4VdsFrN/0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19B6B16E430;
        Fri, 12 Nov 2021 11:08:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 75E3916E42F;
        Fri, 12 Nov 2021 11:08:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Aleen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH 0/2] am: support --always option to am empty commits
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
        <6da5e984-1dcf-4c55-976c-49ffb8d128bf@web.de>
        <xmqqy25tj2fi.fsf@gitster.g>
        <ca9baf51-28ca-048d-ded6-f4834874f7c3@web.de>
Date:   Fri, 12 Nov 2021 08:08:16 -0800
In-Reply-To: <ca9baf51-28ca-048d-ded6-f4834874f7c3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 12 Nov 2021 16:28:30 +0100")
Message-ID: <xmqqmtm9tkzz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BF668BCC-43D2-11EC-BBCD-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>> The symmetry is compelling, but "always" is quite generic.  I can see
>>> e.g. someone expecting "git am --always" to imply --keep-non-patch.
>>
>> What symmetry?
>
> To have the same option in both producer and consumer.

Well, "--always" that stands for "--always-show-header" seeps
through to the command line parser from revision.c layer but that is
by accident, and is not even documented.  We may want to file it as
a bug and fix it later.

As you mentioned, allow-empty-commit does sound like a much better
name.


