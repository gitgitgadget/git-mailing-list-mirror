Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0E3C20954
	for <e@80x24.org>; Wed, 22 Nov 2017 15:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbdKVPyg (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 10:54:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64353 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751259AbdKVPyf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 10:54:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9018C32AF;
        Wed, 22 Nov 2017 10:54:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eZgrGtvu9G62hWoGfpvUAj5B9Pc=; b=vKS1cy
        HGP/hynjjRRVws0evzZPMeq4rNW4kBq6WNzxivybwZxzk1IN0LfIqD8jKAaekTVi
        gk3uEj3SeXM0UrFNm9ZHpghUus9MuRN787kOkAZzohwmFwiQWrqc4W5o4cSZ88SD
        M7OhHUwVim0TG36hsRL/SsdgO5I8MJJeQ2ZU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nBVIqGakPwSNequZ9FbIL6O8vLGGoDg0
        Wvw6zng589fGzQuKnueBPeGrblQyMslCSElwn/QjSgQANExxaPSEQTo1cIf2qUDi
        vEbaCDnSjRxH2xVIyGLOnq2NRBXEtLeq0VwMwagwuoxoBoHRfiS4/W4JeXaRXr68
        PBA6IwlrU4Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1AFFC32AE;
        Wed, 22 Nov 2017 10:54:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60A39C32AC;
        Wed, 22 Nov 2017 10:54:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Steffen Prohaska <prohaska@zib.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] doc: Mention info/attributes in gitrepository-layout
References: <20171122085814.8563-1-prohaska@zib.de>
Date:   Thu, 23 Nov 2017 00:54:32 +0900
In-Reply-To: <20171122085814.8563-1-prohaska@zib.de> (Steffen Prohaska's
        message of "Wed, 22 Nov 2017 09:58:14 +0100")
Message-ID: <xmqqmv3es407.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F69F030-CF9D-11E7-BD74-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steffen Prohaska <prohaska@zib.de> writes:

> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  Documentation/gitrepository-layout.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
> index adf9554ad2..c60bcad44a 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -208,6 +208,10 @@ info/exclude::
>  	'git clean' look at it but the core Git commands do not look
>  	at it.  See also: linkgit:gitignore[5].
>  
> +info/attributes::
> +	Defines which attributes to assign to a path, similar to per-directory
> +	`.gitattributes` files.   See also: linkgit:gitattributes[5].
> +

Makes sense, but don't we also want to mention a bit more than
"similar to"?  The entries in this file is treated as higher
priority than the in-tree .gitattributes file, which allows us to
use it to locally override the choice made by the project.

>  info/sparse-checkout::
>  	This file stores sparse checkout patterns.
>  	See also: linkgit:git-read-tree[1].
