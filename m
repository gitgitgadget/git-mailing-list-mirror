Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BE0C433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 19:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDEE207D3
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 19:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qHYHC+OK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgIATQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:16:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54122 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIATQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 15:16:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 13B0BD92ED;
        Tue,  1 Sep 2020 15:16:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FaCOyX+gjPM7s0yxfcur+mmvI58=; b=qHYHC+
        OK5xZsbKz5huzAVFQsSTOmpLUw8OlUSOh/gZkQZd7PguITMiCU8eIetGIN8PGGO2
        Vh0JIJL/vZ70sm10rMfz98gA68oNvIJEbHDl9VHagmQzXs4QMaDH607Q6sWLpGok
        wgVNZ0+MVpFJTxXogfUAnXpX7VAPiXUTU3HWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GxJbHYCOhalhW4xsF8pGtt/xo3dd59cV
        CYPs4C1tRYA8/taCB4O+rIiItUatgzYzAZPwd6Irc1sjIev2zAPz1CbImXI5gk7E
        HwK1A8kq8/r18TkB4nlIPMxkSxlC+A3cLM2WW2qPXjmthqwJcL8pYQZ3Nvlg0N7y
        VCr+XqpGFDg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B46BD92EC;
        Tue,  1 Sep 2020 15:16:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 02024D92EB;
        Tue,  1 Sep 2020 15:16:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sean Estabrooks <seanlkml@sympatico.ca>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] git.txt: correct stale 'GIT_EXTERNAL_DIFF' description
References: <pull.718.git.1598966412371.gitgitgadget@gmail.com>
Date:   Tue, 01 Sep 2020 12:16:22 -0700
In-Reply-To: <pull.718.git.1598966412371.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Tue, 01 Sep 2020 13:20:12 +0000")
Message-ID: <xmqqpn75cnp5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0C56088-EC87-11EA-8B99-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
> index e8ed6470fb..b10ff4caa6 100644
> --- a/Documentation/diff-generate-patch.txt
> +++ b/Documentation/diff-generate-patch.txt
> @@ -10,7 +10,8 @@ linkgit:git-diff-tree[1], or
>  linkgit:git-diff-files[1]
>  with the `-p` option produces patch text.
>  You can customize the creation of patch text via the
> -`GIT_EXTERNAL_DIFF` and the `GIT_DIFF_OPTS` environment variables.
> +`GIT_EXTERNAL_DIFF` and the `GIT_DIFF_OPTS` environment variables
> +(see linkgit:git[1]).
>  
>  What the -p option produces is slightly different from the traditional
>  diff format:
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 2fc92586b5..98bdf0983c 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -551,8 +551,9 @@ Git Diffs
>  
>  `GIT_EXTERNAL_DIFF`::
>  	When the environment variable `GIT_EXTERNAL_DIFF` is set, the
> -	program named by it is called, instead of the diff invocation
> -	described above.  For a path that is added, removed, or modified,
> +	program named by it is called to generate diffs, and Git
> +	does not use its builtin diff machinery.
> +	For a path that is added, removed, or modified,
>  	`GIT_EXTERNAL_DIFF` is called with 7 parameters:

Excellent.  Thanks.   Will queue.
