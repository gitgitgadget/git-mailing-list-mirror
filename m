Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9CFC001B0
	for <git@archiver.kernel.org>; Sun, 13 Aug 2023 19:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjHMToS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Aug 2023 15:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjHMToR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2023 15:44:17 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D259810DB
        for <git@vger.kernel.org>; Sun, 13 Aug 2023 12:44:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 292331B6DFE;
        Sun, 13 Aug 2023 15:44:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uH2MoMTs+nBdxcybVaspavStKGqYWyzY3aBFwE
        bi0OU=; b=LeRdO+f73oQm+1tXJCPtTNkreQp06NB/QDpVDbQVJvprojzd24ruzs
        V7PhN/V+otnNn4rvA+w9Q13zF2j5S7L+m88kDeNl0wSwar51KZ5xuinKiWMyLD29
        oCCLI6VaAcfspGOK/7g9PxgKswbyegT/M2E0fJqABYD1PLSGJ7cyc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20F6D1B6DFD;
        Sun, 13 Aug 2023 15:44:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 88BBD1B6DFC;
        Sun, 13 Aug 2023 15:44:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [wishlist] git-add(1), git-restore(1): -U for more context
 (with -p)
References: <8bbfa6fe-fdaa-aeaf-51bc-16b3d3f7afaa@kernel.org>
Date:   Sun, 13 Aug 2023 12:44:17 -0700
In-Reply-To: <8bbfa6fe-fdaa-aeaf-51bc-16b3d3f7afaa@kernel.org> (Alejandro
        Colomar's message of "Sun, 13 Aug 2023 21:21:20 +0200")
Message-ID: <xmqq350mohgu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAC37DA4-3A11-11EE-B079-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alejandro Colomar <alx@kernel.org> writes:

> It would be useful to have -U in git-add(1) and git-restore(1)
> to be able to see more context in combination with -p.

Even more useful would be to add commands to enlarge/shrink the
context to the interactive prompt, wouldn't it?  Not all hunks need
unformly large context and having to decide how many lines of
context to ask upfront and having to stick to the choice during the
whole interactive session would be a bad interactive experience.
