Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8120A5D5
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408457; cv=none; b=Smq/ncFgwKo62TSAIMMEapP4zsW2/xgsp+SlPcBGM9Jnub7H4YbAJ1VhlCevkDkK/jK08tM0PlYBOX2XaPwV7p0e/GrG9oPTqZcq9790RtViyC0gIDEC7ZwpFfdYZXo+7UQlhup4bY9h7/UEkyLeFGKFf81IO79kYCiSika68IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408457; c=relaxed/simple;
	bh=Sqx65Yi8kOZmOS4u5j1dt0Nn0GzBKr4GbU7jeGenQLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHOlEjwho4OYR/Unker0yzw5wX0rw66WrMiCtunOO7EVbLkIH/y1u4yACJwoefycKDAIWBCKtFS03MJDvrfUBegVR2iWkCYowsF3OGZi+rXFRx/g/XDrilszccVdkH9MuE+S/px05fHd7V3LNBukIQCACyH9+JuBafL16vj4tpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=bDA7uoKr; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="bDA7uoKr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742408448; x=1743013248;
	i=oswald.buddenhagen@gmx.de;
	bh=Sqx65Yi8kOZmOS4u5j1dt0Nn0GzBKr4GbU7jeGenQLU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bDA7uoKrRJXY+Y/wf3034j9LSkVJPCNlKculmIaChYmwQapVBhkcm+vPUp+whxwD
	 pjBFtAodd4NetZLKK7OUgipfcuJMXow8nE8DzaAY0WcSe9H/7qi6Lf5yTId7A7y/p
	 1dmLhLG4GGMhBzP9fyUe3q2BCddwAbXtQo2BDpjtEwJbN4tTrO5hO9GMl/ETmC7cw
	 aO6zsdj1uFclchwsr7YHRHDo4Gniwk/3/mVI0A/+L5+SEZQKYHRJ3hme6Vcq5DZ2z
	 vFOOuIpFTChopKVeSfOsa5IEb6h6LY3tL4aoRVw9V96p26snoTXDS9MZzhAtwG8J3
	 W81hn5gbjHb7Ksgv1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.113]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7i8O-1t8HEw2XEQ-012EIw; Wed, 19
 Mar 2025 19:20:48 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1tuy24-C4f-00; Wed, 19 Mar 2025 19:20:48 +0100
Date: Wed, 19 Mar 2025 19:20:48 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] docs: clarify meaning of core.commentString=auto
Message-ID: <Z9sLAEbE9lAInBXz@ugly>
References: <Z9lcXR6sL3UWlL33@ugly>
 <xmqqa59i45wc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqa59i45wc.fsf@gitster.g>
X-Provags-ID: V03:K1:NtLmsQKkYS8wIl5wfpF6gzAzKpJXBxSoLBDjXAGE6rsTfjQzZ9k
 aG4nadAVujUS+Fr7gkAIqLPUbnUz2TGdNWC3RZAcDzTbPkohL0/0Ec72NiMpJR/IhstDIq+
 neZwu/pgQXKLb113MfEjoHP1fE1mg0T/Ha9cAptVZsL8S3xO6PcoRROo86QIEKjWXT20JfU
 xDPGmRnwe8e/heomTErCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uBmcIF5iWr8=;b/2uILgDrRzOA4XQxoUFlw9vzHu
 xaLXOrCciFZfqfCg9gqnN2ZqzsTRPlTMSV/RqzQX+lWts+X5TfbJelD/+Yje1BDJyhVEFCU0G
 eMJDrWMb/Q1EVJciqzGqdT5YJQ6rrc5EIgLUgKQN8D0kh7Dr1f4wgWQSxUIgFjWnIl45NA21t
 aONVq2LGzW9Zk7BfYl6aE3a5qrtKfA8tB7A0ruG7Ai/ZUl/oimG/djNiKrXI/sD3gotRnYKxx
 bJCtLMa2ecCDEWTp+AlcqcLtRHWJM0O+fPHI2/qq4j++GSs2r7Gp3TehbBaE0NrqKNtSC8ejP
 rWN2CBNdYGudHtzNrlr+G7pyeoPEG2KXrChP6Tx1gs0wgy1ITFkBCDvpG1cu/GPWsxcGypo67
 LrmPQPWZqMBPND0YEsPw6/2NFAAUYcQGrqqka/1ruUd9E7ZPX798Vq64IEaAr8aENhD4AfG1g
 CzTFulX9COPWHItw3BjfKHZmeA3IAejMN5e9In09a73YLgMsVZI6Q7Xzhdp6AXnJE1ly2KpTV
 Xo1PhodAaLpm9nzhR2+fdAXfePxE48zb/vX58cSPrwoxShuFkCrbEFSpgT09ynH9l833SoywV
 HPvz2s2TxuIe6shENniMIF2AxeyrP3smNK9NS0iIxm9O9eB+Lh3cUNP9dg0aYhSFNUjbXEUcu
 /v3BX5UEoaT+O/B5KCDc6bjORKvgrM76CpUP1k1kYyZ8FInG1tzUvhO7L/SJdCVB0AdtPcMpC
 tLi4eweB+l5JgiYjJPJSGTIeCZl1QDPs7pEEIhNTfZRtAK9L4AlkdMkOuWRXj0QOafdlMCYay
 fcavZiDI1ZUOnw49UqY1pxt5f2ee8qZCGCkHxzApAOVsIvYpxUHYo2PHjyUHesluLydinIuPd
 zZoEryUL7mWhWUUy+S3JFFh3iVjD+umfv9YClBnzwK8pr5ngcv2rBch9jVGN7BMaNK3bs0kB2
 xHM70F7fU4fal+JahlhEjz2UQJASk/hN/FY/AW7ocp1yzKSxLq5rrFw9wA0sBhpKeLa5Zvy9Z
 RaIJJnKSsD0xYGaBP/1UNzDke2wN6QUiUYBdkJ3stWRkEvW6+A/88hinx3pbvjTufk7XYr36V
 DeLTL5ev4fsAznr6FH6LTUF6wLVGkmLYz7lq8EqaEyG4qfp19ps3+fhn8wWt6Xeke9FjzYQWJ
 RJ+N+QtsiOfwAKf6C52HBWh2H5HdpMuRocfX/8E3Ww1erQBmpcvgU9nM0TmaZHaRdOp4dXF3D
 Eta77hoRy8rYXDy1arXZKB+RVom0eGUiee4P9x+purErz9K5wj8DOhamUM+EBv1oKxHIpiMRF
 LmAYw/Z1XMoZUmq670G3C0Qd1KhUR+N8WbprmIGoaJZ33MynJuE/FX/uyFznPoXrVelvpQ5DI
 t56JffphmMVnkmNxLIqk3RyoDYPg36ohZ2cwmDxDvlR7W+skx3eoxw+Fj89tn3QmzPio7Vl0Z
 7tYCdznMDcNq2tBC49zRwFqRuWaBDAJICVA5KQlhGFEew/umc
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 10:15:15AM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>> no, i meant what i wrote: it makes it _literally_ impossible. it
>> follows
>> from the preceding sentence that _whatever_ is in the template will NOT
>> be the comment char.
>
>OK, it (i.e. the order in which things happen) would be a good thing
>to add to the explanation, to unconfuse readers who (incorrectly)
>guess that auto comment character is determined and then template is
>read, which is where my comment came from.
>
i hoped the formulation "the prepared commit message prior to editing"
would be unambiguous. did i miss anything? if you just made a thinko and
actually agree, then i'd leave the patch as-is, as it doesn't seem worth
expanding _that_ docu any further.

>> reading through the thread of the original submission, the feature is a
>> workaround for `commit -m` and `commit --amend` being inconsistent wrt.
>> message washing.
>
>Perhaps somebody can be talked into fixing it ;-)
>
>With a clear explanation, I am OK if somebody wants to advocate to
>deprecate (and remove at Git 3.0 boundary) the "auto" support ;-)
>
how would we go about this in practice? just a notice in the docu, or
some mechanism which would complain at runtime? under what circumstances
(i.e., how to enable/squelch it)?
