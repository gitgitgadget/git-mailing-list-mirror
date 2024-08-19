Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EA617837D
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086154; cv=none; b=iDVZjYLcx8bbudGdZUWYmDguFC3aHbRAmJfu196ROwhfybx7MjS/NGmdZOmS0bPO8DqrsyqP7eOIbe2iWJ3rZWDqyemkO3U7mu8G1NbZ/ZG0f6kK303Sbh0X3HzpNlP7aP8VBqZ/5wSozVg5oeMKk6kg7YJ77rm27qDlQuz+nM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086154; c=relaxed/simple;
	bh=SaHXLsTjmf+0HSGdn30L4RFUmIJ7OCXC8ik7oOZbVN0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EtDYvr2uNgSWE6GzMsBywfba4J/czA2CfrmlXb9DRymBrwCKa50mPGS2CxJzSG6yOmgTl86Oi8JTS0jIWQTmWU2myA8TU6mEAWPogvyJw4prCcTpYzMiJ3rvv/pQv2iJEL3AomBwt+UZ+4ABxwodKSRdA5a4I0jec1/OmK22+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=GhLMDf3S; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="GhLMDf3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724086148; x=1724690948;
	i=johannes.schindelin@gmx.de;
	bh=ZyfUc/dZjjv6lJJtKE844BvNxUJ+NpifxSIHJDdKEFA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GhLMDf3SOmHvAmpLF4hiA+7DG6jiA8v9QGnhV4u2HDFl7MjgjXe1AVC0YQv2hLeI
	 +Ym83V6MKAd1C30GNT/qRWE7o538U32zqBVxmqJwhex01A2EiqTDvo+amVprH+Ydi
	 xjUQFu53b1126zISgJMiWksuGLZD0ZzZP0TT/Ve3JR/69jcIK+2FyomYsvFTI7ZuR
	 2wbIy9VeInYfsDu/AzZl/GxzRdm/e8r0pzDdFYx9GU575pYpVK6tp3vpnsbUqj8bh
	 eRg0PF9/UsfyOszarjlp3c6pcb3bHI3RrCsoT9PRmbOycXi7QwN9bYh7Qr9f0mL2F
	 N8vhhgside5B+bYISA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.249]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1s2VaG0GuW-017KsB; Mon, 19
 Aug 2024 18:49:08 +0200
Date: Mon, 19 Aug 2024 18:49:07 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: v2.46.1? was Re: What's cooking in git.git (Aug 2024, #06; Fri,
 16)
In-Reply-To: <xmqqwmkgjomp.fsf@gitster.g>
Message-ID: <b6e3763d-945f-fdf7-e620-cd26b8c72419@gmx.de>
References: <xmqqwmkgjomp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+Z0uBhTNdfxWEUr4JNlDzCDudqhYtqhznf2C3CHrdG3k2CG2aN9
 TETAZdV3wetj389tZ+XrA9VldHLKVjIhvU15LKhu1Vd4saGHIU35ghuC5EEpDXt6RiiT7Zg
 OwX7FpJgI1nxjdO4dwUVuLVDWVylx+XgC2m+SA0IfXgTjp8nXd5NVFW/NmLk4x2orueKKm/
 Z38NuDPbTXiDHT3GbyJ/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tzkAsDN3Hsk=;L36W2tx/Knso9xyJ3FRwUfxHHwn
 YRK3O4/0ORx8SdJAh/8NhuUdTFIPQHJy0V0vjRGG376cu5hjKw51G5pB7LA3WWm+PaHahdh4E
 i1XKjggetOp5/ArmTSXTIv4czPNfBSbSichBSUuOoLxc4cN64XspzhLjXaH9eP6zQT4HAzA6q
 UH57xj0n6nLVpm9XAB4A8u8GtseomqGjc8yBhQ16UmPQBdeFXBzZlzQLwA6yD5ixUR0KYoNOY
 8Sl2dFzAHQDHZGYHZEhSIfon7SpMXCFaRCKy0R9mpyD9/DDUV2zi0UnToE4Or9y3K1YoWgauU
 kM3zfxyzIs4W2LnrJmnj7JkNoR+499v1dG0Bg+FeHQ+GN2OFbrCdTQ91CPbXFXPPjQvzgXYXw
 K+FPC8G9LzuyOeHmAL35MIO8iQ+PPMOUPHpAmNzsJJZhd3xMhx9AvgeXKOn7LfRNkbB4BLxM2
 noOD7s8cYz4D2MA06TYT/r4NrE2p3gjLS+UoDfnHBIzPuBYsibqIi13vvX75MB3r2hhSUJ9oO
 533/fddjF9qUZg9X25sszfNTdmXBe+8TC1p6KWHZR7eAMMMYTL9Gi48C47WE13KKb6xIPcpw4
 tJXTcAIFRQtWzIgr+9ZL3JVsvuSErFOBV/ze91c9gM7JwIEg7HjaVKhXdSOP3OeuWKtQj8/cx
 HryARMRikdIlsSwCJ98/QRJDzXE4+M4iI49bNrV/f8vePMhJPkyN320vROW18WnR2aLkZp0TC
 Fe8VmLPidxWz6zxne6sMsTv4aRiPkB1AI9zKuT5ZZoNM/v4AGkAgTpZLVyFjyCC7LxIy2Igai
 tRowchJ6ZxD4/YASkeI+xZ2A==
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 16 Aug 2024, Junio C Hamano wrote:

> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a
> future release).  Commits prefixed with '-' are only in 'seen', and
> aren't considered "accepted" at all and may be annotated with an URL
> to a message that raises issues but they are no means exhaustive.  A
> topic without enough support may be discarded after a long period of
> no activity (of course they can be resubmit when new interests
> arise).
>
> Copies of the source code to Git live in many repositories, and the
> following is a list of the ones I push into or their mirrors.  Some
> repositories have only a subset of branches.

I frequently look at these two paragraphs in the What's cooking mails, or
more specifically: at a paragraph inserted between these two occasionally,
to get hints about imminent maintenance versions (to allow me to better
prepare for them such as keeping back component updates in Git for Windows
that strike me as needing some exercise before being released in an
official version).

About 2.5h after sending the quoted mail, it seems that the `maint` branch
was updated with a hint that you plan on releasing a v2.46.1.

Could I ask you what your plans are regarding v2.46.1 so that I don't
exercise my weak fortune-telling abilities that would shock Sybill
Trelawney?

Thank you,
Johannes
