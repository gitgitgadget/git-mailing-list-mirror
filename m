Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB41BC001DE
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 21:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjHGVSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjHGVSR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 17:18:17 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E621737
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 14:18:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E3CF1A71F0;
        Mon,  7 Aug 2023 17:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PnlpNZg1VJtp
        GutlNYnRzW0WqGoyEaWhRJGVA8NfVks=; b=CHEQ+Q3orocYfr+y34hDd7XEuAMo
        Hf9lqOjhi6i1OFxBE7ZBmtOTaJK15qwN/8V2ifWy9awetL6dSRe4FLTNBkTpqiZ+
        RDvecXYd1z8pWpEffuaz0seaBMb83Kc96p9yG6NHvcPf3gs4rhEMcXZqCoWtXaOd
        +gRGNe9MLwxJC50=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46C611A71EF;
        Mon,  7 Aug 2023 17:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A57E41A71EE;
        Mon,  7 Aug 2023 17:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] branch: update error messages
References: <7710c002-0832-d8f6-59b8-30119bd5efe6@gmail.com>
Date:   Mon, 07 Aug 2023 14:18:14 -0700
In-Reply-To: <7710c002-0832-d8f6-59b8-30119bd5efe6@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Mon, 7 Aug 2023 22:38:38 +0200")
Message-ID: <xmqqy1imblgp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC44EF16-3567-11EE-A954-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> A message like "branch 'frog' checked out at ..." may be confusing to
> the user if the branch 'frog' is not the currently checked out branch,
> which may occur while rebasing, bisecting or other operations.

Makes sense.  Will queue.


>
> Let's reword those messages as it has been done in 4970bedef2 (branch:
> update the message to refuse touching a branch in-use, 2023-07-21).
>
> Rub=C3=A9n Justo (2):
>   branch: error message deleting a branch in use
>   branch: error message checking out a branch in use
>
>  branch.c                |  2 +-
>  builtin/branch.c        |  2 +-
>  t/t2400-worktree-add.sh |  3 ++-
>  t/t3200-branch.sh       | 14 +++++++++++++-
>  t/t3400-rebase.sh       |  2 +-
>  5 files changed, 18 insertions(+), 5 deletions(-)
