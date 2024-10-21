Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144DD1C8FD6
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545070; cv=none; b=lIT4WgzLGWO8lGlrdUr3nDqy2SjkN5lNg29fzvfmiMMQAQHnSjmYWqvehvJSwvdxuvr16jY+NQwjciWz1jIZ+NkBmaUnQjk8EvigQNo4gJ7Y/fvwKb3e9qdxLVaFuYQvzTarWszNp1p74uf30+X2UArVNxeMNTnmQ04y2VbEjrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545070; c=relaxed/simple;
	bh=uV8Xi76XSfXvK4TRfBXo0Bf5xOn33FV8rSSPjuzG9ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcBYX2c6xeKHhLcKGwt8H76e2HLQR5UvzhpkouDneXKWHv061v2kPzuP8qA8Do45kLRUGBOVL4sem7GQl1Mvdz9V0JfOUFR1Bsik+AMxx8zqA1a3Qx2dYO9jvRZ3xuQBY42z0sLcbLqBOmE8VZn3B4L1Kwf1Hb/cMi1lvn5nv/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JUHeWON5; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JUHeWON5"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so1984224276.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729545068; x=1730149868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uV8Xi76XSfXvK4TRfBXo0Bf5xOn33FV8rSSPjuzG9ws=;
        b=JUHeWON53uD8dazXLRLnN/q0WLCEiU2vsE4DJBI6MVnjrZ/2nsz6DyvyfNF/NIj0Lf
         AfhZ1uvIsNGXxA2HoGvVm5vNlcy+On822TeC6aquYO49pg8i+F0IcRpNgW1XXty2i7OL
         A3TR5nhD7asiGgNFlnIJr5RXGccZBUOuN4N5IPpKNxlsa3nVdfNEQyistgSYjabbKegE
         zyL8RdkUtyiwkRhdyC+JYcupFEc08M45nrEFIxKcMBv/HQnr/sBZ7y25cT/kPxqhdonI
         gbCPfUbvdv8YBJJT8np+XB+9gB7j3FSDDTY0DIUd2jKAAQCxD514gRbCYK+q1rNs5MNa
         1rEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729545068; x=1730149868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uV8Xi76XSfXvK4TRfBXo0Bf5xOn33FV8rSSPjuzG9ws=;
        b=dnsdlbvKPXxFiyUexOUg5CmcX3vn06KA+AaOtcCSDrtRUHwNu1yRPz7pZa6FMOm8pj
         iNWHvG9hlLAjKGQ41qRoX9StYPx0oYWXhKWOWRVrA3Db3JEgzBJcoN6lx6496DQn6i+2
         WUtcmd0sRfESxpYjNYnZsNqn9bNkeR++agOj1mBs7tzxUmRZZ0j0Hk92AK9qau5nKKz5
         dZwmh2EEtbcQ28CCxa6etYPFGalzGu2oHaycB2oGBce2F3ec84EJqiBIyILyns6F0knt
         gdrcv+b41ctGm0UrXDueFDus1FjWT+aaSo0WsN3u5c23H6LBc5oC4ReuO51oJeOXjFqu
         SqWg==
X-Forwarded-Encrypted: i=1; AJvYcCXI/KtX7kBJQqKoTKQ85ZAKcppnF7820uOuaXpEO4J7tcWGQK7A5sjYkqS8r6JDBzEpvUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEjWKBMitlg6zej6XXt//dV9WLYn+JP9Ws0slTmmJOGBVbyftm
	S949hLbOUqTG5D3Ix+jDe3YpnM73/K5qar1h3nyrf+xhrxq6h0lfGfRH8YtU0R0=
X-Google-Smtp-Source: AGHT+IG9vs+d6CDD/zUb0GGmriS0s1EM557kg4MAnkE0la+DZZUHdN6flULzrwjYqsBUCYpYtu+C3A==
X-Received: by 2002:a05:6902:2803:b0:e2b:d159:8728 with SMTP id 3f1490d57ef6-e2e274290a5mr256648276.47.1729545068087;
        Mon, 21 Oct 2024 14:11:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdcaebbb9sm849669276.47.2024.10.21.14.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:11:07 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:11:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Freya Starshade <saoirse@axiom-networks.org>, git@vger.kernel.org
Subject: Re: [Resend] Re: Git build failure: v2.47.0 on Solaris 10 SPARC64
Message-ID: <ZxbDaiaSUgRa3WYd@nand.local>
References: <db95aa3f-f270-4939-ba3f-a964d46e2325@axiom-networks.org>
 <ZxYXNTjRYkVaQaOl@pks.im>
 <966457d3-c6f6-4028-bd28-da73a0296679@axiom-networks.org>
 <ZxYgDu2vt-qDqmqr@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxYgDu2vt-qDqmqr@pks.im>

On Mon, Oct 21, 2024 at 11:34:06AM +0200, Patrick Steinhardt wrote:
> > > Could you maybe also send the output of `./configure`? We do have a
> > > check in "configure.ac" that tries to find out whether your system has
> > > `inet_ntop()` or not. Maybe it is misdetecting the availability of that
> > > function on your platform and thus declares the `NO_INET_NTOP` variable,
> > > which causes us to pull in compat code.
> > >
> > > Out of curiosity, did you try running `make` without first running
> > > `./configure`? Many platforms should work alright without having to run
> > > autoconf first, but given that your platform is a more on the esoteric
> > > side I wouldn't be surprised if things didn't work there.
>
> [snip]
> > checking for inet_ntop... no
> > checking for inet_ntop in -lresolv... no
> > checking for inet_pton... no
> > checking for inet_pton in -lresolv... no
>
> So yes, indeed, your `inet_ntop()` isn't detected. Does that function
> require any additional libraries on your platform? Searching for this on
> the internet quickly brings me to... a [thread] from our own mailing
> list. Looks like that patch never landed.

Thanks for digging.

Thanks,
Taylor
