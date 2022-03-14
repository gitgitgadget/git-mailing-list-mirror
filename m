Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEFBC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 05:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiCNFmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 01:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiCNFmD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 01:42:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ABE3E0EC
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 22:40:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1D51121CB7;
        Mon, 14 Mar 2022 01:40:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JFs5o/N+EiKnt8GkUjpx0MK++q8oU5dQZF4UoL
        Y2TzQ=; b=V/MQSG/TqznAK9jTsxLwszPLxeu7mPmX71OKEdxQ4OHff2AiDV1SAv
        oIiWTDzyExjIss/yFPlS6KGe0wSIVAoJ0GuXPY6VuYGmmUu6dScEXK7rt5QsVlte
        Ft/foQ5iOIFQ053tofxONTMMW4Zdw+PovAGN1ISnRBSbD07Tb8C1M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D99BD121CB6;
        Mon, 14 Mar 2022 01:40:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2EB7E121CB5;
        Mon, 14 Mar 2022 01:40:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] attr.h: remove duplicate struct definition
References: <20220314002327.243915-1-gitter.spiros@gmail.com>
Date:   Mon, 14 Mar 2022 05:40:51 +0000
In-Reply-To: <20220314002327.243915-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Mon, 14 Mar 2022 00:23:27 +0000")
Message-ID: <xmqqh781t7ks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F7498C2-A359-11EC-BB0A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> Subject: Re: [PATCH 6/6] attr.h: remove duplicate struct definition

I do not see other 5 from 1/6 thru 5/6 on the list.

If this is a leftover bit follow-up to the 5-patch series whose
cover letter was <20220313195536.224075-1-gitter.spiros@gmail.com>
we often see such a message

 - with subject numbered as [PATCH 6/5]
 - as follow-up to the same cover letter.

The patch text looks good, and we can see from the output of

 $ git grep '^struct .*;' \*.h |
   sort | uniq -c | sort -n | grep -v '^ *1 '

that this is the only duplicated opaque struct declaration in the
header files.

For now, I'd assume that is the case and queue it on the same topic
branch as the other five.  Thanks.

> struct index_state is declared more than once.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  attr.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/attr.h b/attr.h
> index 3732505eda..3fb40cced0 100644
> --- a/attr.h
> +++ b/attr.h
> @@ -121,7 +121,6 @@ struct git_attr;
>  /* opaque structures used internally for attribute collection */
>  struct all_attrs_item;
>  struct attr_stack;
> -struct index_state;
>  
>  /*
>   * Given a string, return the gitattribute object that
