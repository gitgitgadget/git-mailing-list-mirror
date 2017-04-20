Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 926A0207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 22:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033498AbdDTWqW (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 18:46:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51001 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1032435AbdDTWqU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 18:46:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AABF7D68B;
        Thu, 20 Apr 2017 18:46:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=icb4AHtLSHoopZSz1pXTXDF5sfM=; b=vWyiGh
        lZ8KrucFzCiK4q0HG6avsV9K/VrvVxbUrTxSYKTaMrSuiLaJ+Dh3A+vO5ySk/Jku
        J/aMo6ctfrXS0XPplWxnCr+uVBfQDZ+XUYZSlmEEAgCqpzg5ej8bIE0Uoh0l12k3
        aSjafp99+y4RIC4eoE3wFb0mpWnqsLdAuIyOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cn9c0TDfNiu3kXkL6S25c3vh97ZCq6a1
        6zLiaNo6mPVWOLGrSs/MbPKuVUmv9XTa/Y+NGiCGi/g7b/cK8mlgnIgLgncQCO5Q
        xghbYjltiEGztLikGxQQoVJvZGrqKVeg+KyQ3aX2M4sN4z+D70dpC0BKGvVgnmdJ
        42iWoR8p+N8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 438D87D68A;
        Thu, 20 Apr 2017 18:46:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEC7E7D686;
        Thu, 20 Apr 2017 18:46:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
        <20170420095921.GA23873@ash>
Date:   Thu, 20 Apr 2017 15:46:17 -0700
In-Reply-To: <20170420095921.GA23873@ash> (Duy Nguyen's message of "Thu, 20
        Apr 2017 16:59:21 +0700")
Message-ID: <xmqqshl28zpi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B1B5D82-261B-11E7-99C2-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Looking good. I would add some comment, lest ';' feel lonely. But it's
> really personal taste.

... which matches mine.   Thanks for the update (which I'll squash in).

>
> -- 8< --
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 5ebdcce793..bc75676bf3 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -310,7 +310,7 @@ static int add_worktree(const char *path, const char *refname,
>  	strbuf_reset(&sb);
>  	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
>  	if (!ret && opts->keep_locked)
> -		;
> +		;	      /* --lock wants to keep "locked" file */
>  	else
>  		unlink_or_warn(sb.buf);
>  	argv_array_clear(&child_env);
> -- 8< --
