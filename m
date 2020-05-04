Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11789C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D149C206D9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 16:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QCDQ3le3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgEDQhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 12:37:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60228 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbgEDQhS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 12:37:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CD180DA397;
        Mon,  4 May 2020 12:37:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BQ4JgK6d6NkV
        Rsv7g7lIY+TUyN4=; b=QCDQ3le3GMmqzCzC3YEbIoh8pZq51IRqcMDYUrP3NU/5
        LCFX3kYTmH2jOTxvfVhRtJmPVmXMPyNN9Jode4yNRDlhnv5NmgejBsLsveuwn+a1
        F7ib5dph1hb7p/BLZM+fNTOecDwuNlw7eDL1Lp49m56X3RrY0bwD6J4ResN8LlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GUiKGX
        notcYzM9fK/IEG2bpEHq3WNkLNWlXcn+ErGzsnAhClJnWrBu5qi361quJnlyY22a
        lSItAS380F44eRhnYsBPKdJtBZJi6pW3cFkIF3QHFVDB6IRYdIh+nGZs7F4qGL0p
        LFUfzsrcAPpzOMWkUBAAEdSU28Sa/bXQBDUDE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C55C5DA396;
        Mon,  4 May 2020 12:37:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 02F80DA395;
        Mon,  4 May 2020 12:37:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] SubmittingPatches: advertise GitHub Actions CI
References: <20200504150105.GB11373@coredump.intra.peff.net>
        <cover.1588607262.git.congdanhqx@gmail.com>
        <24a8fefe5add61d557a29f070bd2ca0d0f43d844.1588607262.git.congdanhqx@gmail.com>
Date:   Mon, 04 May 2020 09:37:11 -0700
In-Reply-To: <24a8fefe5add61d557a29f070bd2ca0d0f43d844.1588607262.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Mon, 4 May
 2020 22:49:32 +0700")
Message-ID: <xmqqmu6nhd1k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 81C46730-8E25-11EA-8D53-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> +Alternately, you can use GitHub Actions (which supports testing your c=
hanges
> +on Linux, macOS, and Windows) by pushing into a branch whose name star=
ts
> +with "for-ci/" or opening a GitHub's Pull Request against
> +https://github.com/git/git.git

Can you tighten the description of "for-ci/" a bit?  It's not like
the convention is offered in _any_ repository, but it is active only
if you push to a fork of git.git, right?  If your fork is a fork of
a fork, what happens (e.g. github.com/gitster/git is marked as a
fork of git/git; when somebody forks from gitster/git, would they
also get the for-ci/ convention)?

Thanks.

