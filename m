Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA381314D0C
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137406; cv=none; b=g9clhCOyUEBhD500oaTCI+bImH863XXhPsC2S7NUjve0JixU5/3dMyncJ6U9+LIp3UUw4F9Erpy+rSJ7PEMaKqiTEZF71PK62CiJubWq8FI++7INsepDyfuh57A0/jALz+LEiT45wvc+SCxqZukEFTzHTsMzCwNdIjXrqByWbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137406; c=relaxed/simple;
	bh=R3Vy+WYPs0XRXsCjDq66UPo37PTvamDm2T94ho55NKc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P8fokLuRSMzm0dXSLVCYypUFtbL8BMOCibI18jBEc8G1qaHhXXLCfrwQ5CJ1VnDzYrMDJdC6hAQolauwVa0r6QCzhyWrwM/sbyVQARPXYGW3FHB6OWWyxiLbE4z7oqJROtdbTersWkMzQLfDNjFDeayyYN90G6KCnb1Phd/Bkus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=1Efyz2hW; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="1Efyz2hW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764137399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dwe5Z1fVAv3dl/EQDZKrpAT254YtmqmXNE5tN1CQfh4=;
	b=1Efyz2hWVY6kGDv7JkiBp9pJvtiTMco/aESDzliuVOOa1oqlhvKU2tHFOkINcv+a717ojR
	1PzWDpanwQlm5P2BFoj/WwBFnAk9Iv/DEWlYv8xaI7jQ4iH56rsWALxKAHxvavuhZgs4no
	DsEWvRhl8/nBSszmgLadlci0Nrr9STY=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH 0/3] Expand and enhance git-last-modified(1) documentation
Date: Wed, 26 Nov 2025 07:09:42 +0100
Message-Id: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKaZJmkC/x2MQQqAIBAAvxJ7bqENI+or0cF0rYXS0Igo+nvS3
 OYw80DiKJygLx6IfEqS4LNQWYBZtJ8ZxWaHuqobIlJ4hOBx1enALVhxwhbvDGrXGZq4Vc4oyPU
 e2cn1n4fxfT9jnX5PaQAAAA==
X-Change-ID: 20251114-toon-last-modified-zzzz-af9c1be74fc4
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Option `-z` and `--max-depth` are not documented in git-last-modified(1)
while they are pretty crucial. In these patches documentation is added
in the man page and the `-h` output.

---
Toon Claes (3):
      last-modified: handle and document NUL termination
      last-modified: document option --max-depth
      last-modified: better document how depth in handled

 Documentation/git-last-modified.adoc | 71 +++++++++++++++++++++++++++++++++++-
 builtin/last-modified.c              | 23 ++++++++++--
 2 files changed, 90 insertions(+), 4 deletions(-)



---
base-commit: 6ab38b7e9cc7adafc304f3204616a4debd49c6e9
change-id: 20251114-toon-last-modified-zzzz-af9c1be74fc4

