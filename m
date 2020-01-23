Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2D9C33CAA
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 06:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAEF24676
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 06:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SAygFWIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgAWGlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 01:41:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64868 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgAWGlv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 01:41:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C28F43D5E;
        Thu, 23 Jan 2020 01:41:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d/iF8Xi+qYUA9NhSxEBA04alpX8=; b=SAygFW
        IjYz9W47jI1GDZodcTZjemL/ExvW9Rd9jc+e9/DM2LCY4Ln/gZXB5pBqAFWy1vxJ
        XIgkw08aMtAjWfOoT9ELhnM+Owsr2dMXdCVgCQjCVCevXGtI0henAw9ihO/zc72G
        Jqkls20Igilgha//F1GHgmIy5wbMh3di5OZrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D4uyhtJVe46oCX+c2wpadlUguqv1hkFh
        mGCEtR+y/8ahDwpu1MlWlT8Xb9RXKF71GpqCyIl2DxrwsRcDgE0NcJC7+7NR/QaJ
        DVD2B7BymeCR9qQZNG+Lv928Xi0FMGhHwmzBtm2nykE0QuwPupYMQ/3t3MoOH7kH
        xlFrtv2A550=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 638E043D5D;
        Thu, 23 Jan 2020 01:41:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B73B843D5C;
        Thu, 23 Jan 2020 01:41:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH] git: update documentation for --git-dir
References: <pull.537.git.1579745811615.gitgitgadget@gmail.com>
Date:   Wed, 22 Jan 2020 22:41:46 -0800
In-Reply-To: <pull.537.git.1579745811615.gitgitgadget@gmail.com> (Heba Waly
        via GitGitGadget's message of "Thu, 23 Jan 2020 02:16:51 +0000")
Message-ID: <xmqq1rrq65ed.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DB79A2A-3DAB-11EA-84A1-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  --git-dir=<path>::
> -	Set the path to the repository. This can also be controlled by
> -	setting the `GIT_DIR` environment variable. It can be an absolute
> -	path or relative path to current working directory.
> -
> +	Set the path to the repository (i.e. the .git folder). This can also be

I suspect (i.e. ".git") may be clear enough, but if you must, say
".git directory", not ".git folder", as you mention "current working
directory" later.

> +	controlled by setting the `GIT_DIR` environment variable. It can be
> +	an absolute path or relative path to current working directory.
> +
> +	Note that --git-dir=<path> is not the same as -C=<path>.

Surely, of course.

> +	It's preferrable to set --work-tree=<path> as well when setting
> +	--git-dir to make sure Git will run your command across the correct
> +	work tree.

It does not help the readers that much to say "It's preferrable"
without saying what negative implications there are if they don't
use it, or what positive effect they would observe if they do.

If I were writing it, I'd drop "Note that..." and rewrite the three
lines more like...

	Specifying the location of the ".git" directory using this
	option (or GIT_DIR environment variable) turns off the
	repository discovery that tries to find a directory with
	".git" subdirectory (which is how the repository and the
	top-level of the working tree are discovered), and tells Git
	that you are at the top level of the working tree.  If you
	are not at the top-level directory of the working tree, you
	should tell Git where the top-level of the working tree is,
	with the --work-tree=<path> option (or GIT_WORK_TREE
	environment variable)

perhaps.

>  --work-tree=<path>::
>  	Set the path to the working tree. It can be an absolute path
>  	or a path relative to the current working directory.
>
> base-commit: 232378479ee6c66206d47a9be175e3a39682aea6

I do not know if GGG users have control over this, but I'd prefer to
see a "-- " divider before this "base-commit: ..." footer material.
