Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4448020A10
	for <e@80x24.org>; Tue,  7 Nov 2017 00:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933520AbdKGAzf (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 19:55:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52291 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933910AbdKGAwl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 19:52:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A9059AB43;
        Mon,  6 Nov 2017 19:52:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jbFXUrak8qC6O3oao3wnRGu8gv0=; b=HwA29c
        ++e5aYTTzMmbnQllgmMdcy8+14sojEnshHGbehb6QwQdkJjLV0xM0ywWApzJb5bL
        5wJsWLey4fet02d9I4erLMtwLE0r4lcr22kzn0S3jNqqxWe79qAeLYPpmqM1xFDa
        hOgghkgV0uuqlTQ/5m1OFi9uoHknLhJyAGWEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FBhck0+Ls9PlEV9kazG2v0sZtEMtlpoq
        5jekUcZd+UgSKEhJtlHd6BqHXLK2xcGypsoT1VltR0Z68io3dVxMgOPg6swrb7av
        IRPAQeIqpzkEbQ649n9C7jVokDNC6CADv4uxUvhgvmnqvH1YrMopl2xbu8x7QoEx
        mLHO3c4hqQc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 626C69AB41;
        Mon,  6 Nov 2017 19:52:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D64119AB40;
        Mon,  6 Nov 2017 19:52:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3] checkout: describe_detached_head: remove 3dots after committish
References: <20171105162730.31405-1-bedhanger@gmx.de>
Date:   Tue, 07 Nov 2017 09:52:37 +0900
In-Reply-To: <20171105162730.31405-1-bedhanger@gmx.de> (Ann T. Ropea's message
        of "Sun, 5 Nov 2017 17:27:28 +0100")
Message-ID: <xmqq375qj4fe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3DAEA76-C355-11E7-B6ED-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ann T Ropea <bedhanger@gmx.de> writes:

> Lest we confuse the meticulous observer, we ought to retire the 3dots in
> the circumstances described above.

Yes, as I said in my response to 3/3, I think it is a good goal to
avoid n-dots used as a "here we truncated something longer" sign,
which was a very old convention that was invented without knowing
that we'd later come up with a syntax that would conflict with it.

For this particular output, I wonder if it is even better to follow
our own advice, though.  Documentation/SubmittingPatches says:

    If you want to reference a previous commit in the history of a stable
    branch, use the format "abbreviated sha1 (subject, date)",
    with the subject enclosed in a pair of double-quotes, like this:

        Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
        noticed that ...

I dunno.

> Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
> ---
>  builtin/checkout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index fc4f8fd2ea29..59cc52e55855 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -404,7 +404,7 @@ static void describe_detached_head(const char *msg, struct commit *commit)
>  	struct strbuf sb = STRBUF_INIT;
>  	if (!parse_commit(commit))
>  		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
> -	fprintf(stderr, "%s %s... %s\n", msg,
> +	fprintf(stderr, "%s %s %s\n", msg,
>  		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
>  	strbuf_release(&sb);
>  }
