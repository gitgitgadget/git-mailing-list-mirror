Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91231C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645F020674
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E2A7Atk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbgHQTh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:37:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61952 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732416AbgHQTh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 15:37:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46653850E2;
        Mon, 17 Aug 2020 15:37:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DWPV7+1+WMuJLfH+VswFk8J2zXQ=; b=E2A7At
        k9Lon3Gql2nuh79dhho5TVuycF7GtP3Gn4lISSWHtxdjZMqE9dXU1mblkbcoQQsZ
        xktDlWMdJwYdwhJLsxfkvZi+IEvmAz9y9QvmUKxGkVA4VzIzZ9ir8OxdU5f90vg2
        SblpfbOP20gSGGpXo491XyiL6Bn+6nIWj/5+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UwIljXeYIf7wds07USKYisRbCt0U2fD0
        8yuHmT04j3A9TeaXQji87R9xtgK7apEMjmL4dAZybsdspXj3TNr0hT5ym03HOUSI
        REB9OAhwz+gWoIO13hcVh2QBxV91e/6pVA1XU9FU6MnzDtXP1NW88erRerTXcX/j
        ArsGLNFR1IE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EE5E850E1;
        Mon, 17 Aug 2020 15:37:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9225850E0;
        Mon, 17 Aug 2020 15:37:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3 0/9] [Resend][GSoC] Improvements to ref-filter
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
        <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 12:37:24 -0700
In-Reply-To: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com> (Hariom Verma
        via GitGitGadget's message of "Mon, 17 Aug 2020 18:10:13 +0000")
Message-ID: <xmqqh7t112tn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13719CFA-E0C1-11EA-A78D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is the first patch series that introduces some improvements and
> features to file ref-filter.{c,h}. These changes are useful to ref-filter,
> but in near future also will allow us to use ref-filter's logic in pretty.c

Overall the series was a pleasant read, except for some places I
found small questionable things.

Thanks, will queue.

