Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4435441C
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 05:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PvmYzkG6"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BD5CC
	for <git@vger.kernel.org>; Sun,  5 Nov 2023 21:34:27 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SP0Qg6vyyz9skX
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 06:34:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1699248859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Z39JBjtJyBeCCiYsMvyDgFhTFYEWQZv17QxsHvJbzY=;
	b=PvmYzkG6rqJb3LH0BYYLMMN2JjE6yWuS63Mfv62CHWAHnRx1wOOnKNZhHkDq+/twq6xC4T
	OTKTVnDRmZfGB0SOCHI6SCXGEri7PQFuadliP8LZyGjFAWzQdTI1n66XH1NmPurPIkkzCk
	wcILPN73muSAqR+KHuGN0mDpYMoONvcoqBZwBEAxD8+B/oAV1E5KkcD6MGPuvf+xfP/t1G
	hYZynPnZa9lG/2k5IsD1Y5WqaElF4VZa/Ogx0qiOCt96UR7MX2T8AiI+3fzgODz0yFCY9K
	etdYf+1hPAc5o8oLRn1kgesxfEo82mPoTQnybeJRh3Z2c/PcSqgLohOJ1K427A==
Date: Mon, 6 Nov 2023 08:34:19 +0300 (TRT)
From: luckyguy@mailbox.org
To: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <133794934.122939.1699248859628@office.mailbox.org>
Subject: An analogue for commit.gpgsign but for verifying signatures on each
 pull
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-META: a7ei49hw5b8rjxa5dqutibmn84xozkqn
X-MBO-RS-ID: 776ff7f48827418445f

Hello. I apologize if this question has been asked before.

Is there anyway I can configure git to *automatically* verify the signature of the HEAD of any branch it pulls and fail if that signature is bad or missing? I'm hoping for something as convenient as `commit.gpgSign` that can be configured globally.

I can, of course, do this "manually" but others may forget or may not be knowledgeable to do this on their own. I would like git to locally enforce this, rather than some upstream server, so that new commits don't accidentally get built on top of bad commits. 

If no such functionality exists in git today, then I humbly ask that this feature be considered. Perhaps `pull.gpgVerify`?

Thank you for your time.
