Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6443CBE74
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874247; cv=none; b=I72byH2h0IBS/EVYilqWnLpPWm3liNmvWWoOrRo8lBIaPl5I5EI093BzMReKUgap/LsSz3L7Q05o/t/i9wSpq/0/SlwYsBjpNingSyTNzeLreHy/kHK82+5VuxF2Iyglia+OZKkQ5ZNuPrlC/mhtamgN21ZJhejZ1C2SKjMEKGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874247; c=relaxed/simple;
	bh=l7CjFE3jNdgfW9hHADSlnXXRd/t1FX6MloX5qaUm4TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iA23/JxubOVcLCzIrAHRy9t0QPTTSUtX/SUFrsX8sZD0E5/yayn4WpDojJNwT+NHYrG1/l6kUt0y91Y6nohWGzpPCVqzW0olkt7V0wGwjJ43fyUxXiBeSe3BcMaQF85PVcfZPSqFnFPyFVeKfWo55qu1A+mWsZKH2QiWLYF85xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hWJ4q39PbzMlFR;
	Fri, 28 Aug 2026 01:43:55 +0200 (CEST)
From: Wesley Schwengle <wesleys@opperschaap.net>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Subject: [PATCH v2 0/2] git-svn: don't print v1-layout migration noise when there's nothing to migrate
Date: Thu, 27 Aug 2026 19:43:43 -0400
Message-ID: <20260827234345.1037130-1-wesleys@opperschaap.net>
In-Reply-To: <xmqqy0dr8npo.fsf@gitster.g>
References: <xmqqy0dr8npo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry, I missed the space when I reworked the patch a bit before sending it.
Here is the new patch set for the change.

Wesley Schwengle (2):
  git-svn: don't print v1-layout migration noise when there's nothing to
    migrate
  Makefile: add NO_GIT_SVN knob to skip building/installing git-svn

 Makefile                   |  8 ++++++++
 perl/Git/SVN/Migration.pm  | 16 ++++++++++------
 t/t9107-git-svn-migrate.sh |  7 +++++++
 3 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.55.0.975.g5fa7c85aff

