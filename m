Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D02FC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 21:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbiD0VEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiD0VEd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 17:04:33 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D532F01C
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 14:01:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E829194942;
        Wed, 27 Apr 2022 17:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MOHbiwUU8kpVYxuKci35R5xEaXAGdmI2yFbais
        D1wNQ=; b=OM3VnO1YLk+t8DBpFXynRDq++0HttnfPoSvSGt0c8OcTIe2xoNCQQN
        S3bs/dzSvMLb1VLIzarQ1FmdqFkmxf/M8J4knNV9XjiAEBGhUv+kydLHddyimxmV
        q+4oj2JTduWVhBdAFlUFKrf5qQcdHgOVF+Gf96xk9lgHPnsdIX+CY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 76C11194941;
        Wed, 27 Apr 2022 17:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 004E919493F;
        Wed, 27 Apr 2022 17:01:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yaroslav Halchenko <debian@onerussian.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: replace - use consistent 'replace
 reference'
References: <20220427195450.366703-1-debian@onerussian.com>
Date:   Wed, 27 Apr 2022 14:01:13 -0700
In-Reply-To: <20220427195450.366703-1-debian@onerussian.com> (Yaroslav
        Halchenko's message of "Wed, 27 Apr 2022 15:54:50 -0400")
Message-ID: <xmqq8rrqkzqe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CFD1738-C66D-11EC-B39F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Halchenko <debian@onerussian.com> writes:

> As a new user to 'git replace' I found it a little uncertain about what
> "'replace' reference" documentation was talking since there was only
> "replacement" mentioned in the command summary.  Decided to make it more
> consistent as 'replace reference' after checking that in a few spots there is a
> use of multi word entries within <>.
>
> Signed-off-by: Yaroslav Halchenko <debian@onerussian.com>
> ---
>  Documentation/git-replace.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
> index f271d758c3..71f98edfe3 100644
> --- a/Documentation/git-replace.txt
> +++ b/Documentation/git-replace.txt
> @@ -8,7 +8,7 @@ git-replace - Create, list, delete refs to replace objects
>  SYNOPSIS
>  --------
>  [verse]
> -'git replace' [-f] <object> <replacement>
> +'git replace' [-f] <object> <replace reference>

If we must use a multi-word, perhaps come up with a dashed form to
make it still a single token, i.e.

	'git replace' [-f] <object> <replace-reference>

otherwise it forces people to first think "ah, command reads from a
file (whose name can be 'replace'), and then..." and then backtrack
because the "reference>" part would not be syntactically correct.

You earlier mentioned that you copied the pattern from elsewhere.
These places may have to be updated, too.


>  'git replace' [-f] --edit <object>
>  'git replace' [-f] --graft <commit> [<parent>...]
>  'git replace' [-f] --convert-graft-file
> @@ -17,16 +17,16 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Adds a 'replace' reference in `refs/replace/` namespace.
> +Adds a 'replace reference' in `refs/replace/` namespace.

And this part becomes 'replace-reference', too.

If we must invent and use such a new multi-word jargon, it probably
is a good idea to define it in Documentation/glossary-content.txt

Other than that, looking good.

Thanks.
