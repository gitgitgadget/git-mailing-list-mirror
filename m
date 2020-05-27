Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFC7C433E1
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4A420873
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PxEmVj9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbgE0RFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 13:05:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50118 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbgE0RFI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 13:05:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 284C775970;
        Wed, 27 May 2020 13:05:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DKX4N7ugf2sz6fGkyhvLa0H4zSo=; b=PxEmVj
        9xwue0fwJQa37OkzCzu1+V0bxeFYbIDInFm3HKfN8pT9ExxjIzhOzDa7E0rM5hST
        omZGL/7mI0Cu0uiA3iS8IrjX3NDoYeMQ2r5JihzFkUckEIfWrL+Ttl4N5vlPFP/I
        IYNEmJxPj17W7CEQ9ggBdxV33Ead1398hkiq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ImRxT8l0rvr3DFnLMTBEYpoDdb7QsAeE
        8KYRFjswMck9M/pvafqpIpGznUSd2OpUK3GA8EB1TCqQ+8i0YxunAiM9vf2NIat2
        KRUbVUQ24cg9z6o4Oy6DbBgwLAQ0MSrj8rl8zJqURbq4bAlUruF8Rf0c7vOnkizV
        fAcM75daNYM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1798D7596E;
        Wed, 27 May 2020 13:05:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 469247596D;
        Wed, 27 May 2020 13:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Documentation: correct hash environment variable
References: <20200526183720.120314-1-toon@iotcl.com>
        <20200526183720.120314-2-toon@iotcl.com>
Date:   Wed, 27 May 2020 10:05:03 -0700
In-Reply-To: <20200526183720.120314-2-toon@iotcl.com> (Toon Claes's message of
        "Tue, 26 May 2020 20:37:20 +0200")
Message-ID: <xmqq1rn5mhq8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 360650FA-A03C-11EA-B7E8-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Toon Claes <toon@iotcl.com> writes:

> To set the default hash algorithm you can set the `GIT_DEFAULT_HASH`
> environment variable. In the documentation this variable is named
> `GIT_DEFAULT_HASH_ALGORITHM`, which is incorrect.

My reading stuttered while reading words around "to set ... you can
set"; I would have written

	The GIT_DEFAULT_HASH environment variable, which is the way
	to specify the default hash algorithm, was misspelled in the
	documentation.  Fix it.

but it's OK.

As you said, bc/sha-256-part-1-of-4 is new in this release, so let's
merge this fix down before the final.

Thanks.

> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  Documentation/git.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 9d6769e95a..12890841c4 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -493,7 +493,7 @@ double-quotes and respecting backslash escapes. E.g., the value
>  	details. This variable has lower precedence than other path
>  	variables such as GIT_INDEX_FILE, GIT_OBJECT_DIRECTORY...
>  
> -`GIT_DEFAULT_HASH_ALGORITHM`::
> +`GIT_DEFAULT_HASH`::
>  	If this variable is set, the default hash algorithm for new
>  	repositories will be set to this value. This value is currently
>  	ignored when cloning; the setting of the remote repository
