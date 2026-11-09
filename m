Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237703;
	b=q3kQ0h9HGJuq14CKXfka7U/SKP2Xeic78UvAAxUi6VD2bHMG1gEt6uEz3Z0qt+6QW31f
	 F3Bn8quxPH+Fol0NG4Q7uWcFctXd+KpCxRVRG4F5OVctYQfPU4hIOhAl41pjQNye7j9jS
	 UU+znU/JvB+A3Mft6j13yWcomhwvkIdMN2wkcelzfhpFrH739P4S6hLHeRTw8KZzpZXF3
	 6xTw+UXYPpZXiyNHMwzNzQfUZrBoY+B7+ZQOHw6bZPPgYyNka87s/qmNsZ+v7XNdMh3VW
	 OO8TSzE+rCWgTWf0tyM1T6Raexj4Fl8pqmQJ5bjBHJ9meu3R4/82vkn2zUTOJ4aGJiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237703;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Debian-User;
	bh=RccD10RPQXTQnxGzh9R7Fuil8vnJyXL9aZCfDhLFl+M=;
	b=MxfKFd+N5NMPoBS4LXY3FvuKSF6iaZrp0C3Yi8/VRxHuuswbjaT9NlurwTYmG7W0zoMa
	 LGzTMq7esdx8zEel8nPgGVG1Q7gzq01tbAilkJzPF/6/GO8+NBPo6xFxJwwIJa/PpIor9
	 NJAU1dlZagvgwQn57MZ/DlVhBe6maw+oeO7vRBeQH3C3U3ieYENIQtLenRv7su1v8kxcW
	 mS0kn2XORwsSyQZdIeUkFy3SxQHesSy59xnm2b+nKZgEVLFM0ovKmgbU2ZwR2VXjyj/TG
	 QHpgHh4CsElSc2+PQRcLhMwi9zdfN/VErbTYFFpPNj0fUe/p7BUFU4S1wyRNEP2iJXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=kNPIQ3ns;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AABB606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AABB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=kNPIQ3ns
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Reply-To
	:Cc:Content-ID:Content-Description;
	bh=RccD10RPQXTQnxGzh9R7Fuil8vnJyXL9aZCfDhLFl+M=; b=kNPIQ3nsvEF0ct6ZHX9ykt8xyH
	3qJ4ind9oXeYCkPknvMY3xEYYBTG7/k6u4pNgxy/k+lctfPLZ44XYIRdfGQ/9Mj9BYO0x40cLSvb+
	u+eT+ZD3PAZpvIdn26KKgbzxumZqEoMbaD2g/On+8JT7VqXvlqIR/9Wv1d+Lv0A6P47c0kpPxyOs+
	50Nh4mfPXCRd+scpKLdTBEXD4+qc5IwxkF+wa/L68XBbTavIf3fMBWFy1Tv7kitF3K8tBILP2xK1i
	AwtqCaXbgAnNiUDdhLaFd2qg4KkOhK8vnSkfpyfG1pqh/bDUcnyAjFUTuiLLE2EeNkL0JEbSl+eky
	cbi1Uh4Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.96)
	(envelope-from <glondu@debian.org>)
	id 1xQRBi-00BiLy-2a
	for git@vger.kernel.org;
	Mon, 09 Nov 2026 15:21:40 +0000
Message-ID: <248a0247-da65-4db3-ad55-f0a2f9f2fa17@debian.org>
Date: Mon, 9 Nov 2026 16:21:25 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: propose community voting process
To: git@vger.kernel.org
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZmyADCU8VdVDrvR-OuDKybSnT2pMOKbrofRBg6YdpxZ0A@mail.gmail.com>
Content-Language: fr
From: =?UTF-8?Q?St=C3=A9phane_Glondu?= <glondu@debian.org>
Autocrypt: addr=glondu@debian.org; keydata=
 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
In-Reply-To: <CAJoAoZmyADCU8VdVDrvR-OuDKybSnT2pMOKbrofRBg6YdpxZ0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Debian-User: glondu

Hi folks,

Le 30/10/2026 à 18:15, Emily Shaffer a écrit :
> Questions that remain open:
> 
> * Which voting platform should we use?
> [...]

Belenios [1] could be used. It supports Condorcet voting. There is an 
instance running at [2] (anyone with a Debian Salsa account can use it), 
but a new instance can be deployed elsewhere, if needed.

[1] https://www.belenios.net/
[2] https://vote.debian.net/


Best regards,

-- 
Stéphane

