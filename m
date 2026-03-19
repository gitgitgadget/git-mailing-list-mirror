Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93580347FD7
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961907; cv=none; b=TDvjZb30cl3asLIm3XxNtqIht6dUAAm05kuiBudoNoAfYIckJauw39wXp/u8nfmVWm/QHZikKBM6jEtrZLuNrtVi0J+EcZPFAzlI1hPAisKsT7isKzEbtRH2ankAQQtEWWJVCrSdiZBmwv3HiXqpjgbTebXyEa3Ib18vF/Erd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961907; c=relaxed/simple;
	bh=SlnoCET72/00ofraedh3KjxvoXjDmp6XW5UYwXZnbs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eFsQr9+afgenZ2sDpsZXc5xTcIRgsIG0mdmMB9gWSOoxA3T2VRknzqQM5gcqh6g98m12luktRYCYNDqJ7nv+iW0857Utqg2DUqi7BnI2Bn4rq98io+fY6zyReLliDeb5mP7NQ8fj8uM/eRspx0J4lGnnLxT/8iaG6+IzB3mrQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=goAxW1pH; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="goAxW1pH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773961903; x=1774566703; i=l.s.r@web.de;
	bh=O0cLxv+SuHt8MmQ8BRWFXBPiAzKe5i45jYf3pASuUD0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=goAxW1pHbHN0y1vWAAHQdIM9zdAdGWG5Qks86tyKHxIjMfhiU/ZDLQpH9dHsuFPJ
	 2IS0kDRRVCbYRN7o4el+imf+qWpw09bT3AkeoPBiImq0ZsLmF+Mv+PIvJx2GON0bk
	 ASGP5WE40QurZ4ZUgv1G56wL0el1MXawlTyVO/3Des7l9ffjcVE1b8qadgTeeh47X
	 iqtJbeRq4jUYCoqGB+5R9Ejj21+kF6IWTd8l+I9OtY4WN/+4WCVAOIsG/imCu+odL
	 975ynro7Pdd/UfKRylxGswPrinFGfqPJkDh76QysWMDBAolo29No6Pjs4YX7EkxYK
	 iQg99bxJFCXKoVwiIw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3V28-1w3uUX28nK-004wnG; Fri, 20
 Mar 2026 00:11:43 +0100
Message-ID: <6cd35848-a234-40dc-bb87-4c2cb7eff52c@web.de>
Date: Fri, 20 Mar 2026 00:11:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regex: not all macOS platforms seem to have REG_ENHANCED
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8qbnigxp.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq8qbnigxp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:drqt+5yxtrzbjQA2TBGLEYL3BnEDOv65pmEbfqqyzYONYKsmsH9
 AHc21C13UVGbJ2ENFGEP+mn0bMclYT6to5KZK6vtwiligZuQdVHqXvr/Ecl6HPgyvNU1xVy
 fi64G9vDfDzLjbyQA+PWcSpf7vXlKLhmf/IFnpG2XOKDqHAd+6tLxqyOmyQjrSTHLFsHSv6
 2SOKMt90FOWCX4+wiMr1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z2vGJLUvZWQ=;TxrX/kpUgxsVlyop2WGyg3mFZXN
 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

On 3/19/26 11:37 PM, Junio C Hamano wrote:
> Earlier, 54463d32 (use enhanced basic regular expressions on macOS,
> 2023-01-08) started to use the REG_ENHANCED option when ERE is not
> in use on macOS.  The build seems to have started failing on
> macos-14 CI jobs at GitHub, however, as apparently not all the macOS
> platforms have this flag defined.

Interesting.  https://en.wikipedia.org/wiki/MacOS_version_history says
macOS 14 (Sonoma) was released 2023-09-26, i.e. more than eight months
after the patch.  And the oldest regex(3) man page I could find also
mentions REG_ENHANCED:

https://man.freebsd.org/cgi/man.cgi?query=3Dregex&apropos=3D0&sektion=3D0&=
manpath=3DmacOS+10.12.0&format=3Dhtml

Ren=C3=A9

