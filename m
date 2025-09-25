Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9B1324B3A
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836200; cv=none; b=XqJGpyBilbBwu3B9i6ra+u1RpSp3lluYez1Udj1eHkZ0EUr/X8u04vMqGTknJUf4535lj0wonlY1uDjBQZ9D/LItILMT+sf4QIpchEShLWXymYRzQaIVBsTsWK0gi0vrMQ+/oVjG4W2vq9byv2M0UJCi5c7wCfJdl9KRgzVUyAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836200; c=relaxed/simple;
	bh=BOwSGcMQzg1yDUsyNMpqYjmwUYtAnOqBllXlWDHPcH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rz3s1o0QS3hKU+6UyuBAoGVrN0CQYUJjuawrghkqz2fuO9W27ChgyAaWMVHBSi+zDrWLbqs16a39ajmp9AMqNFtdcRh3cBxEFGrvwQqmTBzgAmAA2zEtA334ZiJTrJ4/M48Avc6LGaQNMR+Zj/b2rn+BWS5xP9O+/BT9APEX30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=W1OdDoOD; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="W1OdDoOD"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 1tacv1NH1Dzgq1tadv86Le; Thu, 25 Sep 2025 22:33:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1758836009; bh=s0rSjYMWVtcNr0MKiAXbKMt8jZK3mdBJyhdsO7tCRso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=W1OdDoOD2B8bagJmtICOK40q7wf3/bJ85XvBK+ZAsGALXxzpRQsp/dFRb7thobZHO
	 W975QRAt0RSj4wFDtXEUYQC6YKikVhs1OYEoP9FM80cNhtPHuT8hheGSVx3DnoFHl2
	 WIocwmcFNLC+Af8oJJapSgzOT902gMcUizkUCgXw6PXtwjc+WH9JMrYe29Ski6TxGb
	 mZpRrHj9W7UDQQH9JhWi+SJvrCIYnNhTqDfd3Y7pP1P/vXr/hTVYoFodZdFWucda9j
	 XLThUCHfhVmUyljQ9phLMT9NnoJ3EPcV68drm+X4ZFO8367Q5LmH1aUEy2U8rllthy
	 +FY9htZho73+A==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=AvdN3/9P c=1 sm=1 tr=0 ts=68d5b529
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=vk5LFCdBcclPuyGl_zsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <06de5ccc-98e5-4bb6-bb09-e67be906ff6d@ramsayjones.plus.com>
Date: Thu, 25 Sep 2025 22:33:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/9] Makefile: reorder sources after includes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>,
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im>
 <20250925-b4-pks-rust-breaking-change-v7-2-4e49dcb904d5@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20250925-b4-pks-rust-breaking-change-v7-2-4e49dcb904d5@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOicBhgdUW3KzvtDJaJYEM1OaGLNbSdxfwIo3oQU2dG5D08r7jLyOXbq0EewjQXu7rhM2znRMvAE8aT+lo3xYNQhSZWMNXbHKFkCmmehWpWCpGW9crA7
 HrcdYEaPtjTiotVzuhqDE9v6kCy7eVHAA1Okm841rjqpqMcDd5YVJSGgJAZHvUQox9S7gT66JDXprBX+KgwrF/AU33TvcSmLKEw=



On 25/09/2025 7:30 am, Patrick Steinhardt wrote:
> In an upcoming change we'll make some of the sources compile
> conditionally based on whether or not `WITH_RUST` is defined. To let
> developers specify that flag in their "config.mak" we'll thus have to
> reorder our sources so that they come after the include of that file.
> 
> Do so.

Yep, I have a very similar patch which I used recently on cygwin so that
I could just 'make' git - having to remember to type 'make WITH_RUST=false'
all the time (and always forgetting) was somewhat annoying! :)

So, thanks for that!

ATB,
Ramsay Jones


