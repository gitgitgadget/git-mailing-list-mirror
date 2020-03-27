Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDF4C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 17:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE05206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 17:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CbRjnx8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgC0Rqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:46:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56185 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgC0Rqo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 13:46:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 244CBB6AF0;
        Fri, 27 Mar 2020 13:46:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HvlqSizAwfbwppsS98hUlWhB4qg=; b=CbRjnx
        8gSd9menbEwqOgXr57yI6bT+gJRy0cEoU804ma6ijuIjBuflY8c5SE6SoSD91lqP
        SOKm+6P4FiB6iPNis/A7Ihx65CyQ6vYq1sSCYXfyfUug26FJL7nW4LcauhOwIoNM
        f+dO+FK7U/RhumVz4U+d7SYpcINUAPh98Ex0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ochXVBBr5nBfhaewOJTMlQ19jFJ6Fyye
        qPKsmfbbYG+aC7i94riG/sWBxHcBFkcakzwNC8+Z+cNEx6Vv99RQQkWkMgpv0JFf
        OSfdEQZXIyptsMde3JNcTYlS8L1oBQmQ3KGwagISrFNVmSVVFY/nHhmmtYi2fbKM
        fxw0UdoLNHA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D9D0B6AEF;
        Fri, 27 Mar 2020 13:46:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5E8E0B6AED;
        Fri, 27 Mar 2020 13:46:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 9/9] fixup! t5512: stop losing git exit code in here-docs
References: <cover.1585209554.git.liu.denton@gmail.com>
        <38924d9c4994b5bad93cbbd2659666f6b452a89f.1585269773.git.liu.denton@gmail.com>
Date:   Fri, 27 Mar 2020 10:46:37 -0700
In-Reply-To: <38924d9c4994b5bad93cbbd2659666f6b452a89f.1585269773.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 26 Mar 2020 20:43:45 -0400")
Message-ID: <xmqqimipherm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E96BB5F0-7052-11EA-9188-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Subject: Re: [PATCH v2 9/9] fixup! t5512: stop losing git exit code in here-docs

Forgot to do the final "rebase -i --autosquash"?

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t5512-ls-remote.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index 8928d1f62d..e98c3a0174 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -224,7 +224,7 @@ test_expect_success 'ls-remote --symref' '
>  	oid=$(git rev-parse HEAD) &&
>  	echo "$oid	refs/remotes/origin/HEAD" >>expect &&
>  	generate_references \
> -	refs/remotes/origin/master \
> +		refs/remotes/origin/master \
>  		refs/tags/mark \
>  		refs/tags/mark1.1 \
>  		refs/tags/mark1.10 \
