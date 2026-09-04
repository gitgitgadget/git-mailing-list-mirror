Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBFB3AAF54
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788554159; cv=none; b=Nqbbj1WlRsgnb4ATbX8GJTyPj7jRHt59+SvdC7BdT9v7KH30zpP9ASOQ1y3Bma9pQdgApXJPdB/TclABwcLwaXDnSctWm6W3vNr8RHuA4gq5YSkim2NE+MJ2nYYs3Y2Ly7owwwAifx7xEq6lnhL6po5522E58SP6QtfL3LHkA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788554159; c=relaxed/simple;
	bh=G1J9z1l3cMiNxee29mdtRcU82QSFZ4+kwd3igm9S4C8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h2vdsBckkNEJOhnnsn8qjqCgsN1xlwHq9QD+mqNx+N/GNINCD7abLaY7FhS+i4hpj3oLyuntljhUfLatd6QkU8+biaa93MV2ZIELa+8G2OkSeQtsAaaY1KNCWp6V+JwUMqlTLm4saKX0xeHJfBD1Emd4wzk9YGCXQ2AdfveqKJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krUT7k3f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krUT7k3f"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B17DC2BCC7;
	Fri,  4 Sep 2026 20:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788554158;
	bh=G1J9z1l3cMiNxee29mdtRcU82QSFZ4+kwd3igm9S4C8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=krUT7k3f3Y/q4aTJrR5U2ya1gpZZLshCyPn0cnUs0EXKxqu40DrNJ7sGW0TRvtb/p
	 X6L+z/D+iZsz3EXW1iLFb0v/uINNQSRd47R89CG7or48lfiA2U6h7GY2vq2v5jYD5/
	 gFF6eiRtHF+bJOoLWN3kk6FTKop6UWfxAV37vfhpEojx3kNh4xAFOEpyGoM9ggZEyD
	 FpSKmFGmIOlZ/as3UZFr0dOsE80KTZqw+iDWAHibFGiit8JcL5SChHjGWS+URhMA95
	 NsIFhxlNeZWnnOwStGW14TgTchenqB+2hmbXGNJJSAvU/UPzotWtHjkeGtGUx+4m7T
	 FVdRkvRHojEOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ED2C624DE;
	Fri,  4 Sep 2026 20:35:58 +0000 (UTC)
From: "Mark C. Chu-Carroll via B4 Relay" <devnull+markchucarroll.fastmail.com@kernel.org>
Subject: [PATCH 0/2] Update tests to use semantic functions
Date: Fri, 04 Sep 2026 16:35:51 -0400
Message-Id: <20260904-file-tests-use-shell-functions-v1-0-b66f9cb4adbe@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQrCMBCE4Vcpe3YhliagryIeNJm0KyFKNhGh9
 N2N9vgd5p+VFEWgdB5WKniLyjN3HA8D+eWWZ7CEbhrN6MzJTBwlgSu0KjcF64KUOLbsa18qwwT
 n7WSDdZ565FUQ5fM/uFx3a7s/4OuvStv2BXMXTYyCAAAA
X-Change-ID: 20260904-file-tests-use-shell-functions-e0d6c545d56c
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3800;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=G1J9z1l3cMiNxee29mdtRcU82QSFZ4+kwd3igm9S4C8=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLJma6+pUFtxtYkhoMx2LUN7woyUeWrNylL9s8X6UjoNm
 fi+1ER3lLIwiHExyIopsvz/J9D4iuWBhF/Qu08wc1iZQIYwcHEKwETOrmD4H7ah7OJMjrBXFyqy
 Ez7suPfjZ2nbtrniRU05WwTaGOef5GT4Z+Px7fLN0t1n/EVM+wRSZJ/Yl/bFnu9wqFl68Ahf6it
 nDgA=
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE
X-Endpoint-Received: by B4 Relay for markchucarroll@fastmail.com/default
 with auth_id=1002
X-Original-From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Reply-To: markchucarroll@fastmail.com

Update tests to use semantic functions like "test_path_is_file"
instead of the older "test -f". All of the tests that make simple
usages are updated; tests that do more complicated things like
starting subshells are left unchanged.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
Mark C. Chu-Carroll (2):
      Update shell tests to use semantic functions
      Second batch of shell test migrations.

 t/perf/p5302-pack-index.sh              |  2 +-
 t/t0007-git-var.sh                      |  2 +-
 t/t0031-lockfile-pid.sh                 |  2 +-
 t/t0081-find-pack.sh                    |  2 +-
 t/t0200-gettext-basic.sh                |  2 +-
 t/t1007-hash-object.sh                  |  6 +++---
 t/t1700-split-index.sh                  |  2 +-
 t/t2005-checkout-index-symlinks.sh      |  2 +-
 t/t2030-unresolve-info.sh               |  8 ++++----
 t/t2201-add-update-typechange.sh        |  2 +-
 t/t3300-funny-names.sh                  |  2 +-
 t/t3306-notes-prune.sh                  |  2 +-
 t/t3311-notes-merge-fanout.sh           |  2 +-
 t/t3434-rebase-i18n.sh                  |  2 +-
 t/t3902-quoted.sh                       |  2 +-
 t/t4013-diff-various.sh                 |  2 +-
 t/t4014-format-patch.sh                 |  6 +++---
 t/t4016-diff-quote.sh                   |  2 +-
 t/t4032-diff-inter-hunk-context.sh      |  4 ++--
 t/t4102-apply-rename.sh                 |  2 +-
 t/t4131-apply-fake-ancestor.sh          |  2 +-
 t/t4132-apply-removal.sh                |  4 ++--
 t/t4252-am-options.sh                   |  2 +-
 t/t5000-tar-tree.sh                     |  2 +-
 t/t5100-mailinfo.sh                     |  6 +++---
 t/t5300-pack-object.sh                  | 10 +++++-----
 t/t5301-sliding-window.sh               |  4 ++--
 t/t5302-pack-index.sh                   |  8 ++++----
 t/t5334-incremental-multi-pack-index.sh |  2 +-
 t/t5402-post-merge-hook.sh              |  2 +-
 t/t5500-fetch-pack.sh                   |  2 +-
 t/t5502-quickfetch.sh                   |  2 +-
 t/t5510-fetch.sh                        |  8 ++++----
 t/t5515-fetch-merge-logic.sh            |  4 ++--
 t/t5516-fetch-push.sh                   |  2 +-
 t/t5526-fetch-submodules.sh             |  8 ++++----
 t/t5534-push-signed.sh                  |  6 +++---
 t/t5550-http-fetch-dumb.sh              |  2 +-
 t/t5601-clone.sh                        | 16 ++++++++--------
 t/t5604-clone-reference.sh              |  2 +-
 t/t5702-protocol-v2.sh                  |  4 ++--
 t/t5710-promisor-remote-capability.sh   |  2 +-
 t/t6030-bisect-porcelain.sh             |  2 +-
 t/t6500-gc.sh                           |  2 +-
 t/t7004-tag.sh                          |  4 ++--
 t/t7011-skip-worktree-reading.sh        |  2 +-
 t/t7012-skip-worktree-writing.sh        |  2 +-
 t/t7102-reset.sh                        |  2 +-
 t/t7104-reset-hard.sh                   |  2 +-
 t/t7113-post-index-change-hook.sh       | 12 ++++++------
 t/t7201-co.sh                           |  6 +++---
 t/t7400-submodule-basic.sh              | 10 +++++-----
 t/t7407-submodule-foreach.sh            |  6 +++---
 t/t7409-submodule-detached-work-tree.sh |  2 +-
 t/t7412-submodule-absorbgitdirs.sh      |  8 ++++----
 t/t7450-bad-git-dotfiles.sh             |  6 +++---
 t/t7602-merge-octopus-many.sh           |  2 +-
 t/t7606-merge-custom.sh                 |  8 ++++----
 t/t7610-mergetool.sh                    |  6 +++---
 t/t9400-git-cvsserver-server.sh         |  6 +++---
 t/t9804-git-p4-label.sh                 |  8 ++++----
 61 files changed, 126 insertions(+), 126 deletions(-)


---
base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e
change-id: 20260904-file-tests-use-shell-functions-e0d6c545d56c


