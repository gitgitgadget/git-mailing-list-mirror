Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83383C3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 20:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E52246A2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 20:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lnU9muJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgB1UWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 15:22:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59139 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1UWb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 15:22:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 371BE49D2F;
        Fri, 28 Feb 2020 15:22:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qTSHtQJ64H7pbn3ckHgxzazDSyo=; b=lnU9mu
        J0GSOu8NojWXIaISZH8ECGWpunfcTLbCzMzwW1J2W986i7zYsdNA6rnkKxQNS/+B
        oxMB4xQpwBDhrRi03cvFysd9/RJyWjdfWe98irsCK0MrGWQpdGKuUYfaXfEz53wU
        /R0PlifPiMEP3nYWNKr9T9ACZC8VSk8UHHkUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xfYjhwWJQ8VMtx4vTtzovm3pbs3vXK2U
        rMx56K3qd2bG5L6znUAe2Xs08l9MeK3O+qlVQNRLfd7IKsGOEFx9mUePi4l0AIin
        WvfOHcnwheMb0RpNojJXhGO63qt7cJcW2r87DoYPwz3EcJn74eVil3xVao0qkT1Q
        8aZT8H+TpiA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DBE549D2E;
        Fri, 28 Feb 2020 15:22:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8500949D2D;
        Fri, 28 Feb 2020 15:22:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Damien Robert <damien.olivier.robert@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: GIT_DIR in aliases [Re: Spurious GIT_DIR set when in a worktree [was Re: Nested submodule status bug]
References: <20200214224242.knmzkwx7ls4sote7@doriath>
        <0123F1ED-C421-4C1F-896B-E54C9D345A34@gmail.com>
        <20200226172338.unembhjhog36sqj7@mithrim>
        <20200227100557.ydouc4n3jphzbits@feanor>
        <20200227104330.hp7zf2suquxsf6zw@feanor>
        <20200227155057.7idpa447ixo6sf6j@feanor>
        <20200228190218.GC1408759@coredump.intra.peff.net>
Date:   Fri, 28 Feb 2020 12:22:26 -0800
In-Reply-To: <20200228190218.GC1408759@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 28 Feb 2020 14:02:18 -0500")
Message-ID: <xmqq4kvaea2l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A63E120-5A68-11EA-834C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes, the recommended thing is to make sure GIT_DIR is unset if you're
> going to chdir around and expect auto-discovery of the repository to
> work.
>
> Note there are other variables you might want to unset, too, if you're
> switching repositories. Doing:
>
>   unset $(git rev-parse --local-env-vars)
>
> would cover the full list.

Thanks for mentioning --local-env-vars; I was going to ask you to
mention GIT_WORK_TREE anytime you mention unsetting GIT_DIR, but you
did it much better ;-).

