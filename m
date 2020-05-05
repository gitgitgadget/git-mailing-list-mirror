Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC44C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C1A206FA
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JNLB4pJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgEESg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 14:36:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62005 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgEESg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 14:36:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46944BC921;
        Tue,  5 May 2020 14:36:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9voxNebv4IIIRYRl39q+1L9D3jc=; b=JNLB4p
        J2fq/TAXIVVwsd/4w2hSLe7DjVrTbtJ9W3jyeW0y4kaLhGmmCPHOcdWw5ZIosqio
        nxlWFnzYZzoCTLNaR7Z4ixz7RxGU23TDHhZ5KPkV82Tc0TcrFieXuP7R7ZF/Yg6D
        CsEGoRGr10zHhnqkC4MvfQAu89xn03oxAibbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=viBLkDQcJHaP9KEi+N+UGlsmVgpo/PPX
        xFDjLQETmaxli6JxJuGStEQOaHxfv0wybuyJm0UWgqB43j0TGQxMaYksdAOgPjXv
        rUkk2RFU7rv1X25ZikQwWwQ22RWwqOmrErm+WJOh/TCs5Pb5CX8lveZfvbQmXo/k
        h8n1DWXMtwA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E870BC920;
        Tue,  5 May 2020 14:36:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E848BC91E;
        Tue,  5 May 2020 14:36:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] Doc: reference the "stash list" in autostash docs
References: <0b898ca26b0399e9f14b9170f6586014dee80cf5.1588683624.git.liu.denton@gmail.com>
Date:   Tue, 05 May 2020 11:36:22 -0700
In-Reply-To: <0b898ca26b0399e9f14b9170f6586014dee80cf5.1588683624.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 5 May 2020 09:00:59 -0400")
Message-ID: <xmqq8si6b55l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52C4F938-8EFF-11EA-9C12-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In documentation pertaining to autostash behavior, we refer to the
> "stash reflog". This description is too low-level as the reflog refers
> to an implementation detail of how the stash works and, for end-users,
> they do not need to be aware of this at all.
>
> Change references of "stash reflog" to "stash list", which should be
> provide more accessible terminology for end-users.

Sounds like a good thing to do.

>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> Notes:
>     This patch is based on 'dl/merge-autostash-rebase-quit-fix'.

Thanks.  This kind of note is very much appreciated.

>  Documentation/git-merge.txt  | 4 ++--
>  Documentation/git-rebase.txt | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index ec06b2f8c2..3819fadac1 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -106,12 +106,12 @@ commit or stash your changes before running 'git merge'.
>  `MERGE_HEAD` is present unless `MERGE_AUTOSTASH` is also present in
>  which case 'git merge --abort' applies the stash entry to the worktree
>  whereas 'git reset --merge' will save the stashed changes in the stash
> -reflog.
> +list.
>  
>  --quit::
>  	Forget about the current merge in progress. Leave the index
>  	and the working tree as-is. If `MERGE_AUTOSTASH` is present, the
> -	stash entry will be saved to the stash reflog.
> +	stash entry will be saved to the stash list.
>  
>  --continue::
>  	After a 'git merge' stops due to conflicts you can conclude the
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 7d0c89a184..fa969d8064 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -257,7 +257,7 @@ See also INCOMPATIBLE OPTIONS below.
>  	Abort the rebase operation but HEAD is not reset back to the
>  	original branch. The index and working tree are also left
>  	unchanged as a result. If a temporary stash entry was created
> -	using --autostash, it will be saved to the stash reflog.
> +	using --autostash, it will be saved to the stash list.
>  
>  --apply:
>  	Use applying strategies to rebase (calling `git-am`
