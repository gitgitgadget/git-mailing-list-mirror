Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2D9C43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 20:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359759AbiFGUtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 16:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356449AbiFGUsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 16:48:05 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCBB532C8
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 11:39:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5159B1250F5;
        Tue,  7 Jun 2022 14:39:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F61Fd3fpSC33DJNwWU7pHGjTcw2F8mx/OkTK6Y
        LROZs=; b=JF3mAVjSaqOCn0uhjdsbKQcQiUO3YQBeWZQnXBJGGnvg7/ZZ1TztYQ
        EKuMBFhVCN7yv0uByrp67fLHrwc4FpRzjlqHD6vAaphedxR8O4yaJv4KZKKFBhA4
        keAUmyh86iDO6uKu7f58fZSwxBvnlBukBSPKuBPnM9/lo48THfgiA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 482C01250F4;
        Tue,  7 Jun 2022 14:39:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4A721250EF;
        Tue,  7 Jun 2022 14:39:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Vicent Marti <tanoku@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 1/3] bitmap-format.txt: feed the file to asciidoc to
 generate html
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
        <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
        <a1b9bd9af90df88b7ce14de60a9626d2a1f2d3e8.1654623814.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 11:39:08 -0700
In-Reply-To: <a1b9bd9af90df88b7ce14de60a9626d2a1f2d3e8.1654623814.git.gitgitgadget@gmail.com>
        (Abhradeep Chakraborty via GitGitGadget's message of "Tue, 07 Jun 2022
        17:43:32 +0000")
Message-ID: <xmqqa6aowc6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E700330-E691-11EC-AA27-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Documentation/Makefile does not include bitmap-format.txt to generate
> a html page using asciidoc.
>
> Teach Documentation/Makefile to also generate a html page for
> Documentation/technical/bitmap-format.txt file.
>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  Documentation/Makefile | 1 +
>  1 file changed, 1 insertion(+)

The change itself is obviously correct (assuming that it is worth
passing the document to AsciiDoc, instead of reading it in text,
that is).

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index d3f043f50d2..8d405a14330 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -94,6 +94,7 @@ TECH_DOCS += MyFirstContribution
>  TECH_DOCS += MyFirstObjectWalk
>  TECH_DOCS += SubmittingPatches
>  TECH_DOCS += ToolsForGit
> +TECH_DOCS += technical/bitmap-format
>  TECH_DOCS += technical/bundle-format
>  TECH_DOCS += technical/hash-function-transition
>  TECH_DOCS += technical/http-protocol

Is bitmap-format the only one that is not fed to AsciiDoc, by the
way?  Are there other 'text-only' document that is worth converting
to AsciiDoc? 

It is outside the scope of this series, of course, to actually
adjusting them, but since you are already doing the homework, I
thought you might already know the answer, which may become a source
of inspriation for others to find something to work on.

Thanks.



