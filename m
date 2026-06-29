Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298EF2E736F
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760241; cv=none; b=It0zl3ri/JzvdGo6kUVf9AwvRzQikPj4qL477l3nLUBUwcvfBHMdm0fYpt9NCq2w7SmlZ5j2vMtL9/xX5QnFqD1UUkjonhp4ZtJ4hiRBbv6VPHYpBgJlwRjamq3kSNMg/R/mAcCORrH7xEg1YD2LW2ZjU2zoRP8e21QHkPA9wbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760241; c=relaxed/simple;
	bh=Jo7JCpIvtv+tpaF7gLI7/J4gG0EygmUZ0zmkXtk7JEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DW4A/xECqUOrqfZsA224TzErPfUKRsVgEni1nxthX99xrXwDCfuekRZ5Py0BWQoFuuorK41N19htI/6j0QLuND3dTjEtsQ1JW8PvUIB/MEWYVztTdGC7d+EpoOk4JFuMaG7obJy7eoDM1KJWX7dCJwkpN0IwYoinK/1G2wNRxK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qOTf7AAi; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOTf7AAi"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e93f93ed01so2350788a34.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 12:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782760239; x=1783365039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=myojnBp1dXCACXLHUhNaDklG6HzD4H9WFv+1zLvADMM=;
        b=qOTf7AAiKmFysucAl6vX2q+QsR602ds4VnUI7U452VFgmzNXO+x8CglGs6m/M9VVsI
         GN63hAJKZeySO1tY7tQi5GJ+z6KR6Y3+IYgDNrpUYNVCRAb3qdpk2rGVpLNePj91IGh5
         IbrXRwlMZnrYtmO98lo6fIzHSi6FNozrNCY3aJFhuz80o3eNaZmZXSfHJWVSQ3wkI5Jb
         FpnWE+KV0sNS9JyPFU5q52PumJ/i8oBLDBIjBYmQWKLPipEJdJjT06jjDnJHsm2W+l5R
         qy5vhO4tmFbeXBshzNkFd5BA2incjNEJjc/g5nZ4tDP7aa1BehaIdmpbpkOHfwNSvjEB
         PFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760239; x=1783365039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myojnBp1dXCACXLHUhNaDklG6HzD4H9WFv+1zLvADMM=;
        b=VOHs/cv2g9FDRI+vqRSt5O+sCOnx7eozjFRJXW5mwU9Ag0s5k4dcQQ59dqWuWpukUq
         QMe2EG00HDsxartR4Wn1SM03exvp7TSw6MKT4Ny3LI0uySqdA/gI2l0q3eVXBLPzE+Fd
         iKgDt7aX+RioKeqBOc5peFBLOaUeK7X4gvbMeSQ81/yB5O/fJaEwSoVvKWAUWNX9m4DB
         T8fdprSR9EGo4uhp0CScaum5IV9s0MkrL76iD7+Cdt9NixsYhfAApy7bnUxliYB6YHaW
         f0cIjCCV3rug28FI42wZcnhzenDwBtBLRUXu0Tzd7bPpXI4VdKKTEbHmSx0dH3onc678
         U4nQ==
X-Gm-Message-State: AOJu0YxgvuzeYKQfuclywDYm+oPc86t62sNmkOCPSJsQ1r/hkX9rBX9d
	IrOGLEp5kfI7uabhTMxkNN5Mo63VrRXgKU8Bek7qwAwuLhTF3XvUrlGI
X-Gm-Gg: AfdE7cnySn02Y+trnjlVcVufzpWSzgbrIGxeNv2iLDoG/O1j3iKe0M/kEfizIoTscOx
	4lZn0WIIYZElA41Ce6jpVuYiGEJLeIK0BIfK+uBa/QhYU8QIlTr6DXaUsSIuFiXeRfjtzm2yNdc
	cdR/OBTXIXdHijmR1JwTieoxi2AhvBbciGRyMeeU9Cad8DMohhRq6eOP5vvV+BemG2YPQ/G7PDZ
	NOL/lr3PPQmcheqnT2RBgRsJqCkv27fnXPQUmkdkPu7T4N49LtsETBFwAk4zwowrDK9EKzDLFKr
	0e8i1ZPoHooX6PnbY6btQsaVrZnf9C9rMOw7Gfm5GBSb0nPBlah2c7z/H1pfQFfQRDXkbmTsPxk
	LN6yqNdb/4o3sjOlnt6ijVp7j5h9Se1+UgZkg4bORnKci08gP9jBYqxV387cRQY9BJCtJsm1ZsM
	Xxoex+gw==
X-Received: by 2002:a05:6830:268c:b0:7e6:fa37:9797 with SMTP id 46e09a7af769-7e9ec59b510mr601984a34.6.1782760239153;
        Mon, 29 Jun 2026 12:10:39 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ebf891e0sm505019a34.4.2026.06.29.12.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 12:10:38 -0700 (PDT)
Date: Mon, 29 Jun 2026 14:10:37 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 2/6] object-file: propagate files transaction errors
Message-ID: <akLByeT2no922sBX@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-3-jltobler@gmail.com>
 <xmqqjyrniy6r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjyrniy6r.fsf@gitster.g>

On 26/06/24 11:35AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > The "files" transaction backend may encounter errors related to managing
> > the temporary directory used to stage objects, but silently ignores
> > these errors. Instead return errors encountered in the
> > `odb_transaction_files_{prepare,begin,commit}()` interfaces to allow
> > callers to handle as needed.
> 
> "handle them as needed", perhaps.

Will fix, thanks

[snip]
> The caller of this function does react to a failure of it, ...
> 
> > @@ -1670,27 +1678,34 @@ int read_loose_object(struct repository *repo,
> >  	return ret;
> >  }
> >  
> > -static void odb_transaction_files_commit(struct odb_transaction *base)
> > +static int odb_transaction_files_commit(struct odb_transaction *base)
> >  {
> >  	struct odb_transaction_files *transaction =
> >  		container_of(base, struct odb_transaction_files, base);
> >  
> > -	flush_loose_object_transaction(transaction);
> > +	if (flush_loose_object_transaction(transaction))
> > +		return -1;
> >  	flush_packfile_transaction(transaction);
> > +
> > +	return 0;
> >  }
> 
> ... like this, which is good.  Do we need an explicit "abort-transaction",
> or is that implicit?

So this is currently handled implicitly via
`tmp-objdir.c:remove_tmp_objdir()` which gets registered as an atexit()
handler. As long as the tmp_objdir global remains set, it will
automatically get cleaned up.

In a subsequent series, I do plan to add `odb_transaction_abort()` to
the transaction interface. It may make sense to also use that here to
make the cleanup a bit more explicit though.

-Justin
