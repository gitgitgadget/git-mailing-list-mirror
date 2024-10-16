Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4770D2144D3
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107486; cv=none; b=R1x0KoQF8Bbqr6wsaxBFSW3TM/z3vtdn7Trgu79N0UpJg4SZ7OU6IR9iQxWJR3X/IGP3GvE+nXKluP/fngSoPgzmS1ZlpzamfB/FCreyfhFDc+n3eOuWDKqTv2Ue7rDtVkafXv4bURPPaqOhcXk/JJjxr7yQ8jPjA5q801TZ9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107486; c=relaxed/simple;
	bh=Y89NGiT69xx9O0ej5KUzLxpM+gOegBZkci+h+GnNvAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpNjjUMLV+jGGsMaVwvU6/Y7VrhOfFcu2nw8QrMa41SbNpiFjpYIIm9Gz0Ul1YTknlmBB01FcU0FcF42+htWUmqO1XPoRngbqLkOS/QAnN+w1LbkQi3xnnNWU3VXYTpxwx1Wh7GQ63QiNUm1c0HTZKNKFyD/7nTJ2qGvd32WtZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=ixwNrY9l; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="ixwNrY9l"
Date: Wed, 16 Oct 2024 21:38:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729107483;
	bh=Y89NGiT69xx9O0ej5KUzLxpM+gOegBZkci+h+GnNvAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:From:Sender:Reply-To:Subject:Date:
	 Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=ixwNrY9lCdGnA3+jPhHhlOOMoiNh4qWSJB8gj6DxSw3/gphhUJBqMsu5tqL4YbuAm
	 QsCKuCrD2exuocATc36Tjv/ZFkmgoNmfT4F1NxnSqLzM8iU+AIeRhxqlsg4OpPMNWr
	 PWfT6dgl7ZEFmS4GnT/J4Z05slJLJTgI7YNZj7ks6cLtLwX91MJtnVUfuJsh1/ZyPf
	 ExMH9shjVCyf6CyERPKj60BLJkI5XPbrSa14llnMH8upCUOxzLPCBzJdve9laE0v2S
	 j82Cwg/XRUGA6pfEp/7YZigIv9iyQhXhNbWoZxjRRoeZSISR9rd80MGuCDkTPKv2QQ
	 g9tJkCgKcOadQ==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <oq3xwp36ntggis4nmdlj75uyj37fb2eiwdpgkxpm2mnatjmdf4@kya2n3oi25af>
Mail-Followup-To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241016182124.48148-1-wolf@oriole.systems>
 <ZxAUwxswtz4HmFeg@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxAUwxswtz4HmFeg@nand.local>

On 2024-10-16 15:32, Taylor Blau wrote:
> I had a couple of small-ish comments that I think would be good to
> address in a new round. But if you feel strongly that the current round
> is good as-is, I'm happy to hear arguments in that direction, too ;-).

New round sounds perfectly fine to me, I'll send it along once there is
some consensus on whether or not to keep the additional test.

-- 
Wolf
