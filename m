Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5751A2E62B2
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 05:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743743629; cv=none; b=jo7LKe8UlnucLTmMXx6O5KOfunyHm1B8JP4r+AUwi5gH4iDKeiwFM8iCRVLtDOBBt/x75n4shosdPChN911BkyjNJ20NRCWiaudQ4kNCX11HtxA5zSbWs6JMbpYaJq1nFd3vGCwhPF8ansOsHmU8RkKmJXFubOw0iieNRihPJZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743743629; c=relaxed/simple;
	bh=C9Pl0B9dbvrRJsmuJrndWO0cYSx6G9vQvke0zXu4uuE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oF+Wb7VnngnD+jLdhvl7u9YmD2s3/tcPDr+Lz4Bofriikb+TQwuvgIV2MSUAVfegnBWL8zhcHH+EmoYgZLyFoRyqv5ekCDbnFOzqVxCuqOZ5BgTEthfGyji12Mv2KDuLGi3ALILSoHbJXsYBn3oQNdvJmVopCi+L04CIaXhre44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=rBxUtqV/; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="rBxUtqV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1743743620; bh=C9Pl0B9dbvrRJsmuJrndWO0cYSx6G9vQvke0zXu4uuE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=rBxUtqV/CQImRl00PcAB2PJKi332wlkYpoUT/MH2tFFLxg72Z80ale3XXEQWrUpUe
	 v7TZyRDIVAtv+SKBfLDcH74CAUCXVPMtrOpIqGFMs3JvZ38u/WqO5J2+b6M8I9vWx7
	 FhcoAHE/34zKQRDQmeDXXKGOza4Q33lSkW3qhCmU=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 46E9661732;
	Fri,  4 Apr 2025 05:13:40 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Apr 2025 01:13:39 -0400
Message-Id: <D8XLIW3UYCGC.1S3K2HXJ2R8BL@lfurio.us>
Cc: "Johannes Sixt" <j6t@kdbg.org>
Subject: Re: [PATCH] revision: fix --left/right-only use with unrelated
 histories
From: "Matt Hunter" <m@lfurio.us>
To: <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250330055809.1019090-1-m@lfurio.us>
 <f8a7d089-3150-4212-8ad0-c9bbb3858776@gmail.com>
 <D8TJMUMOGLBC.3FR8DHTTUN4M9@lfurio.us>
 <63e79534-db09-444f-8e82-8e01d914182d@gmail.com>
In-Reply-To: <63e79534-db09-444f-8e82-8e01d914182d@gmail.com>

On Wed Apr 2, 2025 at 9:12 AM EDT, phillip.wood123 wrote:
> Each test in a given file runs in the same repository (this is a=20
> performance optimization) so the number of commits will depend on what=20
> the previous tests have done. Usually there is a setup test at the start=
=20
> of the file which creates some commits with tags. Individual tests can=20
> then use those tags to establish a known state.
Ok - that makes sense.  And that being the case, I think I stand by the
test in v2 of my patch.

Thanks
