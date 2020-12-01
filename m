Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F8EC8300F
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 18:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5420321741
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 18:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ctAKOF0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392242AbgLASa7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 13:30:59 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64286 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391625AbgLASa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 13:30:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D4BF113E43;
        Tue,  1 Dec 2020 13:30:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wWptkOy0A5wa93mS+z3P2l+00QM=; b=ctAKOF
        0GxwHFcINXGLbdXklhGuEc6VZldA4HY0vfb3Amd6l1CNNxeVCdnSNk03mLFDlVTU
        MsPIDE5nOQjLeSRWY7Ko9mc/ZvThVk141Lf3SebcThyTRcQZcNFhOyVlwcdQi1U7
        NoJJwVW07BFhJCk36B49aje4N+UCcSNfZ83yM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HkoI2h1ZqCsIi+DzQAdin24Fj+1sEsHs
        PWOSwCL/5UmuoERTlNIwTK2rWq5eVFiuE46nlL/KlyaOKk8vMQkx4oVeIc6flb3U
        ZSdvBVK2+sJ3ITTMgQM5NTR2QYnrcpeO0jHThu8k9wIS/JhJ5sNhg1rUhcT3Da3j
        nQ9mXnAPFnk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 96608113E42;
        Tue,  1 Dec 2020 13:30:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6ADF1113E3F;
        Tue,  1 Dec 2020 13:30:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] .gitignore: remove dangling file
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
        <20201201004649.57548-3-felipe.contreras@gmail.com>
Date:   Tue, 01 Dec 2020 10:30:12 -0800
In-Reply-To: <20201201004649.57548-3-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Mon, 30 Nov 2020 18:46:47 -0600")
Message-ID: <xmqqczztqszv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40F8D0C2-3403-11EB-9F47-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The library was removed 7 years ago on commit ae34ac126f. But not from
> the .gitignore file.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Good eyes.  Any automation used here, or just mark I eyeballs?

>  .gitignore | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/.gitignore b/.gitignore
> index f85d02c854..7c5096aee5 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -135,7 +135,6 @@
>  /git-remote-ftps
>  /git-remote-fd
>  /git-remote-ext
> -/git-remote-testpy
>  /git-repack
>  /git-replace
>  /git-request-pull
