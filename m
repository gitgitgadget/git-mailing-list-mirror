Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF64756A1
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714839; cv=none; b=luOfXWerJuIoSPLwtTty794DcEfe1iUUCLbcTGG2pDw1UWN4PjMILa9dQIj8M2TdOfx9VOphw66Gp+1PGl39A+Y4hCSxfaj91VT9URd0Scx3JCyVqDPFIDgg8VGifLwfjFqA7Wjdf7KC2HSENN5gNyfvJw6vEqMLxDCFxubJrgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714839; c=relaxed/simple;
	bh=l2VmUZiYgTwuY+Nqr/5H0SV0BSnMkXROsA74LPkZaYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+OzIvMxasBSEifS3CuidY/KMVqPHwpnCGNHU56hg+gRa342WmSkTDlAkLaMkCJ7nHtu4QcFQCr6Duk/tKin+3p63qqv7iuBVSJDxscCtNwZ66C41cilKhxLRpUttfXC+orb17vkxupMRYiC5vimlPB7p+zlJo0Vs/cWfC828mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mN/62tIU; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN/62tIU"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4960fb63c75so550328b6e.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 06:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714836; x=1787319636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TbnuY3Fj/HMQK5uvqsuRlzRUQTx6QQrs33jWn8x3j2E=;
        b=mN/62tIUM19HEF4ldgG5yecTW5DgZEu1ivYgwXh9gOl37Q/erGNVzUkhELerSfd8aU
         II2mYxk7Mi7KPkvKnaDjHfc2IGIuTb3pyZBsY4FEo9MUqaZo3/NGXH13XBTOfyt8NE9+
         SSNGF7S7ihbvHxDVkncJ2d4cboy0EhZ4IVdCqhEWosvkJGsrTO1rodIkkj3g/AgN5u5W
         6IyaXaGS+5DWjF9ipXN1FvFttrJ4vraDqZiuZFsvn2m2P1urP/iIVxENI1sH9QV/6Tap
         eu9dOG8rAP6AduFMfMi9+ADDw3bYcaGiCU5Z0E8x2n9t217I4Ul6ErSz5TTtJvXejvrj
         lqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714836; x=1787319636;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TbnuY3Fj/HMQK5uvqsuRlzRUQTx6QQrs33jWn8x3j2E=;
        b=aJiM77QjD0j934DOlQ7XHM0q4stIQNmO+Fh471Tu6eX+eVjWcvz4DAG1n6gOJ1URqI
         F/VnEptKIYvNECh8n9lT+jhO+4KMKzOLYQLEQJNEn7NVVhjIFNDbX3xPG2wN3BtG0LlO
         unHef0OzF3aVuqHPKf5bB1Lh0UUIMy0NfULSV95khOAFGtq04eD66ai8ead4gbiziH1L
         0CFhpWwg2uVFb0uh7UdetfEd+6/nw1dXWye3mKQu+g4hh9YoCRvot5DdNEhRRbUIbNQS
         TE6LHgf0xRq/bIwH6zcwgn5H/YuPsb8MUYpby+AocxOIyxBxm9j3nn1IJ1cC8ZcV42BE
         k5hg==
X-Gm-Message-State: AOJu0YxRjyvAOyRhv6WuF/W2JphQmPinsEcBBPTgkT7PJTuu7NmOHxqO
	fAboZOYiN10DvYQfN5lRkgYxUvCiVBROe9p5d0nGjuhxwvGAEPlSuG/64xIKhQ==
X-Gm-Gg: AR+sD111LQmKXsDns5XM/4LPRyxe2VTGWShnH8DX9QEa2XxWwSVvg7b/KSBCuGiH3wm
	0N4O+za+6jBsob6sSEVdi2mTLpHtuzWAt1so906tWhuopmUTZXkNFgZ14EOSnod8hOuRciVaNxT
	xJSjmQ8WxX9aps+rlUJcxC/TLsozqrN8EI1TOZALFMHjFok91KuVO8Ywab+bIYcFgTV+bJsQnD9
	4EZlXDmtiMqfDnjfkjG4CSl/qa/noERarb2p928Kh4aGij179Q5YNfQVaAS5g4Kzwxsvo8jx7gB
	V/fFe44JLsX0J4YC8cjmqSEN7pSfv1gxgaayeglLgzWNC3levUkc1rwc7mROgUb3eLoc0eAqgX9
	IypyxIhqoYB3KZ9lHiYzppfMnK8fFTGn4lN9CbQ/vV+/NhD5GO5XHfCNEsMo3/LXfNpkInyDzVI
	AS4lteH1K+P0RLr/EIs7sNrOPgz0kTirJU0h6SpbMnh+RIaW7ErKJn9yAyZdNG2MCV
X-Received: by 2002:a05:6809:2cc:20b0:4a4:ade8:a287 with SMTP id 5614622812f47-4b241ccc905mr3475446b6e.13.1786714836218;
        Fri, 14 Aug 2026 06:40:36 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d956a41sm891340b6e.8.2026.08.14.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:40:34 -0700 (PDT)
Date: Fri, 14 Aug 2026 08:40:32 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 9/9] odb/transaction: add transaction interface to
 write packfiles
Message-ID: <an8YSE8iIDXPSkH8@denethor>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
 <20260811175415.2044235-10-jltobler@gmail.com>
 <an7XAyQr7PrPlAGO@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an7XAyQr7PrPlAGO@pks.im>

On 26/08/14 10:51AM, Patrick Steinhardt wrote:
> On Tue, Aug 11, 2026 at 12:54:15PM -0500, Justin Tobler wrote:
> > +static unsigned int get_unpack_limit(struct repository *repo)
> > +{
> > +	unsigned int limit = 100;
> > +
> > +	repo_config_get_uint(repo, "transfer.unpacklimit", &limit);
> > +	repo_config_get_uint(repo, "receive.unpacklimit", &limit);
> > +
> > +	return limit;
> > +}
> 
> One thing I noticed just now: as the intention is that `write_pack()`
> will be called for more use cases than only git-receive-pack(1) we'll
> have to add a way to tell the callback what scenario they are running
> in. I still think moving the unpack limit into the backend is sensible,
> but now we're not givint it enough information.

So we already have transaction flags like ODB_TRANSACTION_RECEIVE that
can be used to differentiate certain callers that may require slightly
different behavior in the backend. 

In a followup series where I expand usage of odb_transaction_write_pack
to git-fetch-pack(1), I was originally planning on using this flag and
also adding ODB_TRANSACTION_FETCH accordingly. It's probably a good idea
to go ahead though and start using the transaction flags here in this
series too. Will update in the next version.

-Justin
