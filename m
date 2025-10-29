Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430337483
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776183; cv=none; b=C4zd1S8e+WeVVo/eZxI37qfbFdM2Q52NZImZJgq4pvNVXVqj5YP+h9Kvj0iw1YFJCAwKmu/YVWIGpLjFK3f7q0ZkHnseCfzHVLDgFL0hfvOURakG8OAf/0LU1uy6WurqDXbBgbym39vyzSyAkfgf7cw9dJAfUvzSiGxNyOqHE0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776183; c=relaxed/simple;
	bh=VcjSl1BDdPnAbpnd5FFKlsdlBmf8l+VfskBI6e7Em3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGQ59c6+jKatakzbXX6fiFbQpI0B9hLAt30ZkFrXN7S7rHGMa+YpRbZysoa7ZVHBJVNqIbcrXYqQOUZdzkYpyFvaFpBoWkQeSWX++VabHCQADNSE6ZbKiD68CbPuuZbNI3v1Fn524q2RBHal230JsliY6M6ZlTSYquz5PKJdhbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=P2JyDyOe; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="P2JyDyOe"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-945a42fd465so16161039f.3
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761776181; x=1762380981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7UryZF2PorvM+AmdkbQJxeBS5Pe5GOTUEemHlrsrlA=;
        b=P2JyDyOeHqCsh02nTO9RY25evhIQM0pmjddDE6ztI1Q+73smgN3fjVL7xHpVY1jX7o
         ZAiBRUpkHAvbM5ZtLgGzmh5iRmyY8JK5Tr4Lzw9VNq5+47wBad0WGNz9D/XhDyVGc8u6
         rN1i4+Hmua6jp+a/BP6jJhTJxjIaQIIeISC2DQ47yEeu6BBSmF6NtubLX9end/RJwcXa
         4aB/KuFzaD6A3PeYIv6mpKWdCeNG80KtTQ5WEupZorw3d+axwzPF6UfTwgWa5D7lpXwi
         jZqimbGBNekeHVDAjDcnVztc9f9/OtbJ0vCV2VHjJvrFkDfweuyjOOh6E562Fa/UpomN
         MqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776181; x=1762380981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7UryZF2PorvM+AmdkbQJxeBS5Pe5GOTUEemHlrsrlA=;
        b=JuXncBcl5C+aQhGv2/TNwC8WBnIVXjFUSL0myORUPxu7MQv0czFkJa9Jq9SYj7afhr
         O9CQXAHiwe3dIrzAJSy7QBKQmRPxzMf3CHzNDpS10iB02lNLtwK8e5VgCJsOLmaBArVB
         t1m4EpcnW1rpJE+BkiHAJt2QCd1I7c89FUp76X3AaycEFjAqm28qNhilb32WnWhkMfgE
         KRYWTUlh8YHH0TbbCQiN6q5K7IgMWmbihKra15YpiMK/O7B8SLcw7gEFukczUwfbvTkv
         u53Xzh5ARzCP5AmR88DoJK2qJfubg1iVq+6bYcAnPIeW8JizTjS2XVan3BimWzEOn+De
         9VzA==
X-Gm-Message-State: AOJu0Yz2uLrYVqGNGD9umhdxT6o9VeJHCF9FTf5xhcvMTLf0ZoLwzX+y
	ez+R1hcbD5KiDi0C+uQ8A7b6H6i4FavwvIRBJvPpiEg2BKZGD5jrjKfEBCnSTZJoMpA8AeZLglP
	c8YzdlTo=
X-Gm-Gg: ASbGncsv0ewfFs/L0azKYlCqTjK4Dh2p6lVWEygZtmZ9D2N7HdeXU+LzKMRhldI7Rlh
	xSe+xcjcItnhXluPxKK9Be6WK7buZXO9eYiSD7YqAngGogUQC/ZZNe3WoCZ3ETZT4EAWHOvXYDz
	PnknIXTw9Bvv+NH4RDlJPCX13lIq0AdPMRfp2KieRBD82ZtqkAbCeep+ZRmBvaRaKDO44MuMPwK
	C3VGUyLcKOueHK1nzqTqQWZRg199etkwrWgIST9nnK3hSocIGbNPN/ZvmJOOL/0S4DFovafYFD5
	my4cqvwEiPyeGMm2YB/Z5TIjxERW7EiH2s5N/j3Ttv549P5yAURTJGrhrulrMOz75QLPaZ8n5kX
	RCd1S7mdJYYhQ/qlM6BKir9jzHz5Z+5k6FmQDX5VcOZAO01Pkxw6o5ncyWJOxwbRdFjqOzG+uNO
	RB77xxgGA/u4AQj65cUSzl6TGTYlklrkNqSDq9vHAKJoNM+RD/VxLibv8fwGYHWkVAqaMt2ykYG
	bO5zAc=
X-Google-Smtp-Source: AGHT+IHuUGpEc35aCu3Rz6w/nLH0wtUjEFAPKAE5ZxFGd4SHG/0aAvDoSNNdtg0thd8tCZ7zBSdCFg==
X-Received: by 2002:a05:6602:3e8e:b0:945:a37e:65fe with SMTP id ca18e2360f4ac-945c969b8abmr732713539f.3.1761776181305;
        Wed, 29 Oct 2025 15:16:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-5aea77ebfcbsm5960847173.17.2025.10.29.15.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:16:20 -0700 (PDT)
Date: Wed, 29 Oct 2025 18:16:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/8] packfile: use a `strmap` to store packs by name
Message-ID: <aQKSMk6nFIk6Xomh@nand.local>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-1-1a3b82030a7a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-1-1a3b82030a7a@pks.im>

On Tue, Oct 28, 2025 at 12:08:31PM +0100, Patrick Steinhardt wrote:
> ---
>  packfile.c | 24 ++++--------------------
>  packfile.h |  4 ++--
>  2 files changed, 6 insertions(+), 22 deletions(-)

Nice; well explained and the change below looks obviously correct to me.
I much prefer the strmap API here and agree that this is a good use-case
for it.

Thanks,
Taylor
