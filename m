Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBBCC83F01
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 00:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244642AbjHaA2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 20:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjHaA2K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 20:28:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1183BE
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 17:28:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A7341BB20E;
        Wed, 30 Aug 2023 20:28:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=s/fI0YgYDk3BD4KaUIY/n2a/oBMdGcTvgQuDnz
        8Na/k=; b=kPC3VE1Y211E9dCC9X3acK4UEckrtUpPcgM+IBJf/IZS47+nyzHhJq
        OZ+5gNknwP8ii9GnhGj5mEeNCIdC1LHDFS+3pMd4NWFuXp/fpdi1X1clPq1Abk4c
        S8VJxMj+O5PlmzianWMFkSDj/JuoyaNbcvy3lxwtW8RvcUhkIQ7jg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7044B1BB20D;
        Wed, 30 Aug 2023 20:28:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7A2F1BB20C;
        Wed, 30 Aug 2023 20:28:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Wesley <wesleys@opperschaap.net>, git@vger.kernel.org
Subject: Re: [PATCH] git-svn: drop FakeTerm hack
In-Reply-To: <20230831001325.GA2685726@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 30 Aug 2023 20:13:25 -0400")
References: <20230810004956.GA816605@coredump.intra.peff.net>
        <20230810011831.1423208-1-wesleys@opperschaap.net>
        <xmqqcyzupf3b.fsf@gitster.g>
        <8d683835-31d4-41f0-9d4e-90c95acbea28@opperschaap.net>
        <xmqqwmy2no2e.fsf@gitster.g>
        <20230811145121.GB2303200@coredump.intra.peff.net>
        <xmqqjzu1o97n.fsf@gitster.g> <xmqqa5u888lz.fsf_-_@gitster.g>
        <20230831001325.GA2685726@coredump.intra.peff.net>
Date:   Wed, 30 Aug 2023 17:28:04 -0700
Message-ID: <xmqqpm34ys17.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40C19E92-4795-11EE-9099-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Optionally you could add this to the commit message:
>
>   It has been obsolete in git-svn since 30d45f798d (git-svn: delay term
>   initialization, 2014-09-14). Note that unlike send-email, we already
>   make sure to load Term::ReadLine only once. So this is just a cleanup,
>   and not fixing any bug.

Thanks.  That reads extremely well.
