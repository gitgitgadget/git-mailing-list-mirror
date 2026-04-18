Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C761F37D3
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776547847; cv=none; b=q1s80+xduWY+MXbaVMvjSzpDljCgp62Gisrw4XBjanaUh9QNcq2T0K3yiL2sR8LYzh3rzzSnbixii19/cOtPMgEOd88WWCBnhj90AUsHencvINhER7WzMm5jNTLjKP9dLShy8R1E7N8hYRJqfbwQILAIQpxj5NBjfm7Ck4Sounc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776547847; c=relaxed/simple;
	bh=iilKipN+1NhSSOchWgRik8GWtpX7xKWokM8qIZL9CVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1tgWBwWcPRSmEvjYAdMqwLVLNIIoZ4ym78Q0Ib375LXm+L/pCEC8enIIWuoyuTAymREKpgMkhWZS7ImOcDnoxI0CCQm9W4H62L+plFm5bTHm/v4gc4/UoFJ5clRW4u5SWlUWSJ+P3vw+d08k+k74Hu2cRf+YDnzIcLufnejZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FgMUDZwJ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FgMUDZwJ"
Received: (qmail 393273 invoked by uid 106); 18 Apr 2026 21:30:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=iilKipN+1NhSSOchWgRik8GWtpX7xKWokM8qIZL9CVo=; b=FgMUDZwJO4YTO/KxNsGAFZsbfyoxXt7Fvh3D0zuRtLuiuY+2g6fhTmdTu4hg1xIO/T9TD7r0mj3gwsZwku4nXFxvWSkb9075yKrnDO6gCL72tQAKnZx+E+QSiOAUdPhZpoQpAqVjFiyyGXOlbWt0TpuKu0+23VQJscI+iOQAv1XnUrKZqu3jcPyJ3xWkI4C46rfBsi+3Njz+DAOogylqXJaK+zTaszINsSK2wVTtJliL/4Cd3bynTaVPoSJChkxd6IanRACSNQjKT4Zebo6XoaoBFk/uk361lnTLevsyQrCFu++m/X9qdi/dS3PTVHxh1Uxw2x4jqFJwMonIgvGEcw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Apr 2026 21:30:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 895574 invoked by uid 111); 18 Apr 2026 21:30:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Apr 2026 17:30:44 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Apr 2026 17:30:43 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Ben Knoble <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?R8OhYm9y?= SZEDER <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 12/12] t: detect errors outside of test cases
Message-ID: <20260418213043.GB9632@coredump.intra.peff.net>
References: <20260418065009.GA2619713@coredump.intra.peff.net>
 <AA6F33AD-25C2-4AB0-A624-35C7B0BE0F66@gmail.com>
 <aePY1x9uO39p6WDI@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aePY1x9uO39p6WDI@fruit.crustytoothpaste.net>

On Sat, Apr 18, 2026 at 07:17:43PM +0000, brian m. carlson wrote:

> Having said that, I actually think that mksh may be right in at least
> one case.  For instance, this diff seems required for mksh to pass t1410
> and I believe this is actually the right thing to do:

I think mksh is wrong here, if it is flagging this fsck call.

> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index ce71f9a30a..f289fc11e9 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -23,7 +23,7 @@ check_have () {
>  }
>  
>  check_fsck () {
> -	git fsck --full >fsck.output
> +	git fsck --full >fsck.output || true
>  	case "$1" in
>  	'')
>  		test_must_be_empty fsck.output ;;

If check_fsck() were run by itself then yes, this would be a problem.
But it is always run inside a test snippet, and there "set -e" should
always be suppressed because test_expect_success does:

  if test_run_ "$test_body"

So we are inside a conditional, and the usual global "set -e"
suppression should happen. It sounds like it is not happening in your
version of mksh, but I was unable to get t1410 to fail at all using mksh
59c-43 (from Debian unstable) or 59c-41 (from stable).

And it is a good thing that this "if" suppression is here, or else tests
who fail the final component of the &&-chain would cause the shell to
exit. The simplest case is just:

  test_expect_success 'bad' 'false'

If "set -e" were in effect, then the whole script would bail upon seeing
that "false".

-Peff
