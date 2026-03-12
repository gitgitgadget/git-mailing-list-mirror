Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BCD3D76
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323889; cv=none; b=a4F7JddHRNb1Vdsm4Qr56mt1ufmUG28DFP5hQquUwYTtg6qtbxEyLjdv8kDK1dST6KJHPIfa2wOaUrBGCYfx8CFXTG1G4lBSBNJwEvXBN1HbM7+crGHD4aYOeDLextEApTh9ASSW42pBS2onJd9bqCWopVe+VL13NvRlFZ23bQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323889; c=relaxed/simple;
	bh=jt+Z8qMXpUEuqXO08aAf3RAQoYdIvF7YJOeDkU4ER0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvpslh1jQGq0r9O6fXqJ0xFPaSJ7NrcWt2sjt+jvnYe6YGmOgS1CpywAb+kTHpSEeqyi57dwOlz69bpF2n1ZqHl8LUxK1gJM2oEUtFw+b+l7rTHSBRbjNeI8BnguUnfecyycnQKEdfBCigdWvoYLq+4BMollMxSIE8k9dJtV07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jkx7EN3z; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jkx7EN3z"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2be1c918173so1647867eec.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773323888; x=1773928688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oJKf8jPbcL05mN8jUThyiib7Zzt9tjoDwO7nvCwxCs=;
        b=Jkx7EN3zgQ7VyuB7as1eMfacmIPkJXDz+4Vonoqywq3ktR0AaWMsQoKudg2Ee13oh9
         OwxmmxiXvvWT0GDABPpsBFmZs4qGuxZOCO88U+b+Rg6lMoelKwVby6AS0GRqLPUBOuJ9
         WumlkNEsiLkoGfM3mRa/fi8JZXMYTgw6d3DdtjdMipjQzguxW1oS5NBGeyXFVU/ERHmB
         uZ0U4Y2FFU2Ck40Xz77SemHcGBfAxgnb4R+Og67xJ3XKji+rmpyaLay0Em8ZttqmbZgV
         f6uOEpP6sflEKZZaiJXAqyRZJOwMTl0WA9NkbOM6zlf/vl7WAs8NuLowvGb+4YdJR3dh
         RIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773323888; x=1773928688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oJKf8jPbcL05mN8jUThyiib7Zzt9tjoDwO7nvCwxCs=;
        b=cmFXbqOQ5o1VqOxXYeotrsHxHvYgS6IkdbWFjJ9ewCVzAf9n1MVRUapg8RlVZ0IeAk
         bHBZxvzFE6T6jt665swpFJu03DJz1BuXKY1dEzWl2WIMn5/RD8JzbJqBKLlLGOznOHtY
         tYalZK/X9EClmrLzDNvYtOq/3WVKqMGNFrfqI+Lx9gVkq3n3firQhafg/t1nO8IQ5qK7
         jcW18oKutWzr9k6TPGh2fZG6474YLBvkcMFVkVxPNw1Rp9pX+lDxeMaD3pv8b+epKyeO
         CJ0twMXH96T71xhu1YbQGArRoHIeSqMAjTyS2ZZxKYFt1mBuQfgCDRQPmpf5rwVdPkR2
         mQOg==
X-Gm-Message-State: AOJu0Yy4fYAgViYEws6J/4PGTGUp6ATQN7tVjvf2AuqkQNWM5u3PcFqH
	CUTa568fdhxPQ0r5sFGbzp77Wvw8f2D5kdWD13ZA0K0uMWqfzlTKF36f
X-Gm-Gg: ATEYQzzq/4jY6zLa+Zx8+OBmdZDUgdLDVvV/kSJPKkxb1/gCCOJ3khyYBWIWrp2sX5r
	mqZeL7NBTE5weRImRHzqeM9oVEdDdya16od/ni0BBh8Bmbkl8tLZ3pkewmd6jJL3z6ygExPiInz
	07L4zExDnJoUFsRtM1tmbocP0+y6535GV7B/EMX3uYbmPPRPkwyb+Uc1iI/FfVi3D6b1Nk1rGDB
	27300A4enuPnAye6E1roA3zwPlA82B4IEqQZ1Z65hj/xC6r8bGXdKu02s8fKmIEOJPhu7elnRFb
	xZ4flPfzEU+dZ7pGXr6LHBF7lW+kqOy8k1Hu9Esg+Nc5IrgKZXUso0sNM1qu9V3df4nc4Paprpg
	V1+g3xrBobmHIsW2KJZwgnA+qa2nLKXAZHmUhs2UXgHkS2ieZ1XC/SPpyRApqUYwD20EapULe7i
	vnFkE/Ghiq45iF0VjT
X-Received: by 2002:a05:7300:bc0e:b0:2bd:d3f3:b0be with SMTP id 5a478bee46e88-2be8a551951mr3176634eec.20.1773323887486;
        Thu, 12 Mar 2026 06:58:07 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be9df326f6sm1405064eec.1.2026.03.12.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:58:06 -0700 (PDT)
Date: Thu, 12 Mar 2026 08:58:06 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, 
	christian.couder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v4 2/3] gpg-interface: introduce sign_buffer_with_key()
Message-ID: <abLF-08jpqT8jYpp@denethor>
References: <20260310201116.1130160-1-jltobler@gmail.com>
 <20260311173147.2336432-1-jltobler@gmail.com>
 <20260311173147.2336432-3-jltobler@gmail.com>
 <abKT_50GVgBcj7op@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abKT_50GVgBcj7op@pks.im>

On 26/03/12 11:22AM, Patrick Steinhardt wrote:
> On Wed, Mar 11, 2026 at 12:31:46PM -0500, Justin Tobler wrote:
> > diff --git a/gpg-interface.h b/gpg-interface.h
> > index 789d1ffac4..a32741aeda 100644
> > --- a/gpg-interface.h
> > +++ b/gpg-interface.h
> > @@ -83,6 +83,13 @@ size_t parse_signed_buffer(const char *buf, size_t size);
> >  int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
> >  		const char *signing_key);
> >  
> > +/*
> > + * Similar to `sign_buffer()`, but uses the default configured signing key as
> > + * returned by `get_signing_key()` when the provided "signing_key" is NULL or
> > + * empty. Returns 0 on success, non-zero on failure.
> > + */
> > +int sign_buffer_with_key(struct strbuf *buffer, struct strbuf *signature,
> > +			 const char *signing_key);
> 
> I think this interface is a bit confusing, as you wouldn't really be
> able to tell what the difference between `sign_buffer()` and
> `sign_buffer_with_key()` is without having a deeper look. Naively, I
> would expect the latter function to be the one that actually mandates
> that the user provides a key, but it's the other way round.
> 
> Would it be preferable to instead extend `sign_buffer()` to take a flags
> parameter and then introduce `SIGN_BUFFER_USE_DEFAULT_KEY` to make it
> fall back to the configured signing key? If so, we could drop
> `sign_commit_to_strbuf()` completely.

That's fair, and this suggestion sounds completely sensible to me. There
are only a handful to `sign_buffer()` callers, so it should create too
much churn either. Will send another version adapted accordingly.

-Justin
