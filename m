Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1FF61F454
	for <e@80x24.org>; Thu,  7 Nov 2019 05:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfKGFQZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 00:16:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62476 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfKGFQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 00:16:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45E4636D0C;
        Thu,  7 Nov 2019 00:16:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3XbX0NH/SMUY0/TW+NGRqVe3DX8=; b=TSkOYk
        5IJyp8G3nar0NPi4Ck1yTjKvi8V1N2EnDVYxWg3rEkQ3HeuK87HvUHNp3imYdRtD
        jluQm01iRoogWKS1CBBTnFxVgAS/g7pAELT9Rk05aJjW6rGgvlQAk6oUQE4Q+Fg1
        tOM36mPqhg7xCLyRRZlJXh0wDN7gQ1WxJMeaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PIKDPQlFDHjGfPNLktK04a0e1JWOh+S3
        EFFWfnumw2HdAdeI8Iii23u7jj7pYCNgDf85hT18X9EFWv6tFydBhurCXKSrgok9
        MHoIslW413BLD/h+Xr5TqbFtD9+IqZyG1Ccvt41C4gJIQ7SI1nzutAd8/y/dmWes
        Y+I19x1PhVw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D56636D0B;
        Thu,  7 Nov 2019 00:16:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A26B936D0A;
        Thu,  7 Nov 2019 00:16:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 03/11] Prefer 'up-to-date' spelling
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
        <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
        <466aead9af6516ff94a5d217e58ab894e63088b7.1572973651.git.gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 14:16:21 +0900
In-Reply-To: <466aead9af6516ff94a5d217e58ab894e63088b7.1572973651.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 05 Nov 2019
        17:07:22 +0000")
Message-ID: <xmqqh83gs1ui.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD1EF5B0-011D-11EA-A933-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 33ea7810d8..8ba2dc3267 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -29,7 +29,7 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] 
>  	"Entry '%s' would be overwritten by merge. Cannot merge.",
>  
>  	/* ERROR_NOT_UPTODATE_FILE */
> -	"Entry '%s' not uptodate. Cannot merge.",
> +	"Entry '%s' not up-to-date. Cannot merge.",

As the name of this table says, this is a table of the plumbing
errors that are given without translation, in order to allow scripts
to read and act on them.  Wouldn't touching it break the promise to
the scripts?
