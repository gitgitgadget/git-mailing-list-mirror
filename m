Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466174C83
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740703124; cv=none; b=cTRFepOn1OdpbauHkneLlyQ2P12SiFuI/1emE8AqoHWwYAp2H/Cn4BLQfPWNaz7PHCuWr0xbO8aVtK5Xrd85h09ofjDkVq6hD2gIAkWHxiviopbpHf3ZP61Re0iydeYuuxXg2Z4lhE6HGdDY3MqYK+Dog53RKNIWZnGFcYIuVcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740703124; c=relaxed/simple;
	bh=dI187TYaZjUDpsoYrnDMhJl9uGGL09y1jjDKWkvygJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6LUJ+vbXtqQD4XoRUIFR09exrKeNLDfjaCkZYKgcq132dTQqagCWwkF1mcm3eFb/Tu/cKUNQP5uaSm3k6k/EZ70bhRL83jsjB3M8gBGBzEdeirADOlPlTkMPf/Le2yNTmNaDOKLUbjwpEvVF/woq401KPvJyhD4NVHl8aUoj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=p85zYH4H; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="p85zYH4H"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fb2a0e4125so10422607b3.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740703122; x=1741307922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iL8pyQA/55Ffd2EXFopmgKJGiy1hGd+m+/l15pxGn4o=;
        b=p85zYH4HXwGCbpY002QTOFZ771sKHFc6xvJyUgdtwMcAsgSFMzeknkE/AnH51ifPEL
         xP5vWI92weKXt7XUWnNdgnPiIF/QLXV2P4CgXTXQkn9qeprPHTz20D7llP3/Iwu2LUME
         QwGACJ1qIa1GAclfLSYzsYkhrYT+gY/u1bNdIJKVqEKYtSNWZlEkKIxVfXVIfCUD0I2K
         fHZhvE+U+yHGruvQ5Ghf6lnF9A9Gg3dcxxArwGrUMGIESp9g1MYx5x40kaEA9XbFHaNy
         PHD1Ia80vFv1kD3hxjFJClIlVVzfnKSLnhbqQvUK4TJdSMuV4dm8k4ZjpTlEtPLo+Ciy
         C/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740703122; x=1741307922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iL8pyQA/55Ffd2EXFopmgKJGiy1hGd+m+/l15pxGn4o=;
        b=Yubu8J02y3vsPPK9s2kG09BdcTgQF7n743JM0sxnX3GeRa+UkNSCvJsQU1TqqT15tt
         1rDODeP3G4tWIKbGLb7PKg1NmFGHwXpKtfUpXgmmvIv/lulXXfajR9y5HAZqSHcU3h5r
         fAuepY8SP738BsvdgLndWqpZ3Acdpq8bRdUi6hWJHP+Ti0CuJRhUZbhuWHu+FLCwD8Tt
         1p2StsBDOL7bX4FL2tfRkT1qh/tPuUTe4Gho2PF2YMO0JU19mY9D/fc7e1EYFyflKNZC
         xgnHvTWw9AvDphW16QGXSAikxp3wG1u5/L/EkcyyoUddxdc6fYTLVPdKFhD01azvYths
         CqNQ==
X-Gm-Message-State: AOJu0Yxu9jhjkvCppU5aflnrixiqomy6Ovx9buCR5jy6AYrvKi98EF+0
	a0T1B+ned7pbdacP7dZ5U7R+AUGBz5nf0lMi0cCwaNcifcGfjx5TwDZyUT6bGqI=
X-Gm-Gg: ASbGnctpUATErS+VyWDuhOtHgvleULaB6DhjGN3Y2tHrNNiCfeRXyDR99kOiw6GcRx5
	QgrnZ6KYPpkAwd/cLpSKuPtl06IR2uKe4f5/3Stoti/b7xDOi5ep868LhKvNV73MjwT1gQwgIC/
	q51q6DHD/LDqLpwJ7hPOlK3Is9cNtLQPoQ2SQfRP4xLburfTp5jssLMQYiI7BllcRspdBr+mtdS
	yhz2yZpwpG8tWgmhsMSU9EzgdhWwVyOS3bJ98h6TXpW0kxB+FGOlhsbcsvE/dVX+2+T4xXBwy5/
	monENHSfjyEcGsrf1yd9Is3TVKfhznXTuGM+H4dk0GlRipGhb2Fw1xVwdxLnc2nwEhjWYpUk2w=
	=
X-Google-Smtp-Source: AGHT+IGF+IM9TX7vhJiqUE3KAHJG3NW9/Ga70NuL3iZB1n6avJskhNp+Sb0vedvJNc67YdOz6a4vkA==
X-Received: by 2002:a05:690c:a8d:b0:6fd:4441:3daf with SMTP id 00721157ae682-6fd4a14d07dmr24111007b3.30.1740703122167;
        Thu, 27 Feb 2025 16:38:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca43b7csm5196337b3.39.2025.02.27.16.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:38:41 -0800 (PST)
Date: Thu, 27 Feb 2025 19:38:40 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/10] some zlib inflating bug fixes
Message-ID: <Z8EFkLEiRCztQA8l@nand.local>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225062518.GA1293854@coredump.intra.peff.net>

On Tue, Feb 25, 2025 at 01:25:18AM -0500, Jeff King wrote:
>  git-zlib.c          | 27 +++++++++++++----------
>  object-file.c       | 48 ++++++++++++++++++++--------------------
>  t/t1006-cat-file.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 92 insertions(+), 36 deletions(-)

Thanks for putting these together and sending them out. I didn't have a
ton to add throughout since you and I wrote patches 4 and 5 together,
but I re-read things to make sure that everything still seemed sane a
week or two out.

The remainder of the series looks good to me too, though I am not in
love with the final patch. Like I mentioned in my response there, I
think it's pretty subjective, but I would be OK to see the first nine
patches queued and the last one dropped. OTOH, I wouldn't be upset to
see it included either.

Thanks again for working on this :-).

Thanks,
Taylor
