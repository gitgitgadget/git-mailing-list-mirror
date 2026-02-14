Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B542D339A8
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771064388; cv=none; b=jHlxg4yWkX45elTCsaLaSU9SbBf0gDcseoPqcISuexSJEyhF0Jt5chuyYGnxgEs69xLxkcaBPsE5lSMpvfH/T9U7pKIxV5h3p82xAgMmFhmZ5PvNSvshr3JqiuyMDwCnveLHxbIhDPv9xy1XXErFWT+BP4iD0JPIZlM9uPoyRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771064388; c=relaxed/simple;
	bh=aU0ZlwODBlYDDp4Ec+rqkbYG5SzIP5WV3CioaIx/xVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nC0Mqh+9uCWatad0KT7IlTS8SXJ5VOHwrfLmSaB+dHs+FCnJE5UL6jFDhKYXirZd4BylkCQLtvEGRbCRWuBNjV/aR/uf3X960l65XzIIYd+XAfJVB/F4tuOHO4XLYP/VBeSZW7eRnUcU7RTvYPf6mKjsEYHVuMWGbdmEga7rzH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=I346zJd1; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="I346zJd1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1771064385; x=1771669185;
	i=oswald.buddenhagen@gmx.de;
	bh=aU0ZlwODBlYDDp4Ec+rqkbYG5SzIP5WV3CioaIx/xVc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=I346zJd1aBX2bXydV3EiDHvu95uPsfXLpVETdx4NtdHdP3EghkeHTxewj6+P1HO9
	 oAAzBNg3IN8MckWC/ltLr4gBnnNDadwoq+9isjntaL1FbLtsrNzI/STXwiAi0b2hR
	 eqce/YLKnQ5PySS2vq1YsvdtOvXTP35cjbbGnjnTtmpdA2263DaR1UFOzZNAt35iu
	 H4zrdWx7Mlyfn96hC1zzZI4t60i+pHHsshLY3LPy3xqm65lINgBfiboAEcL97aWix
	 paqRFc3reJ8M752IbNLcCRSqMxPFYvXhosw5ScrygAX6ahr5tbn3thjOBY2xC4MVr
	 70rZFRNGYoCzUJIj0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.117]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1vvek43WNs-000aKh; Sat, 14
 Feb 2026 11:19:44 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1vrCka-JbD-00; Sat, 14 Feb 2026 11:19:44 +0100
Date: Sat, 14 Feb 2026 11:19:44 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] CodingGuidelines: document NEEDSWORK comments
Message-ID: <aZBMQGQPiE3cJBUq@ugly.lan>
References: <xmqqms1ft7il.fsf@gitster.g>
 <xmqqldgxmzbj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqldgxmzbj.fsf@gitster.g>
X-Provags-ID: V03:K1:O218FfBw4z87ONw6/PkE8mSxukwAQPXITWkaXh7yZ0kILfORFie
 YtTOLUYt+MfXfr0ByeSwv1gjhQ2uxQV1AGZwx5Rur2qrCbiseNmLnT8/eVi6ypCxdkY/8te
 bA1kQFME5pzIZyaV3d0W+YPm4j0YcNpkkgbf6yqPK31HOPQDoxlVeqoBD+B72q2U2lgN7w/
 +GVa8hiz7sxZcXEp3PONA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BjRK6GOW2fc=;MCAXsjyl0scSzuQUlW5T5VQyE3j
 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

On Thu, Feb 12, 2026 at 01:22:56PM -0800, Junio C Hamano wrote:
>+ - A label "NEEDSWORK:" followed by description of the things to be
>
by [a] description
