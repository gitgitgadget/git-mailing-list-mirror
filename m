Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5190115957D
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524001; cv=none; b=VG8SlrwYfMxSgvoAHjTrRDyDrie3BRztPcmEDPurLuzQmyGT1S9sRRTZ32K9igeOCx21XGbRVA2o8/jz/cl+gM764A1DB6xqBIks4kdC/4VP0ygj8YEFikey2hCydrkQPcmLucpJAylojAF35yzTqlMmKnGKUQgdVefUcA2ApZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524001; c=relaxed/simple;
	bh=FtcgKt7H/kFbwpiHpdRSkplBQvc2XsBjMOaznuV6cq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmmpPu8P/CVWopySxXkYGVwKi99pcCDw9Lv+F/vQpJgNQlow1tOGIjbtKo+chQ0zqIKH7Vac/Sn7ue6xge/0QInlkRGs8v9oniZhaqrg98IGhMClfFKA5LIZSVIdneBqa690iUAewH/E/OzxoIq4DiZq5ltdwRmihfA6+idPhP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OAYkhHYf; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OAYkhHYf"
Received: (qmail 6573 invoked by uid 109); 18 Dec 2024 12:13:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FtcgKt7H/kFbwpiHpdRSkplBQvc2XsBjMOaznuV6cq4=; b=OAYkhHYfXD/CtT4NvIOtfYKK3wx6i9s4J1Jxk77FPz0sSfiVl649COHD41w4TfPvh1cqgkxWBZVkYgWb5k2Pyq0FIpUN9onb6t/4iVN9fNlvqQtLLpoKxcJL+Kx6kesR6agiJj/PT/VqXDhDQM9vfZnex9lsgmK+PfeccQ4+FcxLzkQW9v/YZcg7dxEk62rfvsqQzWTs2YG4Da+JnG4Uen1gpI2xB5U2AyoeiJp4MptVb6nbFB2f3dx9KC6m/T9g0uqsbmmD54rmdiivFZ8PJ3u6ftWDS38F2ck5OpCJrFnBK6nQfGMIzSiEwOzIJtWfR61hBDEYe2GvtE6EVE1kNQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Dec 2024 12:13:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24985 invoked by uid 111); 18 Dec 2024 12:13:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Dec 2024 07:13:17 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 18 Dec 2024 07:13:17 -0500
From: Jeff King <peff@peff.net>
To: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2] doc: remove extra quotes in generated docs
Message-ID: <20241218121317.GA696975@coredump.intra.peff.net>
References: <pull.1847.git.git.1734479267736.gitgitgadget@gmail.com>
 <pull.1847.v2.git.git.1734483422181.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1847.v2.git.git.1734483422181.gitgitgadget@gmail.com>

On Wed, Dec 18, 2024 at 12:57:02AM +0000, Kyle Lippincott via GitGitGadget wrote:

> Commit a38edab7c8 (Makefile: generate doc versions via GIT-VERSION-GEN,
> 2024-12-06) moved these variables from the Makefile to asciidoc.conf.in.
> When doing so, some extraneous quotes were added; these are visible in
> the generated .xml files, at least, and possibly in other locations:
> 
> ```
> --- a/tmp/orig-git-bisect.xml
> +++ b/Documentation/git-bisect.xml
> @@ -5,14 +5,14 @@
>  <refentry lang="en">
>  <refentryinfo>
>      <title>git-bisect(1)</title>
> -    <date>2024-12-06</date>
> -<revhistory><revision><date>2024-12-06</date></revision></revhistory>
> +    <date>'2024-12-06'</date>^M
> +<revhistory><revision><date>'2024-12-06'</date></revision></revhistory>^M
>  </refentryinfo>
>  <refmeta>
>  <refentrytitle>git-bisect</refentrytitle>
>  <manvolnum>1</manvolnum>
> -<refmiscinfo class="source">Git 2.47.1.409.g9bb10d27e7</refmiscinfo>
> -<refmiscinfo class="manual">Git Manual</refmiscinfo>
> +<refmiscinfo class="source">'Git 2.47.1.410.ga38edab7c8'</refmiscinfo>^M
> +<refmiscinfo class="manual">'Git Manual'</refmiscinfo>^M
>  </refmeta>
>  <refnamediv>
>      <refname>git-bisect</refname>
> ```

BTW, for git.git patches you should indent example snippets like this
rather than using markdown backticks.

Because it's not indented, "git am" thinks that "--- a/tmp/..." is the
start of the diff, and the rest of the commit message is lost (and of
course the patch does not apply, because we have no such file).

Leaving the "```" doesn't hurt anything, but of course it is not
rendered by git-log, etc (nor even GitHub's web interface, since they
don't assume commit messages themselves are markdown). IMHO it is ugly
and not necessary if you've indented.

Looks like Junio kindly fixed this up while applying already, so no need
to resend. Just thought I'd mention it for the future.

-Peff
