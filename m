Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5632122FF37
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200188; cv=none; b=mUyL2viDkCtNeT96OZxjSh6h6AhShEG3klWP7T+VGmSGJ39z6UfYWhMFFqQKl9Pbp/+RJyN/EB8AXIun9ITq3sd5qnanOFYrTyfCCCQg2++kVx7CwM2gmvWUkvGuAgHnNYBDa1LWVjgTwyq0NDvATvrziDddHfwx+/e4tOYjIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200188; c=relaxed/simple;
	bh=CNiFPSlNPLtBJY16/k2P5ss7pO1mjQgvKaNMxQYNbxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IcD9ZXXNozNmPCg2Aapm1gr13fMmabOrbAglkq60cYx4oj1rVsDYhiPl5dcmbBVChmV34jxAMOgWjnziYgCz7QD8nc1iXfmnpRsokGyS7BHGX8MzG11F7GWXNmbu5LiSG6PKnb5YIlhKH8n2J6cTp7eDNiaSO13Vs9r7XxodKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4cB26X4fl2z1sGXJ;
	Tue, 26 Aug 2025 11:14:28 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4cB26X4JD2z1qqlb;
	Tue, 26 Aug 2025 11:14:28 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id Hd0QSZkdHsde; Tue, 26 Aug 2025 11:14:19 +0200 (CEST)
X-Auth-Info: X4Q6jKqvyzoYZh9hMyzJKDseS0VG1CAHNvxRnO6RMza4iYa4EF6oFNT68umPYECv
Received: from igel.home (aftr-82-135-83-103.dynamic.mnet-online.de [82.135.83.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue, 26 Aug 2025 11:14:19 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id B79632C19F8; Tue, 26 Aug 2025 11:14:18 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: "Wing Huang via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Wing Huang <huangsen365@gmail.com>
Subject: Re: [PATCH] rename default branch from 'master' to 'main' in refs
 and test scripts
In-Reply-To: <pull.1961.git.1756183921623.gitgitgadget@gmail.com> (Wing Huang
	via GitGitGadget's message of "Tue, 26 Aug 2025 04:52:01 +0000")
References: <pull.1961.git.1756183921623.gitgitgadget@gmail.com>
Date: Tue, 26 Aug 2025 11:14:18 +0200
Message-ID: <875xeamolx.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Aug 26 2025, Wing Huang via GitGitGadget wrote:

> diff --git a/remote.c b/remote.c
> index 81d8fc017e1..ffc4089a1c2 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2379,7 +2379,7 @@ struct ref *guess_remote_head(const struct ref *head,
>  			return copy_ref(r);
>  
>  		/* Fall back to the hard-coded historical default */
> -		r = find_ref_by_name(refs, "refs/heads/master");
> +		r = find_ref_by_name(refs, "refs/heads/main");

That comment is no longer accurate.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
