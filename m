Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D156CC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1ED20B1F
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iDVQve9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgEFRSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:18:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50978 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgEFRSB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:18:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19FF45F808;
        Wed,  6 May 2020 13:17:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RCTPrJgfCJw4XG1rN+kHrOeETSk=; b=iDVQve
        9Lc8VX/GwgKglVOfc4gKk5ptUOEmFijz16C++w77kLI9UcE7S9uR6NsJrj/egUnD
        1SjmC/OH3/Gopx7lL/zWuqDio65NeoTXbkSlj/g9AfVAjZZHTmACgugYgDOWKlcT
        rRkEW4CHbDzPfOftNM77cNrs9h1WYFv2Zlfeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sI3IOGsHxQrdTKidY0QC6aBfLY1mni94
        lwAhrIVs6VuDhz42xIvs/ZkyQHzSOqscW8OV+jJwTLdUugKU702tXNqbW5RltvHY
        VNL3Zz+tZ6/R1dRLq9oOUz3MGT85PRCYhKbXVX2IZZr6K1Ck0PlCV8o/cWxsZlcm
        +dZjnzqTPrU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1182F5F806;
        Wed,  6 May 2020 13:17:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 82E845F805;
        Wed,  6 May 2020 13:17:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, sandals@crustytoothpaste.net
Subject: Re: [PATCH v6 2/4] gitfaq: changing the remote of a repository
References: <20200506080023.12521-1-shouryashukla.oo@gmail.com>
        <20200506080023.12521-2-shouryashukla.oo@gmail.com>
Date:   Wed, 06 May 2020 10:17:57 -0700
In-Reply-To: <20200506080023.12521-2-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 6 May 2020 13:30:21 +0530")
Message-ID: <xmqqlfm56kze.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 883DF902-8FBD-11EA-B2C3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Add issue in 'Common Issues' section which addresses the problem of
> changing the remote of a repository.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  Documentation/gitfaq.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 11d9bac859..875cfa0acd 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -233,6 +233,17 @@ I asked Git to ignore various files, yet they are still tracked::
>  	and add a pattern to `.gitignore` that matches the <file>.
>  	See linkgit:gitignore[5] for details.
>  
> +[[changing-remote-of-the-repository]]
> +I want to change the remote of my repository. How do I do that?::
> +	A remote is an identifier for a location to which Git pushes your
> +	changes as well as fetches any new changes from (if any).  There
> +	might be different circumstances in which one might need to change
> +	the remote URL (see linkgit:git-remote[1]).  To change the remote URL
> +	one may use: git remote set-url <name> <newurl>

Up to this point it is a well written answer to "how do I change the remote".

> +One can list the remotes of a repository using `git remote -v` command.
> +The default name of a remote is 'origin'.

This is not.  Drop the paragraph, perhaps?

>  Hooks
>  -----
