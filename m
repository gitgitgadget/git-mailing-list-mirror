Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8DE79DBF
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709506726; cv=none; b=TUJQvuzk811tPZt1/VsGc6XblrLYFYPcLPDMVh9hHsDqof7IUq0/oyQpYwhuqn9nWW1eYX3mdMO3kMXPXfWpRGqI2SlphE1zfgffK1aYMkvQZGf9JlzTDxVlUhYj+UCZEhf40eFUMgUErN4IyOtihiTCR0SefylpFHYAU44KnR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709506726; c=relaxed/simple;
	bh=bGB+Nx1mlKdjQ0rmOca0ypsMayD22P4n82y8atRWLoQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=RaMwRXRo9xqvwiSBuFDlBKHFi14ZthZKODv0a9nqA9tW7hIFR7jh0BXcj/w6N8lU0CVeUUQcGrUaBGrOc5n1KuZNSbm3Y4O0O+jO8uW4FQtHdchtDSe/ePsR0jSNqdcW+LAKMn1ARTj3HO5NH3DknFa4JkvU812RrT97HxtHD7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=u6Gp0xuk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n/vwTuzL; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="u6Gp0xuk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n/vwTuzL"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 10EF113800EA;
	Sun,  3 Mar 2024 17:58:43 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sun, 03 Mar 2024 17:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709506723; x=1709593123; bh=pd49cjoDXM84YRe0sar/AZv5CxEJeeoA
	LeiZrlrHvLY=; b=u6Gp0xukuuD5adqseb77bh92tsRuPviNdCy4yNgx3kB6ftBG
	pdxFuKnmjrgH1Ie4cWqOHNmHklef2XizZ0RmTCwn+pYXkB7hBAbmLIiWTiv0DLrr
	w+gEZDs93PJbCfJSXX395tfulWRtQLhT7UeSuHmstHYwq8wUO56qckLHS6t7QLkI
	X84pF5vAQYMISqlN6YnKkhaJN5+LsC9o6KQ2VatHV9B7YG2Bn7Pz35Djf5B+Q8Ou
	ANIlI2wdDEDtPSBS+wPyQ5xfmg0MwZohgjDLv0YymQRaAEL+xraKRji0KKTTweq3
	iKIqFFmS7KJrMf0lDXiP/++oWfITvmm2UVZgXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709506723; x=
	1709593123; bh=pd49cjoDXM84YRe0sar/AZv5CxEJeeoALeiZrlrHvLY=; b=n
	/vwTuzL+po3JCI4LDB7AZ/xfL2LuoMUs/T2kgGcWymfSVuEySawzqN3Yny6xWxCN
	ikK5eynEKOWDUQPKRs94jY0fzZ6+hln3oIYu2ItBGAmKnqHRYcvHC3Ub/QYxJlhI
	Q8xzJrq/O8AigbKbI7lfnw+p2Rhh/DnPCyOhZ6PeYezxsaVgRxIkg1tBwqUK1q/p
	WSjlmNSyxWLG7C+R5p5O846TbQz2VpPNJnkF1z4BjI+sztHYYb1ycayn5t/MEHDr
	oHsWsTYr1CWRSMHAqu5CTUGlrvV+3v2N9bH1N+Y3Z1KUYL8O9C8Moij7ElJ7TiMq
	VF8/glPCt9GTmDUdDwEtg==
X-ME-Sender: <xms:ogDlZbElZzJNzKPB5Kq29mG2uNsgTHAyT36FLaWRHzUIckrGEdfVzoA>
    <xme:ogDlZYUu6qbw57cV724oZZsEkYbVP9ZHbbgGNkM8ZZ2sLI2doYLAdu6iogC9y9Jvx
    FhZ7Pe_PPUwEQFZhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheeigddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:ogDlZdKkfac1nOP9NqUOGJAiRBI6OnBoPd9ISsT_gb2cS1BEgl6abQ>
    <xmx:ogDlZZFFD4Xw6rLW0vFiD-IMZovsxtr-UkgRxKdfV_xQ4ItnD86uMg>
    <xmx:ogDlZRWp8HtFSmIYpiMJnYjnUJOVdLJJoiyNDsPNLTupaIjU9mjXzQ>
    <xmx:owDlZQcSedsTz5xcfHtRhmLQtyfR8zftd_DOCJVQLG0wZrQ9Z7BU_w>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C456015A0092; Sun,  3 Mar 2024 17:58:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-205-g4dbcac4545-fm-20240301.001-g4dbcac45
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3fe38b25-64fe-4b35-9cfb-1ab342e29dca@app.fastmail.com>
In-Reply-To: <xmqqil23uebw.fsf@gitster.g>
References: 
 <d275d1d179b90592ddd7b5da2ae4573b3f7a37b7.1709307442.git.code@khaugsbakk.name>
 <cover.1709491818.git.code@khaugsbakk.name>
 <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name>
 <xmqqil23uebw.fsf@gitster.g>
Date: Sun, 03 Mar 2024 23:58:22 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] branch: advise about ref syntax rules
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024, at 23:42, Junio C Hamano wrote:
>> +	refSyntax::
>> +		Point the user towards the ref syntax documentation if
>> +		they give an invalid ref name.
>
> I noticed a minor phrasing issue, but many other entries talk about
> "shown when ...", even though a handful of them use "if ...".  Do we
> want to make them consistent?

Sure thing. Do you prefer the =E2=80=9Cshown when=E2=80=9D alternative?

--=20
Kristoffer Haugsbakk

