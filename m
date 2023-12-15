Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E97447762
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NblPRsAS"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 242981BD36A;
	Fri, 15 Dec 2023 15:32:54 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=XsUxuSbFD8r7KwCnbR60MyBkR
	6F3NzoekMny3BPgAsA=; b=NblPRsASF4TiYWj7vTLBJzdQwloGlu0AlUdTesW5J
	abb8RUJTSm92CV6s8dikBpMs+1uMCP7dS1bOyZ8eooU8/uKpKYCsp6aShUXaRb+4
	s/KE91A8PgZLqGJnjmY2OriJfJHh6vkdRAu67tRaRGLyO+nqa/x/JE5PDjoEWIJn
	zA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C03F1BD369;
	Fri, 15 Dec 2023 15:32:54 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8237F1BD368;
	Fri, 15 Dec 2023 15:32:53 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/5] git-bisect.txt: BISECT_HEAD is not that special
Date: Fri, 15 Dec 2023 12:32:42 -0800
Message-ID: <20231215203245.3622299-3-gitster@pobox.com>
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
 1F728E66-9B89-11EE-A043-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

The description of "git bisect --no-checkout" called BISECT_HEAD a
"special ref", but there is nothing special about it.  It merely is
yet another pseudoref.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-bisect.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 191b4a42b6..aa02e46224 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -362,7 +362,7 @@ OPTIONS
 --no-checkout::
 +
 Do not checkout the new working tree at each iteration of the bisection
-process. Instead just update a special reference named `BISECT_HEAD` to =
make
+process. Instead just update the reference named `BISECT_HEAD` to make
 it point to the commit that should be tested.
 +
 This option may be useful when the test you would perform in each step
--=20
2.43.0-76-g1a87c842ec

