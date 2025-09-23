Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA127303A2A
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656708; cv=none; b=pskOQNslIRK4iONya97MXy9kp0KEiVMsmgBzL9JmBeaUm7tvZmrZV5MfD0foIFIgf4b9R15qt7tOPGrPoNN94Vc7AGWWZM9Wme44Irxe+gQJ0oZfKLNqgckqC2MtQ+mBVZWOvS2fDcHVd7ENSzG68GF2DRbUCJyKPNUyrR69n+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656708; c=relaxed/simple;
	bh=ohD4CeTfMWHF5sKaRjV4FRtafSQXF9x2kkJKOE5H+ZE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jyCHWaBVkvS6zXRiIJrUn36EKCVr0seyPcV5GNtgcG0l0QT59ZiaanKfNoHxZMCX7rouNj6MQKdcqASlH/t1BdUGWhzDSNNddVeP6J7gaqxxPp9BXU8rLdznbD9fY5OWw+19tg7/b6Cn/De6HKaptHL9fN79gaVdZOAuBFUqatc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpY/34sc; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpY/34sc"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8eeeeb37cc5so36809739f.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 12:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758656705; x=1759261505; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EFIM+YdLnYD4u8xXVIjIxbeUSc88hO9Var/lt2ardE8=;
        b=jpY/34scxzXa4+gZGXrVbuq6xZcCk3qcV9NRT0zbzLoDN0ITPF469cz9m5qE47sv6z
         JlkE1DktuY5jeRUmCxbK1v/m7/6J2soRrDDiT25/dhJVw10inYE0ZqPk4dDOe0rqrCML
         aHPHMsnGnkAmRR4XQjpSAl7g8NrKRa36sm/NjH8DM/xecL/F7ntSHfB4T5rlfHHfm654
         tHX5K+CRvC3LMB8XxO9syA4qqyxYa+UjG0coLRVN9jzWKGhZ4xyDZZH5CDwqHoE2XvvK
         L01M+wFM+ibEFRiIgaRi4Ve9g0SwyM9aM3qhFpWMpYPQJ2ZMs24TtNd02agFEs4VZTgU
         YveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656705; x=1759261505;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFIM+YdLnYD4u8xXVIjIxbeUSc88hO9Var/lt2ardE8=;
        b=qL/xQszhoY60P5eZvPC6UZKwGuUuRpk5iBLlzGfiPme1gTUzqZdk5pqVFS0nkyJhtw
         cucA2B+b6BK5ieY5MUjUinisWmbkrKbCTHTZFngAz5Xyv4T8gvok0Iaib4KqjsoWwe8H
         DY3x/mJTZlxdEUBkTuwnDib95k1ajZ9m+86QnFzuZiw9h94r+kbAl4eYzzB0g9S1JsJd
         HcpDML34f/PfnSLeUoUINlgf7/XbawibuxKZ8ocTSZPV9wMqfzVQdT8gzZu8blrx2j+9
         e/R6cEW8PNWSVCcSjNySBvmuSdKXcpilAa8BTVVmTaon3iNYIpnFzHYEgZ9QKpESVcrR
         0Mpw==
X-Gm-Message-State: AOJu0YxNMgLb13BEaKJfErOCfzPo96z9Axy7kytwfDUS7VXuZZOoWSG8
	Bf7fVLCLPTMzJw7e4Em7t6OhEIEzAb9O3pTUApw//Law2f4eASv6P/p8gQ2Z6A==
X-Gm-Gg: ASbGnct2HCvdwhyQEnzGUm8DtbbiIvAWod1EH+OJSIXzQETsi40Lb6Pvpy9cQ3eEVZH
	yNnUaPQD/UGp2+W3TsUCMy/Gj+j+hwBZx0TXWW3qa0JVZHE0Mx8SXaAxHdUyknwtEfGnxOHAORu
	x7jEdK3VQSMnVXMrVdn9R91bfVfYDJQ4epXB+sTxL1tuH2razv31pZyKHSbBPvTliG+GdMDQnrL
	KMc+S6ElBohrpEjEu3gwc/4GrPNjLurE3S00U8CkV8s0rz26lOcpJMDVE+vU/9rUMaaMV8VSHUo
	g+f6t5PDgCygiN/4sOLOS25fKC6FG8BzaWW9HJFW1PCmcpaTam+gZ53uy9bTngq70KVcYkxjQz9
	zC9gtwuIWML0m739iQtTn0LbFvA==
X-Google-Smtp-Source: AGHT+IFrnpoAGoByfV9APBZvo5HuOj3ngjQpbOh2spLyC6WOESymQuu7dJsAO3Vp8QPGFD5CYpMmKw==
X-Received: by 2002:a05:6602:6b83:b0:887:5303:b3f9 with SMTP id ca18e2360f4ac-8e1d1a13f4dmr647018939f.10.1758656705403;
        Tue, 23 Sep 2025 12:45:05 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.130.210])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8db17087bfdsm144171139f.8.2025.09.23.12.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:45:04 -0700 (PDT)
Message-Id: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 19:44:58 +0000
Subject: [PATCH 0/4] doc: git-pull: clarify DESCRIPTION section
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>

I got feedback from 15 Git users on the current git pull man page, using
this tool: https://text-feedback.wizardzines.com/git-pull.

My goals here are to be clear about the relationship between git pull and
fetch/merge/rebase etc, make sure users know the current default for git
pull (--ff-only) since some folks still remember the old default, and to
help users quickly figure out what command they need to run to
merge/rebase/squash/etc.

I've taken a pretty aggressive approach because I think it's possible to
have a pretty short and focused DESCRIPTION section here while keeping the
most important info. Open to hearing that I've removed too much.

This references the UPSTREAM BRANCHES section from
https://lore.kernel.org/git/0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com/
, so if that isn't merged I'll need to revisit the approach here.

Julia Evans (4):
  doc: git-pull: move <repository> and <refspec> params
  doc: git-pull: clarify options for integrating remote branch
  doc: git-pull: delete the example
  doc: git-pull: clarify how to exit a conflicted merge

 Documentation/git-pull.adoc | 86 ++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 54 deletions(-)


base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1976%2Fjvns%2Fclarify-pull-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1976/jvns/clarify-pull-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1976
-- 
gitgitgadget
