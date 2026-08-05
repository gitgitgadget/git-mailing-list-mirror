Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A10442FBB
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930853; cv=none; b=FAZj6Z2m07iqQPcwSr04kIOaBKMpopFR59WUAjHkCDga+zqLz4DcfeMU8b4sOOFJ/EI6F/QPK5BDvqYx95vZdw0kA29qudOD0whaZsYnywokmopMTnN9LIeW84/2njyep2/FTvHR0vHh18J+06+mTuCHBvILRaq768GI8vp1tcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930853; c=relaxed/simple;
	bh=MPjDbL3e2s0Cws42tnddQjSYe57OVWABpWE9RFHsfDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l+ijtD4AUg58aa/DGEt0oosOUITsubn6/M+KCPDNfJwYXJp+F6jk81yIvUIQJmn4QEJKo5Z3P8QEIM08PkcXIKddo7bXLi2Kw2KyMlFgsNa2g9PQ7XBSHj6KLWI5/BcKvaVLmkUq7p4HJBN3KC5659DMju3mMwKpsb4rjgNtjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=aamf/sNy; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=eS0tsz6O; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="aamf/sNy";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="eS0tsz6O"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=aamf/sNypUEUqV5Ffmkxn+IS0Z0Da2Q211cZzHTsR1bvaL6GHHPIj6OJl+YVmWPTmQCku9xpdAwyX5FgTPe8M8ZwIHIkP6IrjHN7Jix5IiXKInSVUUuojSN2t4fz5SO0ad8T8SWeOH9IUIn7vxOLAhUGNklQLhx17LbYjzUbKpy5q4BBj0T+KMQSBFWEsXrPFu707lbcYYWPFCfxYDEYCbpnqPu2EFReLg6fwnvO9jYpECX4kLKLmGysMZFKpEBQd87pUPL/9VomJYq3xYRWLiUjDzxdIx0dWql1pE2OzIqFSBQOmTrAZ3sJT8Ner7xFFXgUuRa/682oZdKc8fq97Q==; s=purelymail1; d=malon.dev; v=1; bh=MPjDbL3e2s0Cws42tnddQjSYe57OVWABpWE9RFHsfDQ=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=eS0tsz6OPrMHmMhlO8W9jvUOzKdb5rAepZLsI0wBlJxZorK5NDpX0WjRXnnDaohX+ZV7uyE7yU2oJiZ5/o6xjGBrtguxyu5J88kDhH0XUPLF23Hu1Dhom9dWWcvhNiumrJ5GB0uoDX6atPvGtW+da/nKnOepMrVEKLNY3xE1vbYigm6W8nkvUI2+mysIzPlIPNuDY8BWG+PP8VoVRcY7N7HXAhUoPTl4Dwi3P8ZgX9t67vRboDAm7mhNQhu5r+Rl0DoQ8qozmgcL3pKV2WCJxIa9UVwCdd8TbpfQ6twaINjHxQuPy5btQW2RdWoRCkWuNFsJT6c0XhnGwIUEqfH/EA==; s=purelymail1; d=purelymail.com; v=1; bh=MPjDbL3e2s0Cws42tnddQjSYe57OVWABpWE9RFHsfDQ=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1777023232;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 05 Aug 2026 11:54:04 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>
Subject: [PATCH 0/3] environment: clean up repository config handling
Date: Wed,  5 Aug 2026 19:53:38 +0800
Message-ID: <20260805115342.3939931-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hi all,

This series contains several cleanup patches for repository configuration
handling.

No functional changes are intended. The patches make the related code
more consistent and easier to maintain by improving documentation,
formatting, and the organization of repo_config_values.

RFC:

If there are other small cleanups in this area that would be useful to
include, suggestions are welcome.

Regards, yuchen

Tian Yuchen (3):
  environment: simplify repository config getters
  environment: clarify repository config getter documentation
  environment: reorder variables in repo_config_values structure

 environment.c | 49 ++++++++++++++++++++++++++++++-------------------
 environment.h | 31 ++++++++++++++++---------------
 2 files changed, 46 insertions(+), 34 deletions(-)

--=20
2.43.0

