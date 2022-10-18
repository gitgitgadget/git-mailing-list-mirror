Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BDAC433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 17:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJRRLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJRRLn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 13:11:43 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE07C1495
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 10:11:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CAE516466E;
        Tue, 18 Oct 2022 13:11:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hfW1YX2zxpYE+BFS3GE9612x4Bgmw+Agxzmn9v
        JQFvs=; b=fTPDrYq0WuUYoTE/0Q+xy3f8ms3i6r2fcWKO48xKptM3AqUf+X1PAU
        5SxFuM/ecfB6GU/V//G8YZ4D3/5tmJ0k9i+pcltrdnjAzkXShgLiiZFYBGyd5DKI
        ctutZShBj16SZccHB8ZXZcc7UJ1+O/qDmAOmY2kY6cC+K3vMbGAtM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05C4716466D;
        Tue, 18 Oct 2022 13:11:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FD4116466C;
        Tue, 18 Oct 2022 13:11:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric DeCosta <edecosta@mathworks.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqo7u9wyt7.fsf@gitster.g>
        <kl6l4jw1yshm.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Tue, 18 Oct 2022 10:11:36 -0700
In-Reply-To: <kl6l4jw1yshm.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 18 Oct 2022 10:03:01 -0700")
Message-ID: <xmqqzgdtt5tj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECB2505C-4F07-11ED-97AD-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I wished we had caught it sooner too. The folks here generally agree
> that our weekly release cycle is not ideal for reasons such as this.
> Hopefully this is good motivation to move that work forward, though I
> can't promise anything right now.

It is perfectly OK to have an automated trial build job that runs
more frequently than your weekly release cycle, though.  It should
usually yield only a single bit of usable information (e.g. "there
is no 'does not even build from the source' issue in upstream") that
may give you assurance (e.g. "if we maintain the course, the next
real build for release would hopefully go smoothly"), but when it
breaks, you have more time to react.

Thanks.



