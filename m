Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D633C001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 22:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGMWYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 18:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjGMWYj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 18:24:39 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9713B2D7D
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 15:24:17 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C0A71ABF28;
        Thu, 13 Jul 2023 18:20:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CWD/3omtp9cglCTh2mpe3c0ncjFbQbhQlOTpf3
        PTPtk=; b=LD+G73tz9xCBJK27jISzNIu44jFyZ2SP1lHmiIg1gluKhA7I3K25ix
        uabxZWQ3sYF/Kn6AQ1EARXLnsrwHqydnqUND+ZXPFDrt2niVaELUiFsy0gYTxGd5
        x93jiEynwGjc/ItpWUY5veZt6BBvIuk5ozcu3/Bi9+IuUrWbwCNgY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 636EE1ABF27;
        Thu, 13 Jul 2023 18:20:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CFB381ABF26;
        Thu, 13 Jul 2023 18:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: Re: [PATCH] i18n: mark more bundle.c strings for translation
References: <pull.1550.git.1689285683013.gitgitgadget@gmail.com>
Date:   Thu, 13 Jul 2023 15:20:22 -0700
In-Reply-To: <pull.1550.git.1689285683013.gitgitgadget@gmail.com> (D. Ben
        Knoble via GitGitGadget's message of "Thu, 13 Jul 2023 22:01:22
        +0000")
Message-ID: <xmqqh6q7lahl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 761B63B0-21CB-11EE-8959-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
>
> These two messages were introduced in 8ba221e245 (bundle: output hash
> information in 'verify', 2022-03-22) and 105c6f14ad (bundle: parse
> filter capability, 2022-03-09) but never for translation.

Thanks for catching and reporting.

> diff --git a/bundle.c b/bundle.c
> index 8d5936c4212..a9744da255c 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -271,10 +271,10 @@ int verify_bundle(struct repository *r,
>  			list_refs(r, 0, NULL);
>  		}
>  
> -		printf_ln("The bundle uses this hash algorithm: %s",
> +		printf_ln(_("The bundle uses this hash algorithm: %s"),
>  			  header->hash_algo->name);
>  		if (header->filter.choice)
> -			printf_ln("The bundle uses this filter: %s",
> +			printf_ln(_("The bundle uses this filter: %s"),
>  				  list_objects_filter_spec(&header->filter));

Looking good.  Will queue.

Thanks.
