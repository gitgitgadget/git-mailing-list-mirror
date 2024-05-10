Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5513CF85
	for <git@vger.kernel.org>; Fri, 10 May 2024 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377582; cv=none; b=YtnZv5VTNF0aT/S7zMyYecOay/ZSj9N8HBgjhUfay4NSlJvAysULSKgFDw3rWo4JHex4VQ3QvCSOw7QCeBl8aE9Ne1b3EuM2gkGoAKa1Nw+Top3Yo9h38VrzGnnNuEcefDceYaBaTW66jXZ1EiOzMZDRivjwGyS+4nn9AiBxEZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377582; c=relaxed/simple;
	bh=2ZbqQYM4b45oppEXwxDRRmaY+8l89Ancf1NVmzQPHKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7bQnIW9niBa1YzoQutCZuSN+fybI8m8zCwmLNtD9hQGEHgdSSb5uzvNsTk/wbsJ5rJC8ZnJlY7fpPAawAUe/VhpEjqVqR5bnmisMFMC17kW2AkzVsvSilR2IAWO0fNqaSRBzIaaaJEB/yt40iDYdUw+3aGXKPGCbvFXjDzxXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4wtIbcR; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4wtIbcR"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-23d16b9bca7so1239183fac.2
        for <git@vger.kernel.org>; Fri, 10 May 2024 14:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715377579; x=1715982379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96Jc/mqcNNaBc8kFaYXaYgNtGjZtDxRy2AUcpPp36b8=;
        b=H4wtIbcRH7FsMTR1OKQRdt3SnPd4WBDyc+ZvzYBmenrWYeH6+LiMAwG8B5BztaDgMF
         aqj5wzdt9+SIEojLMfbzwVOTLAphLceTi0vW8un8MkFl//sxc2nMNYf7U2vBB/kRpc5w
         yvlYV7tWIuYYDftRNr4eBTIinNZcTFFJd2KZMBcEzbcfsiKLO9VchwND2drC8cWlkhDU
         +n0foHuRNeIpa+W1rW/KG/S9IXAnzB9vVipotEzEffMyXZKgsZkJ0RDojbNzWrhtylep
         h1Z7GDdguTVMDhZwsEkOj3WkNWwPk/AkS3pnpeZ/uEA2OvWaV1Dbw6iJ2l3VLJvS7PZN
         pKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377579; x=1715982379;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96Jc/mqcNNaBc8kFaYXaYgNtGjZtDxRy2AUcpPp36b8=;
        b=jpLmWgYbeacpuuofvUDWO+AfrBRWsqexLmxqDgeOT9hvOd3r2g5N9hGMW/8kOrT0Mz
         O81aOWtUJjO/7TQOiFTOiyLQSeqweg7hCiEuT+pjJzOeo8q9X8y6dSCOxa7n1+e5sPFu
         JhopIn+f/FC2VLcR2LsFUxQjIfs8JgA6clNx2iSFfo1VmCUH/aWQlBLnSCHfBbNLUY0r
         Afo/YCdy5kQlE/3TSoM85HtzWzVmBsKggJPF/yZrV/qbubntnhr2G0nDcIDFr2qUrGO/
         iCRZWc5DweIbhsKEPaBIvFetat1JPAFjPTyxU1iq7qaBKKxfNfq/I6HX/wYj0xq3IdGN
         /yrw==
X-Gm-Message-State: AOJu0YyYD5M5QYxDORPnpWp61Z5iDbnTFboKPgfesWURpVkdWc5f/IgI
	FexKvG6Cm07J6iLX5sU/uH+HPZei+zSYM9NhpECRMQf9hlurBlgs9Ua/Ug==
X-Google-Smtp-Source: AGHT+IEoDujX/bmE29XRXxk/WE0AjdlAYW5OqrMlWcPF0V3R7s/0yldwO0+w7qrt3mTJQcrdv5WqRg==
X-Received: by 2002:a05:6870:8190:b0:22e:b96a:375 with SMTP id 586e51a60fabf-24172be95abmr4372855fac.30.1715377579473;
        Fri, 10 May 2024 14:46:19 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e01b6d01sm837162a34.24.2024.05.10.14.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 14:46:18 -0700 (PDT)
Date: Fri, 10 May 2024 16:44:54 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/13] reftable/generic: move seeking of records into the
 iterator
Message-ID: <4pyzm53ioaqt5men72ti4ffu7zjbpigytfgcyg4h2q7657zoji@7hlrvlt2cws2>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1715166175.git.ps@pks.im>
 <859b399e71e92dd7aa0fa7fc9f2d9ca6f389d34a.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <859b399e71e92dd7aa0fa7fc9f2d9ca6f389d34a.1715166175.git.ps@pks.im>

On 24/05/08 01:04PM, Patrick Steinhardt wrote:
> Reftable iterators are created by seeking on the parent structure of a
> corresponding record. For example, to create an iterator for the merged
> table you would call `reftable_merged_table_seek_ref()`. Most notably,
> it is not posible to create an iterator and then seek it afterwards.
> 
> While this may be a bit easier to reason about, it comes with two
> significant downsides. The first downside is that the logic to find
> records is split up between the parent data structure and the iterator
> itself. Conceptually, it is more straight forward if all that logic was
> contained in a single place, which should be the iterator.
> 
> The second and more significant downside is that it is impossible to
> reuse iterators for multiple seeks. Whenever you want to look up a
> record, you need to re-create the whole infrastructure again, which is
> quite a waste of time. Furthermore, it is impossible to for example
> optimize seeks, for example when seeking the same record multiple times.

The last setence could use some rewording.

"Furthermore, it is impossible to optimize seeks, such as when seeking
the same record multiple times."

> 
> To address this, we essentially split up the concerns properly such that
> the parent data structure is responsible for setting up the iterator via
> a new `init_iter()` callback, whereas the iterator handles seeks via a
> new `seek()` callback. This will eventually allow us to call `seek()` on
> the iterator multiple times, where every iterator can potentially
> optimize for certain cases.
> 
> Note that at this point in time we are not yet ready to reuse the
> iterators. This will be left for a future patch series.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/generic.c |  47 +++++++++++++----
>  reftable/generic.h |   9 +++-
>  reftable/iter.c    |  15 ++++++
>  reftable/merged.c  |  97 +++++++++++++++++-----------------
>  reftable/reader.c  | 126 +++++++++++++++++++++++++--------------------
>  5 files changed, 177 insertions(+), 117 deletions(-)
> 
> diff --git a/reftable/generic.c b/reftable/generic.c
> index b9f1c7c18a..1cf68fe124 100644
> --- a/reftable/generic.c
> +++ b/reftable/generic.c
> @@ -12,25 +12,39 @@ license that can be found in the LICENSE file or at
>  #include "reftable-iterator.h"
>  #include "reftable-generic.h"
>  
> +void table_init_iter(struct reftable_table *tab,

The following table related functions are prefixed with `reftable_`. Do
we want to do the same here?

> +		     struct reftable_iterator *it,
> +		     uint8_t typ)
> +{
> +
> +	tab->ops->init_iter(tab->table_arg, it, typ);
> +}
> +
>  int reftable_table_seek_ref(struct reftable_table *tab,
>  			    struct reftable_iterator *it, const char *name)
>  {
> -	struct reftable_record rec = { .type = BLOCK_TYPE_REF,
> -				       .u.ref = {
> -					       .refname = (char *)name,
> -				       } };
> -	return tab->ops->seek_record(tab->table_arg, it, &rec);
> +	struct reftable_record want = {
> +		.type = BLOCK_TYPE_REF,
> +		.u.ref = {
> +			.refname = (char *)name,
> +		},
> +	};
> +	table_init_iter(tab, it, BLOCK_TYPE_REF);
> +	return it->ops->seek(it->iter_arg, &want);
>  }
>  
>  int reftable_table_seek_log(struct reftable_table *tab,
>  			    struct reftable_iterator *it, const char *name)
>  {
> -	struct reftable_record rec = { .type = BLOCK_TYPE_LOG,
> -				       .u.log = {
> -					       .refname = (char *)name,
> -					       .update_index = ~((uint64_t)0),
> -				       } };
> -	return tab->ops->seek_record(tab->table_arg, it, &rec);
> +	struct reftable_record want = {
> +		.type = BLOCK_TYPE_LOG,
> +		.u.log = {
> +			.refname = (char *)name,
> +			.update_index = ~((uint64_t)0),
> +		},
> +	};
> +	table_init_iter(tab, it, BLOCK_TYPE_LOG);
> +	return it->ops->seek(it->iter_arg, &want);
>  }
>  
>  int reftable_table_read_ref(struct reftable_table *tab, const char *name,
...
> @@ -23,6 +23,13 @@ static void filtering_ref_iterator_close(void *iter_arg)
>  	reftable_iterator_destroy(&fri->it);
>  }
>  
> +static int filtering_ref_iterator_seek(void *iter_arg,
> +				       struct reftable_record *want)
> +{
> +	struct filtering_ref_iterator *fri = iter_arg;
> +	return iterator_seek(&fri->it, want);
> +}

I've found the `filtering_ref_iterator_seek()` here to be a little
confusing. At first, I assumed that the `filtering_ref_iterator` would
have referenced `filtering_ref_iterator_vtable` thus resulting in a
cycle, but on closer inspection this does not seem to be the case and is
in face always set to some other iterator operation.

Am I understanding this correctly?

-Justin
