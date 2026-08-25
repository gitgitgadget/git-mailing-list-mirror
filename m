Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B9175A83
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683039; cv=none; b=cIFR2uj5skb9fTe/ThC7uOVlUYBM2cxsFtn/OA1KBaRkag4fv3svEu4BC6NjZrKOiZZoU2gW2aHi7T7AASlpu9Z+A9gSEvYdgY64kBTRIuVKe8XXXl6DsoOgRLZ2m1frrdV6fvlGhJ4NgF1jmb0cHveeH4AJbnwj3cmCLw4G4rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683039; c=relaxed/simple;
	bh=bJU+dZ7UR6zdnoBj5QMLblRcC/FFQE/Pkw2vkx4SoVs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TKrPCz/tHSIIRZBbbBQShqe+yHOOEwbn2vKWp50tkWjGSzRKSERyTniz1fB+KZBT/EKec1/nDEYJSA40XRXVuULXpDF+Q9xKT38mnJVEOjBXC3kUtLEvN/xBLq/+0xfdIGCSK3k9haU9UtJMEkXzZWF6BThQtc1Kz0vyskJNRpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XlddejfM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QNWPLIY8; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XlddejfM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QNWPLIY8"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E282D14000EE;
	Tue, 25 Aug 2026 14:37:15 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 25 Aug 2026 14:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787683035;
	 x=1787769435; bh=hdupONC7nAnWWAwOJel/FUgD/AzZhd2DQ/XiaqRZWMU=; b=
	XlddejfM7WzC4H6eTc25mX6gEmlQuumfHfvaY7Z1JTnL+Lp3Vbir5BuDIFHSCwdm
	WEAJfhHvjzIUhqX5ngA0MwMKLNvkzE5Ws+m0s3ZNq+akoInjBcit9v93tYkOKn0A
	Q5HsR6IUEQVYEacbG/CzU5Bqo+IE5Lkr+v+v6ksaSxv2FP72w3HzNxEqAIvucjSz
	3FtGXTHE3h0UnseXK9BHgeJcdjFAkV4IFpdKJLDiFiweRKFTpEPr90WHUST45EG3
	04a6f7dx1BKVZ4YpyAQZqiJyEfQ0Blw1/9t8zTvybpMzN5CPDyIeriwolllv2TWM
	AxIVR04psVeCjMzOi4bc9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787683035; x=
	1787769435; bh=hdupONC7nAnWWAwOJel/FUgD/AzZhd2DQ/XiaqRZWMU=; b=Q
	NWPLIY8bRgVm5OGzeQ0n/OS7Ze+eFIvObpKijdg81wqnvUsmk7t0fdKumHYcZWmE
	j741O1vGtsqqf1FjhzU14lMJihVEbAmGe8U89JQI2UyDHLvWxFkrgawnQbDSYUyG
	g8Idrl7yJXotPjS6ntV+nfF8r3X339iGDS92Xb29ZECk2R3GNnrl6aqBc3vgQv7Y
	21gXeqKqTGeMEuxz5x8iYlfJei+IgSx/fVwFV9XdKqN9AkAvDQsB5m1z6a5tBM6q
	ErgabeYeGUAygcUeVUV6T7E/GXBJtcVIK36iVMuTOMQ6vlEv9XVgjoUk07GLFFUI
	0JVDoApFCeSLL6HTo2o3g==
X-ME-Sender: <xms:2OCNajNo7xTucYnJzA06GDifsxPB1kQsOY_4SB3klqmBEfZdAo-HmQY>
    <xme:2OCNaowDICZSxUkAZIoPCXJ18B9sOq8FhI3S-VsUxIXO1Ngzr2Pe7RVe2pmm4QpAU
    Yx2a6aVQP1X77oB-1NPMl65gzeYbMAIw6uxl9ZxWpLU2OjMCoBr>
X-ME-Proxy-Cause: dmFkZTGKlQhSmk2t+Gy7vUFgIvk1P9ZjCBlwd9mJJxwVQyhEhEaLdlTKO9t7c9ETUgptTf
    VzX4J+TVXWS1R09wCoOgyKUAk3udJwF7y6cELuK/i5M4/W5wp0MQd6BoFt9Ay80WtewW17
    npTzGgZoHF2zbONH2AwgVOTNVUszPnjrc/Bi2mn9Iqu21nnpyqS6vISeoZLiuWp/BVkyJa
    35F8BYcpcCCmHXlAVWEWsrYM8kaF5MHqJKFEd0+UeyKmCGDE6wphD2S3yKnlJpnrxAEv0h
    /8sOqxyTXq8dnRRS+he7xSsRI0wwrqm+CamXNCn3KsyqSMmfhVxyoh73s/1rLIWPIXZHFH
    SOoFw/85KXKQ9bBcsom6F4addKOKpgFtv7hJRul8EPNOGA2kJygYveWI6kqUMI+IWSch+P
    /qGJziYkLZRxUirJ9EGzftMoNEeRjGPJRZHfP5UQ/5/9aNXNKncFu44dcE9+n7gRpYoO95
    OybxhYltpFlEmGyAhJp5c2AVT0cZqLstME72qHwTQ7mdbY94qx1lP0GdLoh/mEjoX/lWKj
    6gsgs43hdHxXaB+7uaoNTLhNiUCQWq5D549o5hE/v6yLI7PL60y20UBs3Z6LapR+NseHe6
    Ox3xSejYvJOCFlxfVAC8t4D6mMWLPdUAIOWtdbf8erQQ0GLhFv85m8sHi4bw
X-ME-Proxy: <xmx:2eCNah5CAIIIDP0-Aj39YGfEEotYNh7wjp_ddfjCuhFLKtMCQwFECw>
    <xmx:2eCNas1jBbUTp3pX32NOs1McE7_CS2SmKft5b5i5ZT3J-hHacQw4WQ>
    <xmx:2eCNagAquJtOZkvztunQn6i4Q7_4cygTE2ABLnZRiZcjrALpwvAj8g>
    <xmx:2eCNam3NvRgAtWAVBOneHQDOQbkHNpnhaTlSCe32FLGSkkNcYz3dtw>
    <xmx:2-CNaihGy_ZOfPZqhASXuaZ5IrfWUFyqMAKe7J3KJRjfkkrCDwVdm591>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2377522C0078; Tue, 25 Aug 2026 14:37:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Aug 2026 20:36:50 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <16315616-097a-4fe2-8665-010e424afd8b@app.fastmail.com>
In-Reply-To: <xmqqjypfp2vl.fsf@gitster.g>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <format-patch_learn_--range-diff-notes.c5a@msgid.xyz>
 <xmqqjypfp2vl.fsf@gitster.g>
Subject: Re: [PATCH 3/3] format-patch: learn --[no-]range-diff-notes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 25, 2026, at 00:31, Junio C Hamano wrote:
> [snip]
>> +Now the range diff is back to displaying the same notes as the patches.
>> +
>
> Hmph, this is a bit too complex for me.  When I say
>
>     $ git format-patch --no-notes --range-diff-notes ...
>
> I would expect that individual patches would not get notes, but the
> range-diff will include them in the comparison.  But if
> --range-diff-notes just falls back to default (i.e., inherit what
> patches use), would I see the notes used in the range-diff?

You will not get patch notes and not get
range diff notes. That --range-diff-notes
told it to use the patch notes which you
just turned off/emptied the list.

Code-wise, the list of notes is cleared so you
you would have to change the --notes implementation
if you want to keep a sort of shadow list
of not-patch-notes-but-RD-notes.
And another problem, or fact, is that format-patch
does not show notes by default. So what should
--RD-notes show? The default notes?

Thanks

sent from mobile

