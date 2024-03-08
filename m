Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA13C32
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922650; cv=none; b=hGcGCrJvYjsBOot93BORJDKYcsysKl8DIcR966OgsizthGhvCoUF3XyXP0nje6yLqiz0ZcA45zwRK2B6V4di3Lp7YqBctEaAr+ejTEoS7fk6FQwcpyKtpX3ro85i/kqhnV1typXe2X/gJSSPlkmxhTKxtFjxThb7Z7injeYQ9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922650; c=relaxed/simple;
	bh=NUZbcfmfiRXtPIMpXhEKRNhGmIEwOX6IfNRAt+iKQdw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=bNAlvMo/xhXIW9vwUNvmRDvuFcWExBbyG79t3z9teMyD9+HUtFTnQt+2NzaDl+2oePHa7+MoK+IKt8pav7om1PckjQGOQ/Ff9fWrqU1iSqQOUO9HTh8Lzlj0ewZUfMf/h6jzVT485gf9eRCNZ1Jqau0Nfko9fjBFEf5mxu3vWpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=XJR+rjUq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T3MZgutQ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="XJR+rjUq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3MZgutQ"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E60DC11400DB
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 13:30:46 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 08 Mar 2024 13:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709922646; x=1710009046; bh=sssF3s1ooD
	rcv5kqdt0lZmH/R2u/5khBWakKVKxSJ6w=; b=XJR+rjUqvM/t/KlVaWJtbtaQlS
	5sltoJNRySU0oxzyCU5iAP6IpqkQStwUZuRsTnaAV/cXH3mnViwtXEtcgUaQ1voD
	odwYIEzQP8UDsAIZsfUXC5cCNN9L2Q0PF36d3DVsfDte/xAGut8OJbIopBOwHMpR
	IeRVhkmMvx4xPOfPhF9lj7sZOpAVjpLhpUzaEC0VEKtsI/8xBsYaHsfLbthM98dK
	e91w3RHO6hpOxnSheu4tNdn/ojCo9sW1br7pcB7s7QHK34r2rxKyMoSfod8kW3jf
	qL8yVpRZKTBkXnv+bxIZ0APZSgv7X5LBm1uDmMhh9RyNJ6XIZADazkhoDOSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709922646; x=1710009046; bh=sssF3s1ooDrcv5kqdt0lZmH/R2u/
	5khBWakKVKxSJ6w=; b=T3MZgutQIrLvKhPXV2bdGQUHORGoeVKo7E4IPNgxcWGs
	lfAGyWqoSPZ8zYTZccZvY5efgF9o4U+x1KpgwInAlSWsbuizAngzYYj4CgF0sYzk
	Gz9U2BbXS6oGdV0RrYVIk9V7OEhrGwtmLvr559ZO0i7654YNMuGMvQikZGpUINNC
	LIBJHd1w42vXLGLJl9bxonWjW98khEAsTlE4qMzTplfT9/DvPiiNvXNnQ8EdypGe
	NrhEtVBQM08ebhUdgb1D2E97/BjmboEzYmOvtxWgyWL5CcUZKqp5BNPMfuZF2e8w
	OEKGyEl2z+iYS9ffGaOMZwumlkMv6Sl2GM24PwNebw==
X-ME-Sender: <xms:VlnrZeGIROCSlOJ-5vzcnCve45lP3RHaI82WKne-uqA3G9v26BFR-Dw>
    <xme:VlnrZfWJiqWQJZL1ogwtmQkOqvXoZAdGNQrt75oa9Ndt9fmlqjNwj-QQD8liCxvTP
    BnaYnIBGXi4bOh-Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieehgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhephf
    eutdfgleeugfeljeefudeugeetheelleegkefhfeffteegkefgveeiuedtheffnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:VlnrZYIzK49pJSqV_cb4gYezhPhVHfXAQqbpP4F3GsLvhLEx7b4vJQ>
    <xmx:VlnrZYEmZ0JgGOVYtU4gW5q14i7Gt5eATupJXk5AWBQaFNuXNOtfiw>
    <xmx:VlnrZUUPs4tghwE97c4ccI3l3zAk9qwHBw_fNxnbIVxpmcfCy5U0Mg>
    <xmx:VlnrZdd-pqFfvJp2CK4Xrf0-KLLKtyL18nBgLayR05HXyy4jAEQ2Sw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9A9BC15A0096; Fri,  8 Mar 2024 13:30:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <108afd9c-e158-4366-853e-3a384c77a452@app.fastmail.com>
In-Reply-To: 
 <f405a0140b5655bc66a0a7a603517a421d7669cf.1709841147.git.code@khaugsbakk.name>
References: <cover.1709841147.git.code@khaugsbakk.name>
 <f405a0140b5655bc66a0a7a603517a421d7669cf.1709841147.git.code@khaugsbakk.name>
Date: Fri, 08 Mar 2024 19:30:24 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: git@vger.kernel.org
Subject: Re: [PATCH 2/3] format-patch: teach `--header-cmd`
Content-Type: text/plain

On Thu, Mar 7, 2024, at 20:59, Kristoffer Haugsbakk wrote:
> +test_expect_success '--header-cmd with no output works' '
> +	write_script cmd <<-\EOF &&
> +	exit 0
> +	EOF
> +	git format-patch --header-cmd=./cmd --stdout main..side
> +'

This can be simplified to `--header-cmd=true`.
