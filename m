Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834698;
	b=TSKsNW7Bls4RTWHXktLUAHlacTHiOKT+UkZagqu6LETLNdb5WxHfuhbz9YvQ1bf1LZEQ
	 DeKPQJN49e7H6iLhw4E+FBKxJbpETR1JHNzKhI+ombiwqsW6/UCN11p/q3Sz6tXnsvDWk
	 06IppRrW6zscdQC6DlmLyWkX0nss/9rb51rj58pCktsancjA/xBvFjN+Lf8HV9hrHJ1ay
	 pJrSibysoX3/BkeOmapxk8w1MmmOKisIJOT8Jmpa/Q0J+9Hixp4FwShH9iP7YY1muzZ3t
	 6tHJhRYlUPVIp835ZuLjDgFov43MW8dAGtigIZ6eYpOIveiv/X2k+V0qOfkfh48wZ5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=x2DkySolMM7K98afXDeoWw01C4ttZi4Y54kZiCP1sPo=;
	b=DRSjFKg9lLPYzTPG8WuxQ1UlX64kKRO8a/B3oWVHxkl2dBaPWjpltu60Q5Y7kmD1HXdF
	 Tcc9LOH5KColm2mqXB0GyG59VtkO1QcPx/y26WGnIswECa+YeamlvJYmoL7DaTaP3pyjj
	 5ucdH33P4FIwxE3DR9YhiassfyG3J9Sk/7ul5j4aTCZvI37HOrDavnjUAFSSqj+SWS5wq
	 VfKfvhxnL+uVA/R4NkL1X/g9zakmmxvxkzKETk85fMhiVdVaR4ytoeIYcgKevELIYgFdd
	 MacEI584kY+3pkN2VVLs7Y3KaAXb+4TjejaX2yx3lIunmBmIRbkyVCWCQHjwbURf+sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wF029uFo;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE506606A33D
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 13:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE506606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wF029uFo
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b56221d361so5336321a12.3
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 05:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794834696; x=1795439496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x2DkySolMM7K98afXDeoWw01C4ttZi4Y54kZiCP1sPo=;
        b=wF029uFoChbC5L5hxttSb+OV5tMnRkbWJgO/MkNE2Ta8Aik7nI78eucVopMjnSlR0R
         s1rhaLk0OYrmb9BTKzc6Knj6Jpyt34GUMA15t3Mhy0vaTgX2kjpNTOZh+awDeYepmoPe
         w+INWCSwU1lVgAp5lc7Z4Mewk6jcHl1TtvPiqst/sFzLVAtokVnTxCtkDNakbAnc7ABD
         GnpDEaJ816ZlGO9Etn88FJ3V6Gm8nZF5wL22xTaPH4npcbS+KQRDwLV3d8K/rN1JjrbQ
         b4tt/UfjcF//+e7W7WBp6TQHk1rUbZXLA2cnaNvLGivwTpUVUHyFmhE3fbTIdYC7cXTV
         pG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794834696; x=1795439496;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x2DkySolMM7K98afXDeoWw01C4ttZi4Y54kZiCP1sPo=;
        b=D8vEDzK0dKqz1YzerCBKVTEJdqxkGnpp5tmJCveomS4NyTWnVsIeoRMnc8YI6EetTO
         t424HaM6Ap2ANToiXJNI1M1WVq8mbCExUkohsVvEZzb5wVaKoj7n670ROWkGITtDsyHt
         lympSIJ2+w6nS/hdnSjiTJlZJPTYnWadIDRvM9V+7bTgGzYPEvG7k06SivFmDuOA8CG4
         p4YggQNGT9aeAKSqYsxYHGIlHg7FzXWZvl068D741d1bKLMDbXt54e1wk+NuxlJPfZac
         EfM1MPcLAGShSbyC2JIOvNhxH68vFK9uaKbhBgSodQC9YawU9uDEaixQH6MyW3fAOmRX
         t/qA==
X-Gm-Message-State: APuU4Z+tEqdoacBiyl+Ij7wZ/Nz2D0yOGXBc07ooNcavKRMl1DnaH7Go
	FQUGhEv1tnRH2lMem0e52v+8OUotS4w4fTJdq/dFrSRRgsXSBG/cyL4o4AN+qS7r
X-Gm-Gg: AYBFou3uZmZgrNEuXMOZf+/A07kL8gBWaucis5rKBCUTOMwoV6VDJLfcdq+61XjhpJH
	2ls9otzIAPM9YfUOIQfMduNj9uH+STadgtgbBIVIQyoILCu5KCByGSdCt/KqUlgfagHlc9J9wz7
	AFF1CJ2wcHqtI9VL8u9sf1JdZRWfPlZnXorGUPelATlNPGuZJTRYMG7XZnBm8+Z0gHTnrVDK3On
	re0h6i3UERGdTmX572yDX/a/ebpD/Yr5Q/lbgV68aJAtcCo4prU+HheFv/cyRc6xifWxhUnWsxf
	zcGJnTy+HHPk7rBjJOMSwDzy+LB/SZe2cQx3XS1eZ/Jm+bfrEBu+8qgLK95RWdRyLQbRojXU31G
	xWLFxyQCHcRM2mv8yn2K3J+yefwGsxQGYaftK2vKCl5y68cLVtnJ5h3wJQX55LQQfVXtKsOaGeI
	SHxiLOgCagt/5288QlIBVFrF958dhHEbW8gM1Ha60LgS3f3RLJpIi11U2OzNhfNCWgJV7Z1FE85
	BqWMYP53K7B5tycSOjVd9xWy4A5xUYT3/agum/TYA2+AY5FnVxiaYVSE+MsTNAHrGQPWNM5Ikiz
	Jj8TtLqbYwLVH7yJBIR9eZrqoomCVFvy3+ytrpL9hu2d4iLVQiny2MesO7B2vvqgMcaInHXwfGG
	cRCdYryf5L+CT+qQ5CBZVBeLml+Qm6bQVGDAkFXpJxUXucZlQ3ZTULWLGu+iF5Zz5nE7WM4Ux2C
	OvP4UV465INE8Rv9cKCStUnPdNJwXVw0nNjB4ZHgbKZEYTQr1qW70HGQc=
X-Received: by 2002:a17:907:2d1e:b0:c2d:bae5:27d9 with SMTP id a640c23a62f3a-c509639033bmr890311766b.46.1794834696007;
        Mon, 16 Nov 2026 05:11:36 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5c520sm421307366b.9.2026.11.16.05.11.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 05:11:35 -0800 (PST)
Message-ID: <b7abaeba-1dd9-45f3-ad63-e43c49ee48d4@gmail.com>
Date: Mon, 16 Nov 2026 08:11:33 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] read-cache: use istate->repo in overlay_tree_on_index()
To: git@vger.kernel.org
References: <pull.2315.git.1794825269464.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2315.git.1794825269464.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/2026 5:34 AM, Srujith A Poojary via GitGitGadget wrote:
> From: Srujith A Poojary <poojarysrujith@gmail.com>
> 
> Use the repository associated with the index state when
> resolving the tree name, parsing the tree, and reading
> its entries.
> 
> This avoids relying on the global repository when the
> function already has access to its associated repository.

Cleanups are good.

> +	struct repository *repo = istate->repo;

> -	if (repo_get_oid(the_repository, tree_name, &oid))
> +	if (repo_get_oid(repo, tree_name, &oid))

> -	tree = repo_parse_tree_indirect(the_repository, &oid);
> +	tree = repo_parse_tree_indirect(repo, &oid);

> -	err = read_tree(the_repository, tree, &pathspec, fn, istate);
> +	err = read_tree(repo, tree, &pathspec, fn, istate);
The only other way to do this would be to replace the_repository
with 'istate->repo' directly, but having a 'repo' variable is
just as good.

LGTM.
-Stolee

