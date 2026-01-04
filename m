Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA62D6E5A
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767549865; cv=none; b=jIY10K8Hn4KbqPt6o7aSF00GH+wRL2Vrzr3FPRli1l6cJ23FQjXXphMAI0H7fqBCBWzQ8nBPg37CBuyh9pNalT2NCvNVYnSuv6+RPvP1P7WE32MC/Yre8DVRGkA4AYDhCygVoue+ahzI6+YZ8++/GToRHf5XqpPW0akC7SC+9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767549865; c=relaxed/simple;
	bh=BW0w0goeK+t4RWcZVme6wgWwVhdIq60oLKSvXfhcriM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rmsdJEDwjxFeNjBm8pqDk/LaNvcc0eWxmH+Fs90JDf0Uw+3VxwBDyPMikpovNZOWSkRW2lVp3/8LCaRlJZHAr/H3zsDGiJ/pd1lnyCyDNQBLF0b4QTUddp1s6jFQwxlgp1rV3OJrlhyLxvW+18zPGwOiBgoZUr/+kVpDt2LUutY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=michael.lyo.nz; spf=pass smtp.mailfrom=michael.lyo.nz; dkim=pass (2048-bit key) header.d=michael.lyo.nz header.i=@michael.lyo.nz header.b=xadWKTQl; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=michael.lyo.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michael.lyo.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michael.lyo.nz header.i=@michael.lyo.nz header.b="xadWKTQl"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dklgJ28yDz9tHV
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 19:04:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michael.lyo.nz;
	s=MBO0001; t=1767549852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ChA94OxYnkTGoLK+XGbikdb5O/DHjIrY797PHyGZ+Qw=;
	b=xadWKTQlbwGsKTpJShZcUT6YXdxBZ8U+xbH81HaphpYOi5mCg1mYCUpOy0H8XoqJLHHrzh
	H6MU2Nn2VkBME2Bfednz6blis5kUKWjl+XqysP/LcIysTVOwRFOcOu9iZuAVMO5U88hWXI
	hdnRs30n7pbW7Pm2NaIpX6fLDl1KuTShfi/ySWaOU4wBNh7MfMtnPpF7BqrrqnwPj2Vl2Y
	MY49dbKoyujn2G8Bfp+JUG8dG2p2JRQLt072bTTtVUKWfbAEVqzuSwShKPDZFLMzBiFtTZ
	SwtFs9U4hEWOcEh/RfSe+PN9wRZ7vaePS00xcSrobeiP+dVDoe861ccQwM7Cew==
From: Michael Lyons <git@michael.lyo.nz>
To: git@vger.kernel.org
Subject: Documentation options: Code or not?
Date: Sun, 04 Jan 2026 13:04:09 -0500
Message-ID: <2076768.usQuhbGJ8B@debian-mbp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

I noticed that git-scm.com's documentation for `git-am` has a different color 
for the rerere options than it does for the other ones. Those options are 
imported from rerere-options.adoc, which adds code backticks to the keys:

`--rerere-autoupdate`::
`--no-rerere-autoupdate`::
	After the rerere mechanism reuses a recorded resolution...

I started a quick commit to drop the backticks from rerere-options, but then 
sampled a few other doc pages. Some use backticks (git-merge, git-repo), and 
some don't (git-prune, git-name-rev). Is there a preferred style? Would an 
update to make them consistent be useful or just annoying?

Thank you,
Michael


