Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661653;
	b=Rlw5TD5WUu/RkCfahUrcWnMEYa1jDcAwKuRSCzAx7sT/Urq2QcNPdhCKdtAlenBrEcuR
	 /UT/cY8OK+Ras3CjCIXW8xmqC0d3jdEfzp5G4Z1g4qPvsuHgfZq7zhYzh2fZxeKWYMwBd
	 mCSBOJ7DmQuLEEZushffvS/UKPUfcZfcY9vZMTmZWNMHvuOUCxyEk/yRZXeiXG42UGS3x
	 Zv6/BZpoSu12AZgmlb9pDoYlcQStJGZ3w8Ny+IekOwiSGBmo0LjVg/v5BY+XIW103nHes
	 5qeAEE9yKeIawoO5LYe2Vjt+/EIRsZbjSY90pd78j9wi5DKUgxwsUeCJH+1oFnrBPxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=blTvOaC3RApBqM2F3Q0zGlXUuh8CJDzDAzjorpAFHUA=;
	b=P6omD7psKbg+R2ttPBH+IPSKq1y4ifZ9GvRDZsgDSuuqNiKE7psFfOB3eMUwkbmylSlw
	 2LYQCExL6AvsqE5rKsulr68jukq1m2kDx/5oAE9+f1YRxwpju3pwJL2XEwMvYO6JFdeaU
	 BEeRlwBT5/5m5jMCSVjhRMxYkl7VsdMEZooPdCAOReti7uQLhrE/t1mt77HyCa9u0wXu+
	 sF/BID4oNqzMNNwpeToqlihoK7kWpq/v6AYF0qKY+X0RWQDaXO4DC+e70q7McxsreDOJn
	 TPlAvOBw8EER5nqaOBYIkKCyGAd10ydUIXDy3/FjEHDDUPJ4bYeBV2SK3+unIxu3PnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HR/gyn7P";
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A115606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 23:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A115606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HR/gyn7P
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4a85c656c58so2180845fac.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 15:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793661652; x=1794266452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=blTvOaC3RApBqM2F3Q0zGlXUuh8CJDzDAzjorpAFHUA=;
        b=HR/gyn7PTuCWQbXNaL916YHebz2mXBpZY9wcfw2r9hNJNHTzwWIieWI/3FVlhRm6cw
         uCTtS2BCKNWmv37sz0RQx8bMpTu8/X9cgzlQzqRCOI/P2JxCG82+TLG3hFjNk+fh3UHx
         J44LX6AL4pEPyhpBzGEEz+bKTCUdC3NNHzvvqjlBBnNwblaOMf7nf0h4Sx4Hhiczkc0c
         dreNto4zgTiRcKoHLTv0x3rY/vGuva870ctAtZyoOgyytmewFePghF2V8qgWqZvkDKWq
         0tzHbyPxEkldj+tZKUFOPyl3EH5KGuDZ6qMfSHKMki/nNhfnSW3AphdrvXHLauKZaFIg
         fZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661652; x=1794266452;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=blTvOaC3RApBqM2F3Q0zGlXUuh8CJDzDAzjorpAFHUA=;
        b=fqqUqaCZVuQk7EDyUXmvIQnysov/8kR9+T9e93z46gUzBtAjhWbduL2AQsc3gJSar+
         dRyEoUEBnHUKLKUtz/mIw2hGatzFNTIKFj8M/6XUg/PnBQ6VyW6zk8PtRhv+p0XXYHYj
         X9Q+ld37uL+talFX9t0nvt2kfXKcDb2I8NAgNLKkDZI6UuW7sMcP/oQIs3vHaFFMZ+bK
         gJEQa+PAPQ4rdzfboI+az6LW4lgnxF4b+2fub3ZAHxwPtRf2F6543VgTfSV5oMlhxMqe
         W9aTuhc/EIG3sgQc2i6Hdc5PydkPIQ97I/XudChzml9xKF7KgjeUDEQMO0SfKgJ99e9P
         +W6Q==
X-Gm-Message-State: APuU4Z9toM/XHrYt/MASF8wl78CU2T6Ks5geA3MRKBzKNwsYIO0R1EkL
	HmUzpPwDCWudTH2WGVqelzTfW2SXFnAsOlclVJFy6lVD9DO4xUCTiXeENrmLNQ==
X-Gm-Gg: AYBFou16Tndy5BgUmI7paxdJGrtvzpprHI7jcptLKXvgZOuEkwyyAnaCADsUvHmUAMs
	cVgqYcZkUkxDH/8Lpo/QfMOAtkNupcslXqq0d+n9OEwV5RcuMrzHxLpOLq8Gn4GW7TNZqgC0GXM
	dMnYJLcCJkZGZsF3LcoypArPbwhYsjbAndPEVhq59yb9g+RCd8OOZkov+Jq8c48qvSi/3l66Gyi
	b7yzcCyYihN6E0MJH5vTs+ag6lTTt0O8u/XYT7cIeJPGUIPreUxG5KU0RxjhyOenkFywtSKqxZC
	EcipkjfnYTeHj0gad4wq/QYfT6yNWGwDg2uGxkjS57bwgJDl5BxQn5m6PMYS4Rm49j0WiVykNRD
	SITo4Qdo0bweqvgsIBOC+wiCHzqzSIE62Raw+QONYhzwvc7dcTCgiu8s+6QVG3+z7SVPiX/d0VY
	nVlh2QrM8Cg9oETrYU3mUmmL0GcvgDhzQImUFzQnR954VqTPlWJZzbLV6Ke2vg6GPc0sFL8a1wI
	HJlgh430L8uWcU8dw6/vfFGaM1FwQRDkU46N9kdb4IHr3Zu9jv8JNYg877sXNRflOuwvZ0ZvjDo
	kKgJj6/b95eJstGmZXiR0HOzeOHDT6NhEbxML2luN0yZ2TCn1Fsk
X-Received: by 2002:a05:6871:5d09:b0:490:f2cf:29ce with SMTP id 586e51a60fabf-4a907701411mr6809711fac.36.1793661651959;
        Mon, 02 Nov 2026 15:20:51 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a92196578fsm8413151fac.7.2026.11.02.15.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:20:51 -0800 (PST)
Date: Mon, 2 Nov 2026 17:20:48 -0600
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, gitster@pobox.com
Subject: Re: [GSoC Patch v7 8/8] repo: add path.cdup
Message-ID: <aukYVs2nVla0yuSV@denethor>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-9-jayatheerthkulkarni2005@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927114420.59724-9-jayatheerthkulkarni2005@gmail.com>

On 26/09/27 05:14PM, K Jayatheerth wrote:
[snip]
> +static int get_path_cdup(struct repository *repo, struct strbuf *buf)
> +{
> +	const char *pfx = repo->prefix;
> +
> +	if (!is_inside_work_tree(repo)) {
> +		const char *worktree = repo_get_work_tree(repo);
> +
> +		if (worktree) {
> +			strbuf_addstr(buf, worktree);
> +		}

nit: The curly braces on a single line if statement are not needed.

Also, should we just return early if we are not inside a worktree?

> +	}
> +
> +	while (pfx) {
> +		pfx = strchr(pfx, '/');
> +		if (pfx) {
> +			pfx++;
> +			strbuf_addstr(buf, "../");
> +		}
> +	}
> +	return 0;
> +}
> +
[snip]
> +test_expect_success 'path.cdup cwd outside the working tree' '
> +	test_when_finished "rm -rf repo" &&
> +	mkdir -p repo/tmp/x &&
> +	cd repo &&

This cd isn't in a subshell, so it changes the working directory for
every following test, which I don't think was intended.

> +	git init test &&
> +	(
> +		echo path.cdup=$(pwd)/tmp/x >./test/expect &&
> +		cd test &&
> +		GIT_WORK_TREE=../tmp/x &&
> +		export GIT_WORK_TREE &&
> +		GIT_DIR=$(pwd)/.git &&
> +		export GIT_DIR &&
> +		git repo info path.cdup >actual &&
> +		test_cmp expect actual
> +	)

-Justin
