Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA58C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 00:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C492070A
	for <git@archiver.kernel.org>; Mon, 18 May 2020 00:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mtdWIJAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgERAcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 20:32:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63265 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgERAck (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 20:32:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CF65AC0B30;
        Sun, 17 May 2020 20:32:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AmFOPrxeUQFEs3DjvERuje3K60s=; b=mtdWIJ
        Aew6rNgrZMOBqcf/qE3XVQ9KnTaih77Qj9EqKdSlgbbWT/BiLN0g7oI/dpKoxqb/
        +NZ41VJIpJnHtOFuCTHmagtKeeQrNCOIMrmov3c0MnurxnLah6NPwOSZqSEoJnYq
        UcL4++LWapXX6Gi1UQAv1j8VWENjD0h5HOO6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cMhhk5NVW45WWkLUpcjvnIiZT20ZAYI4
        un9vg0nbn8N9OYbGLHIP87kn64TPpQG5B8DW2EA9ArZ1DR10i6x1ePVzBVyP8cp3
        zYnWKxjTHc/OQeQ0E4nVF7zaSvjXk1Y2yL/0E2Xd7SgGnvRW+PAElljhrYg+71rv
        o46LV0sKrSE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C6106C0B2F;
        Sun, 17 May 2020 20:32:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8CE35C0B2D;
        Sun, 17 May 2020 20:32:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kenneth Lorber <keni@hers.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] Tell config.txt about NAMESPACE COLLISIONS
References: <1589681624-36969-1-git-send-email-keni@hers.com>
        <1589681624-36969-6-git-send-email-keni@hers.com>
Date:   Sun, 17 May 2020 17:32:33 -0700
In-Reply-To: <1589681624-36969-6-git-send-email-keni@hers.com> (Kenneth
        Lorber's message of "Sat, 16 May 2020 22:13:43 -0400")
Message-ID: <xmqqmu665bha.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11E8EC4A-989F-11EA-BD12-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kenneth Lorber <keni@hers.com> writes:

> From: Kenneth Lorber <keni@his.com>
>
> Add a link to the NAMESPACE COLLISIONS information where git help config
> only mentioned the issue without supplying any guidance for how to do that.
>
> Signed-off-by: Kenneth Lorber <keni@his.com>
> ---
>  Documentation/config.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ef0768b91a..1e819c26f0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -310,7 +310,9 @@ in the appropriate manual page.
>  Other git-related tools may and do use their own variables.  When
>  inventing new variables for use in your own tool, make sure their
>  names do not conflict with those that are used by Git itself and
> -other popular tools, and describe them in your documentation.
> +other popular tools, and describe them in your documentation.  See
> +'NAMESPACE COLLISIONS' in linkgit:gitrepository-layout[5] for guidelines
> +to prevent such conflicts.

The configuration variable namespace is a shared resource, and it
does make sense to give a provision for third-party tools to
coordinate to avoid stepping on each others' toes.

The repository-layout document is about a physical on-filesystem
structure that ought to be blackbox to third-party tools, so the
link target may have to be different from what this patch wants to
add, though.  

I'd rather not to have such a document prematurely; if we were to
add something to this paragraph (and I do think it is a good idea to
say a bit more than "you're on your own but make sure you do not
conflict with Git and other people" which is what we have there in
the original), I'd just stop at telling readers to come here to the
list to discuss and solicit input from other Git stakeholders.

Thanks.

