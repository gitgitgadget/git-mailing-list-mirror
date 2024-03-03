Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE66CDC0
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493069; cv=none; b=auWwfIHXPP/FychGY049FE3GNGUwWzJpP/pWmW0X04p2ciG9Ce7fKpOREHgW4dVMZ6awWkt8FFwbYMNYocVvAfRbcMEhHj7SwuaW18sCMKNGUG2MnxoGsTpHz57aHzwuebI9TsmerOhvzGZAoCKZ3xnr49bcqgAmCBTJsv9bPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493069; c=relaxed/simple;
	bh=3GrBTt7CzojpGBtuwcWmynTjU6e54TmqR69MhDjj4d0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=ooH+yypY0WFl96O29ko9dEc+S8I5VGWOpSAXsV+ZN/t9Xxq1REmiwXywiqbyglm332j7dkANyPd6QcpESJ4f9RSPh46EB4GwFd7BG7gYFDWmtwL0Kai30jBDEEezweliB15Wa7zB4FDQPp1gdLhVVYWqczmHl6UypQu0XTIbr/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=eg1M6VJy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DyZBDhUI; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="eg1M6VJy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DyZBDhUI"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 95A5511400E4
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 14:11:05 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sun, 03 Mar 2024 14:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709493065;
	 x=1709579465; bh=3GrBTt7CzojpGBtuwcWmynTjU6e54TmqR69MhDjj4d0=; b=
	eg1M6VJyWklxRN7eiLLLBiicLIEmN8qBvqo5l9LLMlBittC8g/X4611vOM0wETId
	bNeAbj6fSEUOmkOGrBMScs1x0lCe3NWGjz2a1RadtGfKMChJ3Mfztz7yf9kLbQ6u
	vnUqMx1XXXM/w7fQItJYkPO0dokDol/5wkB7uq2iZ2pw215LO/qcpuMqc+J8y3+i
	wNe5X5ba9putSHnzYZiXCq/aPWroUrrWzub2DKT/zC4rXvZsQRm3QLZ9HiFxSI+C
	duwReQeZFRLSO30Mp5Wbtcgkq5sY6MsWUdzgjPInWxabIkePn40Gc8tMYMNB0yVF
	9/nUx1UMdsf85swNkmt7RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709493065; x=
	1709579465; bh=3GrBTt7CzojpGBtuwcWmynTjU6e54TmqR69MhDjj4d0=; b=D
	yZBDhUIK/8j/xOP2FTn/9IZKyOgQ1LFW7QoTKX3ia3I5R3/jfVU7hoLJemumYILr
	T1VeHHw1NW0tlC+3jUEiLvbTpFzpwZecV8DHabpfJ6+WoXq0Tug4Q7un4iwh33v4
	/daJVlryhF0sZ/VG/UoJ7q+Ek6aaTwL0lPO1iH8rYCzV6fHZz9jWUjFhtepDMTOX
	gk4dwPWPxEE0nMsgfzqOaRjJ6dOMThLA3Uxb1FXTaiX4xHHwNYg2n2Zp4Q5J3l8Z
	+k8FqJ0mRwkTWodXYWlFqAPHsLDXvXEuHu0KzUDoerduRImgln+qcdEjjAnw8xfP
	zMWmhrJ73a7/lwsPlMZVg==
X-ME-Sender: <xms:ScvkZYqwHTW2SGxS24lroHF1VYy-SX08F67lEHPC98H06ctYKP-ZekY>
    <xme:ScvkZepCbv0vIt42jc_s-yV06Fqghu6biomJgvtj9kRoevIzDuq8nlTDUm4uLztKM
    FJSOqjLs0qO-RlrjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheehgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dujefhheevjeefvddvueefleetgefhgfevjeeuledtudeihfefgefguddvtdduudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:ScvkZdMRKYsDnLjFNd6JDS0IQ-B8VVHcy-JU9YQoi66JIsO6jwDB8w>
    <xmx:ScvkZf6U59Nx9R2lAxjVUrUpkkqCvKb_2qp-cPJUOfW6S-4se26QZg>
    <xmx:ScvkZX5o4iNkoPkkRDzmK0ppqvG85-sWK9CilfIzcJyyODuzCqrVQQ>
    <xmx:ScvkZUh2KTuwIvFcNDq0H0vaDdBsvC30_jzbxbc7DbWgA7UwlOT27A>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 55DF815A0092; Sun,  3 Mar 2024 14:11:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-205-g4dbcac4545-fm-20240301.001-g4dbcac45
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <038da75b-9732-4128-b92a-25f642393b28@app.fastmail.com>
In-Reply-To: <cover.1709491818.git.code@khaugsbakk.name>
References: 
 <d275d1d179b90592ddd7b5da2ae4573b3f7a37b7.1709307442.git.code@khaugsbakk.name>
 <cover.1709491818.git.code@khaugsbakk.name>
Date: Sun, 03 Mar 2024 20:10:44 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: git@vger.kernel.org
Subject: Re: [PATCH v2 0/1] advise about ref syntax rules
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

I forgot the range-diff. But turns out it=E2=80=99s empty.

--=20
Kristoffer Haugsbakk
