Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E7F4FA
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892055; cv=none; b=GfXbNMirn9rOYzUO2kp7JsTNAcTuxzkgOiuRWTG8QQ/a3iD6qgk8LaiVqlnEZm32V6t9u5cpcEDxWhr/YwDQBBbvzSeTSee/PkPfHlOLBDD7ijlEnb+GMg+Ua14ZQiGYTNoCQc02E4AvBkkyVokX3hW3qsTkwe7M/aKomxnH5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892055; c=relaxed/simple;
	bh=i9l4wPzSNNBd034y0BjoufKxWC81hHkuPF3rThl8df4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOniYI0BGh5Zk3YeaJ9QHgd8O5eYIRPMupe1P+KP5pF26O4++gA6LdyIrrBFoWxs8swRkn+mMQkLb/i/hAyadKl6NBl1JcXnEfbbtrKYUJ/8C2183GD4CfWiMMqqj/lpy4HlgQ2pHTerFG5je9nSxL7dLaeVFaFoUa5/gD/nr6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=jXKXQiHq; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="jXKXQiHq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770892033; x=1771496833; i=tboegi@web.de;
	bh=i9l4wPzSNNBd034y0BjoufKxWC81hHkuPF3rThl8df4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jXKXQiHqvePrbN0Y9SE0Qv0KNgBZHw6QI5rccWlc2CLhNXr+XVKxyebqjoAyUj/f
	 Q2UEY/NbfPUJTOBWjqrxoHGUXkdSwWUxrFiXheiandANQRzoZqwp79OV4qb0OglTQ
	 JQkYiSlXMxPJyfWvdNB7C1CYcP0h81sxZqxqUpOFTn2a3npBKRJG+GM4F6n/MBDTB
	 O7svE+SzGoI7v0CozwE3SDaH1CVJieN8DFu/BkD4+j4zZ+WTxLvAqcymVPAUaMZWA
	 R07BYI9UIcth26yyZl5BLrXpMI9DElURwrQsYOjk0v9bUWjsBSjKoYbs4NE8XXfYP
	 W+Hh2XXTKPzZfYGyEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.224.105.209]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MC0LJ-1vvfOG1JzZ-005AlR; Thu, 12
 Feb 2026 11:27:13 +0100
Date: Thu, 12 Feb 2026 11:27:12 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 0/3] support UTF-8 in alias names
Message-ID: <20260212102711.GA17587@tb-raspi4>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260211211810.278806-1-jonatan@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211211810.278806-1-jonatan@jontes.page>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:xtYRgYrjs9amAz4EVqIo06Lodv7sZ5XWLjMQJoq0lJ0QjNxqrdi
 nKs+TLe6DquViRgXWoWhneOp+UOzzWDB3gPawKCGc/jCoFys/RkbXb5LfJ51q5b4x8yvhhf
 Vm6re8QY2QLTh99fsftbqg4rBDrL0cdtKr3iAEhJi3TzbfKUQqPln0CGVKCd1yxjarp5B8C
 AHbYMbVzu4vOLvP1WyC8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OEG1PU61GYg=;hz9rKC/R7COZ3KzcIJNvnpeFsTj
 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

On Wed, Feb 11, 2026 at 10:18:07PM +0100, Jonatan Holmgren wrote:
[]
Is it only me who only sees the header message, the 0/3, and not
the patches themselves, the 1/3..3/3 ?
