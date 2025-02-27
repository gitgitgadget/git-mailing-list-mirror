Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FED45945
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740617814; cv=none; b=GpP/zaArHPxO9hdRDV7mglZ8WvKpZ8B2uI9glJYxVuL5l2XZX8iYBr/7LV+1yD2JOOW0lwIJ4Dgx8mawWQn69gLmrumkH7IXMQiZn7mDgZvINSJ2zK97xU6cIfjqZe83p/4jt5HQ1ZQ/NoXZElKXR7NKqMLuQUiGmKHYvnsydfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740617814; c=relaxed/simple;
	bh=UfayfJ/KMQ30uaPBxpWWk01TQBkcNMZcpetkw7iEnuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLUZSD3mX12b0GdW7+AiwH+35vjbg9fVtx6j/W7UJEli0xYH/uGJgRaV+AH2VokFPfpuBlZwgzl2xZtiQy54v/GtcAi2DeAU8NPJ8wpx1s2hARyAYHT+uGUOMeZAcxRe3QORmF3x/AIBDjpMNW7hjRtLOXNPdOVZsEdCAiOsKJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQgCxNQN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQgCxNQN"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2234daaf269so7579445ad.3
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 16:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740617812; x=1741222612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2pWt8MljxK29pkaPYlMXYEt2VqH1XuLL9yt7i7xRcmI=;
        b=gQgCxNQNNbqoZZNPUxCC1KKqwctxVjEshYiExYrzMUriPFxmzKg+oobCCkZfKIWeCe
         Dttt/huys7TlMkyyzmQjpJgwmsjXUxVrMEYiOgdQ+3uwRKreV4b8ZxB0gP6vxX6e+5gD
         BbCot48YyDD/OqfeSdeC0kTJaFJRMiSDfscUZ/W7PSoNEdcGfvoF8irQdTaqSVKHFZ0a
         2wueLZ1l9YrGMrwRs5G7dcocOikg7ntH8o2Wg8irZU23uvfVrFpqNNfKK5UwgliyYlRt
         4OW9tesXYuQi729nwGKX9HUKoIHkSsJv3C/mHa1aTtxpZLhYqtTS4IiqXt/hs8/IlhnK
         u2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740617812; x=1741222612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pWt8MljxK29pkaPYlMXYEt2VqH1XuLL9yt7i7xRcmI=;
        b=lFmO3b9VQFfuTSsdkP/YMR5t23+NJNYzxOLjRBUjkjn8TlC6esO6Kl2TdEwkQ47V7u
         I603MNga44KuKICTZkCi+NtnjT51+0DdezshkeCVSmA2yVnbOsrawP6s9Rg8FPPcDuh4
         2nxwHJyyGbIHogukbbsNwfizaTgJWtkrdq96nKOP6a2N+WziiDoLma34IBN4d5arzMEr
         C/wrn/Kmiibc0Csfc4PU9tyhrc88eG0i7OWs9JfQLedOwsulObRwf/42AyrIFdsff2bo
         7114Hvzdns0IWMhXGZ5vpvfT1ZMkEN0hMCUTWLBCJx7hEjcM2dcljIu2nI90q6dfI4SD
         Q7wQ==
X-Gm-Message-State: AOJu0YxLdH90AyDR0LkqiLQvYFTOMhzaqlRgHjkt6ndCQWsMt24FSUVo
	Zn1CxPY1oK0V9mKFd00VpNmVmeyHACoGFqCWE4bEZkEEzgniBdzL3jXmLA==
X-Gm-Gg: ASbGnctRa9S7PgDD+FY95QG5UP8kUhx56M9qZmFBYCXJVfliD058tTI9ESBl+rkEma1
	Px52WJh9GCrrz/zylWJg9CRG/bVj+EQ3F7LI9hKnqN64WL4K8ZmcUmJUs/fmg5t1QUufB1bVWJU
	d1e0hwV/fg48J3Pe90aXn+XhSpPTLp5TTyaNCCtjAmubJx6ZujMEX9YNDvUujicvhqhdg3ih3vf
	inFO6h46nivr7EizcKWokZJgG/YgXFmbaz5dTsvHE30hiAzqLx+LqZ+xxVomgP3z9zxUGt6Cvyy
	g9oYBPD85HuwexRYSFYCyQ==
X-Google-Smtp-Source: AGHT+IFZuxbh/QtUV4qKOjz14UGEd9mtvCl9XemO0iPCs1UZ5OKXTkOb10pQ1vFLmGfAX1FR8cpJPg==
X-Received: by 2002:a17:903:2f88:b0:21f:3abc:b9e8 with SMTP id d9443c01a7336-22307e70152mr157038395ad.43.1740617812340;
        Wed, 26 Feb 2025 16:56:52 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504e1976sm2657235ad.184.2025.02.26.16.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 16:56:51 -0800 (PST)
Date: Thu, 27 Feb 2025 08:57:01 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 3/9] packed-backend: check whether the "packed-refs"
 is regular file
Message-ID: <Z7-4XRCVvLjFCFR8@ArchLinux>
References: <Z78bmBSrDR20GY6g@ArchLinux>
 <Z78cAU69IUSDgpuD@ArchLinux>
 <xmqq5xkwd042.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xkwd042.fsf@gitster.g>

On Wed, Feb 26, 2025 at 10:36:29AM -0800, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > +static int packed_fsck(struct ref_store *ref_store,
> > +		       struct fsck_options *o,
> >  		       struct worktree *wt)
> >  {
> > +	struct packed_ref_store *refs = packed_downcast(ref_store,
> > +							REF_STORE_READ, "fsck");
> > +	struct stat st;
> > +	int ret = 0;
> > +	int fd;
> >  
> >  	if (!is_main_worktree(wt))
> >  		return 0;
> 
> I do not think it is worth a reroll only to improve this one, but
> for future reference, initializing "fd = -1" and jumping to cleanup
> here instead of "return 0" would future-proof the code better.  This
> is especially so, given that in a few patches later, we would add a
> strbuf that is initialized before this "we do not do anything
> outside the primary worktree" short-cut, and many "goto cleanup"s we
> see in this patch below would jump to cleanup to strbuf_release() on
> that initialized but unused strbuf.  Jumping there with negative fd
> to cleanup that already avoids close(fd) for negative fd would be
> like jumping there with initialized but unused strbuf.  Having a
> single exit point ("cleanup:" label) would help future evolution of
> the code, by making it easier to add more resource-acquriing code to
> this function in the future.
> 

You are right. Actually, I just want to avoid assigning the `fd` to -1.
However, I didn't realize that I would initialize the strbuf later.
After waking up, I have suddenly realized this problem.

If other reviewers don't have any comments for this new version, I will
send out a reroll. We have already iterated many times, if we could make
it better, why not?

Thanks,
Jialuo
