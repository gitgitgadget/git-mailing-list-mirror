Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167011F991
	for <e@80x24.org>; Mon,  7 Aug 2017 01:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbdHGBbT (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Aug 2017 21:31:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62448 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751375AbdHGBbS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2017 21:31:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75159AEDCE;
        Sun,  6 Aug 2017 21:31:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=unb7ClAC8TIggMBAH458xMuBK5s=; b=YyjlDp
        Tie9l4H2EMN0jntOyEO154PEZ9CZOoU2tjtRPXdu9uTV1XzOO0YjMJFd8bMu8xZX
        PCscV06YwUkjq4gLImlA6meXd8q6XuvGrZ1CtWIBouPUBCsUeLj8a8GhvnQxE681
        zrI4c6xds5f0962yoBJ5A+Xp+wnXAtZJEWP/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MUxULFljgwxjGqfMD2vQp8ceWAyfxZOc
        /rwQrOl2mQsl3DGrvutrTNC7RhWSsrO/1jptaG2xrwQSnJqXt+wHoQAnH6f5HiEw
        F/nWuk7CX/NUP21LP0k0OMGDlZcY34j28FGpzrVS4/QkOss2Ku+DS2QkLqnZVhv7
        56hum/l4uwU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C9D4AEDCD;
        Sun,  6 Aug 2017 21:31:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9374AEDCC;
        Sun,  6 Aug 2017 21:31:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Forney <mforney@mforney.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Drop some dashes from built-in invocations in scripts
References: <20170805064905.5948-1-mforney@mforney.org>
        <xmqqlgmxskm6.fsf@gitster.mtv.corp.google.com>
        <CAGw6cBtKF-Xt4z3m4gBDQvaSnurbtHURe737s8XMX78ca_RTcA@mail.gmail.com>
        <xmqqh8xlsiaq.fsf@gitster.mtv.corp.google.com>
        <CAGw6cBsYiGH1h8C8qFp-yX3arzkaRi_vghpjbErxjoYHXxpu+Q@mail.gmail.com>
Date:   Sun, 06 Aug 2017 18:31:08 -0700
In-Reply-To: <CAGw6cBsYiGH1h8C8qFp-yX3arzkaRi_vghpjbErxjoYHXxpu+Q@mail.gmail.com>
        (Michael Forney's message of "Sat, 5 Aug 2017 22:35:47 -0700")
Message-ID: <xmqq8tiwrwo3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 174934C4-7B10-11E7-B763-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Forney <mforney@mforney.org> writes:

> Ah. Well, it looks like all but git-merge-resolve.sh run `.
> git-sh-setup`, so we know that GIT_EXEC_PATH must in their PATH (and
> at the front unless the script was invoked directly).
>
> git-merge-resolve.sh does not do this, so I suppose if the user ran
> $GIT_EXEC_PATH/git-merge-resolve directly, and also had a custom
> git-merge-index executable in their PATH, that would switch to running
> the git merge-index built-in instead.

We are good then.  Nobody other than "git merge" should be running
merge-resolve, so the original probably is OK.

Thanks for digging deeper.
