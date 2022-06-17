Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909DCC43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 22:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiFQWnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 18:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbiFQWnu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 18:43:50 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084FF3BA7F
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 15:43:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A950133DF6;
        Fri, 17 Jun 2022 18:43:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HHY2/tNePMINgcLBmfQUzsTQ58oeffxk6qmMJC
        l9tqo=; b=HQgDvYKTCjRXelac5dOwTF5BlJ833E6jjobSpY5zkbSBOnTb+4gTL0
        BvhG1CKR3nesgQC3bZRygFde+3nRTR8UK23e8sQbbcmQXOV77kiAFqvtTORgNq2s
        FSek3GEBmNKNQI1L07jT1l/fgsa8S0HhRZwYyhMtq/813Qk16ZB5E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 018BC133DF5;
        Fri, 17 Jun 2022 18:43:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 664D8133DF4;
        Fri, 17 Jun 2022 18:43:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Cleber Rosa via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH] setup: fix function name
References: <pull.1255.git.1654782920256.gitgitgadget@gmail.com>
Date:   Fri, 17 Jun 2022 15:43:45 -0700
In-Reply-To: <pull.1255.git.1654782920256.gitgitgadget@gmail.com> (Cleber Rosa
        via GitGitGadget's message of "Thu, 09 Jun 2022 13:55:20 +0000")
Message-ID: <xmqqzgianc66.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F29690F2-EE8E-11EC-9139-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Cleber Rosa via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Cleber Rosa <crosa@redhat.com>
> Subject: Re: [PATCH] setup: fix function name

I'd add "in a BUG() message" at the end.

> diff --git a/setup.c b/setup.c
> index faf5095e44d..b5a537258d2 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1402,7 +1402,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  		 * find a repository.
>  		 */
>  	default:
> -		BUG("unhandled setup_git_directory_1() result");
> +		BUG("unhandled setup_git_directory_gently_1() result");
>  	}

Did you actually hit this BUG() and was sent to a wild goose chase
because of this typo?  Just checking, because BUG() that triggers
is a more serious issue itself.

Thanks.
