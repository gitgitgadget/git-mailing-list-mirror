Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D02EBB8C
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323813; cv=none; b=bgWXIx4c+u0c1xdgqqY9yUsXeGimT6/qwwT6JzuEq0RhCXZ+XOwnzRY2YYnb3YlBc2SMkjNE8v9T0aOqlHhrLDBXUkmGvJvvP8INMLkuIcXR1EYASE/lysuQrYGGVUvlp8UTYOQ4+8hsJKoc3oCd1IautpYin775fOkrWuTl62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323813; c=relaxed/simple;
	bh=dUfYNOmERL8HwP0Rr2ADn6ZHCMhYRwcMyx/Kz0SpOmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dn7OEM7I+FsXgRbq4hkV/9oyQEUg82Ry/s5aMBYDjPJAPlN0D3rXwlVOnlq0nfnqtSpnhnwSESFQj2+YPNRy37ztyY4dcA2+PZ8REMNFE6s2fmosOEw+Zd2uUtaVZ5B6AtNrDiyDc88p7r5cSkeuNYyfYfqqMFtyo512qX+BKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Yt8Ecj42; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Yt8Ecj42"
Received: (qmail 30216 invoked by uid 109); 13 Jan 2026 17:03:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dUfYNOmERL8HwP0Rr2ADn6ZHCMhYRwcMyx/Kz0SpOmA=; b=Yt8Ecj42Rt1ow5kLV2elmIOAEtxjzp+XKer5B0qFtuDmPXiAA/z1mO/2THA+ylZi+0FTI9NVPsIGzdJQZjv3S/X0Zjkm+CAPj+rcP0a+tyFmo9HmAP2uzIGNt5R+Q59TZ0Wx1kx6Z9/wL0K+Q6WwRp082sZEi02nVN4Lg/iYbrocIXV+hDA7Q+wTcgMNymZRS9ntH4+qygWAm0XadsiarikagNjtYHj7b9fwd12lCko7ak9DhUakOf1xWgv/BGY1HUP3MFwBsim4n+39wKJ3dncosykKDV4/k4Hq5z87GCyIWsQUXZD5LsxFFfAhUPWKimn9oHugnMbCZgiYVt3ZmA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jan 2026 17:03:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 51878 invoked by uid 111); 13 Jan 2026 17:03:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jan 2026 12:03:22 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Jan 2026 12:03:21 -0500
From: Jeff King <peff@peff.net>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v25 2/2] status: show comparison with push remote
 tracking branch
Message-ID: <20260113170321.GA265671@coredump.intra.peff.net>
References: <pull.2138.v24.git.git.1768298118.gitgitgadget@gmail.com>
 <pull.2138.v25.git.git.1768306316.gitgitgadget@gmail.com>
 <fa744efc598cd902e9a3a4a17b24134351ca5803.1768306316.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa744efc598cd902e9a3a4a17b24134351ca5803.1768306316.git.gitgitgadget@gmail.com>

On Tue, Jan 13, 2026 at 12:11:56PM +0000, Harald Nordgren via GitGitGadget wrote:

> Example output when tracking origin/main but push destination is
> origin/feature:
>     On branch feature
>     Your branch and 'origin/main' have diverged,
>     and have 3 and 1 different commits each, respectively.
>       (use "git pull" if you want to integrate the remote branch with yours)
> 
>     Your branch is ahead of 'origin/feature' by 1 commit.
>       (use "git push" to publish your local commits)

Can we make this configurable?

I build my daily driver off of the 'jch' branch, which now includes this
series, and I've found that for my triangular workflow the ahead/behind
for the push branch is just useless noise. I treat my push destination
like a mirror, where I always just push up everything at the end of the
day.

I know that the output can be disabled with status.aheadbehind, but:

  1. I noticed this first via "git checkout", which does not have such a
     flag (AFAIK).

  2. That flag would also disable the upstream branch ahead/behind
     output, which I do find useful.

-Peff
