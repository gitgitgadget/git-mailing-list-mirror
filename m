Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44951F407
	for <e@80x24.org>; Fri, 15 Dec 2017 19:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755977AbdLOTZm (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 14:25:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50179 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755751AbdLOTZl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 14:25:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C718B5687;
        Fri, 15 Dec 2017 14:25:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BnFDJHKXni0RGXaMaqj6jhMMYTA=; b=m3rbiS
        iqI8KRIwColWOkh+SnvVxmkNi/Rc+Ig89t3RigaQYH23sqodgPoeEFUeNT/lRHbi
        mMEnU/ei+qJBjCIoTI8xkmOsgZbSSeXrqSw7LZLO9b8HzX0NJoWGNwv9J+LV0831
        PlvCTEf2tWYrmQ3+IFpBDyjQ0HhUJftzFKcFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S4XxZmX2LhYWOih98VQVsuWYBuIH5P4p
        Y7/LZ/kZbt/g5D+MaCPKLN6eknO5HxnDNckhBj+xRwvkH0j1VQANog982Zx1UuFn
        05ywCeb3ngIvsKrSDCw1A9B+8u0aTReM5ilbr+oL/BqHytGIB1sxw7qYCcFY7ofB
        gq9DTb4WoOU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5380BB5686;
        Fri, 15 Dec 2017 14:25:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6DFCB5684;
        Fri, 15 Dec 2017 14:25:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Knittl-Frank <knittl89@googlemail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git describe" documentation and behavior mismatch
References: <CACx-yZ10GiDT=dDeF1EUtM_K4nGd414SDfxLRqGWyXt0ub02Gg@mail.gmail.com>
        <CACx-yZ1dJuUj5mD6WE8yqZCPMK8q-yaJ0GKUSppZ7uDkqvJ5UA@mail.gmail.com>
        <xmqqefocjrp2.fsf@gitster.mtv.corp.google.com>
        <CACx-yZ1DGz2z6qqAX=pzeExT689y0sON+wVDaocdWk75a5SOxA@mail.gmail.com>
        <CACx-yZ3FxqFvXgM-V0stODcyAdCoO83s=WwyZ2OLiJON6qqvkA@mail.gmail.com>
Date:   Fri, 15 Dec 2017 11:25:39 -0800
In-Reply-To: <CACx-yZ3FxqFvXgM-V0stODcyAdCoO83s=WwyZ2OLiJON6qqvkA@mail.gmail.com>
        (Daniel Knittl-Frank's message of "Mon, 11 Dec 2017 19:37:53 +0100")
Message-ID: <xmqqwp1npzd8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCB0347A-E1CD-11E7-8316-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Knittl-Frank <knittl89@googlemail.com> writes:

> Forget the above patch. I should compile my code after refactoring ...
>
> Here is the fixed version.
>
> -- >8 --
>
> From 8203bd0ad5baab7024ebff597c9f35a0250d09ff Mon Sep 17 00:00:00 2001
> From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
> Date: Mon, 11 Dec 2017 19:24:54 +0100
> Subject: [PATCH] Prepend "tags/" when describing tags with embedded name
>
> Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
> ---
>  builtin/describe.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

I think the code makes sense, but it won't be understandable by
those who do not know what you discussed in the original thread.

A proper commit log message, with a new test or two in t6120, would
be an appropriate way to fix that.

Care to follow through, along the lines in
Documentation/SubmittingPatches?

Thanks.

> diff --git a/builtin/describe.c b/builtin/describe.c
> index e14e162ef6..9da6d85ea3 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -271,10 +271,13 @@ static void display_name(struct commit_name *n)
>          n->name_checked = 1;
>      }
>
> -    if (n->tag)
> +    if (n->tag) {
> +        if (all)
> +            printf("tags/");
>          printf("%s", n->tag->tag);
> -    else
> +    } else {
>          printf("%s", n->path);
> +    }
>  }
>
>  static void show_suffix(int depth, const struct object_id *oid)
> -- 
> 2.15.GIT
