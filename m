Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FA4FBF6
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910336; cv=none; b=IevEkdwI52EAZRZRdBHKunETqKoDtjViZZ9ll8Dt/cNjLYg4Jj+A/wQtPAjZ5yUXCR5TrPmw9FojurfpKbnpHRPf3MeO23KEcDTXhCKTn9YNblm3KDKRfYZRxTLcNjXV8psCoCq0yaHpYnFiWLPofkZndiBIN5uoL4yqYdLScwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910336; c=relaxed/simple;
	bh=/WIjA6+87+scFdFvixFXT4HvbhtNx2XLPBE32x1o1u0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gqAXMZN2d49cTv9aoC/IRmZtNb8T4a07TSI4RaKofj7BTvwkl6LcrN6cBrT4h5HwKX3Fxn7I9Or7spPKx3VxP9zczEWioNAdmAiJTUGVYQz4G7lWoMHdFGHZMm6jkaL6NWwANmZtKYzoRqi22/wh1Lmh8zXADuuBlLfSERIZDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dLiag/ch; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VFIxnrzk; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dLiag/ch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFIxnrzk"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 0576B1D001B1;
	Mon,  7 Jul 2025 13:45:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 07 Jul 2025 13:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1751910331; x=1751996731; bh=IJU9LEaZQ2VmZR6VEKqECDCFovPWskUL
	oYDoYpEopLY=; b=dLiag/chI0eY3q8RBF5TNumKs3ABm2+abVvlIoWmeIOPSYgQ
	4tE+AXMK3buAcKqyzUT1Fbyzf7qYqtrHDczq20qeQ2XQwI901sw5Aj7aPpEAFAaF
	hV469FD8jfTje9fgWL9568tD8nlMb4CQTuDk3+7k0EhLQZrohHr0SdVTYZxk5mr4
	S+dGrX2O4ibxUCsVaN60xBDT8jx8SlBmGR9ReBj4Hrof5bUf8V8xfbEvoBPNj/t3
	X8m95oNsp55wsvKMp+IJRuvctWe8DET78x4GUo9lkWrmDp9qm+u6+cT7muG2jlOC
	/9s1H5YVWcHWZKpJgRsI7Qxru75k0o0lTEvkSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751910331; x=
	1751996731; bh=IJU9LEaZQ2VmZR6VEKqECDCFovPWskULoYDoYpEopLY=; b=V
	FIxnrzkLpCNpS6qVJgsRV5A0iw3FbfmbpgsX1l5neFc22Y89HZ9SPtmGaas4QE4q
	/3EOitP8YvugjwvfpXKYmf7cCwGpOe/KwhCJhLIYDIeoesg5g1DbXuVH0wsSG2FF
	0WgE4PBOmrUnTyhu2zeE+72VtgSkhykYUKdEtcHqr0nV4adAVoHB25aduKsOzlcf
	cYPw54wqwwhPiOKiN9iAaUtlAOJp+1r2AJX/SE320zxO/vxosduNAa1NFbFUDcYF
	QJT9DaRmMHwPTxKo6UdOs9Oq65o13yAHZxGctl4rOITO7V6kDKKH381njkX0EoHg
	5rPQXtg9TL15xLtFQ37Bg==
X-ME-Sender: <xms:uwdsaFkqDPhNBzL7YHb36G2t7j6k-yvoxipX0MznziPHe2Qi3XTPSQ>
    <xme:uwdsaMWQWGZJmY8eb2j1oo8PSwTuzO3t5c_3kNfTvdqK3BCdhbLStjDTJaZ4OvaUj
    KK4onBxOIIlhN3btQ>
X-ME-Received: <xmr:uwdsaCHMA_dVWce-Jsi1Itzatezac7e5dRzpjZh4Ey-x4ldgp0sIudAqNDZWxVLRV0PgnkC2OsN-P56d0aN9sGuo2FBG-skhC3bWMJyF2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvdegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehttdertddttddvne
    cuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhm
    qeenucggtffrrghtthgvrhhnpefhhfefgffhtdeiffdvffeuudehfffffeehtddvieeuff
    ettdffkeevffevledukeenucffohhmrghinheplhhinhhugihfohhunhgurghtihhonhdr
    ohhrghdpghhithdqmhgvrhhgvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepuggrnhhisehgvghrrhhithhfohhrghgvrdgtohhm
    pdhrtghpthhtoheplhhutggrsehgvghrrhhithhfohhrghgvrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehstghhrggtohhn
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:uwdsaAdNhZcvVFPKIJsiS9t0oKomMuIMqTFPo3gZxwzoWQ2nexX9jA>
    <xmx:uwdsaLJvZl9_IM05Qfl2eY9rw579cOVEmkno4DENaB1QTPqVoRx9tQ>
    <xmx:uwdsaNHCSFHH2uT1KMbvbSKD09fbPfWyKBykfwWzUOhF9iCpnMAntw>
    <xmx:uwdsaGD6H8lX7zfMlwppOM-O75D-XFWDExMxK7b446KBHkduW2bCGw>
    <xmx:uwdsaNj8TJuc6CJaYd2QP5o6nmp5u3MQnh4RoLykGi97mx_2FXglVSWZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 13:45:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a497b78 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 7 Jul 2025 17:45:28 +0000 (UTC)
Date: Mon, 7 Jul 2025 19:45:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [ANNOUNCE] Git Mini Summit at Open Source Summit Europe, Amsterdam,
 August 28th
Message-ID: <aGwHt9HCd86hVuKh@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I am happy to announce that there will be a Git Mini Summit co-located
with the Open Source Summit Europe in Amsterdam [1]. The details are as
follows:

  Date: August 28th
  Time: 9:00 - 13:00
  Location: RAI Amsterdam, Europaplein 24, 1078 GZ Amsterdam

This event is not intended to be a replacement for the upcoming Git
Merge 2025 [2]. Rather, it is intended to be a smaller community event
for those who cannot travel to the Git Merge due to whatever reason, or
those who are interested in Git and already attend the Open Source
Summit anyway.

The event will be structured so that we have a section of lightning
talks (probably two to three hours) followed by some time for people to
connect with one another (probably one or two hours).

The registration is not yet open, but as the date is approaching fast I
wanted to give the community a heads up so that they can plan. It is
expected that sign up for this event starts next week. Tickets can be
either bought as an add-on to your already existing Open Source Summit
Europe ticket or standalone and will cost 10$. I will send an update as
response to this announcement once tickets are available.

If you want to submit a talk, please send a short proposal to me. I will
vet these proposals together with other involved parties. Deadline is
July 28th. Furthermore, if you got any other input, please feel free to
send me an email, too.

Thanks!

Patrick

[1]: https://events.linuxfoundation.org/open-source-summit-europe/
[2]: https://git-merge.com/
