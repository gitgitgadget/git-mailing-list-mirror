Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B11A1DF736
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300405; cv=none; b=oP+S6ouuwnM2b1MOQ0wvBLC1QJrQTFbQlwn9CzZW2khiPWLejHtkHzKhOhvUs3GGiuFL21IZ4Q69Y3TRSDCZ/QboR4BBVGmXoWxcKiazjBQojCb+LaOPwd7ToeBuscW+Imj23kQqZaK5O4ouuHD3r/cUxqYqO2S0KKIz4JG/AhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300405; c=relaxed/simple;
	bh=/FXppzcXqmiuuaEJMLp1y1UxHgviKfekSBmdg2dv4eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D154wmhq/Rv2UzdMP+pxLOOHj/I1qVhgKPb7vganjZu73gff5vn12YEv10FwTuoSBRamW19Ag9zz0k0HQvWJT34KvJ9VGVbTUwlpgmxDRT5fcRH2DclyTOEYht9kJcWtGQ/G+BR8LJ5aUScATHZvlkfG8eWc4yzq7Nc3+ATP34M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N5jPjgN2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dNLHRQNB; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N5jPjgN2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dNLHRQNB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6358A1D00119;
	Wed, 24 Jun 2026 07:26:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 07:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782300403; x=1782386803; bh=aBkJrndVBm
	GcrW6cFsqtR8z0a+0h59KvNJpjLTaEDrs=; b=N5jPjgN2gtublXRR/V97Zf8Sbo
	2yBKh6t5108DibrKrYAqv5cRF/P/NQRRGqsNnpESItqCdumgmgVBgvK+YMaix85P
	O9c6KM3sFTeugEZIy9vEzyuPiQIOap53P7lj8nVoHjVISQ1oAMhy426aV3I2eK2+
	yyqjQEDsQFUoQr28fLQ9rQnuW4/MYnK6RvikkoFF8WvcOPtHhRhGZevpwh7GQGwl
	3HUYp8fYjzvS1Z2H+faeaNx+o1ppVNRv2Krs8hB8D7ao25/EN25/MkNGlUr1tQ/2
	jNVIQgrCjmjiOpXXxjBKC+1CDXKNN57WwXI22pUPddyRiEVl6E1ciwxiI4tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782300403; x=1782386803; bh=aBkJrndVBmGcrW6cFsqtR8z0a+0h59KvNJp
	jLTaEDrs=; b=dNLHRQNBCPGcx0sWSv7VJF3Ka8D4TcmJOxr3J+DuyvrtbWMKTfz
	/GJM3FQaVxxDGFrtA4GQUx1UA4xCCzaB0Au79ierFZNzy4zYqTMS0AxtWHhjH0wp
	txuc8W9cBMJKTn4ZlTBRgdYMOZbqOJ0Fv7IIuRcp7AcCCDQaLPG/fbp7v5+Kik8y
	juf66WOeozlmAJHnN43Poc5ids7WwNChbgd7iFSXUq9ydVUUl8qpp2HmJ3rj9K/l
	hIWN65Ans+1CehCu3l1QRIZRixTZxhb4lYqKWLrW0s6jkn4stpjz+JJzjvMuCyPX
	MePNN42kfSq7A7240PNh04t3budlOcNX4lA==
X-ME-Sender: <xms:8747amZ_oslHBBbuLRglayicrMJMwPy090j5x2oby9yzBOPBt6Q--Q>
    <xme:8747avaBQZcVNBn3HhsbS-RKRyn_5uTpFt54GMdUVo9TSG-xWQ5Ob96W4vB8x55eO
    gmibI5h92NZyFW5R-i0M6IFp_BUynwjAXWXX31vsWc2h12YrQ8AKzQ>
X-ME-Received: <xmr:8747aulPuJhMThotgabiWVufW2IVrfUHbfFc__K0Z5P-uepaV4Gc1XAD7kI9ToqUOUyw6o7qfR4EC3MjR0P_Z8I8x2VKu_aDutwtmqL_>
X-ME-Proxy-Cause: dmFkZTE8nadoKE78MhcMgd+5yQWfYE0kD+bQfooTkEol/2jwh+xQsSE2EvTICLpAxVc6wf
    Mde+nLtwhCDFgylcTHk/OMcTocidOWfSjCfl1ep4tPfzxsNejPrls4ML+APBsOAX3uzheb
    JA5MEHFKwGvkD+b/6WuDd3yQyXQ427/ILRxgyd3XU1A7aAwGy/3gEHwr1+FN5NtTpHsvce
    YqPsamkWBANJ/ROUZROvLaY01t1XVO7syFfaNDCALE6hrnBXo62XNAv4kgX+djkM/VYmwI
    BDkK38geuCKVXOnLz1wAfv1L1r+mzoInrQDXRoyahUbur2UGZZXpoWwgZQ+JkM10xqHIMl
    NyPottbFvp2xHmkLCbaTlb705NDC8GzkAI6Ed7U6icFiI6pKstlmpfnsl8643VqQkOnK1Q
    3Vp3LYkghrhcE5/S8u3UQQts0eEqrI45/MM2olbgaW1U4fJAFImn80sMUfivKyNxCMJqIb
    oveAq5qT7InI8FLkCMRUIPl1eI1gdiR+egvwY0qvHNQFFcDjKZntRJ12/9JKpws7UevhcK
    4DETWCgt5RoSpBtSAlxKkM1PCNtvJQoKFHJNO0K57yef8APB6oTwu4WZoyEF+XPuSYHeWN
    nIWSBXuwwJvD4c6tBWeujqRP1Oi6elmJtI9sq1ds35QeUAC/Qk+8io+SNfwQ
X-ME-Proxy: <xmx:8747ajyl6341xBxJXtwa46bc4b0TVogmP-bXmr0hLq1elLnRCnNEFQ>
    <xmx:8747akPA3wXBloWUperV5D5wUQA6ixLg0tKLgfMFA-a3swdcs-DN5A>
    <xmx:8747avT5XHxFhg6GcguDDVhuQp0U-CgwFQjJn07RgdALxPdAlycjkg>
    <xmx:8747aqZXrFyKA4XMVQSxMvJf3sk8Jp2OtOOLcllPyYZphkgxBjwJSA>
    <xmx:8747asKA3HjseCWiA2Hx-fSc-Ng-CP37DrLFXwP7Nojlmb9o0T_3kFrb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 07:26:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1b3adcc1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 11:26:40 +0000 (UTC)
Date: Wed, 24 Jun 2026 13:26:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] object-file: propagate files transaction errors
Message-ID: <aju-7Z-ecJG_ORow@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624041920.2601961-3-jltobler@gmail.com>

On Tue, Jun 23, 2026 at 11:19:16PM -0500, Justin Tobler wrote:
> The "files" transaction backend may encounter errors related to managing
> the temporary directory used to stage objects, but silently ignores
> these errors. Instead return errors encountered in the
> `odb_transaction_files_{prepare,begin,commit}()` interfaces to allow
> callers to handle as needed.

Missing a then? "to handle as needed" -> "to handle them as needed"

Makes sense. It always felt a bit off that those functions didn't have a
way to signal errors to the caller.

> diff --git a/object-file.c b/object-file.c
> index a3eb8d71dd..18c2df75fb 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -499,7 +499,7 @@ struct odb_transaction_files {
>  	struct transaction_packfile packfile;
>  };
>  
> -static void odb_transaction_files_prepare(struct odb_transaction *base)
> +static int odb_transaction_files_prepare(struct odb_transaction *base)
>  {
>  	struct odb_transaction_files *transaction =
>  		container_of_or_null(base, struct odb_transaction_files, base);

By the way, is there any reason why those functions are still hosted in
"object-file.c" instead of in "odb/source-files.c"? I should probably
know, but I forgot.

> @@ -511,11 +511,15 @@ static void odb_transaction_files_prepare(struct odb_transaction *base)
>  	 * added at the time they call odb_transaction_files_begin.
>  	 */
>  	if (!transaction || transaction->objdir)
> -		return;
> +		return 0;
>  
>  	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
> -	if (transaction->objdir)
> -		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
> +	if (!transaction->objdir)
> +		return -1;

Huh. So previously we just didn't handle this error at all and just
continued to tag along? Did that result in anything sensible or was this
just YOLOing it?

> @@ -542,13 +546,13 @@ static void fsync_loose_object_transaction(struct odb_transaction *base,
>  /*
>   * Cleanup after batch-mode fsync_object_files.
>   */
> -static void flush_loose_object_transaction(struct odb_transaction_files *transaction)
> +static int flush_loose_object_transaction(struct odb_transaction_files *transaction)

Feels like this function should've been renamed in the preceding commit,
as well.

>  {
>  	struct strbuf temp_path = STRBUF_INIT;
>  	struct tempfile *temp;
>  
>  	if (!transaction->objdir)
> -		return;
> +		return 0;
>  
>  	/*
>  	 * Issue a full hardware flush against a temporary file to ensure
> @@ -570,8 +574,12 @@ static void flush_loose_object_transaction(struct odb_transaction_files *transac

There is a call to `xmks_tempfile()` hidden that can fail, but that
failure is already handled in that function itself by dying.

>  	 * Make the object files visible in the primary ODB after their data is
>  	 * fully durable.
>  	 */
> -	tmp_objdir_migrate(transaction->objdir);
> +	if (tmp_objdir_migrate(transaction->objdir))
> +		return -1;

Feels like another case of YOLOing it. The migration could have failed,
but we just ignored that failure and never told the user about it. The
result may be silent corruption, I assume?

> @@ -1670,27 +1678,34 @@ int read_loose_object(struct repository *repo,
>  	return ret;
>  }
>  
> -static void odb_transaction_files_commit(struct odb_transaction *base)
> +static int odb_transaction_files_commit(struct odb_transaction *base)
>  {
>  	struct odb_transaction_files *transaction =
>  		container_of(base, struct odb_transaction_files, base);
>  
> -	flush_loose_object_transaction(transaction);
> +	if (flush_loose_object_transaction(transaction))
> +		return -1;
>  	flush_packfile_transaction(transaction);
> +
> +	return 0;
>  }
>  
> -struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
> +int odb_transaction_files_begin(struct odb_source *source,
> +				struct odb_transaction **out)
>  {
>  	struct odb_transaction_files *transaction;
>  	struct object_database *odb = source->odb;
>  
> -	if (odb->transaction)
> -		return NULL;
> +	if (odb->transaction) {
> +		*out = NULL;
> +		return 0;
> +	}
>  
>  	transaction = xcalloc(1, sizeof(*transaction));
>  	transaction->base.source = source;
>  	transaction->base.commit = odb_transaction_files_commit;
>  	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
> +	*out = &transaction->base;
>  
> -	return &transaction->base;
> +	return 0;
>  }

It's still somewhat fishy that we have this ODB-level transaction, but
that's a preexisting issue and thus outside the scope of this patch
series. Ideally though, it would be possible for there to be multiple
transactions, and it would be the caller's responsibility for juggling
these transactions. Just as it happens with reference transactions.

> diff --git a/odb/transaction.h b/odb/transaction.h
> index 854fda06f5..f4c1ebfaaa 100644
> --- a/odb/transaction.h
> +++ b/odb/transaction.h
> @@ -17,7 +17,7 @@ struct odb_transaction {
>  	struct odb_source *source;
>  
>  	/* The ODB source specific callback invoked to commit a transaction. */
> -	void (*commit)(struct odb_transaction *transaction);
> +	int (*commit)(struct odb_transaction *transaction);

We might want to document the returned error code here.

Patrick
