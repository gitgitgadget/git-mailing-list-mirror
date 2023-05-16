Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED524C77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 18:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjEPSon (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 14:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEPSol (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 14:44:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45117DBB
        for <git@vger.kernel.org>; Tue, 16 May 2023 11:44:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 71EC51FF48E;
        Tue, 16 May 2023 14:44:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+ljM62p0GHX8VNgNg9DpQvLYxCADD82dqeWaF6
        3cqHY=; b=PdlRXkX6Cz1jJo8GK27v03cYXxziZ5ni3NvzFyUdTLMX2DppPsmi5C
        s2QY7H/uu7IwmTRMK9mzyjwxWDc9jdAC/sc2QWQmHByNINVzGn64VWG6kY64++bn
        hL4B7uX36AYmPTvwMi3OQqAJKl03JWOmBjd+bPgk3uubpnlKFTJkI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A7DC1FF48D;
        Tue, 16 May 2023 14:44:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A04841FF48A;
        Tue, 16 May 2023 14:44:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] run-command.c: need alloc.h for our own at-exit handler
 emulation
References: <009501d98817$9eb44560$dc1cd020$@nexbridge.com>
        <ZGO4LesPe4A2ftdm@nand.local> <xmqqlehourbf.fsf@gitster.g>
        <xmqqh6scur3r.fsf_-_@gitster.g> <ZGPEHu2pCYfdNI0h@nand.local>
        <ZGPE9ozRChUJ3NGV@nand.local>
Date:   Tue, 16 May 2023 11:44:36 -0700
In-Reply-To: <ZGPE9ozRChUJ3NGV@nand.local> (Taylor Blau's message of "Tue, 16
        May 2023 14:01:26 -0400")
Message-ID: <xmqq353wune3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B59D956A-F419-11ED-8D94-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> OK, having now read both completely, I would say I have a vague
> preference for my version since it keeps the include at the top and
> unconditional, and has slightly more information in the patch message.
>
> But I do not prefer it so much over yours that I would be sad if you had
> already queued yours and didn't want to bother shuffling it around.

I do not have much preference between the two, either.  Both lack
one important description that we are reasonably confident that this
breakage is limited to run-command.c and no other files.

Thanks.
