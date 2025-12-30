Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9C12765FF
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767105234; cv=none; b=beLDDkByW7rMo7JoiOLYLrsL5oMvWA/LWaztNfjsXfkD/MmuhAqwGAmnYAFUbJIfpDbRI0WeXZh+HqxOOHFIu9lOJTusfxWwR0JM4zI+lk6ZPwpn5qr+CS84vVUE3n+r6p5I6seK99IgDZIXHBAz7MppmulM+sAGJ1FjC7E4KP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767105234; c=relaxed/simple;
	bh=dsy6V7snh577wZ3ZxDsSdfcd8MO8ZgmgPkzDEEKq+jU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ijc52B4d5vF1FJ7Lq1vJlutxUjaY3lX7MNBogBAbe1McrAx3yYPiVmAa3ZN4nV/2lQ1ky9pCUunSrDAm6plPT0L58XHm3PcVhbp3RnFNcZlBG/2AfmEjb/s1T4Rk6WzBUSHua8N/e0WxyG2btJC5lZZmIPyT6iA+DUJVPW8uy0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=es5MQVjI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lBb20Yi4; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="es5MQVjI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lBb20Yi4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 88CB21D0009D;
	Tue, 30 Dec 2025 09:33:52 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 30 Dec 2025 09:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1767105232; x=1767191632; bh=CgkauNRlQVarGERyazJn2+LV+Rcs+o8C
	0ZPYHzl8QZw=; b=es5MQVjIBCVFETkRLkYIZZOW2ysaCQZQFgqK49eRR3J51dnY
	pCmFLp8HojiYy74XR09W5K/FfqUztkfXjKuDCDCGUHzN1rxoKH3pMhvOHfko9f8q
	yntVpQYoKBGsY+U8oce912OKypkOcnLoq2/Tk4mLqQ4MgSq/6J8TqGKoQoRfbcLp
	TSxSDfglbA5rHa7oMyMdtuMhgcMKTyUIDBKSuaaZvkHB9VoDLXDfjMBG8XmYWi3L
	4Fegs262A/Fh0C3nxRmdcqqEQ8h1LnfgRLOVFz/FrEmlLzfu2f9L6no54IuYTGRR
	3a7z6tIopaQGiNPTF1io3CXayByGOcixz+jh+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767105232; x=
	1767191632; bh=CgkauNRlQVarGERyazJn2+LV+Rcs+o8C0ZPYHzl8QZw=; b=l
	Bb20Yi4oTKrDscEeNcLjPDfwVP9RCmxnH30qdIaqV74RIFciATRoL4d2/0zKOfTm
	AWF7sf2GDngA+LdWo6XQFSt+qbtin3Tc7sBLDcz72cQlzZuvWNaF7H7h7dgPQUOa
	D0MZUIPsIvBirf5MZimeyYbk6JFGvyqPZZEHfL5UcQsyT6j8CGcdAaOnWQtbasPL
	0MaVoUr8ZAqSFfRvgshRNNV93OHe6ZvzJbuSZiaVpy8GjKrqRaPuE7joBACNuovG
	VuSgajQKcLdgT69wrPNWBRjmXVOiVRKBTiI4IdrFJLx2PaHTlJm51m2mK6Wf+JNz
	mBE+o92st+z4kHNIFqSiQ==
X-ME-Sender: <xms:0OJTaRBpT0593O_B7xd1VFJbngmu1JW5CiUBdlv1yw4uKr2ztD6dGPI>
    <xme:0OJTaaXvgkZiycRI3PIGAd-NAjdRuoYJIfXJz1V9BNCH66D96Li7kvBhqSbiadZpH
    0S1z0g8wQJxXzZrcDL9cx2BFyrDLoWHNpyvhSqGQEo4eD4c1e5CCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrh
    hishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnh
    grfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:0OJTafAwhsDWF3YkVLYM-hOdT-s0vrQO3RjqffKE-49KVBDHhKygfA>
    <xmx:0OJTaQeVilV0NzKhY2emjwopEMraG5a-0TYoLeQo96j6LMiQtqUkPw>
    <xmx:0OJTaZk0YnAODPJTEKbATB9dxR7AT3FFPraraKYjwQv-2xn2zSlLqw>
    <xmx:0OJTaXHf6z6dneIxYR8j89AGidNVABarieTgmqsCFUb3nfQuRKLVJw>
    <xmx:0OJTaUcQV3W3L9fAOhyOys8eWCrxhvc8miaQdbwq_cKzRcfWeC5E-Dt8>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 08C1C1EA0066; Tue, 30 Dec 2025 09:33:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aw450i4YyXKZ
Date: Tue, 30 Dec 2025 15:33:31 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: "Christian Couder" <christian.couder@gmail.com>,
 "Elijah Newren" <newren@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <105d610f-f002-4ae5-96a6-f83595aba19d@app.fastmail.com>
In-Reply-To: <65d19cff-33cd-4209-af3d-6a518254019a@gmail.com>
References: <CV_replay_die_descr.13f@msgid.xyz>
 <replay_regression_tests.141@msgid.xyz>
 <65d19cff-33cd-4209-af3d-6a518254019a@gmail.com>
Subject: Re: [PATCH 2/2] t3650: add more regression tests for failure conditions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025, at 11:58, Phillip Wood wrote:
>>[snip]
>> +test_expect_success 'option --onto or --advance is mandatory' '
>> +	cat >expect <<-\EOF &&
>> +	error: option --onto or --advance is mandatory
>> +	EOF
>> +	# First line is the error; rest is Usage
>> +	test_must_fail git replay topic1..topic2 >&1 2>&1 |
>> +		head -1 >actual &&
>
> Using a pipe means we lose the return value of test_must_fail here so
> the test wont fail if the command succeeds. Everything else looks good

Thanks. That=E2=80=99s kind of subtle for me. I=E2=80=99ll fix.

I=E2=80=99ll just test for the full output instead of the first line.
