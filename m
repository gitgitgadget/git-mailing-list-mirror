Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79A290F
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103334; cv=none; b=o5/2J/R5LrPUEWYADxG7pwiZIOZCpeLefP4sZVVMqRZhVhJ+fJOpAkjEhAtitNWnsMKs0s2kCMysXNDZ7iyy2+qZwBbecUfX1sCq6syTEE/ynUL3clDCDKcSyLuITMZhcEa53SUyZPoZoZrrkY0jl440anSmm3+NINbAaBju5C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103334; c=relaxed/simple;
	bh=tm0dY3ACLjqbn5u/prRvKP4KHMDJ7ZLKDZqZZIPPYJY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB1AKu1OLfbFc7BwsabvAwNnaD3VZKOLI5NKK15wy8NBb05Yj3mKIJmVKQ8dcgINfXlgdLNNt2/5FdDgco6pwl7Zlm1q84r05B8TBSe53sEhHV+cft1XkYTvDku8rA8KFM2kKlaSqWzEvr7g6EM6dSiwYaDR7TuDXa3s07R8NiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qgqEboX3; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qgqEboX3"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e39bf12830so860427b3.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729103331; x=1729708131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tm0dY3ACLjqbn5u/prRvKP4KHMDJ7ZLKDZqZZIPPYJY=;
        b=qgqEboX3dGb0L9z0KK8y3kHyivfciFxjCByR8YBuV54jOyUP7hffUnDy9PEgVnlhoA
         UGUgYShbX+ru9l4/uHnU+lwd3xiAg7zQW7CJDKxAYQ9207UY2pArQDu3ltDWE3iavlXv
         ct7Runcxl8prHodWWP57YvkZlk314gBHUxRZX73eaykiWmgL5jG1jqapg9UEi1uKtxKC
         sy+9IQch/3WOwrJgmYSjvLsLRZ5KtSJYjqWDMvjmxJgh3vcDvfIufrDy7rxgZxyk0VAS
         y/JroVnerVgMLQ1QaEMiij5cg6E+MyBClTfME2iyX9tMvbxUBRTajW3/bf8XjQeIY2/1
         mQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729103331; x=1729708131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tm0dY3ACLjqbn5u/prRvKP4KHMDJ7ZLKDZqZZIPPYJY=;
        b=Ib8VuCmcI8xhSqV2NFecapZRx4IMfF/tyaMY8iXtdBBgTeqVybkHJIUW/ejuADfbLR
         QhzztUQODqjV7ZeInmSQL4Vx+vmJbxGRJ+uwII4Ul6aK7e21w8GTt7t6AWGEa8GO10/A
         uwN2l+eJy8Xl3c0hhhvy0jVzBvFJwPa9p8AO920XnO0311GEGWD086ZK81xMaHS6YO33
         RqQZV7L1eTWtyt94VGq0EAsPb6h1a2ATsk3vpBL0OV3NJ8OoqG6kh1EUp5gd8lR/bAoG
         7fOeV8DM6GOomuGJ5Jhw6EmQotOrloE73LDxSsIIeJ/rkATYZXLdf4gRJpxS02oDBLOW
         WvNw==
X-Gm-Message-State: AOJu0YxVb0YKmm0ajHAKMuYw9nm1Mdyau1sITfME/V8s2lFYuuqbzUf+
	fdX1mhzsl0oEtKQhlKYJixp/7C1GI9rIROPqOaAinGSvS0KXuaj6t+PPzGtMfsEspSFwTvQiBrx
	d
X-Google-Smtp-Source: AGHT+IGBY6OIYXdy7cw7nax6/TVRow9mvOmLpP0P8CUo4FqB4mxo/cwZbJuHBcbZ1Je2dXyJOhLg5Q==
X-Received: by 2002:a05:690c:10c:b0:6e3:d8ca:f06 with SMTP id 00721157ae682-6e5a3e6a3e6mr5365427b3.22.1729103330876;
        Wed, 16 Oct 2024 11:28:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5d1f50csm7885787b3.104.2024.10.16.11.28.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:28:50 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:28:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: Re: [RFC PATCH] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <ZxAF4JEA/3r9Jbn4@nand.local>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <r4btv3hmwv6haflwhmjbjshova4wnth5mkbknsuuqcvose5lix@bvy5e6gxnit6>
 <Zw7IiwK5mi1rmqFN@nand.local>
 <Zw76iYXJQq9gJCj8@nand.local>
 <whst5ap7snkdns5k47tysuguusad5jp7vybahirshkypufhk2s@pnar2yiwcphv>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <whst5ap7snkdns5k47tysuguusad5jp7vybahirshkypufhk2s@pnar2yiwcphv>

On Wed, Oct 16, 2024 at 10:15:31AM +0200, Wolfgang Müller wrote:
> On 2024-10-15 19:28, Taylor Blau wrote:
> > I picked this up today and applied it to 'seen', but ejected it before
> > pushing the result out, as this appears to break CI, presumably due to
> > the mixed declaration and code in the patch.
>
> Oh, I had missed setting DEVELOPER=1 in my builds so I didn't see this
> failure myself. Will fix in the upcoming version.

Thanks for fixing.

Thanks,
Taylor
