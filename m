Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45A4135A69
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336662; cv=none; b=I0skun6Y8nGtOzke2iZjhmH5+FJplOhzPHZZy0KBBu86kwCH19lLStSYIwkguaUDHWydL2fQBx8ChdE1ACgsJXlf6CzZLcVKv6oVn7AeyF5o4CsH5UUg2hn1xCVxOvZ9Iz842cc56IIqjqRNM8UxYcHpIRRam2r3Cd9Gk8KTS1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336662; c=relaxed/simple;
	bh=VlGTcW8FQz//AH8vDbKbn7Fj4ow09q8JxNz+STPwFkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mT7MohfsBXDDW9lbXaJmMR5PqAQ1xlh6FgwRT1Hi7O4rhwKNjHWts/hcs2xfOeDqUwS1yg3cpS8QweunrEdcvGLX2fxQ6lsD20Evfz3+PgcFCk6pbk3gsJqIwE7QeEK5DL3gBr7DpZ1Pjkws9fv71d83OgWbk1rGg9pjfTcGwKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5huuYIG; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5huuYIG"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7ec2d71059dso222798239f.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719336660; x=1719941460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvdfn3Z7xVYo4bLGIGVH0O5mcAoN8A7eFutCbY2YsCc=;
        b=F5huuYIGyrqQZV/Hc6NIZe5A2izUxFGMGLsdXqAJYO95m9d1zAChz8d/iCY8Qj4n3I
         iwwHhNyQg1WU6b5GIDZJe+GMUT2XedrW01mCf9S3N6iwE5K9YMi7g6v7RzVc6jFjEsWf
         tz6sPi0/1ZLNucgTMRBjhHjZasZnQPqYnos2RJxZ+/zKqlmuqYCwl7iDAHWx07+X8GhN
         LPlG68B1OpER3Q1GYWYv0JfLBG1gOMx1K+aGyLpRwtZcOZFIJG3iv3bdAqxCY3V934ND
         XjL1n06iCM5g3NdNZObZs1aejJpdbGH7TMx7hEEvHCmQwFBdSA077XgkWEm5LPb1RJkL
         0zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336660; x=1719941460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvdfn3Z7xVYo4bLGIGVH0O5mcAoN8A7eFutCbY2YsCc=;
        b=NPpDUQbOSHvWjSTaS4qa+UxXckRuA/iUW3FIhjh47SoVY8Sn3WsALdAvXpeSQDWRT0
         e0Y7viIGSaAdFnqaouD+QyJ7T4czI5DbtvZOVbd8kbBhdEBCn4CCOYGuCq4Dt/gBaSSQ
         Ta06uwCEtp7ComqgYxbBzbP7AEOyaSgAR4CY9D+DW8qan+O+R46udEjBFDdqgeQ0gWRV
         tYfSrYLgqoQCHdnGsHE1gC7W8dlzZhmvC9VHXsL5C8GJ+pXb/g9CTulIGk5JicPzxh6t
         2DRinyzEGR0VRVILPBJWC5jfirpenXzr/EePgV6CPCrGC6SrUfZjCBQ/eBpevqrmI0Uy
         Y2+g==
X-Forwarded-Encrypted: i=1; AJvYcCV+MoiOk+FLCXjDqP12OpQ1YLts/CudBx6qkZcxc7J5W4TqrgeRm1FVTBjaq5mLS8takay3KTBY18TkgplQAQP1PAEF
X-Gm-Message-State: AOJu0YzupbxIuD2sN7cfLSWgLOsWRUHj0pO9HaMXI/dInzmK9T/Zq5dt
	nAaPKIEQHC+lVxyOPONo+RM5roFUFQIXewoP/eiowVDCqCFVGij4AgEGJOnQaUXN1iMb8cSkH6s
	HwzjFXENz3O/DBaphdjPQr+y15sU=
X-Google-Smtp-Source: AGHT+IGqMpSV9p3vDUdz8o3rf2zHFn0alOXc6b6nI+Zp9f23UbBEHPfj1m2eLgF/Hyvc7EtuexFCxSj8GmLJY3k4YZw=
X-Received: by 2002:a05:6602:3f81:b0:7eb:7df7:461c with SMTP id
 ca18e2360f4ac-7f3a760d406mr798374639f.21.1719336659802; Tue, 25 Jun 2024
 10:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614102439.GA222287@coredump.intra.peff.net> <20240614102722.GC222445@coredump.intra.peff.net>
In-Reply-To: <20240614102722.GC222445@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Jun 2024 10:30:48 -0700
Message-ID: <CABPp-BHzT0dwsV3bZ4TX74JzQyhq6zHLdFtNQCxFdgEmGidh=A@mail.gmail.com>
Subject: Re: [PATCH 03/11] remote: transfer ownership of memory in add_url(), etc
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 4:08=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> Many of the internal functions in remote.c take const strings and store
> them forever in instances of "struct remote". Since the functions are
> internal and callers are aware of the convention, this seems to mostly
> work and not cause leaks. But there are some issues:
>
>   - it's impossible to clear any of the arrays, because the data
>     dependencies between them are too muddled (if you free() a string,
>     it might also be referenced from another array, causing a
>     user-after-free; but if you don't, that might be the last reference,

s/user-after-free/use-after-free/

(Read the rest of the patch and it all looks good.)
