Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6B23EAA6
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762203133; cv=none; b=CGocsThNTKQOPSgPHP493oiT30wiEHWwU485LYPN61rZoYeNjW2w2Hbb6ecDAcvHJqE3NEUu1Kdrgn8enoSy2xWDZtlQirjZ5N26wr764b2pXD6g7L7WoqWBeY47XsxZEH8xyHm9aDU2wot/07UCV3SkcebgYxjl1CB1BwusFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762203133; c=relaxed/simple;
	bh=YD4jH5SJFPbK+OD9dbZI6TYAavdR2RktzlyWqZPA/6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrUKSIrBdMC/JjAwE7HZa+2Ct/AJl0mJv4saXuEkycO6o+NBGcfR3aYIflrNzmW0+hCoFPrxQlTZnFkI5AgLz+laUHYme3X0s77lBsS53VlKNpwIcVGwFHeWq+SiKVteFAjkePS4cPfyLKnMLHIa3oZPFXpNwgszwrkNOJPfc40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQI8Zkfn; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQI8Zkfn"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3d5bb03d5c2so3364681fac.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 12:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762203131; x=1762807931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCXiUERF9H/vfE84YwacvAN9skhhUICNkd94mzf68R0=;
        b=VQI8ZkfnmeGDkMU6kTzkeNxymHwJeybXMLonKyVg2lx5VEs3xPWdhKbltajm0g6gRx
         RlSh22R9y8HPKxbMMlKeyTiR0Xza86YpYBLnxctOPWkg97Ple2feidfqE73gLZLpu7QQ
         t0Rg4rGZM9UHThz0koYJI+umqf5KDO1KriL3Eb/116f7+L94VJk+vTTbkH9OdHjOoXMt
         /JNQinZlZgMy8bfpkpKTDTRnGMacLtvfVC+BFE1Wcfubm9CXsl6y16YyUEUjduGxsPfj
         skKySfPT0EN6uDZIWo+dyqrYw6tXCLoT4zMOKlbsjXyUKNjqiQrYTPfHcOMUoJidACzl
         +jAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762203131; x=1762807931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCXiUERF9H/vfE84YwacvAN9skhhUICNkd94mzf68R0=;
        b=OK9jYNBuPT81wk3HTtxtlLUYLSVh8PoItRowf1MsqBuuXPn5Ob2ADmly6NfANxrGCd
         Isr7Jb94gQt9cNK17eoKgPppzeQl05Nj2qcBMP12l5gDsvj/jUpQO+mCTGJf+KKcIDOF
         tbhyOItzXTXaOvqKNal6YR81k4w/EQZQeRgtTk3E9FVHa/j0ZveDrNjm7utPC3kZ6qBY
         Jg4TlJfnORcVZcH3soVbeLjM9I0x9QVmxpuz2ljVZsSxWMk+zCHTvGrppaA6oteRb2hU
         aKoEwsbQNkuNthCpxIfrfK4IWku9/RpJ7SMRpe5j14cLauezmNkkZXRC+eIJGyEEC7os
         XQTQ==
X-Gm-Message-State: AOJu0YzYbDAkHdxYRKFmW3n2DipeOmh05RQ+gKyraBcD8rWjQxv7xYt+
	IRpTDwFZqwLuGnrcMvx6mgkvc34zlGE33N7+AJES/wcYauVcKlj2F4SAM/Blhw==
X-Gm-Gg: ASbGncsi8Tinb1cZuff4YoN3neKusnlya/58APgi0jAvU9XXrKOAOphKAfC4boKDQbH
	achefLPVOuV4wan4smcMJ7wdIikwbULSi9raXr2bUO9Ssluil1ZMcpq/pfJODi3S3uF5yCknChg
	XO4PLNhuSP8m3VnVjizmOtZUMZ0/Io1b41FwDsWDVhtL7Wt4qG1tDYtzCVGblcf69jVtg72ucMN
	myI7NbSlTDHNnLt+8sWSkBc/yROOhK01eZs7CSDm7WQ4hh1Yds+RJ4ybJ+5WRGNCODlXuQjwP4w
	VJJz6P4pdFYLKU41Ql4fMrn4WLHGWWxik20HaAJ0+nAWx+XXO5TvPpOK9t4c6Jlg5LzzQcioNPz
	BhYfsFam8QQrSh4DaKdCzkG+32YnvuqTIZTJhIiRZfKLX6b5kuY7/qhVzsY44jM3M/smfL/7ap6
	Zk3xcn
X-Google-Smtp-Source: AGHT+IGBi8IBlxniVybEgPAEcrqOMgRy/1Sk0GVdgr6LdsTOSTVQ1rvC/ZOlWgFd/cMpc3KIGL7vXQ==
X-Received: by 2002:a05:6870:7d0a:b0:3d6:8c2e:15b2 with SMTP id 586e51a60fabf-3daca71e788mr6478970fac.13.1762203131214;
        Mon, 03 Nov 2025 12:52:11 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3dff5213959sm412040fac.10.2025.11.03.12.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 12:52:10 -0800 (PST)
Date: Mon, 3 Nov 2025 14:52:04 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, David Bohman <debohman@gmail.com>
Subject: Re: [PATCH] fetch: fix non-conflicting tags not being committed
Message-ID: <i3wzd6r2iohohj36fbipc2owrxkqzjni6aqwyv2gw7hb5kdg6b@y6fsmfvphpom>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>

On 25/11/03 02:49PM, Karthik Nayak wrote:
> The commit 0e358de64a (fetch: use batched reference updates, 2025-05-19)
> updated the 'git-fetch(1)' command to use batched updates. This batches
> updates to gain performance improvements. When fetching references, each
> update is added to the transaction. Finally, when committing, individual
> updates are allowed to fail with reason, while the transaction itself
> succeeds.
> 
> One scenario which was missed here, was fetching tags. When fetching
> conflicting tags, the `fetch_and_consume_refs()` function returns '1',
> which skipped committing the transaction and directly jumped to the
> cleanup section. This mean that no updates were applied.

Ok so when fetching tags, if there is a reference conflict, we are
bailing out without committing the transaction. In such cases, we
actually want to handle the rejected reference updates and continue with
the transaction.

> Fix this by committing the transaction even when we have an error code.
> This ensures other references are applied. Do this by extracting out the
> transaction commit code into a new `commit_ref_transaction()` function
> and using that.

Makes sense.

> Add two tests to check for this regression. While here, add a missing
> cleanup from previous test.
> 
> Reported-by: David Bohman <debohman@gmail.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> This fixes the bug reported by David Bohman [1].
> 
> [1]: id:CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com
> ---
>  builtin/fetch.c  | 65 +++++++++++++++++++++++++++++++++-----------------------
>  t/t5510-fetch.sh | 41 +++++++++++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+), 27 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index c7ff3480fb..8dea08dc74 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1686,6 +1686,38 @@ static void ref_transaction_rejection_handler(const char *refname,
>  	*data->retcode = 1;
>  }
>  
> +static int commit_ref_transaction(struct ref_transaction **transaction,
> +				  bool is_atomic, const char *remote_name,
> +				  struct strbuf *err)

nit: I think `commit_ref_transaction()` here can easily be confused with
`ref_transaction_commit()` and it's not exactly clear how they differ
from the names alone. Maybe we could explain the additional
responsibilities in a comment?

> +{
> +	int retcode = ref_transaction_commit(*transaction, err);
> +	if (retcode) {
> +		/*
> +		 * Explicitly handle transaction cleanup to avoid
> +		 * aborting an already closed transaction.
> +		 */
> +		ref_transaction_free(*transaction);
> +		*transaction = NULL;
> +	}
> +
> +	if (*transaction && !is_atomic) {
> +		struct ref_rejection_data data = {
> +			.conflict_msg_shown = 0,
> +			.remote_name = remote_name,
> +			.retcode = &retcode,
> +		};
> +
> +		ref_transaction_for_each_rejected_update(*transaction,
> +							 ref_transaction_rejection_handler,
> +							 &data);
> +
> +		ref_transaction_free(*transaction);
> +		*transaction = NULL;
> +	}
> +
> +	return retcode;
> +}
> +
>  static int do_fetch(struct transport *transport,
>  		    struct refspec *rs,
>  		    const struct fetch_config *config)
> @@ -1826,6 +1858,10 @@ static int do_fetch(struct transport *transport,
>  
>  	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_map,
>  				   &fetch_head, config)) {
> +		/* As we're using batched updates, commit any pending updates. */
> +		if (!atomic_fetch)
> +			commit_ref_transaction(&transaction, false,
> +					       transport->remote->name, &err);

IIUC, when we encounter an error via `fetch_and_consume_refs()` we now
explicitly commit the transaction early and handle the rejected
references. At first I wondered why we wouldn't just skip the "goto
cleanup" in such cases, but I assume this is in part because we are
trying to match the pre-batched updates behavior.

Naive question: I noticed that `backfill_tags()` also invokes
`fetch_and_consume_refs()`. Do we also need to commit pending updates
there in case of reference conflicts?

>  		retcode = 1;
>  		goto cleanup;
>  	}
> @@ -1858,33 +1894,8 @@ static int do_fetch(struct transport *transport,
>  	if (retcode)
>  		goto cleanup;
>  
> -	retcode = ref_transaction_commit(transaction, &err);
> -	if (retcode) {
> -		/*
> -		 * Explicitly handle transaction cleanup to avoid
> -		 * aborting an already closed transaction.
> -		 */
> -		ref_transaction_free(transaction);
> -		transaction = NULL;
> -		goto cleanup;
> -	}
> -
> -	if (!atomic_fetch) {
> -		struct ref_rejection_data data = {
> -			.retcode = &retcode,
> -			.conflict_msg_shown = 0,
> -			.remote_name = transport->remote->name,
> -		};
> -
> -		ref_transaction_for_each_rejected_update(transaction,
> -							 ref_transaction_rejection_handler,
> -							 &data);
> -		if (retcode) {
> -			ref_transaction_free(transaction);
> -			transaction = NULL;
> -			goto cleanup;
> -		}
> -	}
> +	retcode = commit_ref_transaction(&transaction, atomic_fetch,
> +					 transport->remote->name, &err);

This is where we would normally commit the reference transaction and
handle rejected reference updates. Now we just reuse
`commit_ref_transaction()`.

Do we need to check the return value and potentially "goto cleanup"
before proceeding?

-Justin
