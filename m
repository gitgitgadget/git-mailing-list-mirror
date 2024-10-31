Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21474437
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730401228; cv=none; b=VdMrOV49yYiZKJ2+Za9r8QC4E3X0O0zrArAPoWl5KS3Ps4QkPGBXWfsYAlgl+1tn2tC0s9XfA2HYw/R+VClVdqZPuWIk2tR+tixJD8zef9pUmzjfeWeu+hNsvbfTVB03UK9IaMIlc8cUlNc5rbbOLY8Br1J52K4Zh1nQUjbRx2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730401228; c=relaxed/simple;
	bh=LXKgsDlICmtsmqeRGuOgYA7KQwct1G2RwMWmh+Or1PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I65rf4qOFXZ6tOENKLD1ohWPr4C/ZkC/sVlO09OHdpVfHU7kjsZTIBHZf4Vo0sgcKr04UWGapcz6jYOqRpt7pcKoTO7AmJ9UDHp7XQd0srO+LMFO0z8qhKrb/rCawXMVtFNgzC7sqpir8yP0ZPvFVczjYqyOa3q4WZVVO/w2pPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=L3wnr+Vq; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="L3wnr+Vq"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e2e340218daso1404325276.0
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 12:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730401224; x=1731006024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LXKgsDlICmtsmqeRGuOgYA7KQwct1G2RwMWmh+Or1PI=;
        b=L3wnr+VqpxpEQdJfZoXpcwXGQ9jbZI3CGkM4yUPbMewiiUD5PZQdDq5wBFcbGyJSFt
         rsqngAZN3noOm9wJFxj02q/nn91A3p84kdJXGR9cBgFnD26APbp9uGUsGdR/f/kqJOCT
         DT53qaOC8+6Q9okYqtkwAg+x2qb/rIzeY3gOUWznVS0Nmakn3JWR/qbhdvMyk5K7ToTD
         mu5Bqr+xXmHNCP1dP7hUYvp9I+6jxMhY8ghPQfUkgMclsUmxDvaYLBNdB9kyeQuCy/lG
         faOkdlGIABHqOKkkLuCPNYQVKWhwQo6qyL5OPowuoNbudFTgFasboGCHbabu5/Av89pe
         x1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730401224; x=1731006024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXKgsDlICmtsmqeRGuOgYA7KQwct1G2RwMWmh+Or1PI=;
        b=OCLv/V+fZ6N4842oGzUxqt5Hzlu6kcqVJwXzBLni2SZn/GVt2A2C9P69H5ddwyJGT0
         IgKB2WijCsMRHT229WSWbGmzNux2yDL/SaFGfq++yUyuDZM37ncV7Ugu9wq0RPwiLsr2
         LiDQkUmUy8GG1IguPezpuJc8+pF7otMKXV4kiunBG17TDUPiHdnEX+9H38SjDLpHWZiJ
         9USmGPTAfFPyU3sMyguZWv4HsDprhBBldlggepvlzGvxrYAyIXtfr5yPByPFvqcqdr6b
         HNls8sMsgWjhL/MJ7LYQJ84BF73dTQVpw36opLmkL6cuhcaeINvLY68jIu9avWGGEkOQ
         dqSg==
X-Forwarded-Encrypted: i=1; AJvYcCWBKud1ll4v9neBzRGwQ5ZzsR8H95CVYbhj0MCfFC2fbL37kwjcALW0cCW0Dr+IXrCYWsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBjlgKgE4oudnPE+R7104+MBzzvwV7ICgTU64aOKI/QK9rgwP
	Gmlu0R9yssrucrvTlq4ql1y8ntfVk95Moh13zJdLO+K4frB5t1h1ElnXM0hl4Vs=
X-Google-Smtp-Source: AGHT+IGaURhkEaLYlg+iopFGfMk8qys7eX1/xAve4L0+rnYxl5GzBscQHp+MVun7M2if5WYrpDlhfw==
X-Received: by 2002:a05:6902:330e:b0:e28:e8c4:67ad with SMTP id 3f1490d57ef6-e30e5a1b507mr3746881276.12.1730401224269;
        Thu, 31 Oct 2024 12:00:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a6114dsm410068276.6.2024.10.31.12.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 12:00:23 -0700 (PDT)
Date: Thu, 31 Oct 2024 15:00:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, git@vger.kernel.org
Subject: Re: [BUG] "git describe --match" performance
Message-ID: <ZyPTxgSFiQpZG8qe@nand.local>
References: <20241030044322.b5n3ji2n6gaeo5u6@treble.attlocal.net>
 <20241031114731.GA608553@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031114731.GA608553@coredump.intra.peff.net>

On Thu, Oct 31, 2024 at 07:47:31AM -0400, Jeff King wrote:
> I think we'll build the commit graph file by default these days when you
> run "git gc". But we don't build it immediately after cloning. Perhaps
> we should change that.

I think that would be a reasonable thing to do. We already have
fetch.writeCommitGraph and gc.writeCommitGraph, so it seems like a
natural extension to add clone.writeCommitGraph.

I don't have a strong feeling about what the default should be, although
I err on the side of "true". Most repositories cloned will be small
enough that writing a commit-graph upon clone shouldn't take too long.
So the savings it will provide will be well worth the marginal increase
in perceived clone time.

Thanks,
Taylor
