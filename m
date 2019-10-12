Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185101F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 02:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfJLCgi (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 22:36:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56425 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfJLCgi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 22:36:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C48168293C;
        Fri, 11 Oct 2019 22:36:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oTVSdp6+Zl9q3GoHbuv9Y9xrmlU=; b=j43KX0
        qGRlV9SXaaJMU+e7Vjdg6/6cnHEdD7KKoRVObwlO1ZbTkPzVjpQqWETzEbAw8xVP
        ZSW5UAe2CDV3GzLkOrKKT+kXg2w8JyYry8PUD8KfUw+d8vw2pORvpCakE89nHl71
        8a9jItvpR7l9DU39buH3/1005ZdCO3ayXm6fI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QbQAdgBB+QxNgCwaRz9dtP2yxPSfG4wT
        AIh4Kw9O7ik93ycMaibi5BQh+zDgAS6qEeXd8SXvEEyC6zPnHjiY9eEB38er7DBv
        Eraf2FhJgqo7V4gBrHNvsURk7zuIKWsWkSUzvcP7MtFotCqA9YOGsAH3WTpoEOVx
        rb8Vj7ZoXgQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC3F48293B;
        Fri, 11 Oct 2019 22:36:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E687782939;
        Fri, 11 Oct 2019 22:36:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 3/3] format-patch: teach --cover-from-description option
References: <cover.1566285151.git.liu.denton@gmail.com>
        <cover.1570821015.git.liu.denton@gmail.com>
        <9b8c3dcb539054ba483fc34c6ff509e4ca73517c.1570821015.git.liu.denton@gmail.com>
Date:   Sat, 12 Oct 2019 11:36:25 +0900
In-Reply-To: <9b8c3dcb539054ba483fc34c6ff509e4ca73517c.1570821015.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 11 Oct 2019 12:12:56 -0700")
Message-ID: <xmqqd0f2elli.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 177B7428-EC99-11E9-8235-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +format.coverFromDescription::
> +	The default mode for format-patch to determine which parts of
> +	the cover letter will be populated using the branch's
> +	description. See the `--cover-from-description` option in
> +	linkgit:git-format-patch[1].
> +
>  format.signature::
>  	The default for format-patch is to output a signature containing
>  	the Git version number. Use this variable to change that default.
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 0ac56f4b70..86114e4c22 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -19,6 +19,7 @@ SYNOPSIS
>  		   [--start-number <n>] [--numbered-files]
>  		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
>  		   [--ignore-if-in-upstream]
> +		   [--cover-from-description=<mode>]
>  		   [--rfc] [--subject-prefix=<subject prefix>]
>  		   [(--reroll-count|-v) <n>]
>  		   [--to=<email>] [--cc=<email>]
> @@ -171,6 +172,26 @@ will want to ensure that threading is disabled for `git send-email`.
>  	patches being generated, and any patch that matches is
>  	ignored.
>  
> +--cover-from-description=<mode>::
> +	Controls which parts of the cover letter will be automatically
> +	populated using the branch's description.
> ++
> +If `<mode>` is `message` or `default`, the cover letter subject will be
> +populated with placeholder text. The body of the cover letter will be
> +populated with the branch's description.

I understand that this is what we do now, so those who want to live
in the past can set the configuration variable to 'message'.

> +If `<mode>` is `subject`, the beginning of the branch description (up to
> +the first blank line) will populate the cover letter subject. The
> +remainder of the description will populate the body of the cover
> +letter.

s/the beginning of .*blank line)/the first paragraph of the branch description/
may be shorter, but the above is OK, too.

When description is prepared appropriately, this mode would fill
both subject and body, which sounds sensible.

> +If `<mode>` is `auto`, if the beginning of the branch description (up to
> +the first line) is greater than 100 characters then the mode will be
> +`message`, otherwise `subject` will be used.

I understand that this is a more clever and safer variant of
'subject'.  Do you want to say 100 characters or 100 bytes?

> +If `<mode>` is `none`, both the cover letter subject and body will be
> +populated with placeholder text.

OK, this is done for completeness?  I wonder who finds it useful to
set it to 'none' *AND* set the branch description.  Not a rhetorical
question that suggests removing this choice, but purely soliciting
opinions from others.

It is unclear (other than the mode word being 'default' for one of
the choices) what the new default mode of operation is after the
patch is applied among the four presented mode.  "This is the
default when no configuration nor command line option specifies the
desired mode" or something may want to be added to one of these
paragraphs.

> @@ -1061,13 +1076,16 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  			      struct commit *origin,
>  			      int nr, struct commit **list,
>  			      const char *branch_name,
> +			      enum cover_from_description cover_from_description_mode,
>  			      int quiet)
>  {
>  	const char *committer;
> -	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
> -	const char *msg;
> +	const char *subject = "*** SUBJECT HERE ***";
> +	const char *body = "*** BLURB HERE ***";
>  	struct shortlog log;
>  	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf description_sb = STRBUF_INIT;
> +	struct strbuf subject_sb = STRBUF_INIT;
>  	int i;
>  	const char *encoding = "UTF-8";
>  	int need_8bit_cte = 0;
> @@ -1095,17 +1113,34 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	if (!branch_name)
>  		branch_name = find_branch_name(rev);
>  
> -	msg = body;
> +	if (branch_name && *branch_name)
> +		read_branch_desc(&description_sb, branch_name);

It may not matter in practice but strictly speaking there is no need
to read the description if we know that the mode is NONE.  Removing
the support for the NONE mode may be an easier fix than adding "&&
mode != NONE" to the if () condition guarding this call---I dunno.

> +	if (cover_from_description_mode != COVER_FROM_NONE && description_sb.len) {
> +		if (cover_from_description_mode == COVER_FROM_SUBJECT ||
> +				cover_from_description_mode == COVER_FROM_AUTO)
> +			body = format_subject(&subject_sb, description_sb.buf, " ");
> +
> +		if (cover_from_description_mode == COVER_FROM_MESSAGE ||
> +				(cover_from_description_mode == COVER_FROM_AUTO &&
> +				 subject_sb.len > COVER_FROM_AUTO_MAX_SUBJECT_LEN))
> +			body = description_sb.buf;
> +		else
> +			subject = subject_sb.buf;
> +	}

I wonder if it make the end result cleaner and easier to follow to
replace all of the above with a single line:

	cover_from_desc(&subject, &body, branch_name, desc_mode);

in this caller, and move the logic (and a handful of strbuf used as
its implementation detail) into the helper function, including the
choice of the default "*** SOMETHING HERE ***", etc., and make the
helper *always* return allocated piece of memory in subject and body
so that this caller can unconditionally free them.

Thanks.
