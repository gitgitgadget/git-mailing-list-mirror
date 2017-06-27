Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFC8820401
	for <e@80x24.org>; Tue, 27 Jun 2017 19:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbdF0TA0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 15:00:26 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35910 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbdF0TAY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 15:00:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id z6so5847695pfk.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IkAzDLXkhA5CUzPE0jKTFJ9SUFX2pcXe5BNWl58+qfs=;
        b=eWVvFYYGQ4KfwSsrUwOn1t14h3ZYqkmDUROGGnfo469aJTuSdNI/yAWN9U/1Mr8cpI
         QOTFeV4aKr7fB+/2avwxiaBXkLhKz6EErRTD0nz3sg8hwk4JlKCnp6I3qYfCehrEdL+F
         rRjFxLqCF25ndv0nnuPmNctSJwiGil0ixiqL/jhAg6owrhWl+0zxksaab+unDxnC8ztX
         w/d8eCFxDMa//UpwqJwzqTd+kHgiO/xmuVM4OAvRe2UF1rM/2tIQWGJ9VAkw56xJ1iBv
         hVCITdxT76NyFZwJiGnMrXTq0wc0pE8KV/tPjlm3mZGSjueq8pvSXwDvChc1+Ax8u+yo
         BjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IkAzDLXkhA5CUzPE0jKTFJ9SUFX2pcXe5BNWl58+qfs=;
        b=udymrlZ63GkoldAP0fPuMd1PM9rXLzGdP8x49Gof1jDI/HDDOwQSsRs6FogM4+Ianc
         oAzQyTdrUgemurmCBZuC4PKM+cGISkD4KM7OFeQxE+HBdwW3/NdVUk1WH6QSL8F2yL7P
         vVJf+PpXr/8c0r+zJFGK3ehjhRrRtyPFwSIdD0xWDiz7W40tkNSQ7qNQHPjDkA7WmazY
         xdb0dLgaply78RrASs9EXftqDiLiLWsykwKEPJduKNryrRYGp95esCct4Vd60zrXdMQe
         dc8f6HWom3+eqFqulSf1sAbAI2jBz4t0D0kln58ij+4Ru5zQ5MNuRyqTGjKmWogwsT71
         NaVw==
X-Gm-Message-State: AKS2vOxPXLSXtgjbYrrUdZODqTfU19octhEbv9Cws2TkHbLzIRKyvQIj
        VgVXEdM2iKckKQ==
X-Received: by 10.98.204.194 with SMTP id j63mr6623809pfk.137.1498590017911;
        Tue, 27 Jun 2017 12:00:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id 73sm11239pgf.41.2017.06.27.12.00.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 12:00:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v7 6/6] convert: add "status=delayed" to filter process protocol
References: <20170627121027.99209-1-larsxschneider@gmail.com>
        <20170627121027.99209-7-larsxschneider@gmail.com>
Date:   Tue, 27 Jun 2017 12:00:15 -0700
In-Reply-To: <20170627121027.99209-7-larsxschneider@gmail.com> (Lars
        Schneider's message of "Tue, 27 Jun 2017 14:10:27 +0200")
Message-ID: <xmqqbmp91cjk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> @@ -533,7 +534,8 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
>  	if (err)
>  		goto done;
>  
> -	err = packet_writel(process->in, "capability=clean", "capability=smudge", NULL);
> +	err = packet_writel(process->in,
> +		"capability=clean", "capability=smudge", "capability=delay", NULL);
>  
>  	for (;;) {
>  		cap_buf = packet_read_line(process->out, NULL);
> @@ -549,6 +551,8 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
>  			entry->supported_capabilities |= CAP_CLEAN;
>  		} else if (!strcmp(cap_name, "smudge")) {
>  			entry->supported_capabilities |= CAP_SMUDGE;
> +		} else if (!strcmp(cap_name, "delay")) {
> +			entry->supported_capabilities |= CAP_DELAY;
>  		} else {
>  			warning(
>  				"external filter '%s' requested unsupported filter capability '%s'",

I thought you said something about attempting to make this more
table-driven; did the attempt produce a better result?  Just being
curious.

> @@ -590,9 +594,11 @@ static void handle_filter_error(const struct strbuf *filter_status,
>  
>  static int apply_multi_file_filter(const char *path, const char *src, size_t len,
>  				   int fd, struct strbuf *dst, const char *cmd,
> -				   const unsigned int wanted_capability)
> +				   const unsigned int wanted_capability,
> +				   struct delayed_checkout *dco)
>  {
>  	int err;
> +	int can_delay = 0;
>  	struct cmd2process *entry;
>  	struct child_process *process;
>  	struct strbuf nbuf = STRBUF_INIT;
> @@ -647,6 +653,14 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>  	if (err)
>  		goto done;
>  
> +	if ((entry->supported_capabilities & CAP_DELAY) &&
> +	    dco && dco->state == CE_CAN_DELAY) {
> +		can_delay = 1;
> +		err = packet_write_fmt_gently(process->in, "can-delay=1\n");
> +		if (err)
> +			goto done;
> +	}
> +
>  	err = packet_flush_gently(process->in);
>  	if (err)
>  		goto done;
> @@ -662,14 +676,74 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>  	if (err)
>  		goto done;
>  
> -	err = strcmp(filter_status.buf, "success");
> +	if (can_delay && !strcmp(filter_status.buf, "delayed")) {
> +		dco->is_delayed = 1;
> +		string_list_insert(&dco->filters, cmd);
> +		string_list_insert(&dco->paths, path);
> +	} else {
> +		/* The filter got the blob and wants to send us a response. */
> +		err = strcmp(filter_status.buf, "success");
> +		if (err)
> +			goto done;
> +
> +		err = read_packetized_to_strbuf(process->out, &nbuf) < 0;
> +		if (err)
> +			goto done;
> +
> +		err = subprocess_read_status(process->out, &filter_status);
> +		if (err)
> +			goto done;
> +
> +		err = strcmp(filter_status.buf, "success");
> +	}
> +
> +done:
> +	sigchain_pop(SIGPIPE);
> +
> +	if (err)
> +		handle_filter_error(&filter_status, entry, wanted_capability);
> +	else
> +		strbuf_swap(dst, &nbuf);
> +	strbuf_release(&nbuf);
> +	return !err;
> +}

This I can understand better than the previous round ;-)

> diff --git a/convert.h b/convert.h
> index 82871a11d5..cdb91ab99a 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -4,6 +4,8 @@
>  #ifndef CONVERT_H
>  #define CONVERT_H
>  
> +#include "string-list.h"
> +
>  enum safe_crlf {
>  	SAFE_CRLF_FALSE = 0,
>  	SAFE_CRLF_FAIL = 1,
> @@ -32,6 +34,27 @@ enum eol {
>  #endif
>  };
>  
> +enum ce_delay_state {
> +	CE_NO_DELAY = 0,
> +	CE_CAN_DELAY = 1,
> +	CE_RETRY = 2
> +};

This feels more natural and makes it easy to imagine the state
transition diagram.  enable-delay will take us from no-delay to
can-delay, and we tell the filter that it is OK to delay while
making the initial pass of the requests, and then after that we go
into retry state to collect the delayed reponses.

> +struct delayed_checkout {
> +	/* State of the currently processed cache entry. If the state is
> +	 * CE_CAN_DELAY, then the filter can change the 'is_delayed' flag
> +	 * to signal that the current cache entry was delayed. If the state is
> +	 * CE_RETRY, then this signals the filter that the cache entry was
> +	 * requested before.
> +	 */

        /*
         * Our multi-line comment look like this; slash-aster 
         * and aster-slash that opens and closes the block are
         * on their own lines.
         */

> +	enum ce_delay_state state;
> +	int is_delayed;

Hmph, I do not terribly mind but is this thing really needed?

Wouldn't filters and paths being non-empty be a good enough sign
that the backend said "ok, I am allowed to give a delayed response
so I acknowledge this path but would not give a result right away"?

> +int finish_delayed_checkout(struct checkout *state)
> +{
> +	int errs = 0;
> +	struct string_list_item *filter, *path;
> +	struct delayed_checkout *dco = state->delayed_checkout;
> +
> +	if (!state->delayed_checkout)
> +		return errs;
> +
> +	dco->state = CE_RETRY;
> +	while (dco->filters.nr > 0) {
> +		for_each_string_list_item(filter, &dco->filters) {
> +			struct string_list available_paths = STRING_LIST_INIT_NODUP;
> +
> +			if (!async_query_available_blobs(filter->string, &available_paths)) {
> +				/* Filter reported an error */
> +				errs = 1;
> +				filter->string = "";
> +				continue;
> +			}
> +			if (available_paths.nr <= 0) {
> +				/* Filter responded with no entries. That means
> +				 * the filter is done and we can remove the
> +				 * filter from the list (see
> +				 * "string_list_remove_empty_items" call below).
> +				 */
> +				filter->string = "";
> +				continue;
> +			}
> +
> +			/* In dco->paths we store a list of all delayed paths.
> +			 * The filter just send us a list of available paths.
> +			 * Remove them from the list.
> +			 */
> +			filter_string_list(&dco->paths, 0,
> +				&remove_available_paths, &available_paths);
> +
> +			for_each_string_list_item(path, &available_paths) {
> +				struct cache_entry* ce;
> +
> +				if (!path->util) {
> +					error("external filter '%s' signaled that '%s' "
> +					      "is now available although it has not been "
> +					      "delayed earlier",
> +					      filter->string, path->string);
> +					errs |= 1;
> +
> +					/* Do not ask the filter for available blobs,
> +					 * again, as the filter is likely buggy.
> +					 */
> +					filter->string = "";
> +					continue;
> +				}
> +				ce = index_file_exists(state->istate, path->string,
> +						       strlen(path->string), 0);
> +				assert(dco->state == CE_RETRY);

Can anything futz with dco->state at this late in the game?  You
entered into CE_RETRY state at the beginning of this function, and
this loop is going through each delayed ones. At this point, you are
going to make , but not yet have made, a request to the backend via
another call to checkout_entry() again.

Just wondering what kind of programming errors you are protecting
yourself against.  I briefly wondered perhaps you are afraid of a
bug in checkout_entry() that may flip the state back, but it that
is the case then the assert() would be after checkout_entry().

> +				errs |= (ce ? checkout_entry(ce, state, NULL) : 1);

> +			}
> +		}
> +		string_list_remove_empty_items(&dco->filters, 0);
> +	}
> +	string_list_clear(&dco->filters, 0);
> +
> +	/* At this point we should not have any delayed paths anymore. */
> +	errs |= dco->paths.nr;
> +	for_each_string_list_item(path, &dco->paths) {
> +		error("'%s' was not filtered properly", path->string);
> +	}
> +	string_list_clear(&dco->paths, 0);
> +
> +	free(dco);
> +	state->delayed_checkout = NULL;
> +
> +	return errs;
> +}

Thanks.
