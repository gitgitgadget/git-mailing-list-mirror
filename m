Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456221CD06
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 05:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244442; cv=none; b=iCaj5vVzpmuHXXl2eRjs+ZvBJRSaTgzW13d0fSbhDBbKPq2JlyMzs9LGviAZxo5eMXHJQIKQKPOEn/DQtbV6ioMvimvWQVs9nh0k72QJZRBZTANl8RQVjNQbZ3Ax2CyCpAEtazg75fyt8UtioX/4Wukj/XD8B9QIoDfIMAf7kRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244442; c=relaxed/simple;
	bh=/YpdGszT7fvAbiOPFFGuO/5BdtK+qOg8Rc5TSStuOsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHF/f8XIUN8Hce8SBQeKIxbncc9FdYqjFUFDnlapL/cSHOGPVTzc2cUdn1gReb70zzXvG2o5p+7pC/OOxf7Nll2c668mUyH1dHpTLd/JcVMIYy+9WBd6MXyczQpTj9xC7N1yEkkUv3BSKNBfNWV1sNyruifZqu3JcVvDQMyG/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3640 invoked by uid 109); 16 Apr 2024 05:13:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Apr 2024 05:13:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26749 invoked by uid 111); 16 Apr 2024 05:14:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Apr 2024 01:14:03 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Apr 2024 01:13:58 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>,
	Michael Osipov <michael.osipov@innomotics.com>
Subject: Re: [PATCH v3] bisect: report the found commit with "show"
Message-ID: <20240416051358.GB1745631@coredump.intra.peff.net>
References: <965ae345-fd58-c46c-5a7a-de181e901f21@softwolves.pp.se>
 <CAPig+cQu15HzZkeT3+oG3U7iFax5_GYUB=uqwuJxshw-PD=VHQ@mail.gmail.com>
 <xmqq7cgyl3pr.fsf@gitster.g>
 <CAPig+cSY3vp6V=4SWmxyCi+7QY74eGnzPM6bu5LU5j00n8-j5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSY3vp6V=4SWmxyCi+7QY74eGnzPM6bu5LU5j00n8-j5g@mail.gmail.com>

On Mon, Apr 15, 2024 at 05:33:29PM -0400, Eric Sunshine wrote:

> > Curious how you trimmed the trailers from the submitted patch ;-)
> >
> > Although we do not use Cc: in this project, we do recommend use of
> > the "Reported-by" trailer in Documentation/SubmittingPatches.
> 
> Sorry if that caused any confusion. I wasn't trying to make some sort
> of implicit suggestion to the patch author (such as "don't use Cc:
> trailers"). Rather, to ease the reading burden for others, I
> habitually trim off chunks of the email which aren't relevant to the
> portions about which I'm commenting. So, although I always leave the
> Signed-off-by: intact, I often trim off other trailers, sometimes even
> parts of the commit message (replacing with "[...]"), and, of course,
> entire chunks of the patch body.

FWIW, as a reader I very much appreciate when people trim their quotes
to the most relevant bits.

-Peff
