Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF00C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 16:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbiGMQWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 12:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbiGMQWt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 12:22:49 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589B424BD1
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 09:22:48 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F0EB13B033;
        Wed, 13 Jul 2022 12:22:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CTeDTNPGi5jVL+ee+yDKirVuUYp/I4EGZLs2/5
        Q9Kes=; b=ONWyrhFA9mrp8sSQd1C+fD174imIDproeLdb6b6k5MFZIXMyGmYb9W
        15zo/CCrjp9qDtNUz4yB2XjeuQ0ek5PZZ+klzzO6vj56i/C4m+d5gJOWl2VaH6S1
        aNxcXMlYcsQo/xOg/wDNtCiLIMwHPRzlP+f0Eb9SFUf46NJqK5hf8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 966B913B032;
        Wed, 13 Jul 2022 12:22:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 037F513B031;
        Wed, 13 Jul 2022 12:22:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fernando Ramos <greenfoo@u92.eu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mergetool(vimdiff): allow paths to contain spaces again
References: <pull.1287.git.1657726969774.gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 09:22:44 -0700
In-Reply-To: <pull.1287.git.1657726969774.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 13 Jul 2022 15:42:49
        +0000")
Message-ID: <xmqqfsj5dlt7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0777874A-02C8-11ED-8CFF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> To fix this, let's not expand the variables containing the path
> parameters before passing them to the `eval` command, but let that
> command expand the variables instead.

Yup, that is exactly the right approach to fix this kind of
breakage.

Thanks for a clear description of the problem and the solution.

Fernando?  Ack?
