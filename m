Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048E5C433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 06:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiBZGJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 01:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiBZGJa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 01:09:30 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ADE114FD2
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 22:08:54 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A74631682A4;
        Sat, 26 Feb 2022 01:08:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z9yxu2+Xo8sXQOCAIuu6dBZ8icJcjRsSYv94nY
        P0JbU=; b=VRjnd44jPHMxfLJIXFITzm+BfQd5gw89GmlpPfurCyiCytKvhE0zIA
        ZNZmAtamCqZFboBbpZ501UzKWvwiOWSKlxwlgTy02Z/VYHcQpEz5H1yPs7AG/YlD
        vY8WLnk03aGEaK1biXFi5W5nTnZ1bKvN7Ce87swzooD6lsOemk/+k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9373A1682A3;
        Sat, 26 Feb 2022 01:08:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E9EE41682A2;
        Sat, 26 Feb 2022 01:08:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
References: <pull.1147.v3.git.1645626455.gitgitgadget@gmail.com>
        <pull.1147.v4.git.1645766599.gitgitgadget@gmail.com>
        <e1c5a3258263d05530f236c247603c2f342dac85.1645766599.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2202251632320.11118@tvgsbejvaqbjf.bet>
        <xmqqpmna76jz.fsf@gitster.g>
Date:   Fri, 25 Feb 2022 22:08:49 -0800
In-Reply-To: <xmqqpmna76jz.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        25 Feb 2022 17:36:16 -0800")
Message-ID: <xmqqa6ee6txq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9177CD8E-96CA-11EC-B33D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I would imagine that large enough platforms that have their own
> conditionally compiled #ifdef/#endif block already have CI to build
> their conditionally compiled block in practice.  I do not see the
> above as a compelling reason to grow and shift the scope of these
> two patches.

Let's instead drop [2/2] for now.  I do not want us to go back to
shell script that pretends to know about C language, and I do not
want to block [1/2] by waiting for a replacement.  Fixes in [1/2]
are pretty much uncontroversial ones that can even be fast-tracked
down to 'master'.


