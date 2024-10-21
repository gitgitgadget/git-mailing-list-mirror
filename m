Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5E17C224
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526989; cv=none; b=OMBhUlX03VE8gNRMy2s7Hvvqeot74kciPiZJL4w2xoyOoR6ugk5odjt53Me+i7k3tySsIE7Nz+iNaxwD/TZVNes5nScCMy8iLcMEVsCjeX/GXBETIZ4V/kE867UAfiDb/qiMBRxHFwlFrflxlm2h1b3jHMnmHjeeYQ2yE0jvBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526989; c=relaxed/simple;
	bh=K8ECcYHBzsoN4QwIB4yxByiXXn2ulXqKYEJ8Ffqhdfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKRoO+xQnKBNf48oVN+jTUYzF2V5FjxJ7WPnIl6TodxwCgKbf/g+ncoeDMKK2V5EaRFFVdZSMBf1hL7TUbr+ok8IsmQzfKZhSJaX2JAk3eZsR3R1no06LgX+3s8Jx4M835vL9vpUdJCTbYm2W+7zZ/LpDCnNKiY6q78NBrA5WWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2qsh+b2K; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2qsh+b2K"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e39bf12830so32219097b3.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729526986; x=1730131786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hC1KcmlFMtJcaA/Gd/GTySgE/H44KkxHaG5ehI4F0QA=;
        b=2qsh+b2KmPugY2kuF4zKPOqP01j0kvbedLRRlyFpBqlEQGFtUk1eKT8z2IXyIiaf9N
         ua0OMTrsvwCh1L/WzvMYd4a/559WLFuyxocPpGrYnEVtq/i+djuFpYVqXx2pKIuI/HjH
         lPdezOZsJ2iV4R+HhRHWQEIlEI93743GrmRZaDPAlJnnGzjvkXZq6huAuIsDFkSDkIZo
         vrfIOvvC19pg4O6X26vg/qrtNuDELHrrte8LEXM34KtvngFb2Z6goU5VGBQPyxZxVQk9
         4GxoGJP9MImvOYXIfbrwLng6re2n9eepydoLkWv32ETmgDGioDsSz5HaFYuqkBCI0tP4
         es2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729526986; x=1730131786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC1KcmlFMtJcaA/Gd/GTySgE/H44KkxHaG5ehI4F0QA=;
        b=T8JTHM2tajo5sISHv6Fyg6JbIA6bbMMj4RNjQPYykAbRefvrPp89AT+enPbRPeHWEM
         7L4jkFcETqtLfH9c06DGep60GiUyF/CdHuzKPHBZuLIj3udiJbBq5beXyqC9kN7zu6aX
         vgB9bZM104cUYYZTGJCtw7MtcW7ZPqYrbWSkKbBmy4unaSyfGD9K/PiNSPwi5kR/2ms9
         huAntqfPjGteWaTgNAPweOx29hFkWyyf7ehYHPLO3zg1BBhhHj30jpTvW6cA+TEmHj5J
         y5w4U9v+KYfj3+otRIHjnGGbOCJoBVEd6pwUr6quqhNeTfaevtmOXMqGz0p9Xc7j0e3+
         5zcw==
X-Gm-Message-State: AOJu0Yxe7I/Gdejz+BdCZdZs8yLNn7xrtOV2jlif0IlWuPaPDeRGsehN
	LTzL9u1O9LI3K8GZWd79KPKVfOB9b2oiz5MFOzx4W0K+goiA3Oitt/DnM4h1Tqs=
X-Google-Smtp-Source: AGHT+IE33yAiSh4TQ0RRiCI8yHc5U8GjI7ICFpS7JDBBdzvOeyaezgkfVtwOJLElDXg70eXCjHkYbg==
X-Received: by 2002:a05:690c:708a:b0:6e2:2684:7f62 with SMTP id 00721157ae682-6e7d4582283mr1738787b3.8.1729526986006;
        Mon, 21 Oct 2024 09:09:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccc4c7sm7196857b3.87.2024.10.21.09.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:09:45 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:09:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/9] add ref content check for files backend
Message-ID: <ZxZ8yNBZWNEhLgND@nand.local>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <ZxZX5HDdq_R0C77b@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxZX5HDdq_R0C77b@ArchLinux>

On Mon, Oct 21, 2024 at 09:32:20PM +0800, shejialuo wrote:
> Hi All:
>
> This new version updates the following things.

I am assuming that this new round was rebased onto the tip of 'master',
since I could not apply it on top of its original base

  b3d175409d9 (Merge branch 'sj/ref-fsck', 2024-08-16)

In the future, please indicate when you rebase your series so that I
know what the correct base is for that round.

Thanks,
Taylor
