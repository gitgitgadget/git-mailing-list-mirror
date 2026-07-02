Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3D7394492
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988502; cv=pass; b=UL+8godKJjK3S2bsb82nVX0fQWjCIFwxFyt3QADprhWXOTD3JOkEAMolHjuHGh2PfK/7BDxSVhIEJT59s3DR5XfHgD+8ZCUqwdmsy8z3NexdSrcIkO3mUsU8tYV2iD7T/kUiix9B5Lyu6T3AQeYc3Uwxz4n3CkInp9R3g/emf4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988502; c=relaxed/simple;
	bh=cCGHeUwLGdFmghOAQuRyA+naYl638yLkWdu6q1Hpodc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z4dbtgMngNhtJODDB9jhjiu8ipHzI/lWirI7eN/X87ZAKbz+l0h4sapDZgVFU3y8Lj5tYCLJLJbwVK3IOGp2K5fUaqpBKi0E/LFEFG+HewP9zecp6p95E8eH3pcvRn9CVxT6GSc5KsfV6WtC6eVpn0LNoJNpiSq2WuAp4R6swSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=BYnd19Vz; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="BYnd19Vz"
ARC-Seal: i=1; a=rsa-sha256; t=1782988484; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nsGYksChFtBTR9bzu4RjlBDej6Oj62xhjYWukHwnXHe+oLjJCOKZ3nMkoWPOKiozW7FwOFQ1qlmOnW9KuP+p75jAknApqTtdayg1qgdN8UmaubDZAOK5qdIQ38iS5zHq4y+CnAp76/8R9q3JdtZGrgG4pNQTk/VK8ATkgDJ/Rt0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782988484; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+BDD82bfBwxUyowui9erjNHzpjnHAY2qw+hEsZE4Z7U=; 
	b=M8PCQ5RSo0oTgnCMgO+aIbij2CZtJc530XytdHnVOaigMw1I40Ug1Qb2w4fvCoS+5x6RUCUjUSZ6PGo6H6ePNAveEbTmHF4hh6CsMUsZ17idWfYX4+L/6EKUAJtbEBDqBf+6uI0nQT7DgE7eU6oGNqJto+uPeFO7oSs7rhofiTw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782988484;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=+BDD82bfBwxUyowui9erjNHzpjnHAY2qw+hEsZE4Z7U=;
	b=BYnd19VzWlfBpa2NWHA7WcwBkuC71pLHnUzNexwddBegA6RnH788BF/4P5FrZi8z
	5qzy8Qu1cDmQpIDxryxhTbj+pYM8JBRWDWNUxNQ5ypw1C4hJpbUP257+tSD70btQq4O
	id7DZRb4xrO1i4dbIbe7P2CSf9b3ypnx/x+yirqo=
Received: by mx.zohomail.com with SMTPS id 1782988482971102.26800776725315;
	Thu, 2 Jul 2026 03:34:42 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Mike Gilbert <floppym@gentoo.org>, git@vger.kernel.org
Cc: Mike Gilbert <floppym@gentoo.org>
Subject: Re: [PATCH] meson: restore hook-list.h to builtin_sources
In-Reply-To: <20260701193928.358825-1-floppym@gentoo.org>
References: <20260701193928.358825-1-floppym@gentoo.org>
Date: Thu, 02 Jul 2026 13:34:39 +0300
Message-ID: <87mrw97k8w.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 01 Jul 2026, Mike Gilbert <floppym@gentoo.org> wrote:
> This fixes a racy build failure.
>
> ```
> builtin/bugreport.c:12:10: fatal error: hook-list.h: No such file or directory
>    12 | #include "hook-list.h"
>       |          ^~~~~~~~~~~~~
>
> ```
>
> hook-list.h must be generated before builtin/bugreport.c is compiled.
>
> Bug: https://bugs.gentoo.org/978326
> Fixes: 2eb541e8f2a9 (hook: move is_known_hook() to hook.c for wider use, 2026-04-10)
> Signed-off-by: Mike Gilbert <floppym@gentoo.org>
> ---
>  meson.build | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 3247697f74aa..bdc83843e8e0 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -278,7 +278,20 @@ compat_sources = [
>    'compat/terminal.c',
>  ]
>  
> +hook_list = custom_target(
> +  input: 'Documentation/githooks.adoc',
> +  output: 'hook-list.h',
> +  command: [
> +    shell,
> +    meson.current_source_dir() + '/tools/generate-hooklist.sh',
> +    meson.current_source_dir(),
> +    '@OUTPUT@',
> +  ],
> +  env: script_environment,
> +)
> +
>  libgit_sources = [
> +  hook_list,
>    'abspath.c',
>    'add-interactive.c',
>    'add-patch.c',
> @@ -566,19 +579,8 @@ libgit_sources += custom_target(
>    env: script_environment,
>  )
>  
> -libgit_sources += custom_target(
> -  input: 'Documentation/githooks.adoc',
> -  output: 'hook-list.h',
> -  command: [
> -    shell,
> -    meson.current_source_dir() + '/tools/generate-hooklist.sh',
> -    meson.current_source_dir(),
> -    '@OUTPUT@',
> -  ],
> -  env: script_environment,
> -)
> -
>  builtin_sources = [
> +  hook_list,
>    'builtin/add.c',
>    'builtin/am.c',
>    'builtin/annotate.c',
> -- 
> 2.54.0

LGTM, thanks and nice find!

Sorry for the build regression, at the time I did the builtin->libgit
move IIRC only libgit was using the generated file, but it's clearly
safer to have it for both precisely to avoid these kinds of build races.
