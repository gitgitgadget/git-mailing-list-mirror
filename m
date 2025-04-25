Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82948231A2D
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581475; cv=none; b=tSG3eNpenTwCFeBfG2Y2I54KgkaOgIfKz4ogxnnfVn88oqEFG9mZQ/kcw2dluIhS3U5BC+dRl64SERPU9AnzehwAw013T1y8fof6R25UnvTTwmMMccU1T5k3pDpRt5VRgBkVf0dPs9ayaPko+HnOJoINkf/NZe4dAW5OPS9qG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581475; c=relaxed/simple;
	bh=xKjBCPDoyOYmXYKKT/Ip7A9S097IiKpbInG+3+6bg+0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Kzq3IgcX3xTxoaYZaUqhd9zls14DbNz96PEXbMnddzFKYp9JuqWCwKyPM0QWThuaxuN+wzHzSB5xqax8Ja+ucN32nkOtyDLwGwgWx6ESC/3YbrTfAcY35GrCjBsFZTF3QMHmk9LFGQZ4ypTzVdLy8CcMsk4jot0w6UqUv70DXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=gjkzEBNs; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="gjkzEBNs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745581468; x=1746186268;
	i=johannes.schindelin@gmx.de;
	bh=xKjBCPDoyOYmXYKKT/Ip7A9S097IiKpbInG+3+6bg+0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gjkzEBNsQYSN/7LED4eCqpxvJJ4h/vliSnZ/M4HT8K+GpCYzHysjqu2xU/kuoIr7
	 e+QeRYfMTQ5tmSb7K2W5Vm+UGkDCaRFl4j29+8xGHSzoJPWuZQIfkOdZ8zPB8M1o2
	 e9KPhxENlX71+gae6FhfBgc6rZDOXdWkGXtO1P9cMH3BoJ+ae3EMbfZRaxWCzejrM
	 ovoq/4g5KTNWPg2nELwIAHV5bDEF3N64mhbGGtjwKOV3PTF3pL9BMegX4RFF3mWgA
	 YS/fmpps9Q0iNw9PPh2gGr2UiTgYWJCxmOE19lxhiUJ8Q/zo+0yWht3QO/sDqfOe+
	 lmG1ngntWYia2W0OyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.84]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf0BM-1ujG7S0tqc-00ichg; Fri, 25
 Apr 2025 13:44:28 +0200
Date: Fri, 25 Apr 2025 13:44:27 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Lars Eriksen - DSV <lars.eriksen@dsv.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: cURL in git for windows does not support HTTP/2 anymore
In-Reply-To: <GV1PR10MB76004ED8EC327A2D11EDD2CB9B842@GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <01fd2b48-dc9e-ec69-b4f9-1183beb7f8a8@gmx.de>
References: <GV1PR10MB76004D6F2617B561A7718A099B852@GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM> <1cb70ac5-31ee-ec1b-dea5-e900f28a38f2@gmx.de> <GV1PR10MB76004ED8EC327A2D11EDD2CB9B842@GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nTMwrlKNA7VdQvp9MArYS1cMdXtU9pyvkMzYH7ZeSu6ckd3DL+x
 GFxrEBMTthnG5FfRZCJy+/4MUd2cCLpud+bMyIvd0n+b1X+1AFC5CzyvIvx5R3raZmv3sPl
 2NmszcsnPjzT4V1ZK54KnqMdcADrVo6RsLGx7g9/+pGr/E1KhS7HzEuuJ41ffJ2SyibLsxa
 6pKyQ4hBp/aZtxSvp7NBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vl/LT7AcmGg=;9ls0OjpUBlJ63cqCbZv2vPY8vGt
 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
 g==

Hi Lars,

On Fri, 25 Apr 2025, Lars Eriksen - DSV wrote:

> I'm sorry for the confusion, but the problem is not within the git
> command itself. This works fine. But we use the distributed curl command
> for POSTing data in a custom script when we deploy to production.
>
> So the problem is with how the curl command is built for windows. It
> used to be built with HTTP/2 support, now it is not.

I am sorry, but Git for Windows is not really intended as a distribution
model for the `curl.exe` command, it merely is shipped in Git for Windows
because some scripts require it.

Have you tried using the `curl.exe` in `C:\Windows\system32`? If that does
not work, you may need to switch to MSYS2 (which is a proper software
distribution, not a hard-baked one like Git for Windows that includes bits
and pieces necessary to run Git commands).

Ciao,
Johannes
