Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277811FDA61
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770772006; cv=none; b=D65Sy/dlgVNRtiJW3uH4tjB6yY1rFQtRd8kJRLyaxedsE3QQU2/Cakp4EgC4ttvkcrTk236B7PZAr5i+9RymEeCSfFa0mdGaf3LYSn6xrh8gCOmNRyGVTfFExJCS+ubrAHJIJeg/XS52UDpPy8q68gUPncVBAg+LrrsYuxZN3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770772006; c=relaxed/simple;
	bh=CQvzT+QdCT4KvulO3/Bt4acE8pfPuLY0+//NmKLaulA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd2n3+G5qEdC5RsDdjx6aGF+t/D6jkl5CU7zaUQ1qYw7SufulnnNzyGHrz/YYaVoe9vXr3OhRhS24xFl2VROsW7W3Qft3IwS0k6kOzZiPlc904Dk/R5J3YwoUvshWng25YYyCq8PwcRWe8ipnv6ikEugEF8K75eXCFtQO2M1lPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=kmqZR9YU; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="kmqZR9YU"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-790b7b3e594so68925997b3.3
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 17:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1770772004; x=1771376804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxjD3jTtYy5EDV3J1CVfaUHdhbJWnd7kCo0MZnanB0k=;
        b=kmqZR9YUvy3xfk6yknH0B8u+oZUO5x04juV2V8YxC5h48bUhj2Cmluxd4vmSaCX/3w
         y5L0FBQh9hliEfojJ22wI+zqQtXtg5vlwCoUprg+5P2HEEPLB8jvGNxQ0SPATfdBKWtt
         02203AehzklOl4VCV5tmLptHJ2euLlLDaoHMtLTacMhBR36qDFJ7Km/jg+/EV9m0Rv8f
         fCZiqf+/vQ+fMhLv3bf0JRv/IpfQiEpwkAOTrVbEz4NUQgVudELp6bosmx3pVzUY/f0/
         0pAf9ntwPXmwSOqxzmh2pYBsRnxbKLWoC13eKmKOtKK8XDZ3rrcXKyCf047irs0oQ3pG
         plog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770772004; x=1771376804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxjD3jTtYy5EDV3J1CVfaUHdhbJWnd7kCo0MZnanB0k=;
        b=BG0qDZ22qYhRqXQMO311VKY2tS4rrzd1C49eTN4p4VR+hQYMZl5An+WSX6Tsm9Pqyi
         tLxcBFOOEDpsbhhh/OyzNAyes9SqFXjiFNjz3wQiDgJlceSngo4S9cdZsvly2r+w0OMk
         3FcPP0O212RHMOBrE5v0MaQYkHSyRPkgC7MqtT0i7NP2NEn/r+Naknvq7D8r6K2F/T+z
         07W7oCoCG3CLyQSR21dTbaAikC3hlDhgsL88wwey1UZ3bFU/IsDueUDnIiePUkHEvNGS
         qnkGEBKkeJh4MTWuMOWYOSRDI2ZzDm5YrUR8iFGBjjTYda5vSnTvrrI18sHqUcOYu/WV
         /Slw==
X-Gm-Message-State: AOJu0YxPZTHssHXtpVAzGuUzDhvFTYEy0O8+9QLS8zO1+EivmQ1nuT/Z
	9q9ohqbbNORlSzOmD05NFiI5/soHiap5wzuMDP6nJIElbjjq5ba+tEdjVz0OIVvSYEyO9kMUUOQ
	MReSLCHBBdg==
X-Gm-Gg: AZuq6aKPNhDAG7tRx1DCRv2JC4HbAZtsiIWVyps+wPGxkY8fnculQM2KYVk7ft8jR94
	8cjJoVb5z1KSufyG2UB8ql48hJZptTLCa0I8JdCqTOqGV1DKN+iNSWTLNqSyXrOXD+bUSwM+Ay6
	yQm+Id3cgzBM8GtDCC+j5BHQh1tgxez72wL615gKjd5VYOPyF/UDCJxArPeq4orC1wMBB4V1OUw
	MQmGcQfru/4HDwTE4XWj6Vqu7vm8XX36/aDBB4ePVUSmRlWevIpxTOZXC2dUhfa/XysRC/KamMY
	apsIpSA7wIgq6CJKVHRstB7P0aD7NVUmBaF/UZ0UU09FFvPJgiQPciba/3nlmSX7VIdANtrmCuf
	AM1iVZddktTlHdGhfChXjyPEu7Eqaxvx3iU3KvsDatB6zeh/QF3pu3ltna9duLZg28vCsH/ZG3e
	gzB4hTMoa7bJOWlRUcG8wmBpPd/WGQEwb7T7n4SufWbGt9X5xkEb+MNSyDW/OZd7bN5y/yblhc1
	hX9doJPQIyqTXDthJBcl8UQ2gdh0A==
X-Received: by 2002:a05:690c:97:b0:794:d1a4:dca4 with SMTP id 00721157ae682-7965eff9a1dmr34959327b3.33.1770772004129;
        Tue, 10 Feb 2026 17:06:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c16e7dcsm2761997b3.8.2026.02.10.17.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 17:06:43 -0800 (PST)
Date: Tue, 10 Feb 2026 20:06:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH v2 2/2] http: add trace2 logging for retry operations
Message-ID: <aYvWIvViGYoVDngh@nand.local>
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
 <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
 <ad4495fc94a4bcdcf7f299ffd8514afce88f2d6c.1766069088.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad4495fc94a4bcdcf7f299ffd8514afce88f2d6c.1766069088.git.gitgitgadget@gmail.com>

On Thu, Dec 18, 2025 at 02:44:48PM +0000, Vaidas Pilkauskas via GitGitGadget wrote:
> ---
>  http.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

These changes all look reasonable to me. I think you could reaosnably
squash this into the previous commit, especially since that commit will
likely shrink as you move some hunks out into preparatory patches.

Thanks,
Taylor
