Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01601E7C2D
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413485; cv=none; b=uWoGowgTHprAvRu+jaFxtJ+D51q+rraoUui8ZA53wfD9NFWbQDERh0vAB9oYE1si9XRuTMEgw2cktVrN8kF5DpssLUXJXMO6aJgjYRM+zG8sc66BAJAAZFbTFPEUaVLACpm9lmvJ+O8E2a24yT/11YQ28CdjFPArInCOfs5J7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413485; c=relaxed/simple;
	bh=DH0aDac/e+UYXcsDJzQAQo40ucpnCb4LmlGtXsEXJT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CC4XsG0WFjxATSC17V3wbgWmNmwJClv+VoOHNO6GHGQ/GsRUcWGAqkRKT1O/Ho+q+iamD9nf7GkKY6h/X35kVsfaeaPpwtfzbRujJH+vLbE0+1fvErZFzpersBUpwRBogM8iQQQp4DHLiupAgQg53YFdlcX31BHU5dnolWMGYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=FtEjPQ4P; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="FtEjPQ4P"
Received: from cayenne.localnet (unknown [IPv6:2a01:cb06:114:e600:28d2:9042:8b81:c43a])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 0146BB00596;
	Tue,  5 Aug 2025 19:04:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1754413473;
	bh=DH0aDac/e+UYXcsDJzQAQo40ucpnCb4LmlGtXsEXJT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtEjPQ4Pmb9kklUqZUCr1XM6+o8X7QzLKi7KbaqP2VZQChbaOwSwX6LZ5BTA8InnD
	 C+VPvzqbSrwb/0+rFkQr0D+DUxUrQk1oIMpra4HMAU/RYVuzCylQqOLI60HqNMnmi7
	 tbKKa5CBgKipouw2e/Fx0c2/lBeg3pngYCVuaJc3/9dxBtDtScKSYh+/1yvh1r3WZ8
	 ZomtTZdtI1GijHPSzRKMEP0Gm+hdrFy07tbcCqkZAcLnLyBxQMAhRul519rWWFNqRJ
	 2os8K+MP5P42iaUxs1Ecz3RJ2m2Ik7l+OHWLKl/nJXl44rcHVaMvQiEaHkxH3YaRx1
	 UD6fpmD2xWc6w==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 SZEDER =?UTF-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
 Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Ben Knoble <ben.knoble@gmail.com>
Subject:
 Re: [PATCH v5 1/9] Documentation/git-reflog: convert to use synopsis type
Date: Tue, 05 Aug 2025 19:04:23 +0200
Message-ID: <5910515.DvuYhMxLoT@cayenne>
In-Reply-To: <20250805-pks-reflog-append-v5-1-050997db09d5@pks.im>
References:
 <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
 <20250805-pks-reflog-append-v5-1-050997db09d5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 5 August 2025 17:11:31 CEST Patrick Steinhardt wrote:
> With 974cdca345c (doc: introduce a synopsis typesetting, 2024-09-24) we
> have introduced a new synopsis type that simplifies the rules for
> typesetting a command's synopsis. Convert the git-reflog(1)
> documentation to use it.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-reflog.adoc | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
> index 412f06b8fe..707a9b39ed 100644
> --- a/Documentation/git-reflog.adoc
> +++ b/Documentation/git-reflog.adoc
> @@ -8,16 +8,16 @@ git-reflog - Manage reflog information
>=20
>  SYNOPSIS
>  --------
> -[verse]
> -'git reflog' [show] [<log-options>] [<ref>]
> -'git reflog list'
> -'git reflog expire' [--expire=3D<time>] [--expire-unreachable=3D<time>]
> +[synopsis]
> +git reflog [show] [<log-options>] [<ref>]
> +git reflog list
> +git reflog expire [--expire=3D<time>] [--expire-unreachable=3D<time>]
>  	[--rewrite] [--updateref] [--stale-fix]
>  	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
> -'git reflog delete' [--rewrite] [--updateref]
> +git reflog delete [--rewrite] [--updateref]
>  	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
> -'git reflog drop' [--all [--single-worktree] | <refs>...]
> -'git reflog exists' <ref>
> +git reflog drop [--all [--single-worktree] | <refs>...]
> +git reflog exists <ref>
>=20
>  DESCRIPTION
>  -----------


Hello,

Be careful that with the doc lint series I'm proposing, this change will ra=
ise=20
a failure: one of the tests checks that switching the main synopsis to=20
[synopsis] is linked to switching the definitions lists to inline synopsis,=
=20
using `backticks`. This check may be too restrictive though.

Jean-No=C3=ABl


