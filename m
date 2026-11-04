Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824743;
	b=P5ywqt7xdZYd945CkD5ecoXcCL9qjLPMn2UbFtZPHsYI2G4MJGn+GbzdB/l1ffVNtFH3
	 iTmHGCCl7ud2tk6FumKCNvR577KLGAUQX7KTpuCygDALs2FbJjAR7Ql0gfoRJ+C8CaPyH
	 51Upha0NLaOowtXtZBR59zIy8nPITr0JlyyJXP+iNsEdVJQwUM28lVFLzy2p9n49VuMiy
	 zbMz28+1f+y3qzM3Vod9+fPwKPJwaQaj4JgfNhGVfLPi93cef7KNnt3x1ENqm4R0ACB1A
	 AH1ssbvKkgOe7w0xWOIO8WpDKdpVbJUMtjz6pgEusOgQCt+UqxflzKtvFVLchtZFLgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824743;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=RQLT4/m6SmLkDoQGMAigpNpqfHQEeDnFek+K9AUPCgw=;
	b=qOwSGnrUwn6BHG7zJVJJ+/TxOzldVltjxDMR4VrO+FRR+LfJiUxBVgf3LbsHr5SzjrWn
	 opF9NFhgSlUDyEDTtuNeSyjmA25MzVzPubNeOVpotjTwF9WftddZS3Qb23HOy9+wXqcha
	 LmPbiQdGm2gq7Fm6nXJ+i8V1Pi4UvGVHLZBep6zKYdcE5yddUOOmi69AQ2k3C+f6dLDLr
	 OSn8xLzL4p5xZCxsWO5iCksstcOfvbCtonQ9dadFRReLPZrEirbBwdQwQ708K3hrsunqu
	 qR1Z9uDP5FAIWo2+g3xgtk2JFhm+lmz/O0/I2dT2KVcsLRRewft3+MvGJQwa4wXIm0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Kr+Mck46;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NfB2KOcH;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36393606B2EB
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 20:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36393606B2EB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Kr+Mck46;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NfB2KOcH
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 51D7C140010B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:39:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 15:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793824742; x=1793911142; bh=RQLT4/m6Sm
	LkDoQGMAigpNpqfHQEeDnFek+K9AUPCgw=; b=Kr+Mck46hYHv9BjNX2hp6ZVWMQ
	yTxKFtqxGHuk87aLSXMWuG6ibNgXJC/9t7tnHOI3J1hFIXTNeNk8B8ZP0CCYj1Ls
	cY0NkzGN/XcEZ5gMcC5wuLvZHFoagLwhEgjUWKBq23QZSG1HpjpRDDzit1gy+No6
	rMT4cqwQ9VXxYc8fuCVUni0Zk7RBV09w3VKrJkEvYVY5yOf+s1i+G6fWkINXzKes
	ClVyNfyM1eY798pu01OvRIdY6f8G7jdymzCBDkANmW63oNVLAI7VPm6NQCNqoShD
	BIOu0BU7A+FrPIiwhVQt8FU1kVtxSZsoAM7N0KroRjDaLzcPjQGLSqmxNRNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793824742; x=1793911142; bh=RQLT4/m6SmLkDoQGMAigpNpqfHQEeDnFek+
	K9AUPCgw=; b=NfB2KOcHiuBOfY/Q60fJeyp/+Ds7OfNhIqtuAKErNycsX5sWNhx
	wMKNNbSLus0Qla3j/7bQZJLluDuVz7UHLCa0CIlo3zkkMbwSV7b5rFTNJkfe4sRB
	eD8YTtJ2eHG2oZfWekVyBz2fjyWqVbizIXAcammmP4RTqZhw/Ni2leeX+bTP9345
	sT1U/YSXK8Va6U09qGXXSfuEWANEtc0IZu3ndrOJjgB7xrt42YRwqzZGz7WB6BOv
	smLDx/GNszY9VpeWWyk7O6Lq/CiRDZibmcQHhzd59pjcuNo0WoOl4E74Q4U76q6L
	HyyyUoR3qAEKKQVBvtAL7BghYsg5xFPU7jw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793824742; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:a3aMoTstA/0FU4BvAo3w9n5HF/88b1ymaOpN/XuYVbR1JMc
	c1ka4ptBGF7NmZnhNmi018jRriyImzQK7u8/6AfTYc1vVKYdCkoz2YWzZrlgMBK8
	O/bfd4lkoCWSnuvzEkIzI1h2AZdTSmCrIxp9pHF5dxg8w9G0iDSOxi0oDK5bHTBf
	NlowFthn1h/PrUfnFKzX06Z/2JDQMpMXnj/179pXlT1pLfMW7KS4h40RmW80TTZq
	Aqq7BPBywDnkPcYA9B5oCFoOx5k8eJZ0ofQc3wTjeojHwMtaJR3T6dEc97WaDEzp
	s1PkB1MO18flSdyh3ndwCAhETSWnkb0XpvNGGsg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Rp9A2MxSkjWLrFrYXP+0yc5As3x8f3OedYoXqnPp/3g=:cGW4WBTnVthCJyumGgYiMDc+r+nnB+8SlgUWoeqcQBA=;
X-ME-Sender: <xms:5pfralu6qeUp7rKL3v0H42ZUf-4mCcWLVZ9ZjhfP-DVyvsG2Cdi-sg>
    <xme:5pfralUBwxel7QmTKNO1CAedKTK3Ewed86-Za2B9bgT38IItzKTr_P_-N6pcsBUpm
    rQkjtaW4Wa2cQMnQjMmN42pURfEmW8wT7o2EMtsmgCoKrtHwTG4WcM>
X-ME-Received: <xmr:5pfrahGCqOSPw8GqklQTB2DG_YxpqeT98k5CyjxdHQBjKT3-CuPRrhq6GwwCE8KWMNJnK5YmEWZtMlMrzko0YOgV2duvjn1qaGcq>
X-ME-Proxy-Cause: dmFkZTFAQ34V2jgkYY+GmYtnATjdg6X/AUYBj//z5DcnsbWtn5aef2jT8kojplezGC/4Kk
    3+jNZ+JTGb5CfgsFuFgTV8sD5lpiSWwGjXvySVDKFQ8H9GWAgbjYYAN3IOUnP5tCiTqMBw
    mAvE3Tc7rs7Wa7RPmp7a0tfv3tyPfPC85j0qdQKoW9sHnfrmThVL1LNUD0n8/39k8gGs5Y
    cfUHrEwNXDnLcVwPC+3SEK4SWxrFwQDx0xZb1Rb3crFk1+kjqycy1aVqDGH9jxjR0ff0j0
    GurBIE5iXbby9vtHsEH1A7TBaRrOL8tixC4Tkv7PsEULi6N8fzo6g7eb+Yhq+Oudpt02gw
    CXTHYKSepUtI5+N2pymY4POQca0gcgEjQnGICtUP/pB3tiN1awC3yUgd6Tkn55o/11aY7k
    xji5aUldVZHXmDdVkfuFvq/aUd2+W5uPn4EU30ClYbNqPbU6gD0Gs+EJCtS8YCO9MyK81K
    Nh1v057/GZ7zsoVsGZMAD59N3R4MbZ4wjfOtQNvHzpZy/86W+4Tk/Usrs5p5xKEKcbDBX0
    BSPW6G+INgzvRfB4qjiwuEfdveXbUTU4owzLNhu8cUsoRfZXEFfX98URVycj9a9nqWj/X0
    DKwWWVgD/QS1RPUrJN8WMTMFehziNxbaTMRs8rPSn1Xv+w40LlkOXoTPwuCQ
X-ME-Proxy: <xmx:5pfran3R5-uovBXKX3jmyMH2aULAcANoJ8Sa9K0AzPn2C1hKnFJr6g>
    <xmx:5pfrajM9PHI_o2hZzOOzlk8DB0h48KAZT_0R7XtIYtqGJFDEk6b2YQ>
    <xmx:5pfram46omsOB4ouSpvlrLN6tCUYs5wpwUkSzLr8EtD3Taul8fjSYw>
    <xmx:5pfrat38Mizwqi_cy0D37kBWb7HHSs-FPFeOHgjVIv7RY3Gf83JVyA>
    <xmx:5pframMD4IaQyA-URW4yUlDfTp6PsS3BaSGJ3iQGISoonc9ayHx6NRck>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 15:39:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes.Schindelin@gmx.de,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH] fsmonitor: invalidate untracked cache after losing history
In-Reply-To: <pull.2295.git.1793806679163.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Wed, 04 Nov 2026 15:37:59
	+0000")
References: <pull.2295.git.1793806679163.gitgitgadget@gmail.com>
Date: Wed, 04 Nov 2026 12:39:00 -0800
Message-ID: <xmqq1p901gd7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
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

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void invalidate_directory_recursive(struct untracked_cache *uc,
> +					  struct untracked_cache_dir *ucd)
> +{
> +	invalidate_one_directory(uc, ucd);
> +	for (size_t i = 0; i < ucd->dirs_nr; i++)
> +		invalidate_directory_recursive(uc, ucd->dirs[i]);
> +}
> +
> +void untracked_cache_invalidate_all(struct index_state *istate)
> +{
> +	if (!istate->untracked || !istate->untracked->root)
> +		return;
> +
> +	invalidate_directory_recursive(istate->untracked,
> +				       istate->untracked->root);
> +	istate->cache_changed |= UNTRACKED_CHANGED;
> +}
> +
>  /*
>   * Normally when an entry is added or removed from a directory,
>   * invalidating that directory is enough. No need to touch its
> diff --git a/dir.h b/dir.h
> index 83e0f648a8..d2de762da8 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -596,6 +596,7 @@ static inline int dir_path_match(struct index_state *istate,
>  int cmp_dir_entry(const void *p1, const void *p2);
>  int check_dir_entry_contains(const struct dir_entry *out, const struct dir_entry *in);
>  
> +void untracked_cache_invalidate_all(struct index_state *);
>  void untracked_cache_invalidate_path(struct index_state *, const char *, int safe_path);
>  /*
>   * Invalidate the untracked-cache for this path, but first strip
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 107767527e..9c3079f64a 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -713,8 +713,10 @@ apply_results:
>  		if (is_cache_changed)
>  			istate->cache_changed |= FSMONITOR_CHANGED;
>  
> -		if (istate->untracked)
> +		if (istate->untracked) {
> +			untracked_cache_invalidate_all(istate);
>  			istate->untracked->use_fsmonitor = 0;
> +		}
>  	}
>  	trace2_region_leave("fsmonitor", "apply_results", istate->repo);

That is rather a blunt instrument, but being without acceleration is
much better than being fast and incorrect.

Will queue.  Thanks.
