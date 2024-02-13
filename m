Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032B60890
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856889; cv=none; b=Z1pU9AQ48s6zt6ZnK0xAi+0eadnTwS4/FIzC2j9bt1jF1dPS2H7H5Cwe2H1N/k/K+l7ECFtOXD65WgvqzeUoVsgOqcAW4XLOslX6hPJn6zc9kezXHAbs50J3kF/Y/k49uJPc/f3J/g2GD1yZtbBXPJL86Me9hq+1ghZApRgi6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856889; c=relaxed/simple;
	bh=mD1Yi5DLpTkp6zne1umbLfVcjLngllhv6F8Ab85IcV8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ndjc67SfaCHMQ+Knmp2+zzmOlSMyw/5xt+DFS4jYLoTDEbV5DdCP4W/Ie2Nla/uv6V15XKjMifNuyKX3bW9A6aYK9m3Oh8TixwWbv1vPEi28RYKyYuR4sY3ckqhki0kUquV6TGsa77WBewHqVdq/5vsc94VBGG11k/ux2skuN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=O/fVqg9u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i0zlcFqF; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="O/fVqg9u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i0zlcFqF"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 7E3D21C00070;
	Tue, 13 Feb 2024 15:41:26 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 13 Feb 2024 15:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707856886; x=
	1707943286; bh=x2Tpq86HUYZQyNql+F2U2ZuElLMBvb4EzxrbiFSipUo=; b=O
	/fVqg9uX9HKQ4biY4PqCB6aRwGdbLEa3UwuxTVqWZX9rXpjX0RN7PNJ+ZKWR6NfO
	FDcutcXN/13AXLsfVTUQfT+B+h1SKzHtGuxd2suvGfJZrFKO5TkhnHAU5zwPtVXJ
	eRXYRSHuWVupwAsufllNuZ6aiuox5UqFCMI9VcD4G4vtQU722RKb3hytWD6ErTJ6
	PMC70QFKbLHNY62yi7TNx3NYj2b+UOqNaOLJPAQm06jGm8ljg1w9hzi6LIxH4vXA
	j5NKEUCa8yjFb6Zpk5OgR2oGG42mqPDvyaE0OTwqdHJ6UDOVVVFuQHj1R1NQQ1b2
	LWvla4cU1RSLne5nZjvTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707856886; x=1707943286; bh=x2Tpq86HUYZQyNql+F2U2ZuElLMB
	vb4EzxrbiFSipUo=; b=i0zlcFqF+TqT4KBDGvZCwIXQGrYS6zXxtHW4EIibAL55
	6Ez5T95kbGPjmmDQBUw0SmzR7W8V4BE4UtOGhi7alI+xS/glsA8MpG5uM5zG0eD8
	Fdr9CCIxzpjSsVJpzyNxQTk3sJbWqs6O/Zz61hO75sF22Z7+ehXkyY22OhAR5KQA
	O9lP46jEmzzUYiCzt+tmT27v17iyZ4T4lBb3EZJd6LXo+5bmjnJqOY7liQG+0sHQ
	wiundyy2JG2B8zOFEbDE+pp8Diq0SzVXX4/upZ34S7VX6fYahQ7XItHSl2dv02PK
	jRTyBSrtP9WRq/eCs0Yqe1Rbnn4QzZkKfBTMwe3v0w==
X-ME-Sender: <xms:9dPLZVQIDN6ZqVgnZoBt8Drjp0YVNsK9v3FbipPgOyogOAOVXndmf6I>
    <xme:9dPLZewfAShuddKl8HxsHQD1IAd4bcN1V9RoeUMSISlYkaSVHfN4xobY9zTAv-i-u
    mCFOXPEQQjf7xG7Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:9dPLZa33GBhcopxgQ2z7ynQgolY61yPdpyPvalyv0hp4iwaTg-m4ag>
    <xmx:9dPLZdBOhk-GUEOi1n_vDUfX-s_FWiWcWW5kwPUMXZSTXpmxbpN74Q>
    <xmx:9dPLZegyAstPzEn70PfJDyJeIWap_25dWUe4_IJXk2ZPPXS2d0ZKiw>
    <xmx:9tPLZSh94hNHARfrKYBRT1YdpZz-egavNFdmAS0QbItDhAcrxyulBJB34j0>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AE3A415A0094; Tue, 13 Feb 2024 15:41:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <10c1ae18-b39e-4210-b488-cc125861412e@app.fastmail.com>
In-Reply-To: 
 <ba1f387747b08a7270f7387beddd75dc4a8eddfe.1707196348.git.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
 <ba1f387747b08a7270f7387beddd75dc4a8eddfe.1707196348.git.gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 21:41:01 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Josh Soref" <gitgitgadget@gmail.com>
Cc: "Christian Couder" <chriscool@tuxfamily.org>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Emily Shaffer" <nasamuffin@google.com>,
 "Josh Steadmon" <steadmon@google.com>, rsbecker <rsbecker@nexbridge.com>,
 "Linus Arver" <linusa@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 15/28] format_trailer_info(): avoid double-printing the
 separator
Content-Type: text/plain

On Tue, Feb 6, 2024, at 06:12, Linus Arver via GitGitGadget wrote:
> From: Linus Arver <linusa@google.com>
>
> Do not hardcode the printing of ": " as the separator and space (which
> can result in double-printing these characters); instead only
> print the separator and space if we cannot find any recognized separator
> somewhere in the key (yes, keys may have a trailing separator in it ---
> we will eventually fix this design but not now). Do so by copying the
> code out of print_tok_val(), and deleting the same function.
>
> The test suite passes again with this change.
>
> Signed-off-by: Linus Arver <linusa@google.com>

Nice find and a great commit message!

-- 
Kristoffer Haugsbakk

