Received: from dcvr.yhbt.net (public-inbox.org [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C2343D79
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457350; cv=none; b=Zds4vwvDhKswMtlSJIqbtxLTLRrh07pJCOqMP/lZa6NVj/jTFEdTjjHO72GIODdW8mK9++zGt2IGG2ySFy1nxEdEu1suEaEkzuRkkMYbiBdchArBGU1r+PpIXmY8VkgkdJl/Pa5ORwDhZAVIan4aI+y5NKaTHApMwMb9uvXsWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457350; c=relaxed/simple;
	bh=GB6X4vZSrjSkfliMqdVztrutrlFnH4c3hAaHTTa7kFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOIo1op6u1CPjE5iqSze96BIDegV1N30kBKpCjZaPNg5Rt1LZ2pypaqAKhQMel9No+Q3yMLiCFHgizDYFKWZkVWTvzkNQWysH2bTiGJyc5WPmF5E5yZH3GH2tMlCjsDjODlObGSbwNURRcVvSdpqHHpPsJSIcVXF3Jj1ICrfjdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=K4Ev2H6s; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="K4Ev2H6s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1762457028;
	bh=GB6X4vZSrjSkfliMqdVztrutrlFnH4c3hAaHTTa7kFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K4Ev2H6s6ER/SM0YrLUNYxYFAlZ/vB0DP2VWXnnaL7Eh0o1BCD24Vy+8OPwCHlgJS
	 5mzFqFmsB7RxzRRWI2enbhETMjfnh20xqmpu5mJIp/KBiMorOVFUPlKWclhgy3T7Ug
	 PtxS6T/8rIoSUi5yYd25r7p4sLIimvUnmM1BmBmw=
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2826820325;
	Thu,  6 Nov 2025 19:23:48 +0000 (UTC)
Date: Thu, 6 Nov 2025 19:23:47 +0000
From: Eric Wong <e@80x24.org>
To: Pavel Dydyshko via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Pavel Dydyshko <paul.dydyshko@gmail.com>
Subject: Re: [PATCH] svn: fix path strip for branches
Message-ID: <20251106192347.M949304@dcvr>
References: <pull.2087.git.git.1761917181558.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2087.git.git.1761917181558.gitgitgadget@gmail.com>

Pavel Dydyshko via GitGitGadget <gitgitgadget@gmail.com> wrote:
>  perl/Git/SVN/Fetcher.pm | 4 ++++
>  1 file changed, 4 insertions(+)

Can you please include tests for this and your other change
for multi-line support in
<pull.2091.git.git.1761917197824.gitgitgadget@gmail.com>?

It's difficult to do any maintainence or updates on `git svn'
without tests, especially since SVN is far less common nowadays
with few remaining users.  Thanks.
