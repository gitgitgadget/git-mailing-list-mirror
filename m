Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81E73B2A4
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756699; cv=none; b=SVOPOqB24ubucYihjpluXz8wt1op0r8rljhdCl5mhE1LOFpsUV95IOq7/SN52CCz845JgQ+Lld3SG3H78qRv4KdkNb9XN//Pon0EcoDSjQkFoMFpoLwpit/gShEVjE0sEEG9t5L5q+DqiCEuYA3+bihLzTx815p/F2uPvgISijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756699; c=relaxed/simple;
	bh=8x9EEL6vApeQVyYYkFvlrlDLFfVPjH6K8t67Tl3+ntM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gNwrSjokLDeQ6Rb7yrkAS5P1V9IXKq9tGDt8OJKDwW9KTzxNd5F3OKGRNoLSRxq9V20u6b3RbSC2Vn8b2BhduBMFaT0BrD9vkcKjSX4yOGfrTCoKdnAY9Zj8SBQs4YxO/ANSskfPXWnLEAeXYoxuj0tFeKGAUlAUIta8nMu8R/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=P0DV0vWP; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P0DV0vWP"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 59CDA1F2FE8;
	Mon, 12 Feb 2024 11:51:36 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8x9EEL6vApeQVyYYkFvlrlDLFfVPjH6K8t67Tl
	3+ntM=; b=P0DV0vWP53fdnAVyBTgIv0f4uqknviLl+TlWUcP416jm4JtIZvCJjL
	FzSdjQB33Ztm6CFDXZeYGQIHlYgF9yjc9KluoXMAFtdfbi98o+cPvwBRUixooBj/
	nSxsr7Kl2cxryvtWqa61DEyMGweDEfacGxl5zVly2s42YbupyM0I0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 528421F2FE7;
	Mon, 12 Feb 2024 11:51:36 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B62061F2FE6;
	Mon, 12 Feb 2024 11:51:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] ci(linux32): add a note about Actions that must
 not be updated
In-Reply-To: <9088cc60bda0f3f0d152ddc3c22a60effa272483.1707653489.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Sun, 11 Feb 2024
	12:11:29 +0000")
References: <pull.1660.git.1707652357696.gitgitgadget@gmail.com>
	<pull.1660.v2.git.1707653489.gitgitgadget@gmail.com>
	<9088cc60bda0f3f0d152ddc3c22a60effa272483.1707653489.git.gitgitgadget@gmail.com>
Date: Mon, 12 Feb 2024 08:51:34 -0800
Message-ID: <xmqqr0hh7hih.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FBA451CE-C9C6-11EE-9137-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> So let's add a big fat warning, mainly for my own benefit, to avoid
> running into the very same issue over and over again.

If we had this, it would also have helped me when I did e94dec0c
(GitHub Actions: update to checkout@v4, 2024-02-02), as I wouldn't
have had to dig for 6cf4d908 (ci(main): upgrade actions/checkout to
v3, 2022-12-05).

Thanks.
