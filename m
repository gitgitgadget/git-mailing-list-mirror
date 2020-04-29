Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E30EC83006
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E534B208FE
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DIBkzMtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgD2RBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:01:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55720 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgD2RBj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 13:01:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EE6145719;
        Wed, 29 Apr 2020 13:01:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1id8q7reJ5/L3ShIbm3w7/S6mAs=; b=DIBkzM
        ttoj7hPUon2pd55RmmfWwkhKKcbp3N1QN0pU2rdqM/+LMF90rR1MkuDwaMHmYiuJ
        wBhl9qL8DexTQzMxOFo54pCk1Zf+iYg/AD9ZOgUdA11vxAPWdhjBV7ZjYqzCBpas
        uYpv13Aj/fe4mRdPR8rp9LkrLyh8C4PhCif5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VSaP5p0uDzQV26rnDQwGURxBSB7AYJYq
        iogGZFOWXYyMZjEFIyB1UH7yzRxkcCiaPhuqCXDAh8fVppwFEfr2N5pua6zq+Y7x
        bEjHh15QTCnEUTaqPQTXAvdisMH2bkiSJuPCrBSjsNKE/awXF4nxNtsBVmoI9Plu
        WjZakQZS1m0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55B4645718;
        Wed, 29 Apr 2020 13:01:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9BC145716;
        Wed, 29 Apr 2020 13:01:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 2/4] gitfaq: changing the remote of a repository
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
        <20200429093811.8475-2-shouryashukla.oo@gmail.com>
Date:   Wed, 29 Apr 2020 10:01:35 -0700
In-Reply-To: <20200429093811.8475-2-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 29 Apr 2020 15:08:09 +0530")
Message-ID: <xmqqees6xm34.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 162A3434-8A3B-11EA-8CCF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Add issue in 'Common Issues' section which addresses the problem of
> changing the remote of a repository, covering various cases in which
> one might want to change the remote and the ways to do the same.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  Documentation/gitfaq.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index b1e758ffd1..7d294306f9 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -232,6 +232,17 @@ I asked Git to ignore various files, yet they are still tracked::
>  	it is advised to use `git rm --cached <file>`as well as make
>  	the file pattern is mentioned in the '.gitignore'.
>  
> +[[changing-remote-of-the-repository]]
> +I want to change the remote of my repository. How do I do that?::
> +	A remote is an identifier for a location to which Git pushes your
> +	changes as well as fetches any new changes from (if any). There
> +	might be different circumstances in which one might need to change
> +	the remote URL (see linkgit:git-remote[1]). To change the remote URL
> +	one may use: git remote set-url <name> <newurl>
> ++
> +One can list the remotes of a repository using `git remote -v` command.
> +The default name of a remote is 'origin'.

With the trimming, it got a lot easier to follow.  

We should strive to (1) make sure any FAQ entry can have a pointer
to more comprehensive and canonical documentation, and (2) an FAQ
entry with such a pointer does not consume more than one paragraph,
say no more than 5 lines.

It may be tempting to cram as much information as it comes to your
head as possible when writing a FAQ document, but for those who need
FAQ list, a list of pointers with clear and concise summary is more
helpful.

Thanks.
