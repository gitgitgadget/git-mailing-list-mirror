Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9621FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 21:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755374AbcK1V0H (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 16:26:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52647 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754925AbcK1V0G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 16:26:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2CAE54096;
        Mon, 28 Nov 2016 16:25:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=URl89ykvHS3+
        CPjvCY8DC8p4iiE=; b=IanrqtkSMRVflcscBd35fbQNvN6pMi6f4MH3+HxzQq1x
        M1GvDDwq2GlaYcF+KNEnpYZROVLUQ0v1XGQz8CWSg63wEzCa9zzdE+U1FC41Hh8P
        5AQTUR3ct5glRtpn3vEs7v4Vrcp7NA3KP97shNs2qpoQOLUOAGmd913ytSFPUpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EL4Ptt
        09ERD4GpVuBA/ZjW7FEeI6p7mu7uGZ48J5wShIcEWaeGo21E4zGkFFQrsU1GngV8
        6OIyBplVvLzVyrR56abTb+m03M5NgOeEpClyd9O2opTClMv94qfuvTo7JC8XR/Vy
        oAkxs4IVpbYVP7RFhtbWVEpSHuhW6DQ/MSGjU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2BC254095;
        Mon, 28 Nov 2016 16:25:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0208C54094;
        Mon, 28 Nov 2016 16:25:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, rappazzo@gmail.com
Subject: Re: [PATCH v2 0/5] nd/worktree-list-fixup
References: <20161122100046.8341-1-pclouds@gmail.com>
        <20161128093656.15744-1-pclouds@gmail.com>
Date:   Mon, 28 Nov 2016 13:25:57 -0800
In-Reply-To: <20161128093656.15744-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 28 Nov 2016 16:36:51 +0700")
Message-ID: <xmqqoa0zi9ei.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 414498BA-B5B1-11E6-B0FD-E98412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This version
>
> * changes get_worktrees() to take a flag, and adds one flag for
>   sorting.
>
> * adds tests for both the 'main worktree always present' and the
>   sorting problems.
>
> * reworks 3/5 a bit, keep changes closer, easier to see the cause and
>   consequence.
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
>   worktree.c: zero new 'struct worktree' on allocation
>   worktree: reorder an if statement
>   get_worktrees() must return main worktree as first item even on error
>   worktree.c: get_worktrees() takes a new flag argument
>   worktree list: keep the list sorted
>
>  branch.c                 |  2 +-
>  builtin/branch.c         |  2 +-
>  builtin/worktree.c       | 14 ++++++++------
>  t/t2027-worktree-list.sh | 40 ++++++++++++++++++++++++++++++++++++++++
>  worktree.c               | 42 +++++++++++++++++++++-------------------=
--
>  worktree.h               |  4 +++-
>  6 files changed, 74 insertions(+), 30 deletions(-)

Thanks for a pleasant read.  Will replace what has been queued.
