Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC8A37B
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565468; cv=none; b=knD4m8eklCrG36b30pSeTiAMuBAgdDu3yzU5iQiaPpjKCpgW5OCz/PXt8PUQ6IAIlbj9j4l6xV11PYKz9OmO+KivD56MCpJ7PaPK9fI/+Wjsc3CcS0ioUwDB7MSSjyNS/L2PA3x6r5C9WNu/yT1MBc2rXLM0/9DH4vwsSBSZ8d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565468; c=relaxed/simple;
	bh=m+wao2r4KRRJqY1GoBSkpmUXoQ7tCQ+4mPzIk0N4USU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwbofget0+LZP7zJmRCKPox+Dj/kNWvxZGNywFIRU7c7AlBzwZT3H+ljfUndYStcPzdA3uJruRO+DC5/zO6kgHvICCC8JgqA3M25yTxPQsQs2fOYxdW567v8GZ3HThL6RovxC3TI3r9YH324XUTi8OT2jDOGm6Vs13y6A9XDD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TwUm61qi; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TwUm61qi"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a0b57059f0so394695ab.2
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726565466; x=1727170266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+wao2r4KRRJqY1GoBSkpmUXoQ7tCQ+4mPzIk0N4USU=;
        b=TwUm61qiSzD/EUwmsuNUGjeskhK4bWpbJCuyG6Y6vX1EOgnKluwZ1wZU2KtQKCB4ik
         1KZWKVeH14dbKFh05YxhMhLLnz/s9zneq94AsHC8IeILZ4oQbgljHriPVYSC/K1WJ3Fk
         vYcox/CKB4FegavJGYwqPIpvejbES7PP3WHm9Qm3qS1Rf/brBQIlnb/uibFbMI723Dwl
         5zem3BWpvHx1ZQacODdWtWf+r6gmx5uy+q+4OsWjjJ5VbOP2AgWiXpjHgVLdq7d7LpW7
         n4/Wmq0CVJkr5XB20wCVXweaLUlBJPRmNKWPcS+sJH99yZxvQkjdJts0uHs8hDSGItLO
         Gb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726565466; x=1727170266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+wao2r4KRRJqY1GoBSkpmUXoQ7tCQ+4mPzIk0N4USU=;
        b=Z6VaxRNIRWpNJ6TiOoaZyY3y7fMnlONZ0xk2/rWQdoDs9t5hfwniGQBHHOxUjdbVPk
         /p4K1PnGHpL0IAu78ZYJzQz+Vs6v9Px+jknepMKN5x9AVm30g5b5wFDd/0i6+GGZVviS
         rf9AkmwCCvccLQZfiJy7yb8t4jXvbT4yNPh3cFjWWZ13mUNz2riVKhGtWZjTJUY68zNj
         PJphEqek8GBshKBOzPFr764jmTQrwGIRJCud+OiZv6K3Tc0KVjS8N8tE25BMw1btGmzW
         vpjdOjosUg2rCRse2nPw3IBFDwuzNM4qu7IPZG0XDznr0SxKAkB446fHMLds2fqIK9Qh
         ZZZg==
X-Forwarded-Encrypted: i=1; AJvYcCWYG5XDAewJYxSGQMl9aUtMpRTJUuZH+BzROOv6vDVfq4mgbav1nwldToD85byLI2+tfCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVaJ59uZz7bYjmq5cBJcOZmAv1rKZmC9Xw86Q1YYBvq3voRTv9
	rnGbLxdy0H73azjmx/XsDyUbs1uMXG9i9nlrsIowzgtjCkb4gJFPfU2IwcGscCU=
X-Google-Smtp-Source: AGHT+IHRFoLrOamFT/Vm1KtsRA1NoovjD4sSkKTIPkqcJF1OvhlJW6oRU5bCQhT2y4gbRpmXZE5FdQ==
X-Received: by 2002:a05:6e02:17cb:b0:3a0:9159:1561 with SMTP id e9e14a558f8ab-3a0915919b7mr98779305ab.2.1726565466529;
        Tue, 17 Sep 2024 02:31:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a092dfdba4sm21397305ab.8.2024.09.17.02.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:31:06 -0700 (PDT)
Date: Tue, 17 Sep 2024 05:31:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2024, #05; Fri, 13)
Message-ID: <ZulMVv4ZEVtVxTG9@nand.local>
References: <xmqqwmjerqvl.fsf@gitster.g>
 <ZuiJjQCZ23DznwJo@nand.local>
 <ZukiD4-GP-rcUWnS@pks.im>
 <Zuk7Fvo+a/e6UObo@nand.local>
 <ZulLfjtfuyDkeQJg@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZulLfjtfuyDkeQJg@pks.im>

On Tue, Sep 17, 2024 at 11:27:26AM +0200, Patrick Steinhardt wrote:
> On Tue, Sep 17, 2024 at 04:17:26AM -0400, Taylor Blau wrote:
> > On Tue, Sep 17, 2024 at 08:30:45AM +0200, Patrick Steinhardt wrote:
> > > There was also the open question of whether we want to rename the new
> > > `_fast` hash functions to `_unsafe` to make it stand out more that they
> > > are indeed not safe for cryptographic uses.
> >
> > I am fine to rename it to unsafe_, etc. But the more that I think about
> > this collision in loose object files, the less I think that it matters
> > in practice.
> >
> > We would only hit it when trying to write a loose object and racing with
> > another writer which is trying to write that same object as loose using
> > different compression settings, which seems awfully rare.
> >
> > Perhaps there is some use-case or scenario that I am missing, but this
> > seems like a very rare case to disable a check that is otherwise useful.
>
> What I don't understand: why don't we just decompress the objects to
> compare their contents? It shouldn't be a huge hit on performance as we
> basically don't expect the code to ever trigger. And it shouldn't be a
> lot of code either, so I don't see much of a reason to not do this the
> correct way.

Alternatively we could avoid use of the _unsafe SHA-1 implementation in
the hashfile API only when writing loose objects, and skip the collision
check entirely.

Thanks,
Taylor
