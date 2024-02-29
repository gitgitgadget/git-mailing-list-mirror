Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE686275
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219924; cv=none; b=lPTuVkWSVnMqAu4KOvGUmBZvhWXtLf15iSaQPfCp2FL7mwXdbLFuY0suAlFoxKq1yklcHvISCBiRew7Blw1GkiayQw7Is9MImctv9IMLUfQMkAqwAjVYa5vzFwWLWDM/WPSXlndeLRSqfda+fVloJ3S47ZnuAyeOx/lFavIMYxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219924; c=relaxed/simple;
	bh=Qd7Iab1h+RoVgIc2qffklti3QF0+TGWpz+8KSXh+Ars=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=n56U6aUb7pr1IIgfot5nYUhhUKhGJ5gJMXu8UsLEsE0RFeCg3LCuEJqk/FwC2YISJNO/6XPbeuaLtqIKVlIt6N/NnXcBux65IwGjJrvKhrgEV3mc6Rqb9/ymM7sXKuKI/tyi8VTFzfABszOj9Qx9FxuqDhEevWJWnHpwM2qC/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=GXWU1Kev; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nDXHiwoJ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="GXWU1Kev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nDXHiwoJ"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EEF8411400C5;
	Thu, 29 Feb 2024 10:18:40 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 29 Feb 2024 10:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709219920; x=1709306320; bh=Qd7Iab1h+RoVgIc2qffklti3QF0+TGWp
	z+8KSXh+Ars=; b=GXWU1KevIAvbUWKzMpcZKwMMTGT9gi/Jp5dfYKUTy36dDUUY
	OfYPi0uf0sGtlyMSJxt7JjS0vvLkMUWj91KjC2l/xwJFmotWvQROOmca/XVp5mTx
	4tZKsOW+je0/r/czTWwRgHBrgTFchUXx+c/8OOd18mH1FCcKNzqLNBUwFHTB3XxX
	//nI+3Tc8XVSo11D5lJQcUhnsxikxMPeVr9XIOUV9PUSNmEpStm3pPTC9nh7zW+D
	7FoFDQA+2IgAv7ocCqLf5HC0XvT0WNqlhajQ0TWFgmD9YxOpQ3B+1vo+uzETRWJp
	1Eo7ebwrP7YIFAppS/Cuq1PxF0MRoozPszmhLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709219920; x=
	1709306320; bh=Qd7Iab1h+RoVgIc2qffklti3QF0+TGWpz+8KSXh+Ars=; b=n
	DXHiwoJ/OpGjhkvO+T7ZwdmRg6NZto+pJLRboCf5voHLbhQpXjqty1HNhXr3QZKK
	MwL/ZrUp0bUKUCQ7nePS3wDBA7/oV75as1KPjO3tQp90wWJhXwgmwjXa1v8uqRQC
	njS09MH6BPcvwRzeJCIgGCQ0xq2+ELbZrzCqVhW+e6DMiz+yeTz8ty+QNSzTcRcA
	on9OjJMryoxrrNiquz4ibJ7pQWGlMVKNM4cYX459tWKGgg2x0V22GJmim7AbhnzJ
	fVEihfSXFTczvLV5PtQw48enBDudSfLyBiK1dRJ1sJInVJYwaXbJeGMVEDVs7WxB
	2q/4PFICvh9d/LhIlo8VQ==
X-ME-Sender: <xms:UKDgZX3be6KHncYOC5-P5JFQi8WypoVL7vT_AMN_YZ_VGZz4nV7AtOs>
    <xme:UKDgZWHeIHt-SctF96gbLwwkZLORfNj9o8_9-17lHSnEGBNk6DgvHS00ymaZ7iLpE
    XPJlA7fbZ7E95qzpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeelgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepffehgeeulefgfeejgfeijeeutdffudev
    vefgfffffeeiuefggeekhfejgeevfeffnecuffhomhgrihhnpehgihhtqdhstghmrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:UKDgZX4tlgstKgT_jaPssz7YrAoyKbxjqMt31FNj-sGQFKrJNklhsw>
    <xmx:UKDgZc3-21SOd-AO5GJM3OdGJcX21nlGGaAecK7f7PXK0g20okV6sQ>
    <xmx:UKDgZaFv168wiVEYMIKIMPYIR5WIBu3u6V11QWn5Nq99aw_04Pth0g>
    <xmx:UKDgZcM2ldUOGiuO6qpWm6rHKwTx9lL3IPuVdrf4x9P4qpm2BCC2SA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 53BD215A0093; Thu, 29 Feb 2024 10:18:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-182-gaab6630818-fm-20240222.002-gaab66308
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9389c159-ba55-4329-9d86-bc95b321737f@app.fastmail.com>
In-Reply-To: 
 <k4zvycdixqmntkyevdtsrswbfiklyj24mp6jhltnwwdswxromc@q3wtrivkbfbl>
References: <k4zvycdixqmntkyevdtsrswbfiklyj24mp6jhltnwwdswxromc@q3wtrivkbfbl>
Date: Thu, 29 Feb 2024 16:18:20 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Wu Zhenyu" <wuzhenyu@ustc.edu>
Cc: git@vger.kernel.org
Subject: Re: [question] How to customize git revert template
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Feb 29, 2024, at 13:52, Wu Zhenyu wrote:
> In https://git-scm.com/docs/git-revert
>
>> While git creates a basic commit message automatically
>
> How can I customize git revert template? e.g.,
>
> ```sh
> git config revert.template ~/.config/git/template
> ```
>
> TIA!
>
> --
> Best Regards
> Wu Zhenyu

I see no way to customize this message. Your only choices seem to be

1. This default
2. The =E2=80=9Creference=E2=80=9D style using `--reference`

So there doesn=E2=80=99t seem to be a template alternative here.

--=20
Kristoffer Haugsbakk

