Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06F3A5430
	for <git@vger.kernel.org>; Mon, 11 May 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488189; cv=none; b=e+5qFlG/fPmJgHXsnwSWU2eKK8MfTu/2Y1TkifxhVVfOvnHrCArK+NbZcymcsf2v/fdLhLCZsgaiIEPSQKJ8LUvohBGmQoF8BEjC/mpEdGVYKhsNOlI71XEV2WBExz46KKgZi2AyR8rthrNTxtsjiYKYjYelq1jxxxMC47N65DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488189; c=relaxed/simple;
	bh=2JRox0zU5Enhsr5JFiUNRCN2U8HU2pQ8E+31Odtkp90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adHjFuR/4uyaO4xYFIqg2TFKdJ3L7VhLZvCATOzIuIOS0P0HU7e0dZoSo3lEgzlg1IB9FOf9uSX4sox3t64capNHQ9Oxut5iPF7OZs5+9eKed0osTJx1AJSEz339C4LLhRoFwJ3ySx9Ntg1aUw+gpHZTgEw/hqpCb5sDC6+FGZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=GAI3wY4C; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="GAI3wY4C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778488178; x=1779092978;
	i=oswald.buddenhagen@gmx.de;
	bh=2JRox0zU5Enhsr5JFiUNRCN2U8HU2pQ8E+31Odtkp90=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GAI3wY4Cq+8yFt3VmFTTlEhuET7K1WOz0hHbCKIPBwhSa+ZnfstIdHKplYjGmjTo
	 yRD2WMNkY2wooEgT9dne+w4WhnbO5imK+L8Nk9TUDpywCWR45y3rrk7kCzWtaD6Wa
	 NEulCMMd9YmZaGv68UyTrIfQ2P2Za+Jo0zgMUxotjrkbv7zymJAkD5+Q6TzEOqzJa
	 kFDdFt5VHst1DB5w3tH/+bxMQtekyjOnTcRWWYw0wLz/Vp6Xl7UYH0ge/uoPZCYhF
	 b01QCecnYpd6iuK+JP3xA2sLnnOljUNrDQNqhg4Mptp+fIx1x1FVTeRoQT70extfm
	 4O7FVqjyUfHSzx9C8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBm1U-1wYV5x3DP2-0057Xu; Mon, 11
 May 2026 10:29:37 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wMM1B-OnA-00; Mon, 11 May 2026 10:29:37 +0200
Date: Mon, 11 May 2026 10:29:37 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] doc: add caveat about turning off commit-graph
Message-ID: <agGTcTZip0KItj1v@ugly.lan>
References: <V2_caveat_commit-graph.68b@msgid.xyz>
 <V3_caveat_commit-graph.6b6@msgid.xyz>
 <39f029d7-0c12-4a79-a701-04abf82cfde8@gmail.com>
 <7eae7ad5-5b09-4069-aafe-571f3e345b83@app.fastmail.com>
 <xmqq8q9qwxrr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq8q9qwxrr.fsf@gitster.g>
X-Provags-ID: V03:K1:4gefuJc+X4a/Ssxb//FzUXqeLRY8kw/PcJoHjVYIdQJEKuZRIET
 D7yl+6SWemZzsfeTgZISYp/+dJ/3W8SnebLPNiwrk1eBktckVe5NGwTOx4mIXY0KF0dTEYJ
 sLkumrY/aFpXZf4RGpm8aBX1atCTl7BiqtaDZK8dB3ZNsFYnippK5g2dhwvzfJ2uzv45VIq
 nRj9lk9ClOLlK+H6sa11Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5EVaHFmRLEg=;u6R5eRM+Z5VXAK48iSXJcHyndVJ
 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
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:16:56AM +0900, Junio C Hamano wrote:
>There will be lot of unapplied patches left on the mailing list=20
>initially until the contributors adjust their behaviour,

>but in the long run it may be beneficial? =20
>
no, it won't, because "the contributors" doesn't have a collective mind=20
beyond the core group.

every bit of bureaucracy you add just leads to fewer successful (and=20
subsequently attempted repeat) contributions.

if the scalability problems with making things contributor-friendly are=20
too much for you, then rethink the process/tooling. i've already made my=
=20
case for gerrit [1] ...

[1] https://lore.kernel.org/git/ZcA0NEb+lnjeZUBe@ugly/
