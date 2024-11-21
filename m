Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBDA14BF87
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732185146; cv=none; b=Nx+NLIDiiZ32PTYmsmVzm3CUpPeQWHCQFIO3O8QT45m9a5SY//t7WmxMcVuEHb8DPzWqRMW/APP/9/n5dvFnR6/8l+z1MkvxLOUw1GSo21qsz9dZkLA8KTcVIiuFxfhFCBZE27xl8PRmK1a7w5b4D3/vRHVqPktPf4G3aVSij2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732185146; c=relaxed/simple;
	bh=VGG7NI/+L8KuTF+jDY152nnmsRY+C3h68Shqqy6wmtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz/pAEvbzuUCEYSNQ1pgE9I0BO9ZA9dr0u8X39zs/eBTMiQvhXZs/ks/lH2aO4SGHombdXufV+65a8gllNiO4tgBIz9SWmI83WzLzbzHLxps0QRYlXkb0woIK6Jy+RneGBw2eZj1ge2btAfmLKPVjK+uZI958R0DhNH0Dvd47qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MKYKM9LN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MKYKM9LN"
Received: (qmail 30695 invoked by uid 109); 21 Nov 2024 10:32:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VGG7NI/+L8KuTF+jDY152nnmsRY+C3h68Shqqy6wmtY=; b=MKYKM9LNY/DMB+S7u7w2eikf/eJCxZNufAMKQgpQYmiAp4kWPlMdoTZgR01h1/HPU1OnBPdk9XlBjVTehlp8rcz9FsqQ6LcQKUpzeG16IG28unq+whP9r8A0sLt518B2VcTulhBkL2oRRZZABuEmzrqCJKiO8TIxkQ+WiF4nkJlpuIf+No1JFmm2+GpGMw+OCPvTKyJ/UW4X0F5kPexaMrHo3dRr99mlYKX8yxsBXUpevqc1lFnDJS0jtBuZ4PaLRPZxHhXIr1O9zznzURx4bs4y7vx+BAy3QIWjE2yhOXIltz4IeR7v9wOKx4tiWRj1lDSyC+Jpc1PuOqUMzFY+GA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Nov 2024 10:32:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23142 invoked by uid 111); 21 Nov 2024 10:32:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Nov 2024 05:32:28 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Nov 2024 05:32:22 -0500
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: Doxygen-styled comments [was: Re: [PATCH v2 09/27] strvec:
 introduce new `strvec_splice()` function]
Message-ID: <20241121103222.GA1133719@coredump.intra.peff.net>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-9-6154bf91f0b0@pks.im>
 <877c8yti5n.fsf@iotcl.com>
 <Zz3Y35YI9ysFabUJ@pks.im>
 <xmqqcyipijma.fsf@gitster.g>
 <20241121081146.GA581647@coredump.intra.peff.net>
 <87plmosx58.fsf@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plmosx58.fsf@gitlab.com>

On Thu, Nov 21, 2024 at 11:23:47AM +0100, Toon Claes wrote:

> > To me the point of an official declaration is just to
> > tell people not to do so. :)
> 
> What do you mean? Do you want to formalize in the contribution docs we
> will not accept patches only changing the formatting of code comments?

I just meant that by clarifying our position we would not have people
sending patches adding or removing, or arguing about whether they should
exist during review.

-Peff
