Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ACE482EC
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aGolkbC1"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 018CA27BB2;
	Fri, 15 Dec 2023 15:33:04 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=8uzN5/GO8OTRPgT7KPwlxPD/w
	UXVwZ8lS1vq9fTGu1A=; b=aGolkbC1knrmHD4bi3P/uGlTq8L69vwYFNeXB/INN
	8L143+ij/xT/QZ7lp1BLK7l0skijL9entr01V78txdSTlNTp4p3itlnETv/GKW/X
	Qs/qUrPxrCP/nfH8DFrZYpcVYKBB4bXvbpNu5Cu/t7A5d28NB56eoF8LF5qyHc8L
	3U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EEA4727BB1;
	Fri, 15 Dec 2023 15:33:03 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9E9BD27BAE;
	Fri, 15 Dec 2023 15:33:00 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 5/5] docs: MERGE_AUTOSTASH is not that special
Date: Fri, 15 Dec 2023 12:32:45 -0800
Message-ID: <20231215203245.3622299-6-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-76-g1a87c842ec
In-Reply-To: <20231215203245.3622299-1-gitster@pobox.com>
References: <20231215203245.3622299-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 23B0CB8C-9B89-11EE-878F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

A handful of manual pages called MERGE_AUTOSTASH a "special ref",
but there is nothing special about it.  It merely is yet another
pseudoref.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/merge-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-option=
s.txt
index d8f7cd7ca0..3eaefc4e94 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -191,7 +191,7 @@ endif::git-pull[]
 --autostash::
 --no-autostash::
 	Automatically create a temporary stash entry before the operation
-	begins, record it in the special ref `MERGE_AUTOSTASH`
+	begins, record it in the ref `MERGE_AUTOSTASH`
 	and apply it after the operation ends.  This means
 	that you can run the operation on a dirty worktree.  However, use
 	with care: the final stash application after a successful
--=20
2.43.0-76-g1a87c842ec

