Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1776040
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560124; cv=none; b=u1qUhuc6Ll9He6jH44gy9COHMEFs/z3oO+F7t1uuZkqxvauSlW1baL8W/4eVavV9+maUBUJ8n11oUqvOupeJUySShZNyrGCkqKkFuWnpRxA0VvZjO0u56S1d5ia+I84sWlNh2HgyM7IGSE5jq1zSetuDJ8G/btKSg0FMkvg7EQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560124; c=relaxed/simple;
	bh=BwJTrFXGQT76odM6muQ7FL5OHlwk4+YCgcJDcNuG4r4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=V+Fm89tdUhAQOeYC3ttzf5A/XxU5M8Jt63x17wTGQ1euT6L7BVj93XPIsxOYpJNTEmXQa+g07+wVfqIrhYU9QTiZ5bQ//MokVXZDkV2gdRMmjVjl542QLjQ5VDyolKb7l3Arnw22Rj/1zC6gsMkrlMnlKdmunlbf5aZ/o3czAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ozpFp102; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ozpFp102"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 485EE1D856D;
	Mon, 29 Jan 2024 15:28:41 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=BwJTrFXGQT76odM6muQ7FL5OHlwk4+YCgcJDcNuG4r4=; b=ozpF
	p102HE4IqQsdKsSZcUWoBlvWtakhUrvXBCzntw2yFq+p+oo/yL4aA+77Io9z4LR+
	T9wKY3eXAeG/GgXqRjw9UQzfZPhDCy+3yGRvcAjgMIl6CRfJefd/aMRVx//kBAjA
	e+1VglVe46budWQyhSFce+vPz2lrYIpjDI/aPEU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DDB61D856C;
	Mon, 29 Jan 2024 15:28:41 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EC731D8569;
	Mon, 29 Jan 2024 15:28:40 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/3] Comment style fixes
Date: Mon, 29 Jan 2024 12:28:36 -0800
Message-ID: <20240129202839.2234084-1-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-440-gb50a608ba2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 FD307528-BEE4-11EE-A88F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Among comments in the traditional /* single liner */ ones, our
reviews seem to have missed a few // comments.  While they are not
illegal per-se, they look out of place mixed with the /* ... */
style comments, which is the prevailing style used in this project.

Fix those small number of style violations in our own code; files
with borrowed code that have // comments as the prevalent style are
left untouched.

Junio C Hamano (3):
  builtin/worktree: comment style fixes
  merge-ort.c: comment style fix
  reftable/pq_test: comment style fix

 builtin/worktree.c | 10 +++++-----
 merge-ort.c        |  2 +-
 reftable/pq_test.c |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

--=20
2.43.0-440-gb50a608ba2
