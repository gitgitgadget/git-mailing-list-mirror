Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0703A3C38
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 04:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743739426; cv=pass; b=Gvw6jcujSw6ABbEQ8gAnD4cRWoRA23fRRzyKYAUBaOncI+0zkzH0Ja5yZytoKJilUk2x0jzm2iR9gR0X2GySD6imJK8AIsHQlhygVa6Vrn0taxPRwIqwQgn6n5IFVZWWrdYXRrZIUo6VOLBbdbCIpd/NYdndHaxnw0BO6jL/hCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743739426; c=relaxed/simple;
	bh=nOlHr5srUA9a3+MGzzeu5dowFzdfz54NqkMbjOfwszU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUVtjN7Ui81N9RLYmDmpgvYZquNgKqxKmonbyR3ibQmYTjCjRudALtJqO1cwCOgl+Lbc8N7CtcSQq+clYzWXVCH0003gMu8uQoHuFj8d/hKiLyTyq25zE5pYjR1Q49F6YL+urwfDyIeJxp+R9NMnemhrRM8Ra9t0AtakimfFXTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=emxf2VlW; arc=pass smtp.client-ip=23.83.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="emxf2VlW"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9419F8C046E;
	Fri,  4 Apr 2025 04:03:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a259.dreamhost.com (100-125-201-5.trex-nlb.outbound.svc.cluster.local [100.125.201.5])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 21BB88C2315;
	Fri,  4 Apr 2025 04:03:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743739417; a=rsa-sha256;
	cv=none;
	b=7RMtFQRKmIh1GXNlBLrAYdWqBmTd8NXovt28Z5kjVD+Rv2eliKMjuKEpncAx5HkPrsiUuV
	OrsconFodA6zdWdC5ynU59DgoBG7LjatnbF7jA/g4nhiZF5g88On6NgFTFnt6KCODQKI50
	LVqFQeIi+2JL61IvuMrVGOeTzZYo0JAdDJWLrSA5k1ms7f0rGt9Ezf3PmgBpK5pYP9oE/v
	NZg03RSsPgvghQeLCE2joOZ0HjIf0n114a9qDqxBA6O9oPSZ8aTXFEgGOPVFh5OW+KeFo7
	TZzsKCAb7DqkVPIjR24qKRYkBETDgkhQARB8hdUmXpjhJQtxRIvOcKPfXEJiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1743739417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=x0dh4jAzlBWINpO+44G9l+kyqSRP3WxirSruGUenplM=;
	b=tx4/yBymg7r8i3wDXz2SCr06tuz3v+fA2WeDG/a/YyaHMwBvLezIWvsYJfFJhzRr194yIl
	SswEgRpSwX5tnub7KZqKMMn27QBXAbvQFMfIr1m6ciMgoglzA/sYNkQow8cPfNrd92lm+S
	rLRMZIKB3KR0F4q6q6bv1UHH6n+gYidpddJ19Hiv1x2K/U1G4e2Q+OSyh7fVSgcPXYtZ2S
	K/mWKehWPVCl90X52XekYx+Xxx6di8RIIXUVHM4slBj26MfUO7WsNPelwSx3/bTUs2ibvd
	HDWOUFl4RT8pIJny2CtpMvRrHQbutR6C5k05pErkJHs6+pSy7dZKAr+jkmXQOw==
ARC-Authentication-Results: i=1;
	rspamd-5c8769d675-bz25l;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Juvenile-Hook: 1f5d1304450b150d_1743739417413_3999363864
X-MC-Loop-Signature: 1743739417413:1120637626
X-MC-Ingress-Time: 1743739417413
Received: from pdx1-sub0-mail-a259.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.201.5 (trex/7.0.3);
	Fri, 04 Apr 2025 04:03:37 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a259.dreamhost.com (Postfix) with ESMTPSA id 4ZTQ2J1S1Lz2r;
	Thu,  3 Apr 2025 21:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1743739417;
	bh=x0dh4jAzlBWINpO+44G9l+kyqSRP3WxirSruGUenplM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=emxf2VlW0KYSpL1Mdpq3KZ0DkJDC1yn2lOUR/PBswpAMJYvWLSveKxezOMaeUer3C
	 04ItD84is5UNWrmYBki22V28Fjfbvq751j4Bi6XHs7u5AEP88DlilnQXaesaNAlCu0
	 RCb3RNksNwoOVAFxj9tNbkIkFs5FK0GnOBgZjJZwBhKRm32MOXt4/MSqjpPdanSB0c
	 OTjTJl4R7vHiK5yzcbmNQsO1ODrhiKMQCDhVtWkTHr36Fl7joLL1MK3StSG+4u1CLU
	 lh6SWscE/FNpUI3fsv2u1imm73JrCFt4P0PI0wbnHkvZpjKwLY/J9k/0uKcC33WFsb
	 d2m47MeDYgMbA==
Date: Thu, 3 Apr 2025 23:03:33 -0500
From: Nico Williams <nico@cryptonector.com>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Elijah Newren <newren@gmail.com>, Remo Senekowitsch <remo@buenzli.dev>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z+9aFffZJ1pP9QQK@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <D8X5I3W7K1DI.2JYHGNY9L7ZD3@buenzli.dev>
 <CABPp-BECTrVp9X6bVmzU8LEeYsC3KbzeJvAaDPN+FgZz_uEhmA@mail.gmail.com>
 <CABPp-BFYoZ1cuUMJPhWhtgntS0D-E=ZF+8_KS7gC+ShXjTrEDg@mail.gmail.com>
 <CAESOdVB4yrDQ1v1BZtPiHDJwbaRVN6tixWg9eWNmBitXyqAh6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAESOdVB4yrDQ1v1BZtPiHDJwbaRVN6tixWg9eWNmBitXyqAh6w@mail.gmail.com>

On Thu, Apr 03, 2025 at 08:47:37PM -0700, Martin von Zweigbergk wrote:
> Yes, that's close to what we have in mind. I think I just didn't
> explain clearly that it's mostly harmless in at least Jujutsu if there
> are multiple commits with the same change id. If there are multiple
> visible commits with the same change id, then you'll just have to
> decide what should happen when the user tries to refer to commits by
> change id. We currently let it resolve to all the visible commits with
> the given change id. We may change that to be an error instead [1].
> The user can always fall back to using the commit id in such cases. We
> call change ids with multiple visible commits "divergent". They
> currently show up in red in `jj log`, which I think we all agree makes
> them seem unnecessarily scary. We'll probably change that soon [2]
> [3].

To support search by change ID you can use refs named something like
refs/change-IDs/<change-ID>, and the ref can either point to a singular
commit if the change ID is intended to be unique, or it can point to a
root commit which lists the commits with that change ID.

> So when I said that I think it's quite uncommon to have multiple
> commits with the same change id, I didn't mean that as an excuse to
> not consider the other cases at all. I just mean that I think the vast
> majority of commits are not cherry-picked, so we don't need to
> optimize the user experience for that case - it's fine if it's a bit
> more complicated to refer to such commits.

Fair.

Nico
-- 
