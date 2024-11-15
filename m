Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC83161328
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668880; cv=none; b=muA5UNv/aNBDx/ezlKGENtAbW7e7ucTK/P/RIFOziEp00rN0XIuxquKZ6QojM9NP3dCQhV3CtpyNiXPL2rlfO6HxBRujSkTzig3TSVuNhsYg5dSYOXxdenM+kdI4o4+yja5PqFxywrisc+h8FD0uN3JS1uohFGrlAkNhoorQXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668880; c=relaxed/simple;
	bh=LErjTI7mGHJbsFXiyyO29RTRI60gbrLVf0YKx0CXGtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QS8et3Epvk6mXkCkhcFZvpHgyF8Q6ECjX7Se8xDDwo8wdKTntJ7xx0k0QciRMBIgc03VY49XOKXlTsXMvWQjfUrCUm0FPWxT6OPbhj8eJ16eZNAja2JP43WVDzWJM3SA/B4Vs9IXyKf1ceReuvpZXU+DqB3yK9/ivi4DBarYQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeVzb7Ym; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeVzb7Ym"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c8b557f91so17264835ad.2
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 03:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731668878; x=1732273678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yvxvGSYW+zt9LPZAtywHTYWcDIc4+YQxh+SaKsl5ZgE=;
        b=AeVzb7YmeuqCK3nKh/yR0vP5QSYqv4jwQfLTK0OIctfvx0vbWshSmFNEOP1lUSAtxs
         u/YWfpW7eWrASpxrjRfzPVk7YaqvSZP4TLGQETZG3gh5zIOY5SehnipNxJWoMpxolKsE
         +3V0X+x8QFknAgSZpYK2+8qZtgnbdPEH1EkMl3+d8d8993i+VSKEcx+RIobCPsjNuods
         7QO8qU0Kz+NazP6UK6ejyg2e1LU/PlKIwIUSYWXNkikoVbpRALf5ADrA12XyYckLAiyU
         H2eizkaEtqnCESUqNufTXC7+rO/dYY76hY6k7bXjeAmFnv/FBNzU9iNJrg74Npv/EE8S
         PtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731668878; x=1732273678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvxvGSYW+zt9LPZAtywHTYWcDIc4+YQxh+SaKsl5ZgE=;
        b=rDPwuuUvcjZGnypD/JxhWyhrOVVZoCy41wnb11k4HDbeeJW7DGUli5PomplvQ9jq6v
         VEyh39T6oNzUBJQ0/OEeAnFxY5aYKNugmodCAcVIpepPOD9O1t20UMayGQ7ZvVUUpeZt
         AhxsmGE7sFk8xpHtBoDhmF2EnrOeK2S4z9hKxkraJ5qBevydPNZyw1BZnRvqpH/TnOGU
         CiaJguoReCahfU0TKl+bvD5X9kfyQEw5eivf7i3zugU40ggh/OtC448qsb6m3jN0QTKZ
         KO8fCXmvARXPbspgVwFLnKvuyEMw4uSXcbfoKc+cYEf0DxSLKpLaYfsGozyvSpzCZw4b
         vyDA==
X-Gm-Message-State: AOJu0Yxblak7fdF504q3WemqjLx135mqOZs9x/G8g+3/Z+mMgPuYf137
	OZamWodj+A+Fg1hGF+Xx2dUAdLcwdcxHKB6f5Ey0TtOj9Vq/0488
X-Google-Smtp-Source: AGHT+IHSrKZU1XIfgyoLRZmRkpzLmydQ6rspET7/JeiAzhoIkygU1jTJc5vQeUrjgc15c0DxakrQIA==
X-Received: by 2002:a17:902:e745:b0:20c:ecc9:c50b with SMTP id d9443c01a7336-211d0ebc084mr31407735ad.42.1731668878174;
        Fri, 15 Nov 2024 03:07:58 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f4708dsm9989795ad.199.2024.11.15.03.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:07:57 -0800 (PST)
Date: Fri, 15 Nov 2024 19:08:01 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 5/9] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <Zzcrkd0aetRjUHKA@ArchLinux>
References: <ZzYqoai8X_Wdtbmt@ArchLinux>
 <ZzYrRExrs17rapOb@ArchLinux>
 <Zzbz_4Xqt39JZfgU@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzbz_4Xqt39JZfgU@pks.im>

On Fri, Nov 15, 2024 at 08:11:01AM +0100, Patrick Steinhardt wrote:
> On Fri, Nov 15, 2024 at 12:54:28AM +0800, shejialuo wrote:
> > +	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0 ) {
> 
> Nit: there's a space too much here now.
> 

I will improve this in the next version.

> > +		/*
> > +		 * Ref file could be removed by another concurrent process. We should
> > +		 * ignore this error and continue to the next ref.
> > +		 */
> > +		if (errno == ENOENT)
> > +			goto cleanup;
> > +
> > +		ret = error_errno(_("cannot read ref file '%s': %s"),
> > +				  iter->path.buf, strerror(errno));
> > +		goto cleanup;
> > +	}
> 
> You report `errno` twice. This should be:
> 
> 	ret = error_errno(_("cannot read ref file '%s'"), iter->path.buf);
> 
> Other than that this version looks good to me, thanks!
> 

Opps, I didn't think about it, I just copied it. I will fix this in the
next version.

> Patrick
