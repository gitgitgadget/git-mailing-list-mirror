Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD961401B
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721688885; cv=none; b=G+1XPuP6Xjr2vO5N9bhHrB1cTqpTM6QHAZjqtll9+eVu/fAUBm+z0Ud+t4aPyY4DMAw3PXm7i1aP6YLutqF/jzqOdyc/lPiEKOgXhZX5fVc/CxT9Oqwq60NFrK0uiTgXffxSrrvt+5XfvKX9kA2XNrshiQWYO6S7Cr7calO3G4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721688885; c=relaxed/simple;
	bh=FJkIMuWa+KTwuEhmvvrCrDu9wB+BHoSDGp/0EkxDC88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PdnSkw/MAT6I9IVYh001LP+i82iKuN976zl75HgkNN/VbB3HFedSMSU77vzZA1eqthkuEaaOY21++aPZIromWX34qYjH0L7LwP/SqhNOJrYIPBKbJ9cChgxPggRGkgHHvnNu63YDKVqykKt+mgVEwaHSAKjF6ezI7s4DuM8hBnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=UFZQHykz; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="UFZQHykz"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 49042240103
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 00:54:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1721688874; bh=FJkIMuWa+KTwuEhmvvrCrDu9wB+BHoSDGp/0EkxDC88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=UFZQHykzOBItEYpuGS78Pp10knmoA59zlavINvbdDb/aBt8706DfQe1aJmx8rGUdW
	 awHvKco6rnEL7qNdOxwC7AShyT2n5oyz6G9bGcCtqwcn6QsdfcSE9LsI2phpQ+tDZm
	 Eh+tkbWVz+vg1rNBGfJtB4DwJbgV+QyZI/vQZJlan37KOVOPn9W0R55f8qVQD3u5MA
	 oVOVQ56LGpeOPw/bKIt7BRtuvMW/7v5lGxpTt6SENv/ovR9EI9mfjMUpoBUsZMu4sH
	 Pg6cuuxWpmw1kCWHzNsZvArrAsOFGfG75XDJ8oOgHCLTnrOHecyBZJcDlfejIOAmVW
	 Iz/dhrTiX4Fsg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4WSbFP3F6yz6twK;
	Tue, 23 Jul 2024 00:54:33 +0200 (CEST)
From: Tomas Nordin <tomasn@posteo.net>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	charvi077@gmail.com,
	tomasn@posteo.net
Subject: [PATCH 1/1] doc: remove dangling closing parenthesis
Date: Mon, 22 Jul 2024 22:53:02 +0000
Message-Id: <20240722225302.124356-1-tomasn@posteo.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second line of the synopsis, starting with [--dry-run] has a
dangling closing paren in the second optional group. Probably added by
mistake, so remove it.

Signed-off-by: Tomas Nordin <tomasn@posteo.net>
---
 Documentation/git-commit.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 89ecfc63a8..c822113c11 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
-	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
+	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
-- 
2.39.2

