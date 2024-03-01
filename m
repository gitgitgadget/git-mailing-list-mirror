Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F060107A6
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316838; cv=none; b=QlZNK102EKbHzfGekKC4DyThbowfGEGxnqwSVVKdr3pds9+9789ZwRUadipO4anCHo+qa/LK8y2gWdJgSx/de7+84LPj/rGVD/dvmW5lhVkVoZrkAifcnrXrIKvp2EBzp99G45EmSyjxYbtOC535TtSm3M8DNHqo0Ijl6NyZcEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316838; c=relaxed/simple;
	bh=YW8AJEWPFDu7jbGRTNk3vET/OqR03dIFG+dELaoF+GU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=My6I7ceUpktok5+R+xRlqLiF7Uf9Jg6zrhCxSI7rraN2PKj7F3XRdn3uTPk2cvWpGoIYwyX8Ok0jXXh5w8DFfSPnRUCAfmqsuJLRAfHLvJvTXMTChu1PURCSHxkzqQsiiAFjR1PcBojpaP25q10ST5WjHmXEiRTnchNeVoKYsbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=csdYdnzP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RiboKSfG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="csdYdnzP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RiboKSfG"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 71A2111400FE;
	Fri,  1 Mar 2024 13:13:55 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 01 Mar 2024 13:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709316835; x=1709403235; bh=xr/EwvGedB8/5yFNPi5NCyiGxNJ26joj
	wDqDKGTUrqw=; b=csdYdnzPRWmHBGjXMd2RaMDN+gJWMo55MoxZajn8oZTlXYjm
	f1EFgMm38en7GKdr3QdYt2bugE46gc9so6NgHAlQlZKF/TJDq6pGF0L57XOz1lbC
	25FYMqA8z4qpfBpX6Fi1SJ46yXBN7e5vzLYHW5eSQLfA2YtiXm8dQ4cF4dlPa7Gp
	ReJ8FX4zp6JvrPWc0CG355VlR5oEbDQ0I0XaKYXoYAsiUMNji0dVS6XtDRUFOh6S
	AEOT5AC9OoRmoJSIhq29Ub7O8sbOEK7c8lNMBMhB/3VdzNSR5YQGfGeshKILr3dc
	wCqR8F/CmpO/ZV3Vi331jcRkeRYDz6MMF4ImPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709316835; x=
	1709403235; bh=xr/EwvGedB8/5yFNPi5NCyiGxNJ26jojwDqDKGTUrqw=; b=R
	iboKSfGKktAxcL9Q/JSOVGmfOvLwnSR39VJB+ZIsRv8NrUlZtbn1Z7embrX2XGfG
	liD9y7klfyakotBtGkqmCC+RsI53IUEgm1RFkC3YFOo/qNTuQ1nQqtue2B01/P6c
	4tUwuLmfMvkVKB4MTMR8BoIWhbCJkg/TjbqFXDhsDznElJIK5ul7B/TkuIc0X5bX
	I5GE/zs2hiOptKu1UijM+xYq26We4PW1ujd/i5wMmLLBDn9t/1EnZYf1/6qS9iYe
	t9tC3oAV6WWr6S/w5kEfG9RbSgKDjCvb7QWFDXzBzYrLq6OJLi1Et/Jlz36eQbFT
	MiBxK9T/SXtsCdzzmwVyg==
X-ME-Sender: <xms:4xriZeAAbmPKU2aeW1O4oUMrq2FNAj1WpFLPubXmvDer1cZao5o2UFY>
    <xme:4xriZYi7FYFyu4vefjYIvHZwc0TWgmbvZ1LAnCH9scLqGr0C78noF2EfjuknBFBui
    Hf6jMrSIyLX7aLBGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrhedugddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    epvdevheeiudefheffvdetueevkeehhfeliefgkedtieefudetueehueeftefffedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:4xriZRlhfUWWNm0oI8f4sot94KLI9oOFWiSdhxhVKsIHi_SvY_L55w>
    <xmx:4xriZcw5jrFVInTUZ1EoFLWe6ZVOIpyROGb2pee9Lp09B0QoHgZtGA>
    <xmx:4xriZTSoz81_dukJomP8Gfd1IWmgEvs_kDe13P5NY4Y28RKO-SZq3A>
    <xmx:4xriZaIyDmPMkjrHEBne97uvxrrOxFBKuWNCCg9VLloypn2uvqzajg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2CF0D15A0092; Fri,  1 Mar 2024 13:13:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-205-g4dbcac4545-fm-20240301.001-g4dbcac45
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1ba698b2-a0da-4d62-8174-0ee6d6cd9bbc@app.fastmail.com>
In-Reply-To: <xmqq1q8t7roc.fsf@gitster.g>
References: 
 <d275d1d179b90592ddd7b5da2ae4573b3f7a37b7.1709307442.git.code@khaugsbakk.name>
 <xmqq1q8t7roc.fsf@gitster.g>
Date: Fri, 01 Mar 2024 19:13:33 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] branch: advise about ref syntax rules
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

> This will give the message with "hint:" prefix, which is a good
> starting point.
>
> The message is given unconditionally, without any way to turn it
> off.  For those who ...
>
>> git-branch(1) will error out if you give it a bad ref name. But the u=
ser
>> might not understand why or what part of the name is illegal.
>
> ... do not understand why, it is helpful, but once they learned, it
> is one extra line of unwanted text.  If you want to give it a way to
> squelch, see the comment before where enum advice_type is declared
> in advice.h header file.

I thought of doing that, but I reckoned that people who have a good
intuition for the ref syntax would not get this error enough to want to
turn if off.

I=E2=80=99ll add a squelch option in the next version.

Cheers

--=20
Kristoffer Haugsbakk
