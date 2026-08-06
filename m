Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53F37D133
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035259; cv=none; b=rnh+X8Gz4tpu+jzvX1dlrsQd6w0Ns9pkzFQ8sV8p5xvUnVMxF2ndK5VVjSjCQz/F4bie2/oG1jvucqljit1p2mK1FQRMKngrQEGV1Cs2s3SeeLdEtX3IHyo17e+EPV5ABr4+ZRCbXwFm+jwneowHsLTGEvBTksLRbHG+gbPUaI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035259; c=relaxed/simple;
	bh=mR5iNs3y1nv9T+E8YnkGnlei9ty4/tZMWhNP6yuFLPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fz9seZNzr+0Eyn2BSA4I8O0hTlnQCJEAAs0wJBOfPj5Wpcwy+vBLepR+RaSpENCzJxn2pcB6KcK4Q+hdS3lFo25EfoXjwLoMIv8tIE9QvtJnR66s2w6KXpqcifHIuAHum4krgCerejRtsryf0zLZ3zQ9JdhW0XcwERMWkWAWXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q5fVGhPJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ko7a47/y; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q5fVGhPJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ko7a47/y"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 37EF81D000AA;
	Thu,  6 Aug 2026 12:54:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 06 Aug 2026 12:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786035257; x=1786121657; bh=PiEaAvXKP2
	s3Yg5eaJKFg9RH+DFSR2QfHWxuoYAPv/8=; b=q5fVGhPJjMXGc67SpnAHxUzoui
	AnJ1t+wqpuUu0otnV2ocp6rYfKD9tP21eIlTRXePUfJjNh90w99J/UXoq+lUreWN
	Bk2ajzoUNgiqLy1NQ7vqHAH4qPQDyJkhPfX69v6CaQSwFKYhEHb9nB5+ppsZKDPt
	CswYOelcJnO/La6wfggX5Dx/1B/og0DTbvU+JWULCF/YAQoAMe62owHwMyWJ+obz
	UHCGLMibfE8qR4cw1Cq3W7nB7wFgvG9dtx8FvGeUeZTW5q0OU9dCpnkdEws8jpfU
	xHLMGJUiCdru810XlKDdEvPL2ekZzFJHQYnqwaaTh9LRgVgwjEl+Bu/KKgWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786035257; x=1786121657; bh=PiEaAvXKP2s3Yg5eaJKFg9RH+DFSR2QfHWx
	uoYAPv/8=; b=ko7a47/y9qYV6xkF2U7UijVdCAQPF8JHOQlZwneDwQ/uKz0iMLy
	t/ydFHwAU1tV9BGQ02q/LcZ4TLRCVyZfuJLM4Dxrs5dWk6rIZ0d8fqmupdYTwBwz
	J5QzPz0p5M66snXe5jrvgHvvl2UYQDC2dEf5KN/V/EPeJ5KgnXBJzqu+mq29OcA/
	RurntcRkXINqINp7kfd7xK80zIEhkpLifBt/uracFkdFCJc5cuIbpUJO4LxkiSIU
	BD9Z8yeul7Gn6vu01ntdLfpNsXtdoZFa/c3eyoOdmcCSmEU5KP4qLbn1QT3QkYdL
	grfjJaC4HHJReA/oA1NLIxym2Xt+bINjoHw==
X-ME-Sender: <xms:OLx0ame5feemuz9NLrP3iR69g3OGfdQfzxoJuc4ZGbnM3L-P3g0_vQ>
    <xme:OLx0aj68f7l4WERfn06tuymae3S6NmUPYABYefMVR61tjd8yHW2PtwO5l1bWOUEJS
    fx0FV5kq01Mi2Z07GtHgqX70csph7yF5HqrlD3L1vwGMz0u91x9uA>
X-ME-Received: <xmr:OLx0ahU1blS53PT1T5bqGn3Xjtmjgu4mczrpqmN1slnUiK8yRDN8UPByH9LI33coY1_xf52jt78F1Id5RaN1VBcGOMXfNTJsKw>
X-ME-Proxy-Cause: dmFkZTE/men9WZi+qivzt6bzv/eYUl4W91TcWCzKj8W7pfd8DWTwmN7i3QhQ7otrCp5Mv/
    AEY/6HUR64j5P3/PcmK0g5eWothw+cfwUC/0MzJ1qXLO9SByXOLSLSHMDtN2uKiwxmabHV
    y7kisBUsMjqNZkwXaPA56Js+OqY+C/mDNnYPTUhufUm+JxtP/FPvv0gUvh/+miCRBC9LdW
    roLW51u7Eq5Uidlk3N0bbdoUtAKCIDqctOhnK356p4i9J+3JUjq9jaxawbrdPxnKxB1TiT
    8wxMoKm4SORO2sj5kRiQEcjoawn8vvdh/KKiS4S/2IQyo0mfopjL7Bi0VJQT6mK0sZaLY+
    v9OqnbFlnclcJjUrmPQvf2OJorI5iM7O4XOiFOLNHqsEVqx1CNZMth7lnlsogsPNDMxj5i
    dAjHsumBwBuuoV5prw4Hn01W4LVAh2r/yMuL/MlRlNGuHYGjOF/QeqJuWUob/SBYDWz7+y
    9t1/TbRqIvU+PqDmBV5pL255NwRLOOxbW5u5PvOrALu3JvHq1YTRVNze1kcwZ2CAQfelYX
    J2E1fD/taq56JrZ121YyaYTL702SgoffBwDQCscPfxkvd2nXkeYm8Uc0+r3sTdyyWvQf+i
    DMgoqirTR1dJ0ZYxm4lnroP5rYYSdQ/6HivILphDvL81j8GR6SwpAk3sHmEQ
X-ME-Proxy: <xmx:OLx0aq7n5v8WaDqPDP0pCXbZqQXkB56HOZHGrlxoFjIy6ZDIO73bXg>
    <xmx:OLx0akrIVEiAOiansq4cMPQR5oQX_nL-Cdlh_jNc1hEhz6M0wcY0Xw>
    <xmx:OLx0alnic1dM801u1aPfQlzPaaBnMxTXLUUJbC7EJKyk3T9acx95_A>
    <xmx:OLx0aoPMxz8jrFhbrRS419b7fPq-lt5GpN4OBw7ichwXEbslTssfPw>
    <xmx:Obx0ajKZovlyhjOowPzIPCfyqL4TbxDpoOr0k8Evlmg-NCHpT6M7nCLR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 12:54:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v2 2/3] environment: clarify repository config getter
 documentation
In-Reply-To: <20260806092557.3951208-3-cat@malon.dev> (Tian Yuchen's message
	of "Thu, 6 Aug 2026 17:25:56 +0800")
References: <20260805115342.3939931-1-cat@malon.dev>
	<20260806092557.3951208-1-cat@malon.dev>
	<20260806092557.3951208-3-cat@malon.dev>
Date: Thu, 06 Aug 2026 09:54:15 -0700
Message-ID: <xmqqpkzvkx54.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Update the comment above repository config getters to describe their
> common behavior.
>
> The getters handle repositories that are not fully initialized by
> returning the corresponding default values.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  environment.h | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/environment.h b/environment.h
> index e7ec5b0437..1a58b553b5 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -175,22 +175,14 @@ int git_default_core_config(const char *var, const char *value,
>  			    const struct config_context *ctx, void *cb);
>  
>  /*
> - * Getters for the `protect_hfs` and `protect_ntfs` fields of `struct repo_config_values`.
> - * They check `repo->initialized` to prevent calling `repo_config_values()`
> - * before the repository setup is fully complete or in non-git environments.
> + * Getters for configuration variables in `struct repo_config_values`.
> + * These functions handle repositories that are not fully initialized
> + * by returning appropriate default values.
>   */

Do we also want to mention that calling them when the caller is
outside a repository is an error, or is it obvious enough?

>  int repo_protect_hfs(struct repository *repo);
>  int repo_protect_ntfs(struct repository *repo);
> -
> -/*
> - * Getter for the `ignore_case` field of `struct repo_config_values`.
> - * It checks `repo->initialized` to prevent calling repo_config_values()`
> - * before the repository setup is fully complete or in non-git environments.
> - */
>  int repo_ignore_case(struct repository *repo);
> -
>  int repo_trust_executable_bit(struct repository *repo);
> -
>  int repo_has_symlinks(struct repository *repo);
>  
>  const char *repo_excludes_file(struct repository *repo);
