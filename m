Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5861AD3F9
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894422; cv=none; b=lh1hOBVAMhagy0sYjeZ1qA4bcRIj+C2h6rusOCvuN1/j9BRREyerJwQmNZc3G9ShI7X3a6DBzGKL3Z2jbMzZtd3f/ZwIvwDg4vev2qX86MlSJlg6tszbFj3fCw1CfVlogklnOm0XQIx7lRQqUV0p5/qGQgqSoWJobmLsPLtL7t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894422; c=relaxed/simple;
	bh=8KbyNCWDb0GmopdnjNdLuAega5sWyeoWx74VDvBkjdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCJ+EvS+0AkfcZcQzPIWudybSzjALnAs3+QWZuet7cEsE7M+PuPCzRAzAuIHGMT7xVjW6QylPxcK4M6IbwgBd4IvPh3eZKExipDJyHt6/UN3EjEUQrJkgaXTi6N9Dl0f6s8o/b8ZeIP2EHr7TeCSlHbirMnuBWDODknf1osmq1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=Q12g6sJA; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="Q12g6sJA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1718894415;
	bh=tRPwswGHIW/p7HONwqEIVPnBrdftGS5iqJfeQpxTW38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q12g6sJAKoJm13IYBw0NZRBwuT57uNw+n8pczMpDsratxVq5oqtrhGOmNRBWg2SJw
	 0Uiju+MyEQe20S6XonG/hnvfJtU7hDJK8lcGwFuUF9UwUPKmVSkdmFxDXWA/sufYrb
	 ii/izsqftdGRPQwlCF4Gq6jyf6nfMo/7ce55t9V3Qfhs29hJ0WGIwwOdYrZ6ughvWf
	 DrRJfdsTvUrxot0fioxI8d2SwjlEdYoBXJk6tNJ+nLDSNC9x8kXv4C5deqNeQFfbZU
	 46dKThb9HwXmCtO/pvzVDciRveyJ0jsisK0w0+UyE2WgscxMuSyo9y3UP2EakL+rMp
	 LWVlLEguzG/TA==
Received: from [192.168.42.22] (69-99-142-46.pool.kielnet.net [46.142.99.69])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id B9D323C0B1A;
	Thu, 20 Jun 2024 16:40:15 +0200 (CEST)
Message-ID: <41408b88-2938-4112-a02c-53876e20f5b1@haller-berlin.de>
Date: Thu, 20 Jun 2024 16:40:15 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-gui: Visualize * History does nothing on macOS
Content-Language: de-DE, en-US
To: Eric Sunshine <sunshine@sunshineco.com>,
 Ilya Kulakov <kulakov.ilya@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <38A18180-3CC9-411B-B5D3-36C5C32B6EE9@gmail.com>
 <CAPig+cS1o5bqK2Ph1fFt2wi6QaOO2=83xwoqoTLifA6z3NssXA@mail.gmail.com>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <CAPig+cS1o5bqK2Ph1fFt2wi6QaOO2=83xwoqoTLifA6z3NssXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 09.05.24 21:05, Eric Sunshine wrote:
> A patch to fix this problem in `gitk` was posted[1] in 2018 but never
> got picked up since the `gitk` maintainer seems to have disappeared.
> Considering that the patch is still relevant, perhaps it might make
> sense for Junio to pick it up himself and apply it to the Git tree(?).
> 
> [1]: https://lore.kernel.org/git/20180724065120.7664-1-sunshine@sunshineco.com/

Whether the patch is still relevant depends on which versions of Tcl/Tk
we are supporting. On recent versions, the whole AppleScript business is
no longer necessary, windows come to the front correctly without it. So
a better patch might be to remove the osascript call entirely.

In my locally patched version of gitk I did that long ago. I don't
remember which version of Tcl/Tk I was running back then, but my patch
that removes the code is from October 2020.

-Stefan
