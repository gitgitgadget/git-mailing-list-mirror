Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D426BB37
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411778; cv=none; b=aX7UXsOSMM/lCXTBd8a+H0hREwARJKE/eb0HdwQrQaRgy/kao8zIXl+0j7jPwRfgkLRyyTwRl0IPjKpU3otibf1oH5f1y66LV34qPpY9l/djPa8PfVisPYfnpodCoTjEfE5jEd9RKbkdpQIn/1aO/nAUV7ajrxEHmlys+758SoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411778; c=relaxed/simple;
	bh=6KvTZ1eGMW0/vAcyIisHsEAJBt4/W33m/LTuP8Nrbvo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCr6Z2ljbPi1/t7XTT4fsTC/EwTm2aEOryC2wpZThbvv1NKdW2LVZGSaeGH0RC1NoUZA7X5o8oto3qFzfBdzbUaE5YpHB4OygqSwEberrHxasenBKKsJIxtpCCpomIPb+gAT5H5RaF+sxsVcKW6QFLWg0wDoz6RHhWF2jMShL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZCg3S724; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZCg3S724"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=tslynkpsm5fu3duzwubm2qr6qm.protonmail; t=1710411773; x=1710670973;
	bh=6KvTZ1eGMW0/vAcyIisHsEAJBt4/W33m/LTuP8Nrbvo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZCg3S7242s38uJoC7RuvFdi5fQYez+Sl8KFrqHxwQ2U0lLUKkv7himiMk+szHiUOe
	 4qEJh/Cc/0T+nnaq3Ti3QdeXl3enUbgrWdhjaE1c5/rHP+NegjxBzibOeEMoh/fRot
	 4nAVKX6/mZTXCjG8vTeD5j7vIdD3kZSykPhT/aTx9Jb6RP7UHzsfcEHq0MUgoAZ6Nj
	 HmMqXGmk92BABsjix5TMk1o2lXzqljRvrm+8+S/gjVJPWtLy1jSyP5L01DtK8ktZHV
	 bXMMia2CNG8dyRHIJaBBi3iZTACtYw6PIGwRsrQlvTh4ExOK5bN2ZPAo7oCxPhjwbk
	 JkptfhN5TPq8Q==
Date: Thu, 14 Mar 2024 10:22:46 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Mohit Marathe <mohitmarathe@proton.me>
Cc: Mohit Marathe via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Mohit Marathe <mohitmarathe23@gmail.com>, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 2/2] patch-id: replace `atoi()` with `strtoi_with_tail()`
Message-ID: <jnBS0qo8QZFzqzU38VOg0t-BVquGuzjDdY820B8DW1uCd70FAetOik5rSV01nzSidyMqIPbarZ7lL9JNra-hR8Xzdfv9ZLcLI9wU3nyVgrI=@proton.me>
In-Reply-To: <xmqq34st1bhh.fsf@gitster.g>
References: <boJAHbg3xUqJ1hriFJu3QNlF9CYWbP9x9zu9mcV1jk1SI2WGAOes-wU1MMBZBWvMxs6VTkhlfE59iMEnYcDTOUTxA-3M72kvOJN613jaygw=@proton.me> <xmqq34st1bhh.fsf@gitster.g>
Feedback-ID: 95862732:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





> Mohit Marathe mohitmarathe@proton.me writes:
>=20
> > I am writing to inquire about the status of this patch.
>=20
>=20
> Thanks for pinging.
>=20
> Please be kind to fellow project members by including a URL under
> https://lore.kernel.org/git/ to the original discussion. In general

I thought replying in the same thread as that of patch would be enough.
But now that I think about it, threads can get pretty long. My bad,I=20
will keep in mind to include the URL of the patch next time.

Just for the record, I was talking about this patch:
https://lore.kernel.org/git/pull.1646.v6.git.1707025718.gitgitgadget
@gmail.com/

> there needs to be a reason why a patch should be applied, but a lack
> of reason why a patch should be applied is good enough reason why a
> patch may not have been applied so far. I cannot offhand recall
> what problems the patch had or if there were additional problems in
> the patch that was left unaddressed.
>=20
> Thanks.

This makes perfect sense. Thanks for clarifying.

Thanks.


