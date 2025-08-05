Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B92273D99
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399826; cv=none; b=cWWds7T4Ai5rnpwEjCL7bHunZyQ4SkTMmHU4KUo3mwletzYZ45DV+qENuIKhizjVCcELkaKB4vYK3M949LfhqdUGNqpRj/c2DE/6d5Eb+/IdZBMgW2Rhtcgsx1wB1kwGIjN8LhuyaBYw4CqqiK+uDECWSljVmnfOX1xi/jEXXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399826; c=relaxed/simple;
	bh=/VCB3MK951C7UqWZjNC3FiAyO1WYKV8PpDfhfr6IrHk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=aqD0UzGfW7EKM9DBCdjxXGsChxo1iurDSWRFmTKm2oIJGbBrrk6pNzf+nLZ9r78D4xN3kv13BlMhP//qT3ZM5AypAtEvrqJYAs/zKkXMTHMf/rkN5jqXsh36aJczByeD4MurgelN3dCte2HBYLEYZZSIfnhL7COI1z8HRO86UBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPzv0W2S; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPzv0W2S"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4589968e001so35718905e9.0
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 06:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754399822; x=1755004622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQzffXcZpWWOlz38swRPpF7ylhjMcPCmczUEE28pH6o=;
        b=CPzv0W2SCAqZtFqD2gFH4gH7OELXVSezCBMfvJzlATJ9+ylOI2KbMdgIjRab//XLST
         I1q8FzFJVbTEPokgwY3VacMPk8VtzrcqyrX0UveFq7rWAJqDPZsUPTmQaz5lwmAQMjQx
         8/GewjjRbHmplvHPZPjUVwZuNWAaPVvPABdvoLxLKk7BBT66HTZ0Av+CRZeSmjDlYX+u
         2cw5QXtJgBwhjlXSMKir9tDq9AXGhymTj9Z3LvYxw9j3bHEOOjSpQgxH2PEpbPib7fYC
         HQZvLz06kBuglMAWaeyKNnln5pCTJAhPcQlRs2m10fnyQuOyOj0gE8+oJ5Bf4CGH6ocj
         E+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399822; x=1755004622;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQzffXcZpWWOlz38swRPpF7ylhjMcPCmczUEE28pH6o=;
        b=MMErYwOogditd9jeg5qFv8/HOHux5tj6dMlZbtjVn233nPVV6q+jvjtUj9pD5CSwXT
         zbNM8h76sQCaEGHrivWLtfwXUisrCaiw5i6Cc5tPTXxlpP1grAC2HeDidwUQspLhtZwu
         0WkrdU8soGAhW+bVDXaJF7ajrIw+Pmexq4kp3vOgbC/fZBy9dVP/DAp+tMTYLyHureRT
         TvvFr6y+i5ypwW7NcjfBSjP+TM1L+rOhwa9si9AirnX8um0ceXgVC97Pv5PA2uS7oqOR
         a/Y5Npi3C3EwjYXjEih23D0/Am3mdiXu6z9nM6vaeyTXAvv6F8zRySMFgujf113w3kL6
         tFVA==
X-Forwarded-Encrypted: i=1; AJvYcCVtUqRhn0SoGPvzUS1SPkvlvf/RJqYkweIR7bJR7qBv8iVGziTiW0K8kwN8PV/Snw9ehvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY1bCFxvi/9Lpj2Z4Wdh8BgkThNcNJgULHxYl0xRskKB0Jw8Lc
	jpVBhcSd9rqGgYSPKw+055HlW3UV8B2HcQKDWwceuhnOIjesWsNHBkq7
X-Gm-Gg: ASbGnctjaw0NqI3UqjSzOX6XRos6H/rIVmD+ZVj5khpCaTTH4nyZxGz/i4XuayHUGDZ
	GG/AkE5onZZM/Lb6INeT5tf+ioRz1MsAVNQvLfgls1EOcytWIL9mMOnZ7p0LY4bi/TC4I4dprZ8
	GhXSwmOFsqyS3ulR+79sLdou71vj905O/6/0yvnhUpCrcA8zjZiB10p0fGEab6gM6v/qi8+WsnH
	4YAUC/edugR6lIg4L+tdERp6AKnbglLIYaIgsGjNW2XRthXpZ2FTQ5l5niRvSbut2eXab2YnWuQ
	UyfTj/im6VhAaH9HwUCShAOs8ZMoxx1cgGND+6HkBL/e5usXje2RMq/tmoktfZ3hMo6AD+2PIyQ
	ca9uzxXUlMaqaysdTVJ84GZHsf2ppEPvN5HkhMC0776TdV0bxU8UdVn9HCLnSi3oXfsan9rN8AA
	M6D7+sMtwdJieNlO6JLg==
X-Google-Smtp-Source: AGHT+IHD1JVIz8TDrM/q5F0imuii2XMr82a7RruX147145VF/UVVMt7r70NGNKHRHX+0jiqAE4parw==
X-Received: by 2002:a5d:64e8:0:b0:3b7:942c:5450 with SMTP id ffacd0b85a97d-3b8d9469035mr9891701f8f.9.1754399821186;
        Tue, 05 Aug 2025 06:17:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:1c5a:64b9:7dcf:820c? ([2a0a:ef40:7a5:4701:1c5a:64b9:7dcf:820c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c46ee84sm18798696f8f.57.2025.08.05.06.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:17:00 -0700 (PDT)
Message-ID: <d4c9f082-52be-48d9-b817-fcb8a72e1bd7@gmail.com>
Date: Tue, 5 Aug 2025 14:17:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 1/2] trailer: append trailers in-process and drop the
 fork to `interpret-trailers`
Reply-To: phillip.wood@dunelm.org.uk
To: Li Chen <me@linux.beauty>, phillipwood <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20250803150059.402017-1-me@linux.beauty>
 <20250803150059.402017-2-me@linux.beauty>
Content-Language: en-US
In-Reply-To: <20250803150059.402017-2-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Li

On 03/08/2025 16:00, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> All trailer insertion now funnels through trailer_process():
> 
> * builtin/interpret-trailers.c is reduced to file I/O + a single call.
> * amend_file_with_trailers() shares the same path; the old
>    amend_strbuf_with_trailers() helper is dropped.
> * New helpers parse_trailer_args()/free_new_trailer_list() convert
>    --trailer=... strings to new_trailer_item lists.
> 
> Behaviour is unchanged; the full test-suite still passes, and the
> fork/exec is gone.

Normally commit messages should be written in prose rather than a bullet 
list and the message should explain the reason for the change.

This patch has much less code duplication than the last iteration which 
is most welcome. Whenever you are moving and refactoring code you should 
split the move into its own commit followed by the refactoring. That 
makes it much easier to review as the reviewer can clearly see the 
refactoring rather than having to manually compare the added code in one 
file to the deleted code in another.

> @@ -84,6 +83,7 @@ static int parse_opt_parse(const struct option *opt, const char *arg,
>   			   int unset)
>   {
>   	struct process_trailer_options *v = opt->value;
> +

Let's not clutter this patch with unrelated changes.

>   	v->only_trailers = 1;
>   	v->only_input = 1;
>   	v->unfold = 1;
> @@ -92,37 +92,6 @@ static int parse_opt_parse(const struct option *opt, const char *arg,
>   	return 0;
>   }
>   
> -static FILE *create_in_place_tempfile(const char *file)
> -{
> [...]
> -}

We don't need to create a temporary file anymore so this can be deleted 
- good.

> -static void interpret_trailers(const struct process_trailer_options *opts,
> -			       struct list_head *new_trailer_head,
> -			       const char *file)
> -{
> -	LIST_HEAD(head);
> -	struct strbuf sb = STRBUF_INIT;
> -	struct strbuf trailer_block_sb = STRBUF_INIT;
> -	struct trailer_block *trailer_block;
> -	FILE *outfile = stdout;
> -
> -	trailer_config_init();
> -
> -	read_input_file(&sb, file);
> -
> -	if (opts->in_place)
> -		outfile = create_in_place_tempfile(file);
> -
> -	trailer_block = parse_trailers(opts, sb.buf, &head);
> -
> -	/* Print the lines before the trailer block */
> -	if (!opts->only_trailers)
> -		fwrite(sb.buf, 1, trailer_block_start(trailer_block), outfile);
> -
> -	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
> -		fprintf(outfile, "\n");
> -
> -
> -	if (!opts->only_input) {
> -		LIST_HEAD(config_head);
> -		LIST_HEAD(arg_head);
> -		parse_trailers_from_config(&config_head);
> -		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
> -		list_splice(&config_head, &arg_head);
> -		process_trailers_lists(&head, &arg_head);
> -	}
> -
> -	/* Print trailer block. */
> -	format_trailers(opts, &head, &trailer_block_sb);
> -	free_trailers(&head);
> -	fwrite(trailer_block_sb.buf, 1, trailer_block_sb.len, outfile);
> -	strbuf_release(&trailer_block_sb);
> -
> -	/* Print the lines after the trailer block as is. */
> -	if (!opts->only_trailers)
> -		fwrite(sb.buf + trailer_block_end(trailer_block), 1,
> -		       sb.len - trailer_block_end(trailer_block), outfile);
> -	trailer_block_release(trailer_block);
> -
> -	if (opts->in_place)
> -		if (rename_tempfile(&trailers_tempfile, file))
> -			die_errno(_("could not rename temporary file to %s"), file);
> -
> -	strbuf_release(&sb);
> -}

This code is moved to trailer.c which is good but it is heavily 
refactored at the same time which makes it hard to review. Completely 
removing this function leads to some duplication in 
cmd_interpret_trailers() which could be avoided by making 
interpret_trailers() a wrapper around process_trailers()

>   int cmd_interpret_trailers(int argc,
>   			   const char **argv,
>   			   const char *prefix,
> @@ -231,14 +145,37 @@ int cmd_interpret_trailers(int argc,
>   			git_interpret_trailers_usage,
>   			options);
>   
> +	trailer_config_init();
> +
>   	if (argc) {
>   		int i;
> -		for (i = 0; i < argc; i++)
> -			interpret_trailers(&opts, &trailers, argv[i]);
> +		for (i = 0; i < argc; i++) {
> +			struct strbuf in_buf = STRBUF_INIT;
> +			struct strbuf out_buf = STRBUF_INIT;
> +
> +			read_input_file(&in_buf, argv[i]);
> +			if (trailer_process(&opts, in_buf.buf, &trailers, &out_buf) < 0)
> +				die(_("failed to process trailers for %s"), argv[i]);
> +			if (opts.in_place)
> +				write_file_buf(argv[i], out_buf.buf, out_buf.len);
> +			else
> +				fwrite(out_buf.buf, 1, out_buf.len, stdout);
> +			strbuf_release(&in_buf);
> +			strbuf_release(&out_buf);
> +		}
>   	} else {
> +		struct strbuf in_buf = STRBUF_INIT;
> +		struct strbuf out_buf = STRBUF_INIT;
> +
>   		if (opts.in_place)
>   			die(_("no input file given for in-place editing"));
> -		interpret_trailers(&opts, &trailers, NULL);
> +
> +		read_input_file(&in_buf, NULL);
> +		if (trailer_process(&opts, in_buf.buf, &trailers, &out_buf) < 0)
> +			die(_("failed to process trailers"));
> +		fwrite(out_buf.buf, 1, out_buf.len, stdout);
> +		strbuf_release(&in_buf);
> +		strbuf_release(&out_buf);
>   	}

There is quite a bit of duplication here that could be avoided if you 
modified interpret_trailers() to call trailer_process() rather than 
deleting it entirely.

>   	new_trailers_clear(&trailers);
> diff --git a/trailer.c b/trailer.c
> index 310cf582dc..03814443c3 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1224,14 +1224,121 @@ void trailer_iterator_release(struct trailer_iterator *iter)
>   	strbuf_release(&iter->key);
>   }
>   
> -int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
> +static int amend_strbuf_with_trailers(struct strbuf *buf,
> +				   const struct strvec *trailer_args)

Function argument declarations should be aligned

>   {
> -	struct child_process run_trailer = CHILD_PROCESS_INIT;
> -
> -	run_trailer.git_cmd = 1;
> -	strvec_pushl(&run_trailer.args, "interpret-trailers",
> -		     "--in-place", "--no-divider",
> -		     path, NULL);
> -	strvec_pushv(&run_trailer.args, trailer_args->v);
> -	return run_command(&run_trailer);
> +	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
> +	LIST_HEAD(new_trailer_head);
> +	struct strbuf out = STRBUF_INIT;
> +	size_t i;
> +
> +	opts.no_divider = 1;
> +
> +	for (i = 0; i < trailer_args->nr; i++) {
> +		const char *arg = trailer_args->v[i];
> +		const char *text;
> +		struct new_trailer_item *item;

There should be a blank line after the variable declarations at the 
start of each block of code.

> +		if (!skip_prefix(arg, "--trailer=", &text))

Why do we need this? It would be much cleaner if we required the caller 
to pass a list of trailers without any optional prefix.

> +			text = arg;
> +		if (!*text)
> +			continue;
> +		item = xcalloc(1, sizeof(*item));
> +		INIT_LIST_HEAD(&item->list);
> +		item->text = text;
> +		list_add_tail(&item->list, &new_trailer_head);
> +	}
> +	if (trailer_process(&opts, buf->buf, &new_trailer_head, &out) < 0)
> +		die("failed to process trailers");

As this is library code lets return an error here rather than dying.

> +	strbuf_swap(buf, &out);
> +	strbuf_release(&out);
> +	while (!list_empty(&new_trailer_head)) {
> +		struct new_trailer_item *item =
> +			list_first_entry(&new_trailer_head, struct new_trailer_item, list);
> +		list_del(&item->list);
> +		free(item);
> +	}
> +	return 0;
>   }
> +
> +int trailer_process(const struct process_trailer_options *opts,
> +				   const char *msg,
> +				   struct list_head *new_trailer_head,
> +				   struct strbuf *out)

Argument alignment again

> +{
> +		struct trailer_block *blk;

This is trailer_block in the original but has been re-ordered with 
respect to the other variable declarations making the patch harder to 
review.

> +		LIST_HEAD(orig_head);

This is head in the original but moved relative to the other variable 
declarations

> +		LIST_HEAD(config_head);
> +		LIST_HEAD(ar1g_head);

These two have been moved from inside the if (!opts->only_input) below. 
They are only referenced there so do not need to be declared here. 
Moving them makes this patch harder to review.

> +		struct strbuf trailers_sb = STRBUF_INIT;

This is from the original but moved relative to the other variable 
declarations.

> +		int had_trailer_before;

This is new - lets see how it is used. We've just started using bool for 
boolean variables in the last few weeks so this could be a bool now.

 From here to

> +		blk = parse_trailers(opts, msg, &orig_head);
> +		had_trailer_before = !list_empty(&orig_head);
> +		if (!opts->only_input) {
> +			parse_trailers_from_config(&config_head);
> +			parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
> +			list_splice(&config_head, &arg_head);
> +			process_trailers_lists(&orig_head, &arg_head);
> +		}
> +		format_trailers(opts, &orig_head, &trailers_sb);

here is copied from the original minus the code that copied the commit 
message to the output file. Rather than deleting the code that copied 
the commit message we could have replaced the calls to fwrite() and 
fprintf() with strbuf_add() and strbuf_addf() which would make it 
obvious that the behavior is not changed. The original then frees 
orig_head but that is done later here.

> +		if (!opts->only_trailers && !opts->only_input && !opts->unfold &&
> +			!opts->trim_empty && list_empty(&orig_head) &&
> +			(list_empty(new_trailer_head) || opts->only_input)) {

I'm not sure what is happening here. By this point the original has 
copied the original commit message and is ready to append the new 
trailers. Instead the new version seems to have completely refactored 
the logic for adding the new trailers making it harder to see if the 
behavior has changed.

> +			size_t split = trailer_block_start(blk); /* end-of-log-msg */
> +			if (!blank_line_before_trailer_block(blk)) {
> +				strbuf_add(out, msg, split);
> +				strbuf_addch(out, '\n');
> +				strbuf_addstr(out, msg + split);

This copies the original message but adds a newline before the trailer 
block if it is missing.

> +			} else
> +				strbuf_addstr(out, msg);

This just copies the whole message.

> +			strbuf_rel2ease(&trailers_sb);
> +			trailer_block_release(blk);


> +			return 0;

We return a copy of the original message with no new trailers added. We 
do not free orig_head, arg_head or config_head. I'm still confused why 
we need to special case this.


> +		}
> +		if (opts->only_trailers) {
> +			strbuf_addbuf(out, &trailers_sb);

This flips the logic in the original to handle opts->only_trailers 
separately making it harder to review.

> +		} else if (had_trailer_before) {
> +			strbuf_add(out, msg, trailer_block_start(blk));
> +			if (!blank_line_before_trailer_block(blk))
> +				strbuf_addch(out, '\n');
> +			strbuf_addbuf(out, &trailers_sb);
> +			strbuf_add(out, msg + trailer_block_end(blk),
> +						strlen(msg) - trailer_block_end(blk));

This handles the case where we're replacing the headers in the original 
message

> +		}
> +		else {

Style - this should be "} else {"

> +			size_t cpos = trailer_block_start(blk);
> +			strbuf_add(out, msg, cpos);
> +			if (cpos == 0)                     /* empty body → just one \n */
> +				strbuf_addch(out, '\n');
> +			else if (!blank_line_before_trailer_block(blk))
> +				strbuf_addch(out, '\n');   /* body without trailing blank */
> +
> +			strbuf_addbuf(out, &trailers_sb);
> +			strbuf_add(out, msg + cpos, strlen(msg) - cpos);
> +	   }

I'm confused why we need a separate case for when the original did not 
have any trailers - was the original code broken? If it was we should 
separate out the bug fix from the refactoring. If not what's the point 
of this change?

> +		strbuf_release(&trailers_sb);
> +		free_trailers(&orig_head);
> +		trailer_block_release(blk);
> +		return 0;
> +}
> +
> +int amend_file_with_trailers(const char *path,
> +							 const struct strvec *trailer_args)

Alignment again

> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	if (!trailer_args || !trailer_args->nr)
> +		return 0;
> +
> +	if (strbuf_read_file(&buf, path, 0) < 0)
> +		return error_errno("could not read '%s'", path);
> +
> +	if (amend_strbuf_with_trailers(&buf, trailer_args))
> +		die("failed to append trailers");

Why return an error() above but die() here? This is library code so lets 
return an error.

> +
> +	/* `write_file_buf()` aborts on error internally */
> +	write_file_buf(path, buf.buf, buf.len);

Dying here is a change in behavior which callers might not be expecting. 
The original code always returned a error because it forked a 
sub-process to do the trailer processing. Ideally, in a separate commit, 
we'd update any existing callers that have the message in an strbuf so 
they don't have to write it to a file just to add some trailers to it.

> +	strbuf_release(&buf);
> +	return 0;
> + }

As I said above reusing the existing code as you have done here is a 
much better approach. However it would be much easier to review if the 
code movement was separated from the refactoring. I'm also struggling to 
see the benefit of a lot of the refactoring - I was expecting the 
conversion to use an strubf would essentially look like fwrite() being 
replaced with strbuf_add() and fprintf() being replaced with 
strbuf_addf() etc. rather than reworking the logic.

Thanks


Phillip

> diff --git a/trailer.h b/trailer.h
> index 4740549586..01f711fb13 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -196,10 +196,22 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
>   void trailer_iterator_release(struct trailer_iterator *iter);
>   
>   /*
> - * Augment a file to add trailers to it by running git-interpret-trailers.
> - * This calls run_command() and its return value is the same (i.e. 0 for
> - * success, various non-zero for other errors). See run-command.h.
> + * Augment a file to add trailers to it (similar to 'git interpret-trailers').
> + * Returns 0 on success or a non-zero error code on failure.
>    */
>   int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
>   
> +/*
> + * Process trailer lines for a commit message in-memory.
> + * @opts: trailer processing options (e.g. from parse-options)
> + * @msg: the input message string
> + * @new_trailer_head: list of new trailers to add (struct new_trailer_item)
> + * @out: strbuf to store the resulting message (must be initialized)
> + *
> + * Returns 0 on success, <0 on error.
> + */
> +int trailer_process(const struct process_trailer_options *opts,
> +			const char *msg,
> +			struct list_head *new_trailer_head,
> +			struct strbuf *out);
>   #endif /* TRAILER_H */

