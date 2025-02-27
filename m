Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166F18CC15
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681978; cv=none; b=DgpW1yeBJ/u9KKKMDdpDXpdMhF1Pb5CwPkjDqGTMGr3DdCMAQ9QRqvu92yDtjb6jCZgLGwFXNz2dxv44uKlR5TCrrtZdx5Ub+MjITpbB08wYTWFUBrVBtxuwtPx8Wq3AWrohGz19iPkCA4VbmW8SJtKQnxWmqfDKXjjp+iaIFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681978; c=relaxed/simple;
	bh=KfV5conwYOFUD8K1ecL8oeP4wLN2iKcN60X2gWZko6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gzexmkETFR1JVeMsSZNLXUmb0XtJvcQV/zfTDk1yQPZy6TJsFHY5aNnoK5A9V43RPiTExiF6/2XFMWFuFbiVGHMmtoc1YIzS7lYGMw6y4UJPNwA+zUn0coMurHeRTbAQcOu3SGc7HYfO/WIKErbMHdIMv6FbERXu26+0UymvYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sylXt0ve; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TahNqXFj; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sylXt0ve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TahNqXFj"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 78FA111400AA;
	Thu, 27 Feb 2025 13:46:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 27 Feb 2025 13:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740681973; x=1740768373; bh=U/isF9AEA3
	lhaxv8nxGWOZ5pUSq5/xlVQ1K8nVDhRWs=; b=sylXt0veZ/lIygvPtRw1+P4dga
	5bVjOK58uuSJVjYNXFC4otKE52CsQNbg9NfN4/Fye0IeRE/fhTt583uvqp0Qf4Ub
	k6qb8wLiyqouPViN2gjr0WUwwZHy1fGSbWpL8os5GvrcA9XIFcuqZKReQnkyo64s
	dUd8Om+VfsvxiZCFP4nEzyCknlF91fSxpcdrj68h54I3h05MZBVMLLALP1Y/snWO
	qb9VPdOV/WNyX+uE/gUNSaluBhLa8VDNCStXGjX5uz39KwnQIKZC3XwNcKNwdvND
	qRiykXFJ7EHHcdUt/WCfGwURvNkN3UVdrn9Un9+qVvHLXtMg4E3lKmpp0E2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740681973; x=1740768373; bh=U/isF9AEA3lhaxv8nxGWOZ5pUSq5/xlVQ1K
	8nVDhRWs=; b=TahNqXFjJhDyO+XApOKAqOeAWgKYr1D7yCVllXvXrvrhHPOKoRE
	/Xl4HXelatkzn70JVtaEIwbp9Hlp/gYYOVFWQJbHiuOuNKghKWxg4bT7DdU0wXRr
	9aWY+4IVGw1NsurHi4xsPhmsMxNzcC9n9d1I6B046zg1+TFEPcLU0ub2VTO1Bq2N
	c10foQxmcN0QJUODQatwJLQbYJrDxOAsVXtUjbs7zgtvEaSR8wZbaRcU7VM4X0h2
	V8Py1VGZUD0m0UWxlusAR/zm46qDkP1EKo1k7kwwsGBQuY4hVS5vDCQUQw//RtnQ
	FpPpOFvR+iaUszHqvLERLm0pOku+rqNhl0g==
X-ME-Sender: <xms:9LLAZxeFVkO5K5jrJsmv_ol_NyNpodHBcWbGGYEPrea8n8nKUtsfmA>
    <xme:9LLAZ_Nwk1LKY6Q2_vjNqwLZO3IV6uSlSpVUgAD1mEZkdrzjXdMG5qsWipZcAQDXF
    DoDe5LWVk6K2ZPiQw>
X-ME-Received: <xmr:9LLAZ6jBpXFv1dJIvXBCY5AZ2_MKfsH0dTNvASmMDoeefiXjt7r1oqtnWPNCwAI95IbtigWeTIK4bBKsR9RblJ50Yh1V-MU9fHDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkih
    hnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehs
    hhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhntggrihekie
    esghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhi
    lhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9LLAZ6_QU8sKp1x_GUXXwo7XcCpKE8ZIIOMdyELjHdsRm-5O3qwr6Q>
    <xmx:9LLAZ9vYxD8L4QmtVaz55B88Iz2dojQwN37EL8yXp1HLqYhY7asFVQ>
    <xmx:9LLAZ5Gzb1avXJ01dZVkI1gc4fexGEZm2AtnCE62SV0qx7_MyMY93A>
    <xmx:9LLAZ0NMLeMVMA0ZTMhmZs1yad6cb1YdTv0rcE-tj3FGydIUtz_DKg>
    <xmx:9bLAZzBkaB4Pv-zuc64rm0pkmk1MrMQ56bySR3ran6Nc_lD81md9Fr3U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 13:46:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  shejialuo@gmail.com,  johncai86@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] config: teach `repo_config()` to allow `repo` to be
 NULL
In-Reply-To: <20250227175456.1129840-1-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 27 Feb 2025 23:24:34 +0530")
References: <20250227175456.1129840-1-usmanakinyemi202@gmail.com>
Date: Thu, 27 Feb 2025 10:46:11 -0800
Message-ID: <xmqqbjun6xak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> The `repo` value can be NULL if a builtin command is run outside
> any repository. The current implementation of `repo_config()` will
> fail if `repo` is NULL.
>
> If the `repo` is NULL the `repo_config()` can ignore the repository
> configuration but it should read the other configuration sources like
> the system-side configuration instead of failing.
>
> Teach the `repo_config()` to allow `repo` to be NULL by calling the
> `read_very_early_config()` which read config but only enumerate system
> and global settings.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  config.c | 4 ++++
>  config.h | 3 +++
>  2 files changed, 7 insertions(+)

Thanks for tackling this one.  The other day I was looking at the
code paths involved and was trying to think of a way to "fix" it at
deeper level than this one, but didn't think of this much simpler
solution.

This is so drastic a change of behaviour that it deserves some
tests, I think.


> diff --git a/config.c b/config.c
> index 36f76fafe5..c5181fd23b 100644
> --- a/config.c
> +++ b/config.c
> @@ -2526,6 +2526,10 @@ void repo_config_clear(struct repository *repo)
>  
>  void repo_config(struct repository *repo, config_fn_t fn, void *data)
>  {
> +	if (!repo) {
> +		read_very_early_config(fn, data);
> +		return;
> +	}
>  	git_config_check_init(repo);
>  	configset_iter(repo->config, fn, data);
>  }
> diff --git a/config.h b/config.h
> index 5c730c4f89..1e5b22dfc4 100644
> --- a/config.h
> +++ b/config.h
> @@ -219,6 +219,9 @@ void read_very_early_config(config_fn_t cb, void *data);
>   * repo-specific one; by overwriting, the higher-priority repo-specific
>   * value is left at the end).
>   *
> + * In cases where the repository variable is NULL, repo_config() will
> + * call read_early_config().
> + *
>   * Unlike git_config_from_file(), this function respects includes.
>   */
>  void repo_config(struct repository *r, config_fn_t fn, void *);
