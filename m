Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D625C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 19:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46662467E
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 19:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a3NjImxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgA1TW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:22:27 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56346 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgA1TW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 14:22:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8073DB0212;
        Tue, 28 Jan 2020 14:22:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xG/oBEWWsy69TzFwCfEVnH85beU=; b=a3NjIm
        xOpIhymsVyyzrSmvk6c1Bl80el3kUx8AH80NkVeBqaLnj88rUSNbsr4mxZzApjDw
        1OUHvNhnUOsYTQ0p2a9H7KVx3g194v7b5jHJoxDYrPajPXuj9D4iNI28Zq8DOF50
        MjwCCxdPK5IZWdKN7ITL0JkuNur+wx4UaQULc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QsPt6LVEfsUpreaVI7ufjJU1S394x4sh
        /BoRY00KTL5sGlbSLEKpxXuWT1Qq+d+oDa0aba6P17rW1pPE9+IgSCoROzu90MMY
        XUbUIq8MmfGELYho66cHfeclkPsli2KEYXjm7s9hk34MOayy5NrlE6PxEP3fsWbQ
        mfJtcnA+HJM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77FF8B0211;
        Tue, 28 Jan 2020 14:22:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A47EBB0210;
        Tue, 28 Jan 2020 14:22:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v3] git: update documentation for --git-dir
References: <pull.537.v2.git.1580091855792.gitgitgadget@gmail.com>
        <pull.537.v3.git.1580185440512.gitgitgadget@gmail.com>
Date:   Tue, 28 Jan 2020 11:22:21 -0800
In-Reply-To: <pull.537.v3.git.1580185440512.gitgitgadget@gmail.com> (Heba Waly
        via GitGitGadget's message of "Tue, 28 Jan 2020 04:24:00 +0000")
Message-ID: <xmqq7e1b8jyq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82E9D00A-4203-11EA-AECF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  --git-dir=<path>::
> -	Set the path to the repository. This can also be controlled by
> -	setting the `GIT_DIR` environment variable. It can be an absolute
> -	path or relative path to current working directory.
> +	Set the path to the repository (".git" directory). This can also be
> +	controlled by setting the `GIT_DIR` environment variable. It can be
> +	an absolute path or relative path to current working directory.
> ++
> +Specifying the location of the ".git" directory using this
> +option (or GIT_DIR environment variable) turns off the

Consistently quote, like `GIT_DIR`, here?

> +repository discovery that tries to find a directory with
> +".git" subdirectory (which is how the repository and the
> +top-level of the working tree are discovered), and tells Git
> +that you are at the top level of the working tree.  If you
> +are not at the top-level directory of the working tree, you
> +should tell Git where the top-level of the working tree is,
> +with the --work-tree=<path> option (or GIT_WORK_TREE

Likewise.  We may probably want to say `--work-tree=<path>` inside a
bq pair, and definitely `GIT_WORK_TREE` inside a bq pair.

> +environment variable)
> ++
> +If you just want to run git as if it was started in <path> then use
> +git -C.

This is the best part of this patch, I would think.  But you said
<path> in the "if" part of this "if--then", so (unless your Git
magically can read users' minds some magic), I'd expect to see the
same <path> to appear somewhere in the "then" part.

	If you just want to run git as if it was started in `<path>`
	then use `git -C <path>`.

perhaps?
