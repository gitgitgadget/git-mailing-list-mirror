Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D52C388F9
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 22:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C5E223BF
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 22:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="beDjS/80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgKPWVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:21:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54504 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgKPWVY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 17:21:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A8B25F5EB5;
        Mon, 16 Nov 2020 17:21:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sjWqSy3LS31+HO36DRboA55nEXU=; b=beDjS/
        80SNX3fvgqyhMgHfQ0aeRZ3yWDfM3lxw04HAQ9kO7OvhubVFhV2+P8GsnARcaJk8
        4vNimLor6/nQlUfN26t/nw3Jff9J2x+p5489AerGR4b8iBDQcW8sfWAj8EmShQJp
        c3YtOge53reIgfBQw2pvxSf25b+WAB7vyWfWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=viF0j/WzILxDf8jwzkDarbHVZh8Wmwty
        1Os62Sl9z0+AUV+nDA7gVCZd2nrJkGeF/GteCvcptBwFoccLy7spMPLu8fdsprRT
        CQHg/gTTgXNMbm+1AZsuIJeKOpYNVg84pBMgMRQjn9DQ3Ycjz1HooTEJI6fVXPek
        udi6o297sTE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B24EF5EB4;
        Mon, 16 Nov 2020 17:21:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D3C63F5EB2;
        Mon, 16 Nov 2020 17:21:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Javier Spagnoletti via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Javier Spagnoletti <phansys@gmail.com>
Subject: Re: [PATCH] userdiff: php: Improved tests catching "abstract" and
 "final" functions
References: <pull.915.git.git.1605388687554.gitgitgadget@gmail.com>
Date:   Mon, 16 Nov 2020 14:21:16 -0800
In-Reply-To: <pull.915.git.git.1605388687554.gitgitgadget@gmail.com> (Javier
        Spagnoletti via GitGitGadget's message of "Sat, 14 Nov 2020 21:18:07
        +0000")
Message-ID: <xmqqtutp6izn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C069656-285A-11EB-8C71-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Javier Spagnoletti via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Javier Spagnoletti <phansys@gmail.com>
> Subject: [PATCH] userdiff: php: Improved tests catching "abstract" and "final" functions

I'd suggest using this instead:

Subject: [PATCH] userdiff: improve "abstract" and "final" function tests for php

I am not familiar enough with PHP to know if s/function/method/ is
more appropriate for certain, but I suspect that would be the case.

> Since the original tests cases were using other detectable keywords (like
> "public" or "protected"), they are able to pass even if the keywords
> intended to be covered are not present.

I think you meant that other keywords that start functions were on
the same line and that hides if "abstract" alone is recognised
without these other keywords?

The patch changes "abstract public function" to "abstract function";
the assumption is that the presence of "public" alone is enough for
such a line to be recognised to start a function.  

But is that assumption tested elsewhere?

    ... goes and looks ...

    $ ls t/t4018/php-*
    t/t4018/php-abstract-class  t/t4018/php-function   t/t4018/php-trait
    t/t4018/php-class	    t/t4018/php-interface
    t/t4018/php-final-class     t/t4018/php-method

    $ git grep -e public -e protected t/t4018/php-*
    t/t4018/php-interface:    public function foo($ChangeMe);
    t/t4018/php-method:    public static function RIGHT()
    t/t4018/php-trait:    public function foo($ChangeMe)

You bring up "protected" but I do not see it mentioned anywhere in
your patch or in existing tests, by the way.

Taking all of the above together, perhaps

	A few tests try to see if lines with "abstract public
	function RIGHT()" and "final public function RIGHT()" on
	them are recognised as starting a method, but the presense
	of the keyword "public" is enough to get them recognised;
	ensure that these lines are still recognised as the
	beginning of a function without the "public" keyword.

	Note that t4018/php-method already tests a line with 'public
	static function RIGHT()' on it to start a function, so we
	are not losing test coverage for "public" keyword with this
	change

would make it clearer?

>
> Signed-off-by: Javier Spagnoletti <phansys@gmail.com>
> ---
>     userdiff: php: Improved test cases used to catch "abstract" and "final"
>     functions
>     
>     Since the original tests cases were using other detectable keywords
>     (like "public" or "protected"), they are able to pass even if the
>     keywords intended to be covered are not present. In the case of the test
>     for "abstract" keyword, the method's body was removed in the fixture,
>     since PHP doesn't allow an abstract method to have a body.
>     
>     Signed-off-by: Javier Spagnoletti phansys@gmail.com [phansys@gmail.com]
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-915%2Fphansys%2Fpr_864-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-915/phansys/pr_864-v1
> Pull-Request: https://github.com/git/git/pull/915
>
>  t/t4018/php-abstract-method | 5 ++++-
>  t/t4018/php-final-method    | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/t/t4018/php-abstract-method b/t/t4018/php-abstract-method
> index ce215df75a..14d77e6c15 100644
> --- a/t/t4018/php-abstract-method
> +++ b/t/t4018/php-abstract-method
> @@ -1,7 +1,10 @@
>  abstract class Klass
>  {
> -    abstract public function RIGHT(): ?string
> +    abstract function RIGHT(): ?string
>      {
> +        // PHP doesn't allow abstract methods to have a body,
> +        // but this is here just for diff ckeck purposes.
> +
>          return 'ChangeMe';
>      }
>  }
> diff --git a/t/t4018/php-final-method b/t/t4018/php-final-method
> index 537fb8ad9a..f7dd2dec17 100644
> --- a/t/t4018/php-final-method
> +++ b/t/t4018/php-final-method
> @@ -1,6 +1,6 @@
>  class Klass
>  {
> -    final public function RIGHT(): string
> +    final function RIGHT(): string
>      {
>          return 'ChangeMe';
>      }
>
> base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
