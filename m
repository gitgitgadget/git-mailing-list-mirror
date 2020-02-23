Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF23FC35671
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 06:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FD0208C3
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 06:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JOlZVs9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgBWGYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 01:24:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57260 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgBWGYO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 01:24:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8F8E3A551;
        Sun, 23 Feb 2020 01:24:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Ighrgl85o6Aduyqi+TNP63k2uo=; b=JOlZVs
        9gtmM2imofWqPqi6y78LDvfUXQT1LaKF/B8BhxRALAV4E8L6RDRGd2YdW5iel0KU
        eGiFUAjQdTyTUhEZIRxmkJGDW2abtyuv8UQXI++fSnffJOn2Vj3ud5W5PVW3rwW3
        QWj5nxI7ldN+qK7NiNjdwHQxU32Slxua1Izdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u5Mptze6Cppq3SajBXhwU2mHM/JMpY5C
        UY8dRdR1qsHqXlbYxtNd++5G6ae5eMxV3j/gSI1xye1gXM8Bb964CM1PGdvca1pO
        rhKwFDSa0dOdQK5Q8ZNdin8Y5NOksXtdpjgx1uWjTlb8uPLOJQrIO7qiTd4GiVta
        w8oHf/pnsnQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFC943A550;
        Sun, 23 Feb 2020 01:24:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10BF53A54C;
        Sun, 23 Feb 2020 01:24:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 2/4] t5509: initialized `pushee` as bare repository
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
        <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
        <5c749e044a3846d7757b198f29d984d181636556.1582410908.git.gitgitgadget@gmail.com>
Date:   Sat, 22 Feb 2020 22:24:10 -0800
In-Reply-To: <5c749e044a3846d7757b198f29d984d181636556.1582410908.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Sat, 22 Feb 2020 22:35:05
        +0000")
Message-ID: <xmqqblppstx1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B49EB36-5605-11EA-AA68-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Hariom Verma <hariom18599@gmail.com>
> Subject: Re: [PATCH v2 2/4] t5509: initialized `pushee` as bare repository

s/initialized/initialize/ at least, perhaps.

Subject: [PATCH v2 2/4] t5509: use a bare repository for test push target

may be easier to understand, though.  Then the first paragraph of
the body of the proposed message, which gives an excellent
description of how the current tests rely on a bug that we plan to
fix in a later step of the series, explains why we do not want to
push into a non-bare repository.

> `receive.denyCurrentBranch` currently has a bug where it allows pushing
> into non-bare repository using namespaces as long as it does not have any
> commits. This would cause t5509 to fail once that bug is fixed because it
> pushes into an unborn current branch.

And then you give a good description why not just it is safe, but it
makes more sense.  Very well explained.

> In t5509, no operations are performed inside `pushee`, as it is only a
> target for `git push` and `git ls-remote` calls. Therefore it does not
> need to have a worktree. So, it is safe to change `pushee` to a bare
> repository.

>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Hariom Verma <hariom18599@gmail.com>
> ---
>  t/t5509-fetch-push-namespaces.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
> index 75cbfcc392c..e3975bd21de 100755
> --- a/t/t5509-fetch-push-namespaces.sh
> +++ b/t/t5509-fetch-push-namespaces.sh
> @@ -20,7 +20,7 @@ test_expect_success setup '
>  	) &&
>  	commit0=$(cd original && git rev-parse HEAD^) &&
>  	commit1=$(cd original && git rev-parse HEAD) &&
> -	git init pushee &&
> +	git init --bare pushee &&
>  	git init puller
>  '
