Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46472C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 19:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245265AbiBQTgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 14:36:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245260AbiBQTgm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 14:36:42 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC70B6432
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 11:36:27 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D4B0A185FBE;
        Thu, 17 Feb 2022 14:36:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6Exwfgmu7avRuBUJQ+oeibPQRhLOel380kRr/q
        PoM4U=; b=linFMogtv40yuNfivutzX2uqKJb3XS/xxuSSZQ9xmIpd0cXbMOXcUR
        8KQP3S1n3FsMysECOiR6gSKjm3kUlzX5C5HMOOYMFLbfQxJkovHJRbt3tDzjaqxF
        sw5ymZe5pT8eKK/bKCTB2eBdaLF+cjqrulwRYUNsLrMBdsFVsGi0U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CBF33185FBD;
        Thu, 17 Feb 2022 14:36:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 43089185FBB;
        Thu, 17 Feb 2022 14:36:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 00/30] Builtin FSMonitor Part 2
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2202171655390.348@tvgsbejvaqbjf.bet>
Date:   Thu, 17 Feb 2022 11:36:23 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2202171655390.348@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 17 Feb 2022 17:06:26 +0100 (CET)")
Message-ID: <xmqqpmnl8evc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E42D23EC-9028-11EC-BC04-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> In this version I removed the core.useBuiltinFSMonitor config setting and
>> instead extended the existing core.fsmonitor.
>
> I am somewhat surprised that a reviewer suggested this, as it breaks the
> common paradigm we use to allow using several Git versions on the same
> worktree.

I do not think sharing the same repository with different versions
of Git was considered as a possible source of problems during the
review discussion.

https://lore.kernel.org/git/74282d08-aaeb-0a1e-cad3-1de17d59b4d1@jeffhostetler.com/

I am not saying that we should not consider it; I am just stating
the fact that there was nobody who raised as a potential issue
during the discussion that lead to the cited message.
