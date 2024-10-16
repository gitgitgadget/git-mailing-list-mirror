Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F111D14EC
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066539; cv=none; b=KQLJ0a7A/uzH2lL8TgzurdU/kneuvElEClEI8e5UESxbB/iY0MG12h19QE7Cdh5KXuX1sYKNl/tG18Qv0jU/uY19Ppq0ihfYyhXHwCkbq5ePKcA5l6u5AF2t8+HQvd/kMvtVdZy9DEJUqoYT/+EGysDiCUjiiz14wuw3kq05VTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066539; c=relaxed/simple;
	bh=Lxk2H4bBbHYulf/hnZyxP5tvRhNQPQ+Hf9zjRDyhBkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S55dxoL9YUapfeM15RWi92XYJKCtJp8cZBARY15xcG/FzqsGymJ7uk4vLufwUnsfbxOiHtfjzFybzfpiri9Ase6KHEQNSwxXGK66GAGXcP87K9nKOiWW58sCe7pM/P+WrTjs1th6CVgrKuFiQIRY0gBwWmo8SU+X3TEuGpUBag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=sEoOs+JB; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="sEoOs+JB"
Date: Wed, 16 Oct 2024 10:15:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729066536;
	bh=Lxk2H4bBbHYulf/hnZyxP5tvRhNQPQ+Hf9zjRDyhBkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:From:Sender:Reply-To:Subject:Date:
	 Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=sEoOs+JBa2RihZqDobYNsD6ZNowi+CzhN1KYGQs0c7iGjBUKIlDVt7KHpgG4LqyNS
	 i7gDJkmOtjqQMSvNpkKnL5p1d3GhhWzithF2jKcJ2h3Ve6/MyXQPIYmWMATosbzPwe
	 16HVOY2JDUI3swYrBp2zkKlr5prELaXjGf1xrBZMkYxHMvO6kH5sNiuXRjZvDJyTJ7
	 G3Fi6PBFS04hq5wmvTt3eQ2tojOHp3PyLGI2EM8heCJGnxbtEAqr5QpqGkGTN0FMol
	 JKJ0/v2dqdYOOLmirZDgN+iS6twLI8SwK5lvWaZyAXstvZY3rLfojoDNz9pYkOdbuc
	 8cPPLNZ+budkQ==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <whst5ap7snkdns5k47tysuguusad5jp7vybahirshkypufhk2s@pnar2yiwcphv>
Mail-Followup-To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <20241011183445.229228-1-wolf@oriole.systems>
 <r4btv3hmwv6haflwhmjbjshova4wnth5mkbknsuuqcvose5lix@bvy5e6gxnit6>
 <Zw7IiwK5mi1rmqFN@nand.local>
 <Zw76iYXJQq9gJCj8@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zw76iYXJQq9gJCj8@nand.local>

On 2024-10-15 19:28, Taylor Blau wrote:
> I picked this up today and applied it to 'seen', but ejected it before
> pushing the result out, as this appears to break CI, presumably due to
> the mixed declaration and code in the patch.

Oh, I had missed setting DEVELOPER=1 in my builds so I didn't see this
failure myself. Will fix in the upcoming version.

-- 
Wolf
