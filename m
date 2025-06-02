Received: from cc-smtpout3.netcologne.de (cc-smtpout3.netcologne.de [89.1.8.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C42C324E
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.1.8.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748891446; cv=none; b=NOcg+AqElQuxaD9nT68H5csElFNwYZLQmtS5JOQfOELPNNT3DNKWS3+smCtRqt2ezC4YOYp24ovydPCradCuBMcbT5hLSd9p5Nkm4MfDwbrzBYP3TzRXuOqXwN0q8aTRvV89hmMSiLAVzm+dItWG65m7BCFulmXAtmr/tJRwiuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748891446; c=relaxed/simple;
	bh=zgYSeLP+zq+q8c9ePU6kEo+Xg4TF1uQVhHcF3OhjpGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kkPRdygWsw4zHlSJO5NK012gHRFs9QmON344WYAo224LScZcxWGxC/GnLzhbcEet06uoKSF6X6niD1BfWtB1bKi9nQscedUtpeNrJlmeimZCw32Y5kl0bIOK2sJSWeqiO8mSDYhaUvqa23Q6OXTKxnjPsdXQ10JST6sFi0INcS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcologne.de; spf=pass smtp.mailfrom=netcologne.de; dkim=pass (2048-bit key) header.d=netcologne.de header.i=@netcologne.de header.b=lLMpZxYU; arc=none smtp.client-ip=89.1.8.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcologne.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netcologne.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netcologne.de header.i=@netcologne.de header.b="lLMpZxYU"
Received: from cc-smtpin2.netcologne.de (cc-smtpin2.netcologne.de [89.1.8.202])
	by cc-smtpout3.netcologne.de (Postfix) with ESMTP id AA79F1236C;
	Mon,  2 Jun 2025 21:01:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=netcologne.de;
	s=nc1116a; t=1748890871;
	bh=zgYSeLP+zq+q8c9ePU6kEo+Xg4TF1uQVhHcF3OhjpGE=;
	h=Message-ID:Subject:From:Reply-To:To:Cc:Date:In-Reply-To:
	 References:From;
	b=lLMpZxYU/CdIAkBg+CUtqkO11J8uQj4rLH9OoDWWuDL2jTJKt5Llw2C27IJdTK7DI
	 C4/P7c7wKOu3ydmbLeYHZYDy1GNVY05SaWxh/RkprkFn7Rfn37ZKAEIy+HjKeGAUDi
	 bWvfKKd5YC0lah40gyOsKsNN8nU003hj23PacSUqnMZ3GBjD6fvLAM7sKw2j1MbVC+
	 fwW/X35/xAHoNSpwPbJaFaO50sS4R/6xtcTx7UoQMHDqfnGFzCF52QqspUfY2qRZGk
	 Y0IRvEK5Vzt2NfCot2vkJRag/w6ohueWdhZbTjx55vp0//Qi2L0wNu00HhFm3zuSGU
	 OmiIt4l+UAVhg==
Received: from montjoie3.internal.jansen-preisler.de (static-87-79-78-107.netcologne.de [87.79.78.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by cc-smtpin2.netcologne.de (Postfix) with ESMTPSA id B238211D69;
	Mon,  2 Jun 2025 21:00:56 +0200 (CEST)
Message-ID: <1ff4251c81e40f7527c35b13b00f770863719b67.camel@netcologne.de>
Subject: Re: Draft of Git Rev News edition 123
From: Markus Jansen und Julia-Anna Preisler <jansen-preisler@netcologne.de>
Reply-To: jansen-preisler@netcologne.de
To: Christian Couder <christian.couder@gmail.com>, git <git@vger.kernel.org>
Cc: mja@jansen-preisler.de, Junio C Hamano <gitster@pobox.com>, Jakub
 Narebski	 <jnareb@gmail.com>, Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  =?UTF-8?Q?=C5=A0t=C4=9Bp=C3=A1n_N=C4=9Bmec?=
	 <stepnem@gmail.com>, Taylor Blau <me@ttaylorr.com>, Johannes Schindelin	
 <Johannes.Schindelin@gmx.de>, =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?=
 Bjarmason	 <avarab@gmail.com>, "brian m. carlson"
 <sandals@crustytoothpaste.net>, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Phillip Wood	
 <phillip.wood@dunelm.org.uk>, Derrick Stolee <stolee@gmail.com>
Date: Mon, 02 Jun 2025 21:00:56 +0200
In-Reply-To: <CAP8UFD2w0UaLW+psacZp6FfJumXS1DmR9dRsJ=JP9M5Abx+jXA@mail.gmail.com>
References: 
	<CAP8UFD2w0UaLW+psacZp6FfJumXS1DmR9dRsJ=JP9M5Abx+jXA@mail.gmail.com>
Organization: Jansen + Preisler
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: B238211D69
X-Spamd-Bar: /
X-Rspamd-Action: no action

Supplied part 2 of tiny corrections and rephrasings with 4ae9989.=C2=A0
Sorry for being a bit late - feel free to scrutinize as usual.
