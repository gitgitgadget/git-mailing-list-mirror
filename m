Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C261F81205
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145353; cv=none; b=G9y+00kQaAU/RdiMpSVtZcTwMYFldRTwW93MwDxgKihRFjamcEtCQIQAuwUC3s8QOAVRVwSQw4E+lfSDslf8v+92JZZhJZjjmSAgq9hDDgtxpe+Aj5Sp0cY7zXOT9N3c10nk9erNlHNiaKdBTYJSInW/LqRLtJJCc9riRqzvMSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145353; c=relaxed/simple;
	bh=j+Qx4Dv41keuKyR4CP+/yiH4HuzXBurw2PDS4q341XU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=oPwSL0b7V3Wwu8VKnas6in/M8lopLYR4Aon+bdAAqXjFKyohRAA+8501p5BbHCuu4OmdMnhF3ve0Hmf1gh/N0moRT/TMOJBQVLosof1MAxYwHQMshlQz88Ps0hjAZwpPIVHgelwBloO/L3psV4uPzgA+XCE83j80b8OLhfBlc8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=af6Hejen; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=okIblE1/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="af6Hejen";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="okIblE1/"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CAADD114015E;
	Fri, 22 Mar 2024 18:09:10 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 22 Mar 2024 18:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1711145350; x=
	1711231750; bh=4uASdkszkryAKCSXKHzhSlL3b5xawy0E0Poix+Qe9HQ=; b=a
	f6Hejen+D24NIRN9vyeadkLnK8MYX8mAWW1Na2lk5Nm66YoAWnVkcFRSY8Ry+FBP
	SwkiB7AwEa3/AHFRxCv/kH5aETi0fHPFWL8jM01NYHkFFBpbWjoo+KSrtkxWKV5G
	gJWZ5STw+UyNt2TCCEohdR9SJclNyb2WBb7PeyDFevXecTj2rBGBjYbgA/HR276f
	mQ5/gDLYwiw8xtaV0EJkzrUSH/0WPhI3fbdxJkRQgJFwEUytxVTT8/z/a072bI/1
	/lq52sDtMKCfRBOgdhl1gCV4GnqaNZR6MqT0+2HL8wWax0chfNmPGUiXlbR/MxOk
	zDFDvTkFmBjkQTiZvtShw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711145350; x=1711231750; bh=4uASdkszkryAKCSXKHzhSlL3b5xa
	wy0E0Poix+Qe9HQ=; b=okIblE1/EyyPBVKV7cJ4vyxXqvpJWIN4PTTd2Qip2iSH
	+3zONpd4q5wADWlA86hH+DOvRBOPFsasUeqlOk8fyIlp/DB78VgfByCPBGIHJ3jd
	VN3LN/TmpjNxwy1uKC3o3nvcSN1X5hCqs+tqDalNuMSXuGrC9SWHgMqrWQPRBKSb
	ssS/ZmwlxpxLwx7BYiixZjBGKaX3RLQuxzHMH9STkdpPS9r/Qe1AUjeKc9MOBTIs
	zOuZyiGAdneWtFuKnLDwvCix0pTmOxw1jh3oQHAGPjFSTtWE0Vw4kaa+RYALXfR3
	9ST8Y1hU8a2d07W6jmkZDdZLYK21e3DN+jE5TafkwQ==
X-ME-Sender: <xms:hgH-Za2PkUmzZD2ZS_WOdYNee0BRbncLPKODQlVfEncO2sZFx_TaE0s>
    <xme:hgH-ZdG2gdvier0tySORlmhpBu83uuiYrS_0GTGPoILCLJ-0e666RjkEUt-MjPx8b
    WdAyr2w4eJ_aJrcGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtvddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dtkedtjeeiffelteffheeiheeufffgheelueeftdejkeeufffgiefhgeekffffueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:hgH-ZS71hr6gJrlLal72q6pBLL1mSPo4mv-I1mwJLNxDBS4pnP1dVA>
    <xmx:hgH-Zb0kCY-_NmlNObjUVMBEYyBuUj79qpJGolJ3p1ClQSKjxFqt9g>
    <xmx:hgH-ZdE2Zh4-NIgUn2dvGwYxd7lDw8tP4PxgWBlaJnYFYWTlfiK76g>
    <xmx:hgH-ZU-5Vw44EnqZUlwmba4cshCZ1L3fYI9beQVsC9Bzob3V1WLZVQ>
    <xmx:hgH-ZSTtON8mA0k1pew7VS12iANzoMMqfq8nSVOUWqYGlxjZrpZXPA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8DD7B15A0093; Fri, 22 Mar 2024 18:09:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e9a1da5a-733b-4122-917a-5f5356ea1f7a@app.fastmail.com>
In-Reply-To: <20240320003557.GF904136@coredump.intra.peff.net>
References: <20240320002555.GB903718@coredump.intra.peff.net>
 <20240320003557.GF904136@coredump.intra.peff.net>
Date: Fri, 22 Mar 2024 23:08:49 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] format-patch: simplify after-subject MIME header handling
Content-Type: text/plain

On Wed, Mar 20, 2024, at 01:35, Jeff King wrote:
> In log_write_email_headers(), we append our MIME headers to the set of
> extra headers by creating a new strbuf, adding the existing headers, and
> then adding our new ones.  We had to do it this way when our output
> buffer might point to the constant opt->extra_headers variable.
>
> But since the previous commit, we always make a local copy of that
> variable. Let's turn that into a strbuf, which lets the MIME code simply
> append to it. That simplifies the function and avoids a pointless extra
> copy of the headers.
>
> Signed-off-by: Jeff King <peff@peff.net>

I like how all the previous work makes this change straightforward.

-- 
Kristoffer Haugsbakk

