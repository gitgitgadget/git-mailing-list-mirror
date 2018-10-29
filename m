Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FE391F453
	for <e@80x24.org>; Mon, 29 Oct 2018 04:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeJ2Ngl (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 09:36:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38524 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbeJ2Ngl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 09:36:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2-v6so1064433wmh.3
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 21:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V58QcH7TtpVQpnCTzXjMYl80Dmh2dQALjlVymosaVGY=;
        b=eOXUfRQzQYO0pKa/Hd57+3z3fYI8DBcORlyX/taLmP+BLkBMN65tDDoxtt/6bViSVq
         zDn+cR5I1YNBULQk45TsSNNCe6tLx63ns46PWzdIe7R+yMRYwKAGmgajNYRnCZaODtzw
         3+t7c9WNS423Jr/2b+AMtbL/kJX1e7YXBP7yrncGy3dZbvoDAOPY6NV0xPQP6oJWfXrz
         wqO3+lwv3zOsqwJMLimk+S/SSYD8gWuOkkrL0rB7VfNWM2ihvOPEV5uvYltBIRhMz4KP
         cQTF7+Nw+TL6ups0fliLI+sXNB7cISkPOGv0PspdJ9iBfJE/jhNK+xiHQ1w5xyyzXB+C
         waCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V58QcH7TtpVQpnCTzXjMYl80Dmh2dQALjlVymosaVGY=;
        b=aWZYgeX7XsL92LmQ+n/ro0cbCSaU018KRO72arYlMj9Pv8hei+bnmBb6Zb9uf0Ja6p
         DhToGDlVT3zihiWtGheq0YDnZtAWwkLj0KeaFlekwzbm33nXal1Byo2JpfBicf6qI1Yb
         735shO6QWclhmtBGG4ldipGdnoxmY0OTlfedE7mR/hkZH47j6E2S73dckxE13mDfKd9w
         QWo6Ulyjpj8v5xjynle4b4ARE2rnxKhL/rRoy37vdWGZP6DwakN5nnskpAbFuCXwVZ00
         enHHSAtwzz0za+r/RyLteHOZm2rIWq3cVmY5OWJKh+WfdOlqobR7BA+WYpBIKCxEYqIP
         x8Kw==
X-Gm-Message-State: AGRZ1gK9Z33YA1eMCXpJubIHg268ZzMfCp60q65rlhtxoY7m3XaAkwE2
        ifBNNsyfDl14XZ7ALLC0lnutkbKOflg=
X-Google-Smtp-Source: AJdET5eLwW3aVlYPsjKdP/whW176g7eg4d+MdbfOtMyBfU/7jPVMnKg3V5oDjq3sMYOkTgiQEvD7NA==
X-Received: by 2002:a1c:8c46:: with SMTP id o67-v6mr12308435wmd.35.1540788578048;
        Sun, 28 Oct 2018 21:49:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c18-v6sm12605431wrr.74.2018.10.28.21.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 21:49:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] pretty: Add %(trailer:X) to display single trailer
References: <20181028125025.30952-1-anders@0x63.nu>
Date:   Mon, 29 Oct 2018 13:49:34 +0900
In-Reply-To: <20181028125025.30952-1-anders@0x63.nu> (Anders Waldenborg's
        message of "Sun, 28 Oct 2018 13:50:25 +0100")
Message-ID: <xmqqo9bd5pcx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> This new format placeholder allows displaying only a single
> trailer. The formatting done is similar to what is done for
> --decorate/%d using parentheses and comma separation.
>
> It's intended use is for things like ticket references in trailers.
>
> So with a commit with a message like:
>
>  > Some good commit
>  >
>  > Ticket: XYZ-123
>
> running:
>
>  $ git log --pretty="%H %s% (trailer:Ticket)"
>
> will give:
>
>  > 123456789a Some good commit (Ticket: XYZ-123)

Sounds useful, but a few questions off the top of my head are:

 - How would this work together with existing %(trailers:...)?

 - Can't this be made to a new option, in addition to existing
   'only' and 'unfold', to existing %(trailer:...)?  If not, what
   are the missing pieces that we need to add in order to make that
   possible?

The latter is especially true as from the surface, it smell like
that the whole reason why this patch introduces a new placeholder
with confusingly simliar name is because the patch did not bother to
think of a way to make it fit there as an enhancement of it.

> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 6109ef09aa..a46d0c0717 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -211,6 +211,10 @@ endif::git-rev-list[]
>    If the `unfold` option is given, behave as if interpret-trailer's
>    `--unfold` option was given.  E.g., `%(trailers:only,unfold)` to do
>    both.
> +- %(trailer:<t>): display the specified trailer in parentheses (like
> +  %d does for refnames). If there are multiple entries of that trailer
> +  they are shown comma separated. If there are no matching trailers
> +  nothing is displayed.


As this list is sorted roughly alphabetically for short ones, I
think it is better to keep that order for the longer ones that begin
with "%(".  This should be instead inserted before the description
for the existing "%(trailers[:options])".

Assuming that we want this %(trailer) separate from %(trailers),
that is, of course.

> diff --git a/pretty.c b/pretty.c
> index 8ca29e9281..61ae34ced4 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1324,6 +1324,22 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  		}
>  	}
>  
> +	if (skip_prefix(placeholder, "(trailer:", &arg)) {
> +		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
> +		opts.no_divider = 1;
> +		opts.only_trailers = 1;
> +		opts.unfold = 1;

This makes me suspect that it would be very nice if this is
implemented as a new "option" to the existing "%(trailers[:option])"
thing.  It does mostly identical thing as the existing code.

> +		const char *end = strchr(arg, ')');

Avoid decl-after-statement.

> +		if (!end)
> +			return 0;
> +
> +		opts.filter_trailer = xstrndup(arg, end - arg);
> +		format_trailers_from_commit(sb, msg + c->subject_off, &opts);
> +		free(opts.filter_trailer);
> +		return end - placeholder + 1;
> +	}
> +
>  	return 0;	/* unknown placeholder */
>  }
>  
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 978a8a66ff..e929f820e7 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -598,6 +598,46 @@ test_expect_success ':only and :unfold work together' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'pretty format %(trailer:foo) shows that trailer' '
> +	git log --no-walk --pretty="%(trailer:Acked-By)" >actual &&
> +	{
> +		echo "(Acked-By: A U Thor <author@example.com>)"
> +	} >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '%(trailer:nonexistant) becomes empty' '
> +	git log --no-walk --pretty="x%(trailer:Nacked-By)x" >actual &&
> +	{
> +		echo "xx"
> +	} >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '% (trailer:nonexistant) with space becomes empty' '
> +	git log --no-walk --pretty="x% (trailer:Nacked-By)x" >actual &&
> +	{
> +		echo "xx"
> +	} >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '% (trailer:foo) with space adds space before' '
> +	git log --no-walk --pretty="x% (trailer:Acked-By)x" >actual &&
> +	{
> +		echo "x (Acked-By: A U Thor <author@example.com>)x"
> +	} >expect &&
> +	test_cmp expect actual
> +'

These are both good positive-negative pairs of tests.

> +test_expect_success '%(trailer:foo) with multiple lines becomes comma separated and unwrapped' '
> +	git log --no-walk --pretty="%(trailer:Signed-Off-By)" >actual &&
> +	{
> +		echo "(Signed-Off-By: A U Thor <author@example.com>, A U Thor <author@example.com>)"
> +	} >expect &&
> +	test_cmp expect actual
> +'

This also tells me that it is a bad design to add this as a separate
new feature that takes the trailer key as an end-user suppied value.
There is no way to extend this to other needs, such as "do similar
thing as %(trailer:foo) does by default, but do not unwrap; give two
or more 'Signed-off-by:' separately)".

I wonder why something like %(trailers:comma,token=foo) were not
considered.  %(trailers:only,token=foo,token=bar) might even be a good
way to grab only Foo: and Bar: trailers in the order they appear in
the original commit, filtering out all the other trailers and non-trailer
text in the log message.

> diff --git a/trailer.c b/trailer.c
> index 0796f326b3..d337bca8dd 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1138,6 +1138,7 @@ static void format_trailer_info(struct strbuf *out,
>  		return;
>  	}
>  
> +	int printed_first = 0;

decl-afer-stmt.

>  	for (i = 0; i < info->trailer_nr; i++) {
>  		char *trailer = info->trailers[i];
>  		ssize_t separator_pos = find_separator(trailer, separators);
> @@ -1150,7 +1151,19 @@ static void format_trailer_info(struct strbuf *out,
>  			if (opts->unfold)
>  				unfold_value(&val);
>  
> -			strbuf_addf(out, "%s: %s\n", tok.buf, val.buf);
> +			if (opts->filter_trailer) {
> +				if (!strcasecmp (tok.buf, opts->filter_trailer)) {
> +					if (!printed_first) {
> +						strbuf_addf(out, "(%s: ", opts->filter_trailer);
> +						printed_first = 1;
> +					} else {
> +						strbuf_addstr(out, ", ");
> +					}
> +					strbuf_addstr(out, val.buf);
> +				}
> +			} else {
> +				strbuf_addf(out, "%s: %s\n", tok.buf, val.buf);
> +			}
>  			strbuf_release(&tok);
>  			strbuf_release(&val);
>  
> @@ -1158,7 +1171,8 @@ static void format_trailer_info(struct strbuf *out,
>  			strbuf_addstr(out, trailer);
>  		}
>  	}
> -
> +	if (printed_first)
> +		strbuf_addstr(out, ")");
>  }
>  
>  void format_trailers_from_commit(struct strbuf *out, const char *msg,
> diff --git a/trailer.h b/trailer.h
> index b997739649..852c79d449 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -72,6 +72,7 @@ struct process_trailer_options {
>  	int only_input;
>  	int unfold;
>  	int no_divider;
> +	char *filter_trailer;
>  };
>  
>  #define PROCESS_TRAILER_OPTIONS_INIT {0}
