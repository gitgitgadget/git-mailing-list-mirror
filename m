Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9996D208DB
	for <e@80x24.org>; Tue, 29 Aug 2017 18:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdH2SHk (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 14:07:40 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33451 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbdH2SHf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 14:07:35 -0400
Received: by mail-pf0-f176.google.com with SMTP id r62so12381617pfj.0
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ws8Tmr0rqXbLkRxOaAYriTGQPqxw8niqM8wh4OD4UBk=;
        b=XG5R685dCUo0/42VBwfanr5bg5LDS4SpVkX0Ea1jP/7bDU1G6KyiYPFHCNaA55S1oN
         R0JqwWc1OovnFpAgt52xac+j97q/EvZb6kmC4Jslkf+YtCUWsaRWIwxw8OIXFxjre3wQ
         zx7ND3+W/ZCBLszraCVUvFHIlQU6BItJvRKswy/fReEhCpqBHer/vazk955GLUl6jGAJ
         r4KHr8AhJ0qR71v+lGJ6dA/T6Iwi7NXdAHmzBrvtaVUdYSvtKvlSFNMmFBeb4xCAtQGI
         7w+F91Aale5A1AgmCjBolSMyh4VL2tM5kabZhihCa+C4iw7btlWe1LRHe9kg9goe4GHk
         KGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ws8Tmr0rqXbLkRxOaAYriTGQPqxw8niqM8wh4OD4UBk=;
        b=AHHd+aV4dd++FFOJLI+LtlpIND/A9+2loSFPtYnjthIKZ9aqabAUoDt7NRfLRSgebx
         bYxBtCu7p5btGCsbUu0M+Z1kRRxZgSQLoj6/K+PhlKtq9r7nq9dLEVA8rd/ZalqFg4co
         HWx6L0ISe/ae76XFhmyuimZk5C6LsDYi6OIi03/iu3Rzqdiv9l/JbIIeQI0/aOqsP9vo
         D1DO/YTvNxBatksFxHSQid9BKuIVB3Q6ldTqml9VHRXTqPg7zSD9AVknAGAbyyETaPBT
         GOUzXlcJ0W0eRPz+/HUXzezxhR9uQRKMRqbQ62l6cpw2OXjvPlukl+GtAfogVSRgBJLq
         oaLQ==
X-Gm-Message-State: AHYfb5gZ5LF6sfM+WnCNKNZigsvLdrPFZd6yEy7U/tDP1JVQzAgyZVjZ
        ilRy14crlukqULw4
X-Google-Smtp-Source: ADKCNb5D6q0/AGIubXTIMQSjRdT9qVysQAw1cjhMkUwcDZKS8s4VTHBbZw1HbCNevRmDkVhEQFbQTQ==
X-Received: by 10.84.131.129 with SMTP id d1mr1515194pld.114.1504030054774;
        Tue, 29 Aug 2017 11:07:34 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:7c99:20b:3f53:fc88])
        by smtp.gmail.com with ESMTPSA id 9sm883508pfq.127.2017.08.29.11.07.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 11:07:33 -0700 (PDT)
Date:   Tue, 29 Aug 2017 11:07:32 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 04/10] packed_delete_refs(): implement method
Message-ID: <20170829180732.GA131745@google.com>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <7c61f04574e32d6172062a6a8ffa8ade5c90bb1d.1503993268.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c61f04574e32d6172062a6a8ffa8ade5c90bb1d.1503993268.git.mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/29, Michael Haggerty wrote:
> Implement `packed_delete_refs()` using a reference transaction. This
> means that `files_delete_refs()` can use `refs_delete_refs()` instead
> of `repack_without_refs()` to delete any packed references, decreasing
> the coupling between the classes.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs/files-backend.c  |  2 +-
>  refs/packed-backend.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index fccbc24ac4..2c78f63494 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1157,7 +1157,7 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
>  	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
>  		goto error;
>  
> -	if (repack_without_refs(refs->packed_ref_store, refnames, &err)) {
> +	if (refs_delete_refs(refs->packed_ref_store, msg, refnames, flags)) {
>  		packed_refs_unlock(refs->packed_ref_store);
>  		goto error;
>  	}
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index d19b3bfba5..83a088118f 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1082,7 +1082,50 @@ static int packed_initial_transaction_commit(struct ref_store *ref_store,
>  static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
>  			     struct string_list *refnames, unsigned int flags)
>  {
> -	die("BUG: not implemented yet");
> +	struct packed_ref_store *refs =
> +		packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
> +	struct strbuf err = STRBUF_INIT;
> +	struct ref_transaction *transaction;
> +	struct string_list_item *item;
> +	int ret;
> +
> +	(void)refs; /* We need the check above, but don't use the variable */

Can't say I've seen a line like this before, Is the intent to just mark
that this variable won't be used like you mention in the comment?

> +
> +	if (!refnames->nr)
> +		return 0;
> +
> +	/*
> +	 * Since we don't check the references' old_oids, the
> +	 * individual updates can't fail, so we can pack all of the
> +	 * updates into a single transaction.
> +	 */
> +
> +	transaction = ref_store_transaction_begin(ref_store, &err);
> +	if (!transaction)
> +		return -1;
> +
> +	for_each_string_list_item(item, refnames) {
> +		if (ref_transaction_delete(transaction, item->string, NULL,
> +					   flags, msg, &err)) {
> +			warning(_("could not delete reference %s: %s"),
> +				item->string, err.buf);
> +			strbuf_reset(&err);
> +		}
> +	}
> +
> +	ret = ref_transaction_commit(transaction, &err);
> +
> +	if (ret) {
> +		if (refnames->nr == 1)
> +			error(_("could not delete reference %s: %s"),
> +			      refnames->items[0].string, err.buf);
> +		else
> +			error(_("could not delete references: %s"), err.buf);
> +	}
> +
> +	ref_transaction_free(transaction);
> +	strbuf_release(&err);
> +	return ret;
>  }
>  
>  static int packed_pack_refs(struct ref_store *ref_store, unsigned int flags)
> -- 
> 2.14.1
> 

-- 
Brandon Williams
