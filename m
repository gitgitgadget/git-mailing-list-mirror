Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19AB42DFE8
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950192; cv=none; b=iqccToqQepPmXaGLzVvgK4q573jUi+RugJR74lhjkJI9ksO+SrjPYXO41NCo58bQeV5ylpYtjy14hN2VUJR9Hnz6EioOjOdpNjj1WDhZZV1J/0vyklzlwFZwuiBdfmBJ0NViHT+dQC6fH++2fGtEkYFZSpjAPlUBDs0u9KoHdTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950192; c=relaxed/simple;
	bh=EM0XrZww1OlVoT0KevvAPs4puc5FZWEISCEqsb4EY4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHPlUks0tXDYEtcNNq1nsm0C5dnAhmEXvwwru+JH5KKD0VGYJWohIzZ3EMDhcdRmBk45UU2hy07Ym5qszftsQDXGO8xBlSlZEv95uyjzkK8XGLwCVHSEhfEFaCVfNqyGsHq0cRUkBIwHKaFZg0NYjV2eswzfZjjX9d/dDrLpn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=nvBX05WH; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="nvBX05WH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783950181; x=1784554981;
	i=oswald.buddenhagen@gmx.de;
	bh=EM0XrZww1OlVoT0KevvAPs4puc5FZWEISCEqsb4EY4M=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nvBX05WHjFU84NFegDSc4b5mY/nkNMYj54ZH0+FZOivystJYo2AiKzwnzBcxnNcv
	 0U0SQQMIucQ0O6Mky3RXif6w7yngWKwRx9fngIgCQDf3jwr/YH9sXU0Ao20ZreQZ/
	 r8PraZNbnzIMr2vdwoukiLp/Q09ARnhVnxMJ+lj35qBsXPIlcV2qQgKajcwmDCWAU
	 KRPTU8SYGpeDNywq9BaFfB75vh8muqbJtd7lZnvmInnqGCRe4HOuczD1JH+HmZ3OR
	 l77KY0UDaBOWNd/K9AD3Z6l8MdJ0djAdr182YE+eDymn3hMytd/0Oi6TMb7vkcSrI
	 3z9is7O2fi0IpxFjTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbzuB-1xKFa62JQ7-00efGO; Mon, 13
 Jul 2026 15:43:01 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wjGw0-Vie-00; Mon, 13 Jul 2026 15:43:00 +0200
Date: Mon, 13 Jul 2026 15:43:00 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [PATCH v2 01/10] t3400: restore coverage for note copying with
 apply backend
Message-ID: <alTrZG34m85spT8Z@ugly.lan>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <cover.1783948637.git.phillip.wood@dunelm.org.uk>
 <65af2ac07a2bf85336245a7d9b9f0a8a0e8affdb.1783948637.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <65af2ac07a2bf85336245a7d9b9f0a8a0e8affdb.1783948637.git.phillip.wood@dunelm.org.uk>
X-Provags-ID: V03:K1:XB9dFVRPbSBGIksDGLHHH/dUwFkWn5URidSI77OflHO0vMAeYHS
 Bltr4XMlWeqruAp4/XBELtrnlcYNuuYrXVUP3obw2lwTS4hQlBrVA7D+AloCPgxyRNPGdHo
 jYH34Rcysl3K4t27DZeZb2GUvh+fE51MfSyu/GF8DsEN5JEKJNQb963E7VyshoooymEKEeL
 2abuDkLoAcs8mBn3+q3aw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P+iWypcBDuM=;pQtwtDtvO+6oArpfxs+LXxa2231
 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

On Mon, Jul 13, 2026 at 02:17:18PM +0100, Phillip Wood wrote:
>Now that the merge backend is the default
>
add comma here for ease of parsing?

> we have lost coverage for
>"git rebase --apply" copying notes. Fix this by replacing "-m" with
>"--apply"
>
and here?

>as the previous test which uses the default backend now
>checks the merge backend.
>
