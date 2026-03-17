Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050D27FD51
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785434; cv=none; b=c52NRU2DZFMaTj0Vc+oMPq+Qt6IwAGmPFSTAoGEqcrmRCLQVLDuXqtolxBKwwV4RDdFIqBK/ay0OcWfHylcDh87KMzQ07i+YdvStdc4xKQYCf9iMmltDweLy0WUEwuC7HlhnmnAgNd5im3Bx+b4R/uqCPRLsYWP8ho6XpzXAZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785434; c=relaxed/simple;
	bh=bCmHOT6gdTXGYdtYaO0EAyp8v6uNISJmKF2fs3Brb7c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VagWGciKET/MYRYBPqy3DK1ZrrUWX3Yf2WzrnJEh+3Shbm/A1N28nBxME0YseqPG6S9tz6adC0xVv5GeUaQroxhIAElkj97SzssS//Lh8Yf/TwrttkSSbDjsQMgYHRJi4I8NcjQdewJ5VgWZxbJx/zE5zS5fVWBI1or6ip5YjCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=qgttny6Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K0KBWX6y; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="qgttny6Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K0KBWX6y"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C9867A0182;
	Tue, 17 Mar 2026 18:10:31 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 18:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1773785431; x=1773871831; bh=g0vkYVSIC3B7DarXnvjha6u/CpAwTLEg
	HejCCTpudK8=; b=qgttny6QchyW65keUM8comExEbiSja28LxLcqYw8JJT2iIQR
	yqT/pRI0dT42w8gIWk6C5eWuWdmBw1y/5cJQIa6+31YfF9kWFRkbqlm6Cvi/8TdZ
	5742P+Wrin5Q46wmVmBIRVdO0RvErr3l/5J/Slwuvxs4BY63nPSbpKeJOhx8gdlI
	sOpIpF2boQxHDSGdHQDPjXzkyxOZ+ls8gJ3XIJ4tYsaUlAemZpgyuFlVyj7S3T8S
	Lra/96vwY3Lqr0FjoP7E98jLBP//wlziZa+I6RqxVC6s7P41Rq8cd8QZI+8K0sLG
	nqzUPUvM19l7ysKK8Nb/5DQt+aFysBPpS/SLzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773785431; x=
	1773871831; bh=g0vkYVSIC3B7DarXnvjha6u/CpAwTLEgHejCCTpudK8=; b=K
	0KBWX6yEPyOnC/3sbRhF0DEfxGZrei64UdHsctFrMW3TpiNwctY9QAFFvf5/UTbH
	/3qywGnwPt9KHa6we2PnhD3Ey3JqTaba91Q6COg/xMjFkzPYiZF9xVMrubgx6AUi
	dRuS0b+ovZtjCR+9fmU51/j1klQGrgewIElGCcqJoP4toyQkqKoT6Tlzs0QIfLwv
	SxSP9U5VJcZTvTRanaKKd2MJqyTXZ/wXGugZJMpnFr9XqBhcRBoZLbBn2SMpcvhK
	rXWOZb71g012L+U+xX7LRVGZkTvCVo6FSz3DeWxp5bkBfpb3LS2h3SenUrAhxR+P
	cWNXOKrdneVnlLwm/mgLQ==
X-ME-Sender: <xms:V9G5aTctTPzXQtGc3oJMjkMeKwxbERr-0cQdruB0eriMUMHoK3omNpo>
    <xme:V9G5aUB-URmtk0ADQXwnR8T1OzJT_EULlE8M_Jg-G8IKcEiv_c42yt6tZb24nWdex
    y6Pal61QLn2AsV36uwOeHd2q4jSGa0K_wd4ebF9N4IWRBvCxiFVJ6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeefte
    eghfegfeevleeguddvkeetheeiveffudejlefgudffffejleffffeludekjeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:V9G5aZYmZMmEaCr9JnUN5LJfTZAzWYrxugsOV5V-O8F6ZKoQg20ciQ>
    <xmx:V9G5aYK1YUk7GvVICItIf-7Y_oICS5VOsdSdx5qp76JsZobBV-kLKw>
    <xmx:V9G5afCP5oE17DjSf8oO1cXJCDYTJJiylP_niQ_65osgR6u7WgTUfQ>
    <xmx:V9G5aVpqTlCE7uht88ozgIruiI5kvnLrQ3CF7GFMPrMdAFuIK2wp6g>
    <xmx:V9G5aQzTb3XHpfLU3VSB1p9Gcqu40_N-YTQNuD-i61GbOJCxwyEL3Dmc>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A43021EA006B; Tue, 17 Mar 2026 18:10:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlHvjtmmkX_N
Date: Tue, 17 Mar 2026 23:10:11 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Message-Id: <9ffa0e37-3bf4-47e1-bd3f-34962cc69633@app.fastmail.com>
In-Reply-To: <xmqqeclnz2dv.fsf@gitster.g>
References: <CV_name-rev_--format.4ad@msgid.xyz>
 <name-rev_braces.4ae@msgid.xyz> <xmqqeclnz2dv.fsf@gitster.g>
Subject: Re: [PATCH 1/2] name-rev: wrap both blocks in braces
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026, at 01:22, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> -		else if (++counter =3D=3D hexsz &&
>> -			 !ishex(*(p+1))) {
>> +		} else if (++counter =3D=3D hexsz &&
>> +			   !ishex(*(p + 1))) {
>>  			struct object_id oid;
>>  			const char *name =3D NULL;
>>  			char c =3D *(p+1);
>
> You are correcting "p+1" to "p + 1" to honor our coding style in a
> few lines above "while at it", but there are three others in the
> same block (we can see one of them in the post-context), which means
> these are now inconsistent.  Fixing all of them would make it a far
> larger change than qualifies as a "while at it" change.  Either make
> it another step that is an unrelated clean up, or leave it as-is.

Correct observation. clang-format got ahold of a few stray lines. But I
thought it only corrected the indentation, not that it also caught this
arithmetic formatting. I=E2=80=99ll remove it in the next version.

Thanks

>
> The primary thrust of this patch does make sense and is executed
> well.
