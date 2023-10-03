Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EC5E8FDB2
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjJCUZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjJCUZl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:25:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54477AD
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:25:38 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3D6A1B86AF;
        Tue,  3 Oct 2023 16:25:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=c3wvnwRybbncGeSzig9GDQd2GbSDc/TdDymq6o
        0G2wU=; b=ki1uyFD48o0c4J9RLXfa5lCu+WAYgMhjOefQhKUjXB+9pSxksGzk8a
        r4vmwcgZu5LiImb7GQT+hKpVwejxSX6H73q1iKPSgFs9btVW6aDBflw8bsxUVGuj
        55n7l1XhOF4v60K6EskVfmzReIUfJxn1XNIhyvPy2hpkKGINEJgEg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC0BB1B86AE;
        Tue,  3 Oct 2023 16:25:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F8B91B86AD;
        Tue,  3 Oct 2023 16:25:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "cousteau via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Javier Mora <cousteaulecommandant@gmail.com>
Subject: Re: [PATCH v2] git-status.txt: fix minor asciidoc format issue
In-Reply-To: <pull.1591.v2.git.1696350802820.gitgitgadget@gmail.com> (cousteau
        via GitGitGadget's message of "Tue, 03 Oct 2023 16:33:22 +0000")
References: <pull.1591.git.1696193527923.gitgitgadget@gmail.com>
        <pull.1591.v2.git.1696350802820.gitgitgadget@gmail.com>
Date:   Tue, 03 Oct 2023 13:25:36 -0700
Message-ID: <xmqq4jj7zc5b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0336DB68-622B-11EE-A123-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"cousteau via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Javier Mora <cousteaulecommandant@gmail.com>
>
> The paragraph below the list of short option combinations
> isn't correctly formatted, making the result hard to read.
>
> Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
> ---

The above probably no longer describes the situation the patch
intends to correct, I suspect.  It used to be near-impossible hard
to read, but at least with them indented they are legible.

	The additional states for submodules are typeset differently
	from how the states for paths for normal blobs are listed as
	enumeration.  Format them in the same way for consistency.

or something like that, perhaps.

>  Documentation/git-status.txt | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index b27d127b5e2..48f46eb2047 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -246,10 +246,9 @@ U           U    unmerged, both modified
>  
>  Submodules have more state and instead report
>  
> -		M    the submodule has a different HEAD than
> -		     recorded in the index
> -		m    the submodule has modified content
> -		?    the submodule has untracked files
> +* 'M' = the submodule has a different HEAD than recorded in the index
> +* 'm' = the submodule has modified content
> +* '?' = the submodule has untracked files
>  
>  since modified content or untracked files in a submodule cannot be added
>  via `git add` in the superproject to prepare a commit.

Thanks for making this part of the documentation better.

