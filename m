Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4C3A48ED
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321908; cv=none; b=s32Aw/+9MefHvpl6qpCOu99unAECaHVhd+1OAifFTGIQ598JcPHqt/b2Rkdss9ZBMuoOdqC96q/xqWSokVTqzAUgoP5pNIEzoUTlR4JYjewk9WFobMxVs6u/N7BUVhH2FagpsP0dhq63q24tghMAu5H+JQUN+ntsMHkKW+wOVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321908; c=relaxed/simple;
	bh=OB8lM0i+CI2HnV3nSQbgufPnErC8O/dfCvo65GDWyQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZubna+TdAbb8mI+ValTaF5YZEMP0avZpQ+ZPhGVzL6udlX8N6kbMSYwvhX4mipn2+WEzfeAdtSXB7LfWthAHUEqY6Ec7bhfoBbRVlcqRozw9IzyYItFTxUccFPhoGCZcK6whn7Ha6KhNhnKS57OtyNFApstkjmK7bhAj/HZtsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEM8OaLg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEM8OaLg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso92899575e9.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780321906; x=1780926706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KVLqHRFApU3f+WAI/si/6sZDyWO6S0VzXaivDK163O4=;
        b=BEM8OaLg34WI3UuCgEm5OiPn6kouL4efyFPp4TPs5eCt7f5HIQL1cmx3VovB5JOBf6
         G0ZXomfkw7JS1pE3+5R+aVgYGwE2PBI9a0ZsN/jPv61dP0D1IiSe6UNYbegkpqPpkmsH
         +bTiG9S+VIqssP6GZJM67UpHnkHtlKhJkF8IhMOOPgu3boPLQ+XHlnYHDPMVggDN1bsX
         negLpa3hMy7g40WTzO9gAWtaLR2QyOVaJJe5krZfWpKZT+TNdzCPb/COGTW2IIv0+uva
         +rZnSq1hPnMb8coBeBqzFQ6lmgzJGVQ9gNozZSEEHk9B6eRJ5R3bfSqRbRIfxk9PYXya
         FpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321906; x=1780926706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVLqHRFApU3f+WAI/si/6sZDyWO6S0VzXaivDK163O4=;
        b=b5pYrXDRpSheojoIii3f6NMBVK0TO+2ZEndRxyBXUwCKUxcMRc7+Eq0xdyfch56wqt
         WSAZtCnkgzj+aX2unhsv8Eef/W3z9n+ukbUaJ3CUWoPPp5ZA9HEAIV2+SOA/gjGNVVrc
         cJhWWDy4byrhQp1/6VvauF4vkoQ/kLiUPj2nNvw/wTXMsMn3p80XRlrsKYSekSKi+ZVP
         8QmIeKfOfhW63qVaAQOUtqMzm08WdkY5ahm2tdwuQeogdNETkweEO7TWyHLej8rJRShg
         eBkpqCI2qZgE18egLGMtCawd5sB7Cb4FtdWckpCPyem3k6MP9uJQ1NAltZqFQ9kT5vcy
         fgAQ==
X-Gm-Message-State: AOJu0YxdWSGJAe9vCTB3rGt+WFPlahbyf4CgLiXH8zRKDQeIZubUxpkT
	Zh6SNEI4SqoAtUmVcpSnzbJ41mzeiWs4NSKGWthyLNBlcxe+lBCN5whh7GSzqQ==
X-Gm-Gg: Acq92OGDXqSi+sWPgQ01b4FkZ+Q0v5hd1VGfDqPxlbpKp6uuX6H4SA+Ft0s4PwLzY+e
	NJ7wAg5jzXSKTILuwGGaMal1g81h09aqZ6kGRxbjUyeYRvMpE+3yIEg2RIVgaR57B4qdJrlnjYq
	pxi2HRPzCoEsfpysRQr+WNtCubBJ6AN4Yr2bDKXqyZtbaCaMdoPkuLjCRv4lL7bNlsP0LnAh8oC
	spKT7mzE8rNFEVjWRs9dS8jsfuNoyTywf0TNdVv321niewTp2KTNSzYZa0vYzXhJpd+dLxiea5S
	XpQyMm/JTRLzqR4ObLprsOArdRrmtGmI3exrr4QNEhDM3ebRJDTQpahcdf5NbtUXrX7L4WrqubF
	TVGJiSTDlzY1VI9/+reo92ZNvWaJ71wZvd2xjF5baLxUvfYiKV/+TImj17DbnhjbtquHa/BPF7m
	E16v5Icz7WVgo3B73uK2NunwOvPmbBRkWLbf8d3BYNMAPAI0vHCiYGi51L6RycGw5sjQ6aXdX3n
	+OjwN4WN243MMYwPc3wsjxCS4FCQzmtQQ==
X-Received: by 2002:a05:600c:1988:b0:490:44eb:c1dd with SMTP id 5b1f17b1804b1-490a294fe9cmr194695125e9.29.1780321905801;
        Mon, 01 Jun 2026 06:51:45 -0700 (PDT)
Received: from lorenzo-VM ([84.33.159.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0495fcsm124114575e9.0.2026.06.01.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:51:45 -0700 (PDT)
Date: Mon, 1 Jun 2026 15:51:43 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, fox <fox.gbr@townlong-yak.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 0/2] http: fix memory leak in fetch_and_setup_pack_index()
Message-ID: <cover.1780321770.git.lorenzo.pegorari2002@gmail.com>
References: <ahjUmMCKxREamQE-@lorenzo-VM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahjUmMCKxREamQE-@lorenzo-VM>

Patch series that does some cleanup and fixes a memory leak present
inside the function `fetch_and_setup_pack_index()`.

LorenzoPegorari (2):
  http: cleanup function fetch_and_setup_pack_index()
  http: fix memory leak in fetch_and_setup_pack_index()

 http.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.54.0.129.g2dffd77b94.dirty

