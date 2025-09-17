Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47830C0EF
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123285; cv=none; b=WEM8fOTt/gvWUR7fBYdEw1LEQpLcl5BwI43yHGtlFASNP57LyxE+oZToiKPECkNpxzp6zuthotp0EzJGmHYFKTefXSx+2/XstBGSEBTENplQtHgsNM8R5O2+kMxbMExbPJsCxk/GgAPGmIPqg05C75Zo6759b4dwzDCLXvYFll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123285; c=relaxed/simple;
	bh=K5ZIMj/npaCcStzpCYHeKvQHavj5wD9wUPwCn1z9diA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDFnIcpMogW7Lcx/9OET7lf5YCflUTD3ir+3GCh9vizQ8cKxWB51ZOsdJ+eTuPDgp+8iytwVgPgOEPziwk50T13FXkb0pVDGriZriiVmX+eqerqMJHmkhiOfN6V0kqWg0n60mYPXvbcak2rpFVpqUqf80WifP8x4MmG2Zn4mMdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XS8dBc19; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS8dBc19"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3357b8aeddaso1387841fac.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758123282; x=1758728082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BocGujmq7CUwGwcP5zxjAEGAPEvN0+X8urkcSnAzsrE=;
        b=XS8dBc19IyV9hJE0xm4Fa2BAblHtnu7D49+VWs1L6ryP2BeqICTXoCtni9H71aBz06
         aK8JU8y7iMBDeMax4bA4gei+RFYxttNs7yXK9Es86JHfTFbnTp+QaMVniWLZ4TvqSe3U
         pK6N9uWle0cF+4ThtJepuhUhy77wIfXxgBEOvqmVjucy9reWD74WEKtbv0Uleye/1Ulj
         YaJSodnhRPRbGuTe1TSCGmCfy3xPDE/SdNC0dQ1xTov43KZED5+kXtpIe2exL5wyaMIR
         yKhvcVKM+kPgSHbfYBy1K5c402ozxZlU6qGl6fUpSWo/owrYO+XYbrzhHHrxvJ+J9IJh
         +AcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123282; x=1758728082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BocGujmq7CUwGwcP5zxjAEGAPEvN0+X8urkcSnAzsrE=;
        b=sPxQaEu5orAi8y7Un3sBvH6i4HlW43o3hOyGWbTtcGVP3uvsVspOeW4h985U65QagR
         mRg61KCYOpbEyiyN80YUFXZEWytphVXyt9YX/JRcLSjL4N474627wuYzFapwv7V/yaqB
         5tNXtrEoeKarmvNwueSduN1GpviHp7o+gRcAAsMZ3oVrAE5EuzEgycQH9Oarb5IPAUiD
         +4RGe7gnTwztGtNXTOFoPUaiLCxdAksUoAg4Fu52QtIJVw9LNPHN8g4BaJaU/BYbbLj/
         ++rwkvO0R6X0+8C+hih2h6qWbv9i6bid/hiG9mwGKZYSoLIeLLZzDSdmiTDwifB7Kqcc
         5qMQ==
X-Gm-Message-State: AOJu0YyoCPgssJqvSwFQKyo0lyMmgpE6EMOx+U+48T8WopH6W93IlWSm
	RWHmBHnUnaHpN8JgOtbEJbRRvC016Vtk/7vngNrdlsTa3W5Kq+gE1mmm
X-Gm-Gg: ASbGncs2IICnhuNPG1/G1HgYP1pnozcDbEEBry0+84f/sI03UAp18GamZrIOcatRorx
	ALACuezaStZTSisOc6diiqfiJQIlCI7RD1s0uHQlz+a4v3UgH198JEzVxVuYrRB68C1hp6I8NMv
	wvG3Zb79u0zvDAi36ZMafmnjSbzYPfiwwcVjURnH7mgThcweodNIyOteN06WJsm96fV3fb+0ECy
	v/Ptj1axiSJoorH05oKyp48PyfXdVBrqpw4tZqZwXpFfh2mV6M2gCiblzq2VGxtX33v4ahE8Exx
	fLH6/syQki/uebqKmHc8NClSVkLM6kNUliGYUQ1xNog/wGJlsdpLcsCToAL1I3mH9ddfHPtlmn9
	S4mdKmp1iQ5QZZNqj
X-Google-Smtp-Source: AGHT+IFXFB6/sKCbyb/UQozQpAGfrrtCs1JILY0svOa7FfcyD5IUIAXLep/D1KewpOkNbHD6j+V4ng==
X-Received: by 2002:a05:6871:14e:b0:333:295e:96f6 with SMTP id 586e51a60fabf-335c0d7bf03mr1371256fac.37.1758123282480;
        Wed, 17 Sep 2025 08:34:42 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-330c51caddesm4547659fac.29.2025.09.17.08.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:34:42 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:34:41 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, 
	ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v3 1/4] refs/files: catch conflicts on case-insensitive
 file-systems
Message-ID: <eiu2y4r3nncfnmsg3ar3jhzya6ge4dnmwqyrkhsinhcjaxd4qn@ehu6l7xngtrg>
References: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
 <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-1-195569740b57@gmail.com>
 <uv4ifkvxcujjjj3lsc4tf5b5dnc7pkaaw62t6ahagnskxn4kg6@oyxjgupdilrc>
 <CAOLa=ZR1LNs0i5TDPFG_QvUYS3=CMx3ov-68ph6QKNM273JUHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR1LNs0i5TDPFG_QvUYS3=CMx3ov-68ph6QKNM273JUHQ@mail.gmail.com>

On 25/09/17 12:33AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> > On 25/09/13 10:54PM, Karthik Nayak wrote:
> >> +
> >>  /*
> >>   * Lock refname, without following symrefs, and set *lock_p to point
> >>   * at a newly-allocated lock object. Fill in lock->old_oid, referent,
> >> @@ -677,16 +697,17 @@ static void unlock_ref(struct ref_lock *lock)
> >>   * - Generate informative error messages in the case of failure
> >>   */
> >>  static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
> >> -					       struct ref_update *update,
> >> +					       struct ref_transaction *transaction,
> >>  					       size_t update_idx,
> >>  					       int mustexist,
> >>  					       struct string_list *refnames_to_check,
> >> -					       const struct string_list *extras,
> >>  					       struct ref_lock **lock_p,
> >>  					       struct strbuf *referent,
> >>  					       struct strbuf *err)
> >>  {
> >>  	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
> >> +	struct ref_update *update = transaction->updates[update_idx];
> >> +	const struct string_list *extras = &transaction->refnames;
> >>  	const char *refname = update->refname;
> >>  	unsigned int *type = &update->type;
> >>  	struct ref_lock *lock;
> >> @@ -776,6 +797,9 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
> >>  			goto retry;
> >>  		} else {
> >>  			unable_to_lock_message(ref_file.buf, myerr, err);
> >
> > huh, so if if we have a lockfile error due to a case-insensitve
> > filesystem, does this mean we print the error message from
> > `unable_to_lock_message()` and the new message?
> >
> > If so, I wonder if we would be better off skipping the former since it
> > could be a bit misleading.
> >
> 
> I would say both are necessary. The errors added here are more technical
> and really talk about why we faced an issue. The error in
> 'builtin/fetch.c' is more about guidance to how to overcome that issue.
> 
> Also this error is client agnostic, so we'd add the error here for users
> of both regular transactions and batched updates. The error in
> 'builtin/fetch.c' is very specific to users of 'git-fetch(1)'. So I
> think both hold value.

Ah ok, I was orginally concerned that both error messages would be
printed when a reference update is rejected due to the case conflict
error. I see now that the "Unable to create '%s.lock': %s." message only
gets printed if the transaction actually fails. With this change, a case
conflict error on an individual references in batched updates doesn't
result in the entire transaction failing. Thus, only the new message is
printed. Makes sense.

Thanks,
-Justin
