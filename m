Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B6BA20954
	for <e@80x24.org>; Sun,  3 Dec 2017 06:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbdLCGgp (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 01:36:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57962 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751790AbdLCGgo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 01:36:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E548B6C4B;
        Sun,  3 Dec 2017 01:36:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2DYUwnNIJih/AG567rx1gxK29mg=; b=Xjt8ti
        6kRs0Rst1Xj4DrK1IAPknwB17JxPw0UUJUyP3mli+l0+WegPLpWEXH5WSqxoAURq
        MVnnsECu9YxZnwbCXj1+MtLWfNGBJ3HRJaEIr25+kNh7TDGIqIdPjePQ/sLR5bzS
        2h9OhzHH1xC0s/3MKcyDcuec0ARI/YurefyN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v5bvnBO1DAzjKh5VOy370kbOACQjGZ2K
        JN9y7ByB3xQx2FnDrhxkb5FAka48EI7D5K3I9Xp1eCF1ca9dS+xQ+QZ8nwrBlEog
        6i+igckNU08IThd1SYq0Hgv2G/mpFVZRSznQqox/kc4CAuujClAOthWVPyD/kM4q
        uy5Ovpb4f/0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74F4CB6C4A;
        Sun,  3 Dec 2017 01:36:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C206AB6C46;
        Sun,  3 Dec 2017 01:36:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Timothee Albertin <timothee.albertin@gmail.com>
Cc:     git@vger.kernel.org,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Subject: Re: [PATCH] doc: clarify triangular workflow
References: <1512034932-14499-1-git-send-email-timothee.albertin@etu.univ-lyon1.fr>
Date:   Sat, 02 Dec 2017 22:36:41 -0800
In-Reply-To: <1512034932-14499-1-git-send-email-timothee.albertin@etu.univ-lyon1.fr>
        (Timothee Albertin's message of "Thu, 30 Nov 2017 10:42:12 +0100")
Message-ID: <xmqqwp24iah2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 535AF29A-D7F4-11E7-AAAD-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Timothee Albertin <timothee.albertin@gmail.com> writes:

> diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
> index 02569d0..21f6dc8 100644
> --- a/Documentation/gitworkflows.txt
> +++ b/Documentation/gitworkflows.txt
> @@ -407,8 +407,8 @@ follows.
>  `git pull <url> <branch>`
>  =====================================
>  
> -Occasionally, the maintainer may get merge conflicts when he tries to
> -pull changes from downstream.  In this case, he can ask downstream to
> +Occasionally, the maintainers may get merge conflicts when they try to
> +pull changes from downstream.  In this case, they can ask downstream to
>  do the merge and resolve the conflicts themselves (perhaps they will
>  know better how to resolve them).  It is one of the rare cases where
>  downstream 'should' merge from upstream.

The document starts with

    This document attempts to write down and motivate some of the
    workflow elements used for `git.git` itself.  Many ideas apply
    in general, though the full workflow is rarely required for
    smaller projects with fewer people involved.

and makes me wonder (note: I am not involved in writing any of the
existing text in this document) how much material foreign to the
actual workflow used for `git.git` should go in here.  Having
multiple maintainers at the same time is not a workflow element that
we have ever used, for example, so I am not sure about the change in
the above paragraph.

> +TRIANGULAR WORKFLOW
> +-------------------

I really hate to say this.  Before I made comment on the last round
that tried to add this section, I didn't read the original closely
enough.  

The thing is, it does already cover the triangular workflow in the
"Merge workflow" section (you may need to already know what you are
reading to realize that fact, though).  The text in the existing
"Merge workflow" section where requestor pushes to somewhere for the
maintainer to pull from may not be immediately obvious, and it may
be worthwhile to improve it, but I find it highly misleading to add
an entirely new section as if it is describing yet another separate
workflow that is different from anything that is already described
in the document.  It is not.

A replacement of the entire section (but I'd recommend keeping the
"Merge workflow" title, which contrasts well with the other "Patch
workflow" that follows), or a separate document that is referred to
with "see that other one for a lengthier description" by the
existing "Merge workflow" section, or somewhere in between, might be
a more acceptable organization, though.
