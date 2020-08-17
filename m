Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF780C433ED
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 16:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5764A20674
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 16:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HounMY4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbgHQQr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:47:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51436 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731355AbgHQQrX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 12:47:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D33206E392;
        Mon, 17 Aug 2020 12:47:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WJyS5fIRT6cFSVav99hTYq5VZpA=; b=HounMY
        4vOkD1laeAgLben6zDaaEGBJkk6v97LKfWVpHF71E/8ZEjfphr6DhIkEf/F8LADB
        FVTCnkys9tOPPZzxzCC/w4XcYHpeQKefpoHoTh+C/imPHPwZzwA/1EhFr69M8QRx
        mAeAAcSSZQwVFr78BtLIwPes4+wU70ttvlIWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bSX3ov9VAvwzdWUeu2PSBV8Kq5C/bodC
        zNzADih37Z31bjLHtYeUzWAACIffkZVYPujm3EmORFKfCvhBH8jEh3X0L1QJ1W5r
        pJQVg3d75hVkQ8T7GfS5mnY6RWubUOoc15+NbaGwEGQYWLAYfFF5IHsEz9Jqe6Fu
        dsa+tjLLJHY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB9E46E391;
        Mon, 17 Aug 2020 12:47:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A7D56E390;
        Mon, 17 Aug 2020 12:47:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danny Lin <danny0838@gmail.com>
Cc:     git develop <git@vger.kernel.org>
Subject: Re: [PATCH] Revise supported options for --message in subtree doc.
References: <CAMbsUu6WnHori2t1qG=6UVLWDNEw5FSXeTd-K6WKnpZi5h6q+w@mail.gmail.com>
        <20200815023247.788-1-danny0838@gmail.com>
Date:   Mon, 17 Aug 2020 09:47:19 -0700
In-Reply-To: <20200815023247.788-1-danny0838@gmail.com> (Danny Lin's message
        of "Sat, 15 Aug 2020 10:32:47 +0800")
Message-ID: <xmqq4kp143u0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 511D88C4-E0A9-11EA-A152-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danny Lin <danny0838@gmail.com> writes:

> Subject: Re: [PATCH] Revise supported options for --message in subtree doc.

Documentation/SubmittingPatches:[[summary-section]]

> Revise the documentation and remove previous "unsure" after making sure
> that --message supports only 'add', 'merge', 'pull', and 'split --rejoin'.
>
> Signed-off-by: Danny Lin <danny0838@gmail.com>
> ---
>  contrib/subtree/git-subtree.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
> index 352deda69d..9ccd431c7f 100644
> --- a/contrib/subtree/git-subtree.txt
> +++ b/contrib/subtree/git-subtree.txt
> @@ -139,7 +139,7 @@ OPTIONS
>  
>  -m <message>::
>  --message=<message>::
> -	This option is only valid for add, merge and pull (unsure).
> +	This option is only valid for add, merge, pull, and split --rejoin.
>  	Specify <message> as the commit message for the merge commit.

