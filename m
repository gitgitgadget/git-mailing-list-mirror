Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7723B0
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752747914; cv=none; b=lAnNhDUDqJaOejlUURyuluPmrmnjS4vLaT2HHYN3a0e0v8eEQ6Iz4N03mj10iogHUDDXMKnN1Plr9u+KFxyO4JS0xZRwl0TpPWT5LL9q4UlOmK5lMuQqJst7cpRbToDKUMPjRtU7putNAejuB0PG8I21gYm2+f56w3bBmOjYlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752747914; c=relaxed/simple;
	bh=ScGqWZinoaKWO5rmSsl2TlVOW77SSgv8wJTzZaTTP78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbUs0OEyiSy6h1Z4x6wNreNfjwVN/F+4nZ47gEriYgX5VCnP1bq8cyaHEQal+XkT8lkySxllFyzkTTx7JvohO6DqSAzOy222kaV9lvbIpRxqV8tP0NxMSNjyLEJiyED7WOiBUECDGbCBhWxgD7/S57/SP4nW5Ga0iGN55i/lPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=sgamR3E7; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="sgamR3E7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752747905; x=1753352705;
	i=oswald.buddenhagen@gmx.de;
	bh=ScGqWZinoaKWO5rmSsl2TlVOW77SSgv8wJTzZaTTP78=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sgamR3E71+sngSSM/hFTPvBKD6rUnZ6gMSuRHEhuHVgp5N47gzQPQPKH1MWtLPEO
	 GMUyWAfROEWMTC0RCkyPDzB9pXTTLNRgQGb5Ug6fAY140FH0SFCFj3E5l6fsdrWmQ
	 fXFMfJB2NLl1S/oebJ1UxsVEAc23w7gf4uoZ3Uiacadc8EfsK6Q1noUD23oorveDT
	 qxYGn5s8mY9JFcEaY5CQHuG9xJtgvwr9MDH9T5eO2CM7G0z/VjStK0NDx+72I1Rja
	 /oOTKckZX0YRb9Aor86DNGQRav4f628bxAimLIxGATIo9BwP5rymfurcln4N/nJnh
	 VM6ikSivHXSMVCCfnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.106]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mt757-1uroBV2WQD-00wIsz; Thu, 17
 Jul 2025 12:25:04 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1ucLnT-WRN-00; Thu, 17 Jul 2025 12:25:03 +0200
Date: Thu, 17 Jul 2025 12:25:03 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
	ps@pks.im, karthik.188@gmail.com, ben.knoble@gmail.com,
	phillip.wood@dunelm.org.uk, jltobler@gmail.com
Subject: Re: [GSoC RFC PATCH v4 0/4] repo: add new command for retrieving
 repository info
Message-ID: <aHjPf2so4BzQkYRO@ugly>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <aHYuwlWlbkc600Ps@ugly>
 <xmqqecuhiekv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqecuhiekv.fsf@gitster.g>
X-Provags-ID: V03:K1:+oJC4Vaylp7dK6e6B9wp34tP5VnGp+ZuUWMfvRf/usvWdNZAhjQ
 XQOsvorloltzI/dWllAXYP+A6/ob2x5YH0pwVYu3Z/wYE0NsbNE+NqabDv6JIWQ2gU93BXW
 thjOlWK6+B7d+4MzC0JYgMl0d6e9SKS29A6igjxffBLSdOJf5aaglmoQsBn+m64Vw636ead
 xDLGi+/zbscE9Tin94XQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/WeUi7l2PtQ=;fBmx7lBO4DbGyjvxQ+cnbjpab5v
 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
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 09:49:52AM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>> the obvious followup idea would then be "meta", but that suggests=20
>> that
>> it isn't only a read-only command, which i think it is supposed to
>> remain?
>
>"git repository query"
>"git repository stat"
>...?
>
yes, but one could also add "git repository set" or some such. as such=20
symmetry is reasonable to expect, people might be confused by its=20
absence. an obviously read-only command like "query" would preclude=20
this.
