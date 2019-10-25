Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55C2C1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 05:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393713AbfJYFvv (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 01:51:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60246 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393574AbfJYFvv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 01:51:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36AFF29C6F;
        Fri, 25 Oct 2019 01:51:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GCjWG1Xzve1XJtwksoi3LqnhpyY=; b=sShOy2
        DeN6rspQTtZs5AYUUHrKnLO3XQUd5w+syD16By/49DCqRzErVwBWA7hKcavO1NaT
        GTTF9xnkdwfnercvPLm7hgg4q7eQGjKw4nHrepgBa2VTxz74xvzV97L4EN/lC4a2
        rDG4nzZcwxvhV/Re9ggWlVvyRdNkpK19m5bl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BQH2Y0DV8b9sc8ga1yOWHZ9iUOoIB3ur
        K6heCWKEB8lgWwRDrZROAEC45jLkoQ+z8HlayIZGs0MBNvGtB2sMKgRNm9HBG5UY
        D/JjQ9b20GMAltQPrT7bm4NkfbIYXJgxu0AwuK1TQOmB3TrIZYLnH08OtDGCLVrh
        2sJTMxepPqo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C9B529C6E;
        Fri, 25 Oct 2019 01:51:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9077429C6D;
        Fri, 25 Oct 2019 01:51:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 3/3] pretty: add "%aL"|"%al|%cL|%cl" option to output local-part of email addresses
References: <20191024233617.18716-1-prarit@redhat.com>
        <20191024233617.18716-4-prarit@redhat.com>
Date:   Fri, 25 Oct 2019 14:51:45 +0900
In-Reply-To: <20191024233617.18716-4-prarit@redhat.com> (Prarit Bhargava's
        message of "Thu, 24 Oct 2019 19:36:17 -0400")
Message-ID: <xmqqftjhcqz2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87B68316-F6EB-11E9-A041-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prarit Bhargava <prarit@redhat.com> writes:

> Subject: Re: [PATCH v3 3/3] pretty: add "%aL"|"%al|%cL|%cl" option to output local-part of 

That's somewhat strange paring of quotation marks (the same appears
later in the proposed log message).

I'd retitle to

    pretty: add "%aL" etc. to show local-part of email addresses

and rewrite this

> Displaying only the author's username saves a lot of columns on the screen.
> For example displaying "prarit" instead of "prarit@redhat.com" saves 11
> columns.
>
> Add a "%aL"|"%al|%cL|%cl" option that output the local-part of an email
> address.

like so:

    Existing 'e/E' (as in "%ae" and "%aE") placeholders would show
    the author's address as "prarit@redhat.com", which would waste
    columns to show the same domain-part for all contributors when
    used in redhat-only project.  Introduce 'l/L' placeholders that
    strip '@' and domain part from the e-mail address.

if I were explaining this patch.

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index b87e2e83e6d0..13bac67c446f 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -163,6 +163,10 @@ The placeholders are:
>  '%ae':: author email
>  '%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
>  	or linkgit:git-blame[1])
> +'%al':: author local-part (the portion of the email address preceding the '@'
> +	symbol)

In a document like RFC2822 that is clearly about e-mail, the phrase
"local-part" alone would be sufficient to convey what we are talking
about, but not here.  Let's say "email local-part" to qualify.  That
would also allow us to shorten the explanation in the parentheses,
perhaps like so?

    author email local-part (the part before the '@' sign)

> diff --git a/pretty.c b/pretty.c
> index b32f0369531c..93eb6e837071 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -696,7 +696,7 @@ static size_t format_person_part(struct strbuf *sb, char part,
>  	mail = s.mail_begin;
>  	maillen = s.mail_end - s.mail_begin;
>  
> -	if (part == 'N' || part == 'E') /* mailmap lookup */
> +	if (part == 'N' || part == 'E' || part == 'L') /* mailmap lookup */
>  		mailmap_name(&mail, &maillen, &name, &namelen);
>  	if (part == 'n' || part == 'N') {	/* name */
>  		strbuf_add(sb, name, namelen);
> @@ -706,6 +706,13 @@ static size_t format_person_part(struct strbuf *sb, char part,
>  		strbuf_add(sb, mail, maillen);
>  		return placeholder_len;
>  	}
> +	if (part == 'l' || part == 'L') {	/* local-part */
> +		const char *at = memchr(mail, '@', maillen);
> +		if (at)
> +			maillen = at - mail;
> +		strbuf_add(sb, mail, maillen);
> +		return placeholder_len;
> +	}

Nicely done.

Overall, looking quite better.

Thanks.

