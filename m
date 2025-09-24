Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535E1A316E
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732873; cv=none; b=IUN2u393OfwE/e0NMjpdbpSky14A2rXHvrVDfxHmn9pjUy332Z54TteO/NXBvTqrTCz2poiLkW0yBa17bT7MG1ojzVxQ1tTi6901FFU18+cPuiucpKNekSYZ0KWNWSWg/dsAJg9p7jVvGMaZMTFUPaKJRmEsVcfMWpS7+VvbPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732873; c=relaxed/simple;
	bh=0OtZEPVhW6UnCFiLRQytBJIMjZbxNZ92RNLR58OK/gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAJCDqXujEu4sWU0/8ni8sh6fg8kpMJCsBnbTfNllpomUsSLDAkcWBrhvIT8xs6wv2nPt7JgWDojSaoksCufdk1eksVWqdsBxsCbitP9uTyNrLPHa2KQwbILr2Q/AmWyyAFV+WiRGR4rpi4Soh2WxFBgqLwKKDENBI3jkKZpuds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=IYhiQj7X; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="IYhiQj7X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758732868; x=1759337668;
	i=oswald.buddenhagen@gmx.de;
	bh=0OtZEPVhW6UnCFiLRQytBJIMjZbxNZ92RNLR58OK/gE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IYhiQj7X/AAIA7yXkjQWiPPOJMrkD/d2MuOXfjoOdPDxOzAPKzi8aySCO/q8j8iN
	 svsbFvR/tlPlwUUpOn/eoDHK94JYO/Yi0tS4dNyYbuoga/1xkFZnIfHfXSfZtEG7K
	 1ZJZNVsnbPPJVTUzQHJX5MzgxT5JgSI9jHtnxSDQs2CKyflE9L1fyNcH+7J1YfLPc
	 LWFY6mZr+ZwhMKVgOrc07PGf/1I9NMuwcBnEbVusNzXHxOkWFgZyZzDCSzLJzW9ub
	 fSUyAUMJOJLx9dqxfAYKIMxaTyVxd3Ya7Qh2wGyALForUGdlrDLidUWSC06UIMErQ
	 z4V6HNyLbeAvq2Xhow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1uXtma2xSO-00lhAo; Wed, 24
 Sep 2025 18:54:28 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1v1SlA-7ZC-00; Wed, 24 Sep 2025 18:54:28 +0200
Date: Wed, 24 Sep 2025 18:54:28 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Mathias Rav <m@git.strova.dk>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: use same commit's message and date with f -C
Message-ID: <aNQiRFbBysXXAPDR@ugly.lan>
References: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
X-Provags-ID: V03:K1:Ydt66gr6saHiOB/jgyC7vSEtdqjRvyYSSN/YafNN3rf4CwJqnI2
 jw1hVVyQmLpPZjmXR6bYD/lfdG7nF6seAPNZJyMLli0lB9vebRvPPJ4mGiTVzVB/OFhm5um
 8CMjyz4lRfSkn4bVVALMP/IbG6DdXPl4KtGjxvqF1g6cwgTvLf/5yh9MXKFA5UwP72NfTSx
 EPSJC805pbXTM4rPqqqkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cW6R1syNNXM=;UfJ34/WeqbuaP8ICyD9OxDT8O+b
 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

On Tue, Sep 23, 2025 at 10:55:02AM +0200, Mathias Rav wrote:
>Change the behavior so that fixup with -C takes both message and author
>from the current commit, instead of taking the author from the previous.
>
related thread: https://lore.kernel.org/git/YjXRM5HiRizZ035p@ugly/T/#u
