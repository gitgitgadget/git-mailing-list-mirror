Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA366EB6E
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716693; cv=none; b=RRcBwkisyo5J5nAyCcp9Fi43KwjTHqDkW9P9CrVQnp63HqQx5QVOpzN8Keeq4NjLxwmt438Lr3g2zVq8mmH0xAPIhFXgaNyaNRTu3eqCSYuhUIw+JjHEiX6wT2kXZIl7VsGWossYGzCsUBlTYFIbNfwj0G5+jAQt9tm10B71HZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716693; c=relaxed/simple;
	bh=/fqOLEMyGJRx++wvSF6gasruWUu+I82mB15UWUCx2jc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=mSOOPTbOYoRA/kLRJJq8wL1fIkB5vGdv4eHVaKKP6rmC1NNAaY32eKzuw9enMNpsVrsCI7g2tWxBjSR9oIjyNLH2mC4H6qBX+IdGBB3+SOadF5CkGa64qYL1jbt4R80wVUaFlVs8AiZ2cXEY9xb5eMXcjJyqzIuLabh0cg9/O0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=TVquMHQX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PiJ/OChE; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="TVquMHQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PiJ/OChE"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 341A6114009D;
	Wed, 31 Jan 2024 10:58:10 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 31 Jan 2024 10:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1706716690; x=1706803090; bh=1LzojFxhitbj8cl4xgIp1Hw4uED+2AYu
	qjunQUYE4uE=; b=TVquMHQXfZD3hqEPYhedrioufPMEio4DSLXkzc+G8GthOjXv
	fLxeHZJfpP/EI7GYniEb14WtNxcTNx11ycLkJzRD1o4ZYSuZuIIle/66iONBTfY6
	FMq7jyG15SewSn7J6v+f7xv0fAMpgYDnR+C9W4agZTQXlpqr07vwPWh0njdAgLZB
	wlRDAykh7yB1K+E2D1n6wYrxiw0/9kN3ik3McNxrsxSg6P12dmKQNu8yX+2PEJZ2
	LUSG3q2wRb9KhQIO3Xbnv9Yhi7Cp2U1ft2lIquPzCNKBIfJBpgqBAMzCD/IgxzdZ
	lftj5pb6/QKjeIaMZStL9WlvSAKufnAuJU6IEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706716690; x=
	1706803090; bh=1LzojFxhitbj8cl4xgIp1Hw4uED+2AYuqjunQUYE4uE=; b=P
	iJ/OChEF8AFg1AsUZSSsuaaNeVUlTeVAO+aO1FIbHXnNNDmc5o0btNO97CNkyx6y
	UqIP0WXLd4NJBrT6oYRJOZr1D/z8WlzLAKlJMIYu0yTiX4SP12F4LIpt7RjTltXs
	47/ztsT7o4jGTNQyTS0/o3ODfqOkVOen2FiIUk9AOH40l9CCBBckp7UmVlZEpqPm
	t5ojoV1a2YgA0q6Yk9JWFwQSSyHCaz6PA0AAo17swkw/agwLe43IJc2Ei74NxI19
	/qogQmICHd5YhG2Sj3qrdQbQjxOtl4Ehf5URhK+8SajHs/b6Y2M15VlB5/aO0GP9
	phc++8+SAgtAhuCbaqOjQ==
X-ME-Sender: <xms:EW66ZUIGlLBYR6HkpkYS959QX5Y4xhcfm_IAyEAglqa8jxuCOiBfzv4>
    <xme:EW66ZUISdHVsOwIvv6GVQt1uiLyc_rmR2QD2KP0OUJgri0HThrS9I2CqUJRnvyTDm
    R6jlW7q66GKc85qHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtledgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:Em66ZUtqC1MF3y6oP9hQi5E_7r7dG3-aS773TmeLrBqjxRjeW85MFg>
    <xmx:Em66ZRYQY-l1lvM_hOUC6KGd2KiUDpLme1PJkaCI3WTTQO5Av0NwSg>
    <xmx:Em66ZbZhLYTYGZTJchNN2ibOEbcb5ASI71zwLoZ21K4wf6W8Bw-6WQ>
    <xmx:Em66ZSzIR7W-BxyD2lhDN5ITsLSANuuv6qIgJ9ShdKPdRYOWvPt3jA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E40FD15A0092; Wed, 31 Jan 2024 10:58:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b96f8ce1-f597-447b-b410-e135626e03d0@app.fastmail.com>
In-Reply-To: 
 <b0982baacf74a4501ce5c543b294bc15d6937875.1706263918.git.ps@pks.im>
References: <cover.1706263918.git.ps@pks.im>
 <b0982baacf74a4501ce5c543b294bc15d6937875.1706263918.git.ps@pks.im>
Date: Wed, 31 Jan 2024 16:55:33 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] reftable/writer: simplify writing index records
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

It looks like this isn=E2=80=99t in `next` yet so I=E2=80=99ll leave a c=
omment.

> @@ -405,6 +405,7 @@ static int writer_finish_section(struct reftable_w=
riter *w)
>  		w->index =3D NULL;
>  		w->index_len =3D 0;
>  		w->index_cap =3D 0;
> +

This part and the next quoted one seem to be an unrelated edit by
`clang-format`. They could perhaps be grouped in their own patch.

> -				abort();
> -			}
>  		}
> -		for (i =3D 0; i < idx_len; i++) {
> +
> +		for (i =3D 0; i < idx_len; i++)
>  			strbuf_release(&idx[i].last_key);
> -		}
>  		reftable_free(idx);
>  	}

--=20
Kristoffer Haugsbakk
