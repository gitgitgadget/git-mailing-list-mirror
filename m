Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786A241690
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769936592; cv=none; b=o1G2wvB11yIpjZflc9l9wzmpOxXnw3nd82h+K26vliLRmPfJXXYsRuLOAdRQX1HGRJt6IEmtIudJluu3AJIF+mMxu/XJUF+2rc7yau4FiKWYdM4PtoZL5D69EJdipYZQ7nOn51BiMwTRF8xcHtPxB5XTytj7L+Qk4M0ACRp4K2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769936592; c=relaxed/simple;
	bh=52/Khxc/sjH9AVWGN5ET3FJ2gOAl6LBKZNsSNtQilYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxR3eeZAEWnJxUBXkA7R4wlAR8mjFxEGoKwQ0UloREpwKUwS/i0pkfipldXPitgRd3cO5TPIcoEM5Af9qWxM9lcxA1QzRbNtq/h6Ou9x2ffKggUKHD0U8Q9cGaDKMJePp2Q1krMosRWTxyj5WaTofR+fBYFEbQERIIGNJlAXvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=UUUO+MCn; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="UUUO+MCn"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3d51:7a10:3981:3744])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8103FB0051E;
	Sun,  1 Feb 2026 10:03:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1769936587;
	bh=52/Khxc/sjH9AVWGN5ET3FJ2gOAl6LBKZNsSNtQilYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UUUO+MCnytinyhX0oBMcL6ENwLcuvt7BriGpfvZaYAFuJiFer2B1kkWxeAjBLsjPB
	 +j2hWtLeGO6QHJkyKoXrRwkmDSXI8F/5mXZhMX5LQhZykuWjvMNnTJpfOms1Mpe9cD
	 9fPWlDgJpaBArMWIVkxsN/HAU6hQ9YeO1eVIf0paBNDCEY7Lfifbtioksprtxgq0zP
	 hpRjK6olNV/6V1BNLAkM9J8Yj0/dX0FeTjZgMZKPVJd+ixhV/f6xvJufdPi4m16b7u
	 Nubnj4LlVN23xV4hqFdGdKx/xOxbbGmtQo8jcIn9ozjfhp5P5qS5K3+eksmRShp9n0
	 3tdXj9CoPLeIA==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, William Hatfield <whatfield.git@gmail.com>, ps@pks.im
Cc: glencbz@gmail.com, avarab@gmail.com,
 William Hatfield <whatfield.git@gmail.com>
Subject: Re: [PATCH 5/5] doc: document reversive traversal and related modes
Date: Sun, 01 Feb 2026 10:03:01 +0100
Message-ID: <4710431.LvFx2qVVIh@piment-oiseau>
In-Reply-To: <20260131214309.1899376-6-whatfield.git@gmail.com>
References:
 <20260131214309.1899376-1-whatfield.git@gmail.com>
 <20260131214309.1899376-6-whatfield.git@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, 31 January 2026 22:43:09 CET William Hatfield wrote:
> Add documentation for the new --reverse-traversal, --append-superproject,
> and --reversive flags to git-submodule.adoc. These flags enable post-order
> traversal through nested submodule hierarchies, which is useful for
> cleanup operations and dependency-ordered processing.
> 
> The flags only take effect when used with --recursive.
> 
> Signed-off-by: William Hatfield <whatfield.git@gmail.com>

Hello,

git-submodule is being transitioned to `synopsis` style of markup.
See https://lore.kernel.org/git/
05e68e28257cd450463d253abe9b2995759bdc10.1769462744.git.gitgitgadget@gmail.com/

In the same move, there is some work on style consistency of the manual pages. 

Below are the remarks on what changed:

> ---
>  Documentation/git-submodule.adoc | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/git-submodule.adoc b/Documentation/git-
submodule.adoc
> index 95beaee561..2be477952d 100644
> --- a/Documentation/git-submodule.adoc
> +++ b/Documentation/git-submodule.adoc
> @@ -437,6 +437,26 @@ options carefully.
>  	only in the submodules of the current repo, but also
>  	in any nested submodules inside those submodules (and so on).
> 
> +--reverse-traversal::

Now, options in description lists are backticked:

`--reverse-traversal`::

> +	This option is only valid for the foreach command and requires
> +	`--recursive`.  Process nested submodules in post-order (deepest
> +	first) rather than the default pre-order.  This is useful for
> +	cleanup operations where nested submodules must be processed
> +	before their parents.

Please start the description with the actual action of the option. Then, you 
can add conditions, context, explanation:

Process nested [...]. This option is only valid [...]. This is useful [...]

Thanks


