Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315283932F1
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364799; cv=none; b=dessOFFulr0//IMQzpBs3kBMY6VDNfxEXB0zxFqo28z7Ea1LH6QGLfPEH4U6b7wHbCSpQ5nhJh+/RBszMAEwmfrTECULXy8q+0QWDGPXiCoIgaF8gWOqBETwiMtv0Vb8nNt6w8bO+5rAAcnpNYK6zaolbRrZcXfrLMEQ6n5zpr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364799; c=relaxed/simple;
	bh=4SwJV6KKbBwwrZ4vSPP/XpZGiSkPRaQmlYFTCEFu+is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZaoD07+JUDu+w16kcMzP4z2VKksMRqtLWI7ddax0dm4nWM9PDGaX1i1CTRAftoyV6i/p1gbCV0AV4aFdnhZEOmrXpWy+9wE8vmGie1zgLdfTWzGYU4Du+g92rNhC46NxOk+64x6fE5jpdLPyJMDmpwgStn7Dr66aNFp4gzHwjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=avo2c/vk; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=VtTAOMC/; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="avo2c/vk";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="VtTAOMC/"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=avo2c/vkyJGMnT7rAgv2bsBHXMKEWK6mJP5y0oVtivP/f39IzBAbQv/WUKj0Rl8YQu2LhpRggrCHjwTH1tzjnEUsqG/GuB37WaCemo2wBmJP1gwlK0iu/b+PZyb+MNNjOnAsmZx5CZ1d3vTNXFaRCkLL1A4h1wNPkF7hSLxTE+nBJ5OK0n6VTvwwRuTa+OSqO+cw8sQ5YApKcV7rwYUfyKb9o8rN1NrilbpGdQ7t2yic5zov7iG1fTI+h5Zl9BdjCRc4BInlf0btM7ZgEFe04qle0QAcpFrEhfW13F25hzHSFIClg5f3DS+1KE45zqVR97YzdtFpy5790Ac8tPLsPA==; s=purelymail3; d=malon.dev; v=1; bh=4SwJV6KKbBwwrZ4vSPP/XpZGiSkPRaQmlYFTCEFu+is=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=VtTAOMC/6/qtLpuJhNbmpEQdRo4SLSqML4UWa2L2xCNEpX+cjU9oy70b5KXY+CC6vCvaN0oyRkH4EklN6udTLMXZz007+x0UHV4jr5bw3Q5Orf2LTOyBDIE4j7XwWZ79/+aIO28bJrU/V3BxX0/jg8KfHqitLTQMr9SNYHEOIxNK0LTWfnrRGsdbweXcjcqjotKAfOu02P+QU640xUBvOa6wZ3BDrZEQU4dfjfGXO6MZhGCnSDtR07JWT02EnVSGNh8kEcRDkYzmVQVK0cXtFKtTxJ3YwOhLxNwtJa9d2kyQ+pyEHi3PqoRVJL43HDt/0KUr1hhLc5zuUGSOO0lbuw==; s=purelymail3; d=purelymail.com; v=1; bh=4SwJV6KKbBwwrZ4vSPP/XpZGiSkPRaQmlYFTCEFu+is=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -185209553;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 13 Jun 2026 15:33:08 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 0/1] environment: move protect_hfs and protect_ntfs into repo_config_values
Date: Sat, 13 Jun 2026 23:33:00 +0800
Message-ID: <20260613153302.168801-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610124353.149874-1-cat@malon.dev>
References: <20260610124353.149874-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hi everyone,

This series continues the ongoing libification effort by moving the
global filesystem variables, 'protect_hfs' and 'protect_ntfs', into
'struct repo_config_values'.

Place them within the per-repository configuration structure
aligns with our goal of removing global states.

For reviewers familiar with previous libification efforts, Derrick Stolee
attempted to wrap this kind of filesystem-level variable using a
lazy-loaded global accessor get_int_config_global() [1].

However, as Glen Choo pointed out in his review of that series [2],
it is strongly preferred to use plain fields in a repository-scoped
struct over global lazy-loaders, provided those fields are properly
initialized during the setup process.

By moving these variables into repo_config_values and parsing
them eagerly, we successfully tie the filesystem security flags
to the specific repository instance without altering the timing
of configuration warnings or introducing new global states.

Thanks!

Recent related patch (environment.c: migrate 'trust_executable_bit' into 'r=
epo_config_values'): [3]

Changes since V2:

 1. s/environment.c/environment

 2. Updated the link for "Recent related patch"


[1] https://lore.kernel.org/git/a42dd9397d07b2dc4a0d7e75bfe1af2e46cad262.16=
85716420.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/kl6lbkhpzujf.fsf@chooglen-macbookpro.roam.c=
orp.google.com/
[3] https://lore.kernel.org/git/20260612160527.167203-1-cat@malon.dev/

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>

Tian Yuchen (1):
  environment: move 'protect_hfs' and 'protect_ntfs' into
    'repo_config_values'

 compat/mingw.c             |  2 +-
 environment.c              | 22 ++++++++++++++++++----
 environment.h              | 12 ++++++++++--
 read-cache.c               |  7 ++++---
 t/helper/test-path-utils.c | 24 +++++++++++++++---------
 5 files changed, 48 insertions(+), 19 deletions(-)

--=20
2.43.0

