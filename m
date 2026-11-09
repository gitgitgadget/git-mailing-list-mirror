Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238905;
	b=1zVc2ahxelKXESBMEPHQN2XAob0jy6bPouwH4acDbHK9dXDu/ug1g0xf1ZT4lnMQTjy6
	 gIIbhozjH5uy6CUVJ2W8Not9fhc8aT+I0HRj1LuJORQz1aANZaxN6VJdJCETrQv3qI2G2
	 VgE9opk3e274WTf14sNLJAI2xK4XmVwvqgOoDHNVqyrbJI9tLo01klyhJkb2o4MUfLAbt
	 LWIMhX4yBoCbx3jX3iaua5J8jGKNJyHA2hu9fp9oNyhExX90OJwv9H0Qe7h5v5GkdVI36
	 u7swkY7e9mSfUBvLSy0UcLjA9Ag9Zl/jqnQCGDVGqovbYJTepra6H2YuEotZIw/b6eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238905;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=e51teFo7BcPMH+bM52PozgQQ6XGOCVHzeWvFD2Mdmc0=;
	b=ASgvXxQB/JV86G0t2/FYaKIRE7rDPwZ1cuzE8KNkuoTFjwa2+bG/EL5WkxXLHyfnO7bI
	 cpLu2Fen/XNd0RKz77HPCdTi4Ihnw064ZXhO7Z2tCTJ0mLCy9wG6YXHMujThBvOl480sr
	 ap65oKFXewoza0ShEOW1w83KZM4VE9J/q0aM7gBsTYW/f1K9rwB9fa0B22k9A8Sl2bTZn
	 OrQOmPBvI5pS8ApyOFNJSC9APTc5uLOxntc3mJBD08n+BBEJF+QDMfNL5c0zks3wFkTqO
	 VUIgOsRjbuym1bgG0hj6nCUwcxuMYgrIPKrC/E19t0JcJZoWjar0OynDeQKXx7fRowg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=3czrKGm9;
	arc=none smtp.remote-ip=91.218.175.134
Received: from mta0.migadu.com (out-134.mta0.migadu.com [91.218.175.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A32606EE8B
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74A32606EE8B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=3czrKGm9
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=e65j+P8FY0Q4cR45L92EOaRxmFq/Pd7JqTfkXegI/xI=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794238901; v=1; x=1794843701;
 b=3czrKGm9EdT7Q3iGfqFSmdpX7ZgXtQiHAP1DDOkQXEeDkKJo9fUMzaf4kF+MOPSWznH/EtMq
 HZSUE04vM6iQmC9yAt+LgcBtooBUZtNnGriSNo5zHFLJGf5o6A3aPNPJSFP09Ie+blqS55HGAIz
 XG0eb2RjEugAbWhlZN+HtRoc=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 796bcc0df2f1312a;
	Mon, 09 Nov 2026 15:41:41 +0000
X-Mizu-Trace-ID: 796bcc0df2f1312a
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Mirko Faina <mroik@delayed.space>, git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>, pabloosabaterr@gmail.com,
 ben.knoble@gmail.com
Subject: Re: [PATCH v2] completions: add some missing options for git log
In-Reply-To: <5735bacbd5c2c48eddafb43f75f7ddcdf402ff17.1793656021.git.mroik@delayed.space>
References: <63106e1dec45e82c7f132a18816b2d1fffb52752.1791921033.git.mroik@delayed.space>
 <5735bacbd5c2c48eddafb43f75f7ddcdf402ff17.1793656021.git.mroik@delayed.space>
Date: Mon, 09 Nov 2026 16:41:38 +0100
Message-ID: <87wlqmxb9p.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Some options for "git log" are missing in bash-completions,
> --graph-lane-limit introduced in [1] and --[no-]graph-indent introduced
> in [2].
>
> Teach bash-completions to autocomplete these options.
>
> [1] f756a3c78d (graph: add --graph-lane-limit option, 2026-03-28)
> [2] e9b5720bef (graph: add --[no-]graph-indent and log.graphIndent, 2026-07-14)
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>  contrib/completion/git-completion.bash | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c3a49e2e22..eab6309a69 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2395,6 +2395,8 @@ __git_complete_log_opts ()
>  			--cherry-mark
>  			--cherry-pick
>  			--graph
> +			--graph-indent --no-graph-indent
> +			--graph-lane-limit=
>  			--decorate --decorate= --no-decorate
>  			--walk-reflogs
>  			--no-walk --no-walk= --do-walk
>
> base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
> -- 
> 2.56.0

I'm fine with these changes, they do what we want them to. Looks good to
me. 

-- 
Laters,
Toon
