Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785F1F81B3
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788608; cv=none; b=gkr9BLvDYjGMRWsEDgQoNbuK4oP8/msvCz2i8VBnSXP3Qecrx7c24mMbYMFRn2+jJh5+BfwISXnM+VxavHB96XrmsF6qTdpjoix7kov8vm18dFeuS0qm61cnPds2Lrg8RyhA/N8igc9mJrnrPb7nHdVJMRN282doJsa9tsUEW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788608; c=relaxed/simple;
	bh=7yktYpoRACg/hIe1GKRLHuVieopBY9lX073/hD9Sc3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLSMBFNrekLIsag8PTo4xRVRXbQd5ZqXIVv9jt/26GHT7RmrCe+8wd9RjQvJbSb6E/YnaGVG+q7nDQl+2O+UxRKhWohXP+MvdjzRBauh3AqRTZJxlML1zeCB8X+TyX6XVrVLCaHhSTjODvWj14ggImDXsRejK3MfIF3HGkGQ/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KBuzF9PI; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KBuzF9PI"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e2e340218daso1278650276.0
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729788606; x=1730393406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jblcZas1R0GaiUG7VqEss7Xj9+sTQdhgot4sqmU5FJQ=;
        b=KBuzF9PIOeaIPQNTCzLVitx0U/toni1L8rmY0gQdzLW3MizTw59WI5Z657Hwlnm/yb
         ZD+w3WONC8q72CJbaeDIVEVvzTMFIgC4rp2OQdNIEJYSUnYjOB7vbyPFWVJh3eduSgcA
         J10O1pSuCV4EfkCE70bb3WnTW1oraZ0rD97aYvd2DKjCiyna0dTZF6Lp1nl1AgmVqECT
         Xq9Bs8vbx6PYEm2hxYA1vd57AhKWT8JYkQTaKYB1Kmx5WsYc5B8suHNCrconsCqxSPEV
         llVxsgD47AEcB82H75zWTiOW8JkvMCdgvVrjiid2X5BE/CeR/VhmxEyt9WlOLOi/PZKU
         NU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788606; x=1730393406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jblcZas1R0GaiUG7VqEss7Xj9+sTQdhgot4sqmU5FJQ=;
        b=fk913H0UXh31Af4XOeJdMaqtAXaR3wnHh8Y+4NTGEW4skzLnqxc2tB3Y8iubBbTa/9
         Xz+fda2IDPWYM5+6g5RzI7YWUbvtgjtXMsTRH+4lSXBjlvTOIxTzXIkxO9t2XAg9wrMv
         Fv7NTC6niu//pNfCGN3OcVM9Tg1Z1D/gB1bwXkGJ+SC1AFYb1kh7YZfWM98yn0Juml8Z
         AK5+9J+mUvsh/Bmtn9Mhw5+tnpD/7nTwZv04oavbh6nt+t72WQFfxkhzqsLdUfp+mgLv
         Gh6FZmVdBXXa21B903WnaFNPTA9pz8DwqQ06FPu/kbF2F2cWSJk44WiGhUyYheTD1asd
         b1DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEUB0FZUquvuVVHdGeShcdQNOaCsAKsECyJDbS9edlLU6FOyKoJTCg9eINEpVUz4QkUlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNg/gPs6I/mBcSQYcyXfhGGXn+heAlaa/vte4YUARhnjlXz+Yd
	Z1xcwCcxusGzqsDsUNDgfmNqIU0sFSDo92Ho/0fqkGeHSxO+o40B0YtjZVI1xOAx1khPEEXHwAh
	YGFg=
X-Google-Smtp-Source: AGHT+IGZz6dWsu7YODkTiaihLT0Fhv2LCz//zFf6SurC8IWQAI1I2B3l/8Nb/iw9mkwQ7fSzDshVog==
X-Received: by 2002:a05:6902:1006:b0:e2b:dbe5:8523 with SMTP id 3f1490d57ef6-e2e3a654d33mr7007523276.26.1729788606123;
        Thu, 24 Oct 2024 09:50:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdcb04935sm2026299276.64.2024.10.24.09.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:50:05 -0700 (PDT)
Date: Thu, 24 Oct 2024 12:50:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: karthik nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: discourage arbitrary suffixes in
 function names
Message-ID: <Zxp6vKxxwKTb+g5q@nand.local>
References: <20241021124145.636561-1-karthik.188@gmail.com>
 <ZxZP01C-9RngukZy@pks.im>
 <ZxazVG65+W0qKLXh@nand.local>
 <CAOLa=ZSPmkdngn3=cksBM-syO94-zYANLk8FWBsQYpTR8XT9FA@mail.gmail.com>
 <ZxfVwQxMlcJbGt5D@nand.local>
 <xmqqr086pbna.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr086pbna.fsf@gitster.g>

On Wed, Oct 23, 2024 at 05:50:17PM -0700, Junio C Hamano wrote:
> Surely all of _1(), _helper(), _recursive() are meaningless.  If we
> were to replace existing uses of them, the replacement has to be 10x
> better.

Well put. Each of the three are more or less equally meaningless, but
_1() is an accepted (?) project convention and has the fewest
characters, so I think is a good choice personally.

> Having said all that, as an aspirational goal, I think it is good to
> encourage people to find a name that is descriptive when writing a
> new function.  I'd refrain from judging if it is way too obvious to
> be worth documenting (as I am officially on vacation and shouldn't
> be thinking too much about the project).

Yeah, go back to vacation ;-).

Thanks,
Taylor
