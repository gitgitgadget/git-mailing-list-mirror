Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AD611FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 19:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754606AbcK1TsK (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 14:48:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55669 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751515AbcK1TsI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 14:48:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A1FC53E8E;
        Mon, 28 Nov 2016 14:48:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uzRcGHJNuYQe
        NyQ/MW1+IJ3JnlU=; b=CfQTQezCj47Itx+TLZpIzVPiORQxV17c5JpsWVJQ/nFK
        9seLpy/HiAUYLHhqnu/nDP52XKNE6jjCzjht7dXJBSRxYk8C1IXe1JtuMj0qDZCA
        sIU+CvBfSMpj69OQSPzHVFkRy+Yscih3kVSEqGKuRx+lOVd4qa3GyAabsZzivd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pKSsje
        vzPKRKFbw1Lttn3PIhnhSzsTGm5J8/hgUrXc2sJBmNx7Jdxfo2Vu135kc8ODdnw0
        h0j+QY2aRFDhEK7RPSKwRAri4FiQ9gMo2UzlTeVLxkJtVIr2olZtSus1oWdnZR2y
        p/WlfknPhGZPmDxGdLcAveFN+0fVoukVoTJ3c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8288253E8D;
        Mon, 28 Nov 2016 14:48:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15A1D53E8C;
        Mon, 28 Nov 2016 14:48:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 00/11] git worktree (re)move
References: <20161112022337.13317-1-pclouds@gmail.com>
        <20161128094319.16176-1-pclouds@gmail.com>
Date:   Mon, 28 Nov 2016 11:48:05 -0800
In-Reply-To: <20161128094319.16176-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 28 Nov 2016 16:43:08 +0700")
Message-ID: <xmqqwpfnidxm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 95548298-B5A3-11E6-BF35-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> v2 contains some style fix and adapts to the new get_worktrees() api
> from nd/worktree-list-fixup (which means it can't be built without
> that series).
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (11):
>   copy.c: import copy_file() from busybox
>   copy.c: delete unused code in copy_file()
>   copy.c: convert bb_(p)error_msg to error(_errno)
>   copy.c: style fix
>   copy.c: convert copy_file() to copy_dir_recursively()
>   worktree.c: add validate_worktree()
>   worktree.c: add update_worktree_location()
>   worktree move: new command
>   worktree move: accept destination as directory
>   worktree move: refuse to move worktrees with submodules
>   worktree remove: new command
>
>  Documentation/git-worktree.txt         |  28 ++-
>  builtin/worktree.c                     | 181 ++++++++++++++++
>  cache.h                                |   1 +
>  contrib/completion/git-completion.bash |   5 +-
>  copy.c                                 | 369 +++++++++++++++++++++++++=
++++++++
>  t/t2028-worktree-move.sh               |  56 +++++
>  worktree.c                             |  84 ++++++++
>  worktree.h                             |  11 +
>  8 files changed, 724 insertions(+), 11 deletions(-)

Does this round address the issue raised in=20

  http://public-inbox.org/git/alpine.DEB.2.20.1611161041040.3746@virtualb=
ox

by Dscho?

Even if you are not tracking a fifo, for example, your working tree
may have one created in t/trash* directory during testing, and
letting platform "cp -r" taking care of it (if that is possible---I
didn't look at the code that calls busybox copy to see if you are
doing something exotic or just blindly copying everything in the
directory) may turn out to be a more portable way to do this, and I
suspect that the cost of copying one whole-tree would dominate the
run_command() overhead.

