Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502A12236FD
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781973348; cv=none; b=t1OgHxW4JMKYFh+NhBNv7TJi7/0gWOurbrxJPo/43Ll6koP6+VKDMNFpwDm+v05yZg9wHNVyzHDgplo0P81i0KGM7fMu/9WIV+LE8BUMRt8QpgJ3f3+dJbzErRw1HvmW0z6TRo8Qv97SMdSF9oBV3KP5VSdMx7bDiyl3xY/vTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781973348; c=relaxed/simple;
	bh=E5byMv9k68csZzMe4LrT9C4a/ZG/PjJGlYXIrmR+X8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctDmrAnfxfB18+X81Gk2T3DF4Drk0m/PgXJ1Z32S/+YD8AhGmL9PLYrAEIdHGCd/tRps7bZ//+VBEuZjOi16vxXxft8LOQsvjaY0hwNe3G1p7zKMoTpeDSbaKJ1y07SOPSu7kE378oTjHCrm5MfqXB99abbO7DqARX+7qsXyjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4gjJjV4CKQz7QcfT
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 17:46:38 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gjJjK0dkJzRnmN;
	Sat, 20 Jun 2026 17:46:29 +0200 (CEST)
Message-ID: <11c062f7-09ae-4a6c-80c5-2ac9e5d37d86@kdbg.org>
Date: Sat, 20 Jun 2026 17:46:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Silence po catalog output under "make -s"
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.06.26 um 19:52 schrieb Harald Nordgren via GitGitGadget:
> The gitk and git-gui catalog rules sent msgfmt --statistics output (and a
> "Generating catalog" line) to stderr, so it survived "make -s". Emit it only
> when "-s" is absent, keeping a quiet build silent and a verbose build
> unchanged.
I think that the statistics output isn't needed. A data point is that
the Git repository doesn't use --statistics: 2f12b31b746c ("Makefile:
don't invoke msgfmt with --statistics", 2021-12-17). So, my suggestion
would be to just remove the option.

We don't need the "Generating catalog" message, either. Just remove it
as well.

-- Hannes

