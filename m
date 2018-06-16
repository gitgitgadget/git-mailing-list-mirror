Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A43D81F403
	for <e@80x24.org>; Sat, 16 Jun 2018 20:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932797AbeFPULq (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 16:11:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57786 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFPULq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 16:11:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65FB5E3323;
        Sat, 16 Jun 2018 16:11:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=vbtiac+OeCiFoXU24KXv/lKT6UQ=; b=s5KxdLH
        VLbhoc2Vh+tDYkowjH40B9g/szal0wuEMmXJWR0BSNhKebqmwm7rLuNNPxsvy6W6
        MG3KmLy0HLWwgUOtCUSwyLtzS0BJ2ZEQt8p3i3OLexfLVofhMjYu51648HaosqXo
        TdGB1bxkgmA+eRDmT/UE4YY2bo5AfRpoTmY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=K8l9aFpvK3tFNEBUOh97hNzumQFFowGfj
        CR0XdlrRmHk0g3iDBIwJiAHkcUlbDu2WbJmDRVOQO+Cv3Ygr2X4ox5N3I4f5ZIiR
        Qt+H9NFjDybGLF8C8o0JmwU7QPsbUfAV2AGCTNEGRDHYfeKVT4D7Pr2TZZiJEQdq
        /k9EEXTz/Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D790E3322;
        Sat, 16 Jun 2018 16:11:45 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6875E3321;
        Sat, 16 Jun 2018 16:11:44 -0400 (EDT)
Date:   Sat, 16 Jun 2018 16:11:43 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] rebase --root: fix `reword` on a root commit
Message-ID: <20180616201143.GH11827@zaya.teonanacatl.net>
References: <pull.3.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.3.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 7DD99480-71A1-11E8-84DB-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin via GitGitGadget wrote:
> From: GitGitGadget <gitgitgadget@gmail.com>
> 
> Todd Zullinger reported this bug in
> https://public-inbox.org/git/20180615043111.GS3094@zaya.teonanacatl.net/:
> when calling git rebase --root and trying to reword the
> root commit's message, a BUG is reported.
>
> This fixes that.
> 
> IMO the bug fix is trivial enough to qualify for inclusion into v2.18.0, still.

It does indeed fix the issue.  I agree it would be nice to
see it in 2.18.0.  As a fix for a minor regression
introduced in this cycle, that seems reasonable.

> Johannes Schindelin (1):
>   rebase --root: fix amending root commit messages
> 
> Todd Zullinger (1):
>   rebase --root: demonstrate a bug while amending root commit messages
> 
>  sequencer.c                   | 2 +-
>  t/t3404-rebase-interactive.sh | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 68372c88794aba15f853542008cda39def768372

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I don't mean to sound cold, or cruel, or vicious,
but I am, so that's the way it comes out.
    -- Bill Hicks

