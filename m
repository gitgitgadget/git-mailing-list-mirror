Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7BF621
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 00:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732494315; cv=none; b=E1omOPGnkLUXnDBd8KWRFjKb8hUs1PdSjhYMULN4r8lkiy1OkplyyL4jAws63bzQU3rvCTdabm/39ow6wqczWuEeWqI4WBViC/1WXRxxFu6TVquOi0HoyH6QH8ly9BwyCWYvXg/YS3sVx7ricHdTEfwAqM/Y4Ssgmp91WoC2O20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732494315; c=relaxed/simple;
	bh=5QyAyHa/w8b/YTM5ElXvywKcjHyq8hemMV6dgNJrCHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nx0nAMPmwOPTIyV7Ft+yRDU/QfwBs2ZgAzs1iwPLEgaTjBSTPoQ7DQa225i3pvmX5euN8UnuGtEyqLVrMjxav99WhAgQ/yMvh/b9r8BVK5AJzRaiVrFa0R4+1XuKv291DOFm9pczIDqHcezNAJjfzZexPv6yUOwGxUWqU+QGXVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ycF+OFIt; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ycF+OFIt"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 87C021140155;
	Sun, 24 Nov 2024 19:25:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 24 Nov 2024 19:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732494312; x=1732580712; bh=5QyAyHa/w8b/YTM5ElXvywKcjHyq8hemMV6
	dgNJrCHE=; b=ycF+OFIt0G3vi//eB2gpYuGJ2s2ijDSqF79gkeUhvL03Wj0OsI7
	POahYpgjb0q/HI2FO0ORP3cMgNqEReaH7dDsJMg3qqJ2owdLswnO8xTTWWZSQgtW
	VLvp7V9wXfQT1/9I7hW24s024SUT2T6ivC3UzXTBSdakLklufB13o6KSzRgUsV1l
	3HmLULr5+vkta6JVKAfWqiEZzWig8KgJ7od2q9/HRHXj1rCXSx2gqsVZzEzoc0Vr
	T+TjDLy691VWmR3dCKeB061kvc2T/eVz9qFht2Xk9lHlpoLkwDGBN+sqigS1O4m2
	6YdOF0kik1WsnFWnQB+pVUHMnDiJIFhezwA==
X-ME-Sender: <xms:6MNDZxBKv3A4mziPNIpwcEJMXK31BzcmQ_Kjmi9jmutLzEUjxbISfA>
    <xme:6MNDZ_gEs0wmRBbXkX0f0R0ztWdsVSxk4WnGCtZkShjgtB-fU8tAxjR5WBEiy-q9y
    LyDdf2nDUzqIOilIg>
X-ME-Received: <xmr:6MNDZ8lFsBqdCUef7dn3hswe_fr0S2chnuoARQaiE1t89javmYmDU12Dyu_i4F0aoP6EEyeBifYPgFahxAFsArRrEr9snXRvusoZZag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtugifhhhithgvfeesph
    hmrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6MNDZ7y476PwbtIBuEoCTmgGq4ApSxNHFCRbr6TnQUt63qBIF0redw>
    <xmx:6MNDZ2RUnr4fYIM2D-O7WZTmQ6hev0QLyUPo4lW49BOOyUbIOub2Sw>
    <xmx:6MNDZ-ZiUm6MQM3urKtfBrjFNBlcbTdvJl8t7jqIo96Bbj_gl_OYvw>
    <xmx:6MNDZ3RRlBCNch2zEmdXCSlS7PxXs9IxaRL0xrAetuoNc7RgyAKsog>
    <xmx:6MNDZ8Maa2iVgVUyqjziYgM3d0DW50rgv9ComQ5HKjCrC19Xlvo3ImFa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 19:25:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2024, #08; Fri, 22)
In-Reply-To: <D5SS3P7WQG4F.1I20Z59IDQMD1@pm.me> (Caleb White's message of
	"Fri, 22 Nov 2024 14:31:45 +0000")
References: <D5SS3P7WQG4F.1I20Z59IDQMD1@pm.me>
Date: Mon, 25 Nov 2024 09:25:10 +0900
Message-ID: <xmqqv7wc88ih.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb White <cdwhite3@pm.me> writes:

> This latest round has been reviewed by Philip (cc'd) and I've addressed
> his comments (mainly in regards to using test functions I was unaware
> of). I was waiting for more comments before rerolling but if I don't
> hear anything in the next few days I'll go ahead and do that.

Thanks.
