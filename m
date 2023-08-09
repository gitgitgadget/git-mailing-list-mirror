Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291BDC001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 21:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjHIV5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjHIV5r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 17:57:47 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC9AA6
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 14:57:47 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A07D823A27;
        Wed,  9 Aug 2023 17:57:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5tUOVxzzkwv0hPpSdWVAZxtAkvh9iU/WR3xU2V
        MdYNY=; b=QGYhckBq9EFGi8aAAu+IPPSCUM0QholHH+gZnf9y5xosVxrIDjTXcm
        DQ7Ad00w8w7PmU1tsIGyeSAYFNSAOjedqYnPa+h8NGF161m0uzLsxGcgUbgb3VTz
        ppuunotboqDGshGJoZ+B5+VpMfYM7qdA+1YL55badqw+q6X7gVdwg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9817323A26;
        Wed,  9 Aug 2023 17:57:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7550923A22;
        Wed,  9 Aug 2023 17:57:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/8] Repack objects into separate packfiles based on
 a filter
References: <20230724085909.3831831-1-christian.couder@gmail.com>
        <20230808082608.582319-1-christian.couder@gmail.com>
        <ZNQI5vpcoXbkkPWa@nand.local>
Date:   Wed, 09 Aug 2023 14:57:40 -0700
In-Reply-To: <ZNQI5vpcoXbkkPWa@nand.local> (Taylor Blau's message of "Wed, 9
        Aug 2023 17:45:10 -0400")
Message-ID: <xmqq350rlvzf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C339E59C-36FF-11EE-BFA6-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> We *may* want to fix up the test_must_fail invocation that has the
> environment variable on the left-hand side instead of using
> "test_must_fail env", but I don't know for sure.

Ah, that is a show-stopper bug.  We must fix it, but the necessary
change should be trivial.

> Thanks again for being so patient with all of my review comments. I hope
> it wasn't too big of a pain; this area feels very fragile (to me, at
> least) so I wanted to give it an extra careful set of eyes.

Thanks for writing and reviewing.

