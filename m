Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22708060A
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901393; cv=none; b=RAuvQPUZU54zXjaDvrNNZ/yUahtm3qmgqobtvw8XuDawWV98YONrSSjS5v15FiGsy/edJGZwKmEDYyND/qPVXEPgExBNsYl6i+K7+egD9K/txJLVTN95gDBcvmzwLFlWmsINhM8fQFA0YMyQOr9o+hVglEo/AiyVkBubFpRvk3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901393; c=relaxed/simple;
	bh=dd0+jBcE5beHPqjNFGtOCWwlf9RcJZmUpLuvp6Nyrqs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=l2ItHU50nIcc3RYPotOFP8MLIoOcgvds5d8uk9i23e4xbhKFdGg/ikICutOiY7fTuddq0ABtrEZgNdXftGEZpf81FX8FHJAMlDyhxpcFxe01b6zn92xeazTdGP9n1bnOxc0A7IUoPWgcWqzLhNKl8kvhxV/Vloq6TZ+ClOJ64IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Pwr5nLL8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VSbQkIri; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Pwr5nLL8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VSbQkIri"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 87D861140084;
	Fri,  2 Feb 2024 14:16:29 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 02 Feb 2024 14:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1706901389; x=
	1706987789; bh=dd0+jBcE5beHPqjNFGtOCWwlf9RcJZmUpLuvp6Nyrqs=; b=P
	wr5nLL85h9kC5pFIAcH1Oy6ZI4glloVeIMjCMNA7xA1Aa2uJtj4CoPIMzdlcRTXO
	73dqvlWp7/UXWvDKQU0Ot8ycsC29l5HeSqDsX0n56nspUQcMDC+gwYhCAVUt7P8l
	0rLLunN+lFzBwBhqdQvSO8my1+ewf37VyQN3yho4/HlR6Le3J4+7a4UYd8r4Um/G
	pM6Lm0FLYeQjJbv3QSSfenJe7PbOAJrAfPbvbNBp7jvIEBbZTmMNdarRXSIL4/AH
	PPzX58UpkrIsBhlY9T82iRujiycXUS10yUZ0KQAkCBiJiaMvQfp/x9wFw2HFT/j/
	zq1WRS8CfIk7fev1OIyiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706901389; x=1706987789; bh=dd0+jBcE5beHPqjNFGtOCWwlf9Rc
	JZmUpLuvp6Nyrqs=; b=VSbQkIribi5Ll8+OvVLPLSblh74nwgIAZbP5WZ8yIM2b
	/OJqoGP1GNJJXByYddOfEmizgOGW3Ugxs38NlbkYey961MQKqLafP9xQndAqYymv
	MtuB1nGGespH5wqH21xqT/0B9a3/N/7bIj9vZ7Ds7VZzJgUfWZ07i4V9FQctg1cv
	XwH1BU0v6qkxxliK47npGacUxzdX5vTB/KJv0lcZqdNc5QLWyxvXXQ5Tms/DGE83
	VbF+L8ZEVzqwFKGWPX03Z+2Buqlc3XrclP2jKtEjn3AhRrBI2mBjM/qA1vGxdra1
	aZ2mZnKrYMfPItVhF09tv6/x1qhTR6iY7apbb2aTHg==
X-ME-Sender: <xms:jT-9ZRSJLQRUjxdmdkHp7fJ2jYHYX87kzdFL-PNCScMVAIelffTTuSk>
    <xme:jT-9Zaxx8a6btD_QkxHD02tHKwQulmUHUXC7lNNtWTr8Gd7fG1Zom6YVP7Z0RZ8w5
    f6TLVo5LN222odq4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefofgggkfgjfhffhffv
    vefutgesthdtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgsh
    gsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrght
    thgvrhhnpeehueehfeeiiefgiedtveehudduteehuddttdekkeejteeljedvfeehtefffe
    ekffenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgohhoghhlvgdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:jT-9ZW1G3lLYhJV3D0bbvth54O4xN2vo-v4bJcSX8TB89HEYnJkztQ>
    <xmx:jT-9ZZBWSbOZ_JEzgg0KXRPU72NCHlyvWXRZxx0m2TOMKiTqsitehA>
    <xmx:jT-9Zaj_AiPS6qyy3AtJZSYiSls5AVNNMWVBi7TqWehy1EcsblEIeQ>
    <xmx:jT-9ZeajXrfX4iAhA1EnR91QcCs5Dd7cF2KN-R4P62sJ45Tpx_2aCA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4289915A0092; Fri,  2 Feb 2024 14:16:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <876d8834-a3e9-4971-bce9-f93a04feaaac@app.fastmail.com>
In-Reply-To: 
 <LV8PR13MB6560538530A2A7D1C1FD89C19C422@LV8PR13MB6560.namprd13.prod.outlook.com>
References: 
 <LV8PR13MB6560538530A2A7D1C1FD89C19C422@LV8PR13MB6560.namprd13.prod.outlook.com>
Date: Fri, 02 Feb 2024 20:16:08 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Christian Castro" <christian.castro@dlhcorp.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Hello question on Git for Windows 2.43.0 - GUID and/or SWID tag for this
 title
Content-Type: text/plain

Hi

On Fri, Feb 2, 2024, at 19:57, Christian Castro wrote:
> Hello Git for Windows,
>
>
> I have a question on the GUID and/or SWID tag for Git for Windows
> 2.43.0.

This is the Git For Windows repository: https://github.com/git-for-windows/git

This is the mailing list: https://groups.google.com/g/git-for-windows

Just saying that they might be more responsive there.
