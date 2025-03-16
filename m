Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9A8F64
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742120879; cv=none; b=oL0fwy8Rd2q4bcKSj13/wdUl3Eomrxs9r6VQakHMCZF/m7KPk2MM7NZ19xtIU82r6nWmO+y8P6Ve9Ybn1qwjKooX9Uku6ZjgXzwDK/mnNwe6JD/JfaDYFH1KRXcDq1zAIeTrZ8H0pFX8sL5dThZgpAgoJGJ85xA2Wl/QatPeRKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742120879; c=relaxed/simple;
	bh=WhXe0iGrdOfnxX0tQZ9kmPYEriyUipk/Z0cj7JcAxp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gziJCQsltSO480XZmjsKSrQMUBq60Dd2wVaPcCdhHVDmZKgNzTicufwCdjyl6pUvaTppRcE8QraLq82w7EBtFvmCdHpttdbMnKM3uB8YeUzTGwjLMwW6DZFHhjwhdYC4e+p5b+y8BLz4FlcYkO+cu8isU3URN8xMYBQWxvILv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=CygBNyWe; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="CygBNyWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742120875; x=1742725675;
	i=oswald.buddenhagen@gmx.de;
	bh=3wsgcPLBY1+zm+PqShWpwAruCK2+TnJDCnfSjkyJSq8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CygBNyWeYSo/jglNEqD/rNNoun8FDhPDRTmcqerGoT8MuZCVtFv5a680b8eBtO8O
	 Ch374cq7FhfsWxK6UXheF/kPZ8fh0aL/Z60mYUX8Mjik/epd2zCLpaSuH83Wh094L
	 bf+N1FIG76aBB+n3zikUwUrYgPOhF/101kGp2JQG5QPc2US5tt95MCZrqyrPrgftq
	 999tYeauxhyHWrcAWHeUtWcpr8HBEdVicdtIB1pA4ZY7BVlFySH1xUMWtla7Cyo9w
	 VzEnX4nHek7rwsWbJyKstsPbNBKM7PLTl2mAuu5HUI+OA0N8MouuY3h4bcxNlEabm
	 Oly/LJRE7yl9vUcmog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.126]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63RQ-1t9UBe3i9o-00wlpo; Sun, 16
 Mar 2025 11:27:54 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1ttlDm-kVf-00; Sun, 16 Mar 2025 11:27:54 +0100
Date: Sun, 16 Mar 2025 11:27:54 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] git-gui: heed core.commentChar/commentString
Message-ID: <Z9anqjBmKFpPuTP9@ugly>
References: <20250315140913.577422-1-oswald.buddenhagen@gmx.de>
 <a62035cf-b67e-4291-acf6-d2454a9459bb@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a62035cf-b67e-4291-acf6-d2454a9459bb@kdbg.org>
X-Provags-ID: V03:K1:7NUcIXD0WEGBI/HOH5aoD/0Tf3R1oKA0va2vkSY9c9+lkvnfPmk
 7FhIk9XJxBLBcl+nkVe40aDkgv0VQ4x1uGrscWKbzWag3F5B6d2uwXuS/B7uXxwi0zwwiTV
 As2l0Qe5HQYBY0j3QHAzh82g+ntYh0UtZnhFT3lnZqNnVAKUQtxQ3jmVgosiZtgEflsf8YL
 KJaDFvJqGI5vyj0rN6Fjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xqcCL2waEHc=;5YJbAE3A4C9zynHhZdAxMkFTxNR
 CXuvv97cHcUWRWE5isL2dC+yfQ2XM5bvHquXPFpZjAQI90naKfVWXkQlduT6EJCmKAEARk4vC
 G1CivE64uc3nBYd3nZYKDJWlC59+4NwxZoZPTGeoEhW5jR+RzgBAeJkrNxmG0ksATb4XFZc7l
 YujMgrED/0oTG/oWSn54yUMGetu+WzeObS2KnVbsNa20Sbu+IoPeu/Lre5Xfd8+NPsw3/+Y6r
 729MkrxQDkBxvuBRrnAmrh2hyQFkio9vvkRAKhpi2Zd5UDhnx8vrfw38GwftYr9ngxjNVfGJj
 aoEBQwIsOC+9KlyYK5/bWD1e/Ohed4MdS5Ru/5d7PxSMhQnzJA/IDb5p9AbYOoipMtIzWUukv
 nOCcrxkJoyL7bvX421X6SIBotV+RgHPjyOHqJunj68gh6rgIGrNmdDUcvCu1ETNEdhp9POgOC
 59m2moawbMmhG/1qP2p7cIrVOCbmuhLo8jx0EIWcRFWQrtZ3L3E9x8cTT3iplPo04wUL0zdz2
 izWCmmFkDRbwNnNXvONrv+pVb9bi8Cu3J6jLRTT4cuZW05/670WXJTeUOdjCUfTy87t1srMAY
 iLTIXvckB1wnBaJfJ8b8OKjGWvciqZ1NHqjP9hfQ4WgGxDfLqeT0n4/k9h8xpY/DuPBRQ1yuO
 MLtNReUve3sWpeF+zPwbqjcUmlo+cUbANkbU4TKOPMyzjNsLtbZ6KxB+mDUDV9d7T6fzde8zb
 yNRGus7TltYvI6YqKNFYb7yWhrMGGy9yDk3VUIVRBnSXfG02FmI3JOByZhftWBfyUhrgrnz2O
 5/7hs19Got/301iEnArZCJbaAeCktbE1dP5p8X988Bh7GVThG6Y1AqIsUZ7c0kTgOgmymYZdA
 kwhfPeycHthpu40unewjtWjHgXHRijkPxUEASZCZIraJe3BUvfR8qlhATgog/BbWQ7x14Wdpc
 vPeKi39FkBTG+QgHfD1qgczDrTtJQcYMLBmNMOj5aKtf7GCDlfI1G85uPnSiviTFncey3Ti1T
 ifPNcYM90WP/9bkuUWpG/fWi3NP9NqR4Ov24C0LWwyx+TPENJ0F5i/V0aqLciB3UVbkx5c0OQ
 awFoCDMFTGfzQGdyYqQ33+iKx1z7HDj6NSN3QuY/i9PwhrCnZPUuReJsFlqmiOONgn1TiyQVu
 WgXtmTKyCbeXFH0cQ99zqWpCrmflrNyTdZ6g+xfx8gNEAVYf4UcAuhLsVVeeEpu17b/CA6pvd
 8p53SOeOZEP0X3YIW7SUqH3tXGNWdsgDrkQ11LNBmJh0hBUQi8fiiwbzfIldaXbe6ZbZ1HWWY
 QkqpAKhmvM1MMb4+CjZNwCSKv7OwBTtfIPZ5qj1VPsM/1V3CBHEfVrWYdGA3/MG3wMfuFGIWy
 pf/p9oyeipJ0La8MJkPVXjEYbZ0QTfTqUiZl8XQVpzV08FR+uMW9qX86d9yyXn/XX/q7eVSEy
 r7+OzahroA7R44dyss8lmhE31uiRPKoOfphhYLFARP/jrAqYG

On Sun, Mar 16, 2025 at 11:22:12AM +0100, Johannes Sixt wrote:
>Am 15.03.25 um 15:09 schrieb Oswald Buddenhagen:
>> +	append txt [mc " (Lines starting with '%s' will be discarded)" $comment_string]
>
>Like you said in the introduction, this does look messy. Would you
>approve that I remove this hunk while queuing?
>
yep, go ahead!

