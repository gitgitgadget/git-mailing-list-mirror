Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7917C6E6
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716243; cv=none; b=bRvIjXVuqwQA/JF1/M+QF+dzHQzA3sQZJjUutxlDpgoSBUlH2ljp1nD7kAI0zxnrbE6Q79KcaeQjOcl72kuJQp9Fz+PEyO58LGkRzNmDH9zGi/g0Kps4ViIveqEJfaYl3DeXt4zXfaxxOI8Affrc0606XiF83VjgWdSZUsNiGG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716243; c=relaxed/simple;
	bh=bx5jy179My4mFnoHm9tTeX0yUuVFz8yB6N4+QCsMDWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cx3Fzm6sC4WjFA9m+ItP2Lm/2qJFAMl6zoKcfSuFbhsATgw1snX5IHdwgwHzMeukOA7pAkjXjZaEIIjL6AoIOR5uWxv9w+XPHM36RPxpeLpI6LqPcN8Nu03z/Lm/qqeM+9tSqVv4yTc9pI3oFHPBC92AMK74/nD3G7j1l6en/dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=SaCfwaT2; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SaCfwaT2"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so275294276.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729716240; x=1730321040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IlSeaovl9Av6S+tu2+w2gxVOVGvZRwOFuOjItWD/a9Y=;
        b=SaCfwaT22sMQZc/0p8Ds0cokofftrb6bXPV6uPB0P5ua2KPVK1I6mI26ea3zL4ervM
         xmg2M2eVJw+JDk/2Gn4DCouzJib31oQgKtIA8tlv4204Zo8ibuI7xj7gUQZLVdqxMFVw
         gCbq7KE7vvMbLTsEVfacT1iPHkiESp+YAzcrTK/Jbd1qLHkhovC9j0+tvs1ujxJUnDVK
         x71Z0UfR7+i77rEg1sWk3SHbI3MNz0BHM1r0pnJcz/dlrZprtXdHxou6nbSFe+taCTXf
         2W5wMKZq9EMscXxGJ4DL4aHXlZDXZRYoghPAsnRQed0mQszsSVprKUhboOaiZEfYCxdG
         d3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729716240; x=1730321040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlSeaovl9Av6S+tu2+w2gxVOVGvZRwOFuOjItWD/a9Y=;
        b=eype7XfElnY3wftPLMumii21ZopzUUNV2BO15MSkTnyo7CHOYCsZ+d2fw1C+R7vkgp
         GKZdZ5Nxa/sruiR8RWPvVYz7BEewRHez4mx7CX2ACCrJcLIUmI2Q8V/thK7EvY9Z2Hlv
         aM9GiRUvxVbOI9r01rT+URb3e7W8KskgxQjf67Wkua2ozT/YXOFSSibEzFUVqALuabp5
         41Nv1C5GX+jcgYL/IhGFeSDJlwVGInILU4c8gtD/H9Rcga0WAzf9UlOex6xB6Q/2rp3B
         wYxD1H2sy40eCdKm28JeU5FLOOdK31Gjqwy+P0HZBaE8zMjrx7SFYAWn4WOsQWJb0FUX
         JjPA==
X-Gm-Message-State: AOJu0YyIM+sw7d/1hU8KgvwDrknKKDLACSOiNHhaNgxEmghgJqOwMIaT
	rFPrMxCAyhjQ1z1DAUtWiy5VzqzZzyFqGthmi9v4A73swe6HSUx0r8MUT7Rd3r0=
X-Google-Smtp-Source: AGHT+IH3jIwsVqd9Xaqye9lFH8Pz7mtyFEs3oumhc2wXf8PiljTwxq/OsqkBFuBmEZY2ixCkqTr1lw==
X-Received: by 2002:a05:6902:2804:b0:e2e:3431:b754 with SMTP id 3f1490d57ef6-e2e3a6dc9ccmr3458911276.50.1729716240477;
        Wed, 23 Oct 2024 13:44:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc992b1csm1686647276.22.2024.10.23.13.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:44:00 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:43:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	stolee@gmail.com
Subject: Re: [PATCH] sequencer: comment checked-out branch properly
Message-ID: <ZxlgDqZuBbwqXMch@nand.local>
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>

On Wed, Oct 23, 2024 at 07:27:58PM +0200, kristofferhaugsbakk@fastmail.com wrote:
>  sequencer.c       |  5 +++--
>  t/t3400-rebase.sh | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)

I should have thought to mention this earlier, but this does not easily
integrate into 'seen' because of 'jc/strbuf-commented-something', which
turns, for e.g.:

    strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_str);

into:

    strbuf_add_comment_lines(&cbuf, buf.buf, buf.len);

Note that the function is both renamed, and already knows about
comment_line_str, so it is not necessary to pass it in as an argument
explicitly.

Perhaps you may want to rebuild your topic on that one?

Thanks,
Taylor
