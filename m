Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34295EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 16:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjF3QZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 12:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjF3QZP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 12:25:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D47E5E
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 09:25:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23E612825A;
        Fri, 30 Jun 2023 12:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MaNzYg71uUbZ3JYSWNa/MQyIdhwvEH/h5a11x5
        oqsyI=; b=W1Jis9Zq3irzDmpbq/dph1riVNrkxMLBAFxYD4FnRpOslB8I28SkMu
        2W1JD5iAfyCKomoLHIVcmY/hbtPPxTq6V6siPyEA+c/UTsNmNdYAhcbmSQJnyg2T
        IRJ6WJY7G6bCHGGuNGlSvvYt5Hc095Y2pOiZDwW0pU59/uRztbNNw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0AE9928259;
        Fri, 30 Jun 2023 12:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5DE3428258;
        Fri, 30 Jun 2023 12:25:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, nasamuffin@google.com,
        git@vger.kernel.org
Subject: Re: [PATCH] docs: include "trace.h" in MyFirstObjectWalk.txt
References: <20230629185238.58961-1-vinayakdev.sci@gmail.com>
        <xmqqjzvm7z13.fsf@gitster.g>
        <CADE8NapyQJU1rDPvyMcRXcJfz3kzzg_fYXSSEvYJ7dFO+UHGaQ@mail.gmail.com>
Date:   Fri, 30 Jun 2023 09:25:07 -0700
In-Reply-To: <CADE8NapyQJU1rDPvyMcRXcJfz3kzzg_fYXSSEvYJ7dFO+UHGaQ@mail.gmail.com>
        (Vinayak Dev's message of "Fri, 30 Jun 2023 11:39:08 +0530")
Message-ID: <xmqqsfa87w9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADBAB622-1762-11EE-A63A-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vinayak Dev <vinayakdev.sci@gmail.com> writes:

> That is a good suggestion, but wouldn't the same argument apply to
> including trace.h itself? It makes it necessary for the code to work
> that any API changes must involve changing the included headers.

Exactly.  That is exactly what I meant by "tone down 'defined in X'
somehow to hint that these details may change".  

IOW, it may allow us to "cop out" of the problem to say "You'd add a
new file like so, and call this API function, and include headers
necessary to do so.  The codebase may have evolved since this
tutorial was written, so some details (like names of the API
functions and in which header files the functions are declared) may
be different in the code you have."

> Either way, I would be happy to fix my mistake. Should I send out a V2?

Oh, sorry to see you took it that way.  I think the change you sent
as-is is a fine fix for the immediate problem.  Everything you
quoted above is "while the issue is fresh on our minds, what are the
follow-up improvements we can make" material, so there is no "mistake"
to fix.
