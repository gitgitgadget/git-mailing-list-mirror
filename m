Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1243C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 19:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7758F64E31
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 19:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbhCATGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 14:06:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55885 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240985AbhCATDO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 14:03:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D2D41233C9;
        Mon,  1 Mar 2021 14:02:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pNzOK/+lWIDt0BpSRkLdP+DGdh4=; b=mQu4Lj
        o4szkbBFxwfoO5hZjy8okZVVyEIibmDVmq6pJ3LPctEYsX3D6W/hk2tPDRLvO7gr
        mZxwEZeHQvTogUvnkh14sB72Ze/KxA+sFi4GZ8qLA4ece+Y5MhCdrZBzGXn4y9Rh
        fOAW3nkgeGbdZw655AlbOuZLZrm53XvnSZfV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dx0qtqC3gBEHmdt0XfWUVCWKj72GgmID
        WjBOWx0lP8VMO4fLl53dtbs4p6aSL4RI54dok84HoO0xMpUUeNvI0HeLbDdHL8Ed
        DVo6ku2BNZ2v7+a5A1vE1I8fhtrQYMuCPeO+ewTqun824NgTfL0AKPzM//ikHI6C
        Fzri8oH+Nc4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45A691233C8;
        Mon,  1 Mar 2021 14:02:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86FA71233C7;
        Mon,  1 Mar 2021 14:02:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Marco Luzzara via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Marco Luzzara <marco.luzzara@hotmail.it>
Subject: Re: [PATCH] docs: clarified that --lost-found implies --no-reflogs
References: <pull.970.git.git.1614610921331.gitgitgadget@gmail.com>
Date:   Mon, 01 Mar 2021 11:02:26 -0800
In-Reply-To: <pull.970.git.git.1614610921331.gitgitgadget@gmail.com> (Marco
        Luzzara via GitGitGadget's message of "Mon, 01 Mar 2021 15:02:00
        +0000")
Message-ID: <xmqq4khur931.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAF91A8C-7AC0-11EB-AFAC-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Marco Luzzara via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Marco Luzzara <marco.luzzara@hotmail.it>
>
> git fsck --lost-found does not look for references in the reflog. If not specified, it could create misunderstandings like this one: https://stackoverflow.com/questions/66401232/git-fsck-combining-lost-found-and-unreachable

Thanks for attempting to improve our documentation.

 - Please avoid an overly long line like the above.  Wrap your line
   at around 60-70 columns.

 - Please do not force readers to visit external site to understand
   why your change is useful.  You should be able to summarize the
   puzzlement described there in a few sentences, something like:

	The documentation does not say "git fsck --lost-found" uses
	"--no-reflogs" to make it easier to find objects that are
	not reachable from the tip of refs, which leads people to
	wonder why commits that are reachable only from reflogs are
	shown as dangling (see https://stackoverflow.com/questions/66401232
	for an example).

   perhaps.

> @@ -89,7 +89,7 @@ care about this output and want to speed it up further.
>  	Write dangling objects into .git/lost-found/commit/ or
>  	.git/lost-found/other/, depending on type.  If the object is
>  	a blob, the contents are written into the file, rather than
> -	its object name.
> +	its object name. This option implies `--no-reflogs`.

It also would be a good idea to explain why it implies that.

THanks.
