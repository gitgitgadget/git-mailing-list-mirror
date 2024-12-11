Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACE31E9B11
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907193; cv=none; b=kJBsii6YxtEpnjPgeJfQE12q/nLAwAPv4EG5h0l+AtzMHFG+7zHRCnRC9pbuLCXPSeETjHuzzvNq3iwo0bYber0avqWXq5sJDNbUkrr8mBM1Y72slkMd4gYd8ytsMlnwcKgYhsS4LtsewEK6nshshQHMNNUe27c+Ve2sUbgW9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907193; c=relaxed/simple;
	bh=1SGDySQdp3wsbstXPLvIrbx6wwUgPMo0Jug0z9fJKk4=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=ABa17YRRgYQ2FNXBdDywAAh5TXkextDDFuH88GXyo4XkEUq/fkWoZGmgj965j1QMxsZerQ8Ah647LsCC/owbslhnDPJNcB6wQPsJpARdOxTxyedygnyQt87a9Xpvme+xrWgt/62f8RlISY3ROhqXmcqoKHqV3EElqaq0t/DokjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=OYzmPHlD; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="OYzmPHlD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=1B48UdXPX2WPzpSAUClx/koOaT2kW7mDMIHNt/ST5zk=;
 b=OYzmPHlD/OYwLAR8R6KcD362jfGc5DpC3CdmIMmwpPnGedMAvtB4dSlXLZ9/c26vwR9xmbeNoEbc
   xVZdeG2Wn7+p1jyLuXZ2GDjHDlD1JTggCRdc+oKVrOTg3Sefc5ppPrfO+QZ8Asq4hrxAtkFkCVq8
   GERCZsEtNId2wVEUDTYEYIrNZelF7urz8bBv+gADMfdUdvEd6yOyIj9iiVURb81v9Yek/Otjqtiw
   MOzeUCZ8JL0DWmvP8rRsg2qHE5yN4QCor/gKdd/v8zP7PYqvf+f5cAH3YDai2Sl14JzbtQM4+wuQ
   aBqXPLaoInUVFdsPlTq+G8xdXYYK0aRowPNcZA==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SOB001D1NCF29A0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 11 Dec 2024 08:53:03 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 11 Dec 2024 09:52:27 +0100
Message-id: <D68QSB8Y9UTD.1IO0EU3X8ZX39@ferdinandy.com>
Subject: Re: [PATCH v2] advice: suggest using subcommand "git config set"
Cc: "Justin Tobler" <jltobler@gmail.com>, "Heba Waly" <heba.waly@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
To: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <Z1FkrsQ5tkz1pFUz@pks.im>
 <20241205122225.1184215-1-bence@ferdinandy.com>
 <0e139151-7162-42b3-afae-248c28bf4c4b@gmail.com>
 <D674P6875UXA.LXGHCJ9EFE0N@ferdinandy.com>
 <D6791Z2QPSUW.1LP269FO886XF@ferdinandy.com>
 <be4ee78e-12d4-44c2-9f82-4f0db7706fea@gmail.com>
In-reply-to: <be4ee78e-12d4-44c2-9f82-4f0db7706fea@gmail.com>
Reporting-Meta:
 AAFry28WggvqJ5I2SV7W2WVl9q/za+6nEv2QLMD5pJHhK0t7onQcKEubmYgNfUuM
 8n2bmEfC4faR3JSbZyfWXDZSZ131Jvk1fUGOqdd+9imQx0ivK/kZojQ5yaf1ubks
 jTyTrM2ml8pl7W2Ve/pNKGmFNG8pW4ugq8rS0XOM6BpBf8fMn5rXBAiPUg4f+mio
 IqrGbNV2+PzR3lDGA9dni1eyqOr/BXVpHa99AWE2S6Mt9L5jy7wJd2qRhx6hjepS
 sou0pGNxrHlUFn2fIgJg84Ijk/Wl9aADZpO+0hFFFhYR9tByw2MOAo9nnjbiH7KL
 5AGVmGz3/AXEeUgI9z536BEtxCxXtxliOdcOvtlSwDPD9pB8T27QqqWMlGNdw/jZ
 Xpd3qO+2/FpmQeTalSyS70/YaxoiEoCr1LnhMp+dU7gOrLz+raCcTntDeGlGYpc4
 qpRf/Jzfuw6eX/OUoassKyY/vW1X4meuk2TNzJmNCOIEUuKQxJrrIWcW


On Mon Dec 09, 2024 at 21:35, Rub=C3=A9n Justo <rjusto@gmail.com> wrote:
[snip]
>
> I don't have a strong opinion on this.  Since my message, Junio has
> marked this series to be merged to "next".  I can be perfectly happy
> with the patch as is.
>
> On the other hand, perhaps I could send my patches about
> `advise_if_enabled()`, later, rebuilt on this series once the dust has
> settled.

I think that would be rather worthwhile, since having different mechanism f=
or
displaying advice isn't the best for sure. And it seems the patch has indee=
d
made it to "next" recently, so I think it would be safe to rebuild on it no=
w.

Thanks,
Bence


