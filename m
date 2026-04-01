Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F1B2D9ECA
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052146; cv=none; b=hneJzf0wuKlxIJRdVNuFcR7yPmt+F8uG/o+E+tSC+5RlCDXf9/nBeIBQp7B/F907LgUfGwIbq7Tgu0N/pG27S4f7px9HmkNg1bFCiN+I0Ic4QvCkcwiOUOiKdwqPp1CvCOdot4C1mRmcpxfxUBimTkuiR8f0VqCNlSOVuycascM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052146; c=relaxed/simple;
	bh=edtwu6qNVPAmHWrNzUYRuaj7Oq9s1zF76oLOZZBpUDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzthQv+seewDAKON4h+X9G4506vv2SpoDnugMNR2njHLc8zmMGBf1V5bawxV4ylqywdJ1qjHgsSBRNIru8PWsauIgae8IOFpNOVfAMmqVuJT1G8TWC/t2tFKVSrtPh/iUdVb4YMJR0ZPd6zENh1rLx1SsHAS7UTJpBwAIkpFtaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCy3rDMs; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCy3rDMs"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d86eb7c854so3658794a34.3
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 07:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775052144; x=1775656944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJCPnFobw7iG7rwa7PKr4IPvELBVUsgA49LyAlO5i/o=;
        b=YCy3rDMseh4dOc/JOov7bfo/KXhT/cLelKtiu+P8+beAVvE6zQxKI7CwIB4N5c6Yxh
         w07FDNTMHjJl2SkgSbsjisYRqocxBJyKp/3zMkP30d8BTbdWxR7diys2Ye0YSFOSJOv8
         NAujDC1xUYT3sgFrT21kYZO/N3r+CaevYIXoU+l5zQI4rVopo6RqihAclBqRHo9A40q/
         70SIXGH4YdtRu4Jmou9ZgKrozicr3orRfOlHqOr8rAI4OdFRddVScjfE31DMrxje1aAZ
         MpOxOhDYqApeMEd6S3ky9UIdRt3R1uxl4KeOjjMF0bE4NFOz0f8ng8CeFjnLu/Ml4zFb
         2xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775052144; x=1775656944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJCPnFobw7iG7rwa7PKr4IPvELBVUsgA49LyAlO5i/o=;
        b=pTSqWN7wHSmCQP/J6OI+Bc/y6l0+hg+kIc1U3fNSZqV8DciFYNJJjC7UKZTB4lbUz/
         J8pPBNw/UQoeqp+qS6dC97TLjzw8l/lslcWPh2xe4FGvhnFk7G6OyuocCtCe1JnN5J0f
         cI5OnmL6bPOiTEOPmlSTF8coDjhCX2/ooEFxWgn8GIYj/zfrO+n2zDUuPC2IzHyGHjf6
         5sJE3vok/Uxlpmjyv1xajh+/VvFa5vGFQC36gP6mQAR7ae2Ir5/FgEpebphrh0ArPsMT
         ycGf1h9BOY2h6ipS6aR8Rk2pUDH1EONF1KUgZtptJi5XDL3azmfprTUAzouSkUfnlqr5
         VYYA==
X-Gm-Message-State: AOJu0Yy4YQm23RymiFwVAGf4oNFWLDk2/LS2xANHf7zmxIQaSVP2J69I
	q/ws9+t0TYSCjEsiUtGZjvaldLWRvbf9Jajv1fSZ+cNf/no3QjrM2nMVe0OcIA==
X-Gm-Gg: ATEYQzy8M/GG/TXBOQp33MWQJ5N6U94MYuN/byFPjMYrsHFq2PCQq73VxmoMySBFtSh
	R0cfCindeHpI1pY8V2/NyXeIKhr2uiZmTsIBdQhIPT0z9S0k1jaD/Y7w+qVjQYQfs16dKdOTSji
	F8mfYXbf9JmfjgoheViLzn3eitAyJ8rix9JP+zt9zL9XHXo3eaipXTdBP+IPJcQgTvtd+He23R/
	X4ozvqD8m+U9s3+rkVvnO5iaslk+YmKC6SynDMMNow7IQi9zqhGK9XghB691iFbX/tfT45mVPcw
	owLuxzSiP4QV8RIMakeBs9OVwYCOooucPqZxActHT1Veo27yIAZNzwiGqGgX8shaiWL6+x045wL
	pkJkEQPiHFV/7DQdVbLZE8EPOLFB4JR4K5Ws/0GGY6n6h1XDG19sKNmQH88TnyZYu4Mf9LKSOWO
	h5spkPnZcpNLrQOk/f
X-Received: by 2002:a05:6830:349e:b0:7d9:b314:1457 with SMTP id 46e09a7af769-7db99429971mr2225812a34.25.1775052141041;
        Wed, 01 Apr 2026 07:02:21 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a33546csm11644457a34.1.2026.04.01.07.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:02:20 -0700 (PDT)
Date: Wed, 1 Apr 2026 09:02:18 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 4/7] object-file: remove flags from transaction
 packfile writes
Message-ID: <ac0irp8GJSrSD8GU@denethor>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260401030316.1847362-1-jltobler@gmail.com>
 <20260401030316.1847362-5-jltobler@gmail.com>
 <ac0AROkfM_GQ9fEW@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac0AROkfM_GQ9fEW@pks.im>

On 26/04/01 01:23PM, Patrick Steinhardt wrote:
> On Tue, Mar 31, 2026 at 10:03:12PM -0500, Justin Tobler wrote:
> > diff --git a/object-file.c b/object-file.c
> > index f3038756fc..f317a24ccf 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1412,6 +1411,38 @@ static void prepare_packfile_transaction(struct odb_transaction_files *transacti
> >  		die_errno("unable to write pack header");
> >  }
> >  
> > +static int hash_blob_stream(struct odb_write_stream *stream,
> > +			    const struct git_hash_algo *hash_algo,
> > +			    struct object_id *result_oid, size_t size)
> > +{
> > +	unsigned char buf[16384];
> > +	struct git_hash_ctx ctx;
> > +	unsigned header_len;
> > +	size_t total = 0;
> 
> One nit: I think `total` and `size` don't really give a good sense of
> which variable tracks what. If this was instead `bytes_hashed` and
> `size` it would become a lot more obvious.

That's fair. I'll update the names in the next version.

> > @@ -1666,18 +1683,28 @@ int index_fd(struct index_state *istate, struct object_id *oid,
> >  		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
> >  				 type, path, flags);
> >  	} else {
> > -		struct object_database *odb = the_repository->objects;
> > -		struct odb_transaction_files *files_transaction;
> > -		struct odb_transaction *transaction;
> > -
> > -		transaction = odb_transaction_begin(odb);
> > -		files_transaction = container_of(odb->transaction,
> > -						 struct odb_transaction_files,
> > -						 base);
> > -		ret = index_blob_packfile_transaction(files_transaction, oid, fd,
> > -						      xsize_t(st->st_size),
> > -						      path, flags);
> > -		odb_transaction_commit(transaction);
> > +		struct odb_write_stream stream = { 0 };
> > +		odb_write_stream_from_fd(&stream, fd, xsize_t(st->st_size));
> 
> I would assume that `odb_write_stream_from_fd()` knows to fully
> initialize the stream, so zero-initializing shouldn't be necessary,
> right?

Currently the `is_finished` field is not being initialized, but there
isn't really any reason we couldn't do that in
`odb_write_stream_from_fd()` though. Will update accordingly.

> > diff --git a/odb/streaming.h b/odb/streaming.h
> > index c7861f7e13..e5232cd4d1 100644
> > --- a/odb/streaming.h
> > +++ b/odb/streaming.h
> > @@ -5,6 +5,7 @@
> >  #define STREAMING_H 1
> >  
> >  #include "object.h"
> > +#include "odb.h"
> >  
> >  struct object_database;
> >  struct odb_read_stream;
> > @@ -64,4 +65,11 @@ int odb_stream_blob_to_fd(struct object_database *odb,
> >  			  struct stream_filter *filter,
> >  			  int can_seek);
> >  
> > +/*
> > + * Sets up an ODB write stream that reads from an fd. The caller is expected to
> > + * free the underlying stream data.
> > + */
> 
> Hm. Shouldn't we provide an interface that let's the caller do this
> without having to know about the stream's internals, like
> `odb_write_stream_release()`?

I thought about doint this, but hesitated because the other `struct
odb_write_stream` usage sets up its `data` field differently and
consequently would have no need for a `odb_write_stream_release()`. I'm
probably overthinking this though and it probably makes sense just to
add it.

Thanks,
-Justin
