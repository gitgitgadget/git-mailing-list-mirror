Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34154C433E0
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 22:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 030E420723
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 22:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YRgCxk4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGFWmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 18:42:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55160 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGFWmY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 18:42:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D29DD6C0A;
        Mon,  6 Jul 2020 18:42:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l8wZbkJrh2ZPJjpNCmMQCKe23R8=; b=YRgCxk
        4aJ92HrXzOs9H4hXFSytstkRfoIEQz1N0D1WpjTmi0fDkSF6/G8tOarfKja742WA
        JyAyS5MKiEvAkD3sx3sQqaUQXEyrSAmJWxM39MmuV0T0d3pXTg3CJUukelPfbwgU
        zglklXRYPxHGgYPW4P/ifp/9/4/SQ0q+LTybE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DYL0fHhiw2yQuKhg55p7n0vqIEeG31yW
        Dm4KQXIojU51y0UZsBzBg7CV28bUXCjj/14JHmni/HzTu0I5XMjpcGDKHs8JDcqh
        NkrBOHF9WLFmWX0VQfbEpgJrdLD3uRZbKEu/H+FJkAOwkp80XlZbLXDElHd4/cKf
        rb8wtZaYDQQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 05631D6C09;
        Mon,  6 Jul 2020 18:42:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 509DFD6C08;
        Mon,  6 Jul 2020 18:42:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexey via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alexey <lesha.ogonkov@gmail.com>
Subject: Re: [PATCH] Fix zsh installation instructions
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
Date:   Mon, 06 Jul 2020 15:42:18 -0700
In-Reply-To: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com> (Alexey
        via GitGitGadget's message of "Thu, 02 Jul 2020 10:51:20 +0000")
Message-ID: <xmqqr1to8dv9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F392054E-BFD9-11EA-B0D5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Alexey <lesha.ogonkov@gmail.com>

Thanks.

Any zsh users raise their hands?  Does this change look sane?

> - Fix wrong script in completion configuration. zsh wants bash completion
>   path here, not path to itself.
> - Add `compinit` autoload command, since whole thing didn't work
>   if it is not loaded.
>
> Signed-off-by: Alexey <lesha.ogonkov@gmail.com>
> ---
>     Fix zsh installation instructions
>     
>      * Fix wrong script in completion configuration. zsh wants bash
>        completion path here, not path to itself.
>      * Add compinit autoload command, since whole thing didn't work if it is
>        not loaded.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-814%2Fogonkov%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-814/ogonkov/patch-1-v1
> Pull-Request: https://github.com/git/git/pull/814
>
>  contrib/completion/git-completion.zsh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
> index ce47e86b60..107869036d 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -9,13 +9,14 @@
>  #
>  # If your script is somewhere else, you can configure it on your ~/.zshrc:
>  #
> -#  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
> +#  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
>  #
>  # The recommended way to install this script is to make a copy of it in
>  # ~/.zsh/ directory as ~/.zsh/git-completion.zsh and then add the following
>  # to your ~/.zshrc file:
>  #
>  #  fpath=(~/.zsh $fpath)
> +#  autoload -Uz compinit && compinit
>  
>  complete ()
>  {
>
> base-commit: a08a83db2bf27f015bec9a435f6d73e223c21c5e
